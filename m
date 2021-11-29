Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14AA460F50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbhK2H3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:29:07 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:32767 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233486AbhK2H1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638170628; x=1669706628;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZlbWCVV/lfOP54IUq+A6kh+sJQ9XzioUfaO5ohBaCec=;
  b=ezirMwPclZPnhtr/DlfMkda+UbwVRpDAw7cs+iiOQy9nWSSh3DRP7j6D
   d9httSuycQ+1ElMqSrpF+IoMnIWRfbGpB6ptl3rNbPlJUu4/2Quly3l8N
   wnr7CtyUTjlO9Dwnh8sZWa8x6GUy289LDczXtiXDSqkKdPA2BdCyJ48Jl
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Nov 2021 23:23:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 23:23:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 28 Nov 2021 23:23:47 -0800
Received: from [10.216.45.128] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 28 Nov
 2021 23:23:43 -0800
Message-ID: <56a5820e-9cd7-aa49-7ce8-9547f355986e@quicinc.com>
Date:   Mon, 29 Nov 2021 12:53:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 2/2] irqchip: Add Qualcomm MPM controller driver
To:     Shawn Guo <shawn.guo@linaro.org>, Marc Zyngier <maz@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211126093529.31661-1-shawn.guo@linaro.org>
 <20211126093529.31661-3-shawn.guo@linaro.org>
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <20211126093529.31661-3-shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 11/26/2021 3:05 PM, Shawn Guo wrote:
> +static int __maybe_unused qcom_mpm_suspend_late(struct device *dev)

why maybe unused?

> +{
> +	struct qcom_mpm_priv *priv = dev_get_drvdata(dev);
> +	int i, ret;
> +
> +	for (i = 0; i < priv->reg_stride; i++)
> +		qcom_mpm_write(priv, MPM_REG_STATUS, i, 0);
> +
> +	/* Notify RPM to write vMPM into HW */
> +	ret = mbox_send_message(priv->mbox_chan, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused qcom_mpm_resume_early(struct device *dev)
> +{
> +	/* Nothing to do for now */
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops qcom_mpm_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(qcom_mpm_suspend_late,
> +				     qcom_mpm_resume_early)
> +};

This is not limited to suspend, you will need to notify RPM during 
deepest cpu idle state entry as well, since MPM may be monitoring 
interrupts in that case too.

This may be handled for both suspend/CPUidle using cpu pm notifications 
where in last cpu entering deepest idle may notify RPM (something 
similar to what rpmh-rsc.c does)

Thanks,
Maulik
