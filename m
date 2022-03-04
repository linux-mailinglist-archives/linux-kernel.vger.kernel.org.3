Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCE34CD70C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbiCDPDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbiCDPCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:02:50 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1D71BD9B2;
        Fri,  4 Mar 2022 07:02:01 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id p4so11141384edi.1;
        Fri, 04 Mar 2022 07:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GU8UB6TON4VenNNLOM6Y8KYCnXRjIdD5gZ9A5OMk8Fk=;
        b=If/0zGbiuK3yY47gqLG0585NAxBoPdu39NK737vawufjZ239O5wd1D6cDSd9lKNOg2
         7Y24wNvwo/CMM9rBs6FPjoq+rp6mOdMRExj4l2EKDdtKoP1P56MmFedB1XVykKE3GrNZ
         9vHOyVBQzZJNrgyTMGdt8gxuGmtpnEVGKOragTRZdAUatZCs+78gV75urVEEii5LXlz2
         Q+S091bTDyfrhl3boEeJ4A667JYijoN3u1Ndps4cYQ/xCpPJa76XFiMWer2umxTYskVa
         9U+XtIFkd+qAokpcrpcWXlTMvcBFJ7TRAxVzeTCX4+POPoXpllPCHSgOZfpFkBkvn27n
         yEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GU8UB6TON4VenNNLOM6Y8KYCnXRjIdD5gZ9A5OMk8Fk=;
        b=WfksxAaJ7pkBMHyLwJyRQQrKCAa/Rtg1xw/Ld+k28K88lqOptGQ1b8OOMJ0pfLI9XY
         HSZmTiPq/SUXhK2L8u5RrOKqC43udcB0Q8wbr3aCnFFuj6kPpQ28HbmfiyizbEFrVKJQ
         jGCOlmnXz4kbpa7CIKWEZLsAi3zDwBoTyZIQYbeNx5Puh/LXA/Q1aDbbCn6uWCpvKKNw
         ne7waGMavdtY0Qfhm1KrRt921fHpGUQwxNTyIozzGdeJcidokrmWC3jAcRGvvn1qrJdH
         lHbqIKJLuRIEHpm6dtl1l18wy3Fe6gBv+VCxJAD1F1VEBY6PIHT+wpNEHuQhytDr3cLy
         Mt/Q==
X-Gm-Message-State: AOAM532uyrjVfbNmyja+l2yeeMMh50xS3RFVJrkN6n2Mif07hRM8XpXi
        Y5S5vkD5qaXuK0XTD7X/C3I=
X-Google-Smtp-Source: ABdhPJwbeg+zMrY7HvyZLfPCoywd61S1zgix/OQC8hvmSEFI8VN2hn1c66x0LTx0Yi88SvTVQPFpBw==
X-Received: by 2002:a05:6402:3487:b0:40f:fa53:956c with SMTP id v7-20020a056402348700b0040ffa53956cmr39023279edc.22.1646406120238;
        Fri, 04 Mar 2022 07:02:00 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l19-20020a056402255300b00415f526c6b0sm1084798edb.30.2022.03.04.07.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 07:01:59 -0800 (PST)
Message-ID: <064626ad-129e-c7eb-5e08-12d93cffa993@gmail.com>
Date:   Fri, 4 Mar 2022 16:01:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 11/18] crypto: rockhip: do not handle dma clock
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, john@metanate.com
References: <20220302211113.4003816-1-clabbe@baylibre.com>
 <20220302211113.4003816-12-clabbe@baylibre.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220302211113.4003816-12-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

Make your clock driver parsing portable.

===
    oneOf:
      - const: rockchip,rk3288-crypto
      - items:
          - enum:
              - rockchip,rk3328-crypto
          - const: rockchip,rk3288-crypto

Compatible string must be SoC related!

rk3288 was the first in line that had support, so we use that as fall
back string.

===

Make binding fit for more SoC types.
Allow more clocks by using devm_clk_bulk_get_all.
Drop reset-names requirement for devm_reset_control_array_get_exclusive.

===

Use a patch order to prevent the scripts generate notifications.

- dt-bindings conversion

- add rk3328 compatible string in a separate patch

- your driver changes

- dts patches

A proposed maintainer must be able to submit patch series without errors. ;)

===

When you remove a clock in a YAML conversion you must add a note to the
DT maintainer.

===

Johan

On 3/2/22 22:11, Corentin Labbe wrote:
> The DMA clock is handled by the DMA controller, so the crypto does not
> have to touch it.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/rockchip/rk3288_crypto.c | 16 +---------------
>  drivers/crypto/rockchip/rk3288_crypto.h |  1 -
>  2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
> index 94ef1283789f..645855d2651b 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto.c
> @@ -40,15 +40,8 @@ static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
>  			__func__, __LINE__);
>  		goto err_hclk;
>  	}
> -	err = clk_prepare_enable(dev->dmaclk);
> -	if (err) {
> -		dev_err(dev->dev, "[%s:%d], Couldn't enable clock dmaclk\n",
> -			__func__, __LINE__);
> -		goto err_dmaclk;
> -	}
> +
>  	return err;
> -err_dmaclk:
> -	clk_disable_unprepare(dev->hclk);
>  err_hclk:
>  	clk_disable_unprepare(dev->aclk);
>  err_aclk:
> @@ -59,7 +52,6 @@ static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
>  
>  static void rk_crypto_disable_clk(struct rk_crypto_info *dev)
>  {
> -	clk_disable_unprepare(dev->dmaclk);
>  	clk_disable_unprepare(dev->hclk);
>  	clk_disable_unprepare(dev->aclk);
>  	clk_disable_unprepare(dev->sclk);
> @@ -199,12 +191,6 @@ static int rk_crypto_probe(struct platform_device *pdev)
>  		goto err_crypto;
>  	}
>  

> -	crypto_info->dmaclk = devm_clk_get(&pdev->dev, "apb_pclk");
> -	if (IS_ERR(crypto_info->dmaclk)) {
> -		err = PTR_ERR(crypto_info->dmaclk);
> -		goto err_crypto;
> -	}
> -

rk3288:
 		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
-			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
-		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
+			 <&cru SCLK_CRYPTO>;
+		clock-names = "aclk", "hclk", "sclk";


rk3328:
+		clocks = <&cru HCLK_CRYPTO_MST>, <&cru HCLK_CRYPTO_SLV>,
+			 <&cru SCLK_CRYPTO>;
+		clock-names = "aclk", "hclk", "sclk";

The HCLK_CRYPTO_MST not is related to ACLK_CRYPTO.
You are reusing rk3288 names to not to change the driver.
Give it an other name.

===

The sclk goes through a crypto_div_con.
Does that need a frequency set?
Or does that come from nowhere?

From crypto_v1.c
	priv->frequency = dev_read_u32_default(dev, "clock-frequency",
					       CRYPTO_V1_DEFAULT_RATE);

	ret = clk_set_rate(&priv->sclk, priv->frequency);

===

Could you make this portable?
Example:

	int i;

	priv->num_clks = devm_clk_bulk_get_all(dev, &priv->clks);
	if (priv->num_clks < 1)
		return -EINVAL;

	priv->sclk = NULL;
	for (i = 0; i < priv->num_clks; i++) {
		if (!strncmp(priv->clks[i].id, "sclk", 3)) {
			priv->sclk = priv->clks[i].clk;
			break;
		}
	}

	if (!priv->sclk) {
		dev_err(dev, "no sclk found\n");
		return -EINVAL;
	}

Also add optional "sclk1" clock for rk3399.
Use "sclk" and not "sclk0" to be backwards compatible.

===

Also make the resets portable for rk3399.
Remove the requirement for "reset-names".

Example:
	priv->phy_rst = devm_reset_control_array_get_exclusive(dev);
	if (IS_ERR(priv->phy_rst))
		return dev_err_probe(dev, PTR_ERR(priv->phy_rst), "failed to get phy
reset\n");



>  	crypto_info->irq = platform_get_irq(pdev, 0);
>  	if (crypto_info->irq < 0) {
>  		dev_err(&pdev->dev, "control Interrupt is not available.\n");
> diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
> index c741e97057dc..963fbfc4d14e 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto.h
> +++ b/drivers/crypto/rockchip/rk3288_crypto.h
> @@ -191,7 +191,6 @@ struct rk_crypto_info {

>  	struct clk			*aclk;
>  	struct clk			*hclk;
>  	struct clk			*sclk;
> -	struct clk			*dmaclk;


	int num_clks;
	struct clk_bulk_data *clks;
	struct clk *sclk;
	struct clk *sclk1;


>  	struct reset_control		*rst;
>  	void __iomem			*reg;
>  	int				irq;
