Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60142592C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiHOIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiHOIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:32:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB721FCE0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:32:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n4so8226515wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=EXcUj6FUGMW2MlOtvV9/2PElSz+xwYewruvcgvdHfEI=;
        b=E+a4ffEeT4ZE69D3v3rLDGnXGAvAneqQiKTSOUhWZoeEWxqK+CFjMXxsFy1IAn4Wtn
         rIMYWZmEb/mqrLK/nAOKnkiwLG8cJuGYE9bgjjoglIp02wsesEkBq3NLkntaNEbsu6jI
         3wbQhyMul1lUBDNcHVvf2GnFxeOsCbDcHmsbKL1nImj3KLg+ws4SnQir2K0k5Q5iDapf
         TUsSOjcoApfw48ane2ipyMEEPqwDAqS8HT35M5Y/k/ajpfz2OwWj+O1dnCPhSr/I8zIx
         CKW3+aNTiGK/AYKoYzE8Y3WO67ZprZa1uzjMiwZXB3zTnPxH9Az3AdYMFVbSkAx4j95W
         EOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=EXcUj6FUGMW2MlOtvV9/2PElSz+xwYewruvcgvdHfEI=;
        b=xGo/vsgdhpZL2UVhJtI4GsOzwzLR2A69dgYhyW3isHa0qrUFnwaz+iq8kpl8sivwCC
         jlKnqeyy07uXTOtvKkIXw5BsqcYVraq/gkipIRVNQqeL/bNWCrfD8Q1owsiVsLsjAtbx
         BfhfW1kWJG0Ha+kseXJcYH3ecgrV51aN21eKBk1yzFpmwr+RJHF88SJhIjRnTpx9L5Mj
         WBGJMSImrLYzVPn/LaZd7OuaW21vAhJEwN6o6E3gwWgbNNnBZq0/xlhtVOF3sEbW2aFz
         qfmHtghw8EY4n9strJntCw+Wa0j8ekmHjZVxLbv8SSjvFQQARBBCR5Chv4LauTX/LAQl
         b8zQ==
X-Gm-Message-State: ACgBeo1OM8tnHSGvLhG4L+n3lk45jm6pPk0lAodLHAqrjyqbWBjDzGr0
        klL/jYl/TvL+oBurCtj4DwoNlA==
X-Google-Smtp-Source: AA6agR6VhKLPX5i7Rn7Iy/3Orf0DZCRUMR3GZVnyS56g6AwGZI40CXBX8nlzjn+iA74ifxnIGCNYBg==
X-Received: by 2002:a05:6000:1092:b0:21f:13e7:3cc with SMTP id y18-20020a056000109200b0021f13e703ccmr8544750wrw.671.1660552374551;
        Mon, 15 Aug 2022 01:32:54 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id r187-20020a1c44c4000000b003a5f2cc2f1dsm4138540wma.42.2022.08.15.01.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 01:32:53 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:32:52 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] clk: imx: support fsl,protected-clocks
Message-ID: <YvoEtKd7GCL865C3@linaro.org>
References: <20220815033632.1687854-1-peng.fan@oss.nxp.com>
 <20220815033632.1687854-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815033632.1687854-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-15 11:36:32, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> For the clocks listed in fsl,protected-clocks, enable them to avoid
> Linux disable them. This will benifit root Linux and inmate cell run
> on top of Jailhouse hypervisor, and benifit AMP case.

Nitpick: s/benifit/benefit/

AMP?

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mm.c |  2 ++
>  drivers/clk/imx/clk-imx8mn.c |  2 ++
>  drivers/clk/imx/clk-imx8mp.c |  2 ++
>  drivers/clk/imx/clk-imx8mq.c |  2 ++
>  drivers/clk/imx/clk.c        | 21 +++++++++++++++++++++
>  drivers/clk/imx/clk.h        |  2 ++
>  6 files changed, 31 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index b6d275855b36..24ddb1620bce 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -611,6 +611,8 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
>  
>  	imx_register_uart_clocks(4);
>  
> +	imx_clk_protect(dev, hws);
> +
>  	return 0;
>  
>  unregister_hws:
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index d37c45b676ab..57c486317d28 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -604,6 +604,8 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  
>  	imx_register_uart_clocks(4);
>  
> +	imx_clk_protect(dev, hws);
> +
>  	return 0;
>  
>  unregister_hws:
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 652ae58c2735..a95862cc04a4 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -713,6 +713,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  
>  	imx_register_uart_clocks(4);
>  
> +	imx_clk_protect(dev, hws);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index 882dcad4817d..2868e2390667 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -603,6 +603,8 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
>  
>  	imx_register_uart_clocks(4);
>  
> +	imx_clk_protect(dev, hws);
> +
>  	return 0;
>  
>  unregister_hws:
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 5582f18dd632..307da8bd5243 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -2,6 +2,7 @@
>  #include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> +#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -214,4 +215,24 @@ static int __init imx_clk_disable_uart(void)
>  late_initcall_sync(imx_clk_disable_uart);
>  #endif
>  
> +int imx_clk_protect(struct device *dev, struct clk_hw * const clks[])
> +{
> +	struct device_node *np = dev->of_node;
> +	struct property *prop;
> +	const __be32 *p;
> +	u32 i;
> +	int ret;
> +
> +	of_property_for_each_u32(np, "fsl,protected-clocks", prop, p, i) {
> +		ret = clk_prepare_enable(clks[i]->clk);

I might be wrong here, but wouldn't CLK_IGNORE_UNUSED have the same effect?

I don't think we should circumvent that by adding vendor specific dts properties.

> +		if (ret) {
> +			dev_err(dev, "failed to enable %s\n", clk_hw_get_name(clks[i]));
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(imx_clk_protect);
> +
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index dd49f90110e8..3f8099190b99 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -22,6 +22,8 @@ void imx_mmdc_mask_handshake(void __iomem *ccm_base, unsigned int chn);
>  void imx_unregister_clocks(struct clk *clks[], unsigned int count);
>  void imx_unregister_hw_clocks(struct clk_hw *hws[], unsigned int count);
>  
> +int imx_clk_protect(struct device *dev, struct clk_hw * const clks[]);
> +
>  extern void imx_cscmr1_fixup(u32 *val);
>  
>  enum imx_pllv1_type {
> -- 
> 2.37.1
> 
