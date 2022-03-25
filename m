Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34114E6F24
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354751AbiCYHsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242995AbiCYHsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E7CA0DE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:46:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD1D961B6C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 07:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA036C340E9;
        Fri, 25 Mar 2022 07:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648194398;
        bh=mhnz9m6G+ghJ/c67sYiI4HzhlXpK6Em9Vo4Mqbapwuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EvQGqDqqnUSxKTt2t0t4cWF1xH287iAC8iM8/isfkxlA0f+qsJH/EkrE1wOFuhBWc
         2sRBpIYRJximcGYj3lJBeuD3wcR0c4lqI+MnS53WmYC6JOKImEVCMzWofRpuo4O3kx
         LYH+aOUGiWRy6L0xwhq48RVSyJfQagn312WjdW9yiYrt4DWlMnFZLah1Y1lS4AMXem
         YYSCByZf6uDud6Jt/jnW8bWVab0LoF/97uqljKBaTaWvNFR0+TaDujhsjuaGl0rhZK
         p++qDnbWvoSd6Thd0a85Swa0zuG685IXpE6M8Eu6aw6WG/CcALKLdpx+89H56yslvT
         kWIeJmH2v0Sew==
Date:   Fri, 25 Mar 2022 10:46:30 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     vbabka@suse.cz, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ytk.lee@samsung.com,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH 0/8] memblock: introduce memsize showing reserved memory
Message-ID: <Yj1zVkryTVoAnxsX@kernel.org>
References: <CGME20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8@epcas1p4.samsung.com>
 <20220324070158.22969-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324070158.22969-1-jaewon31.kim@samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 24, 2022 at 04:01:50PM +0900, Jaewon Kim wrote:
> Some of memory regions can be reserved for a specific purpose. They are
> usually defined through reserved-memory in device tree. If only size
> without address is specified in device tree, the address of the region
> will be determined at boot time.
> 
> We may find the address of the memory regions through booting log, but
> it does not show all. And it could be hard to catch the very beginning
> log. The memblock_dump_all shows all memblock status but it does not
> show region name and its information is difficult to summarize.
> 
> This patch introduce a debugfs node, memblock/memsize, to see reserved
> memory easily.
> 
> Here's an example
> 
> $ cat debugfs/memblock/memsize
> 0x0f9000000-0x0fb000000 0x02000000 (   32768 KB )   map reusable linux,cma
> 0x0b1900000-0x0b1b00000 0x00200000 (    2048 KB ) nomap unusable test1
> 0x0b0200000-0x0b0400000 0x00200000 (    2048 KB )   map unusable test2
>  (snipped)
> 
> Reserved    :  746924 KB
>  .kernel    :  137027 KB
>   .text     :   28158 KB
>   .rwdata   :    3238 KB
>   .rodata   :   13468 KB
>   .bss      :   12570 KB
>   .etc      :   79593 KB
>  .unusable  :  609897 KB
> System      : 3447380 KB
>  .common    : 3152468 KB
>  .reusable  :  294912 KB
> Total       : 4194304 KB (  4096.00 MB )

Most of this information information is already available at various
places, like the existing memblock debugfs, /proc/iomem and DT sysfs.

I don't see why we need yet another debugfs file to expose it.
 
> Jaewon Kim (8):
>   memblock: introduce memsize showing reserved memory
>   memblock: detect hidden memory hole size
>   memblock: handle overlapped reserved memory region
>   memblock: track memblock changed at early param
>   memblock: track kernel size on memsize
>   memblock: recognize late free by checking PageReserved
>   memblock: print memsize summary information
>   memblock: print kernel internal size
> 
>  drivers/of/fdt.c             |  10 +
>  drivers/of/of_reserved_mem.c |   7 +-
>  include/linux/memblock.h     |  21 ++
>  include/linux/mm.h           |   3 +
>  init/main.c                  |  13 +-
>  kernel/dma/contiguous.c      |   9 +-
>  mm/Kconfig                   |   7 +
>  mm/memblock.c                | 434 ++++++++++++++++++++++++++++++++++-
>  mm/page_alloc.c              |  15 +-
>  9 files changed, 506 insertions(+), 13 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.
