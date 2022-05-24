Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8E5323D7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbiEXHPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiEXHPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:15:46 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77C85AA66;
        Tue, 24 May 2022 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653376545; x=1684912545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o1deSnlVZaJUiL95RTHbdcraQdrqHnneaLqHhAeeC18=;
  b=RSKwbAX+jJK8NtYmeDZLTizW5pjwSuS2R0tcft+GJVKtwZnFkxAHaQRN
   OPp+qpywgApLFGJCbqxqyAUtLsvruifOH9sq/YS95sgFbLKvLmjSPbYyv
   DngZ4nJQE+2amo0NJBs3omrSYc4JI+L8YAabrv7GJlDCa/MRLIeZxqrPf
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 May 2022 00:15:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:15:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 00:15:44 -0700
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 24 May
 2022 00:15:39 -0700
Message-ID: <ec586900-f4eb-18ee-57cb-17b9a7193b1e@quicinc.com>
Date:   Tue, 24 May 2022 15:15:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v7 04/10] coresight-tpdm: Add DSB dataset support
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <20220509133947.20987-5-quic_jinlmao@quicinc.com>
 <00c30f02-de4e-6bd1-f220-00ae114ef91f@arm.com>
 <c6c37c9c-c68d-a945-d4df-526212924678@arm.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <c6c37c9c-c68d-a945-d4df-526212924678@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

Hi Suzuki,

On 5/23/2022 5:24 PM, Suzuki K Poulose wrote:
> On 23/05/2022 10:11, Suzuki K Poulose wrote:
>> Hi
>>
>> On 09/05/2022 14:39, Mao Jinlong wrote:
>>> TPDM serves as data collection component for various dataset types.
>>> DSB(Discrete Single Bit) is one of the dataset types. DSB subunit
>>> can be enabled for data collection by writing 1 to the first bit of
>>> DSB_CR register. This change is to add enable/disable function for
>>> DSB dataset by writing DSB_CR register.
>>
>> The patch looks good to me, except for some minor comment below.
>>
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-tpdm.c | 58 
>>> ++++++++++++++++++++
>>>   drivers/hwtracing/coresight/coresight-tpdm.h | 23 ++++++++
>>>   2 files changed, 81 insertions(+)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> index 6a4e2a35053d..70df888ac565 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> @@ -20,7 +20,28 @@
>>>   DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>>> +static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>>> +{
>>> +    u32 val;
>>> +
>>> +    /* Set the enable bit of DSB control register to 1 */
>>> +    val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>>> +    val |= TPDM_DSB_CR_ENA;
>>> +    writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>>> +}
>>> +
>
>
>
>>>   /* TPDM enable operations */
>>> +static void _tpdm_enable(struct tpdm_drvdata *drvdata)
>
>
>>>   /* TPDM disable operations */
>>> +static void _tpdm_disable(struct tpdm_drvdata *drvdata)
>
> Missed this. The general convention is to use:
>
> __tpdm_disable()
> __tpdm_enable();
I will address your comments.
>
> So, please switch to the names above.
>
> Suzuki
