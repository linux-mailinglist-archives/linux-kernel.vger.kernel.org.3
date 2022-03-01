Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF234C81B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiCADkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiCADkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:40:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF97037AB4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:39:20 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 195so13330711pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DQiI3/lq41slE6OAld2w97SIbiquHRBn1sYz1OaFUOg=;
        b=YJFbCLzWaBwk5txQ4lnqx6bYjjGZUAl+5zNyYawBXXCwb5sf7l1alpylJO4fLG7bZV
         IoIlTAgKtfJ2LGJEhiVAXc9SLYIg+fs52F3iZU2hjhhyyDVCF2qbwMu+07ogBr3kEitY
         vzGgeZK2nh6QJ9f4S7VNnE2eYh5P30AnDTuP5f/9mN66JpteJbdrqOLdwn2dF+UjHJeN
         mdjORkZwbkSXZUHgGGp18bc+fsIZAHWAOVq7DpKClEsSUhKok/ihGKfHoTo0OfNIv9Mz
         WWZpJH0Xrm5OFwf2QFkrRSKX58fGy6x/YmPo3gg9XWB7XVRV04LMQgzh4qBIoEH0bdyB
         5mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DQiI3/lq41slE6OAld2w97SIbiquHRBn1sYz1OaFUOg=;
        b=caK1kRn/1pTCWnhM+kSNM5dtcUNCcsTHXB1yBtt7VhOceE0kQ2b6echk47o5aO82Fn
         bDmJASJLqEiJHnwpHzItWBX06uxxpSc0PTbAi00gkTR3/LZnIDumWP/wAGD6WTeV9Hsh
         Tbrpg6dIE9gdwy1X/vcBTSb6lIOab+cxH4bYCIBZhLKYsGE+d1322FI2jH63eQKLUZSW
         Ik7UwmBMQPfOl1kYAR0XQp+DkwYi6N42lckDsQwEyUIWmAlIzSVEBqwgduB+KMmK3d9M
         1/Nw0Id3Qde28r1iezp6/CMROcIzh7/j35mNzxTlf8Zvhipihv2u74m4B6iwkPAS2qD8
         0yaw==
X-Gm-Message-State: AOAM531LhOht7hUYEsjQBBwSH6Dv5TQGBwNlFF/QxSRFhjrr/nTXsTnV
        h+j0vtlq7+b+L2uB42ynMzDEiQ==
X-Google-Smtp-Source: ABdhPJzbxoFGEjfg8n2qdCoZciaU6iaAmzzTD/E49i7BEuwCXVtOugEP0V8mBMNJhr7we8XSJrHylA==
X-Received: by 2002:a63:5a5c:0:b0:378:73b1:e1d8 with SMTP id k28-20020a635a5c000000b0037873b1e1d8mr10654109pgm.364.1646105960314;
        Mon, 28 Feb 2022 19:39:20 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm15173699pfu.202.2022.02.28.19.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 19:39:19 -0800 (PST)
Date:   Tue, 1 Mar 2022 11:39:13 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 8/8] dt-bindings: phy: qcom,qmp: Mark
 'vdda-pll-supply' & 'vdda-phy-supply' as optional
Message-ID: <20220301033913.GD269879@dragon>
References: <20220228123019.382037-1-bhupesh.sharma@linaro.org>
 <20220228123019.382037-9-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228123019.382037-9-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 06:00:19PM +0530, Bhupesh Sharma wrote:
> Fix the following 'make dtbs_check' warnings, by marking the
> 'vdda-pll-supply' & 'vdda-phy-supply' properties as 'optional' in
> 'qcom,qmp-phy' dt-binding:
> 
> arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
>  phy-wrapper@88e9000: 'vdda-phy-supply' is a required property
> 
> arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
>  phy-wrapper@88e9000: 'vdda-pll-supply' is a required property
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index f8a43acd229a..82b102b7d42c 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -436,9 +436,6 @@ allOf:
>            items:
>              - const: phy
>              - const: common
> -      required:
> -        - vdda-phy-supply
> -        - vdda-pll-supply

Not sure this change is correct.  In phy-qcom-qmp driver, sm8350_usb3phy_cfg
has qmp_phy_vreg_l assignment.

static const char * const qmp_phy_vreg_l[] = {
        "vdda-phy", "vdda-pll",
};

static const struct qmp_phy_cfg sm8350_usb3phy_cfg = { 
        .vreg_list              = qmp_phy_vreg_l,
        .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
};

That means for "qcom,sm8350-qmp-usb3-phy" device, these two supplied are
required.  The sony-xperia-sagami-pdx215 may work only because
devm_regulator_bulk_get() call in qcom_qmp_phy_vreg_init() doesn't fail
because of dummy regulator support.

Shawn

>    - if:
>        properties:
>          compatible:
> -- 
> 2.35.1
> 
