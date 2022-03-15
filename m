Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D94DA339
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351335AbiCOTYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbiCOTYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:24:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956902670;
        Tue, 15 Mar 2022 12:22:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a8so43671946ejc.8;
        Tue, 15 Mar 2022 12:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YUZLGSm75zNh7rcYmCCbe97E+affE9AzchNO0OWxx4o=;
        b=cCFx+shCgIVka6s5fOiT+wREmOnQNIvnqKe3Op2trhAh9UheCWIrFXkW+s4OGLFZg8
         3f/hmiwIx6xETfTpBaDhyvsp5e+la/BaRAVUo2Hkn6VhJXBpNLUZ/CebWTe5+I+2TArn
         ZoBmhqvS42Fi+0U9YGhV3OF6TPzuxEBnrZBiIsOD4DMGpr5lWzbl78BTF0XGGGVBuHvd
         Nfw9hlez1k1oCKSRv2Y4mmiL6RFdUgYbaZvJjwxwucRWtjNXJqOEnjyewIILyqKQzY8A
         ptO4vaPR/B9wl75cLXCpPreHkpJaVDgWAjbySHrWO/oP3/F6vfvVFzIh7iUTLmAPk1c+
         VoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YUZLGSm75zNh7rcYmCCbe97E+affE9AzchNO0OWxx4o=;
        b=uVoZgJiw66xsB0H5co4iUY5iBwPizMO75+iH2fTAEE2J6W1O6BXkBr2VMO+xplleiC
         oGsrW7+hTImUKDKeAhTuXPA/Zd6cctF7V/smE3Wu14TJhmS9nYfBIUPpzEKXewkYtm3n
         09hdItzGbEwS7A6zNWvBPxRUZ9Raf5uxswpa37gSwDCWtxLqmQynNZ8LsWKecd388Iah
         CHXf+0VVTOg9fvPhOqdvmQC475GVNRP+8IDqX1ooUQSRln4IxjYKOVnzwM7C7tncpDf4
         o96Hh5ecUKKMYooaaKurJ3BXBUBXfEWickTZ5s8G/PitImxeBEZohQHtri9jOIt1cUjm
         xktA==
X-Gm-Message-State: AOAM533gD3GLgdoUgq73da2LAQzgZHfIFq8meXdwHbIkXpZ9vn5YJ6dV
        XEkHQF2ycAioWPGld0qdVmooEVdBUtMvjg==
X-Google-Smtp-Source: ABdhPJx3oMQvDZcegvWM9E7xJZyXa9HzvY7rQWf3ct9h7oMvijJQwqMRKb2G2l22n3jGgUQYENCK5Q==
X-Received: by 2002:a17:906:52c7:b0:6ce:a880:50a3 with SMTP id w7-20020a17090652c700b006cea88050a3mr23528658ejn.437.1647372172743;
        Tue, 15 Mar 2022 12:22:52 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b00415a1f9a4dasm9918377edv.91.2022.03.15.12.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:22:52 -0700 (PDT)
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
Subject: Re: [PATCH v3 03/46] media: sun6i-csi: Grab bus clock instead of passing it to regmap
Date:   Tue, 15 Mar 2022 20:22:50 +0100
Message-ID: <2361247.jE0xQCEvom@kista>
In-Reply-To: <20220311143532.265091-4-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com> <20220311143532.265091-4-paul.kocialkowski@bootlin.com>
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

Hi Paul!

Dne petek, 11. marec 2022 ob 15:34:49 CET je Paul Kocialkowski napisal(a):
> Since the bus clock alone is not enough to get access to the registers,
> don't pass it to regmap and manage it instead just like the other
> clocks.
> 

Let me ask it in another way, is bus clock needed only for register access? If 
yes, it makes sense to keep it enabled only during register access.

Best regards,
Jernej

> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 10 ++++++++--
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h |  1 +
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/
media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index 5fbaa1e99412..dc79f3c14336 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -827,13 +827,19 @@ static int sun6i_csi_resource_request(struct 
sun6i_csi_device *csi_dev,
>  	if (IS_ERR(io_base))
>  		return PTR_ERR(io_base);
>  
> -	csi_dev->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus", 
io_base,
> -						    
&sun6i_csi_regmap_config);
> +	csi_dev->regmap = devm_regmap_init_mmio(&pdev->dev, io_base,
> +						
&sun6i_csi_regmap_config);
>  	if (IS_ERR(csi_dev->regmap)) {
>  		dev_err(&pdev->dev, "Failed to init register map\n");
>  		return PTR_ERR(csi_dev->regmap);
>  	}
>  
> +	csi_dev->clk_bus = devm_clk_get(&pdev->dev, "bus");
> +	if (IS_ERR(csi_dev->clk_bus)) {
> +		dev_err(&pdev->dev, "Unable to acquire bus clock\n");
> +		return PTR_ERR(csi_dev->clk_bus);
> +	}
> +
>  	csi_dev->clk_mod = devm_clk_get(&pdev->dev, "mod");
>  	if (IS_ERR(csi_dev->clk_mod)) {
>  		dev_err(&pdev->dev, "Unable to acquire csi clock\n");
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/
media/platform/sunxi/sun6i-csi/sun6i_csi.h
> index e4e7ac6c869f..356661b413f8 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> @@ -51,6 +51,7 @@ struct sun6i_csi_device {
>  	struct sun6i_video		video;
>  
>  	struct regmap			*regmap;
> +	struct clk			*clk_bus;
>  	struct clk			*clk_mod;
>  	struct clk			*clk_ram;
>  	struct reset_control		*reset;
> -- 
> 2.35.1
> 
> 


