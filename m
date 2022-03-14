Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A448C4D8F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245607AbiCNW2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiCNW2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:28:51 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BCE3DDF8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:27:41 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id q1-20020a4a7d41000000b003211b63eb7bso22135525ooe.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lpISCI/Ldp2ZkDjSdXy+XxHBdMq+2i8M+iR+Wj/TmxI=;
        b=FSWP4VZ/rSXb9qrV1Oeet9ZEJaCd66it/y7godMtyQLOuMqXFPz8nhmIAUjynsGqsj
         xMQ16ip563mQMttvihWIpDXyM+IHlqy0Hu3CGr76bXYXMXevfI5IzcwSVwnTjsDG/T8p
         6ZqJ0IMMvBkY99NkHpyEG5p7DFJaDjno2AmvEaIMJOR05LosC6ISrOy4FIoXDVw96Sni
         PpJuNLBa0MxRifeceQQoXPPxQ2b/n4vLqmHIJ8n9/AS2nue0G0GUZ+5dz6lSQEj39eaZ
         tfCkx7Y0u60ZnMeT8ydGHUSqmumMJEfoIczQMH9R3Fuj1722cTgCiIlz4ZEO33XOMUhu
         VHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lpISCI/Ldp2ZkDjSdXy+XxHBdMq+2i8M+iR+Wj/TmxI=;
        b=tJxKJuBkb/ed0vkSnpQEN7Nj/m8P6icmoKaKKSbFCERZS0LDJl9A2/YazmgwyAtMDo
         6OvfS8MioeXArleD9qw3CDI9NpNGmU+tbicpQi1Yipz4yhaprV+C1zHL+/RJq/a76VIL
         45T6N/pf4jwmGPjm9Tizn1dXMa1OmlEqq9QeRClBAJZOTtAWYcqgvrHEgGmCHvJ6Gfmd
         f7RhS/YKF+7U4DoFnQtxv32zLaQFbnSn6BAaPwNsgbIh/Mr4THqK6Fd3JKivk28if7fF
         JukXCxTUd4br1dh53AOxPBDWKgmajhm/xU4CtnTGHR+RBEQuC8ZSIGi6FiTQAi8PWR5g
         HdSA==
X-Gm-Message-State: AOAM531X4s00RyOkeGbgjybOzgTwZA9y28sWi+bqrAWE/696YgChdzM7
        3JjT4k0xorum6757r280TYUU9Q==
X-Google-Smtp-Source: ABdhPJxmeIMIwdljPYgEiOpLwwF50yShXUo59tqn9r0ZE1A2Pyb2elUZbs81pJLhj0EN+3dSb5i+Ng==
X-Received: by 2002:a4a:d747:0:b0:320:d7c2:4357 with SMTP id h7-20020a4ad747000000b00320d7c24357mr10664075oot.92.1647296860481;
        Mon, 14 Mar 2022 15:27:40 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id ay39-20020a056820152700b003209eddff85sm7905003oob.45.2022.03.14.15.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 15:27:39 -0700 (PDT)
Date:   Mon, 14 Mar 2022 17:27:37 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     ohad@wizery.com, mathieu.poirier@linaro.org, robh+dt@kernel.or,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, khilman@baylibre.com,
        Julien STEPHAN <jstephan@baylibre.com>
Subject: Re: [PATCH v4 5/7] remoteproc: mtk_apu: Use match_data
Message-ID: <Yi/BWTRGu5sbpw7S@builder.lan>
References: <20220304161514.994128-1-abailon@baylibre.com>
 <20220304161514.994128-6-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304161514.994128-6-abailon@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 Mar 10:15 CST 2022, Alexandre Bailon wrote:

> From: Julien STEPHAN <jstephan@baylibre.com>
> 
> This commits prepare the driver to be more generic in order to support
> multiple platform using the compatible property.
> To do that, put some register values and the clocks names inside
> private data.
> 
> Signed-off-by: Julien STEPHAN <jstephan@baylibre.com>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/remoteproc/mtk_apu.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_apu.c b/drivers/remoteproc/mtk_apu.c
> index 3905eb5b7174..deec51b86ba5 100644
> --- a/drivers/remoteproc/mtk_apu.c
> +++ b/drivers/remoteproc/mtk_apu.c
> @@ -58,12 +58,20 @@
>  
>  #define APU_RESET_DELAY				(27)
>  
> +struct mtk_apu_conf {
> +	u32 core_default0;
> +	u32 core_default1;
> +	u32 num_clks;
> +	const char * const *clk_names;
> +};
> +
>  struct mtk_apu_rproc {
>  	struct device *dev;
>  	void __iomem *base;
>  	int irq;
>  	unsigned int num_clks;
>  	struct clk_bulk_data *clks;
> +	struct mtk_apu_conf *conf;
>  	struct iommu_domain *domain;
>  	struct list_head mappings;
>  
> @@ -81,6 +89,13 @@ static const char * const mt8183_clk_names[] = {
>  	"jtag"
>  };
>  
> +static const struct mtk_apu_conf mt8183_conf = {
> +	.core_default0 = (0x10 << 23) | (0x10 << 18),

CORE_DEFAULT0_AWUSER_USE_IOMMU | CORE_DEFAULT0_ARUSER_USE_IOMMU ?

> +	.core_default1 = (0x10 << 0) | (0x10 << 5),

CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU | CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU ?

Regards,
Bjorn

> +	.num_clks = ARRAY_SIZE(mt8183_clk_names),
> +	.clk_names = mt8183_clk_names
> +};
> +
>  static int mtk_apu_iommu_map(struct rproc *rproc, struct rproc_mem_entry *entry)
>  {
>  	struct mtk_apu_rproc *apu_rproc = rproc->priv;
> @@ -289,10 +304,9 @@ static int mtk_apu_rproc_start(struct rproc *rproc)
>  	writel(core_ctrl, apu_rproc->base + CORE_CTRL);
>  
>  	/* Configure memory accesses to go through the IOMMU */
> -	writel(CORE_DEFAULT0_AWUSER_USE_IOMMU | CORE_DEFAULT0_ARUSER_USE_IOMMU |
> -	      CORE_DEFAULT0_QOS_SWAP_1, apu_rproc->base + CORE_DEFAULT0);
> -	writel(CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU |
> -		CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU,
> +	writel(apu_rproc->conf->core_default0 | CORE_DEFAULT0_QOS_SWAP_1,
> +		apu_rproc->base + CORE_DEFAULT0);
> +	writel(apu_rproc->conf->core_default1,
>  		apu_rproc->base + CORE_DEFAULT1);
>  
>  	/* Release the APU */
> @@ -565,11 +579,18 @@ static int mtk_apu_rproc_probe(struct platform_device *pdev)
>  		goto free_rproc;
>  	}
>  
> -	apu_rproc->num_clks = ARRAY_SIZE(mt8183_clk_names);
> +
> +	apu_rproc->conf = (struct mtk_apu_conf *)device_get_match_data(dev);
> +	if (!apu_rproc->conf) {
> +		ret = -ENODEV;
> +		goto free_rproc;
> +	}
> +
> +	apu_rproc->num_clks = apu_rproc->conf->num_clks;
>  	apu_rproc->clks = devm_kcalloc(dev, apu_rproc->num_clks,
>  				     sizeof(*apu_rproc->clks), GFP_KERNEL);
>  	for (i = 0; i < apu_rproc->num_clks; ++i)
> -		apu_rproc->clks[i].id = mt8183_clk_names[i];
> +		apu_rproc->clks[i].id = apu_rproc->conf->clk_names[i];
>  
>  	ret = devm_clk_bulk_get(dev, apu_rproc->num_clks, apu_rproc->clks);
>  	if (ret) {
> @@ -611,7 +632,7 @@ static int mtk_apu_rproc_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id mtk_apu_rproc_of_match[] = {
> -	{ .compatible = "mediatek,mt8183-apu", },
> +	{ .compatible = "mediatek,mt8183-apu", .data = &mt8183_conf },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, mtk_apu_rproc_of_match);
> -- 
> 2.34.1
> 
