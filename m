Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2719B522DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiEKHu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiEKHux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:50:53 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789B6BE0B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:50:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id i24so1288365pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TOpiEgIVOcB5WT+3SW82dW6oiJYrSmauk2q3s83vFLY=;
        b=GjYiH/cdcBunvwcLneFnTnTdDBF/SnRaJ9OcOMcfesIKYqQx/BCTReS/SXwkP5ZAuK
         KtBBQl+aHtTVNQHlgfhLMAaDwx9uiilDXJIuJEW1n8qxDy0UXOBW3BkjdzBqxRoS3Ymb
         XfWIZAaRT/pp0dt/FLpu+J+g2cU0bFBma1IYlsIpE1zbMhtbToxM3Gx7Vl1lRkAd1s3T
         8ZvSgHSd96OOqNpjQGrdxpJ4kPwp5P7PqxjUiM46yTHg3PSGx8ma2CM4infM86N7zc21
         LUgF+mTB3/NAoDVwNDqV/Au4D3ijEzrwW+g8sDwesW2BWYFli08oKOgN7I0jjoCOFiOa
         D3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TOpiEgIVOcB5WT+3SW82dW6oiJYrSmauk2q3s83vFLY=;
        b=0rh4vnJDZX33SFsxCUCqHB4HrPIA56UyRj4ZAfOJbeS6bqWcIXr8IbY2QbvD+R+HfT
         fdPo4efN5gKnUC+mMIdho5TKcfS0v3JncgAXKYNYP+QYKnrh3Mv+MKU2YYPLAIJicyj4
         om2kPWCOYx0qwIMxtXFBXX/IEYJjWVWIdTqfZCIQ4y5+YYROCfz039vE7kP6zL1Vl7cY
         +ZTV1hXhqF42PjEprYc/Rjj5yWm0qdwtpTLiEizSjYfDs/2bjpGSeQ5jwFA/PQp94kPS
         jS++4+vH4Kl0gpQfA5cbekztOfC9oXkZorgn5rk6F8RvzutPfhxN2/Z4aisJBXp7Yw7V
         Er8A==
X-Gm-Message-State: AOAM530ucZYGbIDYqusbZb5PrxGclcdl0d0UTY5ZW+Gz7DBQVYmm4XxG
        BPxiKdn5rxvI5atth2nVXEU=
X-Google-Smtp-Source: ABdhPJyWfCGGLnrrOVCcFuplYmh4xhOYlD6nL1apLGnsFdOkhHBpxvGTnM+WgF1ZB4sgnv6HEW8Jbw==
X-Received: by 2002:a65:6a01:0:b0:3aa:b8:afc3 with SMTP id m1-20020a656a01000000b003aa00b8afc3mr19850719pgu.348.1652255451792;
        Wed, 11 May 2022 00:50:51 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902d65300b0015e8d4eb273sm1019850plh.189.2022.05.11.00.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 00:50:50 -0700 (PDT)
Date:   Wed, 11 May 2022 16:50:44 +0900
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
Message-ID: <Yntq1IhbwjyAHTON@hyeyoo>
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
> 
> I'm not saying there should be no additional mechanism for collapsing
> direct map pages, but I don't know when and how it should be invoked.
>

I'm still thinking about a way to accurately track number of split
pages - because tracking number of split pages only in CPA code may be
inaccurate when kernel page table is changed outside CPA.

In case you wonder, my code is available at:
https://github.com/hygoni/linux/tree/merge-mapping-v1r3

it also adds vmstat items:
	# cat /proc/vmstat | grep direct_map
	direct_map_level2_splits 1079
	direct_map_level3_splits 6
	direct_map_level1_merges 1079
	direct_map_level2_merges 6

Thanks,
Hyeonggon

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
