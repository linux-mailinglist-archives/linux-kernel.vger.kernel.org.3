Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A266D562654
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiF3W7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiF3W7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:59:36 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DBA4F675
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:59:31 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-101ec2d6087so1298491fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X+YOW7gymoq6p54kuAg0y4LK1kLT0zocnaMJboxGrsU=;
        b=LFmipgv0Q2D25QLpPe/Pg0B/X3coeBlnwZnf7GrtlboNOw0qhexKayD2jMjcUhS+Rc
         /v3OyIAKAKO6VFF5QjmcuZsht15IwshhudaBuW1QxETOYmRMPAFN4W5ijt2JCtvoirYl
         WseBLetocdfIRqd2YU4SKtZwRrEkoGRUFdCg0Ju+rr9cc+XttMOCHZTFnpgtDqkKbgK7
         aCXoyG/S0yqzP9KNqKaBvIKvCWlOk2iZOz/INnIsuzK1FUlvIAwWbFFrW4qLhMZTxwc6
         kYLkB2gmjBa7LO2THTqtJiEyBZjmru0wR893piOalfoUSFBC6PedlhJqJqPfH2NmY/rZ
         5eCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X+YOW7gymoq6p54kuAg0y4LK1kLT0zocnaMJboxGrsU=;
        b=hIblU8NTazOI8ohBSSZaFpLQeRSXnbZe5rHBvwbwm9pisKKyCxy/ZeZ07UnjK5ub8W
         P/eXyeuVILBxJLl0yRxFRUb6o2jyBu7Qwoo6lwDnp/Y5ZUk8QNPKlB0EGnCGJM0FSvdj
         8kQwSWPJCAiK9DDJWP7O0Sr1oAFul2frCbb+Bz24tFZqS8TkWD3tsQHJUpNyEi+XcDwf
         91X+UdhIp62Kq84JbEDqc/lbffdPe6n3jDBdWat5DgK3tneARjFMaB0Wb8I466t90kir
         UHgDg1I3G9nH07uGRUUFLOCbqjJh9Fv+h0AAegFSp1oP59m0VtCI3LlTIhL27o4rwmWp
         EDeg==
X-Gm-Message-State: AJIora8pUdjTLpuqFJR0Tca7u1UgmaosFKXP0T+CJs7HB8rMHPrkWT7z
        pm9ZNYICfAPGpIzdLhzrIDE5RQ==
X-Google-Smtp-Source: AGRyM1v1gpzW6017TKVLsRI3kd4o5RZjQ1cOKjRE1jlcR8QCX1c4TZxVbRXb9mu58am9PIxOFJ9zQQ==
X-Received: by 2002:a05:6870:f616:b0:f2:dac0:e339 with SMTP id ek22-20020a056870f61600b000f2dac0e339mr8223802oab.116.1656629971234;
        Thu, 30 Jun 2022 15:59:31 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s24-20020a056808009800b00333f889c9c2sm10642248oic.33.2022.06.30.15.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:59:30 -0700 (PDT)
Date:   Thu, 30 Jun 2022 17:59:28 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock
 controller support
Message-ID: <Yr4q0G1AT4YSOIU5@builder.lan>
References: <20220515204540.477711-1-robimarko@gmail.com>
 <20220515204540.477711-4-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220515204540.477711-4-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 15 May 15:45 CDT 2022, Robert Marko wrote:

> IPQ8074 has the APSS clock controller utilizing the same register space as
> the APCS, so provide access to the APSS utilizing a child device like
> IPQ6018 does as well, but just by utilizing the IPQ8074 specific APSS
> clock driver.
> 
> Also, APCS register space in IPQ8074 is 0x6000 so max_register needs to be
> updated to 0x5FFC.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 80a54d81412e..b3b9debf5673 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -33,6 +33,10 @@ static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
>  	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
>  };
>  
> +static const struct qcom_apcs_ipc_data ipq8074_apcs_data = {
> +	.offset = 8, .clk_name = "qcom,apss-ipq8074-clk"
> +};
> +
>  static const struct qcom_apcs_ipc_data msm8916_apcs_data = {
>  	.offset = 8, .clk_name = "qcom-apcs-msm8916-clk"
>  };
> @@ -57,7 +61,7 @@ static const struct regmap_config apcs_regmap_config = {
>  	.reg_bits = 32,
>  	.reg_stride = 4,
>  	.val_bits = 32,
> -	.max_register = 0x1008,
> +	.max_register = 0x5FFC,

Please use lower case hex digits.

And please send the mailbox patches separately, to make it clear for the
maintainers that this can be picked independently of others.

Regards,
Bjorn

>  	.fast_io = true,
>  };
>  
> @@ -142,7 +146,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
>  /* .data is the offset of the ipc register within the global block */
>  static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>  	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
> -	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &msm8994_apcs_data },
> +	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq8074_apcs_data },
>  	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
>  	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
>  	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
> -- 
> 2.36.1
> 
