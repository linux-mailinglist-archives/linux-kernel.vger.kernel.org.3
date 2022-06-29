Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954E3560447
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiF2PPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiF2PPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:15:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99779B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:15:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1o6ZP7-0004Rg-4n; Wed, 29 Jun 2022 17:14:57 +0200
Message-ID: <4fb9c1b77507b3691f95b55afe053137dd022b29.camel@pengutronix.de>
Subject: Re: [PATCH V2 8/9] interconnect: imx: configure NoC
 mode/prioriry/ext_control
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abel.vesa@nxp.com, abailon@baylibre.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Date:   Wed, 29 Jun 2022 17:14:55 +0200
In-Reply-To: <20220616073320.2203000-9-peng.fan@oss.nxp.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
         <20220616073320.2203000-9-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 16.06.2022 um 15:33 +0800 schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
> 
> Introduce imx_icc_noc_setting structure to describe a master port setting
> Pass imx_icc_noc_setting as a parameter from specific driver
> Set priority level, mode, ext control in imx_icc_node_set
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/interconnect/imx/imx.c    | 43 ++++++++++++++++++++++++++----
>  drivers/interconnect/imx/imx.h    | 44 ++++++++++++++++++++++++++++++-
>  drivers/interconnect/imx/imx8mm.c |  2 +-
>  drivers/interconnect/imx/imx8mn.c |  2 +-
>  drivers/interconnect/imx/imx8mq.c |  2 +-
>  5 files changed, 84 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
> index 78557fe6da2c..bd728caf2b85 100644
> --- a/drivers/interconnect/imx/imx.c
> +++ b/drivers/interconnect/imx/imx.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/device.h>
>  #include <linux/interconnect-provider.h>
> +#include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> @@ -21,8 +22,10 @@
>  /* private icc_node data */
>  struct imx_icc_node {
>  	const struct imx_icc_node_desc *desc;
> +	const struct imx_icc_noc_setting *setting;
>  	struct device *qos_dev;
>  	struct dev_pm_qos_request qos_req;
> +	struct imx_icc_provider *imx_provider;
>  };
>  
>  static int imx_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> @@ -37,8 +40,24 @@ static int imx_icc_node_set(struct icc_node *node)
>  {
>  	struct device *dev = node->provider->dev;
>  	struct imx_icc_node *node_data = node->data;
> +	void __iomem *base;
> +	u32 prio;
>  	u64 freq;
>  
> +	if (node_data->setting && !node_data->setting->ignore && node->peak_bw) {
> +		base = node_data->setting->reg + node_data->imx_provider->noc_base;
> +		if (node_data->setting->mode == IMX_NOC_MODE_FIXED) {
> +			prio = node_data->setting->prio_level;
> +			prio = PRIORITY_COMP_MARK | (prio << 8) | prio;
> +			writel(prio, base + IMX_NOC_PRIO_REG);
> +			writel(node_data->setting->mode, base + IMX_NOC_MODE_REG);
> +			writel(node_data->setting->ext_control, base + IMX_NOC_EXT_CTL_REG);
> +		} else {
> +			dev_info(dev, "mode: %d not supported\n", node_data->setting->mode);
> +			return -ENOTSUPP;
> +		}
> +	}
> +
>  	if (!node_data->qos_dev)
>  		return 0;
>  
> @@ -135,7 +154,8 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
>  }
>  
>  static struct icc_node *imx_icc_node_add(struct imx_icc_provider *imx_provider,
> -					 const struct imx_icc_node_desc *node_desc)
> +					 const struct imx_icc_node_desc *node_desc,
> +					 const struct imx_icc_noc_setting *setting)
>  {
>  	struct icc_provider *provider = &imx_provider->provider;
>  	struct device *dev = provider->dev;
> @@ -164,6 +184,8 @@ static struct icc_node *imx_icc_node_add(struct imx_icc_provider *imx_provider,
>  	node->name = node_desc->name;
>  	node->data = node_data;
>  	node_data->desc = node_desc;
> +	node_data->setting = setting;
> +	node_data->imx_provider = imx_provider;
>  	icc_node_add(node, provider);
>  
>  	if (node_desc->adj) {
> @@ -187,7 +209,8 @@ static void imx_icc_unregister_nodes(struct icc_provider *provider)
>  
>  static int imx_icc_register_nodes(struct imx_icc_provider *imx_provider,
>  				  const struct imx_icc_node_desc *descs,
> -				  int count)
> +				  int count,
> +				  const struct imx_icc_noc_setting *settings)
>  {
>  	struct icc_provider *provider = &imx_provider->provider;
>  	struct icc_onecell_data *provider_data = provider->data;
> @@ -199,7 +222,10 @@ static int imx_icc_register_nodes(struct imx_icc_provider *imx_provider,
>  		const struct imx_icc_node_desc *node_desc = &descs[i];
>  		size_t j;
>  
> -		node = imx_icc_node_add(imx_provider, node_desc);
> +		if (settings)
> +			node = imx_icc_node_add(imx_provider, node_desc, &settings[node_desc->id]);
> +		else
> +			node = imx_icc_node_add(imx_provider, node_desc, NULL);

Maybe just write as
node = imx_icc_node_add(imx_provider, node_desc, settings ? &settings[node_desc->id] : NULL);

But I don't really care, so feel free to ignore this suggestion if you
don't like it.

>  		if (IS_ERR(node)) {
>  			ret = dev_err_probe(provider->dev,
> PTR_ERR(node),
>  					    "failed to add %s\n",
> node_desc->name);
> @@ -237,7 +263,8 @@ static int get_max_node_id(struct
> imx_icc_node_desc *nodes, int nodes_count)
>  }
>  
>  int imx_icc_register(struct platform_device *pdev,
> -		     struct imx_icc_node_desc *nodes, int
> nodes_count)
> +		     struct imx_icc_node_desc *nodes, int
> nodes_count,
> +		     struct imx_icc_noc_setting *settings)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct icc_onecell_data *data;
> @@ -267,13 +294,19 @@ int imx_icc_register(struct platform_device
> *pdev,
>  	provider->dev->of_node = dev->parent->of_node;
>  	platform_set_drvdata(pdev, imx_provider);
>  
> +	if (settings) {
> +		imx_provider->noc_base = devm_of_iomap(dev,
> provider->dev->of_node, 0, NULL);
> +		if (!imx_provider->noc_base)
> +			return PTR_ERR(imx_provider->noc_base);
> +	}
> +
>  	ret = icc_provider_add(provider);
>  	if (ret) {
>  		dev_err(dev, "error adding interconnect provider:
> %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = imx_icc_register_nodes(imx_provider, nodes,
> nodes_count);
> +	ret = imx_icc_register_nodes(imx_provider, nodes,
> nodes_count, settings);
>  	if (ret)
>  		goto provider_del;
>  
> diff --git a/drivers/interconnect/imx/imx.h
> b/drivers/interconnect/imx/imx.h
> index 0ad2c654c222..1da87cfe27da 100644
> --- a/drivers/interconnect/imx/imx.h
> +++ b/drivers/interconnect/imx/imx.h
> @@ -15,6 +15,31 @@
>  
>  #define IMX_ICC_MAX_LINKS	4
>  
> +/*
> + * High throughput priority level in Regulator mode
> + * Read Priority in Fixed/Limiter mode
> + */
> +#define PRIORITY0_SHIFT	0
> +/*
> + * Low throughput priority level in Regulator mode
> + * Write Priority in Fixed/Limiter mode
> + */
> +#define PRIORITY1_SHIFT	8
> +#define PRIORITY_MASK		0x7
> +
> +#define PRIORITY_COMP_MARK	BIT(31)	/* Must set */
> +
> +#define IMX_NOC_MODE_FIXED	0
> +#define IMX_NOC_MODE_LIMITER	1
> +#define IMX_NOC_MODE_BYPASS	2
> +#define IMX_NOC_MODE_REGULATOR	3
> +
> +#define IMX_NOC_PRIO_REG	0x8
> +#define IMX_NOC_MODE_REG	0xC
> +#define IMX_NOC_BANDWIDTH_REG	0x10
> +#define IMX_NOC_SATURATION	0x14
> +#define IMX_NOC_EXT_CTL_REG	0x18
> +
>  struct imx_icc_provider {
>  	void __iomem *noc_base;
>  	struct icc_provider provider;
> @@ -44,6 +69,22 @@ struct imx_icc_node_desc {
>  	const struct imx_icc_node_adj_desc *adj;
>  };
>  
> +/*
> + * struct imx_icc_noc_setting - Describe an interconnect node
> setting
> + * @ignore: indicate whether need apply this setting
> + * @reg: register offset inside the NoC
> + * @prio_level: priority level
> + * @mode: functional mode
> + * @ext_control: external input control
> + */
> +struct imx_icc_noc_setting {
> +	bool ignore;

I don't like this ignore member. Can we get rid of this and make the
"don't touch" a special mode, like IMX_NOC_MODE_UNCONFIGURED?

Other than those two nitpicks, the patch looks good.

Regards,
Lucas

> +	u32 reg;
> +	u32 prio_level;
> +	u32 mode;
> +	u32 ext_control;
> +};
> +
>  #define DEFINE_BUS_INTERCONNECT(_name, _id, _adj, ...)			\
>  	{								\
>  		.id = _id,						\
> @@ -61,7 +102,8 @@ struct imx_icc_node_desc {
>  
>  int imx_icc_register(struct platform_device *pdev,
>  		     struct imx_icc_node_desc *nodes,
> -		     int nodes_count);
> +		     int nodes_count,
> +		     struct imx_icc_noc_setting *noc_settings);
>  int imx_icc_unregister(struct platform_device *pdev);
>  
>  #endif /* __DRIVERS_INTERCONNECT_IMX_H */
> diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/imx/imx8mm.c
> index 1083490bb391..ae797412db96 100644
> --- a/drivers/interconnect/imx/imx8mm.c
> +++ b/drivers/interconnect/imx/imx8mm.c
> @@ -83,7 +83,7 @@ static struct imx_icc_node_desc nodes[] = {
>  
>  static int imx8mm_icc_probe(struct platform_device *pdev)
>  {
> -	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));
> +	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), NULL);
>  }
>  
>  static int imx8mm_icc_remove(struct platform_device *pdev)
> diff --git a/drivers/interconnect/imx/imx8mn.c b/drivers/interconnect/imx/imx8mn.c
> index ad97e55fd4e5..1ce94c5bdd8c 100644
> --- a/drivers/interconnect/imx/imx8mn.c
> +++ b/drivers/interconnect/imx/imx8mn.c
> @@ -72,7 +72,7 @@ static struct imx_icc_node_desc nodes[] = {
>  
>  static int imx8mn_icc_probe(struct platform_device *pdev)
>  {
> -	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));
> +	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), NULL);
>  }
>  
>  static int imx8mn_icc_remove(struct platform_device *pdev)
> diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
> index d7768d3c6d8a..7f00a0511c6e 100644
> --- a/drivers/interconnect/imx/imx8mq.c
> +++ b/drivers/interconnect/imx/imx8mq.c
> @@ -82,7 +82,7 @@ static struct imx_icc_node_desc nodes[] = {
>  
>  static int imx8mq_icc_probe(struct platform_device *pdev)
>  {
> -	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes));
> +	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), NULL);
>  }
>  
>  static int imx8mq_icc_remove(struct platform_device *pdev)


