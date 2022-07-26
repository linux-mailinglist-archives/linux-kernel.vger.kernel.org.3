Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DDA5811E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbiGZL27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGZL24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:28:56 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B8F1E3F8;
        Tue, 26 Jul 2022 04:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658834935; x=1690370935;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=W6nFN7MzfAsHlPYmspcMoNB0hyNHU3IPZlYG/tVC3Ks=;
  b=tzZ1sCXldVebpsP2b/8sZ+8YtP3is29xmLj7TM+cbedbmf2JzKyZv5W/
   4Js09HseTB0dV0ux32zPGWhMRrbUbfnyjwP4kplTutVsgFWn9QYO4aMFp
   iUngZ4yXBI7i/BZV9yKxv6wSXbfI/pHcDnOfj5DxEF8MmKxKtdYTwc5XZ
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Jul 2022 04:28:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 04:28:54 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 04:28:54 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Jul
 2022 04:28:50 -0700
Subject: Re: [PATCH 04/10] soc: qcom: icc-bwmon: store reference to varian
 data in container
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
 <20220720192807.130098-5-krzysztof.kozlowski@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <a9597cd4-be40-c68e-f83c-179f85c4b02d@quicinc.com>
Date:   Tue, 26 Jul 2022 16:58:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220720192807.130098-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/22 12:58 AM, Krzysztof Kozlowski wrote:
> Instead of copying pieces of variant-specific data (struct
> icc_bwmon_data) into the state container (struct icc_bwmon), just store
> a pointer to it.
> 
> This simplifies a bit the code and allows later to grow easily the
> variant-specific data for new BWMON v5.
> 
> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch subject has a typo s/varian/variant

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>   drivers/soc/qcom/icc-bwmon.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index b76a59d9002c..93c3cec84721 100644
> --- a/drivers/soc/qcom/icc-bwmon.c
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -118,11 +118,10 @@ struct icc_bwmon_data {
>   
>   struct icc_bwmon {
>   	struct device *dev;
> +	const struct icc_bwmon_data *data;
>   	void __iomem *base;
>   	int irq;
>   
> -	unsigned int default_lowbw_kbps;
> -	unsigned int sample_ms;
>   	unsigned int max_bw_kbps;
>   	unsigned int min_bw_kbps;
>   	unsigned int target_kbps;
> @@ -199,20 +198,20 @@ static void bwmon_set_threshold(struct icc_bwmon *bwmon, unsigned int reg,
>   {
>   	unsigned int thres;
>   
> -	thres = mult_frac(bwmon_kbps_to_count(kbps), bwmon->sample_ms,
> +	thres = mult_frac(bwmon_kbps_to_count(kbps), bwmon->data->sample_ms,
>   			  MSEC_PER_SEC);
>   	writel_relaxed(thres, bwmon->base + reg);
>   }
>   
> -static void bwmon_start(struct icc_bwmon *bwmon,
> -			const struct icc_bwmon_data *data)
> +static void bwmon_start(struct icc_bwmon *bwmon)
>   {
> +	const struct icc_bwmon_data *data = bwmon->data;
>   	unsigned int thres_count;
>   	int window;
>   
>   	bwmon_clear_counters(bwmon);
>   
> -	window = mult_frac(bwmon->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
> +	window = mult_frac(bwmon->data->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
>   	/* Maximum sampling window: 0xfffff */
>   	writel_relaxed(window, bwmon->base + BWMON_SAMPLE_WINDOW);
>   
> @@ -267,7 +266,7 @@ static irqreturn_t bwmon_intr(int irq, void *dev_id)
>   	 */
>   	max = readl(bwmon->base + BWMON_ZONE_MAX(zone)) + 1;
>   	max *= BWMON_COUNT_UNIT_KB;
> -	bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->sample_ms);
> +	bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->data->sample_ms);
>   
>   	return IRQ_WAKE_THREAD;
>   }
> @@ -329,14 +328,13 @@ static int bwmon_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct dev_pm_opp *opp;
>   	struct icc_bwmon *bwmon;
> -	const struct icc_bwmon_data *data;
>   	int ret;
>   
>   	bwmon = devm_kzalloc(dev, sizeof(*bwmon), GFP_KERNEL);
>   	if (!bwmon)
>   		return -ENOMEM;
>   
> -	data = of_device_get_match_data(dev);
> +	bwmon->data = of_device_get_match_data(dev);
>   
>   	bwmon->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(bwmon->base)) {
> @@ -364,8 +362,6 @@ static int bwmon_probe(struct platform_device *pdev)
>   	if (IS_ERR(opp))
>   		return dev_err_probe(dev, ret, "failed to find min peak bandwidth\n");
>   
> -	bwmon->sample_ms = data->sample_ms;
> -	bwmon->default_lowbw_kbps = data->default_lowbw_kbps;
>   	bwmon->dev = dev;
>   
>   	bwmon_disable(bwmon);
> @@ -376,7 +372,7 @@ static int bwmon_probe(struct platform_device *pdev)
>   		return dev_err_probe(dev, ret, "failed to request IRQ\n");
>   
>   	platform_set_drvdata(pdev, bwmon);
> -	bwmon_start(bwmon, data);
> +	bwmon_start(bwmon);
>   
>   	return 0;
>   }
> 
