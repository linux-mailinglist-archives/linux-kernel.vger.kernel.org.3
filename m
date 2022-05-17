Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C7529DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbiEQJQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244446AbiEQJPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:15:00 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31927366AC;
        Tue, 17 May 2022 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652778898; x=1684314898;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zGMNwgf7AhJx+C2tSJI6ZcLVK4iVnN8x7Ixj+NE3fdg=;
  b=dk6pEZW1cu9w2LFX3VK6fRlwys9MpXRTa7EDahTg+iEmSUy+Ym6qmKPO
   4a6MzUiTQwvqcGrcsIgxtadRRPVLeVSqk2aenX+iUU7+5XKBv9n2YnSrj
   41zJQQ4LklfZGFyxzLcLeCSVo2ap+o684FVlBFsZOCkeT02CCBoJ6GXo7
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 May 2022 02:14:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:14:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 17 May 2022 02:14:56 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 17 May
 2022 02:14:53 -0700
Subject: Re: [PATCH v2] mailbox: qcom-ipcc: Log the pending interrupt during
 resume
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <bjorn.andersson@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <agross@kernel.org>, Prasad Sodagudi <quic_psodagud@quicinc.com>
References: <1652251404-30562-1-git-send-email-quic_sibis@quicinc.com>
 <20220512074312.GA35848@thinkpad>
 <5b8aa653-5af8-a54f-b7bd-4d758eac9019@quicinc.com>
 <20220512095952.GB35848@thinkpad>
 <76a15747-b06e-e869-078f-ac4ad2e4a5ec@quicinc.com>
 <20220516132737.GA5492@thinkpad>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <878688ab-9ee9-b353-d091-9cad7d725ade@quicinc.com>
Date:   Tue, 17 May 2022 14:44:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220516132737.GA5492@thinkpad>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/22 6:57 PM, Manivannan Sadhasivam wrote:
> On Thu, May 12, 2022 at 04:49:30PM +0530, Sibi Sankar wrote:
>>
>>
>> On 5/12/22 3:29 PM, Manivannan Sadhasivam wrote:
>>> On Thu, May 12, 2022 at 03:08:43PM +0530, Sibi Sankar wrote:
>>>> Hey Mani,
>>>>
>>>> Thanks for taking time to review the patch.
>>>>
>>>> On 5/12/22 1:13 PM, Manivannan Sadhasivam wrote:
>>>>> On Wed, May 11, 2022 at 12:13:24PM +0530, Sibi Sankar wrote:
>>>>>> From: Prasad Sodagudi <quic_psodagud@quicinc.com>
>>>>>>
>>>>>> Enable logging of the pending interrupt that triggered device wakeup. This
>>>>>> logging information helps to debug IRQs that cause periodic device wakeups
>>>>>> and prints the detailed information of pending IPCC interrupts instead of
>>>>>> the generic "Resume caused by IRQ 17, ipcc".
>>>>>>
>>>>>> Scenario: Device wakeup caused by Modem crash
>>>>>> Logs:
>>>>>> qcom-ipcc mailbox: virq: 182 triggered client-id: 2; signal-id: 2
>>>>>>
>>>>>>    From the IPCC bindings it can further understood that the client here is
>>>>>> IPCC_CLIENT_MPSS and the signal was IPCC_MPROC_SIGNAL_SMP2P.
>>>>>>
>>>>>> Signed-off-by: Prasad Sodagudi <quic_psodagud@quicinc.com>
>>>>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>>>> ---
>>>>>>
>>>>>> V2:
>>>>>>     * Fix build error when ipcc is a module [Kernel Test Bot]
>>>>>>
>>>>>>     drivers/mailbox/qcom-ipcc.c | 27 +++++++++++++++++++++++++++
>>>>>>     1 file changed, 27 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
>>>>>> index c5d963222014..21c071ec119c 100644
>>>>>> --- a/drivers/mailbox/qcom-ipcc.c
>>>>>> +++ b/drivers/mailbox/qcom-ipcc.c
>>>>>> @@ -254,6 +254,28 @@ static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc,
>>>>>>     	return devm_mbox_controller_register(dev, mbox);
>>>>>>     }
>>>>>> +#ifdef CONFIG_PM_SLEEP
>>>>>
>>>>> You don't need this guard anymore. Please see below.
>>>>
>>>> ack
>>>>
>>>>>
>>>>>> +static int qcom_ipcc_pm_resume(struct device *dev)
>>>>>> +{
>>>>>> +	struct qcom_ipcc *ipcc = dev_get_drvdata(dev);
>>>>>> +	u32 hwirq;
>>>>>> +	int virq;
>>>>>> +
>>>>>> +	hwirq = readl(ipcc->base + IPCC_REG_RECV_ID);
>>>>>> +	if (hwirq == IPCC_NO_PENDING_IRQ)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	virq = irq_find_mapping(ipcc->irq_domain, hwirq);
>>>>>> +
>>>>>> +	dev_info(dev, "virq: %d triggered client-id: %ld; signal-id: %ld\n", virq,
>>>>>> +		 FIELD_GET(IPCC_CLIENT_ID_MASK, hwirq), FIELD_GET(IPCC_SIGNAL_ID_MASK, hwirq));
>>>>>> +
>>>>>
>>>>> Does this really need to be dev_info? This looks like a dev_dbg() material to
>>>>> me.
>>>>
>>>> The whole point of the log is to catch sporadic issues like random
>>>> wakeups caused by remoteprocs through ipcc. We would just end up with
>>>> a single line identifying the client id during resume if ipcc had indeed
>>>> caused the wakeup else it wouldn't print anything.
>>>>
>>>
>>> Right but that information is only required for debugging the periodic wakeups.
>>> And that's not going to be useful for an end user.
>>
>> I would consider this an extension to "Resume caused by IRQ xx, xxxx"
> 
> May I know from where it is coming? I couldn't grep it.

My bad I happened to have an out of tree patch in there. And it happens 
that all the logging done related to wakeup are under debug so I'll 
convert mine as well in v3. Thanks for the review!

-Sibi

> 
>> print that we get to identify the wake up source. That's the reasoning
>> behind marking it as dev_info (being able to nail down random wakeups is
>> just an added advantage). That said I'll re-spin it with dbg if that's
>> the consensus.
>>
> 
> I'll leave it up to Jassi to decide. But this patch looks good to me otherwise.
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Thanks,
> Mani
> 
>>>
>>> Thanks,
>>> Mani
>>>
>>>> -Sibi
>>>>>
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +#else
>>>>>> +#define qcom_ipcc_pm_resume NULL
>>>>>> +#endif
>>>>>> +
>>>>>>     static int qcom_ipcc_probe(struct platform_device *pdev)
>>>>>>     {
>>>>>>     	struct qcom_ipcc *ipcc;
>>>>>> @@ -324,6 +346,10 @@ static const struct of_device_id qcom_ipcc_of_match[] = {
>>>>>>     };
>>>>>>     MODULE_DEVICE_TABLE(of, qcom_ipcc_of_match);
>>>>>> +static const struct dev_pm_ops qcom_ipcc_dev_pm_ops = {
>>>>>> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
>>>>>> +};
>>>>>> +
>>>>>>     static struct platform_driver qcom_ipcc_driver = {
>>>>>>     	.probe = qcom_ipcc_probe,
>>>>>>     	.remove = qcom_ipcc_remove,
>>>>>> @@ -331,6 +357,7 @@ static struct platform_driver qcom_ipcc_driver = {
>>>>>>     		.name = "qcom-ipcc",
>>>>>>     		.of_match_table = qcom_ipcc_of_match,
>>>>>>     		.suppress_bind_attrs = true,
>>>>>> +		.pm = &qcom_ipcc_dev_pm_ops,
>>>>>
>>>>> You can use the new pm_sleep_ptr() macro to avoid the PM_SLEEP guard.
>>>>>
>>>>> 		.pm = pm_sleep_ptr(&qcom_ipcc_dev_pm_ops),
>>>>
>>>> ack
>>>>
>>>>>
>>>>> Thanks,
>>>>> Mani
>>>>>
>>>>>>     	},
>>>>>>     };
>>>>>> -- 
>>>>>> 2.7.4
>>>>>>
>>>>>
>>>
> 
