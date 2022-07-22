Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8493F57D795
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiGVAEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGVAEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:04:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E8018374;
        Thu, 21 Jul 2022 17:04:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M00Cv0000361;
        Fri, 22 Jul 2022 00:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YQSnXFjnVnUtIC6vAkW2iOogDZHtPRkNMYTT5X/COyw=;
 b=H20JSMV7K/yd7grFLtpe1030/bAOx/447gXI3R+50Gs+oN+6ixlEe9xF4eYmiobqlmWq
 Mrucpi4tT4q3xp+vgEjcRWtI5DT9zLsL8flz194CDnFOebiYBhCfVw+61XXzdAiynF8B
 6FWIyhIRosHyKUJsER7y5BDU8OkWV7IeeazKgb+QFCI0ygb4TqMwRb/SQxgqyvUsQ/16
 sV2SynyGp+aw740kJMijF9dR4tIHFXvBFsH4sbuzzwpey0CwW/85qJQBE0IJZUHq1jzb
 0yH7pPnZNmUZmbNK/kncpy4BJ8mfECj2HZp5Vudj88v45q3p1oG78VAjRMqfokrECohw zQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3heue338w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 00:04:41 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26M04er5007644
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 00:04:40 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Jul 2022 17:04:39 -0700
Received: from [10.110.106.175] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Jul
 2022 17:04:39 -0700
Message-ID: <b431cfd5-65b8-aa31-ca13-a813a1ad2e10@quicinc.com>
Date:   Thu, 21 Jul 2022 17:04:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-5-quic_wcheng@quicinc.com>
 <d8d26ce3-6773-bd9c-e227-0924f239eae0@synopsys.com>
 <98623d02-cde4-b036-a85c-9325b58c7eab@quicinc.com>
 <5d0cf380-e045-fcec-639f-ac2f6a187ca8@synopsys.com>
 <5a57d5b9-b81e-bb09-998b-2915d9ab6b2f@quicinc.com>
 <fa172e2c-eff6-002e-3687-d87a2986fd42@synopsys.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <fa172e2c-eff6-002e-3687-d87a2986fd42@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: esfhC2GFSb7ExkrzHCqOcYxwmheXekZc
X-Proofpoint-ORIG-GUID: esfhC2GFSb7ExkrzHCqOcYxwmheXekZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 7/21/2022 5:00 PM, Thinh Nguyen wrote:
> On 7/21/2022, Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 7/21/2022 3:20 PM, Thinh Nguyen wrote:
>>> On 7/21/2022, Wesley Cheng wrote:
>>>> Hi Thinh,
>>>>
>>>> On 7/21/2022 3:08 PM, Thinh Nguyen wrote:
>>>>> Hi Wesley,
>>>>>
>>>>> On 7/12/2022, Wesley Cheng wrote:
>>>>>> If soft disconnect is in progress, allow the endxfer command to be
>>>>>> sent,
>>>>>> without this, there is an issue where the stop active transfer call
>>>>>> (during pullup disable) wouldn't actually issue the endxfer command,
>>>>>> while clearing the DEP flag.
>>>>>>
>>>>>> In addition, if the DWC3_EP_DELAY_STOP flag was set before soft
>>>>>> disconnect
>>>>>> started (i.e. from the dequeue path), ensure that when the EP0
>>>>>> transaction
>>>>>> completes during soft disconnect, to issue the endxfer with the force
>>>>>> parameter set, as it does not expect a command complete event.
>>>>>>
>>>>>> Fixes: e4cf6580ac740 ("usb: dwc3: gadget: Wait for ep0 xfers to
>>>>>> complete during dequeue")
>>>>>> Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>>>> ---
>>>>>> Link:
>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/1a1a5485-790e-79ce-f5a6-1e96d9b49a47@synopsys.com/__;!!A4F2R9G_pg!cXW2TlALYWnXNPg-NoMFUrQ8K1egEZiQizZ5CA1DOM1Gcw4tfOULy-_2eMGvL8pQPte5dScFON-0wxH2eXu8ijEQUbs$
>>>>>>
>>>>>>
>>>>>>      drivers/usb/dwc3/ep0.c    | 3 +--
>>>>>>      drivers/usb/dwc3/gadget.c | 5 ++++-
>>>>>>      2 files changed, 5 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>>>>>> index 506ef717fdc0..5851b0e9db0a 100644
>>>>>> --- a/drivers/usb/dwc3/ep0.c
>>>>>> +++ b/drivers/usb/dwc3/ep0.c
>>>>>> @@ -290,8 +290,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>>>>>>              if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
>>>>>>                  continue;
>>>>>>      -        dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
>>>>>
>>>>> If we don't clear this flag here,
>>>>>
>>>>
>>>> This is why I added the dwc->connected argument to control the
>>>> "interrupt" argument.
>>>>
>>>>>> - dwc3_stop_active_transfer(dwc3_ep, true, true);
>>>>>> +        dwc3_stop_active_transfer(dwc3_ep, true, dwc->connected);
>>>>>>          }
>>>>>>      }
>>>>>>      diff --git a/drivers/usb/dwc3/gadget.c
>>>>>> b/drivers/usb/dwc3/gadget.c
>>>>>> index ee85b773e3fe..41b7007358de 100644
>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>> @@ -1693,6 +1693,7 @@ static int __dwc3_stop_active_transfer(struct
>>>>>> dwc3_ep *dep, bool force, bool int
>>>>>>              dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
>>>>>>          else if (!ret)
>>>>>>              dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
>>>>>> +    dep->flags &= ~DWC3_EP_DELAY_STOP;
>>>>>>             return ret;
>>>>>>      }
>>>>>> @@ -3686,8 +3687,10 @@ void dwc3_stop_active_transfer(struct dwc3_ep
>>>>>> *dep, bool force,
>>>>>>          if (dep->number <= 1 && dwc->ep0state != EP0_DATA_PHASE)
>>>>>>              return;
>>>>>>      +    if (interrupt && (dep->flags & DWC3_EP_DELAY_STOP))
>>>>>> +        return;
>>>>>> +
>>>>>
>>>>> then it may not go through here. I think I made this same mistake
>>>>> in my
>>>>> previous suggestion.
>>>>>
>>>>
>>>> Since dwc->connected is set to FALSE before we call stop active
>>>> transfers, if we ever run into a situation where delayed stop is set
>>>> already, then it should go through.
>>>>
>>>
>>> Then the check for request dequeue that we did previously will not work
>>> anymore.
>>>
>>
>> Could you help clarify?  The pullup refactor kind of shifted some of
>> the previous checks we had in the dequeue path, and combined with with
>> the stop active transfer checks.
>>
>> I think there was an issue w/ the patch I submitted though.  the above
>> snippet should be replacing what is there:
>>
>> void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>>      bool interrupt)
>> {
>> ...
>>      if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
>>          /* Following should be removed --- (dep->flags &
>> DWC3_EP_DELAY_STOP) || */
>>          (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
>>          return;
>>
> 
> Request dequeue can occur while the device is connected. The
> DWC3_EP_DELAY_STOP intention is to delay sending the End Transfer
> command until the SETUP stage is prepared. If we don't clear the flag
> before the flag check, then the End Transfer command will not go through.
> 

Thanks, got it.  Understand what you mean now.  Let me think about how 
to go about it.  I probably don't see any issues as of now, because my 
test does the soft disconnect, which will do the stop active transfers 
forcefully.

Thanks
Wesley Cheng
