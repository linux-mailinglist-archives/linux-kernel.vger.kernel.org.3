Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E834BD576
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344567AbiBUFfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:35:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344559AbiBUFfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:35:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA684AE21
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:35:21 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id ci24-20020a17090afc9800b001bc3071f921so2012988pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=33J/57nAxSn7KHcYx9u5u+41MVedNA5dVhmvQ8pezfU=;
        b=oWfhdr7k2nhW6My+Jw699SkuwzOehDV+ERYV4S0wJGzSIA+D5A7otdDLVyUxXta/1s
         6yQ55L+EMRIDv2aK2JEYK7DC3GUfyQK8GjcctyBWpM9OYMFxCTuAys7NjLTzGJ/P9NyC
         Bq7Z0kOuHa/Lo2tZz8ZYA6/LPwylRcTWQVOMxaQOp+l89MbpptCoVzB/LnNtkHoxnNgg
         JVe52SLiL32NkfgLgO/QIobIsHwKCqBFPp0AhuCkzK7SDfE04I8IkzFYaAm38UHezeAL
         F26pgCf7EvviSLZ3KuQx3T0/SO5faCXWMWk38eq8yQrgahovFTbbRksOPqUQ8csL1YkV
         JLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=33J/57nAxSn7KHcYx9u5u+41MVedNA5dVhmvQ8pezfU=;
        b=v8qOzr6w+dZRMAfmVbgJ08ZluaMpFuIGkljo9PDtmtoiSVwtAXAyWVnn/CLqusSM7i
         bTEA517TyUTKYVbplmEZjloGRKUSiLojADeCsuUDt77rN7uIk3F3KoiNkv4hyzXNAMAw
         xH1w0An/YECkkaqs+do4d48Gn4NmOjyb0gtJHPBoxM4ELYVS6ktYmBaFI9yfH/oUSS6G
         pTRrqLKJlih79RkShqc4D+2xIVm+ddgnXZP+aKcdD44ccslJtE+B9f6Z0MWx78jsYuht
         hwMWh22pbGIgKdBzWfRPA+yrDzR9Yf6BBfGScVxcrW+e/gbuEh40CpaE1g9tbAT3eyQ7
         Rkfw==
X-Gm-Message-State: AOAM532ccwAAuZ7aEoZOgJ9b8mvJoHZdZatWjz1Yz0l0hOdOp8kbprNv
        jNftmHy81LvPRSzNKynaFNux
X-Google-Smtp-Source: ABdhPJwCxa7n3N2IQRg6LXTIhA76NLNBlBqFee+u+GuUOaJ509tU02AxKJ+XNItcF5t2ZB5HPixdjA==
X-Received: by 2002:a17:90b:110a:b0:1b9:eb62:7c00 with SMTP id gi10-20020a17090b110a00b001b9eb627c00mr19837163pjb.67.1645421719824;
        Sun, 20 Feb 2022 21:35:19 -0800 (PST)
Received: from thinkpad ([220.158.158.223])
        by smtp.gmail.com with ESMTPSA id b22-20020a17090a10d600b001b8e6841ca5sm6019443pje.51.2022.02.20.21.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 21:35:19 -0800 (PST)
Date:   Mon, 21 Feb 2022 11:05:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] mailbox: qcom: Add support for SDX65 APCS IPC
Message-ID: <20220221053514.GA15108@thinkpad>
References: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
 <1645420953-21176-3-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645420953-21176-3-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:52:28AM +0530, Rohit Agarwal wrote:
> In SDX65, the IPC bits are located in the APCS GCC block. Also, this block
> can provide clock functionality. Hence, add support for IPC with correct
> offset and name of the clock provider.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 9325d2a..54d7659 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -53,6 +53,10 @@ static const struct qcom_apcs_ipc_data sdx55_apcs_data = {
>  	.offset = 0x1008, .clk_name = "qcom-sdx55-acps-clk"
>  };
>  
> +static const struct qcom_apcs_ipc_data sdx65_apcs_data = {
> +	.offset = 0x1008, .clk_name = "qcom-sdx55-acps-clk"
> +};

What I suggested was reusing the "qcom,sdx55-apcs-gcc" compatible in devicetree.
So with that, you won't need this specific compatible for SDX65 that essentially
duplicates SDX55.

Thanks,
Mani

> +
>  static const struct regmap_config apcs_regmap_config = {
>  	.reg_bits = 32,
>  	.reg_stride = 4,
> @@ -159,6 +163,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>  	{ .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
>  	{ .compatible = "qcom,sm6115-apcs-hmss-global", .data = &msm8994_apcs_data },
>  	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
> +	{ .compatible = "qcom,sdx65-apcs-gcc", .data = &sdx65_apcs_data },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
> -- 
> 2.7.4
> 
