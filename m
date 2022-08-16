Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA40D596367
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiHPT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHPT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:57:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E2D79A74;
        Tue, 16 Aug 2022 12:57:35 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GGI1R4010194;
        Tue, 16 Aug 2022 19:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HESUMwz8Kkq/bA7Cmdg/5s6tz64b87YQevezqxbVRI0=;
 b=aFpgxDZpMx8ZTDMlpZbdkU56nWMuqAIIYseBviwILQOOWDE6Oc03vMKkwPqhNJJuaIJe
 qoA/WWXq1uL7ilRWQJ7EbKBFCC5WsS4R/uiKkUWo8+u1aUV1/EG/OEZlWxiYzXRUZZRT
 MAiR0uG8TiksXnryQRsYmecUpPwXBT3XkRQoyr6urPlW+pXqFZFyU+hlfzlPooLlV8Ha
 3UmYK+ZcV8wScLQ8DFOys8uafPo6uESDvQoP9uz2UgS2QuU9Vt6LVqFwYFZV0JmCZrW+
 nuAdof8+/E79lC64eKK1AHXHuRB6TJYaK4no4e9VjX14KGP2BmXx1ZIYNJPNZ5vN3AtB DQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j06b9jfd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 19:57:30 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27GJvTTQ017831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 19:57:29 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 16 Aug 2022 12:57:29 -0700
Received: from [10.110.85.160] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 16 Aug
 2022 12:57:28 -0700
Message-ID: <dc5cdba3-fcbc-79a2-797e-2553c727cba5@quicinc.com>
Date:   Tue, 16 Aug 2022 12:57:28 -0700
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
 <b123b543-6c82-2787-9730-addd3e6e70a3@quicinc.com>
 <98966b47-0bc5-6ec0-ec80-5eff1d71d9fd@synopsys.com>
 <e3bcfd4c-efdb-c7b0-4e94-1afcd3b8eb73@synopsys.com>
 <1fac4c0f-4e8b-f333-7208-c50353a806f4@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <1fac4c0f-4e8b-f333-7208-c50353a806f4@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _8JoQb92KHYBsPd0n2jrpxoP7Plf9T4G
X-Proofpoint-ORIG-GUID: _8JoQb92KHYBsPd0n2jrpxoP7Plf9T4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208160074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/2022 5:46 PM, Thinh Nguyen wrote:
> On 8/11/2022, Thinh Nguyen wrote:
>> On 8/11/2022, Thinh Nguyen wrote:
>>> On 8/11/2022, Elson Serrao wrote:
>>>>
>>>>
>>>> On 8/9/2022 6:08 PM, Thinh Nguyen wrote:
>>>
>>> <snip>
>>>
>>>
>>>>> To summarize the points:
>>>>>
>>>>> 1) The host only arms function remote wakeup if the device is capable of
>>>>> remote wakeup (check USB_CONFIG_ATT_WAKEUP in bmAttributes and hardware
>>>>> capability)
>>>>>
>>>>> 2) If the device is in suspend, the device can do remote wakeup (through
>>>>> LFPS handshake) if the function is armed for remote wakeup (through
>>>>> SET_FEATURE(FUNC_SUSPEND)).
>>>>>
>>>>> 3) If the link transitions to U0 after the device triggering a remote
>>>>> wakeup, the device will also send device notification function wake for
>>>>> all the interfaces armed with remote wakeup.
>>>>>
>>>>> 4) If the device is not in suspend, the device can send device
>>>>> notification function wake if it's in U0.
>>>>>
>>>>>
>>>>> Now, remote wakeup and function wake device notification are 2 separate
>>>>> operations. We have the usb_gadget_ops->wakeup() for remote wakeup. I
>>>>> suggested to maybe add usb_gadget_ops->send_wakeup_notification(gadget,
>>>>> intf_id) for the device notification. What you did was combining both
>>>>> operations in usb_gadget_ops->func_wakeup(). That may only work for
>>>>> point 4) (assuming you fix the U0 check), but not point 3).
>>>>
>>>> Thank you for your feedback and summary. I will rename func_wakeup to
>>>> send_wakeup_notification to better align with the approach. The reason I
>>>> have combined remote_wakeup and function wake notification in
>>>> usb_gadget_ops->func_wakeup() is because since the implementation is at
>>>> function/composite level it has no knowledge on the link state. So I
>>>> have delegated that task to controller driver to handle the notification
>>>> accordingly. That is do a LFPS handshake first if the device is
>>>> suspended and then send notification (explained below). But we can
>>>> definitely separate this by adding an additional flag in the composite
>>>> layer to set the link state based on the gadget suspend callback called
>>>> when U3 SUSPEND interrupt is received. Let me know if you feel
>>>> separating the two is a better approach.
>>>>
>>>
>>> The reason I think we need to separate it is because of point 3. As I
>>> note earlier, the spec states that "If remote wake event occurs in
>>> multiple functions, each function shall send a Function Wake Notification."
>>>
>>> But if there's no remote wake event, and the host brought the device up
>>> instead, then the function suspend state is retained.
>>>
>>> If we separate these 2 operations, the caller can check whether the
>>> operation went through properly. For example, if the wakeup() is
>>> initiated properly, but the function wake device notification didn't go
>>> through. We would only need to resend the device notification rather
>>> than initiate remote wakeup again.
>>
>> If we don't have to send device notification for other interfaces, we
>> can combine the operations here as you did.
>>
> 
> I still think it's better to split up the operations. The way you're
> handling it now is not clear.
> 
> If the func_awake() returns -EAGAIN, I'd expect that the remote wake did
> not go through and expect user to retry again. But here it does initiate
> remote wake, but it just does not send device notification yet. This is
> confusing.
> 
> Also, instead of all the function wake handling coming from the function
> driver, now we depend on the controller driver to call function resume()
> on state change to U0, which will trigger device notification. What
> happen if it doesn't call resume(). There's too many dependencies and it
> seems fragile.
> 
> I think all this can be handled in the function driver. You can fix the
> dwc3 wakeup() and poll for U0/ON state rather than RECOVERY state, which
> is what it's supposed to poll.

For transitioning from U3 to U0, the current upstream implementation is 
to poll for U0 state when dwc3_gadget_wakeup() is called and it is a 
blocking call. (this is a common API for both HS and SS)

	/* poll until Link State changes to ON */
	retries = 20000;

	while (retries--) {
		reg = dwc3_readl(dwc->regs, DWC3_DSTS);

		/* in HS, means ON */
		if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U0)
			break;
	}

In my experiments I found that certain hosts take longer time to drive
HS resume signalling between the remote wakeup and the resume K and this 
time varies across hosts. Hence the above polling timer is not generic 
across hosts. So how do we converge on a polling timer value to work 
across HS/SS and without blocking the system for a long time?

Some data layers like TCP/IP hold a TX lock while sending data (that 
causes a remote wakeup event) and hence this wakeup() may run in atomic 
context.

To make this generic across hosts, I had switched to interrupt based 
approach, enabling link state events and return error value immediately 
from the dwc3_gadget_wakeup() API after doing a LFPS handshake. But 
yeah, then we have to rely on the resume callback as an indication that 
link is transitioned to ON state.



  On usb_gadget_wakeup() returns
> successful, we'd expect the device is linked up and woken up. then you
> can send device notification through a different api such as
> usb_gadget_send_wake_notification().
> 
> Thanks,
> Thinh

