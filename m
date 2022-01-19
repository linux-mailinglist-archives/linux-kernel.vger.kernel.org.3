Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE111493FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356815AbiASSbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356800AbiASSbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:31:22 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02204C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:31:22 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id p37so3084029pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WE80LPrsoKRXzdHL41J7C3rtPUMvrkVMO2iBekQMkPA=;
        b=xZXUqRDJ0yPTjaO6bGXXJpTSFEGHuWVHBwpBdrbNJdqZHrI0iFd7sZb5+9pzHvrDeS
         K/3EUhRthF3obF5h4IjS8nyfmiwrAobxd1tjqfLDg5EYJSBPPFdTE6zh7uegManr+XMh
         SfJME63w/N5eUEsFnLS9G1BPDRHGxGDgl5vy4T//q8zsMEHgCer7v5H/nbXrz850xAwx
         GF10sb67BCcTIVDYpLf5kOVp4zOYEkmGz8+wQG/WgqJ83sU0VLipE/S9zyGvssWsPiU2
         5XsbbEDYyI5HwAPtenlynQ664EoWUsKOc84/mhNBnbcHSTFN0VxRav3QOXHbkV42r4tz
         4ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WE80LPrsoKRXzdHL41J7C3rtPUMvrkVMO2iBekQMkPA=;
        b=nVHtbHyXA8wpv7wzfQuovoCkeUkiHqZ06JT0+0zi2asoKZyEkWjtnG0JSkBkKA54Uf
         NUVWjNKxYnQIsk+RQAdXYiMtONxYIqkSnC+Jiv6KnpDkh2/vCbji2qI6s7xzdGyVo7Xf
         6aww4B35H46FtxdYN7OSrPRTaBLQJaqlNPXU71/7MzkyKYQ8DP0GvuTQmV8SLH0iaFUC
         ijpnh9gWWwl8F0ovhLLmLPZghfNKNyXuaNNLNo7xgFwhKiXXI9pqIaHw5742uU5sOUZ2
         XT2roKcyxTXNzdf47bc4e6kLP6uYZulqeVBJz3ChTT6fDWfxxuQr3Y+eF1zo7arZmv4c
         2Z+g==
X-Gm-Message-State: AOAM531cPfiIwxZqMXCH6RA82TLxPE7g8xLPcxaYqYNrkUrC69HEo3PG
        i8p20WI7wbAEmVU/Pc9TACFWhg==
X-Google-Smtp-Source: ABdhPJygoX/tffA1AVJrF15VCwFE4xsnn7Kz9mszVkpRmtEYASugV41weiiGmJEqMUtB11PyL7ezpQ==
X-Received: by 2002:a63:384d:: with SMTP id h13mr27781957pgn.472.1642617081487;
        Wed, 19 Jan 2022 10:31:21 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id pj6sm6938827pjb.21.2022.01.19.10.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 10:31:20 -0800 (PST)
Date:   Wed, 19 Jan 2022 11:31:18 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 6/9] remoteproc: imx_rproc: support attaching to i.MX8QXP
 M4
Message-ID: <20220119183118.GA1284752@p14s>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-9-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111033333.403448-9-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:33:30AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When M4 is kicked by SCFW, M4 runs in its own hardware partition, Linux
> could only do IPC with M4, it could not start, stop, update image.
> 
> When M4 crash reboot, it could notify Linux, so Linux could prepare to
> reattach to M4 after M4 recovery.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 96 ++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 0e99a3ca6fbc..5f04aea2f6a1 100644
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
> @@ -90,6 +93,23 @@ struct imx_rproc {
>  	struct workqueue_struct		*workqueue;
>  	void __iomem			*rsc_table;
>  	bool				has_clk;
> +	struct imx_sc_ipc		*ipc_handle;
> +	struct notifier_block		proc_nb;
> +	u32				rproc_pt;
> +	u32				rsrc;
> +};
> +
> +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
> +	/* dev addr , sys addr  , size	    , flags */
> +	{ 0x08000000, 0x08000000, 0x10000000, 0},
> +	/* TCML/U */
> +	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
> +	/* OCRAM(Low 96KB) */
> +	{ 0x21000000, 0x00100000, 0x00018000, 0},
> +	/* OCRAM */
> +	{ 0x21100000, 0x00100000, 0x00040000, 0},
> +	/* DDR (Data) */
> +	{ 0x80000000, 0x80000000, 0x60000000, 0 },
>  };
>  
>  static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
> @@ -236,6 +256,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
>  	.method		= IMX_RPROC_NONE,
>  };
>  
> +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
> +	.att		= imx_rproc_att_imx8qxp,
> +	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
> +	.method		= IMX_RPROC_SCU_API,
> +};
> +
>  static const struct imx_rproc_dcfg imx_rproc_cfg_imx7ulp = {
>  	.att		= imx_rproc_att_imx7ulp,
>  	.att_size	= ARRAY_SIZE(imx_rproc_att_imx7ulp),
> @@ -491,6 +517,11 @@ static int imx_rproc_attach(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static int imx_rproc_detach(struct rproc *rproc)
> +{
> +	return 0;
> +}
> +
>  static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
>  {
>  	struct imx_rproc *priv = rproc->priv;
> @@ -525,6 +556,7 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *
>  static const struct rproc_ops imx_rproc_ops = {
>  	.prepare	= imx_rproc_prepare,
>  	.attach		= imx_rproc_attach,
> +	.detach		= imx_rproc_detach,
>  	.start		= imx_rproc_start,
>  	.stop		= imx_rproc_stop,
>  	.kick		= imx_rproc_kick,
> @@ -671,6 +703,22 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
>  	mbox_free_channel(priv->rx_ch);
>  }
>  
> +static int imx_rproc_partition_notify(struct notifier_block *nb,
> +				      unsigned long event, void *group)
> +{
> +	struct imx_rproc *priv = container_of(nb, struct imx_rproc, proc_nb);
> +
> +	/* Ignore other irqs */
> +	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
> +		return 0;
> +
> +	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
> +
> +	pr_info("Patition%d reset!\n", priv->rproc_pt);

s/Patition/Partition

> +
> +	return 0;
> +}
> +
>  static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  {
>  	struct regmap_config config = { .name = "imx-rproc" };
> @@ -680,6 +728,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  	struct arm_smccc_res res;
>  	int ret;
>  	u32 val;
> +	u8 pt;
>  
>  	switch (dcfg->method) {
>  	case IMX_RPROC_NONE:
> @@ -690,6 +739,52 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  		if (res.a0)
>  			priv->rproc->state = RPROC_DETACHED;
>  		return 0;
> +	case IMX_RPROC_SCU_API:
> +		ret = imx_scu_get_handle(&priv->ipc_handle);
> +		if (ret)
> +			return ret;
> +		ret = of_property_read_u32(dev->of_node, "rsrc-id", &priv->rsrc);
> +		if (ret) {
> +			dev_err(dev, "no rsrc-id\n");
> +			return ret;
> +		}
> +
> +		/*
> +		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
> +		 * and Linux could only do IPC with Mcore and nothing else.
> +		 */
> +		if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc)) {

                if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc))
                        return 0;

> +
> +			priv->has_clk = false;
> +			priv->rproc->self_recovery = true;
> +			priv->rproc->state = RPROC_DETACHED;

This is further proof that information is already available to determine if
clocks should be managed on the application processor or not and that
priv->has_clk carries redundant information.

> +
> +			/* Get partition id and enable irq in SCFW */
> +			ret = imx_sc_rm_get_resource_owner(priv->ipc_handle, priv->rsrc, &pt);
> +			if (ret) {
> +				dev_err(dev, "not able to get resource owner\n");
> +				return ret;
> +			}
> +
> +			priv->rproc_pt = pt;
> +			priv->proc_nb.notifier_call = imx_rproc_partition_notify;
> +
> +			ret = imx_scu_irq_register_notifier(&priv->proc_nb);
> +			if (ret) {
> +				dev_warn(dev, "register scu notifier failed.\n");
> +				return ret;
> +			}
> +
> +			ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
> +						       BIT(priv->rproc_pt), true);
> +			if (ret) {
> +				imx_scu_irq_unregister_notifier(&priv->proc_nb);
> +				dev_warn(dev, "Enable irq failed.\n");
> +				return ret;
> +			}
> +		}
> +
> +		return 0;
>  	default:
>  		break;
>  	}
> @@ -847,6 +942,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
>  	{ .compatible = "fsl,imx8mm-cm4", .data = &imx_rproc_cfg_imx8mq },
>  	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
>  	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
> +	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
>  	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
>  	{},
>  };
> -- 
> 2.25.1
> 
