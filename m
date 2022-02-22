Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB334C00F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiBVSJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiBVSJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:09:01 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 82112171861
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:08:33 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1645553314; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=Uz8QSe9v82YHvd0VvIK+r3m7YCF+d8pxe72VvR7cFe8=; b=tbUI/yUOvryoK0AwWRKnsYthod0HxZ2zed0ZJvGh2tE3oN50EBnYqPrenWouh15k2jOf5QVV
 J39HyTlt6kkdwcf/JtRTk2ktHVVRvDAlBjD0f4VykLtbdI8wW6Eshy9j0gnfanpklEJL5XmC
 ZU8rHJuV1s7m7u5ZTd3DGYAT59k=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6215269ed099c7c4e3b9cf1f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Feb 2022 18:08:30
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C5BA2C43619; Tue, 22 Feb 2022 18:08:29 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED893C4338F;
        Tue, 22 Feb 2022 18:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org ED893C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <01c4d42e-93cd-d293-f4e3-8c136049d87c@codeaurora.org>
Date:   Tue, 22 Feb 2022 10:08:27 -0800
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
From:   Wesley Cheng <wcheng@codeaurora.org>
In-Reply-To: <e3332511-82d3-2892-ad72-a0c167273174@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 2/17/2022 3:43 PM, Thinh Nguyen wrote:
> Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 2/15/2022 9:14 AM, Thinh Nguyen wrote:
>>> Jung Daehwan wrote:
>>>> Hi Thinh,
>>>>
>>>> On Mon, Feb 14, 2022 at 06:44:33PM +0000, Thinh Nguyen wrote:
>>>>> Hi,
>>>>>
>>>>> Daehwan Jung wrote:
>>>>>> It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
>>>>>> even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
>>>>>
>>>>> How does it fail? Timed out?
>>>>
>>>> Yes, timed out.
>>>>>
>>>>>> skipping clear stall commmand or giveback from dequeue. We fix to set it
>>>>>> only when ep cmd success. Additionally, We clear DWC3_EP_TRANSFER_STARTED
>>>>>> for next trb to start transfer not update transfer.
>>>>>
>>>>> We shouldn't do this. Things will be out of sync. It may work for 1
>>>>> scenario, but it won't work for others.
>>>>>
>>>>> Please help me understand a few things:
>>>>>
>>>>> 1) What is the scenario that triggers this? Is it random?
>>>>>
>>>> ep cmd timeout occurs on dequeue request from user side. End Transfer command
>>>> would be sent in dwc3_stop_active transfer.
>>>
>>> At the high level, what's triggering the request dequeue? Is it from a
>>> disconnect, change of interface, or simply function driver protocol that
>>> changes it.
>>>
>>> What application was used to trigger this?
>>>
>> Sorry for jumping in here, but looks like Daehwan is running into a
>> similar issue I am seeing as well.
>>
>> At least in my scenario, the dequeue is coming from a function driver
>> which exposes a device to userspace.  Once that device is closed, it
>> will issue a dequeue on all pending/submitted requests.
> 
> Dequeuing request is coming from the function driver, but what causes
> the dequeue. For example, the End Transfer command due to a disconnect
> may give a different clues than a dequeue from a change of interface.
> 
For us, once the application exits, the corresponding userspace
device/port is closed.  This triggers the function driver to clean up
any pending/queued USB requests.  It doesn't have any association w/ any
USB cable disconnect, or interface change in this case, it is controlled
solely on the application exiting/stopped.
>>
>>>>
>>>>> 2) Are there other traffics pending while issuing the End Transfer
>>>>> command? If so, what transfer type(s)?
>>>>>
>>>> I haven't checked it yet. 
>>>
>>> Can you check?
>>>
>> For the cases where we've collected a crash log, we can see that during
>> the END transfer timeouts there was always a pending EP0 transaction.
>> We had reached out to our internal HW folks to get some inputs on what
>> could be causing this kind of issue, and we were able to get some
>> recommendations from their Synopsis POCs.
> 
> It's "Synopsys" :)
> 
Sorry! :)
>>
>> It was mentioned that if there was an active EP0 transfer, an end
>> transfer command on a non-control EP can fail w/ timed out.
>>
> 
> What controller version are you using? And what version is Jung using?
> Do you have the STAR number of the issue. If you're using a different
> version than Jung's, then it may not be the same issue.
> 
We're using 1.90a.

>>>>
>>>>> 3) Have you tried increasing the timeout?
>>>>>
>>>> No, I haven't.
>>>
>>> Can you try up to 10 seconds (just for experiment)
>>>
>> I've tried this too, and it did not help.
>>
>>>>> BR,
>>>>> Thinh
>>>>>
>>>>
>>>> This issue occurs very rarely on customer. I only have restricted
>>>> information. That's why I've been trying to reproduce it.
>>>
>>> How did you test your fix if you can't reproduce it?
>>>
>>>>
>>>> Wesley may have run into same issue and you can see this issue in detail.
>>>> https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=9d423b69-fc3fd32e-9d43b026-74fe485fff30-77a099b52659410d&q=1&e=20b4d9f5-2599-4f57-8b6a-7c4ec167d228&u=https*3A*2F*2Flore.kernel.org*2Flinux-usb*2F20220203080017.27339-1-quic_wcheng*40quicinc.com*2F__;JSUlJSUlJQ!!A4F2R9G_pg!JWPzNLoO3BFX_IZCVzmHPtxq6frr_VFbSNNaxSQylunt1Y4EauTOefth2LCIcVEuTx8E$ 
>>>>
>>>
>>> I can take a look, but please provide the tracepoints of the failure if
>>> you can reproduce it.
>>>
>> Let me see if I have any previous traces I can share.  If not, I have a
>> pretty reliable repro set up I can collect a trace for you.  For now, I
>> will focus on just getting the endxfer timeout seen during ep dequeue.
>> As mentioned on my patchset, this can happen during device-initiated
>> disconnect as well.
>>
> 
> Your patch set is still on my todo list. I haven't reviewed it. There's
> some concern looking at it from a first glance, I'll check it out more
> thoroughly later.
> 
> Can you provide the tracepoints?
> 
I can provide the full trace if you need it, just let me know.  However
here is a quick snippet:

[ 1865.070397670       0x8724e2f18]   dbg_send_ep_cmd: ep2in: cmd
'Update Transfer' [50007] params 00000000 00000000 00000000 --> status:
Successful
[ 1865.070449389       0x8724e32fa]   dbg_ep_queue: ep2in: req
ffffff87a36bd300 length 0/65536 zsI ==> -115
[ 1865.070480222       0x8724e3549]   dbg_send_ep_cmd: ep2in: cmd
'Update Transfer' [50007] params 00000000 00000000 00000000 --> status:
Successful
[ 1865.070529962       0x8724e3904]   dbg_ep_queue: ep2in: req
ffffff88708dfc00 length 0/65536 zsI ==> -115
[ 1865.070559545       0x8724e3b3c]   dbg_send_ep_cmd: ep2in: cmd
'Update Transfer' [50007] params 00000000 00000000 00000000 --> status:
Successful
[ 1865.070610639       0x8724e3f11]   dbg_ep_queue: ep2in: req
ffffff8042a98200 length 0/65536 zsI ==> -115
[ 1865.070640691       0x8724e4152]   dbg_send_ep_cmd: ep2in: cmd
'Update Transfer' [50007] params 00000000 00000000 00000000 --> status:
Successful
[ 1865.070692983       0x8724e453e]   dbg_ep_queue: ep2in: req
ffffff8042a98900 length 0/65536 zsI ==> -115
[ 1865.070728972       0x8724e47f1]   dbg_send_ep_cmd: ep2in: cmd
'Update Transfer' [50007] params 00000000 00000000 00000000 --> status:
Successful

//EP halt setup packet is received from the PC
[ 1865.166579233       0x8726a5cb7]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep6in)
[ 1865.166716785       0x8726a6708]   dbg_send_ep_cmd: ep6in: cmd 'Clear
Stall' [405] params 00000000 00000000 00000000 --> status: Successful

//This should be the EP0 status phase, as it is on ep0in
[ 1865.166849598       0x8726a70fd]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1865.173668817       0x8726c706e]   dbg_ep_dequeue: ep2in: req
ffffff885f293f00 length 0/62848 zsI ==> -115

//Dequeue timeout occurs here
[ 1865.192420900       0x87271eed6]   dbg_send_ep_cmd: ep2in: cmd 'End
Transfer' [50d08] params 00000000 00000000 00000000 --> status: Timed Out

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
