Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE96349723B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 15:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbiAWOqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 09:46:34 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:45565 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233533AbiAWOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 09:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642949191; x=1674485191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mycJ8+dHfD1xjVxrdmxmttz3DlLMs0BIC5UpIx3conI=;
  b=uX2QxqOzUr0aitJ1yvfTtHjgOL5lSKV3ZAOV+DtZSNJPLK3+lNu8hBtL
   mUgRYJiKSOKZF3274lDsolz6tR/hwuMrG7HaWfweDYCfxyr3Pg6yQAdUH
   4da428md+3IXFfEJGv/mwLKtCNo3Z+jE/eVxgQIQ4B+6alufm2T6EPfKN
   0=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Jan 2022 06:46:30 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 06:46:29 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 23 Jan 2022 06:46:29 -0800
Received: from [10.216.26.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 23 Jan
 2022 06:46:19 -0800
Message-ID: <6eed66b8-a04b-fa1e-49ec-d1051641b2e9@quicinc.com>
Date:   Sun, 23 Jan 2022 20:16:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 4/4] thermal: qcom: add support for PMIC5 Gen2 ADCTM
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>,
        <amitk@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>
References: <1637647025-20409-1-git-send-email-quic_jprakash@quicinc.com>
 <1637647025-20409-5-git-send-email-quic_jprakash@quicinc.com>
 <20211126184613.00002816@Huawei.com>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <20211126184613.00002816@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 11/27/2021 12:16 AM, Jonathan Cameron wrote:
> On Tue, 23 Nov 2021 11:27:04 +0530
> Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
>> Add support for PMIC5 Gen2 ADC_TM, used on PMIC7 chips. It is a
>> close counterpart of PMIC7 ADC and has the same functionality as
>> PMIC5 ADC_TM, for threshold monitoring and interrupt generation.
>> It is present on PMK8350 alone, like PMIC7 ADC and can be used
>> to monitor up to 8 ADC channels, from any of the PMIC7 PMICs
>> having ADC on a target, through PBS(Programmable Boot Sequence).
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> Just one note on using put_unaligned_le16() below.  Otherwise, from
> a drive by review point of view it looks fine to someone not that
> familiar with the driver or thermal :)
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 375 ++++++++++++++++++++++++++++++-
>>   1 file changed, 372 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
>> index fc8cd45..a7b33a8 100644
>> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
>> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
>> @@ -4,7 +4,10 @@
>>    *
>>    * Based on original driver:
>>    * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
>> + *
>> + * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
>>    */

>> +
>> +	/* Low temperature corresponds to high voltage threshold */
>> +	if (low != -INT_MAX) {
>> +		channel->high_thr_en = true;
>> +		adc_code = qcom_adc_tm5_gen2_temp_res_scale(low);
>> +
>> +		buf[11] = adc_code & 0xff;
>> +		buf[12] = adc_code >> 8;
> looks like a little endian put though not necessarily aligned so
> put_unaligned_le16() preferred to open coding it. Same in similar places.
> Not my area though so maintainer may not care as much.


I'll use put_unaligned_le16 as suggested, in similar places in the next 
post.


>> +	} else {
>> +		channel->high_thr_en = false;
>> +	}
>> +
>> +	buf[13] = ADC_TM_GEN2_MEAS_EN;
>> +	if (channel->high_thr_en)
>> +		buf[13] |= ADC_TM5_GEN2_HIGH_THR_INT_EN;

Thanks,

Jishnu

