Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E24246B213
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhLGFIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:08:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52074 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhLGFIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:08:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 231AAB80DCB;
        Tue,  7 Dec 2021 05:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BB1C341C1;
        Tue,  7 Dec 2021 05:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638853490;
        bh=Xg6vfHrpMYBQLi0FhYJxDhSTu6kyDcBJtkekSmZ0j1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZyfWeQeTETKtw3l6OI8kOSQ6ISvUhfT2gxxkwlXetOqZ2LR3fjBgiQRKez5RFMyE8
         YANY0lZL5kHHR+SFgf3J0ec2WJ/6xxZmaJDwWWkpVTpAI56W6Q0NP+yJDEjbj4Bqtw
         Lw/obzzuCymHYUrGh3zmsbtxruY/07kV0+13riSIwVVKt8YfWiKxgGu/VZRJwhIINX
         zJsZVhLw+lZHuuKYgwfHefhTDMBNg2hgd0mZw14lBqlAsP1I6dhUwnPJ+DSEMp1mK1
         xOCEZSNgztjHSNykizCm87Rsh8KOeZ4qRIwkw+fdVuzZLYFP66u17D580V5TaUzNm3
         eov3WQwOgrupg==
Date:   Tue, 7 Dec 2021 10:34:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, dmitry.baryshkov@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: Introduce CLK_ASSUME_ENABLED_WHEN_UNUSED
Message-ID: <Ya7rbsEzt8k73B0V@matsya>
References: <20211203035436.3505743-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203035436.3505743-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-21, 19:54, Bjorn Andersson wrote:
> Some clock implementations doesn't provide means of implementing
> is_enabled(), but still requires to be explicitly disabled when found
> unused as part of clk_disable_unused().
> 
> One such set of clocks are Qualcomm's display RCGs. These can be enabled
> and disabled automatically by the hardware, so it's not possible to
> reliably query their configuration. Further more, these clocks need to
> be disabled when unused, to allow them to be "parked" onto a safe
> parent. Failure to disable the RCG results in the hardware locking up as
> clk_disable_unused() traverses up the tree and turns off its source
> clocks.
> 
> Add a new flag, CLK_ASSUME_ENABLED_BOOT, which clock drivers can use to
> signal that these clocks should be disabled even if they don't implement
> the is_enabled() ops.

I think the name is bit long, but can't think of anything better. Btw
the explanation in log is _very_ good. I think we need to capture this
in the header file below as well.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/clk/clk.c            | 2 +-
>  include/linux/clk-provider.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index f467d63bbf1e..e0bb53cbd4c8 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1265,7 +1265,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>  	 * sequence.  call .disable_unused if available, otherwise fall
>  	 * back to .disable
>  	 */
> -	if (clk_core_is_enabled(core)) {
> +	if (clk_core_is_enabled(core) || core->flags & CLK_ASSUME_ENABLED_WHEN_UNUSED) {
>  		trace_clk_disable(core);
>  		if (core->ops->disable_unused)
>  			core->ops->disable_unused(core->hw);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index f59c875271a0..7661cce31fa1 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -32,6 +32,8 @@
>  #define CLK_OPS_PARENT_ENABLE	BIT(12)
>  /* duty cycle call may be forwarded to the parent clock */
>  #define CLK_DUTY_CYCLE_PARENT	BIT(13)
> +/* assume clock is enabled if found unused in late init */
> +#define CLK_ASSUME_ENABLED_WHEN_UNUSED	BIT(14)
>  
>  struct clk;
>  struct clk_hw;
> -- 
> 2.33.1

-- 
~Vinod
