Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD224C0281
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiBVT4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbiBVTz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:55:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834B6C5DB1;
        Tue, 22 Feb 2022 11:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645559730; x=1677095730;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eE5Y6NJ98wT5byN8TvBoZ9imyKf4VK62w4kqwTGFROw=;
  b=mpbvUGbVtps1bc47Hh2Z4WnP5TIsILB7VGkJpqsHaOxo1QEVEXmXryt2
   6XsDbw5OFRRr7bBIJdMYgQZWIsMi77saRdmlo6xC4IlPQ0vYO5jMUJIvk
   HSyUswGhp6GM8cET9QBMb1WmrbATK2MvOxO6M822SxeALDGpT5VhNbV59
   cjnTgm8xSb4RFTq5Chff0HRZAwa3NMPamBybhAc1XGLGMEKCz5NGvgFy/
   Lq3AB4U+BuAf64WqTi6Pa8g3WbvSOJr70Y7gULvIq160PB9DmifOPFb3S
   96HbngMt4YMGT90ramJiYwofETs9HlG3dUW6exkOUsjGkjBk+dXXo00sW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="231772624"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="231772624"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:55:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="639032047"
Received: from mjpatel-mobl.amr.corp.intel.com (HELO [10.212.37.223]) ([10.212.37.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:55:16 -0800
Message-ID: <70db9c01-104e-e081-198e-0b6d8a1c17da@linux.intel.com>
Date:   Tue, 22 Feb 2022 13:15:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] soundwire: qcom: add runtime pm support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
 <20220221104127.15670-2-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220221104127.15670-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/22 04:41, Srinivas Kandagatla wrote:
> Add support to runtime PM using SoundWire clock stop on supported instances
> and bus reset on instances that require full reset.

This commit message and code are a bit confusing, e.g. you have a
boolean state

ctrl->clk_stop_bus_reset = true;

Does this mean bus reset on exiting clock stop? or just that clock stop
is not supported and bus reset is required with complete re-enumeration.

It would be good to try and explain using SoundWire 1.x terminology what
actions are taken on resume.


> @@ -1267,6 +1305,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	ctrl->bus.ops = &qcom_swrm_ops;
>  	ctrl->bus.port_ops = &qcom_swrm_port_ops;
>  	ctrl->bus.compute_params = &qcom_swrm_compute_params;
> +	ctrl->bus.clk_stop_timeout = 300;
>  
>  	ret = qcom_swrm_get_port_config(ctrl);
>  	if (ret)
> @@ -1319,6 +1358,21 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  		 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
>  		 ctrl->version & 0xffff);
>  
> +	pm_runtime_set_autosuspend_delay(dev, 3000);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	/* Clk stop is not supported on WSA Soundwire masters */
> +	if (ctrl->version <= 0x01030000) {
> +		ctrl->clk_stop_bus_reset = true;
> +	} else {
> +		ctrl->reg_read(ctrl, SWRM_COMP_MASTER_ID, &val);
> +		if (val == MASTER_ID_WSA)
> +			ctrl->clk_stop_bus_reset = true;
> +	}

I think this means clock_stop_not_supported?

> +static int swrm_runtime_resume(struct device *dev)
> +{
> +	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
> +	int ret;
> +
> +	clk_prepare_enable(ctrl->hclk);
> +
> +	if (ctrl->clk_stop_bus_reset) {
> +		reinit_completion(&ctrl->enumeration);
> +		ctrl->reg_write(ctrl, SWRM_COMP_SW_RESET, 0x01);
> +		qcom_swrm_get_device_status(ctrl);

don't you need some sort of delay before checking the controller and
device status? The bus reset sequence takes 4096 bits, that's a non-zero
time.

> +		sdw_handle_slave_status(&ctrl->bus, ctrl->status);
> +		qcom_swrm_init(ctrl);
> +		wait_for_completion_timeout(&ctrl->enumeration,
> +					    msecs_to_jiffies(TIMEOUT_MS));
> +	} else {
> +		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
> +		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR,
> +			SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET);
> +
> +		ctrl->intr_mask |= SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
> +		ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR, ctrl->intr_mask);
> +		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
> +
> +		usleep_range(100, 105);
> +	}
> +
> +	if (!swrm_wait_for_frame_gen_enabled(ctrl))
> +		dev_err(ctrl->dev, "link failed to connect\n");
> +
> +	usleep_range(300, 305);
> +	ret = sdw_bus_exit_clk_stop(&ctrl->bus);
> +	if (ret < 0)
> +		dev_err(ctrl->dev, "bus failed to exit clock stop %d\n", ret);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused swrm_runtime_suspend(struct device *dev)
> +{
> +	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!ctrl->clk_stop_bus_reset) {
> +		/* Mask bus clash interrupt */
> +		ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
> +		ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR, ctrl->intr_mask);
> +		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
> +	}
> +	/* Prepare slaves for clock stop */
> +	ret = sdw_bus_prep_clk_stop(&ctrl->bus);
> +	if (ret < 0) {

if a device has lost sync and reports -ENODATA, you want still want to
go ahead and not prevent the suspend operation from happening.

> +		dev_err(dev, "prepare clock stop failed %d", ret);
> +		return ret;
> +	}
> +
> +	ret = sdw_bus_clk_stop(&ctrl->bus);
> +	if (ret < 0 && ret != -ENODATA) {
> +		dev_err(dev, "bus clock stop failed %d", ret);
> +		return ret;
> +	}
> +
> +	clk_disable_unprepare(ctrl->hclk);
> +
> +	usleep_range(300, 305);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops swrm_dev_pm_ops = {
> +	SET_RUNTIME_PM_OPS(swrm_runtime_suspend, swrm_runtime_resume, NULL)
> +};
> +
>  static const struct of_device_id qcom_swrm_of_match[] = {
>  	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
>  	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
> @@ -1359,6 +1506,7 @@ static struct platform_driver qcom_swrm_driver = {
>  	.driver = {
>  		.name	= "qcom-soundwire",
>  		.of_match_table = qcom_swrm_of_match,
> +		.pm = &swrm_dev_pm_ops,
>  	}
>  };
>  module_platform_driver(qcom_swrm_driver);
