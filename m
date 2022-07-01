Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D5E563267
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbiGALVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiGALVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:21:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFD873592;
        Fri,  1 Jul 2022 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656674471; x=1688210471;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=evxnpVz1IPTfMG5wbCSbSz2OpAW1Bk/cWvUFOXU9RLM=;
  b=yFF4k53EgPZbcwvu5p38fhVxkqGck3SM7R028an/nxEEAZms2qbEKROm
   vL+QrJKd9FT6ukyE24/KV0ZBgygHrH7PNyvehkhu6tAhTNe35Q93hkm/L
   4+JU1YDy4QbnvfU3lQS+i6paHx1Gp6JgrDQKCu1E4tfF3gxiQ5oW1JhLA
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 01 Jul 2022 04:21:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 04:21:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Jul 2022 04:21:09 -0700
Received: from [10.216.5.206] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 1 Jul 2022
 04:21:04 -0700
Message-ID: <ad5e875d-e5d7-3b6f-4915-98ba08df8c5d@quicinc.com>
Date:   Fri, 1 Jul 2022 16:51:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/5] firmware: qcom: scm: Add wait-queue handling logic
Content-Language: en-US
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <1656359076-13018-1-git-send-email-quic_gurus@quicinc.com>
 <1656359076-13018-6-git-send-email-quic_gurus@quicinc.com>
 <ec04538b-93e2-fa93-4043-c489a0f228e8@quicinc.com>
In-Reply-To: <ec04538b-93e2-fa93-4043-c489a0f228e8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/2022 4:32 PM, Rajendra Nayak wrote:
> 
> 
> On 6/28/2022 1:14 AM, Guru Das Srinagesh wrote:
>> Add logic to handle QCOM_SCM_WAITQ_SLEEP or QCOM_SCM_WAITQ_WAKE return
>> codes.
>>
>> Scenario 1: Requests made by 2 different VMs:
>>
>>    VM_1                     VM_2                            Firmware
>>      │                        │                                 │
>>      │                        │                                 │
>>      │                        │                                 │
>>      │                        │                                 │
>>      │      REQUEST_1         │                                 │
>>      ├────────────────────────┼─────────────────────────────────┤
>>      │                        │                                 │
>>      │                        │                              ┌──┼──┐
>>      │                        │                              │  │  │
>>      │                        │     REQUEST_2                │  │  │
>>      │                        ├──────────────────────────────┼──┤  │
>>      │                        │                              │  │  │Resource
>>      │                        │                              │  │  │is busy
>>      │                        │       {WQ_SLEEP}             │  │  │
>>      │                        │◄─────────────────────────────┼──┤  │
>>      │                        │  wq_ctx, smc_call_ctx        │  │  │
>>      │                        │                              └──┼──┘
>>      │   REQUEST_1 COMPLETE   │                                 │
>>      │◄───────────────────────┼─────────────────────────────────┤
>>      │                        │                                 │
>>      │                        │         IRQ                     │
>>      │                        │◄─-------------------------------│
>>      │                        │                                 │
>>      │                        │      get_wq_ctx()               │
>>      │                        ├────────────────────────────────►│
>>      │                        │                                 │
>>      │                        │                                 │
>>      │                        │◄────────────────────────────────┤
>>      │                        │   wq_ctx, flags, and            │
>>      │                        │        more_pending             │
>>      │                        │                                 │
>>      │                        │                                 │
>>      │                        │ wq_resume(smc_call_ctx)         │
>>      │                        ├────────────────────────────────►│
>>      │                        │                                 │
>>      │                        │                                 │
>>      │                        │      REQUEST_2 COMPLETE         │
>>      │                        │◄────────────────────────────────┤
>>      │                        │                                 │
>>      │                        │                                 │
>>
>> Scenario 2: Two Requests coming in from same VM:
>>
>>    VM_1                                                     Firmware
>>      │                                                          │
>>      │                                                          │
>>      │                                                          │
>>      │                                                          │
>>      │      REQUEST_1                                           │
>>      ├──────────────────────────────────────────────────────────┤
>>      │                                                          │
>>      │                                                     ┌────┼───┐
>>      │                                                     │    │   │
>>      │                                                     │    │   │
>>      │                                                     │    │   │
>>      │      REQUEST_2                                      │    │   │
>>      ├─────────────────────────────────────────────────────┼───►│   │
>>      │                                                     │    │   │Resource
>>      │                                                     │    │   │is busy
>>      │      {WQ_SLEEP}                                     │    │   │
>>      │◄────────────────────────────────────────────────────┼────┤   │
>>      │      wq_ctx, req2_smc_call_ctx                      │    │   │
>>      │                                                     │    │   │
>>      │                                                     └────┼───┘
>>      │                                                          │
>>      │      {WQ_WAKE}                                           │
>>      │◄─────────────────────────────────────────────────────────┤
>>      │      wq_ctx, req1_smc_call_ctx, flags                    │
> 
> 
> This is perhaps the same thing I asked on the previous patch,
> I am guessing {WQ_WAKE} is returned in respone to REQUEST_1?
> How do you know in this case if REQUEST_1 was a success or failure?
> 

Ok looking at this some more, I think what we are saying is that the FW returns
{WQ_WAKE} to REQUEST_1, we then call wq_wake_ack and the return of
*that* will tell if REQUEST_1 was success or failure?
Did I get it right?

  
> 
>>      │                                                          │
>>      │                                                          │
>>      │      wq_wake_ack(req1_smc_call_ctx)                      │
>>      ├─────────────────────────────────────────────────────────►│
>>      │                                                          │
>>      │      REQUEST_1 COMPLETE                                  │
>>      │◄─────────────────────────────────────────────────────────┤
>>      │                                                          │
>>      │                                                          │
>>      │      wq_resume(req_2_smc_call_ctx)                       │
>>      ├─────────────────────────────────────────────────────────►│
>>      │                                                          │
>>      │      REQUEST_2 COMPLETE                                  │
>>      │◄─────────────────────────────────────────────────────────┤
>>      │                                                          │
>>
>> With the exception of get_wq_ctx(), the other two newly-introduced SMC
>> calls, wq_ack() and wq_resume() can themselves return WQ_SLEEP (these
>> nested rounds of WQ_SLEEP are not shown in the above diagram for the
>> sake of simplicity). Therefore, introduce a new do-while loop to handle
>> multiple WQ_SLEEP return values for the same parent SCM call.
>>
>> Request Completion in the above diagram refers to either a success
>> return value (zero) or error (and not SMC_WAITQ_SLEEP or
>> SMC_WAITQ_WAKE).
>>
>> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
>> ---
>>   drivers/firmware/qcom_scm-smc.c | 79 +++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 72 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom_scm-smc.c
>> index 4150da1..fe95cc3 100644
>> --- a/drivers/firmware/qcom_scm-smc.c
>> +++ b/drivers/firmware/qcom_scm-smc.c
>> @@ -53,6 +53,9 @@ static void __scm_smc_do_quirk(const struct arm_smccc_args *smc,
>>       } while (res->a0 == QCOM_SCM_INTERRUPTED);
>>   }
>> +#define IS_WAITQ_SLEEP_OR_WAKE(res) \
>> +    (res->a0 == QCOM_SCM_WAITQ_SLEEP || res->a0 == QCOM_SCM_WAITQ_WAKE)
>> +
>>   static void fill_wq_resume_args(struct arm_smccc_args *resume, u32 smc_call_ctx)
>>   {
>>       memset(resume->args, 0, ARRAY_SIZE(resume->args));
>> @@ -109,25 +112,80 @@ int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending)
>>       return 0;
>>   }
>> -static void __scm_smc_do(const struct arm_smccc_args *smc,
>> +static int scm_smc_do_quirk(struct device *dev, struct arm_smccc_args *smc,
>> +                struct arm_smccc_res *res)
>> +{
>> +    struct completion *wq = NULL;
>> +    struct qcom_scm *qscm;
>> +    u32 wq_ctx, smc_call_ctx, flags;
>> +
>> +    do {
>> +        __scm_smc_do_quirk(smc, res);
>> +
>> +        if (IS_WAITQ_SLEEP_OR_WAKE(res)) {
>> +            wq_ctx = res->a1;
>> +            smc_call_ctx = res->a2;
>> +            flags = res->a3;
>> +
>> +            if (!dev)
>> +                return -EPROBE_DEFER;
>> +
>> +            qscm = dev_get_drvdata(dev);
>> +            wq = qcom_scm_lookup_wq(qscm, wq_ctx);
>> +            if (IS_ERR_OR_NULL(wq)) {
>> +                pr_err("No waitqueue found for wq_ctx %d: %ld\n",
>> +                        wq_ctx, PTR_ERR(wq));
>> +                return PTR_ERR(wq);
>> +            }
>> +
>> +            if (res->a0 == QCOM_SCM_WAITQ_SLEEP) {
>> +                wait_for_completion(wq);
>> +                fill_wq_resume_args(smc, smc_call_ctx);
>> +                wq = NULL;
>> +                continue;
>> +            } else {
>> +                fill_wq_wake_ack_args(smc, smc_call_ctx);
>> +                continue;
>> +            }
>> +        } else if ((long)res->a0 < 0) {
>> +            /* Error, simply return to caller */
>> +            break;

if my understanding above is correct, shouldn't we do a
>> +            if (wq)
>> +                scm_waitq_flag_handler(wq, flags);
in the error case also?

Also why no just scm_waitq_flag_handler(wq, flags); before fill_wq_wake_ack_args(smc, smc_call_ctx);?

>> +        } else {
>> +            /*
>> +             * Success.
>> +             * wq will be set only if a prior WAKE happened.
>> +             * Its value will be the one from the prior WAKE.
>> +             */
>> +            if (wq)
>> +                scm_waitq_flag_handler(wq, flags);
>> +            break;
>> +        }
>> +    } while (IS_WAITQ_SLEEP_OR_WAKE(res));
>> +
>> +    return 0;
>> +}
>> +
>> +static int __scm_smc_do(struct device *dev, struct arm_smccc_args *smc,
>>                struct arm_smccc_res *res, bool atomic)
>>   {
>> -    int retry_count = 0;
>> +    int ret, retry_count = 0;
>>       if (atomic) {
>>           __scm_smc_do_quirk(smc, res);
>> -        return;
>> +        return 0;
>>       }
>>       do {
>>           if (!qcom_scm_allow_multicall)
>>               mutex_lock(&qcom_scm_lock);
>> -        __scm_smc_do_quirk(smc, res);
>> +        ret = scm_smc_do_quirk(dev, smc, res);
>>           if (!qcom_scm_allow_multicall)
>>               mutex_unlock(&qcom_scm_lock);
>> +        if (ret)
>> +            return ret;
>>           if (res->a0 == QCOM_SCM_V2_EBUSY) {
>>               if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
>> @@ -135,6 +193,8 @@ static void __scm_smc_do(const struct arm_smccc_args *smc,
>>               msleep(QCOM_SCM_EBUSY_WAIT_MS);
>>           }
>>       }  while (res->a0 == QCOM_SCM_V2_EBUSY);
>> +
>> +    return 0;
>>   }
>> @@ -143,7 +203,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>>              struct qcom_scm_res *res, bool atomic)
>>   {
>>       int arglen = desc->arginfo & 0xf;
>> -    int i;
>> +    int i, ret;
>>       dma_addr_t args_phys = 0;
>>       void *args_virt = NULL;
>>       size_t alloc_len;
>> @@ -195,19 +255,24 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
>>           smc.args[SCM_SMC_LAST_REG_IDX] = args_phys;
>>       }
>> -    __scm_smc_do(&smc, &smc_res, atomic);
>> +    ret = __scm_smc_do(dev, &smc, &smc_res, atomic);
>> +    /* ret error check follows after args_virt cleanup*/
>>       if (args_virt) {
>>           dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
>>           kfree(args_virt);
>>       }
>> +    if (ret)
>> +        return ret;
>> +
>>       if (res) {
>>           res->result[0] = smc_res.a1;
>>           res->result[1] = smc_res.a2;
>>           res->result[2] = smc_res.a3;
>>       }
>> -    return (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) : 0;
>> +    ret = (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) : 0;
>> +    return ret;
>>   }
