Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AA7497244
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 15:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiAWOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 09:50:20 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:58913 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236832AbiAWOuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 09:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642949419; x=1674485419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZtWkFx+ZmMu/JgmqtQEIX8/LamUvtcVYVZZhAAP627E=;
  b=PaVgYGyMAVj614uZP7Ps/xCqD7J6/aZo/RwzKYzvkY5aJ/a8/A0TuUyd
   JmtwcSs/K5yrhFDgravb5jRr9eQR8O5SJTNDfywiRUDsPBEzv+q5CC6Kn
   KnO5JYs+N77tzzPqP8ZzbzqN12dcvwN4Ndc54fKGfi1Ud/+EDgFypMeJm
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Jan 2022 06:50:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 06:50:18 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 23 Jan 2022 06:50:17 -0800
Received: from [10.216.26.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 23 Jan
 2022 06:50:07 -0800
Message-ID: <7e659952-98b0-bfcd-1087-cdd0538d2250@quicinc.com>
Date:   Sun, 23 Jan 2022 20:20:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 3/4] thermal: qcom: Add support for multiple
 generations of devices
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
 <1637647025-20409-4-git-send-email-quic_jprakash@quicinc.com>
 <47228209-552e-b148-c93a-4fbb5a36583e@linaro.org>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <47228209-552e-b148-c93a-4fbb5a36583e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,


On 11/29/2021 7:55 AM, Dmitry Baryshkov wrote:
> On 23/11/2021 08:57, Jishnu Prakash wrote:
>> Refactor code to support multiple generations of ADC_TM devices
>> by defining gen number, irq name and disable, configure and isr
>> APIs in the individual data structs.
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Minor question below.
>
>> ---
>>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 76 
>> ++++++++++++++++++++------------
>>   1 file changed, 48 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c 
>> b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
>> index 824671c..fc8cd45 100644
>> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
>> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
>> @@ -78,11 +78,10 @@ enum adc5_timer_select {
>>       ADC5_TIMER_SEL_NONE,
>>   };
>>   -struct adc_tm5_data {
>> -    const u32    full_scale_code_volt;
>> -    unsigned int    *decimation;
>> -    unsigned int    *hw_settle;
>> -    bool        is_hc;
>> +enum adc5_gen {
>> +    ADC_TM5,
>> +    ADC_TM_HC,
>> +    ADC_TM5_MAX
>>   };
>>     enum adc_tm5_cal_method {
>> @@ -92,6 +91,18 @@ enum adc_tm5_cal_method {
>>   };
>>     struct adc_tm5_chip;
>> +struct adc_tm5_channel;
>> +
>> +struct adc_tm5_data {
>> +    const u32 full_scale_code_volt;
>> +    unsigned int *decimation;
>> +    unsigned int *hw_settle;
>> +    int (*disable_channel)(struct adc_tm5_channel *channel);
>> +    int (*configure)(struct adc_tm5_channel *channel, int low, int 
>> high);
>> +    irqreturn_t (*isr)(int irq, void *data);
>> +    char *irq_name;
>> +    int gen;
>> +};
>
> Any reason for moving the adc_tm5_data definition? It is still prefix 
> with the adc_tmp5_channel declaration.


There's no strong reason, I just thought it would look better to keep 
all the major struct definitions together after the enum definitions.


>
>>     /**
>>    * struct adc_tm5_channel - ADC Thermal Monitoring channel data.
>> @@ -139,22 +150,6 @@ struct adc_tm5_chip {
>>       u16            base;
>>   };
>>   -static const struct adc_tm5_data adc_tm5_data_pmic = {
>> -    .full_scale_code_volt = 0x70e4,
>> -    .decimation = (unsigned int []) { 250, 420, 840 },
>> -    .hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 
>> 600, 700,
>> -                     1000, 2000, 4000, 8000, 16000, 32000,
>> -                     64000, 128000 },
>> -};
>> -
>> -static const struct adc_tm5_data adc_tm_hc_data_pmic = {
>> -    .full_scale_code_volt = 0x70e4,
>> -    .decimation = (unsigned int []) { 256, 512, 1024 },
>> -    .hw_settle = (unsigned int []) { 0, 100, 200, 300, 400, 500, 
>> 600, 700,
>> -                     1000, 2000, 4000, 6000, 8000, 10000 },
>> -    .is_hc = true,
>> -};
>> -

Thanks,

Jishnu

