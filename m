Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5080051CF9F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388683AbiEFDhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388633AbiEFDhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:37:05 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5524364703
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:33:21 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-edf9ddb312so5158167fac.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IO0/vO4FJ1sTb7qZweTSIBe2tfCCOReYy49usyQ9Yho=;
        b=UDayjcrvBMd3DZhNplOehLV6npjyo4DG4Qxd9K5hcMRE1W0kV+UC6C1jqO//vdj2Zc
         +Bu9Nj+fYOfUGld6cA6+QESsVCvvAwPTMmBbYQRr5JroQ9gdc4UTDok7gUuiBbVoJWXd
         SG/9fGhyIqi2a63Fw4bWCwEEWJNeXOthRKpE61RRZaWmNLJ2cdLqBbxxc8tm0AQ1WiAC
         C5TUidsaSZXlHoX4/lVQyjbV7v+ks81814NTw+xLU/PRUX+KbS6CTkNCxQsO7jRMHpgE
         OZs9hVXB8GiwgHhvNzhyEEsYm2SM4Ama3XKb2VZbkncCWQWh4OjS2I6dqjx9pIgSaI9x
         NBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IO0/vO4FJ1sTb7qZweTSIBe2tfCCOReYy49usyQ9Yho=;
        b=lcBuZagr5s13ZDBkSMTvQXngwOy3yUsL5iroDLdgSnDsp7XJ4b04gjqnlDjNXMWSHs
         dEywqJtGC14HVfTpJKIwHaYLO3vqIPImBrz9V9fm39OKuhByC3ObP9Zm/f8pCb4c3NAp
         q6aI8hI0G7Bh2KxA1YZyWRdyDmorMECh+Zmtqx3plBneXKvHYy78GYmu/SZxoF+RqYW1
         2dxDgVGusHaUyRWir1FidEGINUvo3CIOW6NVZPpY/gHyKWdD7K5nvH9aezW1Wn+tnhol
         qU2biTH6id55OHTKL26RyrJEbv1RXJtUeIvjTMlhetHFun2CIKhb48z2rR19lluMTBP5
         tVnQ==
X-Gm-Message-State: AOAM531kRUWVXBiYS8Z0kYGdFkUNjR/tEK8j7G/jJeb2rrWWgWVfYYZw
        gRWlUZ6JCarBcFLIGETNYTlJPw==
X-Google-Smtp-Source: ABdhPJzVjBK4CW09O5H6maRjYHieeJlhHKNJrwljZxMeaxYgC21vui8itT8aOo+h3kAsq7sdI4jPMg==
X-Received: by 2002:a05:6870:708a:b0:e9:9349:9410 with SMTP id v10-20020a056870708a00b000e993499410mr3490249oae.265.1651808000619;
        Thu, 05 May 2022 20:33:20 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l21-20020a9d7095000000b0060603221263sm1233846otj.51.2022.05.05.20.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:33:20 -0700 (PDT)
Date:   Thu, 5 May 2022 22:33:14 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/7] clk: qcom: ipq8074: disable USB GDSC-s SW_COLLAPSE
Message-ID: <YnSW+mNgAp17e/YE@builder.lan>
References: <20220425182249.2753690-1-robimarko@gmail.com>
 <20220425182249.2753690-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425182249.2753690-2-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25 Apr 13:22 CDT 2022, Robert Marko wrote:

> Like in IPQ6018 Qualcomm intentionally disables the SW_COLLAPSE on the USB
> GDSC-s in the downstream 5.4 kernel.
> 
> This could potentially be better handled by utilizing the GDSC driver, but
> I am not familiar with it nor do I have datasheets.

Could you please give it a try before we pick this up?
Look at e.g. drivers/clk/qcom/gcc-sdm845.c how usb30_prim_gdsc and
usb30_sec_gdsc are defined, the offsets in specified in .gdscr should be
the same offsets you give below.

Then you specify an array of struct gdsc *, associating the two gdscs
you have specified to some identifier (USB30_PRIM_GDSC and
USB30_SEC_GDSC is used in sdm845) and reference this list as .gdscs and
num_gdscs in the gcc_ipq8074_desc.

The last part is to tie the USB controllers to the two GDSCs, this is
done by simply specifying:

	power-domains = <&gcc USB30_PRIM_GDSC>;

and USB30_SEC_GDSC, in the two USB nodes in DeviceTree. SW_COLLAPSE will
be toggled by the PM state of the USB driver, like it's done on e.g.
sdm845.

Regards,
Bjorn

> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq8074.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
> index 2ebd1462db78..65249a03a672 100644
> --- a/drivers/clk/qcom/gcc-ipq8074.c
> +++ b/drivers/clk/qcom/gcc-ipq8074.c
> @@ -4806,6 +4806,11 @@ static int gcc_ipq8074_probe(struct platform_device *pdev)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> +	/* Disable SW_COLLAPSE for USB0 GDSCR */
> +	regmap_update_bits(regmap, 0x3e078, BIT(0), 0x0);
> +	/* Disable SW_COLLAPSE for USB1 GDSCR */
> +	regmap_update_bits(regmap, 0x3f078, BIT(0), 0x0);
> +
>  	clk_alpha_pll_configure(&ubi32_pll_main, regmap, &ubi32_pll_config);
>  	clk_alpha_pll_configure(&nss_crypto_pll_main, regmap,
>  				&nss_crypto_pll_config);
> -- 
> 2.35.1
> 
