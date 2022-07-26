Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3C75811D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbiGZLUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbiGZLUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:20:18 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4660D617B;
        Tue, 26 Jul 2022 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658834417; x=1690370417;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7w5lH3hGtlR8UxgJb3JAmDId8kkcO0eQSE2XsZ+aA9k=;
  b=S6mNC0zPgy1X7ug7jrJZF48OzbenAy/whIJKp1mzw5cQnjSVQL/AN4xz
   DT+huWVSwyfSB0gZF70W5v9qYIEZQP6NI9b63ItG6B++cHwJsJtxqowMr
   D0sFmVryc9v/nLJ1NWdWXAniNKHsJdR/+yETnCG4uagTRS2LO7cmlr/E8
   4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 26 Jul 2022 04:20:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 04:20:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 04:20:15 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Jul
 2022 04:20:11 -0700
Subject: Re: [PATCH 02/10] soc: qcom: icc-bwmon: re-use IRQ enable/clear
 define
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
 <20220720192807.130098-3-krzysztof.kozlowski@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <453abc74-442d-7df5-eb6f-9118b55905de@quicinc.com>
Date:   Tue, 26 Jul 2022 16:50:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220720192807.130098-3-krzysztof.kozlowski@linaro.org>
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


On 7/21/22 12:57 AM, Krzysztof Kozlowski wrote:
> The interrupt enable, status and clear registers have the same layout,
> so BWMON_GLOBAL_IRQ_ENABLE_ENABLE define can be used also for clearing
> IRQ, instead of hard-coded value.
> 
> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
>   drivers/soc/qcom/icc-bwmon.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index bea3ea1de7a4..3415f42523cd 100644
> --- a/drivers/soc/qcom/icc-bwmon.c
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -162,7 +162,8 @@ static void bwmon_clear_irq(struct icc_bwmon *bwmon)
>   	 * interrupt is cleared.
>   	 */
>   	writel(BWMON_IRQ_ENABLE_MASK, bwmon->base + BWMON_IRQ_CLEAR);
> -	writel(BIT(0), bwmon->base + BWMON_GLOBAL_IRQ_CLEAR);
> +	writel(BWMON_GLOBAL_IRQ_ENABLE_ENABLE,
> +	       bwmon->base + BWMON_GLOBAL_IRQ_CLEAR);
>   }
>   
>   static void bwmon_disable(struct icc_bwmon *bwmon)
> 
