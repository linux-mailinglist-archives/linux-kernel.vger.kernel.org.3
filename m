Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FA34B0069
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiBIWfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:35:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbiBIWfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:35:10 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBA4E019269
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:35:11 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so4220721ooi.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7sNMbEN2ZWSKBSAKG7biB3FxMf95az/sXODaHaCSWMs=;
        b=xdcjIPjBdfsq47myDzGlv/zDnSvqcldTrssyKMmoNbBcmUw17fDaGp0J/7YeM0yqmg
         s8qWJDlGouztaI3L3dssm+Cpw12Gr8ov9SLFvidB+1pfLT8ol8I+JprQAoRBrzqqrboZ
         nbXLMNrQFM1FxTGR9rCmePKWeLdWhoR/y5dfoPvdJz9aFLZ+TN2pxPw6d9x/VIJuj36Z
         eNTwsOF1QO3RaM49fcz4iuxlbP58AFsMFNuprEf3paG49jotMgGznnttTKdpyvTJtONz
         AxIlSS+bv2EvMq+7ollItzv1rZG4cyXWmZORmzxdjX9tjb1Dc0LvVir9lQHsGl0NbMxu
         dDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7sNMbEN2ZWSKBSAKG7biB3FxMf95az/sXODaHaCSWMs=;
        b=om84PQsyukY8g4jXBv+Y1rFzKxUomdAMPJsUww0bobZTLk5HGFApFe4azQwSOuuxOl
         jlVdo3sVhy732m5JbDQVjAoXDSvsr1zyrPgx9T5kcBB5i1/7WvOCpRsa38+1ac9rWBNn
         ASta+ahX8NB6QGFocT1yXVaHV7nBmwR7KUNU8j5XIOQMJcF7oqTl/q4hkEuFMOYhQyAl
         fYFlOkEMDVmKVEAGVirxoIJ7h9NuijYDG0XASWiXvuj4fbIqLt2t8/3aU3vk12PnyKk3
         ao6jyYntv93SzXVuvLtuIJ7tRG9Gs3x5F8uaiuiPmRtswupJDpXiTiRQ6PHrEYjUINLS
         931w==
X-Gm-Message-State: AOAM5330QrUwlSRVNv2IWnSt+LKTmjScN3pO5eSXStlTGpEnzBEQCyFQ
        3CwN5kD4ttK/QG6fASh95DJotA==
X-Google-Smtp-Source: ABdhPJw6ZCPvGXCBpXm4rynDmp58kloRm/T18gaJuFBSN0X6h1u23KWWxaJ+mFJOT3PwydMvdL4l/A==
X-Received: by 2002:a4a:e1cb:: with SMTP id n11mr1840337oot.46.1644446111200;
        Wed, 09 Feb 2022 14:35:11 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s64sm7233725oos.0.2022.02.09.14.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:35:10 -0800 (PST)
Date:   Wed, 9 Feb 2022 16:35:08 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette ? <mturquette@baylibre.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v1 1/2] clk: qcom: gdsc: Use the default transition delay for
 GDSCs
Message-ID: <YgRBnExwlzI+lPlR@builder.lan>
References: <20220209172513.17873-1-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209172513.17873-1-tdas@codeaurora.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09 Feb 11:25 CST 2022, Taniya Das wrote:

> Do not update the transition delay and use the default reset values.
> 
> Fixes: 45dd0e55317cc ("clk: qcom: Add support for GDSCs)
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/clk/qcom/gdsc.c | 6 +++++-
>  drivers/clk/qcom/gdsc.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 7e1dd8ccfa38..e7b213450640 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -380,7 +380,11 @@ static int gdsc_init(struct gdsc *sc)
>  	 */
>  	mask = HW_CONTROL_MASK | SW_OVERRIDE_MASK |
>  	       EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
> -	val = EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
> +
> +	regmap_read(sc->regmap, sc->gdscr, &val);
> +
> +	if (!(sc->flags & DEFAULT_TRANSITION_DELAY))

I dug a little bit more into this and noticed that on various platforms
CLK_DIS_WAIT_VAL for the GPU_CX GDSC is supposed to be 8 (whereas both
hw default and CLK_DIS_WAIT_VAL is 2).

I'm not able to find anything helpful in the git log describing what the
value does, but it seems that a "just use hw default" flag won't cut it
for this scenario.

Regards,
Bjorn

> +		val |= EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
>  	ret = regmap_update_bits(sc->regmap, sc->gdscr, mask, val);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index d7cc4c21a9d4..1bd3ecdd0b0a 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -53,6 +53,7 @@ struct gdsc {
>  #define ALWAYS_ON	BIT(6)
>  #define RETAIN_FF_ENABLE	BIT(7)
>  #define NO_RET_PERIPH	BIT(8)
> +#define DEFAULT_TRANSITION_DELAY	BIT(9)
>  	struct reset_controller_dev	*rcdev;
>  	unsigned int			*resets;
>  	unsigned int			reset_count;
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 
