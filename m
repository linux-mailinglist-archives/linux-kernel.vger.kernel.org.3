Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7C546319
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347350AbiFJKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344363AbiFJKEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:04:51 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3B1B41C7;
        Fri, 10 Jun 2022 03:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654855490; x=1686391490;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=wM8AR7EF4KqQEH54DYTVZVfCtuLjTuQvtuihUj3UHdY=;
  b=XKt03d2C0kIH42YjEhh5wWSR7eftguBVIbBnCsAVjnEqHxXpK6ZN4WHT
   CEykx0SHizP2XMKB2VJdVkJ7NJnB+Xxbf8QLElWKgVAPVjDwrum2fNr6b
   NzzuEzXA1JK90dyLhZb92JaF2ob4fQiAfk7hiOVNZi7piugsADNNnxwHh
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Jun 2022 03:04:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 03:04:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 03:04:48 -0700
Received: from [10.216.33.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 10 Jun
 2022 03:04:42 -0700
Message-ID: <70631864-ff95-5c73-64ed-602774eb0de7@quicinc.com>
Date:   Fri, 10 Jun 2022 15:34:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/2] soundwire: qcom: Add flag for software clock
 gating check
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <vkoul@kernel.org>
References: <1654785023-1667-1-git-send-email-quic_srivasam@quicinc.com>
 <1654785023-1667-2-git-send-email-quic_srivasam@quicinc.com>
 <97757ee1-2525-4e97-855e-da6fb66f01ae@linux.intel.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <97757ee1-2525-4e97-855e-da6fb66f01ae@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/9/2022 8:52 PM, Pierre-Louis Bossart wrote:
Thanks for your time Pierre-Louis!!!
>
> On 6/9/22 09:30, Srinivasa Rao Mandadapu wrote:
>> Validate software clock gating required or not and do software
>> clock gating on hclk if soundwire is operational and keep it
>> running by adding flag in private data structure.
>> This is to avoid conflict between older architectures,
>> where software clock gating is not required and on latest
>> architectues, where software clock gating is mandatory.
> architectures.
Okay. Will fix it.
>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/qcom.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index a3fccf0..8e163da 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -181,6 +181,7 @@ struct qcom_swrm_ctrl {
>>   struct qcom_swrm_data {
>>   	u32 default_cols;
>>   	u32 default_rows;
>> +	bool sw_clk_gate_required;
>>   };
>>   
>>   static const struct qcom_swrm_data swrm_v1_3_data = {
>> @@ -1311,6 +1312,15 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>   			return PTR_ERR(ctrl->mmio);
>>   	}
>>   
>> +	if (data->sw_clk_gate_required) {
>> +		ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
>> +		if (IS_ERR(ctrl->audio_cgcr)) {
> You need to handle the NULL case, devm_reset_control_get_exclusive() can
> return ERR_OR_NULL
>
> https://elixir.bootlin.com/linux/latest/source/drivers/reset/core.c#L1045
Okay. Will change accordingly.
>
>> +			dev_err(dev, "Failed to get cgcr reset ctrl required for SW gating\n");
>> +			ret = PTR_ERR(ctrl->audio_cgcr);
>> +			goto err_init;
>> +		}
>> +	}
>> +
>>   	ctrl->irq = of_irq_get(dev->of_node, 0);
>>   	if (ctrl->irq < 0) {
>>   		ret = ctrl->irq;
>> @@ -1336,10 +1346,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>   	ctrl->bus.compute_params = &qcom_swrm_compute_params;
>>   	ctrl->bus.clk_stop_timeout = 300;
>>   
>> -	ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
>> -	if (IS_ERR(ctrl->audio_cgcr))
>> -		dev_err(dev, "Failed to get audio_cgcr reset required for soundwire-v1.6.0\n");
>> -
>>   	ret = qcom_swrm_get_port_config(ctrl);
>>   	if (ret)
>>   		goto err_clk;
