Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A75187CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbiECPGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbiECPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:06:31 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4703A193
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:02:58 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso6849682fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gQLzkke3mAD6r/LF03DB/YtaShDebAvgN9C8Yr2tvxQ=;
        b=pEO2gBgz8m+NCeMczhVBvPhu22BV0XIfYT8yEGOwHAJesP6vo4gLVHDPyZENviv8uO
         FJ9sYwagICWrZOKPqaunpmUbY8Ee3IYIzTb51rhiftaHBQdcWjaXqk1nlhtR10jf77eU
         tt39+/4E4Y8XA2DfUYMEgG+OlUaNoGa0nIykYox9y2tS/ejplAvlEzLcCI3vGlCoIk26
         y4+81KlsfpnvLqPlb8YJaWGKd/Ze1j34ZstzmzktulR1thxIu62lKh6t6FUM7xhxM0/t
         4h7fZV/dfPfiLAZV5iSCkzk5CfKspdvvLhrJnG3n6NmKl3tw97hReYlKP8RvVew9p4Fm
         pTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gQLzkke3mAD6r/LF03DB/YtaShDebAvgN9C8Yr2tvxQ=;
        b=YH0A6WCF0cKpTvWK7Vk+sxV8UQxJ3yMzdPcKHYBZjHWAPzgWykd+ekhyRrMby3qBZS
         erJUjbzxl8aD4jX6oGpfEPZFAkFA32HyGr2ulWe6yPZvhNq9c48984IKA1b08Zxiyw3z
         85lqFIZfm4yykMmXTlifRpG+y2zOyT4ZhZGe3BT0mimpa7uSzOPoQN2p7FNG1RS8mO2N
         L5HeiN9tsHtFTsySEFlb/dWql8+ekaCyOoNBQFLownzbdvdo1yDT8Md8jblHQ1yfAXnw
         dw7cYlCexa5EIx7i3udw0Nw4azu7cfhDink0xQAP5yxrl4c994OWUdylq9WuP7tfaHuw
         e+bA==
X-Gm-Message-State: AOAM531tTr/ZpCCGYK7Zt8oIhNlerEcQrxbfa3+Q0hpB2LAwZaoFdNG5
        BRu8zlPQUebrfvzNXhk5/umBQQ==
X-Google-Smtp-Source: ABdhPJwVRcQPpPZBizpnHmcx7jLJeBLPtgfMHJLo4IdMsx7TVzgfl0A5BWi8V0xE/3rw2ahHAwYj+w==
X-Received: by 2002:a05:6870:d1d4:b0:e9:c135:2730 with SMTP id b20-20020a056870d1d400b000e9c1352730mr1947852oac.77.1651590177928;
        Tue, 03 May 2022 08:02:57 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j5-20020a9d7685000000b006060322125asm4154673otl.42.2022.05.03.08.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:02:56 -0700 (PDT)
Date:   Tue, 3 May 2022 10:02:51 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 2/8] clk: Introduce CLK_ASSUME_ENABLED_WHEN_UNUSED
Message-ID: <YnFEGzTQMsNpczai@builder.lan>
References: <20220503130448.520470-1-robert.foss@linaro.org>
 <20220503130448.520470-2-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503130448.520470-2-robert.foss@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03 May 08:04 CDT 2022, Robert Foss wrote:

> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
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
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 

I discussed this with Stephen a while ago and we agreed that in a
sufficiently complex system with kernel modules booting without
clk_ignore_unused simply isn't supported.

We will have to design something better. So please drop this patch from
the series.

Regards,
Bjorn

> Changes since v1
>  - Removed Vinods r-b
> 
> 
>  drivers/clk/clk.c            | 2 +-
>  include/linux/clk-provider.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ed119182aa1b..9789ec137219 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1284,7 +1284,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>  	 * sequence.  call .disable_unused if available, otherwise fall
>  	 * back to .disable
>  	 */
> -	if (clk_core_is_enabled(core)) {
> +	if (clk_core_is_enabled(core) || core->flags & CLK_ASSUME_ENABLED_WHEN_UNUSED) {
>  		trace_clk_disable(core);
>  		if (core->ops->disable_unused)
>  			core->ops->disable_unused(core->hw);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index c10dc4c659e2..9038022ffebd 100644
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
> 2.34.1
> 
