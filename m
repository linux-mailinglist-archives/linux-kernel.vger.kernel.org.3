Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD1A5AA419
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiIBAIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiIBAIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:08:32 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687F1120
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:08:31 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-11edd61a9edso1196640fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cd8UXaLR0IicU4AOk7UKJgay4GHu8DwVdf9UBh0pUjw=;
        b=VLY2dHKFKuStaRf/vcdP3v7LBWyLM8VbbuIYYXLg53mzURdKtBlgcFRhC9Gn4tzPTD
         nxovJiu6z8JZ5IcWYUF4e5OinMpZnxVmDLtQKtL+WDBrMjJPtNzbRAVZZqBm0krZJy2d
         3COZLiG+ApTGino+6KM8VXfMN0OH0y8HH4pYP/4iHUyPLgBQJnQpnSxsRB+lzYR5aWHP
         CkJH16U+amfBINLvq1mDGyroLmX55kfJoOBsFOVnIuGGqwyf8EHQQQOcvkmt55ZE30zM
         M9lerPvWV+cO7Pu4ihplIWrQ+44v+OGe79rlQh1aPgj7gb8lebgxbjRNxEkN+nsUNQEt
         W6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cd8UXaLR0IicU4AOk7UKJgay4GHu8DwVdf9UBh0pUjw=;
        b=4/bsdtduXOCMRLMFbUZWJR1Ex0wLJFRArDL1N2N/yu5kr83skVCmRD/CeRTpX7iXYB
         Bnom6ga4Rqvy18T+vj3ztlQ6KfQlpkZoDtSgJ8r9fQXiIg3qikRSeA7vMePmJRNpwJGP
         MqqY3GHv+TbB3VCgACH9R1iCFbvdW56AZQBLk+KsSJuRFrcLmN9snsq1DIfCVWU4XKLf
         ii3IimEXaLKz1V2uDXJuZg1uw8T7jWQVOPSmhtSZ6cq2Yw4al/ACLCAGlOfeCLas3i6i
         bOIcnrnuOxNlVWsmzvbphVW25U8kIQeSTiopJqj/1+7nyhaSwvLWi/9wFXvUqf1unyMc
         RL+A==
X-Gm-Message-State: ACgBeo3+ZOY2YEQmItN4dKD9SAktDzUr/bLt+Mxo8s8sbZcZlt8HvKup
        KnYYO9fQ52N0iOzVBtS3xAK6799lyvE=
X-Google-Smtp-Source: AA6agR73nHNG1fLa3SjmOoM1nkt+XEbOuHf17niOI92pG+PiGn3TIPZFWorZGTTuVm5JcUa5REj5zg==
X-Received: by 2002:a05:6870:8984:b0:10d:d981:151f with SMTP id f4-20020a056870898400b0010dd981151fmr895003oaq.212.1662077310915;
        Thu, 01 Sep 2022 17:08:30 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id r22-20020a4abf16000000b0044ae10c5974sm170816oop.34.2022.09.01.17.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:08:30 -0700 (PDT)
Date:   Thu, 1 Sep 2022 19:08:28 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
Message-ID: <20220902000828.GB17689@sophie>
References: <cover.1660897864.git.remckee0@gmail.com>
 <0cfb3c69ba6ca9ff55e1fc2528d18d108416ba57.1660897864.git.remckee0@gmail.com>
 <329ab669-620c-ba9e-3c57-9cb90d55b942@redhat.com>
 <20220831034909.GA16092@sophie>
 <7c83950c-6a83-e35b-0060-79b5df3bda56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c83950c-6a83-e35b-0060-79b5df3bda56@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:06:48AM +0200, David Hildenbrand wrote:
> On 31.08.22 05:49, Rebecca Mckeever wrote:
> > On Tue, Aug 30, 2022 at 01:17:56PM +0200, David Hildenbrand wrote:
> >> On 19.08.22 11:05, Rebecca Mckeever wrote:
> >>> Add functions setup_numa_memblock_generic() and setup_numa_memblock()
> >>> for setting up a memory layout with multiple NUMA nodes in a previously
> >>> allocated dummy physical memory. These functions can be used in place of
> >>> setup_memblock() in tests that need to simulate a NUMA system.
> >>>
> >>> setup_numa_memblock_generic():
> >>> - allows for setting up a custom memory layout by specifying the amount
> >>>   of memory in each node, the number of nodes, and a factor that will be
> >>>   used to scale the memory in each node
> >>>
> >>> setup_numa_memblock():
> >>> - allows for setting up a default memory layout
> >>>
> >>> Introduce constant MEM_FACTOR, which is used to scale the default memory
> >>> layout based on MEM_SIZE.
> >>>
> >>> Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
> >>> 16 NUMA nodes.
> >>>
> >>> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> >>> ---
> >>>  .../testing/memblock/scripts/Makefile.include |  2 +-
> >>>  tools/testing/memblock/tests/common.c         | 38 +++++++++++++++++++
> >>>  tools/testing/memblock/tests/common.h         |  9 ++++-
> >>>  3 files changed, 47 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
> >>> index aa6d82d56a23..998281723590 100644
> >>> --- a/tools/testing/memblock/scripts/Makefile.include
> >>> +++ b/tools/testing/memblock/scripts/Makefile.include
> >>> @@ -3,7 +3,7 @@
> >>>  
> >>>  # Simulate CONFIG_NUMA=y
> >>>  ifeq ($(NUMA), 1)
> >>> -	CFLAGS += -D CONFIG_NUMA
> >>> +	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
> >>>  endif
> >>>  
> >>>  # Use 32 bit physical addresses.
> >>> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> >>> index eec6901081af..15d8767dc70c 100644
> >>> --- a/tools/testing/memblock/tests/common.c
> >>> +++ b/tools/testing/memblock/tests/common.c
> >>> @@ -34,6 +34,10 @@ static const char * const help_opts[] = {
> >>>  
> >>>  static int verbose;
> >>>  
> >>> +static const phys_addr_t node_sizes[] = {
> >>> +	SZ_4K, SZ_1K, SZ_2K, SZ_2K, SZ_1K, SZ_1K, SZ_4K, SZ_1K
> >>> +};
> >>> +
> >>>  /* sets global variable returned by movable_node_is_enabled() stub */
> >>>  bool movable_node_enabled;
> >>>  
> >>> @@ -72,6 +76,40 @@ void setup_memblock(void)
> >>>  	fill_memblock();
> >>>  }
> >>>  
> >>> +/**
> >>> + * setup_numa_memblock_generic:
> >>> + * Set up a memory layout with multiple NUMA nodes in a previously allocated
> >>> + * dummy physical memory.
> >>> + * @nodes: an array containing the amount of memory in each node
> >>> + * @node_cnt: the size of @nodes
> >>> + * @factor: a factor that will be used to scale the memory in each node
> >>> + *
> >>> + * The nids will be set to 0 through node_cnt - 1.
> >>> + */
> >>> +void setup_numa_memblock_generic(const phys_addr_t nodes[],
> >>> +				 int node_cnt, int factor)
> >>> +{
> >>> +	phys_addr_t base;
> >>> +	int flags;
> >>> +
> >>> +	reset_memblock_regions();
> >>> +	base = (phys_addr_t)memory_block.base;
> >>> +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
> >>> +
> >>> +	for (int i = 0; i < node_cnt; i++) {
> >>> +		phys_addr_t size = factor * nodes[i];
> >>
> >> I'm a bit lost why we need the factor if we already provide sizes in the
> >> array.
> >>
> >> Can you enlighten me? :)
> >>
> >> Why can't we just stick to the sizes in the array?
> >>
> > Without the factor, some of the tests will break if we increase MEM_SIZE
> > in the future (which we may need to do). I could rewrite them so that the
> > factor is not needed, but I thought the code would be over-complicated if
> > I did.
> 
> Independent of the suggestion from Mike, I wonder if we should really
> care about (eventual) MEM_SIZE changes for now if not caring simplifies
> the current code.
> 
Maybe not. I'm going to try Mike's suggestion, but I will keep this in
mind if the code seems too complicated.

> -- 
> Thanks,
> 
> David / dhildenb
> 
Thanks,
Rebecca
