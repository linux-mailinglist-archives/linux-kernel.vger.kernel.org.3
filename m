Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D4D4DA342
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351359AbiCOT2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiCOT2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:28:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF604C40C;
        Tue, 15 Mar 2022 12:27:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id yy13so43743544ejb.2;
        Tue, 15 Mar 2022 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3AyzWaFZRULv9IcF5V5hNAd0c4hd9W8uiPRsiJrx04=;
        b=Gi1Fqufb/YtSv2Jek0777ak0qYzQWn99w1ffk1/iCwA0ZUKSHYuOWYmjaPLp9kTYKt
         8YPt2ojzPPSft/6SFm94hW/2FwPBAHFFPZEOmfCMHH2TxAOv8hV+ud2hPr8piRvsKRUb
         cppWlxMGeXpuB/8UZT7N84GmeyPgLJKttEU99qfuDgqGpqNxfFNPW9AUQvRkUZynk3c1
         zetaSxZtKu/B2gmWNizI7gL6zXWfHXiUTE2HgUrnK5lKPaahdKxVWOoveWOSS85EDK4w
         H9O03q4dCJCHfxwvAwWdF4UIXwheqBHaYe+VwNjP+ErxVvPSevoyJvXIw+Wj6qMUvhDu
         ttoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3AyzWaFZRULv9IcF5V5hNAd0c4hd9W8uiPRsiJrx04=;
        b=r+Wz2HHWqQd+dstXjoFrA9X6lLdiu/e7ZuhR0EADXJSK1ubl0SeyXobcSzR/IDlEff
         15Q6UvcBP7xrkMpU+lLA3O5GS6z1sncs3GFqeXhAnjAeG+MqpguFt9ltxao29wuljLSB
         QZthxO0gYO7ngMVz2/OC2CQV1tOI3f94z5TrQDx8ybHThg8ni632mwysNq1J4W7PEcUC
         R6/KyrV3DuskcmuQg7T9fppWnv/jnN4h0Bm42YyiBGLgM2VaBjQCNkk//HSZFdEnR+rL
         irKWy+UTdxc9wCTGn62CvizPpQ2ozC52bPQ4FEJO2jIn5Q3btAjmwCKiv7+df5Uh/CZz
         9DsA==
X-Gm-Message-State: AOAM532EdTkJ52uhj0VGTB7BX9kxAQu7bEGVQdvN6paqdtyNWi+HbHWQ
        Z/GfwdK8Y1EcfddpqSyAmWDLS5TE/ocCYA==
X-Google-Smtp-Source: ABdhPJxpdCS3ExM+NJiBm4cT8iFlgpK/7HumnCZ73juniDL5IM4fOcaFPVCL76tYwQmLRW8ZevmGCw==
X-Received: by 2002:a17:907:7e96:b0:6da:f7ee:4a25 with SMTP id qb22-20020a1709077e9600b006daf7ee4a25mr24241525ejc.436.1647372442842;
        Tue, 15 Mar 2022 12:27:22 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id oz10-20020a1709077d8a00b006dd5103bac9sm1065690ejc.107.2022.03.15.12.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:27:22 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 05/46] media: sun6i-csi: Always set exclusive module clock rate
Date:   Tue, 15 Mar 2022 20:27:21 +0100
Message-ID: <823687335.0ifERbkFSE@kista>
In-Reply-To: <20220311143532.265091-6-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com> <20220311143532.265091-6-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 11. marec 2022 ob 15:34:51 CET je Paul Kocialkowski napisal(a):
> In some situations the default rate of the module clock is not the
> required one for operation (for example when reconfiguring the clock
> tree to use a different parent). As a result, always set the correct
> rate for the clock (and take care of cleanup).
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 54 ++++++++++++++-----
>  1 file changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/
media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index 8155e9560164..2355088fdc37 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -154,9 +154,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device 
*csi_dev, bool enable)
>  		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 
0);
>  
>  		clk_disable_unprepare(csi_dev->clk_ram);
> -		if (of_device_is_compatible(dev->of_node,
> -					    "allwinner,sun50i-
a64-csi"))
> -			clk_rate_exclusive_put(csi_dev->clk_mod);
>  		clk_disable_unprepare(csi_dev->clk_mod);
>  		reset_control_assert(csi_dev->reset);
>  		return 0;
> @@ -168,9 +165,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device 
*csi_dev, bool enable)
>  		return ret;
>  	}
>  
> -	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-
csi"))
> -		clk_set_rate_exclusive(csi_dev->clk_mod, 300000000);
> -
>  	ret = clk_prepare_enable(csi_dev->clk_ram);
>  	if (ret) {
>  		dev_err(csi_dev->dev, "Enable clk_dram_csi clk err 
%d\n", ret);
> @@ -190,8 +184,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device 
*csi_dev, bool enable)
>  clk_ram_disable:
>  	clk_disable_unprepare(csi_dev->clk_ram);
>  clk_mod_disable:
> -	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-
csi"))
> -		clk_rate_exclusive_put(csi_dev->clk_mod);
>  	clk_disable_unprepare(csi_dev->clk_mod);
>  	return ret;
>  }
> @@ -819,6 +811,7 @@ static int sun6i_csi_resources_setup(struct 
sun6i_csi_device *csi_dev,
>  				     struct platform_device 
*platform_dev)
>  {
>  	struct device *dev = csi_dev->dev;
> +	unsigned long clk_mod_rate;
>  	void __iomem *io_base;
>  	int ret;
>  	int irq;
> @@ -856,28 +849,53 @@ static int sun6i_csi_resources_setup(struct 
sun6i_csi_device *csi_dev,
>  		return PTR_ERR(csi_dev->clk_ram);
>  	}
>  
> +	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-
csi"))
> +		clk_mod_rate = 300000000;
> +	else
> +		clk_mod_rate = 297000000;
> +
> +	ret = clk_set_rate_exclusive(csi_dev->clk_mod, clk_mod_rate);
> +	if (ret) {
> +		dev_err(dev, "failed to set mod clock rate\n");
> +		return ret;
> +	}
> +
>  	/* Reset */
>  
>  	csi_dev->reset = devm_reset_control_get_shared(dev, NULL);
>  	if (IS_ERR(csi_dev->reset)) {
>  		dev_err(dev, "failed to acquire reset\n");
> -		return PTR_ERR(csi_dev->reset);
> +		ret = PTR_ERR(csi_dev->reset);
> +		goto error_clk_rate_exclusive;
>  	}
>  
>  	/* Interrupt */
>  
>  	irq = platform_get_irq(platform_dev, 0);
> -	if (irq < 0)
> -		return -ENXIO;
> +	if (irq < 0) {
> +		dev_err(dev, "failed to get interrupt\n");
> +		ret = -ENXIO;
> +		goto error_clk_rate_exclusive;
> +	}
>  
>  	ret = devm_request_irq(dev, irq, sun6i_csi_isr, 0, SUN6I_CSI_NAME,
>  			       csi_dev);
>  	if (ret) {
>  		dev_err(dev, "failed to request interrupt\n");
> -		return ret;
> +		goto error_clk_rate_exclusive;
>  	}
>  
>  	return 0;
> +
> +error_clk_rate_exclusive:
> +	clk_rate_exclusive_put(csi_dev->clk_mod);
> +
> +	return ret;
> +}
> +
> +static void sun6i_csi_resources_cleanup(struct sun6i_csi_device *csi_dev)
> +{
> +	clk_rate_exclusive_put(csi_dev->clk_mod);
>  }
>  
>  static int sun6i_csi_probe(struct platform_device *platform_dev)
> @@ -897,7 +915,16 @@ static int sun6i_csi_probe(struct platform_device 
*platform_dev)
>  	if (ret)
>  		return ret;
>  
> -	return sun6i_csi_v4l2_init(csi_dev);
> +	ret = sun6i_csi_v4l2_init(csi_dev);
> +	if (ret)
> +		goto error_resources;
> +
> +	return 0;
> +
> +error_resources:
> +	sun6i_csi_resources_cleanup(csi_dev);
> +
> +	return ret;
>  }
>  
>  static int sun6i_csi_remove(struct platform_device *pdev)
> @@ -905,6 +932,7 @@ static int sun6i_csi_remove(struct platform_device 
*pdev)
>  	struct sun6i_csi_device *csi_dev = platform_get_drvdata(pdev);
>  
>  	sun6i_csi_v4l2_cleanup(csi_dev);
> +	sun6i_csi_resources_cleanup(csi_dev);
>  
>  	return 0;
>  }
> -- 
> 2.35.1
> 
> 


