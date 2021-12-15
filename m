Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D165D475572
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbhLOJtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:49:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54498 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241286AbhLOJtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:49:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7284EB817DB;
        Wed, 15 Dec 2021 09:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36947C34605;
        Wed, 15 Dec 2021 09:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639561777;
        bh=iyz1IavZbdA7EvQGlAK3NVUq4sQ3YeO8OiWehA9NRu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=We9EgW3nbhl3PPysO5L97scwaaPLW/+ADafzE2Z6K5KbxIB6PP1MPXa38x2lT7y30
         lLIyHWB85i7T71dQzMg91DSaq+cS6b0qHDP4fO+6oC+reCower+G2Hj3VJovjeeOlM
         gCBfeKZiQLr31pjHUbo4WZXE5EmbfnuMbTA/vPCdcsXYFwLqPiHb517yYN5G6vRDu4
         8cvHxvlfsSuEZXnAr348MNHCsaK7BD81GkDkNk/7+kFHAHIB4nIYqG2nbZYIzAHcoG
         msK9w5bOeiRwKjozf3/JAetAt1BAhcnQcE9oMFWY5cfOXmDpHgEs2S6d0tbganF1dJ
         P/sD+yVm+rlEA==
Date:   Wed, 15 Dec 2021 11:49:29 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Quentin Perret <qperret@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2] of/fdt: Don't worry about non-memory region overlap
 for no-map
Message-ID: <Ybm6KQiS7B28QOSW@kernel.org>
References: <20211215072011.496998-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215072011.496998-1-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 14, 2021 at 11:20:11PM -0800, Stephen Boyd wrote:
> In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
> already reserved regions") we returned -EBUSY when trying to mark
> regions as no-map when they're in the reserved memory node. This if
> condition will still trigger though if the DT has a /memreserve/ that
> completely subsumes the no-map memory carveouts in the reserved memory
> node. Let's only consider this to be a problem if we're trying to mark a
> region as no-map and it is actually memory. If it isn't memory,
> presumably it was removed from the memory map via /memreserve/ and thus
> can't be mapped anyway.

I have no objections for this patch, but I afraid that this is a never
ending story of reservation vs nomap ordering and this won't be the last
fix in the area.

I was toying with the idea to use flags in memblock.reserved to have
clearer view of how the reserved memory was used and then we won't need
to guess firmware intentions.
Thoughts?
 
> This silences a warning seen at boot on sc7180-trogdor.dtsi boards that
> have /memreserve/ populated by the bootloader where those reserved
> regions overlap with the reserved-memory carveouts that we have in DT
> for other purposes like communicating with remote processors.

Do you mind adding the relevant pats of the device tree to the changelog?

> For example
> 
>  OF: fdt: Reserved memory: failed to reserve memory for node 'memory@80900000': base 0x0000000080900000, size 2 MiB
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
