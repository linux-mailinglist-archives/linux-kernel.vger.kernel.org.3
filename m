Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418D2477A79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbhLPRXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240040AbhLPRXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:23:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAEEC061574;
        Thu, 16 Dec 2021 09:23:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2A2561EED;
        Thu, 16 Dec 2021 17:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE79AC36AE0;
        Thu, 16 Dec 2021 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639675421;
        bh=LqK5qOVnaql7Fj5llN4nlA9Kh7e/Z7C4n3v0Z+Jl7bM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gf6qzF8nj81pIJ0P/SIEylCa5W7J1vHYnEI0VOEL6L3e69MyBGXwsY3ayWlnWtuqY
         Px7o0cCpUphGQXUTBb5CmJ4iSCvW+kCz+rVXHTjCnBqkOYEay32sh5hYFnO7TPdLU6
         WT2G1mmz7G879B1AOZV8PuC4x2/8A5S7VC26wtQFTv0IRVmaLLEIfAu2ubSfL2kWpf
         2ecomR/SGetxXGeh0gLUXLZK+o5Wq/7MlculXx5Lc29oM3lQNbDi3kTzyjA0BlI17w
         8Ss5gow17960+JSoN7ufwi3LWazB/Odp+GYM1H6c6TYCAumjuK7Oh+IIUTkyXSasEd
         uLeuU2vuYutnA==
Date:   Thu, 16 Dec 2021 19:23:34 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Quentin Perret <qperret@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v3] of/fdt: Don't worry about non-memory region overlap
 for no-map
Message-ID: <Ybt2FlgxnuNdZV68@kernel.org>
References: <20211215195354.634746-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215195354.634746-1-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:53:54AM -0800, Stephen Boyd wrote:
> In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
> already reserved regions") we returned -EBUSY when trying to mark
> regions as no-map when they're in the reserved memory node. This if
> condition will still trigger though if the DT has a /memreserve/ that
> completely subsumes the no-map memory carveouts in the reserved memory
> node. Let's only consider this to be a problem if we're trying to mark a
> region as no-map and it is actually memory. If it isn't memory,
> presumably it was removed from the memory map via /memreserve/ and thus
> can't be mapped anyway.

I don't see /memreserve/ removing memory from anywhere. What do you
mean here?

> This silences a warning seen at boot on sc7180-trogdor.dtsi boards that
> have /memreserve/ populated by the bootloader where those reserved
> regions overlap with the reserved-memory carveouts that we have in DT
> for other purposes like communicating with remote processors.
> 
> For example in sc7180.dtsi we have the following reserved-memory
> node:
> 
> 	smem_mem: memory@80900000 {
> 		reg = <0x0 0x80900000 0x0 0x200000>;
> 		no-map;
> 	};
> 
> and the memreserve injected by the bootloader is
> 
> 	/memreserve/ 0x80800000 0x400000;
> 
> so the reserved memory region overlaps with the no-map carveouts and we
> get the following warning message printed at boot:
> 
>  OF: fdt: Reserved memory: failed to reserve memory for node 'memory@80900000': base 0x0000000080900000, size 2 MiB
> 
> Everything keeps working, just the no-map property is being ignored in
> __reserved_mem_reserve_reg() because the region we're trying to avoid
> mapping has already been removed from the memory via the memreserve.
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Nicolas Boichat <drinkcat@chromium.org>
> Cc: Quentin Perret <qperret@google.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Fixes: 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove already reserved regions")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes from v2 (https://lore.kernel.org/r/20211215072011.496998-1-swboyd@chromium.org):
>  * More details in commit text
> 
> Changes from v1 (https://lore.kernel.org/r/20210520012731.3731314-1-swboyd@chromium.org):
>  * Use memblock_overlaps_region instead of memblock_is_region_memory()
>  * Add more details to commit text 
> 
>  drivers/of/fdt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bdca35284ceb..c736e5bcc2f6 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -482,9 +482,11 @@ static int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
>  	if (nomap) {
>  		/*
>  		 * If the memory is already reserved (by another region), we
> -		 * should not allow it to be marked nomap.
> +		 * should not allow it to be marked nomap, but don't worry
> +		 * if the region isn't memory as it won't be mapped.
>  		 */
> -		if (memblock_is_region_reserved(base, size))
> +		if (memblock_overlaps_region(&memblock.memory, base, size) &&
> +		    memblock_is_region_reserved(base, size))

Apparently I'm missing something, but sc7180.dtsi has memory @80000000 and I
cannot find anything that calls memblock_remove() in DT processing.

How is that memory@80900000 does not overlap with memblock.memory?

>  			return -EBUSY;
>  
>  		return memblock_mark_nomap(base, size);
> 
> base-commit: 136057256686de39cc3a07c2e39ef6bc43003ff6
> -- 
> https://chromeos.dev
> 

-- 
Sincerely yours,
Mike.
