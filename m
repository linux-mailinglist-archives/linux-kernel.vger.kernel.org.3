Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CA159EE9B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiHWWG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiHWWGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:06:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F256DF81;
        Tue, 23 Aug 2022 15:06:23 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NL2mqn010598;
        Tue, 23 Aug 2022 22:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xER6nSHUP3QVzjEvz/o3PYgFqLFo1vElMN1TD+nj+HM=;
 b=J1vPrt7xxzLeFzXEY+IjoAeb4B7RxjOO7HktRL+ACSkDY29EFJ2Uzh0CHEVKEMiAgrfy
 Sf9e5pGsgDhsCUm8V51Y9je4pKeXRGaUdHTEaL9SbSz+lWXUQPyHAj1/H6BDNx0ilm+B
 veVhjfm6BRKz/kziHtDYyxTCNKyOsWIoyJmabnZhDDUG/i6B2LJZCA1mT1HeZtOzckb7
 0g74lkisHmXgUlPsotq4FI4/LrL1Tt/vENKMG0WZ/CAOwheRSqP/Jn0OXyHh0qxlld/n
 x+7HrmbuHf/vcBZDlHkGnPT5d0rw2U91CB02yntzxou0nIYDvKpsSjB9PSqtIR8hzHMN sg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pqgvpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 22:06:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27NM6IoD014993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 22:06:18 GMT
Received: from [10.110.67.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 15:06:17 -0700
Message-ID: <281aae0d-6146-bf65-cf23-2ddf7e16ae1c@quicinc.com>
Date:   Tue, 23 Aug 2022 15:06:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>
References: <8705d52e-2181-aebd-43b8-2c8d021339c7@synopsys.com>
 <5ad70f41-622e-2d75-7c53-89aba1255a5f@quicinc.com>
 <ac8e012f-08f3-baed-ead0-231f0527864c@synopsys.com>
 <b123b543-6c82-2787-9730-addd3e6e70a3@quicinc.com>
 <98966b47-0bc5-6ec0-ec80-5eff1d71d9fd@synopsys.com>
 <e3bcfd4c-efdb-c7b0-4e94-1afcd3b8eb73@synopsys.com>
 <1fac4c0f-4e8b-f333-7208-c50353a806f4@synopsys.com>
 <dc5cdba3-fcbc-79a2-797e-2553c727cba5@quicinc.com>
 <6e8de558-7183-d3f1-9ba7-83a612675e17@synopsys.com>
 <e22d4f8e-0ca7-056e-e5ec-4fc97cbaf08b@quicinc.com>
 <20220823010056.5yvd6223awab47vl@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20220823010056.5yvd6223awab47vl@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: grptKC8ATvkmtI8dhQbN8TJmDNGr8AdN
X-Proofpoint-GUID: grptKC8ATvkmtI8dhQbN8TJmDNGr8AdN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2022 6:01 PM, Thinh Nguyen wrote:
> On Thu, Aug 18, 2022 at 11:17:24AM -0700, Elson Serrao wrote:
>>
>>
>> On 8/16/2022 4:51 PM, Thinh Nguyen wrote:
>>> On 8/16/2022, Elson Serrao wrote:
>>>>
>>>>
>>>> On 8/12/2022 5:46 PM, Thinh Nguyen wrote:
>>>>> On 8/11/2022, Thinh Nguyen wrote:
>>>>>> On 8/11/2022, Thinh Nguyen wrote:
>>>>>>> On 8/11/2022, Elson Serrao wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 8/9/2022 6:08 PM, Thinh Nguyen wrote:
>>>>>>>
>>>>>>> <snip>
>>>>>>>
>>>>>>>
>>>>>>>>> To summarize the points:
>>>>>>>>>
>>>>>>>>> 1) The host only arms function remote wakeup if the device is
>>>>>>>>> capable of
>>>>>>>>> remote wakeup (check USB_CONFIG_ATT_WAKEUP in bmAttributes and
>>>>>>>>> hardware
>>>>>>>>> capability)
>>>>>>>>>
>>>>>>>>> 2) If the device is in suspend, the device can do remote wakeup
>>>>>>>>> (through
>>>>>>>>> LFPS handshake) if the function is armed for remote wakeup (through
>>>>>>>>> SET_FEATURE(FUNC_SUSPEND)).
>>>>>>>>>
>>>>>>>>> 3) If the link transitions to U0 after the device triggering a remote
>>>>>>>>> wakeup, the device will also send device notification function
>>>>>>>>> wake for
>>>>>>>>> all the interfaces armed with remote wakeup.
>>>>>>>>>
>>>>>>>>> 4) If the device is not in suspend, the device can send device
>>>>>>>>> notification function wake if it's in U0.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Now, remote wakeup and function wake device notification are 2
>>>>>>>>> separate
>>>>>>>>> operations. We have the usb_gadget_ops->wakeup() for remote wakeup. I
>>>>>>>>> suggested to maybe add
>>>>>>>>> usb_gadget_ops->send_wakeup_notification(gadget,
>>>>>>>>> intf_id) for the device notification. What you did was combining both
>>>>>>>>> operations in usb_gadget_ops->func_wakeup(). That may only work for
>>>>>>>>> point 4) (assuming you fix the U0 check), but not point 3).
>>>>>>>>
>>>>>>>> Thank you for your feedback and summary. I will rename func_wakeup to
>>>>>>>> send_wakeup_notification to better align with the approach. The
>>>>>>>> reason I
>>>>>>>> have combined remote_wakeup and function wake notification in
>>>>>>>> usb_gadget_ops->func_wakeup() is because since the implementation
>>>>>>>> is at
>>>>>>>> function/composite level it has no knowledge on the link state. So I
>>>>>>>> have delegated that task to controller driver to handle the
>>>>>>>> notification
>>>>>>>> accordingly. That is do a LFPS handshake first if the device is
>>>>>>>> suspended and then send notification (explained below). But we can
>>>>>>>> definitely separate this by adding an additional flag in the composite
>>>>>>>> layer to set the link state based on the gadget suspend callback
>>>>>>>> called
>>>>>>>> when U3 SUSPEND interrupt is received. Let me know if you feel
>>>>>>>> separating the two is a better approach.
>>>>>>>>
>>>>>>>
>>>>>>> The reason I think we need to separate it is because of point 3. As I
>>>>>>> note earlier, the spec states that "If remote wake event occurs in
>>>>>>> multiple functions, each function shall send a Function Wake
>>>>>>> Notification."
>>>>>>>
>>>>>>> But if there's no remote wake event, and the host brought the device up
>>>>>>> instead, then the function suspend state is retained.
>>>>>>>
>>>>>>> If we separate these 2 operations, the caller can check whether the
>>>>>>> operation went through properly. For example, if the wakeup() is
>>>>>>> initiated properly, but the function wake device notification didn't go
>>>>>>> through. We would only need to resend the device notification rather
>>>>>>> than initiate remote wakeup again.
>>>>>>
>>>>>> If we don't have to send device notification for other interfaces, we
>>>>>> can combine the operations here as you did.
>>>>>>
>>>>>
>>>>> I still think it's better to split up the operations. The way you're
>>>>> handling it now is not clear.
>>>>>
>>>>> If the func_awake() returns -EAGAIN, I'd expect that the remote wake did
>>>>> not go through and expect user to retry again. But here it does initiate
>>>>> remote wake, but it just does not send device notification yet. This is
>>>>> confusing.
>>>>>
>>>>> Also, instead of all the function wake handling coming from the function
>>>>> driver, now we depend on the controller driver to call function resume()
>>>>> on state change to U0, which will trigger device notification. What
>>>>> happen if it doesn't call resume(). There's too many dependencies and it
>>>>> seems fragile.
>>>>>
>>>>> I think all this can be handled in the function driver. You can fix the
>>>>> dwc3 wakeup() and poll for U0/ON state rather than RECOVERY state, which
>>>>> is what it's supposed to poll.
>>>>
>>>> For transitioning from U3 to U0, the current upstream implementation is
>>>> to poll for U0 state when dwc3_gadget_wakeup() is called and it is a
>>>> blocking call. (this is a common API for both HS and SS)
>>>>
>>>>       /* poll until Link State changes to ON */
>>>>       retries = 20000;
>>>>
>>>>       while (retries--) {
>>>>           reg = dwc3_readl(dwc->regs, DWC3_DSTS);
>>>>
>>>>           /* in HS, means ON */
>>>>           if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U0)
>>>>               break;
>>>>       }
>>>>
>>>> In my experiments I found that certain hosts take longer time to drive
>>>> HS resume signalling between the remote wakeup and the resume K and this
>>>> time varies across hosts. Hence the above polling timer is not generic
>>>> across hosts. So how do we converge on a polling timer value to work
>>>> across HS/SS and without blocking the system for a long time?
>>>
>>> Can't we take the upper limit of both base on experiment? And it
>>> shouldn't be blocking the whole system.
>>
>> On the host I was experimenting with, the time it took was around 110ms in
>> HS case. That would translate to a retry count of about ~181,000 in the
>> above polling loop. Wouldn't that be a very large value for polling?
>> And not sure if there are other hosts that take even longer time
> 
> We don't want to poll that many times. We shouldn't depend on the delay
> of a register read for polling interval. Can't we just sleep in between
> interval at a reasonable interval.
> 

Sleeping is not an option as the upper layers (those beyond 
function/composite layer) may transmit data with a lock held.

I ran into below BUG when remote wakeup was triggered via a ping() 
command and attempted sleep while polling

[   88.676789][  T392] BUG: scheduling while atomic
[   88.900112][  T392] Call trace:
<snip>
[   88.912760][  T392]  __schedule_bug+0x90/0x188
[   88.917335][  T392]  __schedule+0x714/0xb4c
[   88.930568][  T392]  schedule+0x110/0x204
[   88.943620][  T392]  schedule_timeout+0x94/0x134
[   88.948371][  T392]  __dwc3_gadget_wakeup+0x1ac/0x558
[   88.953558][  T392]  dwc3_gadget_wakeup+0x3c/0x8c
[   88.958388][  T392]  usb_gadget_wakeup+0x54/0x1a8
[   88.963222][  T392]  eth_start_xmit+0x130/0x830
[   88.967876][  T392]  xmit_one+0xf0/0x364
[   88.971913][  T392]  sch_direct_xmit+0x188/0x3e4
[   88.976663][  T392]  __dev_xmit_skb+0x480/0x984
[   88.981319][  T392]  __dev_queue_xmit+0x2d4/0x7d8
[   88.986151][  T392]  neigh_resolve_output+0x208/0x2f0
<snip>

The above experiment was done by removing spin_locks if any in the 
wakeup() path of  function/composite/controller drivers. It is running 
in atomic context due to the lock held by linux networking stack/generic 
packet scheduler.

So below are the only two approaches I can think of for 
dwc3_gadget_wakeup() API

1.)Polling based approach: We poll until the link comes up. But cannot 
sleep while polling due to above reasons.

2.)Interrupt based approach (the patches being discussed currently): 
When a remote wakeup is triggered enable link state interrupts and 
return right away. The function/composite drivers are later notified 
about the ON event via resume callback (in a similar way how we notify 
U3 to composite layer via suspend callback).

Please let me know if there is any alternate way that you can think of here.

>>>
>>>>
>>>> Some data layers like TCP/IP hold a TX lock while sending data (that
>>>> causes a remote wakeup event) and hence this wakeup() may run in atomic
>>>> context.
>>>
>>> Why hold the lock while waiting for the host to wakeup? The host is
>>> still inactive. Also, the usb_gadget_wakeup() API doesn't specify that
>>> it may run in atomic context.
>>>
>>
>> The lock might be held by upper layers who are unaware/independent of
>> underlying transport medium. The above TX lock I was referring to was
>> that held by Linux networking stack. It just pushes out data the same way it
>> would when USB is active. It is the function/composite layer being aware of
>> the function suspend would now sense this as a remote wake event and perform
>> this additional step of bringing out the link from u3 and then sending
>> device wakeup notification.
>>
>> In our current upstream implementation of dwc3_gadget_wakeup() API we hold a
>> spinlock as well. But yeah that can be rectified
> 
> Holding a spin_lock for this long is not reasonable. We only need to
> lock when setting link recovery request but not while polling for DSTS
> and waiting for the link to go up.
> 
> BR,
> Thinh
> 
>>
>> static int dwc3_gadget_wakeup(struct usb_gadget *g)
>> {
>> 	struct dwc3		*dwc = gadget_to_dwc(g);
>> 	unsigned long		flags;
>> 	int			ret;
>>
>> 	spin_lock_irqsave(&dwc->lock, flags);
>> 	ret = __dwc3_gadget_wakeup(dwc);
>> 	spin_unlock_irqrestore(&dwc->lock, flags);
>>
>> 	return ret;
>> }
>>
>>
>>>>
>>>> To make this generic across hosts, I had switched to interrupt based
>>>> approach, enabling link state events and return error value immediately
>>>> from the dwc3_gadget_wakeup() API after doing a LFPS handshake. But
>>>> yeah, then we have to rely on the resume callback as an indication that
>>>> link is transitioned to ON state.
>>>>
>>>
>>> BR,
>>> Thinh
