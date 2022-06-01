Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F053A032
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351020AbiFAJVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350194AbiFAJVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:21:25 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F1C580E2;
        Wed,  1 Jun 2022 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654075285; x=1685611285;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=yMzSNegJTY36Tsg8xrGuN/+TPtYGTwZt2sCHlutuh6Q=;
  b=WFj0GdFDnpqY09BwdHRkG4vKdTDUL+YUwI9BTjg+4phJFthH7QGYS7TP
   Rt+Q7En4edn5WgKCwL7XLV9kwl5wk2HYUDDAtyQdYBCg1NNJaaaG2fUy6
   UpK8qcvltX0oIG4tc0s5oEy+UDYx4fl95vZ8rL40imQrGthCgdtwWvJoq
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 01 Jun 2022 02:21:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 02:21:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 02:21:23 -0700
Received: from [10.253.36.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 02:21:19 -0700
Message-ID: <7d6b2e24-21f4-eef1-a722-23cdcd1d8a88@quicinc.com>
Date:   Wed, 1 Jun 2022 17:21:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 02/10] Coresight: Add coresight TPDM source driver
Content-Language: en-US
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
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
 <20220509133947.20987-3-quic_jinlmao@quicinc.com>
 <38bb1ec9-56bc-0cdf-6c46-d448a46ec886@arm.com>
 <ea720e1a-c0d2-84b0-8dbc-bb5031d32208@quicinc.com>
In-Reply-To: <ea720e1a-c0d2-84b0-8dbc-bb5031d32208@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 5/24/2022 3:00 PM, Jinlong Mao wrote:
> Hi Suzuki,
>
> Thank you for the review.
>
> On 5/23/2022 4:57 PM, Suzuki K Poulose wrote:
>> Hi
>>
>> On 09/05/2022 14:39, Mao Jinlong wrote:
>>> Add driver to support Coresight device TPDM (Trace, Profiling and
>>> Diagnostics Monitor). TPDM is a monitor to collect data from
>>> different datasets. This change is to add probe/enable/disable
>>> functions for tpdm source.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/Kconfig          |  13 ++
>>>   drivers/hwtracing/coresight/Makefile         |   1 +
>>>   drivers/hwtracing/coresight/coresight-core.c |   5 +-
>>>   drivers/hwtracing/coresight/coresight-tpdm.c | 146 
>>> +++++++++++++++++++
>>>   drivers/hwtracing/coresight/coresight-tpdm.h |  26 ++++
>>>   include/linux/coresight.h                    |   1 +
>>>   6 files changed, 191 insertions(+), 1 deletion(-)
>>>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
>>>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h
>>>

>>> +/**
>>> + * struct tpdm_drvdata - specifics associated to an TPDM component
>>> + * @base:       memory mapped base address for this component.
>>> + * @dev:        The device entity associated to this component.
>>> + * @csdev:      component vitals needed by the framework.
>>> + * @lock:       lock for the enable value.
>>> + * @enable:     enable status of the component.
>>> + */
>>> +
>>> +struct tpdm_drvdata {
>>> +    void __iomem        *base;
>>> +    struct device        *dev;
>>> +    struct coresight_device    *csdev;
>>> +    struct mutex        lock;
>>
>> Why mutex lock ? Couldn't this be a spinlock ?
> 1. There is no irq for TPDM
> 2. As there are 7 dataset types, there will be some FOR loop to configure
> tpdm registers which may cause some time.
>
I think we can use mutex lock here. Do you have any more comments for this ?

Thanks
Jinlong Mao
>>
>>> +    bool            enable;
>>> +};
>>> +
>>> +#endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
>>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>>> index 247147c11231..a9efac55029d 100644
>>> --- a/include/linux/coresight.h
>>> +++ b/include/linux/coresight.h
>>> @@ -61,6 +61,7 @@ enum coresight_dev_subtype_source {
>>>       CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
>>>       CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
>>>       CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
>>> +    CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY,
>>
>> super minor nit: I find the choice of name a bit odd.
>> We could simply make it something like :
>>
>>     CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
>>
>> Suzuki
> I will check and update.
>>
>>>   };
>>>     enum coresight_dev_subtype_helper {
>>
>> _______________________________________________
>> CoreSight mailing list -- coresight@lists.linaro.org
>> To unsubscribe send an email to coresight-leave@lists.linaro.org
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
