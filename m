Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C4C58E05E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344836AbiHITne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344949AbiHITml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:42:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D2B26AC2;
        Tue,  9 Aug 2022 12:42:40 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JPfGD020412;
        Tue, 9 Aug 2022 19:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/awGMI2lYizOpcebEcEmTbdoQkmdMHXDsaHcv00Cuos=;
 b=iQoBaWsDX2OILgV9sRKquSwLSLADCyLi5trgYXYawAJ9gcr9k+ECGwMCISSFIm9ZbWyX
 KeLOXmJ7JLw4yyjAvg71FnZUre8NW+f0qHuVnXgIf/tWqti38OLuaAnlBNoLIR7pyX8F
 oh07NibVNsukNReF1Iwnpgx4zSBO72rrvbeBK1pqyfOpr1AsI9yk6vdQOum+7hSCGyCB
 FS/ZI+E6gVi98EoAymEV5yX+YGuNmkD2SL8UeIVioo5JJpC1H80xjGZk6wImZL2ztFTe
 NZX6tVwlFAhzWBX/V5MmckZtQGGZRMDlsvjOVKtzG/BxEwK9YSF2jsZoeJ9qZ0DY/GWO 1A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwqm811d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 19:42:36 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 279JgZHe015804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Aug 2022 19:42:35 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 12:42:35 -0700
Received: from [10.110.125.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 9 Aug 2022
 12:42:34 -0700
Message-ID: <5ad70f41-622e-2d75-7c53-89aba1255a5f@quicinc.com>
Date:   Tue, 9 Aug 2022 12:42:33 -0700
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
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <8705d52e-2181-aebd-43b8-2c8d021339c7@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wQFRCU8MgdG_ETcw8GXQs3mQC9fuQ7rW
X-Proofpoint-ORIG-GUID: wQFRCU8MgdG_ETcw8GXQs3mQC9fuQ7rW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=822 bulkscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208090074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2022 6:26 PM, Thinh Nguyen wrote:
> On 8/4/2022, Elson Serrao wrote:
>>
>>
>> On 8/2/2022 4:51 PM, Thinh Nguyen wrote:
>>> On 8/2/2022, Elson Roy Serrao wrote:
>>>> An interface which is in function suspend state has to send a function
>>>> wakeup notification to the host in case it needs to initate any data
>>>> transfer. One notable difference between this and the existing remote
>>>> wakeup mechanism is that this can be called per-interface, and a UDC
>>>> would need to know the particular interface number to convey in its
>>>> Device Notification transaction packet.  Hence, we need to introduce
>>>> a new callback in the gadget_ops structure that UDC device drivers
>>>> can implement.  Similarly add a convenience function in the composite
>>>> driver which function drivers can call. Add support to handle such
>>>> requests in the composite layer and invoke the gadget op.
>>>
>>> Sending the function wake notification should be done in the controller
>>> driver. The controller driver knows when is the proper link state
>>> (U0/ON) the device is in and would notify the host then.
>>>
>>> What we need to add in the usb_gadget is whether the device is remote
>>> wakeup capable. Something like a flag usb_gadget->rw_capable.
>>>
>>> We would also need some functions like usb_gadget_enable_remote_wakeup()
>>> and usb_gadget_disable_remote_wakeup() for the gadget driver to notify
>>> the controller driver when it checks against USB_CONFIG_ATT_WAKEUP in
>>> the bmAttributes configuration.
>>>
>>> BR,
>>> Thinh
>>
>>
>> If we handle this in controller driver, then it would fail to get the
>> right interface id when multiple functions have to send function wake
>> notification. As per USB3.0 spec (below snippets) a function can be
>> independently placed into function suspend state within a composite
>> device and each function in function suspend state has to send a
>> function wake notification to exit.
>>
>> USB 3.0 Spec Section 9.2.5.3
>> "A function may be placed into Function Suspend independently of other
>> functions within a composite device"
>>
>> USB 3.0 Spec Section 9.2.5.4
>> "A function may signal that it wants to exit from Function Suspend by
>> sending a Function Wake Notification to the host if it is enabled for
>> function remote wakeup. This applies to single function devices as
>> well as multiple function ( i.e., composite) devices. If the link is in
>> a non-U0 state, then the device must transition the link to U0 prior
>> to sending the remote wake message. If a remote wake event occurs in
>> multiple functions, each function shall send a Function Wake
>> Notification"
>>
> 
> Ok, so the issue here is adding the ability to pass the interface number
> to the controller driver when sending the device notification function
> wakeup right? Sounds like the callback should be
> send_wakeup_notification(gadget, func_id) instead.
> 
> As for remote wakeup, the spec states that "If remote wake event occurs
> in multiple functions, each function shall send a Function Wake
> Notification."
> 
> The SET_FEATURE(FUNCTION_SUSPEND) does not necessarily mean the host
> will put the device in Suspend State for a remote wake event to occur.
> It only places the function in Function Suspend. However often the host
> will put the device in suspend after this. The dwc3 driver can track if
> the host puts the device in suspend state and what interfaces are armed
> for remote wakeup. If a remote wakeup event occurs, the dwc3 driver can
> send Function Wake Notification for each function armed with remote wakeup.
> 
> Please correct me if I'm wrong.
> 
> Also, make sure that device remote wakeup will still work for highspeed
> (not function remote wakeup). I see this check which doesn't look right
> in one of your patches:
> +    if (g->speed < USB_SPEED_SUPER && !dwc->is_remote_wakeup_enabled)
> +        dev_err(dwc->dev, "%s:remote wakeup not supported\n", __func__);
> +        ret =  -EPERM;
> +        goto out;
> +    }
> 
> Thanks,
> Thinh
> 

For superspeed capable devices, when a function is in suspend state and 
wants to
initiate a resume, it has to send a function wake notification to the 
host irrespective
of whether the device is in SUSPEND or not. Like you mentioned the 
device need not be in
suspend state when a function is suspended. If the device is in suspend, 
then first the
controller driver has to transition the link to U0 state before sending 
function wake notification.
Note that the DEVICE_REMOTE_WAKEUP feature is ignored for super-speed 
devices and they
are by default remote wakeup capable if any function within the device 
is armed for
function remote wakeup.

So in my current implementation when the host sends a function suspend 
SET_FEATURE(FUNCTION_SUSPEND),
the device delegates it to the respective function driver. There we 
inspect if it is capable
of initiating a function remote wakeup. If it is, then when a remote 
wakeup event
occurs (in my current implementation when TCP/IP layer wants to send 
data to the host. patch#5) then
we trigger a function wakeup by calling usb_gadget_func_wakeup(gadget, 
id) callback. Controller driver then
checks if the device is in suspend or not. If it is in suspend, it first 
brings the device to U0 state
and then sends a function wake notification (via 
dwc3_send_gadget_generic_command() API) only after an
U0 event has occurred. If the device is not in suspend then it directly 
sends function wake notification
to the host. Once the host receives the function wake notification it 
sends a SET_FEATURE(FUNCTION_SUSPEND)
with suspend bit (BIT 0) reset to signal function resume. The controller 
driver upon receiving this packet
delegates to the respective function driver. Note that at this point the 
device is in U0 state but some other
function within the device may still be in suspend state (if more than 
one function was put to suspend state).
So the only way to exit from function suspend is via function resume 
which is independent of device suspend/resume.

Also the task of finding the interface id is done by composite driver 
because most function drivers have
a transport layer and this layer is the one responsible for issuing a 
function remote wakeup and
this has no direct reference to interface id. For example u_ether 
transport layer can have either f_ecm or f_rndis
as its underlying channel and u_ether has no knowledge of the interface 
id/function driver it is using.

For high speed devices there is no concept of function suspend and there 
is only device suspend. The ability
of a device to send a remote wakeup to exit from suspend is dictated by 
DEVICE_REMOTE_WAKEUP feature selector.
The below snippet controls this aspect and sends remote wakeup for high 
speed devices only if they are remote wakeup capable.
dwc->is_remote_wakeup_enabled flag is set when DEVICE_REMOTE_WAKEUP is 
received.

+    if (g->speed < USB_SPEED_SUPER && !dwc->is_remote_wakeup_enabled)
+        dev_err(dwc->dev, "%s:remote wakeup not supported\n", __func__);
+        ret =  -EPERM;
+        goto out;
+    }

Please let me know your thoughts on this approach. I will address your 
other comments and rectify the patches accordingly.

Thanks & Regards
Elson
