Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F63855EB06
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiF1R17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiF1R1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:27:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA323A1B1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:27:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e63so12838334pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=osgld0pzQy4iTsusCsWDaWoG0N8IqLVBxYU5+GF9/J4=;
        b=utePYlHH3nRgmww4DbnonjD9OWHAYpU9JCXYlTStomKuNGt03UXXfjWbV/btUimeIl
         4vXRaoRj5qZEhNWLDBZk1A6RKFYmaiMYLpx8H+FTO+YjxWJ4ZlX+auWvTO0avF+sI3XG
         a2n3iQsWVarA5wPuoq4V2g2XByCWSFuSCKeIEYhLIjQ5vqjgtU+aPgbMSJgr2x4nuFSi
         929UEcvtBDNyEF29CAHTwr7OJRWl9QEBbN+intjof9KKw1cwh5PC8FkPYupXrpMf+BAd
         8cxcwEzFClhA3QQcpl9HBRR1HXafcgAFoo7vwIHvqT8qQ97LFR1RTzdP/TIpq9oHuzvE
         +IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=osgld0pzQy4iTsusCsWDaWoG0N8IqLVBxYU5+GF9/J4=;
        b=qPtrlCdb0Z0WRsdofGu+DKgoWmCjTRqyABGEcVZNhSLIVk/mcsNnIgFTGTg8LpJAPV
         Hjs0YvEEILAosNnwa4qR7lbeDZZg7ABukgJ/PhKU8jXdFFHSg99K5wwK2iWCaMvIGZl+
         aSxDV9sFs/YPdeNRJuoNMXlQumEg3yrvvl4Il0QsP7agIWgz5S9z3dsaxKEYIh6Q6PWI
         dgd94byTor1VhPu2lTWzrha3FbkjhNPm2nUjA05IpIc3IEQ04tSoyz05M43PL93o1fux
         8fenDsWyURgWHQ1sjtqfR20Ns1dQVzeaShpI9/pCpJyYh7nGNxdCMb1f4fBIiyBmvu9b
         F2lw==
X-Gm-Message-State: AJIora/XTQcPJI8LKZe8JQVVlUov3uc84anpB8ceCSWvvlRWT1op/1ap
        HLjVFxNOrQUxmOXHUrMJmyOikzOQChnR2g==
X-Google-Smtp-Source: AGRyM1vwRc7KhbpvgRIHUN/TFthYtddimgoYRgo4Bh9++Wof7fy0wsL7BW/PKLLQ2pmhpnQ4b/higg==
X-Received: by 2002:a63:1360:0:b0:410:702f:d1d4 with SMTP id 32-20020a631360000000b00410702fd1d4mr7989478pgt.625.1656437269373;
        Tue, 28 Jun 2022 10:27:49 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id r7-20020a17090a690700b001ec9f9fe028sm86860pjj.46.2022.06.28.10.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:27:48 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:27:46 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Message-ID: <20220628172746.GB1942439@p14s>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
 <20220517064937.4033441-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517064937.4033441-4-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Tue, May 17, 2022 at 02:49:34PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When M4 is kicked by SCFW, M4 runs in its own hardware partition, Linux
> could only do IPC with M4, it could not start, stop, update image.
> 
> We disable recovery reboot when M4 is managed by SCFW, because
> remoteproc core still not support M4 auto-recovery without loading
> image.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 88 ++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 4a3352821b1d..2e751fc90760 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -6,6 +6,7 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/firmware/imx/sci.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mailbox_client.h>
> @@ -59,6 +60,8 @@
>  #define IMX_SIP_RPROC_STARTED		0x01
>  #define IMX_SIP_RPROC_STOP		0x02
>  
> +#define	IMX_SC_IRQ_GROUP_REBOOTED	5
> +
>  /**
>   * struct imx_rproc_mem - slim internal memory structure
>   * @cpu_addr: MPU virtual address of the memory region
> @@ -89,6 +92,10 @@ struct imx_rproc {
>  	struct work_struct		rproc_work;
>  	struct workqueue_struct		*workqueue;
>  	void __iomem			*rsc_table;
> +	struct imx_sc_ipc		*ipc_handle;
> +	struct notifier_block		rproc_nb;
> +	u32				rproc_pt;	/* partition id */
> +	u32				rsrc_id;	/* resource id */
>  };
>  
>  static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> @@ -117,6 +124,18 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
>  	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },
>  };
>  
> +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
> +	{ 0x08000000, 0x08000000, 0x10000000, 0 },
> +	/* TCML/U */
> +	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
> +	/* OCRAM(Low 96KB) */
> +	{ 0x21000000, 0x00100000, 0x00018000, 0 },
> +	/* OCRAM */
> +	{ 0x21100000, 0x00100000, 0x00040000, 0 },
> +	/* DDR (Data) */
> +	{ 0x80000000, 0x80000000, 0x60000000, 0 },
> +};
> +
>  static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
>  	/* dev addr , sys addr  , size	    , flags */
>  	/* ITCM   */
> @@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
>  	.method		= IMX_RPROC_MMIO,
>  };
>  
> +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
> +	.att		= imx_rproc_att_imx8qxp,
> +	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
> +	.method		= IMX_RPROC_SCU_API,
> +};
> +
>  static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
>  	.att		= imx_rproc_att_imx8ulp,
>  	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8ulp),
> @@ -683,6 +708,22 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
>  	mbox_free_channel(priv->rx_ch);
>  }
>  
> +static int imx_rproc_partition_notify(struct notifier_block *nb,
> +				      unsigned long event, void *group)
> +{
> +	struct imx_rproc *priv = container_of(nb, struct imx_rproc, rproc_nb);
> +
> +	/* Ignore other irqs */
> +	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
> +		return 0;
> +
> +	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
> +
> +	pr_info("Partition%d reset!\n", priv->rproc_pt);
> +
> +	return 0;
> +}
> +
>  static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  {
>  	struct regmap_config config = { .name = "imx-rproc" };
> @@ -692,6 +733,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  	struct arm_smccc_res res;
>  	int ret;
>  	u32 val;
> +	u8 pt;
>  
>  	switch (dcfg->method) {
>  	case IMX_RPROC_NONE:
> @@ -702,6 +744,51 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  		if (res.a0)
>  			priv->rproc->state = RPROC_DETACHED;
>  		return 0;
> +	case IMX_RPROC_SCU_API:
> +		ret = imx_scu_get_handle(&priv->ipc_handle);
> +		if (ret)
> +			return ret;
> +		ret = of_property_read_u32(dev->of_node, "fsl,resource-id", &priv->rsrc_id);
> +		if (ret) {
> +			dev_err(dev, "No fsl,resource-id property\n");
> +			return ret;
> +		}
> +
> +		/*
> +		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
> +		 * and Linux could only do IPC with Mcore and nothing else.
> +		 */
> +		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> +			return 0;
> +
> +		priv->rproc->state = RPROC_DETACHED;
> +		priv->rproc->recovery_disabled = true;
> +
> +		/* Get partition id and enable irq in SCFW */
> +		ret = imx_sc_rm_get_resource_owner(priv->ipc_handle, priv->rsrc_id, &pt);
> +		if (ret) {
> +			dev_err(dev, "not able to get resource owner\n");
> +			return ret;
> +		}
> +
> +		priv->rproc_pt = pt;
> +		priv->rproc_nb.notifier_call = imx_rproc_partition_notify;
> +
> +		ret = imx_scu_irq_register_notifier(&priv->rproc_nb);
> +		if (ret) {
> +			dev_warn(dev, "register scu notifier failed.\n");
> +			return ret;
> +		}

I woul have expected to see imx_scu_irq_register_notifier() being called when
the driver is removed and in the probe() error path.  More comments to come.

Thanks,
Mathieu

> +
> +		ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt),
> +					       true);
> +		if (ret) {
> +			imx_scu_irq_unregister_notifier(&priv->rproc_nb);
> +			dev_warn(dev, "Enable irq failed.\n");
> +			return ret;
> +		}
> +
> +		return 0;
>  	default:
>  		break;
>  	}
> @@ -855,6 +942,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
>  	{ .compatible = "fsl,imx8mm-cm4", .data = &imx_rproc_cfg_imx8mq },
>  	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
>  	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
> +	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
>  	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
>  	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
>  	{},
> -- 
> 2.25.1
> 
