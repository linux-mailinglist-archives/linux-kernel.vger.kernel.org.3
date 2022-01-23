Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B500749724F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 15:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbiAWO4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 09:56:50 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33687 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbiAWO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 09:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642949810; x=1674485810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9L7df5exJJ88Rh+9B8n0aVFkHIAPEzApXCoY4D8jqIs=;
  b=IdezgPuCIKK3VdX3FcGYTFlmyQQL9Ja/1nLEA6qC3wafXB+JWJLj1KZW
   4XKl3hU63hayPRwJGQHGr4X6AVT0RF+yMCWmleCZLA1vwWMwtjDqmMI+7
   4mOFXVGxyQ24IMu3498aKGskhbIMmJjJZ4EfF/Brb6hYf+RvLDRh0Q6rR
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 23 Jan 2022 06:56:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 06:56:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 23 Jan 2022 06:56:49 -0800
Received: from [10.216.26.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 23 Jan
 2022 06:56:36 -0800
Message-ID: <c113e9f0-10ea-b3d8-eb32-fb936f64c7e0@quicinc.com>
Date:   Sun, 23 Jan 2022 20:26:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 4/4] thermal: qcom: add support for PMIC5 Gen2 ADCTM
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <robh+dt@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <manivannan.sadhasivam@linaro.org>,
        <linus.walleij@linaro.org>, <quic_kgunda@quicinc.com>,
        <quic_aghayal@quicinc.com>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <quic_subbaram@quicinc.com>,
        <jic23@kernel.org>, <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>
References: <1637647025-20409-1-git-send-email-quic_jprakash@quicinc.com>
 <1637647025-20409-5-git-send-email-quic_jprakash@quicinc.com>
 <b0fb77da-812c-b1b7-81fa-cad0b6ba247c@linaro.org>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <b0fb77da-812c-b1b7-81fa-cad0b6ba247c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 11/29/2021 8:02 AM, Dmitry Baryshkov wrote:
> On 23/11/2021 08:57, Jishnu Prakash wrote:
>> Add support for PMIC5 Gen2 ADC_TM, used on PMIC7 chips. It is a
>> close counterpart of PMIC7 ADC and has the same functionality as
>> PMIC5 ADC_TM, for threshold monitoring and interrupt generation.
>> It is present on PMK8350 alone, like PMIC7 ADC and can be used
>> to monitor up to 8 ADC channels, from any of the PMIC7 PMICs
>> having ADC on a target, through PBS(Programmable Boot Sequence).
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>> ---
>>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 375 
>> ++++++++++++++++++++++++++++++-
>>   1 file changed, 372 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c 
>> b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
>> index fc8cd45..a7b33a8 100644

>>   static int adc_tm5_set_trips(void *data, int low, int high)
>>   {
>>       struct adc_tm5_channel *channel = data;
>> @@ -422,6 +739,11 @@ static int adc_tm5_init(struct adc_tm5_chip *chip)
>>           }
>>       }
>>   +    mutex_init(&chip->adc_mutex_lock);
>
> Minor issue. This way, the mutex is left uninitialized for ADC_TM5_HC 
> devices. I'd move the mutex_init() call to the _probe function itself.


The mutex is needed only for Gen2 ADC_TM devices, I have mentioned this 
in the adc_tm5_chip struct description. I'll keep it in the Gen2 ADC_TM 
init function.


>
>> +
>> +    if (chip->data->gen == ADC_TM5_GEN2)
>> +        return ret;
>> +
>
> Please do not do this. Create a separate adc_tm5_gen2_init function.
> Add init() callback to adc_tm5_data structure.


Will make this change in next post.


>
>>       buf[0] = chip->decimation;
>>       buf[1] = chip->avg_samples | ADC_TM5_FAST_AVG_EN;
>>       buf[2] = ADC_TM5_TIMER1;
>> @@ -442,7 +764,7 @@ static int adc_tm5_get_dt_channel_data(struct 
>> adc_tm5_chip *adc_tm,
>>                          struct device_node *node)
>>   {
>>       const char *name = node->name;
>> -    u32 chan, value, varr[2];
>> +    u32 chan, value, adc_channel, varr[2];
>>       int ret;
>>       struct device *dev = adc_tm->dev;
>>       struct of_phandle_args args;
>> @@ -472,7 +794,11 @@ static int adc_tm5_get_dt_channel_data(struct 
>> adc_tm5_chip *adc_tm,
>>       }
>>       of_node_put(args.np);
>>   -    if (args.args_count != 1 || args.args[0] >= ADC5_MAX_CHANNEL) {
>> +    adc_channel = args.args[0];
>> +    if (adc_tm->data->gen == ADC_TM5_GEN2)
>> +        adc_channel &= 0xff;
>> +
>> +    if (args.args_count != 1 || adc_channel >= ADC5_MAX_CHANNEL) {
>
> Here you read the data (args.args[0]) before checking that it is 
> actually available (args.args_count is not zero). Please correct the 
> sequence.


Will correct this in next post.


>
>>           dev_err(dev, "%s: invalid ADC channel number %d\n", name, 
>> chan);
>>           return -EINVAL;
>>       }
>> @@ -518,6 +844,32 @@ static int adc_tm5_get_dt_channel_data(struct 
>> adc_tm5_chip *adc_tm,
>>       else
>>           channel->cal_method = ADC_TM5_ABSOLUTE_CAL;
>>   +    if (adc_tm->data->gen == ADC_TM5_GEN2) {
>> +        ret = of_property_read_u32(node, "qcom,decimation", &value);
>> +        if (!ret) {
>> +            ret = qcom_adc5_decimation_from_dt(value, 
>> adc_tm->data->decimation);
>> +            if (ret < 0) {
>> +                dev_err(dev, "invalid decimation %d\n", value);
>> +                return ret;

Thanks,

Jishnu

