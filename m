Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51F449638D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350595AbiAURHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:07:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56860 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349733AbiAURHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:07:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B528FB82066
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03999C340E1;
        Fri, 21 Jan 2022 17:07:38 +0000 (UTC)
Date:   Fri, 21 Jan 2022 17:07:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     cgel.zte@gmail.com
Cc:     pasha.tatashin@soleen.com, si.hao@zte.com.cn,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, james.morse@arm.com
Subject: Re: [PATCH linux-next] arm64: kexec: Support the case of VA_BITS=39
 in trans_pgd_idmap_page()
Message-ID: <YeroVxXEcUz8RTgv@arm.com>
References: <20220121065216.1001021-1-si.hao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121065216.1001021-1-si.hao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 06:52:16AM +0000, cgel.zte@gmail.com wrote:
> From: sihao <si.hao@zte.com.cn>
> 
> When the values of CONFIG_ARM64_VA_BITS and CONFIG_ARM64_PA_BITS are not
> equal, the following panic occurs when kexec is executed.
> 
> This happens because trans_pgd_idmap_page() does not support VA_BITS=39.
> So the patch supports the case of VA_BITS=39.
[...]
> diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> index d7da8ca40d2e..3d88185adcf5 100644
> --- a/arch/arm64/mm/trans_pgd.c
> +++ b/arch/arm64/mm/trans_pgd.c
> @@ -232,7 +232,7 @@ int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
>  {
>  	phys_addr_t dst_addr = virt_to_phys(page);
>  	unsigned long pfn = __phys_to_pfn(dst_addr);
> -	int max_msb = (dst_addr & GENMASK(52, 48)) ? 51 : 47;

This should have been GENMASK(51, 48), though it doesn't make any
difference and may work better with the change below:

> +	int max_msb = (dst_addr & GENMASK(52, VA_BITS)) ? 51 : (VA_BITS - 1);

So when VA_BITS == 52, the mask is 0 and we set max_msb to 51.

I wonder, could we use fls64() instead here?

-- 
Catalin
