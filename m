Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2DC508AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379726AbiDTOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379545AbiDTOoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:44:05 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F02275F9;
        Wed, 20 Apr 2022 07:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650465679; x=1682001679;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MRUrSxngAI1RP3Pa/HoZmM1UBEdRxvw4bWReRgdxuEQ=;
  b=aJJdy5ciMkGS4ImghjYUwSsBZtyepZPL4cY1T3uCOsJkIGHazP1lugqX
   shE/flXcnDnTnN7amvKfsKholASeGxst4gdXRv59g9266TTJi5F+4KLqO
   sV6DdJ7237mG6QqbqiqF4WQysweZ4m9apDl/ghXkrivWtVKsFsURamUWe
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Apr 2022 07:41:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 07:41:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Apr 2022 07:41:17 -0700
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Apr
 2022 07:41:14 -0700
Message-ID: <82bb1da8-7a44-8fdf-d9d5-b3c11a936887@quicinc.com>
Date:   Wed, 20 Apr 2022 22:41:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 04/10] coresight-tpdm: Add DSB dataset support
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
CC:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20220412125035.40312-1-quic_jinlmao@quicinc.com>
 <20220412125035.40312-5-quic_jinlmao@quicinc.com>
 <CAJ9a7ViDkaqykQTiPX7T7z0T0cDOfnyDM6H7sY=dNDe0DqZwDw@mail.gmail.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <CAJ9a7ViDkaqykQTiPX7T7z0T0cDOfnyDM6H7sY=dNDe0DqZwDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Mike for the review.

On 4/19/2022 5:23 PM, Mike Leach wrote:
> Hi,
>
> On Tue, 12 Apr 2022 at 13:51, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>> TPDM serves as data collection component for various dataset types.
>> DSB(Discrete Single Bit) is one of the dataset types. DSB subunit
>> can be enabled for data collection by writing 1 to the first bit of
>> DSB_CR register. This change is to add enable/disable function for
>> DSB dataset by writing DSB_CR register.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 61 ++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h | 21 +++++++
>>   2 files changed, 82 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 3900ae50670a..d7b970cdcf51 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -20,7 +20,28 @@
>>
>>   DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>>
>> +static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>> +{
>> +       u32 val;
>> +
>> +       /* Set the enable bit of DSB control register to 1 */
>> +       val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> +       val = val | BIT(0);
> Please use #defined values, declared in the header file rather than
> BIT(x) here. (the etm4x drivers have been recently updated to use the
> same pattern).
> e.g.
>   val |= TPDM_DSB_CR_ENA;
I will update in next version.
>> +       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>> +}
>> +
>>   /* TPDM enable operations */
>> +static void _tpdm_enable(struct tpdm_drvdata *drvdata)
>> +{
>> +       CS_UNLOCK(drvdata->base);
>> +
>> +       /* Check if DSB datasets is present for TPDM. */
>> +       if (test_bit(TPDM_DS_DSB, drvdata->datasets))
>> +               tpdm_enable_dsb(drvdata);
>> +
>> +       CS_LOCK(drvdata->base);
>> +}
>> +
>>   static int tpdm_enable(struct coresight_device *csdev,
>>                         struct perf_event *event, u32 mode)
>>   {
>> @@ -32,6 +53,7 @@ static int tpdm_enable(struct coresight_device *csdev,
>>                  return -EBUSY;
>>          }
>>
>> +       _tpdm_enable(drvdata);
>>          drvdata->enable = true;
>>          mutex_unlock(&drvdata->lock);
>>
>> @@ -39,7 +61,29 @@ static int tpdm_enable(struct coresight_device *csdev,
>>          return 0;
>>   }
>>
>> +static void tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
>> +{
>> +       u32 val;
>> +
>> +       /* Set the enable bit of DSB control register to 0 */
>> +       val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> +       val = val & ~BIT(0);
> val &= ~TPDM_DSB_CR_ENA;
I will update in next version.
>
>> +       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>> +}
>> +
>>   /* TPDM disable operations */
>> +static void _tpdm_disable(struct tpdm_drvdata *drvdata)
>> +{
>> +       CS_UNLOCK(drvdata->base);
>> +
>> +       /* Check if DSB datasets is present for TPDM. */
>> +       if (test_bit(TPDM_DS_DSB, drvdata->datasets))
>> +               tpdm_disable_dsb(drvdata);
>> +
>> +       CS_LOCK(drvdata->base);
>> +
>> +}
>> +
>>   static void tpdm_disable(struct coresight_device *csdev,
>>                           struct perf_event *event)
>>   {
>> @@ -51,6 +95,7 @@ static void tpdm_disable(struct coresight_device *csdev,
>>                  return;
>>          }
>>
>> +       _tpdm_disable(drvdata);
>>          drvdata->enable = false;
>>          mutex_unlock(&drvdata->lock);
>>
>> @@ -66,6 +111,21 @@ static const struct coresight_ops tpdm_cs_ops = {
>>          .source_ops     = &tpdm_source_ops,
>>   };
>>
>> +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>> +{
>> +       int i;
>> +       u32 pidr;
>> +
>> +       CS_UNLOCK(drvdata->base);
>> +       /*  Get the datasets present on the TPDM. */
>> +       pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
>> +       for (i = 0; i < TPDM_DATASETS; i++) {
>> +               if (pidr & BIT(i))
>> +                       __set_bit(i, drvdata->datasets);
> Could this be considerably simpified? - there are a maximum of 7 bits
> for datasets - and you are setting the same bit in drvdata->datasets
> for each bit in pidr
>
> e.g. if the datasets declaration is a simple unsigned long, then the
> following is easier to read and understand:
>
> drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
>
> The tests above could then become:
> if (drvdata->datasets & BIT(TPDM_DS_DSB)) ...
>
I will check your suggestion and update in next version.
>> +       }
>> +       CS_LOCK(drvdata->base);
>> +}
>> +
>>   static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>>   {
>>          struct device *dev = &adev->dev;
>> @@ -104,6 +164,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>>          if (IS_ERR(drvdata->csdev))
>>                  return PTR_ERR(drvdata->csdev);
>>
>> +       tpdm_init_default_data(drvdata);
>>          /* Decrease pm refcount when probe is done.*/
>>          pm_runtime_put(&adev->dev);
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 94a7748a5426..8f05070879c4 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -6,6 +6,25 @@
>>   #ifndef _CORESIGHT_CORESIGHT_TPDM_H
>>   #define _CORESIGHT_CORESIGHT_TPDM_H
>>
>> +/* The max number of the datasets that TPDM supports */
>> +#define TPDM_DATASETS       7
>> +
>> +/* DSB Subunit Registers */
>> +#define TPDM_DSB_CR            (0x780)
>> +
> declare the enable bit here with comment documenting usage  - see above.
>
>> +/**
>> + * This enum is for PERIPHIDR0 register of TPDM.
>> + * The fields [6:0] of PERIPHIDR0 are used to determine what
>> + * interfaces and subunits are present on a given TPDM.
>> + *
>> + * PERIPHIDR0[0] : Fix to 1 if ImplDef subunit present, else 0
>> + * PERIPHIDR0[1] : Fix to 1 if DSB subunit present, else 0
>> + */
>> +enum tpdm_dataset {
>> +       TPDM_DS_IMPLDEF,
>> +       TPDM_DS_DSB,
>> +};
>> +
>>   /**
>>    * struct tpdm_drvdata - specifics associated to an TPDM component
>>    * @base:       memory mapped base address for this component.
>> @@ -13,6 +32,7 @@
>>    * @csdev:      component vitals needed by the framework.
>>    * @lock:       lock for the enable value.
>>    * @enable:     enable status of the component.
>> + * @datasets:   The datasets types present of the TPDM.
>>    */
>>
>>   struct tpdm_drvdata {
>> @@ -21,6 +41,7 @@ struct tpdm_drvdata {
>>          struct coresight_device *csdev;
>>          struct mutex            lock;
>>          bool                    enable;
>> +       DECLARE_BITMAP(datasets, TPDM_DATASETS);
> Could this simply be declared as an unsigned long? - then simplify the
> code in the .c file.
>
> Regards
>
> Mike
>
>>   };
>>
>>   #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
>> --
>> 2.17.1
>>
>
