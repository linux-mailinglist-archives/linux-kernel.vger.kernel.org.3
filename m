Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE3C58122E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbiGZLh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbiGZLhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:37:53 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538C020186;
        Tue, 26 Jul 2022 04:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658835472; x=1690371472;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Cr/ntgC8DiLojaWTkp1HzBpHWTLp4bw3vY/fTzh7su4=;
  b=zGFjejyLqiMzEpvm5OiSs8IzltuSMmosw/c7ebOXqyl2I5vqy1fBIskj
   eK73LDSOI1yOKuGn2pQy97jHbHojHSISMbae6uto3OwH9ga39hK1pgFtD
   LxsDBROJGQodTx/OKJtnbaFwwG4q2RZz3vGmvWcukYDnnyOpgg8Kg9BZR
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 26 Jul 2022 04:37:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 04:37:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 04:37:51 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Jul
 2022 04:37:47 -0700
Subject: Re: [PATCH 06/10] soc: qcom: icc-bwmon: store count unit per variant
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
 <20220720192807.130098-7-krzysztof.kozlowski@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <76e12c2c-648a-8def-f0e4-5606d52a7ad6@quicinc.com>
Date:   Tue, 26 Jul 2022 17:07:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220720192807.130098-7-krzysztof.kozlowski@linaro.org>
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
> Versions v4 and v5 of BWMON on SDM845 use different unit count, so allow
> easier variant customization by storing its value in struct
> icc_bwmon_data.
> 
> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
>   drivers/soc/qcom/icc-bwmon.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index dcd445af6488..9a99e0fd1140 100644
> --- a/drivers/soc/qcom/icc-bwmon.c
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -104,12 +104,11 @@
>   #define BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT	0xff
>   #define BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT	0xff
>   
> -/* BWMONv4 count registers use count unit of 64 kB */
> -#define BWMON_COUNT_UNIT_KB			64
>   #define BWMON_ZONE_MAX(zone)			(0x2e0 + 4 * (zone))
>   
>   struct icc_bwmon_data {
>   	unsigned int sample_ms;
> +	unsigned int count_unit_kb; /* kbytes */
>   	unsigned int default_highbw_kbps;
>   	unsigned int default_medbw_kbps;
>   	unsigned int default_lowbw_kbps;
> @@ -193,9 +192,10 @@ static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
>   	writel(BWMON_ENABLE_ENABLE, bwmon->base + BWMON_ENABLE);
>   }
>   
> -static unsigned int bwmon_kbps_to_count(unsigned int kbps)
> +static unsigned int bwmon_kbps_to_count(struct icc_bwmon *bwmon,
> +					unsigned int kbps)
>   {
> -	return kbps / BWMON_COUNT_UNIT_KB;
> +	return kbps / bwmon->data->count_unit_kb;
>   }
>   
>   static void bwmon_set_threshold(struct icc_bwmon *bwmon, unsigned int reg,
> @@ -203,8 +203,8 @@ static void bwmon_set_threshold(struct icc_bwmon *bwmon, unsigned int reg,
>   {
>   	unsigned int thres;
>   
> -	thres = mult_frac(bwmon_kbps_to_count(kbps), bwmon->data->sample_ms,
> -			  MSEC_PER_SEC);
> +	thres = mult_frac(bwmon_kbps_to_count(bwmon, kbps),
> +			  bwmon->data->sample_ms, MSEC_PER_SEC);
>   	writel_relaxed(thres, bwmon->base + reg);
>   }
>   
> @@ -270,7 +270,7 @@ static irqreturn_t bwmon_intr(int irq, void *dev_id)
>   	 * downstream) always increments the max bytes count by one.
>   	 */
>   	max = readl(bwmon->base + BWMON_ZONE_MAX(zone)) + 1;
> -	max *= BWMON_COUNT_UNIT_KB;
> +	max *= bwmon->data->count_unit_kb;
>   	bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->data->sample_ms);
>   
>   	return IRQ_WAKE_THREAD;
> @@ -394,6 +394,7 @@ static int bwmon_remove(struct platform_device *pdev)
>   /* BWMON v4 */
>   static const struct icc_bwmon_data msm8998_bwmon_data = {
>   	.sample_ms = 4,
> +	.count_unit_kb = 64,
>   	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
>   	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
>   	.default_lowbw_kbps = 0,
> 
