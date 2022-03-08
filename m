Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33054D249D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 00:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiCHXGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 18:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiCHXGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 18:06:23 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786A061A06
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 15:05:25 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id ay7so885527oib.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 15:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rPTUbB4h0uzOl0pyJTM1C/6sy3GotW9nFVXhWq4ooIs=;
        b=F3pk+L2mLfEyDIMlXQr314zLDn6A+XToMiGZFsAkNrWlWlhek3i8UxrgZL1+XqQa3s
         f3LTRr7YQhKWmKsGXZTBpH9qJi0E/aTmX9aJn05aKIQXQuft5V1ljb9dqYL/Ae9zXQwQ
         C3xxJ1GLWpginlCgKmbsqj0yDWH5Npx60RAW3VSGQB4pTzrnzaeCPx2GtucmbcDLA4o8
         vOuzVeG45YYHI+aqnN8hCLSthBwnBoXYAcG233HRxeJuRJzDqxk8Mla7g6Gx6/i3kKZ+
         HNG/ippFPsFcCHPrGJkM9JLB7o++kvIkBKJkNyVYrn0FmmVPsVrzNElTtBv4/AlHAECz
         IXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rPTUbB4h0uzOl0pyJTM1C/6sy3GotW9nFVXhWq4ooIs=;
        b=YHYQo+makNziwInaLpAZ4+J75npzIHzNvuzGQrNBEJs180PYfCZ8eF0A0lsdC6130w
         8SIM+DafzLYkKRhPug0yXsOFCw6koxwsb2OGd3xzToQT/3cYD/K2JmRjPp4UrmZC86wm
         /W9kvJG7L33e1f/Ifsa5b9v5GZ7a0M111+2EQpSjvClHyB0U5HCkNO1a2EX/xwTPqob/
         /E0qR8dDdCT7TeUgvVThBt1AbuggA8W2Fi7yJ+90k/NHqMSbUDuRKILjXdyC8153JFwH
         S9rutrtw9d7JHhOXlq4T1L9qJYBA/t9y8fwtqPddyHUdo1oQX3t/IEpwwui+xcLCx0ko
         Nz4w==
X-Gm-Message-State: AOAM531CkoQ+wqku9bWxuu7f7k/QJnss388kS15IhveFwhk7BWjb7snG
        YtQFCBttwy/hpqGUaWVdf0bftA==
X-Google-Smtp-Source: ABdhPJxpOde9bNTgrgx11ZxO3FN5AhtPFdFf+K/l41CqWG0KwwkGVH5xrJ3ZTIF0nuCeawss/AYHuA==
X-Received: by 2002:a05:6808:1644:b0:2cd:6d80:9af1 with SMTP id az4-20020a056808164400b002cd6d809af1mr4201343oib.138.1646780724786;
        Tue, 08 Mar 2022 15:05:24 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id v37-20020a056830092500b005b1f7daf40asm64940ott.75.2022.03.08.15.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 15:05:24 -0800 (PST)
Date:   Tue, 8 Mar 2022 17:05:22 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, tdas@codeaurora.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sm8150: Add ufs power-domain
 entries
Message-ID: <YifhMiBXRMOCamOt@builder.lan>
References: <20220303082140.240745-1-bhupesh.sharma@linaro.org>
 <20220303082140.240745-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303082140.240745-3-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Mar 02:21 CST 2022, Bhupesh Sharma wrote:

> Add power-domain entries for UFS controller & phy nodes
> in sm8150 dts.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 6012322a5984..7aa879eb24d7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -1637,6 +1637,8 @@ ufs_mem_hc: ufshc@1d84000 {
>  			phy-names = "ufsphy";
>  			lanes-per-direction = <2>;
>  			#reset-cells = <1>;
> +
> +			power-domains = <&gcc UFS_PHY_GDSC>;

It seems odd that the controller would be in the PHY power-domain?

>  			resets = <&gcc GCC_UFS_PHY_BCR>;
>  			reset-names = "rst";
>  
> @@ -1687,6 +1689,9 @@ ufs_mem_phy: phy@1d87000 {
>  			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
>  				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
>  
> +			power-domains = <&gcc UFS_CARD_GDSC>,
> +					<&gcc UFS_PHY_GDSC>;

And "card" is typically related to the second UFS interface, so I
suspect you only would need the last one of these?

Regards,
Bjorn

> +			power-domain-names = "ufs_card_gdsc", "ufs_phy_gdsc";
>  			resets = <&ufs_mem_hc 0>;
>  			reset-names = "ufsphy";
>  			status = "disabled";
> -- 
> 2.35.1
> 
