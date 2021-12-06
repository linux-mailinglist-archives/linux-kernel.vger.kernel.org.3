Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF10469C8B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245402AbhLFPX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355965AbhLFPO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:14:29 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBE0C0698C7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:06:33 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bf8so21964068oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qi+ACrBvsCQh4aeidtMrQGAwDrCcUC2mWJ4NwcOqezo=;
        b=Lyk3ZV2G1kBXn1OTUhDPb6Rn1v2PiSF1kFXmGNPvzvrOKeWbWhReflgDjfQVo5FeXE
         TDDmBx7k1iI9nH1Z/jP6bdzMXtGIsMcvopIW9O/RHPHJdpPRwm0K30aYzOd91ttnPoxQ
         iDZPE9trErEVcn3KPgYPuFWNvxkDkBtNCuS7hmfYnbv3ufxTdNbAh9Qaq3q5z5p9TWiE
         COM3CZtxqNQC3quUP9WS1jKJUKnw718D6NLTzK1O6xWFuxF8GhGv2DopuLxQTzUjKQcD
         vxdUiD+/JzHGqRtUStIY9pJvG0EtMOqq6iuuILThXbz+5sxAkxbDZqcbAwbsQMiQXBAP
         pPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qi+ACrBvsCQh4aeidtMrQGAwDrCcUC2mWJ4NwcOqezo=;
        b=6JoTAw/4Fh+/p0GqUL8z9dSGFJ7H2XCduy9VkhmMCZRcshFXr19F5GbSnIyDwmZXHU
         Uxa4KKh5CbxT3axvSWRJamAlNDOjco1Jg8pp1wdu/qCntAYwFJkTj8bMyBbR1GRNGKtT
         7yl55yHGIaTwer2SXk2yoWSlM22RJXyPlUOS8HBLtj/KATGiPIR6znoQ38C91psPjKE2
         ff9RKfmO0bBz7vDLL3l6+bzxy5hXRDRvhHJmEJNuaXKkqhhnqbFuGwe0yJ8TedIlIz44
         kCqs5PccJKIRbaF0c3FIT91TUIWTPJ0V4BIou0EyXMeRqhmxFH2YgRgH+Q/nebgkb+ay
         HNuA==
X-Gm-Message-State: AOAM5301sAOIP6/jyUc0L4kqYpcVCb7kZrsuSQXmYkbY+gQZVDb/hX1P
        eVYl7MHleBPBMcU36x3yQBPcOA==
X-Google-Smtp-Source: ABdhPJw7H4cDbriWhAuoWmCrnYAmNuZrdWJghA25VKturF79Pb3Ge5nU5PTGydomwKHccAy6npDTAQ==
X-Received: by 2002:a05:6808:b08:: with SMTP id s8mr24691517oij.126.1638803193100;
        Mon, 06 Dec 2021 07:06:33 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y12sm2838923oiv.49.2021.12.06.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:06:32 -0800 (PST)
Date:   Mon, 6 Dec 2021 07:07:59 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: sdm845-db845c: Remove
 clock-lanes property from &camss node
Message-ID: <Ya4nTzE5DC096i9/@ripper>
References: <20211118124819.1902427-1-robert.foss@linaro.org>
 <20211118124819.1902427-5-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118124819.1902427-5-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18 Nov 04:48 PST 2021, Robert Foss wrote:

> The clock-lanes property is no longer used as it is not programmable by
> the CSIPHY hardware block of Qcom ISPs and should be removed.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 13f80a0b6faa..2cf4b932aee2 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -1125,7 +1125,6 @@ ports {
>  		port@0 {
>  			reg = <0>;
>  			csiphy0_ep: endpoint {
> -				clock-lanes = <7>;
>  				data-lanes = <0 1 2 3>;
>  				remote-endpoint = <&ov8856_ep>;
>  			};
> @@ -1166,7 +1165,6 @@ camera@10 {
>  
>  		port {
>  			ov8856_ep: endpoint {
> -				clock-lanes = <1>;
>  				link-frequencies = /bits/ 64
>  					<360000000 180000000>;
>  				data-lanes = <1 2 3 4>;
> @@ -1211,7 +1209,6 @@ camera@60 {
>  
>  		port {
>  			ov7251_ep: endpoint {
> -				clock-lanes = <1>;
>  				data-lanes = <0 1>;
>  //				remote-endpoint = <&csiphy3_ep>;
>  			};
> -- 
> 2.32.0
> 
