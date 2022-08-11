Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D158F759
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 07:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiHKFo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 01:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHKFoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 01:44:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EE365563;
        Wed, 10 Aug 2022 22:44:24 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B50DK7032662;
        Thu, 11 Aug 2022 05:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wEm4dm+jxVyusbWT26U78kyH3JylDzuoETX3tsmRvb8=;
 b=bCyjNd0rPWWy5jGZsv85PT0dX2LLzjkz3683OMVNEszjNYUJ36DIec4Ult7Vj04j65qk
 PAD13KdtB6xMZQFqwqDWH/+7eY71KESrL4Yy5w/lGdxRYgAgza6+MP8Y08tNPwmgV/mJ
 REoYv80CwgqrryxRPW2OY4EWO40MsZBwRqzI8moRNxQ9COSJSJnuPidFaWDj86RBcptI
 NuS1+bfMQitDzASD1Q8veMAlTckoyov4nrdPIObKW8fLBfUZbxst4jLq7l/Fwr5tiGoI
 8x3oJrcu9w+WHamBj/EC5/tt5XUCDlpNlR7YCOtm+9rHwNZS0m452rbwkNQus50ZaD8e ow== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hvh2a1r68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 05:44:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27B5i5eb003619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 05:44:05 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 22:44:04 -0700
Received: from [10.216.31.107] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 10 Aug
 2022 22:44:00 -0700
Message-ID: <456915bf-b7ff-efaa-72aa-62fd05344270@quicinc.com>
Date:   Thu, 11 Aug 2022 11:13:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 4/5] firmware: qcom: scm: Add wait-queue helper
 functions
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David Heidelberg" <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>
References: <1658529438-9234-1-git-send-email-quic_gurus@quicinc.com>
 <1658529438-9234-5-git-send-email-quic_gurus@quicinc.com>
 <1f284b9c-257b-a127-55c0-e6cc8c07a9eb@quicinc.com>
 <20220811030022.GA18104@quicinc.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220811030022.GA18104@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d3pspb0udKWEJJy4XUg4zyLZopqT6m1u
X-Proofpoint-ORIG-GUID: d3pspb0udKWEJJy4XUg4zyLZopqT6m1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_03,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=491
 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208110015
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/11/2022 8:30 AM, Guru Das Srinagesh wrote:
> Hey Rajendra,
> 
> Sorry for the delay in response. Needed to clarify with internal team members

no worries,

> on these questions before responding.
> 
> On Aug 02 2022 17:07, Rajendra Nayak wrote:
>>
>> On 7/23/2022 4:07 AM, Guru Das Srinagesh wrote:
>>> When the firmware (FW) supports multiple requests per VM, and the VM
>>> also supports it via the `allow-multi-call` device tree flag, the
>>> floodgates are thrown open for them to all reach the firmware at the
>>> same time.
> 
> [...]
> 
>>>    2) SCM_WAITQ_WAKE:
>>>
>>>    	When an SCM call receives this return value instead of success
>>>    	or error, FW wishes to signal HLOS to wake up a (different)
>>>    	previously sleeping call.
>>>
>>>    	FW tells HLOS which call to wake up via the additional return
>>>    	values `wq_ctx`, `smc_call_ctx` and `flags`. The first two have
>>>    	already been explained above.
>>>
>>>    	`flags` can be either WAKE_ONE or WAKE_ALL. Meaning, wake either
>>>    	one, or all, of the SCM calls that HLOS is associating with the
>>>    	given `wq_ctx`.
>>>
>>> A sleeping SCM call can be woken up by either an interrupt that FW
>>> raises, or via a SCM_WAITQ_WAKE return value for a new SCM call.
>>
>> Do you know why the FW was not designed to always use an interrupt?
>> That would have made the handling of this in kernel a lot less complicated.
> 
> Because:
> 
> 1. Our firmware in TrustZone cannot raise interrupts on its own - it needs the
> hypervisor to do that.
> 
> 2. Thus, in platforms where there is no hypervisor, there is no interrupt
> possible - only SMC_WAITQ_WAKE.
> 
> Therefore, relying only on an interrupt would render the driver unable to
> support platforms without a hypervisor, which we didn't want to do.

Thanks Guru for the clarification, however what problem are we really solving
with this on platforms _without_ a hypervisor?

Your cover letter said
'The problem this feature is fixing is as follows. In a scenario where there is
a VM in addition to HLOS (and an underlying hypervisor):'

So I assumed this was primarily for platforms _with_ a VM/Hypervisor?

I understand that even with just the HLOS and no VM, if we can get these requests
processed concurrently it still adds value, but eventually Trustzone will
still process these requests sequentially right?

>>> The handshake mechanism that HLOS uses to talk to FW about wait-queue
>>> operations involves three new SMC calls. These are:
>>>
> 
> [...]
> 
>>> +static void scm_irq_work(struct work_struct *work)
>>> +{
>>> +	int ret;
>>> +	u32 wq_ctx, flags, more_pending = 0;
>>> +	struct completion *wq_to_wake;
>>> +	struct qcom_scm_waitq *w = container_of(work, struct qcom_scm_waitq, scm_irq_work);
>>> +	struct qcom_scm *scm = container_of(w, struct qcom_scm, waitq);
>>> +
>>> +	do {
>>> +		ret = scm_get_wq_ctx(&wq_ctx, &flags, &more_pending);
>>> +		if (ret) {
>>> +			pr_err("GET_WQ_CTX SMC call failed: %d\n", ret);
>>> +			return;
>>> +		}
>>> +
>>> +		wq_to_wake = qcom_scm_lookup_wq(scm, wq_ctx);
>>> +		if (IS_ERR_OR_NULL(wq_to_wake)) {
>>> +			pr_err("No waitqueue found for wq_ctx %d: %ld\n",
>>> +					wq_ctx, PTR_ERR(wq_to_wake));
>>> +			return;
>>
>> What happens if at this point 'more_pending' was true? will the FW raise
>> another interrupt?
> 
> Hmm. At this point, the interrupt handler is early-exiting without waking up a
> sleeping call via the flag_handler() because firmware has goofed up and given
> it an invalid wq_ctx. We have bigger problems than `more_pending` being true.
> 
>>
>>> +		}
>>> +
>>> +		scm_waitq_flag_handler(wq_to_wake, flags);
>>> +	} while (more_pending);
>>> +}
> 
> Thank you.
> 
> Guru Das.
