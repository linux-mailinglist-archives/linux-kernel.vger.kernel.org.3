Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801765907A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiHKVDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiHKVDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:03:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C5D85AB2;
        Thu, 11 Aug 2022 14:03:33 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BKQ11i002040;
        Thu, 11 Aug 2022 21:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sgJVhzdM7qnYrGoNs56lS57dHNZPC9GAjp/HN+ehElU=;
 b=dr7rX5m8GR/gLlYfT0CazfEZBtu7mMW2fNj+RWiyG/2CQKlN7jgIhz2VzyFI8zRMz2jI
 D5rTP7G/0WEEP+I5vfUTaxqbqrzJQFY8fes1GxjFWEh0X2TM8kwXjcReapx1n+k+1VB2
 zBHOsJac5FYOg7qHdDzZivNEJHUrYZz/0KeAMYZ3LivAhkkFA2I7ceR+GWUPKglHKNBG
 diYEhfBDCQuMvWxMM8J2s6GUPibecAAaB6VZ1WpLd5KZxpUM2vpfRkatikAjIHB4epKf
 qZHXjtmnH/iXAZfHTcIfJEJK0pRAQ74Z9jXbCXns5hDQCv1hDMFrhVzc/plZXmk7Pmh4 Yg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hv95ywu1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 21:03:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27BL3S26000400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 21:03:28 GMT
Received: from [10.71.115.139] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 11 Aug
 2022 14:03:27 -0700
Message-ID: <19a7f8da-b655-b21d-8bcb-a60e30a8d5f8@quicinc.com>
Date:   Thu, 11 Aug 2022 14:03:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Content-Language: en-US
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
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <ac8e012f-08f3-baed-ead0-231f0527864c@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rzJTF_ahxAaN6Xvx_2Ht9W0mokt40kiE
X-Proofpoint-GUID: rzJTF_ahxAaN6Xvx_2Ht9W0mokt40kiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_13,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110063
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2022 6:08 PM, Thinh Nguyen wrote:
> On 8/9/2022, Elson Serrao wrote:
>>
>>
>> On 8/4/2022 6:26 PM, Thinh Nguyen wrote:
>>> On 8/4/2022, Elson Serrao wrote:
>>>>
>>>>
>>>> On 8/2/2022 4:51 PM, Thinh Nguyen wrote:
>>>>> On 8/2/2022, Elson Roy Serrao wrote:
>>>>>> An interface which is in function suspend state has to send a function
>>>>>> wakeup notification to the host in case it needs to initate any data
>>>>>> transfer. One notable difference between this and the existing remote
>>>>>> wakeup mechanism is that this can be called per-interface, and a UDC
>>>>>> would need to know the particular interface number to convey in its
>>>>>> Device Notification transaction packet.  Hence, we need to introduce
>>>>>> a new callback in the gadget_ops structure that UDC device drivers
>>>>>> can implement.  Similarly add a convenience function in the composite
>>>>>> driver which function drivers can call. Add support to handle such
>>>>>> requests in the composite layer and invoke the gadget op.
>>>>>
>>>>> Sending the function wake notification should be done in the controller
>>>>> driver. The controller driver knows when is the proper link state
>>>>> (U0/ON) the device is in and would notify the host then.
>>>>>
>>>>> What we need to add in the usb_gadget is whether the device is remote
>>>>> wakeup capable. Something like a flag usb_gadget->rw_capable.
>>>>>
>>>>> We would also need some functions like
>>>>> usb_gadget_enable_remote_wakeup()
>>>>> and usb_gadget_disable_remote_wakeup() for the gadget driver to notify
>>>>> the controller driver when it checks against USB_CONFIG_ATT_WAKEUP in
>>>>> the bmAttributes configuration.
>>>>>
>>>>> BR,
>>>>> Thinh
>>>>
>>>>
>>>> If we handle this in controller driver, then it would fail to get the
>>>> right interface id when multiple functions have to send function wake
>>>> notification. As per USB3.0 spec (below snippets) a function can be
>>>> independently placed into function suspend state within a composite
>>>> device and each function in function suspend state has to send a
>>>> function wake notification to exit.
>>>>
>>>> USB 3.0 Spec Section 9.2.5.3
>>>> "A function may be placed into Function Suspend independently of other
>>>> functions within a composite device"
>>>>
>>>> USB 3.0 Spec Section 9.2.5.4
>>>> "A function may signal that it wants to exit from Function Suspend by
>>>> sending a Function Wake Notification to the host if it is enabled for
>>>> function remote wakeup. This applies to single function devices as
>>>> well as multiple function ( i.e., composite) devices. If the link is in
>>>> a non-U0 state, then the device must transition the link to U0 prior
>>>> to sending the remote wake message. If a remote wake event occurs in
>>>> multiple functions, each function shall send a Function Wake
>>>> Notification"
>>>>
>>>
>>> Ok, so the issue here is adding the ability to pass the interface number
>>> to the controller driver when sending the device notification function
>>> wakeup right? Sounds like the callback should be
>>> send_wakeup_notification(gadget, func_id) instead.
>>>
>>> As for remote wakeup, the spec states that "If remote wake event occurs
>>> in multiple functions, each function shall send a Function Wake
>>> Notification."
>>>
>>> The SET_FEATURE(FUNCTION_SUSPEND) does not necessarily mean the host
>>> will put the device in Suspend State for a remote wake event to occur.
>>> It only places the function in Function Suspend. However often the host
>>> will put the device in suspend after this. The dwc3 driver can track if
>>> the host puts the device in suspend state and what interfaces are armed
>>> for remote wakeup. If a remote wakeup event occurs, the dwc3 driver can
>>> send Function Wake Notification for each function armed with remote
>>> wakeup.
>>>
>>> Please correct me if I'm wrong.
>>>
>>> Also, make sure that device remote wakeup will still work for highspeed
>>> (not function remote wakeup). I see this check which doesn't look right
>>> in one of your patches:
>>> +    if (g->speed < USB_SPEED_SUPER && !dwc->is_remote_wakeup_enabled)
>>> +        dev_err(dwc->dev, "%s:remote wakeup not supported\n", __func__);
>>> +        ret =  -EPERM;
>>> +        goto out;
>>> +    }
>>>
>>> Thanks,
>>> Thinh
>>>
>>
>> For superspeed capable devices, when a function is in suspend state and
>> wants to
>> initiate a resume, it has to send a function wake notification to the
>> host irrespective
>> of whether the device is in SUSPEND or not. Like you mentioned the
>> device need not be in
>> suspend state when a function is suspended. If the device is in suspend,
>> then first the
>> controller driver has to transition the link to U0 state before sending
>> function wake notification.
> 
> Was I incorrect? I'm not clear on the point of reiteration above.
> 
>> Note that the DEVICE_REMOTE_WAKEUP feature is ignored for super-speed
>> devices and they
> 
> We're still talking about Enhanced Super Speed here.
> 
>> are by default remote wakeup capable if any function within the device
>> is armed for
>> function remote wakeup.
> 
> What you're saying is if the host arms the function for remote wakeup,
> then the device is remote capable.
> 
> However, the important point here is that the host only arms for remote
> wakeup _if_ the device is remote wakeup capable. That needs to be checked.
> 
>>
>> So in my current implementation when the host sends a function suspend
>> SET_FEATURE(FUNCTION_SUSPEND),
>> the device delegates it to the respective function driver. There we
>> inspect if it is capable
>> of initiating a function remote wakeup. If it is, then when a remote
>> wakeup event
>> occurs (in my current implementation when TCP/IP layer wants to send
>> data to the host. patch#5) then
>> we trigger a function wakeup by calling usb_gadget_func_wakeup(gadget,
>> id) callback. Controller driver then
>> checks if the device is in suspend or not. If it is in suspend, it first
>> brings the device to U0 state
> 
> "brings the device to U0 state" means the device initiates remote wakeup
> here.
> 
>> and then sends a function wake notification (via
>> dwc3_send_gadget_generic_command() API) only after an
> 
> So now the dwc3 tracks which interface(s) were armed for remote here?
> 
> I don't recall seeing it in your patches. Did you handle and send device
> notification for all the functions armed with remote wakeup after device
> wakeup?
> 
> 
>> U0 event has occurred. If the device is not in suspend then it directly
>> sends function wake notification
>> to the host. Once the host receives the function wake notification it
>> sends a SET_FEATURE(FUNCTION_SUSPEND)
>> with suspend bit (BIT 0) reset to signal function resume. The controller
>> driver upon receiving this packet
>> delegates to the respective function driver. Note that at this point the
>> device is in U0 state but some other
> 
> We can't assume that the device is in U0 state. There's also no
> mechanism in your change to know that either.
> 
>> function within the device may still be in suspend state (if more than
>> one function was put to suspend state).
>> So the only way to exit from function suspend is via function resume
>> which is independent of device suspend/resume.
>>
>> Also the task of finding the interface id is done by composite driver
>> because most function drivers have
>> a transport layer and this layer is the one responsible for issuing a
>> function remote wakeup and
>> this has no direct reference to interface id. For example u_ether
>> transport layer can have either f_ecm or f_rndis
>> as its underlying channel and u_ether has no knowledge of the interface
>> id/function driver it is using.
>>
> 
>> For high speed devices there is no concept of function suspend and there
>> is only device suspend. The ability
>> of a device to send a remote wakeup to exit from suspend is dictated by
>> DEVICE_REMOTE_WAKEUP feature selector.
>> The below snippet controls this aspect and sends remote wakeup for high
>> speed devices only if they are remote wakeup capable.
>> dwc->is_remote_wakeup_enabled flag is set when DEVICE_REMOTE_WAKEUP is
>> received.
>>
> 
> The flag "is_remote_wakeup_enabled" implies that it applies for both
> device remote wakeup and function remote wakeup. If it only meant for
> function remote wakeup, then rename it. But I think you can use the same
> flag for both scenarios.
> 
> 
>> +    if (g->speed < USB_SPEED_SUPER && !dwc->is_remote_wakeup_enabled)
>> +        dev_err(dwc->dev, "%s:remote wakeup not supported\n", __func__);
>> +        ret =  -EPERM;
> 
> Also, don't use -EPERM. Use -EINVAL.
> 
>> +        goto out;
>> +    }
>>
>> Please let me know your thoughts on this approach. I will address your
>> other comments and rectify the patches accordingly.
>>
> 
> 
> To summarize the points:
> 
> 1) The host only arms function remote wakeup if the device is capable of
> remote wakeup (check USB_CONFIG_ATT_WAKEUP in bmAttributes and hardware
> capability)
> 
> 2) If the device is in suspend, the device can do remote wakeup (through
> LFPS handshake) if the function is armed for remote wakeup (through
> SET_FEATURE(FUNC_SUSPEND)).
> 
> 3) If the link transitions to U0 after the device triggering a remote
> wakeup, the device will also send device notification function wake for
> all the interfaces armed with remote wakeup.
> 

I am not clear on why device notification function wake should be sent 
for ALL interfaces armed with remote wakeup. Since function 
suspend/wakeup of an interface is independent of other functions in a 
composite device only the interface in which a remote wakeup event 
occurred should send the wake notification right? The other functions 
will continue to remain
in function suspend state.

> 4) If the device is not in suspend, the device can send device
> notification function wake if it's in U0.
> 
> 
> Now, remote wakeup and function wake device notification are 2 separate
> operations. We have the usb_gadget_ops->wakeup() for remote wakeup. I
> suggested to maybe add usb_gadget_ops->send_wakeup_notification(gadget,
> intf_id) for the device notification. What you did was combining both
> operations in usb_gadget_ops->func_wakeup(). That may only work for
> point 4) (assuming you fix the U0 check), but not point 3).
> 
> To be able to do 3), you can teach the composite layer _when_ to send
> device notification function wake and for what functions. This can be
> retry sending the notification until send_wakeup_notification() succeed?
> 
> I suggested to do that in dwc3 driver to avoid having to add the logic
> in composite layer as I think it is simpler in dwc3. However, the
> downside is that other UDCs have to handle it like dwc3 also.
> 
> Now that I think about it again, it maybe better to do it in the
> composite driver for the long run. If you want to handle this in the
> composite layer, please document and design the mechanism to handle all
> the points above.
> 
> Thanks,
> Thinh
> 
