Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087AA588A49
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbiHCKUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbiHCKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:20:40 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EB0C10;
        Wed,  3 Aug 2022 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659522039; x=1691058039;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r2r9v+zdOXg+pjOV8cZBvnLP+wof+DIDY7ngC/evlew=;
  b=qqlItbeE/Q4dNm3hXXH+UO3t29BevJJqEwc2hrYU0nhmvtGyS+rSau0r
   55H38xvRu1bEuSjtjLRHxibce+aUsBsGrEdocciO0J0v6WKF3YGxZuPrZ
   MJDjEXN/mXaLjf7CK1vAUx7cxDmEYguXDZNEZPpek6+YJeRkdgH8Gwso4
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Aug 2022 03:20:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 03:20:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 03:20:39 -0700
Received: from [10.216.24.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 3 Aug 2022
 03:20:34 -0700
Message-ID: <624aaad9-8937-49d1-9e66-38713b5a1f0c@quicinc.com>
Date:   Wed, 3 Aug 2022 15:50:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/5] clk: qcom: gpucc-sc7280: Add cx collapse reset
 support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1659172664-10345-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220730144713.3.I5e64ff4b77bb9079eb2edeea8a02585c9e76778f@changeid>
 <9098554e-5327-0b7f-f4d0-a81880556136@linaro.org>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <9098554e-5327-0b7f-f4d0-a81880556136@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/2022 12:45 PM, Dmitry Baryshkov wrote:
> On 30/07/2022 12:17, Akhil P Oommen wrote:
>> Allow a consumer driver to poll for cx gdsc collapse through Reset
>> framework.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
>>
>>   drivers/clk/qcom/gpucc-sc7280.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gpucc-sc7280.c 
>> b/drivers/clk/qcom/gpucc-sc7280.c
>> index 9a832f2..f5df51d 100644
>> --- a/drivers/clk/qcom/gpucc-sc7280.c
>> +++ b/drivers/clk/qcom/gpucc-sc7280.c
>> @@ -433,12 +433,18 @@ static const struct regmap_config 
>> gpu_cc_sc7280_regmap_config = {
>>       .fast_io = true,
>>   };
>>   +static const struct qcom_reset_map gpucc_sc7280_resets[] = {
>> +    [GPU_CX_COLLAPSE] = { .op = gdsc_wait_for_collapse, .priv = 
>> &cx_gdsc },
>> +};
>> +
>>   static const struct qcom_cc_desc gpu_cc_sc7280_desc = {
>>       .config = &gpu_cc_sc7280_regmap_config,
>>       .clks = gpu_cc_sc7280_clocks,
>>       .num_clks = ARRAY_SIZE(gpu_cc_sc7280_clocks),
>>       .gdscs = gpu_cc_sc7180_gdscs,
>>       .num_gdscs = ARRAY_SIZE(gpu_cc_sc7180_gdscs),
>> +    .resets = gpucc_sc7280_resets,
>> +    .num_resets = ARRAY_SIZE(gpucc_sc7280_resets),
>
> An implementation question. Do we have to poll for the GDSC on 
> platforms like sm8150/sm8250 which have the plain BCR resets?
Yes.

Thanks for all the feedback, Dmitry. I will post another version of this 
series.

-Akhil.
>
>>   };
>>     static const struct of_device_id gpu_cc_sc7280_match_table[] = {
>
>

