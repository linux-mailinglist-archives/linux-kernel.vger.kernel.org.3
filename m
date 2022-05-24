Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61BD532500
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiEXIM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiEXIMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:12:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0830660BBB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED0CE6153B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6214CC385AA;
        Tue, 24 May 2022 08:12:13 +0000 (UTC)
Date:   Tue, 24 May 2022 09:12:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, will@kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanchuanhua@oppo.com, zhangshiming@oppo.com, guojian@oppo.com,
        Barry Song <v-songbaohua@oppo.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Shaohua Li <shli@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] arm64: enable THP_SWAP for arm64
Message-ID: <YoyTWaDmSiBUkaeg@arm.com>
References: <20220524071403.128644-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524071403.128644-1-21cnbao@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 07:14:03PM +1200, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> THP_SWAP has been proved to improve the swap throughput significantly
> on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
> splitting THP after swapped out").
> As long as arm64 uses 4K page size, it is quite similar with x86_64
> by having 2MB PMD THP. So we are going to get similar improvement.
> For other page sizes such as 16KB and 64KB, PMD might be too large.
> Negative side effects such as IO latency might be a problem. Thus,
> we can only safely enable the counterpart of X86_64.
> 
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index d550f5acfaf3..8e3771c56fbf 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -98,6 +98,7 @@ config ARM64
>  	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>  	select ARCH_WANT_LD_ORPHAN_WARN
>  	select ARCH_WANTS_NO_INSTR
> +	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES

I'm not opposed to this but I think it would break pages mapped with
PROT_MTE. We have an assumption in mte_sync_tags() that compound pages
are not swapped out (or in). With MTE, we store the tags in a slab
object (128-bytes per swapped page) and restore them when pages are
swapped in. At some point we may teach the core swap code about such
metadata but in the meantime that was the easiest way.

-- 
Catalin
