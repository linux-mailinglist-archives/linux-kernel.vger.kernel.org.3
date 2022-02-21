Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6964BD722
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346123AbiBUH0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:26:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346002AbiBUH0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:26:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C23F10E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:25:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCD67B80E7F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6717C340E9;
        Mon, 21 Feb 2022 07:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645428335;
        bh=7/NC1xoSn2cRSrz7qbAfefLKb8z7Tnor6hUpbas1J3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwkcXeqwol4SIfZZqF4IRPm8BVQKP21boQ5Fs9waybCA8zRWepcm05u1HISpJrO/5
         mfV+L84aFwN8Fi/zGDBOE4HC8wg5Cg/chiAAzlLJP8QFbg5PY4VI67FSQbPt6B5/0N
         BtYYJN63WzgGZr3mD6tCid2wR0GlGcnSAR3B/EP+4t/VQFr8dd0pHx2g7bWqlufcws
         8R//icZzI4mnz+Bjhq5e9Lnntfo8yyzZMY7om7dcpWhusOdFLVPUxPxXJ9PG6ZWsGQ
         izBiYnYh3nwhPXu/9+0REDkuhA3ACVsoJiGxUwzbByhweApLDAR8Qbevw536KOXr1Z
         yiZLPpEVqzyug==
Date:   Mon, 21 Feb 2022 15:25:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH] bus: imx-weim: add DT overlay support for WEIM bus
Message-ID: <20220221072529.GP2249@dragon>
References: <20220205055006.23447-1-i.bornyakov@metrotek.ru>
 <20220205055006.23447-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205055006.23447-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 08:50:06AM +0300, Ivan Bornyakov wrote:
> Add OF reconfiguration notifier handler for WEIM bus to setup Chip
> Select timings on runtime creation of child devices.
> 
> However, it is not possible to load another DT overlay with conflicting
> CS timings with previously loaded overlay, even if the first one is
> unloaded.

Are we doing anything if that happens?

> The reason is that there is no acces to CS timing property of
> a device node being removed, thus we can't track which of configured CS
> are available for re-configuration.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/bus/imx-weim.c | 136 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 127 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index bccb275b65ba..a09e1d33a554 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -64,6 +64,11 @@ struct cs_timing_state {
>  	struct cs_timing cs[MAX_CS_COUNT];
>  };
>  
> +struct weim_data {
> +	void __iomem *base;
> +	struct cs_timing_state timing_state;
> +};
> +
>  static const struct of_device_id weim_id_table[] = {
>  	/* i.MX1/21 */
>  	{ .compatible = "fsl,imx1-weim", .data = &imx1_weim_devtype, },
> @@ -128,21 +133,26 @@ static int imx_weim_gpr_setup(struct platform_device *pdev)
>  }
>  
>  /* Parse and set the timing for this device. */
> -static int weim_timing_setup(struct device *dev,
> -			     struct device_node *np, void __iomem *base,
> -			     const struct imx_weim_devtype *devtype,
> -			     struct cs_timing_state *ts)
> +static int weim_timing_setup(struct device *dev, struct device_node *np,
> +			     const struct imx_weim_devtype *devtype)
>  {
>  	u32 cs_idx, value[MAX_CS_REGS_COUNT];
>  	int i, ret;
>  	int reg_idx, num_regs;
>  	struct cs_timing *cst;
> +	struct weim_data *priv;

Maybe we should name the struct weim_priv?

> +	struct cs_timing_state *ts;
> +	void __iomem *base;
>  
>  	if (WARN_ON(devtype->cs_regs_count > MAX_CS_REGS_COUNT))
>  		return -EINVAL;
>  	if (WARN_ON(devtype->cs_count > MAX_CS_COUNT))
>  		return -EINVAL;
>  
> +	priv = dev_get_drvdata(dev);
> +	base = priv->base;
> +	ts = &priv->timing_state;
> +
>  	ret = of_property_read_u32_array(np, "fsl,weim-cs-timing",
>  					 value, devtype->cs_regs_count);
>  	if (ret)
> @@ -189,14 +199,15 @@ static int weim_timing_setup(struct device *dev,
>  	return 0;
>  }
>  
> -static int weim_parse_dt(struct platform_device *pdev, void __iomem *base)
> +static int weim_parse_dt(struct platform_device *pdev)
>  {
>  	const struct of_device_id *of_id = of_match_device(weim_id_table,
>  							   &pdev->dev);
>  	const struct imx_weim_devtype *devtype = of_id->data;
>  	struct device_node *child;
>  	int ret, have_child = 0;
> -	struct cs_timing_state ts = {};
> +	struct weim_data *priv;
> +	void __iomem *base;
>  	u32 reg;
>  
>  	if (devtype == &imx50_weim_devtype) {
> @@ -205,6 +216,9 @@ static int weim_parse_dt(struct platform_device *pdev, void __iomem *base)
>  			return ret;
>  	}
>  
> +	priv = dev_get_drvdata(&pdev->dev);
> +	base = priv->base;
> +
>  	if (of_property_read_bool(pdev->dev.of_node, "fsl,burst-clk-enable")) {
>  		if (devtype->wcr_bcm) {
>  			reg = readl(base + devtype->wcr_offset);
> @@ -229,7 +243,7 @@ static int weim_parse_dt(struct platform_device *pdev, void __iomem *base)
>  	}
>  
>  	for_each_available_child_of_node(pdev->dev.of_node, child) {
> -		ret = weim_timing_setup(&pdev->dev, child, base, devtype, &ts);
> +		ret = weim_timing_setup(&pdev->dev, child, devtype);
>  		if (ret)
>  			dev_warn(&pdev->dev, "%pOF set timing failed.\n",
>  				child);
> @@ -248,17 +262,25 @@ static int weim_parse_dt(struct platform_device *pdev, void __iomem *base)
>  
>  static int weim_probe(struct platform_device *pdev)
>  {
> +	struct weim_data *priv;
>  	struct resource *res;
>  	struct clk *clk;
>  	void __iomem *base;
>  	int ret;
>  
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
>  	/* get the resource */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> +	priv->base = base;
> +	dev_set_drvdata(&pdev->dev, priv);
> +
>  	/* get the clock */
>  	clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(clk))
> @@ -269,7 +291,7 @@ static int weim_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	/* parse the device node */
> -	ret = weim_parse_dt(pdev, base);
> +	ret = weim_parse_dt(pdev);
>  	if (ret)
>  		clk_disable_unprepare(clk);
>  	else
> @@ -278,6 +300,82 @@ static int weim_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +#if IS_ENABLED(CONFIG_OF_DYNAMIC)
> +static int of_weim_notify(struct notifier_block *nb, unsigned long action,
> +			  void *arg)
> +{
> +	const struct imx_weim_devtype *devtype;
> +	struct of_reconfig_data *rd = arg;
> +	const struct of_device_id *of_id;
> +	struct platform_device *pdev;
> +	int ret = NOTIFY_OK;
> +
> +	switch (of_reconfig_get_state_change(action, rd)) {
> +	case OF_RECONFIG_CHANGE_ADD:
> +		of_id = of_match_node(weim_id_table, rd->dn->parent);
> +		if (!of_id)
> +			return NOTIFY_OK; /* not for us */
> +
> +		devtype = of_id->data;
> +
> +		pdev = of_find_device_by_node(rd->dn->parent);
> +		if (!pdev) {
> +			pr_err("%s: could not find platform device for '%pOF'\n",
> +				__func__, rd->dn->parent);
> +
> +			return notifier_from_errno(-EINVAL);
> +		}
> +
> +		if (weim_timing_setup(&pdev->dev, rd->dn, devtype))
> +			dev_warn(&pdev->dev,
> +				 "Failed to setup timing for '%pOF'\n", rd->dn);
> +
> +		if (!of_node_check_flag(rd->dn, OF_POPULATED)) {
> +			if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
> +				dev_err(&pdev->dev,
> +					"Failed to create child device '%pOF'\n",
> +					rd->dn);
> +				ret = notifier_from_errno(-EINVAL);
> +			}
> +		}
> +
> +		platform_device_put(pdev);
> +
> +		break;
> +	case OF_RECONFIG_CHANGE_REMOVE:
> +		if (!of_node_check_flag(rd->dn, OF_POPULATED))
> +			return NOTIFY_OK; /* device already destroyed */
> +
> +		of_id = of_match_node(weim_id_table, rd->dn->parent);
> +		if (!of_id)
> +			return NOTIFY_OK; /* not for us */
> +
> +		pdev = of_find_device_by_node(rd->dn);
> +		if (!pdev) {
> +			dev_err(&pdev->dev,
> +				"Could not find platform device for '%pOF'\n",
> +				rd->dn);
> +
> +			ret = notifier_from_errno(-EINVAL);
> +		} else {
> +			of_platform_device_destroy(&pdev->dev, NULL);
> +			platform_device_put(pdev);
> +		}
> +
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +struct notifier_block weim_of_notifier = {
> +	.notifier_call = of_weim_notify,
> +};
> +#endif /* IS_ENABLED(CONFIG_OF_DYNAMIC) */
> +
> +

One newline is good enough.

Shawn

>  static struct platform_driver weim_driver = {
>  	.driver = {
>  		.name		= "imx-weim",
> @@ -285,7 +383,27 @@ static struct platform_driver weim_driver = {
>  	},
>  	.probe = weim_probe,
>  };
> -module_platform_driver(weim_driver);
> +
> +static int __init weim_init(void)
> +{
> +#if IS_ENABLED(CONFIG_OF_DYNAMIC)
> +	WARN_ON(of_reconfig_notifier_register(&weim_of_notifier));
> +#endif /* IS_ENABLED(CONFIG_OF_DYNAMIC) */
> +
> +	return platform_driver_register(&weim_driver);
> +}
> +module_init(weim_init);
> +
> +static void __exit weim_exit(void)
> +{
> +#if IS_ENABLED(CONFIG_OF_DYNAMIC)
> +	of_reconfig_notifier_unregister(&weim_of_notifier);
> +#endif /* IS_ENABLED(CONFIG_OF_DYNAMIC) */
> +
> +	return platform_driver_unregister(&weim_driver);
> +
> +}
> +module_exit(weim_exit);
>  
>  MODULE_AUTHOR("Freescale Semiconductor Inc.");
>  MODULE_DESCRIPTION("i.MX EIM Controller Driver");
> -- 
> 2.34.1
> 
> 
