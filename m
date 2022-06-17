Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987B654F3F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380314AbiFQJKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiFQJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:10:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B203E554AE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:10:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f16so2486777pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ErDfRcZhT9Lf0Mnh9cO6ygQL2ijrScLa0RIJt67Z2D4=;
        b=lQomTkBg+EqCThhBADFZyIqepjXyr4CWMefwfip0o7eYW7ggEW4QKQoiPoQ1pomoHD
         qrg3TOa8dtJdSptD05Ejla1fDaXO4bGZd/2nXiGc6Y0XNP/1Axq/kId0isLVfHXVxum5
         6WPA54qNiK7rwDl+7CMZ+Jhoe0Iqq7MnpkO7oYqaROfq0BoC3vUSQxg/HqQFh0yYTeJj
         4CcVRKUD62I8eCyKZv/kJkV/AzusXwjzi++8rIAjNlPz1rK0076THJuW/n8ZrMpSrJQl
         5RPwKnL5WZ2PzuYxUnA78xT7pua+EU4AK7Bv/jlD6+hyqA0+TFZIBZBTdYGo6ExOKtXf
         NuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ErDfRcZhT9Lf0Mnh9cO6ygQL2ijrScLa0RIJt67Z2D4=;
        b=Fr5VC2/c5hMhRsIKS2AZo3Srl9Tr8oAkugOhPOBikcSOVgrHe1gyRTmeO4BpjIbMF1
         y8w5zRqbtqpq/Wji3kUhQzWaHxuLKSZjvGvfdVE/AY485PXM1S13faUJV4KCf7PUI/Uw
         fLZzuLOsS+nWQyEozTRAvSjurLtopIERHvCi3KUQnGytFFFiogOLuojFda9vi0Asmw82
         6jFhW+zd6Rck0naSDzWHtsq4IC6rd14FLkFreCvUK859UIjIyHlGrwlRLEypxnoGzBvL
         83p1AM2PkoHL0j4vJV6wKzN9MB4Px7Q25yKKamZTR3cOzAri5DG1x4nNY2NdkwUsunu0
         4UFA==
X-Gm-Message-State: AJIora8VROC2PyEu/cvJokeqJPuHSlGh9kVhn3C2OPHYu7xkV7NCwqUO
        w0KnwtqY8aKpaoMgSHB8PhfxxA==
X-Google-Smtp-Source: AGRyM1uXg0lH0GSFNVuOXTioY9vD8bTkRpVilNoA8/nb84rwN6eUxZIKTBYtgSfrbgWJxjoVRK/3xQ==
X-Received: by 2002:a17:90a:c981:b0:1e6:75f0:d4ea with SMTP id w1-20020a17090ac98100b001e675f0d4eamr20607932pjt.37.1655457026198;
        Fri, 17 Jun 2022 02:10:26 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090a384f00b001e31f4cc977sm2815291pjf.56.2022.06.17.02.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 02:10:25 -0700 (PDT)
Date:   Fri, 17 Jun 2022 17:10:23 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, corbet@lwn.net,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <YqxE/yJ1srzpegPb@FVFYT0MHHV2J.usts.net>
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
 <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
 <YqqqPjkh9r8ZrH0r@localhost.localdomain>
 <24d5ec20-9c9e-93aa-11f4-c4619f51f7d1@redhat.com>
 <YqwVTT+50vt5WpeG@localhost.localdomain>
 <YqwtCu2Ura+skV3B@FVFYT0MHHV2J.usts.net>
 <79a1ca29-de8e-6456-460b-a9099340fec4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79a1ca29-de8e-6456-460b-a9099340fec4@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 09:39:27AM +0200, David Hildenbrand wrote:
> On 17.06.22 09:28, Muchun Song wrote:
> > On Fri, Jun 17, 2022 at 07:46:53AM +0200, Oscar Salvador wrote:
> >> On Thu, Jun 16, 2022 at 09:30:33AM +0200, David Hildenbrand wrote:
> >>> IIRC, that was used to skip these patches on the offlining path before
> >>> we provided the ranges to offline_pages().
> >>
> >> Yeah, it was designed for that purpose back then.
> >>
> >>> I'd not mess with PG_reserved, and give them a clearer name, to not
> >>> confuse them with other, ordinary, vmemmap pages that are not
> >>> self-hosted (maybe in the future we might want to flag all vmemmap pages
> >>> with a new type?).
> >>
> >> Not sure whether a new type is really needed, or to put it another way, I
> >> cannot see the benefit.
> >>
> >>>
> >>> I'd just try reusing the flag PG_owner_priv_1. And eventually, flag all
> >>> (v)memmap pages with a type PG_memmap. However, the latter would be
> >>> optional and might not be strictly required
> >>>
> >>>
> >>> So what think could make sense is
> >>>
> >>> /* vmemmap pages that are self-hosted and cannot be optimized/freed. */
> >>> PG_vmemmap_self_hosted = PG_owner_priv_1,
> >>
> >> Sure, I just lightly tested the below, and seems to work, but not sure
> >> whether that is what you are referring to.
> >> @Munchun: thoughts?
> >>
> > 
> > I think it works and fits my requirement.
> > 
> >> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> >> index e66f7aa3191d..a4556afd7bda 100644
> >> --- a/include/linux/page-flags.h
> >> +++ b/include/linux/page-flags.h
> >> @@ -193,6 +193,11 @@ enum pageflags {
> >>  
> >>  	/* Only valid for buddy pages. Used to track pages that are reported */
> >>  	PG_reported = PG_uptodate,
> >> +
> >> +#ifdef CONFIG_MEMORY_HOTPLUG
> >> +	/* For self-hosted memmap pages */
> >> +	PG_vmemmap_self_hosted = PG_owner_priv_1,
> >> +#endif
> >>  };
> >>  
> >>  #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
> >> @@ -628,6 +633,10 @@ PAGEFLAG_FALSE(SkipKASanPoison, skip_kasan_poison)
> >>   */
> >>  __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
> >>  
> >> +#ifdef CONFIG_MEMORY_HOTPLUG
> >> +PAGEFLAG(Vmemmap_self_hosted, vmemmap_self_hosted, PF_ANY)
> >> +#endif
> >> +
> >>  /*
> >>   * On an anonymous page mapped into a user virtual memory area,
> >>   * page->mapping points to its anon_vma, not to a struct address_space;
> >> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> >> index 1089ea8a9c98..e2de7ed27e9e 100644
> >> --- a/mm/hugetlb_vmemmap.c
> >> +++ b/mm/hugetlb_vmemmap.c
> >> @@ -101,6 +101,14 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
> >>  {
> >>  	unsigned long vmemmap_addr = (unsigned long)head;
> >>  	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
> >> +	struct mem_section *ms = __pfn_to_section(page_to_pfn(head));
> >> +	struct page *memmap;
> >> +
> >> +	memmap = sparse_decode_mem_map(ms->section_mem_map,
> >> +				       pfn_to_section_nr(page_to_pfn(head)));
> >> +
> >> +	if (PageVmemmap_self_hosted(memmap))
> >> +		return;
> > 
> > I think here needs a loop if it is a 1GB page (spans multiple sections).
> > Right?  Here is an implementation based on another approach. But I think
> > your implementation is more simpler and efficient.  Would you mind me
> > squash your diff into my patch and with your "Co-developed-by"?
> 
> Due to hugtlb alignment requirements, and the vmemmap pages being at the
> start of the hotplugged memory region, I think that cannot currently
> happen. Checking the first vmemmap page might be good enough for now,
> and probably for the future.
>

If the memory block size is 128MB, then a 1GB huge page spans 8 blocks.
Is it possible that some blocks of them are vmemmap-hosted?

Thanks. 
