Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39C04CDFFE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiCDV7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiCDV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:59:42 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 6547427C79E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:58:46 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1646431134; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: From: References: Cc: To: To: Subject: Subject:
 MIME-Version: Date: Message-ID: Sender: Sender;
 bh=uvIDaNqG7x+9wSm31lF1xIq7+m5RcffN5HMJr9xvguw=; b=NUS13OQm8K/I67PAeB70bH+zVf39kdx8FxQCWuxHZgsdO0VmXeZQSNkm8oDjYPDXNSaCbp8K
 /nIomQ3Ulg7e6relfkbJmRYDubhdLjpQd57tifiLZOS/q6CZDAik/3pg7RrzxYmXxHpqa4rs
 +Iq40MTftvMrgO9TcNkvskc0mok=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 62228b892f1b1e8f79ab6546 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 04 Mar 2022 21:58:33
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A19D4C43616; Fri,  4 Mar 2022 21:58:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
Received: from [192.168.1.17] (cpe-75-80-185-151.san.res.rr.com [75.80.185.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B52B7C4338F;
        Fri,  4 Mar 2022 21:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B52B7C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <15aac89a-bf1d-9f30-6a9a-6d8fe97268ac@codeaurora.org>
Date:   Fri, 4 Mar 2022 13:58:29 -0800
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
 <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
 <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
 <20220215063925.GC144890@ubuntu>
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
From:   Wesley Cheng <wcheng@codeaurora.org>
In-Reply-To: <d043eea8-b72e-f1ab-7f0d-93b3b0503de0@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 2/28/2022 7:02 PM, Thinh Nguyen wrote:
> Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 2/28/2022 5:09 PM, Thinh Nguyen wrote:
>>> Hi Wesley,
>>>
> 
> <snip>
> 
>>>
>>> [ 2181.481956865       0x9dc63f265]   dbg_complete: ep6in: trb ffffffc01e7f52a0 (E43:D43) buf 00000000ebaf0000 size 1x 0 ctrl 00000810 (hlcs:sC:normal)
>>> [ 2181.482044730       0x9dc63f8fc]   dbg_gadget_giveback: ep6in: req ffffff8860657500 length 8/8 zsI ==> 0
>>> [ 2181.482222490       0x9dc640651]   event (0000c040): ep0out: Transfer Complete (sIL) [Setup Phase]
>>> [ 2181.482273271       0x9dc640a20]   dbg_trace_log_ctrl: Get Interface Status(Intf = 4, Length = 20)
>>> [ 2181.482334782       0x9dc640ebc]   dbg_ep_queue: ep6in: req ffffff8860657500 length 0/8 zsI ==> -115
>>> [ 2181.482357386       0x9dc64106e]   dbg_prepare: ep6in: trb ffffffc01e7f52b0 (E44:D43) buf 00000000ea578000 size 1x 8 ctrl 00000811 (Hlcs:sC:normal)
>>> [ 2181.482391865       0x9dc641304]   dbg_send_ep_cmd: ep6in: cmd 'Update Transfer' [d0007] params 00000000 00000000 00000000 --> status: Successful
>>> [ 2181.482485615       0x9dc641a0d]   dbg_send_ep_cmd: ep0out: cmd 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>>> [ 2181.482565303       0x9dc642006]   event (000010c0): ep0out: Transfer Not Ready [0] (Not Active) [Data Phase]
>>> [ 2181.482719417       0x9dc642b96]   event (00002040): ep0out: Transfer Complete (Sil) [Data Phase]
>>> [ 2181.482814938       0x9dc6432c0]   dbg_gadget_giveback: ep0out: req ffffff87df84d900 length 20/20 zsI ==> 0
>>> [ 2181.482926084       0x9dc643b16]   event (000020c2): ep0in: Transfer Not Ready [0] (Not Active) [Status Phase]
>>> [ 2181.483024261       0x9dc644272]   dbg_send_ep_cmd: ep0in: cmd 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>>>
>>> The control status isn't completed here.
>>>
>>> [ 2181.483069521       0x9dc6445d7]   dbg_ep_dequeue: ep2in: req ffffff879f5a8b00 length 0/63680 zsI ==> -115
>>> [ 2181.496068792       0x9dc6814c9]   dbg_send_ep_cmd: ep2in: cmd 'End Transfer' [50d08] params 00000000 00000000 00000000 --> status: Timed Out
>>>
>>> But the dequeue may come when host already sent a new Setup packet.
>>> The ep0out hasn't started yet at the point.
>>>
>>> Due to various system latency, I can see that this can happen when
>>> the dwc3 driver hasn't received the interrupt notified the status stage
>>> event yet.
>>>
>>> If that's the case, the host may have already sent the Setup packet
>>> at this point. So the End Transfer may get stuck if the Setup packet
>>> isn't DMA out yet.
>>>
>>> Can you try the change below to see if it resolves the issue?
>> Thanks, Thinh.  Sure I'll give it a try with this change.  This is very
>> similar to the change proposed here as well:
>>
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20220216000835.25400-3-quic_wcheng@quicinc.com/__;!!A4F2R9G_pg!KlgSpNELOXQydIQuarA3A4NJXIcvHslXqzOdBwYqUIR97Mqdp8zdyezhOC9EJ6UqxLxM$ 
>>
> 
> Not sure if this completely resolves the issue here. The change seems to
> issue the End Transfer command before Start Transfer for the next Setup
> stage completes. Also it's missing some checks for async calls to the
> endpoint that's pending dequeue. Also, we may not need to wait for End
> Transfer command to time out if we know the condition to avoid.
> 
>> One thing to mention is that, I'm not sure how dependable checking soley
>> the ep0state would be.  I've seen some scenarios where we'd run into the
>> end transfer timeout during the time between inspecting the SETUP packet
>> (dwc3_ep0_inspect_setup()) and when the data phase is queued.  The
>> timing of the data phase can potentially differ if it is a vendor
>> specific control request.
> 
> This timeout should only apply to Setup packet and Setup stage. Even if
> it's vendor specific control request, it should be fine. Host should not
> issue a Setup packet until it receives a status stage (unless there's a
> disconnect in the middle of a control transfer, but that's a different
> issue).
> 
> If you do see a problem. We can take a look further.
> 
So far so good w/ the testing.  Had to make a small change in your patch
to fix a typo:
                if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
                        continue;

                dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
                ret = dwc3_stop_active_transfer(dwc3_ep, true, true);

Was using dep instead of dwc3_ep.  Will let this run over the weekend
and get back to you.

Thanks
Wesley Cheng

>>
>> This is what led me to try w/ marking the endxfer delay after getting a
>> timed out scenario.  Just something to consider :).  I'll let you know
>> how it goes!  Thanks again.
>>
>> Thanks
>> Wesley Cheng
>>
>>> Code is not tested. Let me know if the logic makes sense. The change is
>>> to delay End Transfer when the Start Transfer for ep0out is completed.
>>>
> 
> Thanks,
> Thinh

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
