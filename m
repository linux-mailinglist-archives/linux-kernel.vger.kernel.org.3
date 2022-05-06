Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C010C51DE01
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444019AbiEFRCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444018AbiEFRCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:02:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905196D953
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:59:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so7236439pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vj6XEbgIMbTr9+iA2bOkom4+D75tX0mB3fjbufS1Z10=;
        b=feRUWTCl2QMVdpXsrIM+3vZBL5P3h3/8Ynt3HSw+RVb8Y02b8BCzt/xxjdLZ+lm/rM
         MxAAwqTYNpSvPK6/3W9yBxyXkh9zW7dx2jk5najDR6j6DiCDrrz3BhFNkJVh9BpSQKE/
         oh2OH0tjjQa/cOdARonIOidtJlBfLWgUxxHfj+Ghcs0+CZU90bK83a+SULYdKdNLlFy6
         sZxdBhhkTG51p29v7+33fKAxQuKtL+YNZaB2y4zXM/0TZLrKce2isiaiFEyoqEnUzqbi
         daqyCXGSbWvY1LaZrbeKcEsTeYOkCuSsdUWWFcWc+JZ/O+dKbchnly84zJhQHHIbSyRc
         or7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vj6XEbgIMbTr9+iA2bOkom4+D75tX0mB3fjbufS1Z10=;
        b=fdVD5Ly0VgLqCm9wjztV5Zfi6Ck1jzZZaGJ3mZOJwj/vwggtyQvLCHVIHYu8GyBtNi
         q8bIPUa3NJFQOZ9uT6iKXlMKaQ6j7SBOyfr/WtdeKc/vDBAFjkn12ZRIBmFDjy0HySZj
         BpIK4R+7EfbRD6EPO6Ir6OfrQ83mf3t/y+ezbVuhn15vXKj0vZG7wtTgt/Tr6iwwNR7o
         B4bqmdqYc9X2PLXmWwgp4zzhSvaJ5mbh3KhnVzyp/WjujzxfqGSXgNHwfBBKW5ADPYlf
         bl7DWUZXgRApkFL2DTqZ58uB1excN8f6+sAXyackACiwIf7WcTr2j//zLZ+PGkRq3JhJ
         Be/A==
X-Gm-Message-State: AOAM530zNKHEaFh18z3xIhfPCXDJJZdrRGW/fJ84LfUJm6oDJjAH4QG+
        uaVjwaHmDrlqX3WKQLhFAqiFxqt3LTs=
X-Google-Smtp-Source: ABdhPJzHU6TTWVDjf/3gc99fKZkHMN+emRqleV7wQE2C9rolA5SwVurRJTfon78jncXjIJpVJqvGHg==
X-Received: by 2002:a17:90b:3884:b0:1dc:5838:1bea with SMTP id mu4-20020a17090b388400b001dc58381beamr13187175pjb.90.1651856343692;
        Fri, 06 May 2022 09:59:03 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b0015e8d4eb2easm2008874plx.308.2022.05.06.09.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 09:59:02 -0700 (PDT)
Date:   Sat, 7 May 2022 01:58:55 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 0/3] Prototype for direct map awareness in page
 allocator
Message-ID: <YnVTz4szkpwkKlFP@hyeyoo>
References: <20220127085608.306306-1-rppt@kernel.org>
 <YmezWeMZSRNRfXyG@hyeyoo>
 <YmgOFa3FUUpiANMq@kernel.org>
 <20220430134415.GA25819@ip-172-31-27-201.ap-northeast-1.compute.internal>
 <YnCzQJk8Mu1848tG@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnCzQJk8Mu1848tG@kernel.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 09:44:48PM -0700, Mike Rapoport wrote:
> On Sat, Apr 30, 2022 at 01:44:16PM +0000, Hyeonggon Yoo wrote:
> > On Tue, Apr 26, 2022 at 06:21:57PM +0300, Mike Rapoport wrote:
> > > Hello Hyeonggon,
> > > 
> > > On Tue, Apr 26, 2022 at 05:54:49PM +0900, Hyeonggon Yoo wrote:
> > > > On Thu, Jan 27, 2022 at 10:56:05AM +0200, Mike Rapoport wrote:
> > > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > This is a second attempt to make page allocator aware of the direct map
> > > > > layout and allow grouping of the pages that must be mapped at PTE level in
> > > > > the direct map.
> > > > >
> > > > 
> > > > Hello mike, It may be a silly question...
> > > > 
> > > > Looking at implementation of set_memory*(), they only split
> > > > PMD/PUD-sized entries. But why not _merge_ them when all entries
> > > > have same permissions after changing permission of an entry?
> > > > 
> > > > I think grouping __GFP_UNMAPPED allocations would help reducing
> > > > direct map fragmentation, but IMHO merging split entries seems better
> > > > to be done in those helpers than in page allocator.
> > >
> > > Maybe, I didn't got as far as to try merging split entries in the direct
> > > map.  IIRC, Kirill sent a patch for collapsing huge pages in the direct map
> > > some time ago, but there still was something that had to initiate the
> > > collapse.
> > 
> > But in this case buddy allocator's view of direct map is quite limited.
> > It cannot merge 2M entries to 1G entry as it does not support
> > big allocations. Also it cannot merge entries of pages freed in boot process
> > as they weren't allocated from page allocator.
> > 
> > And it will become harder when pages in MIGRATE_UNMAPPED is borrowed
> > from another migrate type....
> > 
> > So it would be nice if we can efficiently merge mappings in
> > change_page_attr_set(). this approach can handle cases above.
> > 
> > I think in this case grouping allocations and merging mappings
> > should be done separately.
> 
> I've added the provision to merge the mappings in __free_one_page() because
> at that spot we know for sure we can replace multiple PTEs with a single
> PMD.

Actually no external merging mechanism is needed if CPA supports merging
mappings.

Recently I started to implement similar idea I described above.
The approach is slightly different as it does not scan the page table
but updates count of number of mappings that has non-standard protection bits.
(being "non-standard" means pgprot is not equal to PAGE_KERNEL.)

It increases split_count when standard mapping becomes non-standard
and decreases split_count in the opposite case. It merges mappings when
the count become zero.

Updating counts and merging is invoked in __change_page_attr(), which
is called by set_memory_{rw,ro}(),
set_direct_map_{default,invalid}_noflush(), ... etc.

The implementation looks like revert_page() function that existed in
arch/i386/mm/pageattr.c decades ago...

There are some issues like 1) set_memory_4k()-ed memory should not be
merged and 2) we need to be extremely sure that the count is always
valid.

But I think this approach is definitely worth trying.
I'll send a RFC versionin to list after a bit of more work.

And still, I think grouping allocations using migrate type would
work well with adding merging feature in CPA.

Thanks!
Hyeonggon

> I'm not saying there should be no additional mechanism for collapsing
> direct map pages, but I don't know when and how it should be invoked.
>  
> > > > For example:
> > > > 	1) set_memory_ro() splits 1 RW PMD entry into 511 RW PTE
> > > > 	entries and 1 RO PTE entry.
> > > > 
> > > > 	2) before freeing the pages, we call set_memory_rw() and we have
> > > > 	512 RW PTE entries. Then we can merge it to 1 RW PMD entry.
> > > 
> > > For this we need to check permissions of all 512 pages to make sure we can
> > > use a PMD entry to map them.
> > 
> > Of course that may be slow. Maybe one way to optimize this is using some bits
> > in struct page, something like: each bit of page->direct_map_split (unsigned long)
> > is set when at least one entry in (PTRS_PER_PTE = 512)/(BITS_PER_LONG = 64) = 8 entries
> > has special permissions.
> > 
> > Then we just need to set the corresponding bit when splitting mappings and
> > iterate 8 entries when changing permission back again. (and then unset the bit when 8 entries has
> > usual permissions). we can decide to merge by checking if page->direct_map_split is zero.
> > 
> > When scanning, 8 entries would fit into one cacheline.
> > 
> > Any other ideas?
> > 
> > > Not sure that doing the scan in each set_memory call won't cause an overall
> > > slowdown.
> > 
> > I think we can evaluate it by measuring boot time and bpf/module
> > load/unload time.
> > 
> > Is there any other workload that is directly affected
> > by performance of set_memory*()?
> > 
> > > > 	3) after 2) we can do same thing about PMD-sized entries
> > > > 	and merge them into 1 PUD entry if 512 PMD entries have
> > > > 	same permissions.
> > > > [...]
> > > > > Mike Rapoport (3):
> > > > >   mm/page_alloc: introduce __GFP_UNMAPPED and MIGRATE_UNMAPPED
> > > > >   mm/secretmem: use __GFP_UNMAPPED to allocate pages
> > > > >   EXPERIMENTAL: x86/module: use __GFP_UNMAPPED in module_alloc
> > > > -- 
> > > > Thanks,
> > > > Hyeonggon
> > > 
> > > -- 
> > > Sincerely yours,
> > > Mike.
> 
> -- 
> Sincerely yours,
> Mike.

-- 
Thanks,
Hyeonggon
