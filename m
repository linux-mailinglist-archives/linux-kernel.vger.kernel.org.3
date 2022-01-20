Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E2494C41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiATKyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:54:20 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:27014 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiATKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642676057; x=1674212057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PWXf9U9ip1SlEBsO3DM5W2hgX/Z8F0qlAhGez6OXS/k=;
  b=qy6SAarL7xNSYLLaJe8M/HI2WnltMqZpRn+c0b0Y2yKlbqR0GEq0xPh+
   K3be9VrLSOm33k74vBs6w27Y3zTl3n5EWcicWweEqiTJayRa5IQ1OjrIJ
   xuik23iAI8hGF4QuRrpVEW5cjIa5PRzNOq0Kyg/R2KCIAVfI2RaVRoWLY
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 20 Jan 2022 02:54:16 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 02:54:15 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 02:54:15 -0800
Received: from [10.216.6.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 20 Jan
 2022 02:54:09 -0800
Message-ID: <2f208798-2ec5-4c29-1362-0de102f29718@quicinc.com>
Date:   Thu, 20 Jan 2022 16:24:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/4] pinctrl: qcom: sm8150: Specify PDC map
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <bhupesh.linux@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <bjorn.andersson@linaro.org>
References: <20220119203133.467264-1-bhupesh.sharma@linaro.org>
 <20220119203133.467264-3-bhupesh.sharma@linaro.org>
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <20220119203133.467264-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/20/2022 2:01 AM, Bhupesh Sharma wrote:
> Specify the PDC mapping for SM8150, so that gpio interrupts are
> propertly mapped to the wakeup IRQs of the PDC.

s/propertly/properly

>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   drivers/pinctrl/qcom/pinctrl-sm8150.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8150.c b/drivers/pinctrl/qcom/pinctrl-sm8150.c
> index 7359bae68c69..499dd05c3e3d 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sm8150.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8150.c
> @@ -1500,6 +1500,25 @@ static const struct msm_pingroup sm8150_groups[] = {
>   	[178] = SDC_QDSD_PINGROUP(sdc2_data, 0xB2000, 9, 0),
>   };
>   
> +static const struct msm_gpio_wakeirq_map sm8150_pdc_map[] = {
> +	{ 3, 31 }, { 5, 32 }, { 8, 33 }, { 9, 34 }, { 10, 100 },
> +	{ 12, 104 }, { 24, 37 }, { 26, 38 }, { 27, 41 }, { 28, 42 },
> +	{ 30, 39 }, { 36, 43 }, { 37, 44 }, { 38, 30 }, { 39, 118 },
> +	{ 39, 125 },
GPIO 39 is duplicated. 39 is used with 118 PDC interrupt in downstream. 
so { 39, 125 } can be removed.
> { 41, 47 }, { 42, 48 }, { 46, 50 }, { 47, 49 },
> +	{ 48, 51 }, { 49, 53 }, { 50, 52 }, { 51, 116 }, { 51, 123 },
GPIO 51 is duplicated. 51 is used with 116 PDC interrupt in downstream 
so { 51, 123 } can be removed
> +	{ 53, 54 }, { 54, 55 }, { 55, 56 }, { 56, 57 }, { 58, 58 },
> +	{ 60, 60 }, { 61, 61 }, { 68, 62 }, { 70, 63 }, { 76, 71 },
> +	{ 77, 66 }, { 81, 64 }, { 83, 65 }, { 86, 67 }, { 87, 84 },
> +	{ 88, 117 }, { 88, 124 }, { 90, 69 }, { 91, 70 }, { 93, 75 },
> +	{ 95, 72 }, { 96, 73 }, { 97, 74 }, { 101, 40 }, { 103, 77 },
> +	{ 104, 78 }, { 108, 79 }, { 112, 80 }, { 113, 81 }, { 114, 82 },
> +	{ 117, 85 }, { 118, 101 }, { 119, 87 }, { 120, 88 }, { 121, 89 },
> +	{ 122, 90 }, { 123, 91 }, { 124, 92 }, { 125, 93 }, { 129, 94 },
> +	{ 132, 105 }, { 133, 83 }, { 134, 36 }, { 136, 97 }, { 142, 103 },
> +	{ 144, 115 }, { 144, 122 }, { 147, 102 }, { 150, 107 },
> +	{ 152, 108 }, { 153, 109 }
> +};
> +
>   static const struct msm_pinctrl_soc_data sm8150_pinctrl = {
>   	.pins = sm8150_pins,
>   	.npins = ARRAY_SIZE(sm8150_pins),
> @@ -1510,6 +1529,8 @@ static const struct msm_pinctrl_soc_data sm8150_pinctrl = {
>   	.ngpios = 176,
>   	.tiles = sm8150_tiles,
>   	.ntiles = ARRAY_SIZE(sm8150_tiles),
> +	.wakeirq_map = sm8150_pdc_map,
> +	.nwakeirq_map = ARRAY_SIZE(sm8150_pdc_map),

On SM8150 need to set .wakeirq_dual_edge_errata = true, similar to sc7180.

Thanks,
Maulik
