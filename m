Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538504D214D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349974AbiCHTWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349970AbiCHTWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:22:13 -0500
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 03E5653E0E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:21:05 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1646767270; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: From: References: Cc: To: To: Subject: Subject:
 MIME-Version: Date: Message-ID: Sender: Sender;
 bh=XLY7VpjvIDcnykLa7qjBsjd1RrR9AWqPK35AMSqo2yo=; b=DUq9St2wP+WAbtKO55X+2Tek3Wh+I7T+w2Ull5389iyx3hyzUaTHx3jSSLkjK66BCXwoORRq
 rRfZjDmZlGz/Nwcipg2EVlJjn0aVF4vPZMK+iWPWxQdLfSQITIwGe0dL14efn+8WBrEVyt9h
 TcwaGYSQArl4jmdEs9TlrnyilLM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6227ac95ea5f8dddb5d73d33 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Mar 2022 19:20:53
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2383C4338F; Tue,  8 Mar 2022 19:20:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from [192.168.1.17] (cpe-75-80-185-151.san.res.rr.com [75.80.185.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95A65C4338F;
        Tue,  8 Mar 2022 19:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 95A65C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <2394ad0f-4c46-07c6-7fee-d73cb62db5a3@codeaurora.org>
Date:   Tue, 8 Mar 2022 11:20:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in
 ep cmd fails
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jung Daehwan <dh10.jung@samsung.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
 <6a1322c4-9589-f4de-d42c-d38af2e12e82@quicinc.com>
 <e3332511-82d3-2892-ad72-a0c167273174@synopsys.com>
 <01c4d42e-93cd-d293-f4e3-8c136049d87c@codeaurora.org>
 <894d54ad-b6f9-b942-be99-fe3ad102051b@synopsys.com>
 <dbd00cb1-b5d0-24e7-ef72-dff3765c26cf@codeaurora.org>
 <810de66c-7d73-fae0-9356-b06b48134ad6@synopsys.com>
 <1714910d-f923-d0c7-72a9-0c1d098f783f@codeaurora.org>
 <4371e407-7791-b0b5-dc8c-ad0be09acba4@synopsys.com>
 <e165c644-4ad0-b103-4f8b-2d3bc1b211f1@codeaurora.org>
 <b2eca3ba-5c36-c788-629c-016bd36be8a7@synopsys.com>
 <b0196760-0495-bd8d-7f41-e46f971b0beb@codeaurora.org>
 <d043eea8-b72e-f1ab-7f0d-93b3b0503de0@synopsys.com>
 <15aac89a-bf1d-9f30-6a9a-6d8fe97268ac@codeaurora.org>
 <594fbaf7-d9f0-a3a0-e660-880e12418282@synopsys.com>
 <1238af3f-3110-a1f2-808c-3c07282b4f14@codeaurora.org>
 <818209ae-f3c5-3740-20a2-d5463b0b168b@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
In-Reply-To: <818209ae-f3c5-3740-20a2-d5463b0b168b@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 3/7/2022 3:51 PM, Thinh Nguyen wrote:
> Hi Wesley,
> 
> Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 3/4/2022 4:53 PM, Thinh Nguyen wrote:
>>> Wesley Cheng wrote:
>>>> Hi Thinh,
>>>>
>>>> On 2/28/2022 7:02 PM, Thinh Nguyen wrote:
>>>>> Wesley Cheng wrote:
>>>>>> Hi Thinh,
>>>>>>
>>>>>> On 2/28/2022 5:09 PM, Thinh Nguyen wrote:
>>>>>>> Hi Wesley,
>>>>>>>
>>>>>
>>>>> <snip>
>>>>>
>>>>>>>
>>>>>>> [ 2181.481956865       0x9dc63f265]   dbg_complete: ep6in: trb ffffffc01e7f52a0 (E43:D43) buf 00000000ebaf0000 size 1x 0 ctrl 00000810 (hlcs:sC:normal)
>>>>>>> [ 2181.482044730       0x9dc63f8fc]   dbg_gadget_giveback: ep6in: req ffffff8860657500 length 8/8 zsI ==> 0
>>>>>>> [ 2181.482222490       0x9dc640651]   event (0000c040): ep0out: Transfer Complete (sIL) [Setup Phase]
>>>>>>> [ 2181.482273271       0x9dc640a20]   dbg_trace_log_ctrl: Get Interface Status(Intf = 4, Length = 20)
>>>>>>> [ 2181.482334782       0x9dc640ebc]   dbg_ep_queue: ep6in: req ffffff8860657500 length 0/8 zsI ==> -115
>>>>>>> [ 2181.482357386       0x9dc64106e]   dbg_prepare: ep6in: trb ffffffc01e7f52b0 (E44:D43) buf 00000000ea578000 size 1x 8 ctrl 00000811 (Hlcs:sC:normal)
>>>>>>> [ 2181.482391865       0x9dc641304]   dbg_send_ep_cmd: ep6in: cmd 'Update Transfer' [d0007] params 00000000 00000000 00000000 --> status: Successful
>>>>>>> [ 2181.482485615       0x9dc641a0d]   dbg_send_ep_cmd: ep0out: cmd 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>>>>>>> [ 2181.482565303       0x9dc642006]   event (000010c0): ep0out: Transfer Not Ready [0] (Not Active) [Data Phase]
>>>>>>> [ 2181.482719417       0x9dc642b96]   event (00002040): ep0out: Transfer Complete (Sil) [Data Phase]
>>>>>>> [ 2181.482814938       0x9dc6432c0]   dbg_gadget_giveback: ep0out: req ffffff87df84d900 length 20/20 zsI ==> 0
>>>>>>> [ 2181.482926084       0x9dc643b16]   event (000020c2): ep0in: Transfer Not Ready [0] (Not Active) [Status Phase]
>>>>>>> [ 2181.483024261       0x9dc644272]   dbg_send_ep_cmd: ep0in: cmd 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>>>>>>>
>>>>>>> The control status isn't completed here.
>>>>>>>
>>>>>>> [ 2181.483069521       0x9dc6445d7]   dbg_ep_dequeue: ep2in: req ffffff879f5a8b00 length 0/63680 zsI ==> -115
>>>>>>> [ 2181.496068792       0x9dc6814c9]   dbg_send_ep_cmd: ep2in: cmd 'End Transfer' [50d08] params 00000000 00000000 00000000 --> status: Timed Out
>>>>>>>
>>>>>>> But the dequeue may come when host already sent a new Setup packet.
>>>>>>> The ep0out hasn't started yet at the point.
>>>>>>>
>>>>>>> Due to various system latency, I can see that this can happen when
>>>>>>> the dwc3 driver hasn't received the interrupt notified the status stage
>>>>>>> event yet.
>>>>>>>
>>>>>>> If that's the case, the host may have already sent the Setup packet
>>>>>>> at this point. So the End Transfer may get stuck if the Setup packet
>>>>>>> isn't DMA out yet.
>>>>>>>
>>>>>>> Can you try the change below to see if it resolves the issue?
>>>>>> Thanks, Thinh.  Sure I'll give it a try with this change.  This is very
>>>>>> similar to the change proposed here as well:
>>>>>>
>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20220216000835.25400-3-quic_wcheng@quicinc.com/__;!!A4F2R9G_pg!KlgSpNELOXQydIQuarA3A4NJXIcvHslXqzOdBwYqUIR97Mqdp8zdyezhOC9EJ6UqxLxM$ 
>>>>>>
>>>>>
>>>>> Not sure if this completely resolves the issue here. The change seems to
>>>>> issue the End Transfer command before Start Transfer for the next Setup
>>>>> stage completes. Also it's missing some checks for async calls to the
>>>>> endpoint that's pending dequeue. Also, we may not need to wait for End
>>>>> Transfer command to time out if we know the condition to avoid.
>>>>>
>>>>>> One thing to mention is that, I'm not sure how dependable checking soley
>>>>>> the ep0state would be.  I've seen some scenarios where we'd run into the
>>>>>> end transfer timeout during the time between inspecting the SETUP packet
>>>>>> (dwc3_ep0_inspect_setup()) and when the data phase is queued.  The
>>>>>> timing of the data phase can potentially differ if it is a vendor
>>>>>> specific control request.
>>>>>
>>>>> This timeout should only apply to Setup packet and Setup stage. Even if
>>>>> it's vendor specific control request, it should be fine. Host should not
>>>>> issue a Setup packet until it receives a status stage (unless there's a
>>>>> disconnect in the middle of a control transfer, but that's a different
>>>>> issue).
>>>>>
>>>>> If you do see a problem. We can take a look further.
>>>>>
>>>> So far so good w/ the testing.  Had to make a small change in your patch
>>>> to fix a typo:
>>>>                 if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
>>>>                         continue;
>>>>
>>>>                 dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
>>>>                 ret = dwc3_stop_active_transfer(dwc3_ep, true, true);
>>>>
>>>> Was using dep instead of dwc3_ep.  Will let this run over the weekend
>>>> and get back to you.
>>>>
>>>
>>> Ok. This seems to confirm my suspicion. Can you update the patch with
>>> the following adjustment:
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index 3e75eaa13abc..c3f7529f64fc 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -2309,6 +2309,10 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
>>>                 if (r == req) {
>>>                         struct dwc3_request *t;
>>>
>>> +                       if (dwc->ep0state != EP0_SETUP_PHASE &&
>>> +                           !dwc->delayed_status)
>>> +                               dep->flags |= DWC3_EP_DELAY_STOP;
>>> +
>>>                         /* wait until it is processed */
>>>                         dwc3_stop_active_transfer(dep, true, true);
>>>
>>> This is to avoid a case if the function driver has some dependency for
>>> requests to return before sending the control status using delayed
>>> status, which can cause a hang.
>>>
>>> We only need to make sure not to issue End Transfer after the status
>>> transfer started and before its completion interrupt, which may prevent
>>> the driver from starting the Setup stage.
>>>
>>
>> Added the above change, and tested it over the weekend and it was
>> working well for me.  However, I wasn't able to really test the
>> delayed_status flag too much, since we don't have a function driver that
>> utilizes the USB_GADGET_DELAYED_STATUS too much. (we only have a FFS
>> interface, which will do it during enum, which is part of the test case
>> I ran)
>>
> 
> Thanks for the test. The delayed status check is only meant for a
> special case if the function driver waits for dequeued requests to
> return before sending the control status. No function driver is doing
> this at the moment, but I want to put the check here anyway for robustness.
> 
>> Would it also make sense to check for the dwc->setup_packet_pending flag
>> as well in the same IF condition?  That would mean that there was a
>> SETUP packet cached in the controller, which would need to be handled.
>> I heard from our CC w/ Synopsys that we need to ensure any pending SETUP
>> packets stored in internal memory needed to be cleared as well before
>> issuing the endxfer.
> 
> Currently the dwc3 driver doesn't handle setup_packet_pending. It only
> uses that flag to handle some quirk. It should be fine when it is
> implemented (at some point eventually :)).
> 
> If the EP0_SETUP_PHASE flag is set, that means that the driver had setup
> the TRB for the Setup stage, so the Setup packet can be DMA'ed out
> within the End Transfer timeout. When the handling of
> setup_packet_pending is implemented, it should properly update the ep0state.
> 
> Note: hitting the pending setup packet should be rare. It can happen when
> 1) Host aborts the control transfer for some reason and start a new one
> 2) The device is disconnected in the middle of the control transfer
> 
> If you plan to implement/handle this scenario, I'll be happy to review
> your changes.
> 
> 

Thanks for the explanation, Thinh.  Let me see if I can revisit the
setup_packet_pending scenario we ran into in the past, and if its still
applicable, I'll submit a separate fix for it.  Its been a few years
since we've seen that :).

>>
>> This sounds similar to your statement previously about if the SETUP
>> packet wasn't DMA'ed out yet.
>>
>> Thanks
>> Wesley Cheng
>>
> 
> Please submit this fix separately from your other RFC patches so it can
> go into the driver.
> 

Sounds good.  Will take this change outside the RFC series and submit it
to go in.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
