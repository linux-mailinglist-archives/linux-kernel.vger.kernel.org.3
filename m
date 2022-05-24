Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C427D5323D4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiEXHOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiEXHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:14:47 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1C995495;
        Tue, 24 May 2022 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653376485; x=1684912485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZneZlwTaWbu52y3FEEErRrYskpuDw+eBsbDnaaApUno=;
  b=kbHXg5iUVwTgpd6JhL7/fSvdvdcM3mcG+HMs9G99UMbP7bEqfZv5s+M7
   nA1RKtprVDaVwX36DqhKPuZZd3QEHKZZt5q/BbVwdOJ5GYkrU3bku5r82
   EDFh/UsynjRLkwrDXZCDdScioyRYkhXjl+EO1z9d/LRl8uyX7fhdRb42B
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 May 2022 00:14:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:14:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 00:14:44 -0700
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 24 May
 2022 00:14:40 -0700
Message-ID: <6f44aa9e-ba5e-3c94-501c-32e0b35ade56@quicinc.com>
Date:   Tue, 24 May 2022 15:14:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v7 05/10] coresight-tpdm: Add integration test support
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220509133947.20987-1-quic_jinlmao@quicinc.com>
 <20220509133947.20987-6-quic_jinlmao@quicinc.com>
 <7fd884ed-1255-5976-6fcc-7a19ad0eb04e@arm.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <7fd884ed-1255-5976-6fcc-7a19ad0eb04e@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon.

On 5/23/2022 5:17 PM, Suzuki K Poulose wrote:
> On 09/05/2022 14:39, Mao Jinlong wrote:
>> Integration test for tpdm can help to generate the data for
>> verification of the topology during TPDM software bring up.
>>
>> Sample:
>> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
>> echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
>> echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
>> echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
>> cat /dev/tmc_etf0 > /data/etf-tpdm0.bin
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>
> Please could we stick this under a sub-Kconfig entry, like
> we did for the CTI ?
>
> CONFIG_CORESIGHT_TPMD_INTEGRATION_TEST
This is comment in V5 patch. There is no adverse effects for all tpdms with
integration test enabled. So i removed this config.

"

For the last patchset you mentioned that you were making this
configurable because the CTI intgration tests were also configurable.
The reason that the CTI intergration test registers were done in this
way is that some of the CoreSight components were not guaranteed to
return to a usable state once integration test was disabled.
Thus after use of the integration test, a complete board reset was
recommended. Therefore we ensured that these features would only be
used by those specifically configuring them and who were hopefully
aware of the potentail limitations

If your hardware can reliably enable and disable integration test
without adverse effects, then you may wish to consider making the
integration test a permanent feature of the driver.

Regards

Mike
"


>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 54 ++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h | 14 +++++
>>   2 files changed, 68 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 70df888ac565..57e38aa7d2bd 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -123,6 +123,59 @@ static void tpdm_init_default_data(struct 
>> tpdm_drvdata *drvdata)
>>       CS_LOCK(drvdata->base);
>>   }
>>   +/*
>> + * value 1: 64 bits test data
>> + * value 2: 32 bits test data
>> + */
>> +static ssize_t integration_test_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    int i, ret = 0;
>> +    unsigned long val;
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    ret = kstrtoul(buf, 10, &val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (val != 1 && val != 2)
>> +        return -EINVAL;
>> +
>> +    if (!drvdata->enable)
>> +        return -EINVAL;
>> +
>> +    if (val == 1)
>> +        val = ATBCNTRL_VAL_64;
>> +    else
>> +        val = ATBCNTRL_VAL_32;
>> +    CS_UNLOCK(drvdata->base);
>> +    writel_relaxed(0x1, drvdata->base + TPDM_ITCNTRL);
>> +
>> +    for (i = 1; i < INTEGRATION_TEST_CYCLE; i++)
>
> super minor nit : It is a bit un-natural, not to have i = 0;
This should be 0. I will update.
>
> Rest looks fine to me .
>
> Suzuki
>
>
>> +        writel_relaxed(val, drvdata->base + TPDM_ITATBCNTRL);
>> +
>> +    writel_relaxed(0, drvdata->base + TPDM_ITCNTRL);
>> +    CS_LOCK(drvdata->base);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_WO(integration_test);
>> +
>> +static struct attribute *tpdm_attrs[] = {
>> +    &dev_attr_integration_test.attr,
>> +    NULL,
>> +};
>> +
>> +static struct attribute_group tpdm_attr_grp = {
>> +    .attrs = tpdm_attrs,
>> +};
>> +
>> +static const struct attribute_group *tpdm_attr_grps[] = {
>> +    &tpdm_attr_grp,
>> +    NULL,
>> +};
>> +
>>   static int tpdm_probe(struct amba_device *adev, const struct 
>> amba_id *id)
>>   {
>>       struct device *dev = &adev->dev;
>> @@ -157,6 +210,7 @@ static int tpdm_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>       desc.ops = &tpdm_cs_ops;
>>       desc.pdata = adev->dev.platform_data;
>>       desc.dev = &adev->dev;
>> +    desc.groups = tpdm_attr_grps;
>>       drvdata->csdev = coresight_register(&desc);
>>       if (IS_ERR(drvdata->csdev))
>>           return PTR_ERR(drvdata->csdev);
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index f95aaad9c653..4aa880794383 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -14,6 +14,20 @@
>>   /* Enable bit for DSB subunit */
>>   #define TPDM_DSB_CR_ENA        BIT(0)
>>   +/* TPDM integration test registers */
>> +#define TPDM_ITATBCNTRL        (0xEF0)
>> +#define TPDM_ITCNTRL        (0xF00)
>> +
>> +/* Register value for integration test */
>> +#define ATBCNTRL_VAL_32        0xC00F1409
>> +#define ATBCNTRL_VAL_64        0xC01F1409
>> +
>> +/*
>> + * Number of cycles to write value when
>> + * integration test.
>> + */
>> +#define INTEGRATION_TEST_CYCLE    10
>> +
>>   /**
>>    * This enum is for PERIPHIDR0 register of TPDM.
>>    * The fields [6:0] of PERIPHIDR0 are used to determine what
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
