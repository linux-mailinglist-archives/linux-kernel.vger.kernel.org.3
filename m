Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D274C0282
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiBVT4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiBVTz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:55:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF4EC621D;
        Tue, 22 Feb 2022 11:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645559731; x=1677095731;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VHSxbtD4mVx8CwpUuPAeIMnzDxuN5vCFvKRBG3+7rIs=;
  b=K9IgKY9KYFhrkkRVT+Dl8DqIEQUdV6U3nCB5uUxsGshQarMZYRMUwdjq
   s0VgH6Ooe2B3dKn5bPsTBW6x/egCfL81YG5a/OoEO8dN0ha8qo1YP3L1Y
   PpXJPfKE7m0DGxgCd7g72+j2Wa6AEZprazarVWnKOeBGzhRokT7xrEAsk
   5KDzZe/SWw1LutoR7+01IANEEFx1AO8uJQAQc7cApRiixmaJXsCXmxRW/
   i8ykxboByRN4RheM4tJAGJo8AJBT2bnYEZkWJLYStEhHFgZMKUUbnhIPm
   YlhDUnh9fA2qKyZGz0D4a2ac/VoEKwFykS3jwNoL5rqcskTBYl+/7gIxq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="231772629"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="231772629"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:55:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="639032064"
Received: from mjpatel-mobl.amr.corp.intel.com (HELO [10.212.37.223]) ([10.212.37.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:55:18 -0800
Message-ID: <5e050d4c-e3d2-35fb-ca49-7be53579bc31@linux.intel.com>
Date:   Tue, 22 Feb 2022 13:26:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] soundwire: qcom: add wake up interrupt support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
 <20220221104127.15670-4-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220221104127.15670-4-srinivas.kandagatla@linaro.org>
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




> +static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
> +{
> +	struct qcom_swrm_ctrl *swrm = dev_id;
> +	int ret = IRQ_HANDLED;
> +	struct sdw_slave *slave;
> +
> +	clk_prepare_enable(swrm->hclk);
> +
> +	if (swrm->wake_irq > 0) {
> +		if (!irqd_irq_disabled(irq_get_irq_data(swrm->wake_irq)))
> +			disable_irq_nosync(swrm->wake_irq);
> +	}
> +
> +	/*
> +	 * resume all the slaves which must have potentially generated this
> +	 * interrupt, this should also wake the controller at the same time.
> +	 * this is much safer than waking controller directly that will deadlock!
> +	 */
There should be no difference if you first resume the controller and
then attached peripherals, or do a loop where you rely on the pm_runtime
framework.

The notion that there might be a dead-lock is surprising, you would need
to elaborate here.

> +	list_for_each_entry(slave, &swrm->bus.slaves, node) {
> +		ret = pm_runtime_get_sync(&slave->dev);

In my experience, you don't want to blur layers and take references on
the child devices from the parent device. I don't know how many times we
end-up with weird behavior.

we've done something similar on the Intel side but implemented in a less
directive manner.

ret = device_for_each_child(bus->dev, NULL, intel_resume_child_device);

static int intel_resume_child_device(struct device *dev, void *data)
{
[...]	
	ret = pm_request_resume(dev);
	if (ret < 0)
		dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);

	return ret;
}


> +		if (ret < 0 && ret != -EACCES) {
> +			dev_err_ratelimited(swrm->dev,
> +					    "pm_runtime_get_sync failed in %s, ret %d\n",
> +					    __func__, ret);
> +			pm_runtime_put_noidle(&slave->dev);
> +			ret = IRQ_NONE;
> +			goto err;
> +		}
> +	}
> +
> +	list_for_each_entry(slave, &swrm->bus.slaves, node) {
> +		pm_runtime_mark_last_busy(&slave->dev);
> +		pm_runtime_put_autosuspend(&slave->dev);
> +	}
> +err:
> +	clk_disable_unprepare(swrm->hclk);
> +	return IRQ_HANDLED;
> +}
> +

