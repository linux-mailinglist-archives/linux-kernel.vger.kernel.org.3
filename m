Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15FB522C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbiEKGDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238703AbiEKGDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B691A3337E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 536AB6173B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9E4C385A7;
        Wed, 11 May 2022 06:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652248990;
        bh=yc7vI9T4PqmCjEjPxZdewSq59ZzcuUXZdKb7+F9lFwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZtQaV8pYpvmoRaaSVPezLtcBQGQ/DuPZriA/HqQA9nFocV3fJ9usZ4XDQkRml5/b
         VNfol2B04Q1NcBIOC+ZSm2i1+TZS+aVZzHxcZ3tVzGWWlyDrIB5LWRaD9Y2TKFL50P
         q3fvyOv86do4b81MNDZhVCdaQ0H/Me+CvugCKEu3W3lg65Kwb61yR/ZoCZhHa/VhPE
         +UMq7RAgWr2d+DEFMIUqaENN69QsVlQZrCiJT9MrrRpRdPCZ12A6QZjssmel3Uzt4S
         AdZuLmJoOVCpQ1oTJ4cv8bFHJALbC26pnM5sHxFo4y62xqLu2zY7rp2f5Pm4l1P+Dt
         +78LziYV3isrg==
Date:   Wed, 11 May 2022 09:03:02 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xuqiang36@huawei.com
Subject: Re: [PATCH] memblock: config the number of init memblock regions
Message-ID: <YntRlrwJeP40q6Hg@kernel.org>
References: <20220511010530.60962-1-zhouguanghui1@huawei.com>
 <20220510185523.3f7479b8ffc49a8a7c17d328@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510185523.3f7479b8ffc49a8a7c17d328@linux-foundation.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 06:55:23PM -0700, Andrew Morton wrote:
> On Wed, 11 May 2022 01:05:30 +0000 Zhou Guanghui <zhouguanghui1@huawei.com> wrote:
> 
> > During early boot, the number of memblocks may exceed 128(some memory
> > areas are not reported to the kernel due to test failures. As a result,
> > contiguous memory is divided into multiple parts for reporting). If
> > the size of the init memblock regions is exceeded before the array size
> > can be resized, the excess memory will be lost.

I'd like to see more details about how firmware creates that sparse memory
map in the changelog.

> > 
> > ...
> >
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -89,6 +89,14 @@ config SPARSEMEM_VMEMMAP
> >  	  pfn_to_page and page_to_pfn operations.  This is the most
> >  	  efficient option when sufficient kernel resources are available.
> >  
> > +config MEMBLOCK_INIT_REGIONS
> > +	int "Number of init memblock regions"
> > +	range 128 1024
> > +	default 128
> > +	help
> > +	  The number of init memblock regions which used to track "memory" and
> > +	  "reserved" memblocks during early boot.
> > +
> >  config HAVE_MEMBLOCK_PHYS_MAP
> >  	bool
> >  
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index e4f03a6e8e56..6893d26b750e 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -22,7 +22,7 @@
> >  
> >  #include "internal.h"
> >  
> > -#define INIT_MEMBLOCK_REGIONS			128
> > +#define INIT_MEMBLOCK_REGIONS			CONFIG_MEMBLOCK_INIT_REGIONS
> 
> Consistent naming would be nice - MEMBLOCK_INIT versus INIT_MEMBLOCK.
> 
> Can we simply increase INIT_MEMBLOCK_REGIONS to 1024 and avoid the
> config option?  It appears that the overhead from this would be 60kB or
> so.

60k is not big, but using 1024 entries array for 2-4 memory banks on
systems that don't report that fragmented memory map is really a waste.

We can make this per platform opt-in, like INIT_MEMBLOCK_RESERVED_REGIONS ...

> Or zero if CONFIG_ARCH_KEEP_MEMBLOCK and CONFIG_MEMORY_HOTPLUG
> are cooperating.

... or add code that will discard unused parts of memblock arrays even if
CONFIG_ARCH_KEEP_MEMBLOCK=y.

-- 
Sincerely yours,
Mike.
