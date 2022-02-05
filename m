Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6002E4AA99A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 16:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357537AbiBEPQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 10:16:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42166 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiBEPQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 10:16:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C1D7B80BD9;
        Sat,  5 Feb 2022 15:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4703EC340E8;
        Sat,  5 Feb 2022 15:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644074175;
        bh=SIPhbdHKmWV6MppiCjN3egF7/k8xhne4taCD8UjBxe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqK84Z/iupWxKYPEI7t/l9f9mbCubnVPv43sCFs7KVDlgV4qis7Y3OqlWg4Kd4UZK
         +Ibr1j6wyWWAPcB979opIraDAbnlA/FezcG28rW2Mc6D3RbXVmn0fGzbznEmEH6QuI
         bEb6kVg4t070TclIszraqg6GuziNJxooARnuLPOUDPHMAiCMQGCl3bGgH9L4cQBHoF
         qIyfjvURxwWwAgWnOryLm3VT43/Uvv8egflcBVV2tNGuoBIPXRh+99ndosUg3fc0IN
         c4grOz/8dbvyRoTZ7CjwCFpw/kZax7cpRf7zzdxOtkopTTGznYLmw06K7RtN5AWet4
         50cfL7ewB+UnQ==
Date:   Sat, 5 Feb 2022 17:16:06 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org
Subject: Re: [PATCH] mm: Remove mmu_gathers storage from remaining
 architectures
Message-ID: <Yf6UthQtASGNgW8Q@kernel.org>
References: <20220205141956.3315419-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205141956.3315419-1-shorne@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 11:19:53PM +0900, Stafford Horne wrote:
> Originally the mmu_gathers were removed in commit 1c3951769621 ("mm: now
> that all old mmu_gather code is gone, remove the storage").  However,
> the openrisc and hexagon architecture were merged around the same time
> and mmu_gathers was not removed.
> 
> This patch removes them from openrisc, hexagon and nds32:
> 
> Noticed while cleaning this warning:
> 
>     arch/openrisc/mm/init.c:41:1: warning: symbol 'mmu_gathers' was not declared. Should it be static?
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/hexagon/mm/init.c  | 2 --
>  arch/nds32/mm/init.c    | 1 -
>  arch/openrisc/mm/init.c | 2 --
>  3 files changed, 5 deletions(-)
> 
> diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
> index f01e91e10d95..3167a3b5c97b 100644
> --- a/arch/hexagon/mm/init.c
> +++ b/arch/hexagon/mm/init.c
> @@ -29,8 +29,6 @@ int max_kernel_seg = 0x303;
>  /*  indicate pfn's of high memory  */
>  unsigned long highstart_pfn, highend_pfn;
>  
> -DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
> -
>  /* Default cache attribute for newly created page tables */
>  unsigned long _dflt_cache_att = CACHEDEF;
>  
> diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
> index f63f839738c4..825c85cab1a1 100644
> --- a/arch/nds32/mm/init.c
> +++ b/arch/nds32/mm/init.c
> @@ -18,7 +18,6 @@
>  #include <asm/tlb.h>
>  #include <asm/page.h>
>  
> -DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
>  DEFINE_SPINLOCK(anon_alias_lock);
>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>  
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index 97305bde1b16..3a021ab6f1ae 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -38,8 +38,6 @@
>  
>  int mem_init_done;
>  
> -DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
> -
>  static void __init zone_sizes_init(void)
>  {
>  	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
> -- 
> 2.31.1
> 

-- 
Sincerely yours,
Mike.
