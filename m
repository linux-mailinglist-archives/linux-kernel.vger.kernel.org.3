Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553E754F5F8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382205AbiFQKt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381964AbiFQKtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:49:23 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2496BFD4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:49:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l4so3735348pgh.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=etXBBicoFjC7mauli6ZHZX7BG/ZNUXKeXrOBV6F93AY=;
        b=phOPovKH8vP2s1pV55Oz4O6ZizKxeZx4XrG7NbWmMDl9mdvr6v9wxQZhD7lVI0R65J
         f2UXcYlGmvoY3TpDJk3ZRarSzlAsBejReHOfOcduB8QmyyXlvA+cdT3Xon6kWzmWh3eh
         GN1LYq1wHvw2jIHI9hN//SttSFlIqFcUxDpUSnX4Y+Xs09QKhDChKmczX4+Gv/JCGiXi
         SWkxGYEIfP3UvGh/YCSPY58I1H6hwg2VnZPkkVVTdY6bYZ8eN087igliOZzPyxDEAEb5
         VT2FQ23kpboFQH9J6EjeL1FXu+3hwfygdVZyCETPFgRNTdjYVEVqxLthIvGXW3HJxwxN
         aB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=etXBBicoFjC7mauli6ZHZX7BG/ZNUXKeXrOBV6F93AY=;
        b=NteNC8/nfepq+GD0vDGHUrwwLMSKeC8Ep0DW/l8ZLVvj/hEUOW/P4/zGIJx7UVj52M
         L/Q2H77Vpn54ufBX6HJ9aZSNWVNYLb4xjyVcv30bEB0dumpbK3KWoTlPowOFkwPGJ9NP
         Nt8AYwesx+iTKjtoA18HKZNDEsPr4jd+aEhKOUS4VopL08pSRIuOqPzSKGokBb496UU6
         8zg+vsEMj4tBkduYiWhkGvXC1IvKIMde4l/DR6/2XCapoqsmUOC08JOOByR/Za35tFW+
         oxdKcdsdIoUbMigGIV3VQVD+wPcV4LelTruR09aRqf6M0m6I7TjRYNnT2kbFNBsukXj4
         3ZtA==
X-Gm-Message-State: AJIora+icMAWbA7yQOizD4lgq4YKNGBk+20SQAQdJvKooEwo1vkzyCf4
        3BTFnYmJQMA6gq6x4Uy2cCS35g==
X-Google-Smtp-Source: AGRyM1smMXabT6De0zMLc/jNsYGXK7Hx9fxLhsQtOCEW2kBnOIGxCqF62HXy4/Q2+euV/aN7816x6g==
X-Received: by 2002:a65:6254:0:b0:405:559:a90a with SMTP id q20-20020a656254000000b004050559a90amr8407085pgv.480.1655462961483;
        Fri, 17 Jun 2022 03:49:21 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id az9-20020a170902a58900b00167838b82e0sm3219194plb.205.2022.06.17.03.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 03:49:20 -0700 (PDT)
Date:   Fri, 17 Jun 2022 18:49:15 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, corbet@lwn.net,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <YqxcK/XzyNn+KfGt@FVFYT0MHHV2J.usts.net>
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
 <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
 <YqqqPjkh9r8ZrH0r@localhost.localdomain>
 <24d5ec20-9c9e-93aa-11f4-c4619f51f7d1@redhat.com>
 <YqwVTT+50vt5WpeG@localhost.localdomain>
 <186924ab-651f-71a1-93d2-3500a67dffee@redhat.com>
 <YqxPTUuqdDpoU9o3@localhost.localdomain>
 <a2f5cb7e-0aaa-cb3c-5437-3aba9ae015d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2f5cb7e-0aaa-cb3c-5437-3aba9ae015d1@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 12:14:02PM +0200, David Hildenbrand wrote:
> On 17.06.22 11:54, Oscar Salvador wrote:
> > On Fri, Jun 17, 2022 at 09:43:33AM +0200, David Hildenbrand wrote:
> >> VmemmapSelfHosted, then the function names get nicer.
> > 
> > Definitely.
> > 
> >>
> >>> +#endif
> >>> +
> >>>  /*
> >>>   * On an anonymous page mapped into a user virtual memory area,
> >>>   * page->mapping points to its anon_vma, not to a struct address_space;
> >>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> >>> index 1089ea8a9c98..e2de7ed27e9e 100644
> >>> --- a/mm/hugetlb_vmemmap.c
> >>> +++ b/mm/hugetlb_vmemmap.c
> >>> @@ -101,6 +101,14 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
> >>>  {
> >>>  	unsigned long vmemmap_addr = (unsigned long)head;
> >>>  	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
> >>> +	struct mem_section *ms = __pfn_to_section(page_to_pfn(head));
> >>> +	struct page *memmap;
> >>> +
> >>> +	memmap = sparse_decode_mem_map(ms->section_mem_map,
> >>> +				       pfn_to_section_nr(page_to_pfn(head)));
> >>
> >> Why can't we check the head page directly? Either I need more coffee or
> >> this can be simplified.
> > 
> > Uhm, maybe I'm the one who needs coffe here but we have something like:
> > 
> > [    hot-plugges section   ]
> > [memmap pages][normal pages]
> 
> Oh, right, we need the memmap for our hugetlb page (which resides in the
> reserved section), but these are not marked. We need the memmap of that
> memmap.
> 
> I assume one could directly via the page address. Because we want the
> memmap of the memmap.
> 
> vmmemmap_page = virt_to_page(head);
>

I think this can works, more simple.

Thanks.
 
> Not sure, though, if that would work with that function.
