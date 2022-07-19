Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39857A191
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbiGSObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiGSOay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:30:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3272D550DF;
        Tue, 19 Jul 2022 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658240395; x=1689776395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YVCLhkh4n7e0j5teqG/5k5LoJ79OBATiCQ/OzpxpXvw=;
  b=fOugyaITLgch8tnlGDaArrHbhvL7Ys8Qajmxq8VGwB1n+rB/qfnbsasD
   eitZPkC6ZRpMar5HA8JzM0k+FYjN5tTgzPwayfTaqAJ2AU1KccTLSLscK
   I+hMlZ19TVP+uT7RfHiIWQfHogA14+6UcoJUYFfuRF44wSjayWt2g67WJ
   uJuZQgkwibyUMNSBhwwxqkKUGxe4qc8/VzqZpAdfMzCYlth2GN36QEA/A
   wODjiPvIghMBsVUoCD1J2NJYxSERVLIZxXWEusOqNU7L1p5o8L6VW/FAJ
   BTvdghu6SkPkIXKprHQtxSpP/RSA6CcZ/9j+56eLZIwH69cS/LTaJ7W7g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="266901286"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="266901286"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:19:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="594844167"
Received: from kckollur-mobl1.amr.corp.intel.com (HELO [10.212.118.182]) ([10.212.118.182])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:19:52 -0700
Message-ID: <a2fd9907-d098-7a38-c423-aeb167ab6d37@linux.intel.com>
Date:   Tue, 19 Jul 2022 09:19:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ASoC: SOF: imx: Add i.MX8ULP HW support
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
Cc:     shengjiu.wang@gmail.com, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
References: <1658208367-24376-1-git-send-email-shengjiu.wang@nxp.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <1658208367-24376-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static void imx8ulp_get_reply(struct snd_sof_dev *sdev)
> +{
> +	struct snd_sof_ipc_msg *msg = sdev->msg;
> +	struct sof_ipc_reply reply;
> +	int ret = 0;
> +
> +	if (!msg) {
> +		dev_warn(sdev->dev, "unexpected ipc interrupt\n");
> +		return;
> +	}
> +
> +	/* get reply */
> +	sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
> +
> +	if (reply.error < 0) {
> +		memcpy(msg->reply_data, &reply, sizeof(reply));
> +		ret = reply.error;
> +	} else {
> +		/* reply has correct size? */
> +		if (reply.hdr.size != msg->reply_size) {
> +			dev_err(sdev->dev, "error: reply expected %zu got %u bytes\n",
> +				msg->reply_size, reply.hdr.size);
> +			ret = -EINVAL;
> +		}
> +
> +		/* read the message */
> +		if (msg->reply_size > 0)
> +			sof_mailbox_read(sdev, sdev->host_box.offset,
> +					 msg->reply_data, msg->reply_size);
> +	}
> +
> +	msg->reply_error = ret;
> +}

Can you double-check if this helper is needed? It looks completely
generic and I vaguely remember that this get_reply() was moved to common
code, and it's no longer in the other existing iMX support files.

> +
> +static int imx8ulp_get_mailbox_offset(struct snd_sof_dev *sdev)
> +{
> +	return MBOX_OFFSET;
> +}
> +
> +static int imx8ulp_get_window_offset(struct snd_sof_dev *sdev, u32 id)
> +{
> +	return MBOX_OFFSET;
> +}
> +
> +static void imx8ulp_dsp_handle_reply(struct imx_dsp_ipc *ipc)
> +{
> +	struct imx8ulp_priv *priv = imx_dsp_get_data(ipc);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->sdev->ipc_lock, flags);
> +
> +	imx8ulp_get_reply(priv->sdev);
> +	snd_sof_ipc_reply(priv->sdev, 0);
> +	spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);

this is old stuff that wasn't updated, we now have an inline that
combines this:

static inline void snd_sof_ipc_process_reply(struct snd_sof_dev *sdev,
u32 msg_id)
{
	snd_sof_ipc_get_reply(sdev);
	snd_sof_ipc_reply(sdev, msg_id);
}

see the code in im8xm.c....

> +}
> +
> +static void imx8ulp_dsp_handle_request(struct imx_dsp_ipc *ipc)
> +{
> +	struct imx8ulp_priv *priv = imx_dsp_get_data(ipc);
> +	u32 p; /* panic code */
> +
> +	/* Read the message from the debug box. */
> +	sof_mailbox_read(priv->sdev, priv->sdev->debug_box.offset + 4, &p, sizeof(p));
> +
> +	/* Check to see if the message is a panic code (0x0dead***) */
> +	if ((p & SOF_IPC_PANIC_MAGIC_MASK) == SOF_IPC_PANIC_MAGIC)
> +		snd_sof_dsp_panic(priv->sdev, p, true);
> +	else
> +		snd_sof_ipc_msgs_rx(priv->sdev);
> +}
> +
> +static struct imx_dsp_ops dsp_ops = {
> +	.handle_reply		= imx8ulp_dsp_handle_reply,
> +	.handle_request		= imx8ulp_dsp_handle_request,
> +};
> +
> +static int imx8ulp_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
> +{
> +	struct imx8ulp_priv *priv = sdev->pdata->hw_pdata;
> +
> +	sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
> +			  msg->msg_size);
> +	imx_dsp_ring_doorbell(priv->dsp_ipc, 0);
> +
> +	return 0;
> +}
> +
> +static int imx8ulp_run(struct snd_sof_dev *sdev)
> +{
> +	struct imx8ulp_priv *priv = sdev->pdata->hw_pdata;
> +
> +	imx8ulp_sim_lpav_start(priv);
> +
> +	return 0;
> +}
> +
> +static int imx8ulp_reset(struct snd_sof_dev *sdev)
> +{
> +	struct imx8ulp_priv *priv = sdev->pdata->hw_pdata;
> +
> +	/* HiFi4 Platform Clock Enable: 1 enabled, 0 disabled */
> +	regmap_update_bits(priv->regmap, SYSCTRL0, PLAT_CLK_BIT, PLAT_CLK_BIT);
> +	/* HiFi4 PBCLK clock enable: 1 enabled, 0 disabled */
> +	regmap_update_bits(priv->regmap, SYSCTRL0, PB_CLK_BIT, PB_CLK_BIT);
> +	/* HiFi4 Clock Enable: 1 enabled, 0 disabled */
> +	regmap_update_bits(priv->regmap, SYSCTRL0, HIFI4_CLK_BIT, HIFI4_CLK_BIT);
> +
> +	regmap_update_bits(priv->regmap, SYSCTRL0, RESET_BIT, RESET_BIT);
> +	usleep_range(1, 2);
> +	/* Stall HIFI4 DSP Execution: 1 stall, 0 not stall */
> +	regmap_update_bits(priv->regmap, SYSCTRL0, EXECUTE_BIT, EXECUTE_BIT);
> +	usleep_range(1, 2);


adding newlines would help make the comments more readable, this is a
bit of an eyesore.

> +	arm_smccc_smc(FSL_SIP_HIFI_XRDC, 0, 0, 0, 0, 0, 0, 0, &smc_resource);
> +
> +	return 0;
> +}
> +
> +static int imx8ulp_probe(struct snd_sof_dev *sdev)
> +{
> +	struct platform_device *pdev =
> +		container_of(sdev->dev, struct platform_device, dev);
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *res_node;
> +	struct resource *mmio;
> +	struct imx8ulp_priv *priv;
> +	struct resource res;
> +	u32 base, size;
> +	int ret = 0;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clks = devm_kzalloc(&pdev->dev, sizeof(*priv->clks), GFP_KERNEL);
> +	if (!priv->clks)
> +		return -ENOMEM;
> +
> +	sdev->num_cores = 1;
> +	sdev->pdata->hw_pdata = priv;
> +	priv->dev = sdev->dev;
> +	priv->sdev = sdev;
> +
> +	/* System integration module(SIM) control dsp configurtion */

typo: configuration

> +	priv->regmap = syscon_regmap_lookup_by_phandle(np, "fsl,dsp-ctrl");
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->ipc_dev = platform_device_register_data(sdev->dev, "imx-dsp",
> +						      PLATFORM_DEVID_NONE,
> +						      pdev, sizeof(*pdev));
> +	if (IS_ERR(priv->ipc_dev))
> +		return PTR_ERR(priv->ipc_dev);
> +
> +	priv->dsp_ipc = dev_get_drvdata(&priv->ipc_dev->dev);
> +	if (!priv->dsp_ipc) {
> +		/* DSP IPC driver not probed yet, try later */
> +		ret = -EPROBE_DEFER;
> +		dev_err(sdev->dev, "Failed to get drvdata\n");
> +		goto exit_pdev_unregister;
> +	}
> +
> +	imx_dsp_set_data(priv->dsp_ipc, priv);
> +	priv->dsp_ipc->ops = &dsp_ops;
> +
> +	/* DSP base */
> +	mmio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (mmio) {
> +		base = mmio->start;
> +		size = resource_size(mmio);
> +	} else {
> +		dev_err(sdev->dev, "error: failed to get DSP base at idx 0\n");
> +		ret = -EINVAL;
> +		goto exit_pdev_unregister;
> +	}
> +
> +	sdev->bar[SOF_FW_BLK_TYPE_IRAM] = devm_ioremap(sdev->dev, base, size);
> +	if (!sdev->bar[SOF_FW_BLK_TYPE_IRAM]) {
> +		dev_err(sdev->dev, "failed to ioremap base 0x%x size 0x%x\n",
> +			base, size);
> +		ret = -ENODEV;
> +		goto exit_pdev_unregister;
> +	}
> +	sdev->mmio_bar = SOF_FW_BLK_TYPE_IRAM;
> +
> +	res_node = of_parse_phandle(np, "memory-reserved", 0);
> +	if (!res_node) {
> +		dev_err(&pdev->dev, "failed to get memory region node\n");
> +		ret = -ENODEV;
> +		goto exit_pdev_unregister;
> +	}
> +
> +	ret = of_address_to_resource(res_node, 0, &res);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to get reserved region address\n");
> +		goto exit_pdev_unregister;
> +	}
> +
> +	sdev->bar[SOF_FW_BLK_TYPE_SRAM] = devm_ioremap_wc(sdev->dev, res.start,
> +							  resource_size(&res));
> +	if (!sdev->bar[SOF_FW_BLK_TYPE_SRAM]) {
> +		dev_err(sdev->dev, "failed to ioremap mem 0x%x size 0x%x\n",
> +			base, size);
> +		ret = -ENOMEM;
> +		goto exit_pdev_unregister;
> +	}
> +	sdev->mailbox_bar = SOF_FW_BLK_TYPE_SRAM;
> +
> +	/* set default mailbox offset for FW ready message */
> +	sdev->dsp_box.offset = MBOX_OFFSET;
> +
> +	ret = of_reserved_mem_device_init(sdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to init reserved memory region %d\n", ret);
> +		goto exit_pdev_unregister;
> +	}
> +
> +	priv->clks->dsp_clks = imx8ulp_dsp_clks;
> +	priv->clks->num_dsp_clks = ARRAY_SIZE(imx8ulp_dsp_clks);
> +
> +	ret = imx8_parse_clocks(sdev, priv->clks);
> +	if (ret < 0)
> +		goto exit_pdev_unregister;
> +
> +	ret = imx8_enable_clocks(sdev, priv->clks);
> +	if (ret < 0)
> +		goto exit_pdev_unregister;
> +
> +	return 0;
> +
> +exit_pdev_unregister:
> +	platform_device_unregister(priv->ipc_dev);
> +
> +	return ret;
> +}
> +

> +static int imx8ulp_suspend(struct snd_sof_dev *sdev)
> +{
> +	int i;
> +	struct imx8ulp_priv *priv = (struct imx8ulp_priv *)sdev->pdata->hw_pdata;
> +
> +	regmap_update_bits(priv->regmap, SYSCTRL0, EXECUTE_BIT, EXECUTE_BIT);
> +
> +	for (i = 0; i < DSP_MU_CHAN_NUM; i++)
> +		imx_dsp_free_channel(priv->dsp_ipc, i);
> +
> +	imx8_disable_clocks(sdev, priv->clks);
> +
> +	return 0;
> +}
> +
> +static int imx8ulp_resume(struct snd_sof_dev *sdev)
> +{
> +	struct imx8ulp_priv *priv = (struct imx8ulp_priv *)sdev->pdata->hw_pdata;
> +	int i;
> +
> +	imx8_enable_clocks(sdev, priv->clks);
> +
> +	for (i = 0; i < DSP_MU_CHAN_NUM; i++)
> +		imx_dsp_request_channel(priv->dsp_ipc, i);
> +
> +	return 0;

is the assymetry between suspend and resume intentional? You are missing
the update_bit for EXECUTE_BIT?

> +}
> +


