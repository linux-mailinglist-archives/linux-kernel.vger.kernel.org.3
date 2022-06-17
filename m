Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374F454F693
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380865AbiFQLTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380988AbiFQLTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:19:21 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C686C576
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:19:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k7so3617073plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JYYqCC4EL5cjTYCu5ouFlRe38KV3xRfbg1LQZEZpvv0=;
        b=IKSnq/sdUWRx+9KlrAbt0m9f+gCf+QJPQV5gbmqqkJg6EegAl/quj6vGgFFHDuITyu
         3YxWy9utBlBzpaGPPbE8PhzqbXe7cxDrFz/8JcaNxZYyvtMEi/Qqnk9Pky01e2+a+t6c
         t7LgTJr53GF35dO6BneltdqnTGMSu/3mQn2Sh9GpttW/9E7Z7vELo4rTtb9O94O7u9b4
         k7m0vSZ/eKTHYRkK6jOqLdJ/j/DEF6paJB4Qg9Ap1sJzvmpIr4z+k8BzBANRO667ZQdh
         1w0jxmG8OfIU8V1nY0U+zyCXch/e2SoD7LoHF6R0+6LRTnSAeDh+GbtGD8Rl7IT7JE1x
         j5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JYYqCC4EL5cjTYCu5ouFlRe38KV3xRfbg1LQZEZpvv0=;
        b=tvkW317qyyJNrj+duBKjS/PuiJmOvQT6zGawSqC7RMxCD9mBMTibq08SrdpVIbJI2z
         QvzutmaHibf2hcLVz/ycxsZZHTwydyp59/5XZIGN2hFkfg/5GiLzTNOffWvCvzv+vQbd
         nLxUpkgDBQ6v77MmexCigi+wtIP1kJ1DatnroJtj+Sok+TvX1FrAbFv/8H4wNljYUHjA
         bPwXYpTP6cLEukILhhINZe5SzoLp8ANakNNmDrGxkmht+sBLVYm09vXVMJwI3zAjCxRE
         AmXuyazUJo8KlYnVUH85iWIkEXHf25xi+xRdLoNJT30zofSXlcAasERo+8/VSvUa7TAi
         T+lw==
X-Gm-Message-State: AJIora8ZhesFN+aUw6ahxHTPHpcwGFUbCCkG7D7V2IgWgIdT3I4XbeAK
        uEDLF2Pm6PtsIJ3xaSCU2AIcEg==
X-Google-Smtp-Source: AGRyM1vLvDTc0M380Aw9TDgt7gKezaAz1cXdrzRvlgufbZaphVo25He2KGAgImgiu6GQkLec7fcA1Q==
X-Received: by 2002:a17:90b:4c4a:b0:1e3:3b3:8800 with SMTP id np10-20020a17090b4c4a00b001e303b38800mr10356726pjb.6.1655464755408;
        Fri, 17 Jun 2022 04:19:15 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id az5-20020a170902a58500b0016636256970sm1032836plb.167.2022.06.17.04.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 04:19:14 -0700 (PDT)
Date:   Fri, 17 Jun 2022 19:19:10 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, corbet@lwn.net,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <YqxjLud4h+z1Lfrk@FVFYT0MHHV2J.usts.net>
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
 <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
 <YqqqPjkh9r8ZrH0r@localhost.localdomain>
 <24d5ec20-9c9e-93aa-11f4-c4619f51f7d1@redhat.com>
 <YqwVTT+50vt5WpeG@localhost.localdomain>
 <186924ab-651f-71a1-93d2-3500a67dffee@redhat.com>
 <YqxPTUuqdDpoU9o3@localhost.localdomain>
 <a2f5cb7e-0aaa-cb3c-5437-3aba9ae015d1@redhat.com>
 <YqxcK/XzyNn+KfGt@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqxcK/XzyNn+KfGt@FVFYT0MHHV2J.usts.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 06:49:15PM +0800, Muchun Song wrote:
> On Fri, Jun 17, 2022 at 12:14:02PM +0200, David Hildenbrand wrote:
> > On 17.06.22 11:54, Oscar Salvador wrote:
> > > On Fri, Jun 17, 2022 at 09:43:33AM +0200, David Hildenbrand wrote:
> > >> VmemmapSelfHosted, then the function names get nicer.
> > > 
> > > Definitely.
> > > 
> > >>
> > >>> +#endif
> > >>> +
> > >>>  /*
> > >>>   * On an anonymous page mapped into a user virtual memory area,
> > >>>   * page->mapping points to its anon_vma, not to a struct address_space;
> > >>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > >>> index 1089ea8a9c98..e2de7ed27e9e 100644
> > >>> --- a/mm/hugetlb_vmemmap.c
> > >>> +++ b/mm/hugetlb_vmemmap.c
> > >>> @@ -101,6 +101,14 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
> > >>>  {
> > >>>  	unsigned long vmemmap_addr = (unsigned long)head;
> > >>>  	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
> > >>> +	struct mem_section *ms = __pfn_to_section(page_to_pfn(head));
> > >>> +	struct page *memmap;
> > >>> +
> > >>> +	memmap = sparse_decode_mem_map(ms->section_mem_map,
> > >>> +				       pfn_to_section_nr(page_to_pfn(head)));
> > >>
> > >> Why can't we check the head page directly? Either I need more coffee or
> > >> this can be simplified.
> > > 
> > > Uhm, maybe I'm the one who needs coffe here but we have something like:
> > > 
> > > [    hot-plugges section   ]
> > > [memmap pages][normal pages]
> > 
> > Oh, right, we need the memmap for our hugetlb page (which resides in the
> > reserved section), but these are not marked. We need the memmap of that
> > memmap.
> > 
> > I assume one could directly via the page address. Because we want the
> > memmap of the memmap.
> > 
> > vmmemmap_page = virt_to_page(head);
> >
>
> I think this can works, more simple.
> 

Oh, I forgot virt_to_page() cannot applicable for vmemmap addresses.
I think Oscar's approach is right.

> Thanks.
>  
> > Not sure, though, if that would work with that function.
> 
