Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D761598CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbiHRTmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiHRTmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:42:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49904D022C;
        Thu, 18 Aug 2022 12:42:09 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IHncIY003371;
        Thu, 18 Aug 2022 19:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Wozy6Im1+BYwMsxpqAwMsftPMqghP6KsBZQfC6UPYu8=;
 b=g+qWRP8Jhc0kBtXwRdw61jbYUia0HCjMZ1CGbNqKWfRF38HSzkLLCEirI6phq45HcYPE
 bkkQKdx8oW2eXwU70i/jVttubn+trP0PCI5m9S2z1AGXQsIyk7OstDKTZWSHYgPgFku/
 eXxpNFotvdLEDjqryIKjR5BiPI9b4+yIndjHhwvuvsAxG5s5KxE+IQd5EZeW5N8P7qlt
 thJJLHNLi9c5P+wQ9CRjnxd+QC8A9lRxPKFhfY2f76cVAISJh45L7neaM2kBtABwcOD5
 u5Wmiuk0kKFODHWX+z4SyzOxpgdWHj7GzfUeQx0fQgaZdOkJKmAmey+S6WTUWe7/WtjC vA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j1rvb0qf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 19:42:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27IJg01e014487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 19:42:00 GMT
Received: from [10.110.31.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 18 Aug
 2022 12:41:59 -0700
Message-ID: <b3d71d92-a748-4779-1b3d-011a4609d61d@quicinc.com>
Date:   Thu, 18 Aug 2022 12:41:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Content-Language: en-US
From:   Elson Serrao <quic_eserrao@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
 <1659467920-9095-3-git-send-email-quic_eserrao@quicinc.com>
 <049219f1-8c68-e4cc-7bf9-1e8c214e80aa@synopsys.com>
 <32a0765e-00d9-1a67-bf36-4060c5fcb008@quicinc.com>
 <8705d52e-2181-aebd-43b8-2c8d021339c7@synopsys.com>
 <5ad70f41-622e-2d75-7c53-89aba1255a5f@quicinc.com>
 <ac8e012f-08f3-baed-ead0-231f0527864c@synopsys.com>
 <b123b543-6c82-2787-9730-addd3e6e70a3@quicinc.com>
 <98966b47-0bc5-6ec0-ec80-5eff1d71d9fd@synopsys.com>
 <e3bcfd4c-efdb-c7b0-4e94-1afcd3b8eb73@synopsys.com>
 <1fac4c0f-4e8b-f333-7208-c50353a806f4@synopsys.com>
 <dc5cdba3-fcbc-79a2-797e-2553c727cba5@quicinc.com>
 <6e8de558-7183-d3f1-9ba7-83a612675e17@synopsys.com>
 <e22d4f8e-0ca7-056e-e5ec-4fc97cbaf08b@quicinc.com>
In-Reply-To: <e22d4f8e-0ca7-056e-e5ec-4fc97cbaf08b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E1l_6Vty-PJwBNPkwEb4yzHZXwikoV3-
X-Proofpoint-GUID: E1l_6Vty-PJwBNPkwEb4yzHZXwikoV3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_14,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2022 11:17 AM, Elson Serrao wrote:
> 
> 
> On 8/16/2022 4:51 PM, Thinh Nguyen wrote:
>> On 8/16/2022, Elson Serrao wrote:
>>>
>>>
>>> On 8/12/2022 5:46 PM, Thinh Nguyen wrote:
>>>> On 8/11/2022, Thinh Nguyen wrote:
>>>>> On 8/11/2022, Thinh Nguyen wrote:
>>>>>> On 8/11/2022, Elson Serrao wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 8/9/2022 6:08 PM, Thinh Nguyen wrote:
>>>>>>
>>>>>> <snip>
>>>>>>
>>>>>>
>>>>>>>> To summarize the points:
>>>>>>>>
>>>>>>>> 1) The host only arms function remote wakeup if the device is
>>>>>>>> capable of
>>>>>>>> remote wakeup (check USB_CONFIG_ATT_WAKEUP in bmAttributes and
>>>>>>>> hardware
>>>>>>>> capability)
>>>>>>>>
>>>>>>>> 2) If the device is in suspend, the device can do remote wakeup
>>>>>>>> (through
>>>>>>>> LFPS handshake) if the function is armed for remote wakeup (through
>>>>>>>> SET_FEATURE(FUNC_SUSPEND)).
>>>>>>>>
>>>>>>>> 3) If the link transitions to U0 after the device triggering a 
>>>>>>>> remote
>>>>>>>> wakeup, the device will also send device notification function
>>>>>>>> wake for
>>>>>>>> all the interfaces armed with remote wakeup.
>>>>>>>>
>>>>>>>> 4) If the device is not in suspend, the device can send device
>>>>>>>> notification function wake if it's in U0.
>>>>>>>>
>>>>>>>>
>>>>>>>> Now, remote wakeup and function wake device notification are 2
>>>>>>>> separate
>>>>>>>> operations. We have the usb_gadget_ops->wakeup() for remote 
>>>>>>>> wakeup. I
>>>>>>>> suggested to maybe add
>>>>>>>> usb_gadget_ops->send_wakeup_notification(gadget,
>>>>>>>> intf_id) for the device notification. What you did was combining 
>>>>>>>> both
>>>>>>>> operations in usb_gadget_ops->func_wakeup(). That may only work for
>>>>>>>> point 4) (assuming you fix the U0 check), but not point 3).
>>>>>>>
>>>>>>> Thank you for your feedback and summary. I will rename 
>>>>>>> func_wakeup to
>>>>>>> send_wakeup_notification to better align with the approach. The
>>>>>>> reason I
>>>>>>> have combined remote_wakeup and function wake notification in
>>>>>>> usb_gadget_ops->func_wakeup() is because since the implementation
>>>>>>> is at
>>>>>>> function/composite level it has no knowledge on the link state. So I
>>>>>>> have delegated that task to controller driver to handle the
>>>>>>> notification
>>>>>>> accordingly. That is do a LFPS handshake first if the device is
>>>>>>> suspended and then send notification (explained below). But we can
>>>>>>> definitely separate this by adding an additional flag in the 
>>>>>>> composite
>>>>>>> layer to set the link state based on the gadget suspend callback
>>>>>>> called
>>>>>>> when U3 SUSPEND interrupt is received. Let me know if you feel
>>>>>>> separating the two is a better approach.
>>>>>>>
>>>>>>
>>>>>> The reason I think we need to separate it is because of point 3. As I
>>>>>> note earlier, the spec states that "If remote wake event occurs in
>>>>>> multiple functions, each function shall send a Function Wake
>>>>>> Notification."
>>>>>>
>>>>>> But if there's no remote wake event, and the host brought the 
>>>>>> device up
>>>>>> instead, then the function suspend state is retained.
>>>>>>
>>>>>> If we separate these 2 operations, the caller can check whether the
>>>>>> operation went through properly. For example, if the wakeup() is
>>>>>> initiated properly, but the function wake device notification 
>>>>>> didn't go
>>>>>> through. We would only need to resend the device notification rather
>>>>>> than initiate remote wakeup again.
>>>>>
>>>>> If we don't have to send device notification for other interfaces, we
>>>>> can combine the operations here as you did.
>>>>>
>>>>
>>>> I still think it's better to split up the operations. The way you're
>>>> handling it now is not clear.
>>>>
>>>> If the func_awake() returns -EAGAIN, I'd expect that the remote wake 
>>>> did
>>>> not go through and expect user to retry again. But here it does 
>>>> initiate
>>>> remote wake, but it just does not send device notification yet. This is
>>>> confusing.
>>>>
>>>> Also, instead of all the function wake handling coming from the 
>>>> function
>>>> driver, now we depend on the controller driver to call function 
>>>> resume()
>>>> on state change to U0, which will trigger device notification. What
>>>> happen if it doesn't call resume(). There's too many dependencies 
>>>> and it
>>>> seems fragile.
>>>>
>>>> I think all this can be handled in the function driver. You can fix the
>>>> dwc3 wakeup() and poll for U0/ON state rather than RECOVERY state, 
>>>> which
>>>> is what it's supposed to poll.
>>>
>>> For transitioning from U3 to U0, the current upstream implementation is
>>> to poll for U0 state when dwc3_gadget_wakeup() is called and it is a
>>> blocking call. (this is a common API for both HS and SS)
>>>
>>>      /* poll until Link State changes to ON */
>>>      retries = 20000;
>>>
>>>      while (retries--) {
>>>          reg = dwc3_readl(dwc->regs, DWC3_DSTS);
>>>
>>>          /* in HS, means ON */
>>>          if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U0)
>>>              break;
>>>      }
>>>
>>> In my experiments I found that certain hosts take longer time to drive
>>> HS resume signalling between the remote wakeup and the resume K and this
>>> time varies across hosts. Hence the above polling timer is not generic
>>> across hosts. So how do we converge on a polling timer value to work
>>> across HS/SS and without blocking the system for a long time?
>>
>> Can't we take the upper limit of both base on experiment? And it
>> shouldn't be blocking the whole system.
> 
> On the host I was experimenting with, the time it took was around 110ms 
> in HS case. That would translate to a retry count of about ~181,000 in 
> the above polling loop. Wouldn't that be a very large value for polling?
> And not sure if there are other hosts that take even longer time

Also we may need additional buffer on the retry value to absorb the run 
to run variation.

Below is the retry count kernel logs from my HS mode experiment when a 
remote wakeup was triggered

[   83.014458][  T191] Start Polling
[   83.147318][  T191] End polling. Retry count:223193


/* poll until Link State changes to ON */
#define COUNT 500000
retries = COUNT;
pr_err("Start Polling\n");
while (retries--) {
		reg = dwc3_readl(dwc->regs, DWC3_DSTS);

		/* in HS, means ON */
		if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U0)
				break;
}
pr_err("End polling. Retry count:%d\n",(COUNT-retries));

>>
>>>
>>> Some data layers like TCP/IP hold a TX lock while sending data (that
>>> causes a remote wakeup event) and hence this wakeup() may run in atomic
>>> context.
>>
>> Why hold the lock while waiting for the host to wakeup? The host is
>> still inactive. Also, the usb_gadget_wakeup() API doesn't specify that
>> it may run in atomic context.
>>
> 
> The lock might be held by upper layers who are unaware/independent of 
> underlying transport medium. The above TX lock I was referring to was
> that held by Linux networking stack. It just pushes out data the same 
> way it would when USB is active. It is the function/composite layer 
> being aware of the function suspend would now sense this as a remote 
> wake event and perform this additional step of bringing out the link 
> from u3 and then sending device wakeup notification.
> 
> In our current upstream implementation of dwc3_gadget_wakeup() API we 
> hold a spinlock as well. But yeah that can be rectified
> 
> static int dwc3_gadget_wakeup(struct usb_gadget *g)
> {
>      struct dwc3        *dwc = gadget_to_dwc(g);
>      unsigned long        flags;
>      int            ret;
> 
>      spin_lock_irqsave(&dwc->lock, flags);
>      ret = __dwc3_gadget_wakeup(dwc);
>      spin_unlock_irqrestore(&dwc->lock, flags);
> 
>      return ret;
> }
> 
> 
>>>
>>> To make this generic across hosts, I had switched to interrupt based
>>> approach, enabling link state events and return error value immediately
>>> from the dwc3_gadget_wakeup() API after doing a LFPS handshake. But
>>> yeah, then we have to rely on the resume callback as an indication that
>>> link is transitioned to ON state.
>>>
>>
>> BR,
>> Thinh
>>
