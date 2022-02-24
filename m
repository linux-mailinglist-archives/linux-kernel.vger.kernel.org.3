Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99794C37FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiBXVqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 16:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiBXVp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:45:59 -0500
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id AB39B2275B8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:45:26 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1645739126; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=XfuFwxCMRbw08G096FuVzxwqVv12sAvay4P4ZVqcH3w=; b=Ik9LGXrL0q8ItweYOhxXYxHsGQXfGcG2xrfhoiQYKbBIZBjO9IDWCVXIt+ZA95HChASTcUE3
 KuFyTawBPrEeyF0BKs44ogNXcvJFbHNS8eIlYxUapMt3mBgMVY291+XLEj8mNT0/b8gBotXv
 RV8s0p/iv9xgoZVLM633k01mOlo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6217fc75c896f3985234809b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Feb 2022 21:45:24
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EEEFDC4360C; Thu, 24 Feb 2022 21:45:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from [192.168.1.17] (cpe-75-80-185-151.san.res.rr.com [75.80.185.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EF50C4338F;
        Thu, 24 Feb 2022 21:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3EF50C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <dbd00cb1-b5d0-24e7-ef72-dff3765c26cf@codeaurora.org>
Date:   Thu, 24 Feb 2022 13:45:08 -0800
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
From:   Wesley Cheng <wcheng@codeaurora.org>
In-Reply-To: <894d54ad-b6f9-b942-be99-fe3ad102051b@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 2/22/2022 6:59 PM, Thinh Nguyen wrote:
> Hi Wesley,
> 
> Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 2/17/2022 3:43 PM, Thinh Nguyen wrote:
>>> Wesley Cheng wrote:
>>>> Hi Thinh,
>>>>
>>>> On 2/15/2022 9:14 AM, Thinh Nguyen wrote:
>>>>> Jung Daehwan wrote:
>>>>>> Hi Thinh,
>>>>>>
>>>>>> On Mon, Feb 14, 2022 at 06:44:33PM +0000, Thinh Nguyen wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Daehwan Jung wrote:
>>>>>>>> It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
>>>>>>>> even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
>>>>>>>
>>>>>>> How does it fail? Timed out?
>>>>>>
>>>>>> Yes, timed out.
>>>>>>>
>>>>>>>> skipping clear stall commmand or giveback from dequeue. We fix to set it
>>>>>>>> only when ep cmd success. Additionally, We clear DWC3_EP_TRANSFER_STARTED
>>>>>>>> for next trb to start transfer not update transfer.
>>>>>>>
>>>>>>> We shouldn't do this. Things will be out of sync. It may work for 1
>>>>>>> scenario, but it won't work for others.
>>>>>>>
>>>>>>> Please help me understand a few things:
>>>>>>>
>>>>>>> 1) What is the scenario that triggers this? Is it random?
>>>>>>>
>>>>>> ep cmd timeout occurs on dequeue request from user side. End Transfer command
>>>>>> would be sent in dwc3_stop_active transfer.
>>>>>
>>>>> At the high level, what's triggering the request dequeue? Is it from a
>>>>> disconnect, change of interface, or simply function driver protocol that
>>>>> changes it.
>>>>>
>>>>> What application was used to trigger this?
>>>>>
>>>> Sorry for jumping in here, but looks like Daehwan is running into a
>>>> similar issue I am seeing as well.
>>>>
>>>> At least in my scenario, the dequeue is coming from a function driver
>>>> which exposes a device to userspace.  Once that device is closed, it
>>>> will issue a dequeue on all pending/submitted requests.
>>>
>>> Dequeuing request is coming from the function driver, but what causes
>>> the dequeue. For example, the End Transfer command due to a disconnect
>>> may give a different clues than a dequeue from a change of interface.
>>>
>> For us, once the application exits, the corresponding userspace
>> device/port is closed.  This triggers the function driver to clean up
>> any pending/queued USB requests.  It doesn't have any association w/ any
>> USB cable disconnect, or interface change in this case, it is controlled
>> solely on the application exiting/stopped.
>>>>
>>>>>>
>>>>>>> 2) Are there other traffics pending while issuing the End Transfer
>>>>>>> command? If so, what transfer type(s)?
>>>>>>>
>>>>>> I haven't checked it yet. 
>>>>>
>>>>> Can you check?
>>>>>
>>>> For the cases where we've collected a crash log, we can see that during
>>>> the END transfer timeouts there was always a pending EP0 transaction.
>>>> We had reached out to our internal HW folks to get some inputs on what
>>>> could be causing this kind of issue, and we were able to get some
>>>> recommendations from their Synopsis POCs.
>>>
>>> It's "Synopsys" :)
>>>
>> Sorry! :)
>>>>
>>>> It was mentioned that if there was an active EP0 transfer, an end
>>>> transfer command on a non-control EP can fail w/ timed out.
>>>>
>>>
>>> What controller version are you using? And what version is Jung using?
>>> Do you have the STAR number of the issue. If you're using a different
>>> version than Jung's, then it may not be the same issue.
>>>
>> We're using 1.90a.
>>
>>>>>>
>>>>>>> 3) Have you tried increasing the timeout?
>>>>>>>
>>>>>> No, I haven't.
>>>>>
>>>>> Can you try up to 10 seconds (just for experiment)
>>>>>
>>>> I've tried this too, and it did not help.
>>>>
>>>>>>> BR,
>>>>>>> Thinh
>>>>>>>
>>>>>>
>>>>>> This issue occurs very rarely on customer. I only have restricted
>>>>>> information. That's why I've been trying to reproduce it.
>>>>>
>>>>> How did you test your fix if you can't reproduce it?
>>>>>
>>>>>>
>>>>>> Wesley may have run into same issue and you can see this issue in detail.
>>>>>> https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=9d423b69-fc3fd32e-9d43b026-74fe485fff30-77a099b52659410d&q=1&e=20b4d9f5-2599-4f57-8b6a-7c4ec167d228&u=https*3A*2F*2Flore.kernel.org*2Flinux-usb*2F20220203080017.27339-1-quic_wcheng*40quicinc.com*2F__;JSUlJSUlJQ!!A4F2R9G_pg!JWPzNLoO3BFX_IZCVzmHPtxq6frr_VFbSNNaxSQylunt1Y4EauTOefth2LCIcVEuTx8E$ 
>>>>>>
>>>>>
>>>>> I can take a look, but please provide the tracepoints of the failure if
>>>>> you can reproduce it.
>>>>>
>>>> Let me see if I have any previous traces I can share.  If not, I have a
>>>> pretty reliable repro set up I can collect a trace for you.  For now, I
>>>> will focus on just getting the endxfer timeout seen during ep dequeue.
>>>> As mentioned on my patchset, this can happen during device-initiated
>>>> disconnect as well.
>>>>
>>>
>>> Your patch set is still on my todo list. I haven't reviewed it. There's
>>> some concern looking at it from a first glance, I'll check it out more
>>> thoroughly later.
>>>
>>> Can you provide the tracepoints?
>>>
>> I can provide the full trace if you need it, just let me know.  However
>> here is a quick snippet:
>>
>> [ 1865.070397670       0x8724e2f18]   dbg_send_ep_cmd: ep2in: cmd
>> 'Update Transfer' [50007] params 00000000 00000000 00000000 --> status:
>> Successful
>> [ 1865.070449389       0x8724e32fa]   dbg_ep_queue: ep2in: req
>> ffffff87a36bd300 length 0/65536 zsI ==> -115
>> [ 1865.070480222       0x8724e3549]   dbg_send_ep_cmd: ep2in: cmd
>> 'Update Transfer' [50007] params 00000000 00000000 00000000 --> status:
>> Successful
>> [ 1865.070529962       0x8724e3904]   dbg_ep_queue: ep2in: req
>> ffffff88708dfc00 length 0/65536 zsI ==> -115
>> [ 1865.070559545       0x8724e3b3c]   dbg_send_ep_cmd: ep2in: cmd
>> 'Update Transfer' [50007] params 00000000 00000000 00000000 --> status:
>> Successful
>> [ 1865.070610639       0x8724e3f11]   dbg_ep_queue: ep2in: req
>> ffffff8042a98200 length 0/65536 zsI ==> -115
>> [ 1865.070640691       0x8724e4152]   dbg_send_ep_cmd: ep2in: cmd
>> 'Update Transfer' [50007] params 00000000 00000000 00000000 --> status:
>> Successful
>> [ 1865.070692983       0x8724e453e]   dbg_ep_queue: ep2in: req
>> ffffff8042a98900 length 0/65536 zsI ==> -115
>> [ 1865.070728972       0x8724e47f1]   dbg_send_ep_cmd: ep2in: cmd
>> 'Update Transfer' [50007] params 00000000 00000000 00000000 --> status:
>> Successful
>>
>> //EP halt setup packet is received from the PC
>> [ 1865.166579233       0x8726a5cb7]   dbg_trace_log_ctrl: Clear Endpoint
>> Feature(Halt ep6in)
>> [ 1865.166716785       0x8726a6708]   dbg_send_ep_cmd: ep6in: cmd 'Clear
>> Stall' [405] params 00000000 00000000 00000000 --> status: Successful
>>
>> //This should be the EP0 status phase, as it is on ep0in
>> [ 1865.166849598       0x8726a70fd]   dbg_send_ep_cmd: ep0in: cmd 'Start
>> Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>> [ 1865.173668817       0x8726c706e]   dbg_ep_dequeue: ep2in: req
>> ffffff885f293f00 length 0/62848 zsI ==> -115
>>
>> //Dequeue timeout occurs here
>> [ 1865.192420900       0x87271eed6]   dbg_send_ep_cmd: ep2in: cmd 'End
>> Transfer' [50d08] params 00000000 00000000 00000000 --> status: Timed Out
>>
> 
> Can you provide a full trace?
> 
Sorry for doing this, but we didn't have a way to share the file
directly, so I have to paste the trace below. :/

> Btw, when you experiment with increasing the timeout to 10 seconds, did
> you use the mdelay() in each loop? The delta time for End Transfer
> timeout here seems very small.
> 
This particular run did not modify the timeout for the cmd status polling.

Is that something that you want to try?  Not pertaining to this dequeue
situation, during the pullup disable path debug, I noticed that as long
as there was a pending EP0 SETUP packet (not data/status) cached in the
controller, it would also have endxfer timeouts on non-control EPs.  We
were able to capture a bus sniffer log + ftrace, and it showed that at
the point of the error, the lecroy/bus log saw a SETUP token ACK'ed,
while on the ftrace, there were endxfer timeouts for all non-control EPs
(due to the dwc3_gadget_stop_active_transfers() call)

Thanks
Wesley

TRACE
---------------------------------------------------------------------


[ 1018.831573056       0x4a995de8b]   dbg_gadget_giveback: ep2in: req
ffffff80516bc600 length 0/65536 zsI ==> -108
[ 1018.832203941       0x4a9960ddc]   dbg_gadget_giveback: ep2in: req
ffffff80516bc500 length 0/65536 zsI ==> -108
[ 1018.833000816       0x4a99649a0]   dbg_gadget_giveback: ep2in: req
ffffff80516bd400 length 0/65536 zsI ==> -108
[ 1018.833625399       0x4a9967878]   dbg_gadget_giveback: ep2in: req
ffffff80516bdf00 length 0/65536 zsI ==> -108
[ 1018.834339306       0x4a996ae03]   dbg_gadget_giveback: ep2in: req
ffffff87823adb00 length 0/65536 zsI ==> -108
[ 1018.834969254       0x4a996dd43]   dbg_gadget_giveback: ep2in: req
ffffff87f99b9c00 length 0/65536 zsI ==> -108
[ 1018.835567379       0x4a9970a1f]   dbg_gadget_giveback: ep2in: req
ffffff87f99b9400 length 0/65536 zsI ==> -108
[ 1018.836162170       0x4a99736ba]   dbg_gadget_giveback: ep2in: req
ffffff87f99b8600 length 0/65536 zsI ==> -108
[ 1018.836938108       0x4a99770ec]   dbg_gadget_giveback: ep2in: req
ffffff87f99b8d00 length 0/65536 zsI ==> -108
[ 1018.837570087       0x4a997a052]   dbg_gadget_giveback: ep2in: req
ffffff87f99b9700 length 0/65536 zsI ==> -108
[ 1018.838123368       0x4a997c9d1]   dbg_gadget_giveback: ep2in: req
ffffff87f99b9100 length 0/65536 zsI ==> -108
[ 1018.838645504       0x4a997f0fa]   dbg_gadget_giveback: ep2in: req
ffffff87f99b9500 length 0/65536 zsI ==> -108
[ 1018.839301441       0x4a998222c]   dbg_gadget_giveback: ep2in: req
ffffff87f99b9e00 length 0/65536 zsI ==> -108
[ 1018.839932587       0x4a9985182]   dbg_gadget_giveback: ep2in: req
ffffff87f99b9d00 length 0/65536 zsI ==> -108
[ 1018.840656597       0x4a99887cf]   dbg_gadget_giveback: ep2in: req
ffffff87f99b8400 length 0/65536 zsI ==> -108
[ 1018.841346285       0x4a998bb89]   dbg_gadget_giveback: ep2in: req
ffffff87f99b8300 length 0/65536 zsI ==> -108
[ 1018.842064462       0x4a998f167]   dbg_gadget_giveback: ep2in: req
ffffff87f99b9f00 length 0/65536 zsI ==> -108
[ 1018.842840139       0x4a9992b93]   dbg_gadget_giveback: ep2in: req
ffffff87f99b9200 length 0/65536 zsI ==> -108
[ 1018.843568681       0x4a9996238]   dbg_gadget_giveback: ep2in: req
ffffff87f99b8a00 length 0/65536 zsI ==> -108
[ 1018.844307847       0x4a99999a8]   dbg_gadget_giveback: ep2in: req
ffffff87f99b8f00 length 0/65536 zsI ==> -108
[ 1018.845096493       0x4a999d4cd]   dbg_gadget_giveback: ep2in: req
ffffff87f99b8b00 length 0/65536 zsI ==> -108
[ 1018.845752587       0x4a99a0602]   dbg_gadget_giveback: ep2in: req
ffffff87f99b9900 length 0/65536 zsI ==> -108
[ 1018.846446650       0x4a99a3a10]   dbg_gadget_giveback: ep2in: req
ffffff87f99b8700 length 0/65536 zsI ==> -108
[ 1018.847192795       0x4a99a7206]   dbg_gadget_giveback: ep2in: req
ffffff87f99b8200 length 0/65536 zsI ==> -108
[ 1018.847889827       0x4a99aa64d]   dbg_gadget_giveback: ep2in: req
ffffff87f99b9000 length 0/65536 zsI ==> -108
[ 1018.848678368       0x4a99ae171]   dbg_gadget_giveback: ep2in: req
ffffff87f99b8c00 length 0/65536 zsI ==> -108
[ 1018.849349306       0x4a99b13c3]   dbg_gadget_giveback: ep2in: req
ffffff87f99b8500 length 0/65536 zsI ==> -108
[ 1018.850019150       0x4a99b4600]   dbg_gadget_giveback: ep2in: req
ffffff87f99b8900 length 0/65536 zsI ==> -108
[ 1018.850718681       0x4a99b7a77]   dbg_gadget_giveback: ep2in: req
ffffff80362f0300 length 0/65536 zsI ==> -108
[ 1018.851418681       0x4a99baef7]   dbg_gadget_giveback: ep2in: req
ffffff80362f1100 length 0/65536 zsI ==> -108
[ 1018.852123420       0x4a99be3d2]   dbg_gadget_giveback: ep2in: req
ffffff80362f0d00 length 0/65536 zsI ==> -108
[ 1018.852889670       0x4a99c1d4a]   dbg_gadget_giveback: ep2in: req
ffffff80362f0600 length 0/65536 zsI ==> -108
[ 1018.853628733       0x4a99c54b8]   dbg_gadget_giveback: ep2in: req
ffffff80362f0a00 length 0/65536 zsI ==> -108
[ 1018.854325139       0x4a99c88f3]   dbg_gadget_giveback: ep2in: req
ffffff80362f1900 length 0/65536 zsI ==> -108
[ 1018.855135191       0x4a99cc5b4]   dbg_gadget_giveback: ep2in: req
ffffff803222fb00 length 0/65536 zsI ==> -108
[ 1018.855950139       0x4a99d02d3]   dbg_gadget_giveback: ep2in: req
ffffff803222e100 length 0/65536 zsI ==> -108
[ 1018.856728212       0x4a99d3d2e]   dbg_gadget_giveback: ep2in: req
ffffff803222eb00 length 0/65536 zsI ==> -108
[ 1018.857404879       0x4a99d6fee]   dbg_gadget_giveback: ep2in: req
ffffff803222ff00 length 0/65536 zsI ==> -108
[ 1018.858602275       0x4a99dc9bc]   dbg_gadget_giveback: ep2in: req
ffffff803222f700 length 0/65536 zsI ==> -108
[ 1018.859436337       0x4a99e084a]   dbg_gadget_giveback: ep2in: req
ffffff803222fa00 length 0/65536 zsI ==> -108
[ 1018.860205920       0x4a99e4202]   dbg_send_ep_cmd: ep3out: cmd 'End
Transfer' [60c08] params 00000000 00000000 00000000 --> status: Successful
[ 1018.860666597       0x4a99e648f]   dbg_gadget_giveback: ep3out: req
ffffff87a3790000 length 0/16384 zsI ==> -108
[ 1018.862703733       0x4a99efd58]   dbg_gadget_giveback: ep3out: req
ffffff87a3791100 length 0/16384 zsI ==> -108
[ 1018.863841754       0x4a99f52b2]   dbg_gadget_giveback: ep3out: req
ffffff87a3790200 length 0/16384 zsI ==> -108
[ 1018.864743993       0x4a99f965d]   dbg_gadget_giveback: ep3out: req
ffffff87a3790a00 length 0/16384 zsI ==> -108
[ 1018.865442795       0x4a99fcac6]   dbg_gadget_giveback: ep3out: req
ffffff87a3790800 length 0/16384 zsI ==> -108
[ 1018.866226337       0x4a9a0058a]   dbg_gadget_giveback: ep3out: req
ffffff87a3790c00 length 0/16384 zsI ==> -108
[ 1018.866949045       0x4a9a03bbe]   dbg_gadget_giveback: ep3out: req
ffffff87a3790700 length 0/16384 zsI ==> -108
[ 1018.867771754       0x4a9a07972]   dbg_gadget_giveback: ep3out: req
ffffff87a3790d00 length 0/16384 zsI ==> -108
[ 1018.869052847       0x4a9a0d987]   dbg_send_ep_cmd: ep3in: cmd 'End
Transfer' [70c08] params 00000000 00000000 00000000 --> status: Successful
[ 1018.869377222       0x4a9a0f1dc]   dbg_send_ep_cmd: ep4in: cmd 'End
Transfer' [90c08] params 00000000 00000000 00000000 --> status: Successful
[ 1018.869769462       0x4a9a10f46]   dbg_send_ep_cmd: ep0out: cmd 'End
Transfer' [c08] params 00000000 00000000 00000000 --> status: Successful
[ 1021.465141449       0x4ac996c2c]   dbg_send_ep_cmd: ep0out: cmd
'Start New Configuration' [409] params 00000000 00000000 00000000 -->
status: Successful
[ 1021.465338064       0x4ac997aeb]   dbg_send_ep_cmd: ep0out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.465523689       0x4ac9988d7]   dbg_send_ep_cmd: ep0in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.465699678       0x4ac99960a]   dbg_send_ep_cmd: ep1out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.465886814       0x4ac99a413]   dbg_send_ep_cmd: ep1in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.466062282       0x4ac99b13c]   dbg_send_ep_cmd: ep2out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.466236553       0x4ac99be4e]   dbg_send_ep_cmd: ep2in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.466432282       0x4ac99ccfc]   dbg_send_ep_cmd: ep3out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.466611137       0x4ac99da66]   dbg_send_ep_cmd: ep3in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.466784001       0x4ac99e75d]   dbg_send_ep_cmd: ep4out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.466963533       0x4ac99f4d4]   dbg_send_ep_cmd: ep4in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.467132491       0x4ac9a0180]   dbg_send_ep_cmd: ep5out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.467307855       0x4ac9a0ea7]   dbg_send_ep_cmd: ep5in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.467479001       0x4ac9a1b7d]   dbg_send_ep_cmd: ep6out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.467657855       0x4ac9a28e7]   dbg_send_ep_cmd: ep6in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.467838376       0x4ac9a3671]   dbg_send_ep_cmd: ep7out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.468019158       0x4ac9a4400]   dbg_send_ep_cmd: ep7in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.468197230       0x4ac9a515b]   dbg_send_ep_cmd: ep8out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.468378116       0x4ac9a5eec]   dbg_send_ep_cmd: ep8in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.468542178       0x4ac9a6b3a]   dbg_send_ep_cmd: ep9out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.468686970       0x4ac9a7617]   dbg_send_ep_cmd: ep9in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.468829678       0x4ac9a80ca]   dbg_send_ep_cmd: ep10out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.468953116       0x4ac9a8a0c]   dbg_send_ep_cmd: ep10in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.469083324       0x4ac9a93d0]   dbg_send_ep_cmd: ep11out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.469256866       0x4ac9aa0d5]   dbg_send_ep_cmd: ep11in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.469426085       0x4ac9aad85]   dbg_send_ep_cmd: ep12out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.469596970       0x4ac9aba56]   dbg_send_ep_cmd: ep12in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.469775303       0x4ac9ac7b7]   dbg_send_ep_cmd: ep13out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.469940460       0x4ac9ad419]   dbg_send_ep_cmd: ep13in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.470128480       0x4ac9ae233]   dbg_send_ep_cmd: ep14out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.470305668       0x4ac9aef7d]   dbg_send_ep_cmd: ep14in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.470480720       0x4ac9afc9e]   dbg_send_ep_cmd: ep15out: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.470660408       0x4ac9b0a18]   dbg_send_ep_cmd: ep15in: cmd 'Set
Endpoint Transfer Resource' [402] params 00000001 00000000 00000000 -->
status: Successful
[ 1021.470799470       0x4ac9b1486]   dbg_send_ep_cmd: ep0out: cmd 'Set
Endpoint Configuration' [401] params 00001000 00000500 00000000 -->
status: Successful
[ 1021.470955980       0x4ac9b2043]   dbg_send_ep_cmd: ep0in: cmd 'Set
Endpoint Configuration' [401] params 00001000 02000500 00000000 -->
status: Successful
[ 1021.471130199       0x4ac9b2d54]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.645935668       0x4acce63bf]   dbg_send_ep_cmd: ep0out: cmd 'Set
Endpoint Configuration' [401] params 80000200 00000500 00000000 -->
status: Successful
[ 1021.646625773       0x4acce9781]   dbg_send_ep_cmd: ep0in: cmd 'Set
Endpoint Configuration' [401] params 80000200 02000500 00000000 -->
status: Successful
[ 1021.681864575       0x4acd8ea6a]   dbg_trace_log_ctrl: Get Device
Descriptor(Index = 0, Length = 64)
[ 1021.683840721       0x4acd97ea0]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1021.688133221       0x4acdac090]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 18/18 ZsI ==> 0
[ 1021.689019575       0x4acdb030a]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.695974992       0x4acdd0cb2]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.706717700       0x4ace03265]   dbg_trace_log_ctrl: Set
Address(Addr = 23)
[ 1021.707788117       0x4ace082ae]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1021.711342492       0x4ace18d41]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.729135148       0x4ace6c3b4]   dbg_trace_log_ctrl: Get Device
Descriptor(Index = 0, Length = 18)
[ 1021.729704940       0x4ace6ee70]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1021.736413533       0x4ace8e595]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 18/18 zsI ==> 0
[ 1021.737211137       0x4ace92166]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.742762544       0x4aceac1c2]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.754386606       0x4acee2990]   dbg_trace_log_ctrl: Get
Configuration Descriptor(Index = 0, Length = 255)
[ 1021.755449367       0x4acee7946]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1021.767178586       0x4acf1e8f6]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 166/166 ZsI ==> 0
[ 1021.768052752       0x4acf22a87]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.770862336       0x4acf2fd3f]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.781574627       0x4acf620ab]   dbg_trace_log_ctrl: Get BOS
Descriptor(Index = 0, Length = 255)
[ 1021.782634836       0x4acf6702f]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1021.786686763       0x4acf7a015]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 12/12 ZsI ==> 0
[ 1021.787616138       0x4acf7e5c6]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.791783638       0x4acf91e58]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.804542700       0x4acfcdb45]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 0, Length = 255)
[ 1021.805013065       0x4acfcfe8c]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1021.820321086       0x4ad017aa6]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 ZsI ==> 0
[ 1021.820730044       0x4ad019952]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.822487544       0x4ad021d21]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.844834836       0x4ad08a92f]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 2, Length = 4)
[ 1021.845811554       0x4ad08f270]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1021.851372023       0x4ad0a9379]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1021.852326242       0x4ad0adb09]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.856418221       0x4ad0c0df0]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.872088794       0x4ad10a53b]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 2, Length = 48)
[ 1021.873069523       0x4ad10eec8]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1021.884076398       0x4ad14284c]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 48/48 zsI ==> 0
[ 1021.884956346       0x4ad146a4c]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.887496763       0x4ad1528d4]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.899610617       0x4ad18b55e]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 3, Length = 4)
[ 1021.900683690       0x4ad1905d9]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1021.904368430       0x4ad1a1a34]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1021.904883898       0x4ad1a40dd]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.908116190       0x4ad1b3348]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.920857284       0x4ad1eeede]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 3, Length = 18)
[ 1021.921880513       0x4ad1f3b9b]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1021.925622648       0x4ad205444]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 18/18 zsI ==> 0
[ 1021.926103534       0x4ad207854]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.944110253       0x4ad25bed6]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.945718534       0x4ad263775]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 2, Length = 4)
[ 1021.946238065       0x4ad265e6c]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1021.947053794       0x4ad269b9a]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1021.947451555       0x4ad26b96f]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.948187128       0x4ad26f09a]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.964733794       0x4ad2bc99b]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 2, Length = 48)
[ 1021.965507180       0x4ad2c039b]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1021.970562544       0x4ad2d7ec2]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 48/48 zsI ==> 0
[ 1021.971286242       0x4ad2db509]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1021.972758117       0x4ad2e236d]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.004602545       0x4ad3777c2]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 3, Length = 4)
[ 1022.005044784       0x4ad3798ed]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.007223690       0x4ad383c58]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.007708638       0x4ad3860b7]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.009726242       0x4ad38f808]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.019832440       0x4ad3bedff]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 3, Length = 18)
[ 1022.020384888       0x4ad3c176e]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.022519524       0x4ad3cb788]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 18/18 zsI ==> 0
[ 1022.022995461       0x4ad3cdb39]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.024091138       0x4ad3d2d67]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.033726920       0x4ad400016]   dbg_trace_log_ctrl: Set
Configuration(Config = 1)
[ 1022.034893690       0x4ad405797]   dbg_send_ep_cmd: ep1out: cmd 'Set
Endpoint Configuration' [401] params 00001004 04000200 00000000 -->
status: Successful
[ 1022.035314263       0x4ad407722]   dbg_send_ep_cmd: ep1out: cmd
'Start Transfer' [406] params 00000000 efff8000 00000000 --> status:
Successful
[ 1022.035805149       0x4ad409bf4]   dbg_send_ep_cmd: ep1in: cmd 'Set
Endpoint Configuration' [401] params 00021004 06000200 00000000 -->
status: Successful
[ 1022.036249003       0x4ad40bd3e]   dbg_send_ep_cmd: ep1in: cmd 'Start
Transfer' [406] params 00000000 efff7000 00000000 --> status: Successful
[ 1022.037503586       0x4ad411b56]   dbg_send_ep_cmd: ep3in: cmd 'Set
Endpoint Configuration' [401] params 00060056 0e080200 00000000 -->
status: Successful
[ 1022.037954368       0x4ad413d25]   dbg_send_ep_cmd: ep3in: cmd 'Start
Transfer' [406] params 00000000 efff3000 00000000 --> status: Successful
[ 1022.038447545       0x4ad416222]   dbg_send_ep_cmd: ep2in: cmd 'Set
Endpoint Configuration' [401] params 00041004 0a000200 00000000 -->
status: Successful
[ 1022.038878378       0x4ad418272]   dbg_send_ep_cmd: ep2in: cmd 'Start
Transfer' [406] params 00000000 efff5000 00000000 --> status: Successful
[ 1022.039353743       0x4ad41a618]   dbg_send_ep_cmd: ep2out: cmd 'Set
Endpoint Configuration' [401] params 00001004 08000200 00000000 -->
status: Successful
[ 1022.039793482       0x4ad41c713]   dbg_send_ep_cmd: ep2out: cmd
'Start Transfer' [406] params 00000000 efff6000 00000000 --> status:
Successful
[ 1022.041149368       0x4ad422cc6]   dbg_ep_queue: ep2out: req
ffffff8036302600 length 0/2048 zsI ==> -115
[ 1022.041403899       0x4ad423fdc]   dbg_prepare: ep2out: trb
ffffffc0197fa000 (E1:D0) buf 00000000eff62000 size 2048 ctrl 00000819
(HlcS:sC:normal)
[ 1022.041750149       0x4ad4259d3]   dbg_send_ep_cmd: ep2out: cmd
'Update Transfer' [40007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.042116868       0x4ad427555]   dbg_ep_queue: ep2out: req
ffffff8036303b00 length 0/2048 zsI ==> -115
[ 1022.042358691       0x4ad428778]   dbg_prepare: ep2out: trb
ffffffc0197fa010 (E2:D0) buf 00000000eff63000 size 2048 ctrl 00000819
(HlcS:sC:normal)
[ 1022.042706868       0x4ad42a195]   dbg_send_ep_cmd: ep2out: cmd
'Update Transfer' [40007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.043062441       0x4ad42bc40]   dbg_ep_queue: ep2out: req
ffffff8036302b00 length 0/2048 zsI ==> -115
[ 1022.043369993       0x4ad42d350]   dbg_prepare: ep2out: trb
ffffffc0197fa020 (E3:D0) buf 00000000e9d9a800 size 2048 ctrl 00000819
(HlcS:sC:normal)
[ 1022.043717961       0x4ad42ed6a]   dbg_send_ep_cmd: ep2out: cmd
'Update Transfer' [40007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.044079316       0x4ad430884]   dbg_ep_queue: ep2out: req
ffffff8036302300 length 0/2048 zsI ==> -115
[ 1022.044302336       0x4ad43193d]   dbg_prepare: ep2out: trb
ffffffc0197fa030 (E4:D0) buf 00000000e9d9b000 size 2048 ctrl 00000819
(HlcS:sC:normal)
[ 1022.044637597       0x4ad433263]   dbg_send_ep_cmd: ep2out: cmd
'Update Transfer' [40007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.044984368       0x4ad434c65]   dbg_ep_queue: ep2out: req
ffffff8036303100 length 0/2048 zsI ==> -115
[ 1022.045224316       0x4ad435e64]   dbg_prepare: ep2out: trb
ffffffc0197fa040 (E5:D0) buf 00000000eff87800 size 2048 ctrl 00000819
(HlcS:sC:normal)
[ 1022.045577961       0x4ad4378e9]   dbg_send_ep_cmd: ep2out: cmd
'Update Transfer' [40007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.045918691       0x4ad439278]   dbg_ep_queue: ep2out: req
ffffff8036302700 length 0/2048 zsI ==> -115
[ 1022.046128118       0x4ad43a22d]   dbg_prepare: ep2out: trb
ffffffc0197fa050 (E6:D0) buf 00000000eff86800 size 2048 ctrl 00000819
(HlcS:sC:normal)
[ 1022.046423013       0x4ad43b84b]   dbg_send_ep_cmd: ep2out: cmd
'Update Transfer' [40007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.046799368       0x4ad43d484]   dbg_ep_queue: ep2out: req
ffffff8036302400 length 0/2048 zsI ==> -115
[ 1022.047075097       0x4ad43e933]   dbg_prepare: ep2out: trb
ffffffc0197fa060 (E7:D0) buf 00000000ecfa7800 size 2048 ctrl 00000819
(HlcS:sC:normal)
[ 1022.047374263       0x4ad43ffa3]   dbg_send_ep_cmd: ep2out: cmd
'Update Transfer' [40007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.047686191       0x4ad441707]   dbg_ep_queue: ep2out: req
ffffff8036302900 length 0/2048 zsI ==> -115
[ 1022.047910618       0x4ad4427dc]   dbg_prepare: ep2out: trb
ffffffc0197fa070 (E8:D0) buf 00000000ecfa6800 size 2048 ctrl 00000819
(HlcS:sC:normal)
[ 1022.048258899       0x4ad4441fb]   dbg_send_ep_cmd: ep2out: cmd
'Update Transfer' [40007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.048838847       0x4ad446d7b]   dbg_send_ep_cmd: ep5in: cmd 'Set
Endpoint Configuration' [401] params 000a0046 16080200 00000000 -->
status: Successful
[ 1022.049279993       0x4ad448e91]   dbg_send_ep_cmd: ep5in: cmd 'Start
Transfer' [406] params 00000000 effef000 00000000 --> status: Successful
[ 1022.050958586       0x4ad450c75]   dbg_send_ep_cmd: ep7in: cmd 'Set
Endpoint Configuration' [401] params 000e1004 1e000200 00000000 -->
status: Successful
[ 1022.051410201       0x4ad452e55]   dbg_send_ep_cmd: ep7in: cmd 'Start
Transfer' [406] params 00000000 effeb000 00000000 --> status: Successful
[ 1022.052623274       0x4ad458950]   dbg_send_ep_cmd: ep4out: cmd 'Set
Endpoint Configuration' [401] params 00001004 10000200 00000000 -->
status: Successful
[ 1022.053049263       0x4ad45a943]   dbg_send_ep_cmd: ep4out: cmd
'Start Transfer' [406] params 00000000 efff2000 00000000 --> status:
Successful
[ 1022.053547493       0x4ad45cea1]   dbg_send_ep_cmd: ep8in: cmd 'Set
Endpoint Configuration' [401] params 00101004 22000200 00000000 -->
status: Successful
[ 1022.053997701       0x4ad45f065]   dbg_send_ep_cmd: ep8in: cmd 'Start
Transfer' [406] params 00000000 effe9000 00000000 --> status: Successful
[ 1022.096081191       0x4ad5244a7]   dbg_ep_queue: ep4out: req
ffffff80407f1700 length 0/16384 zsI ==> -115
[ 1022.096196191       0x4ad524d47]   dbg_prepare: ep4out: trb
ffffffc019b01000 (E1:D0) buf 00000000e9cf4000 size 16384 ctrl 00000819
(HlcS:sC:normal)
[ 1022.096360826       0x4ad5259a0]   dbg_send_ep_cmd: ep4out: cmd
'Update Transfer' [80007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.102595982       0x4ad542d44]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.103773222       0x4ad54858f]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 0/0 zsI ==> 0
[ 1022.104266555       0x4ad54aa8e]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.114207909       0x4ad57942a]   dbg_trace_log_ctrl: Clear Device
Feature(Self Powered)
[ 1022.114483587       0x4ad57a8d6]   dbg_ep_queue: ep4out: req
ffffff80407f1300 length 0/16384 zsI ==> -115
[ 1022.114664732       0x4ad57b66b]   dbg_prepare: ep4out: trb
ffffffc019b01010 (E2:D0) buf 00000000eecfc000 size 16384 ctrl 00000819
(HlcS:sC:normal)
[ 1022.114873899       0x4ad57c61b]   dbg_send_ep_cmd: ep4out: cmd
'Update Transfer' [80007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.115365149       0x4ad57eaf5]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.117621607       0x4ad589431]   dbg_gadget_giveback: ep0out: req
ffffff87f99b9000 length 16/16 zsI ==> 0
[ 1022.118133482       0x4ad58ba93]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.119042857       0x4ad58fec9]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.128172128       0x4ad5bab7a]   dbg_trace_log_ctrl: Clear Device
Feature(Self Powered)
[ 1022.128440618       0x4ad5bbf9c]   dbg_ep_queue: ep4out: req
ffffff87e13db500 length 0/16384 zsI ==> -115
[ 1022.128575253       0x4ad5bc9b5]   dbg_prepare: ep4out: trb
ffffffc019b01020 (E3:D0) buf 00000000eed6c000 size 16384 ctrl 00000819
(HlcS:sC:normal)
[ 1022.128779212       0x4ad5bd901]   dbg_send_ep_cmd: ep4out: cmd
'Update Transfer' [80007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.129190774       0x4ad5bf7e1]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.130699264       0x4ad5c6902]   dbg_ep_queue: ep1out: req
ffffff80457e0200 length 0/16384 zsI ==> -115
[ 1022.130811764       0x4ad5c7172]   dbg_prepare: ep1out: trb
ffffffc0197d3000 (E1:D0) buf 00000000e9cfc000 size 16384 ctrl 00000819
(HlcS:sC:normal)
[ 1022.130976660       0x4ad5c7dd0]   dbg_send_ep_cmd: ep1out: cmd
'Update Transfer' [20007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.131452857       0x4ad5ca188]   dbg_gadget_giveback: ep0out: req
ffffff87f99b9000 length 64/64 zsI ==> 0
[ 1022.131937180       0x4ad5cc5db]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.133891607       0x4ad5d5870]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.143913535       0x4ad604815]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 2, Length = 4)
[ 1022.144142493       0x4ad605940]   dbg_ep_queue: ep4out: req
ffffff87e13daa00 length 0/16384 zsI ==> -115
[ 1022.144274420       0x4ad606326]   dbg_prepare: ep4out: trb
ffffffc019b01030 (E4:D0) buf 00000000ea1c0000 size 16384 ctrl 00000819
(HlcS:sC:normal)
[ 1022.144430878       0x4ad606ee1]   dbg_send_ep_cmd: ep4out: cmd
'Update Transfer' [80007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.144787545       0x4ad6089a2]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.146946868       0x4ad612b94]   dbg_ep_queue: ep4out: req
ffffff87e13da200 length 0/16384 zsI ==> -115
[ 1022.147081243       0x4ad6135a8]   dbg_prepare: ep4out: trb
ffffffc019b01040 (E5:D0) buf 00000000eacd8000 size 16384 ctrl 00000819
(HlcS:sC:normal)
[ 1022.147258847       0x4ad6142fb]   dbg_send_ep_cmd: ep4out: cmd
'Update Transfer' [80007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.150157858       0x4ad621c67]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.150637493       0x4ad624061]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.151514160       0x4ad628220]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.161516712       0x4ad657052]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 2, Length = 48)
[ 1022.161740774       0x4ad658120]   dbg_ep_queue: ep4out: req
ffffff80300d9b00 length 0/16384 zsI ==> -115
[ 1022.161841868       0x4ad6588b4]   dbg_prepare: ep4out: trb
ffffffc019b01050 (E6:D0) buf 00000000eacdc000 size 16384 ctrl 00000819
(HlcS:sC:normal)
[ 1022.162000514       0x4ad65949a]   dbg_send_ep_cmd: ep4out: cmd
'Update Transfer' [80007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.162372649       0x4ad65b084]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.165485566       0x4ad6699fc]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 48/48 zsI ==> 0
[ 1022.165983326       0x4ad66bf50]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.167073222       0x4ad67110f]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.168132649       0x4ad676083]   dbg_ep_queue: ep7in: req
ffffff87f99b8f00 length 0/61696 zsI ==> -115
[ 1022.168266243       0x4ad676a88]   dbg_prepare: ep7in: trb
ffffffc019c95000 (E1:D0) buf 00000000ec480f00 size 61696 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.168435983       0x4ad677743]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.169309368       0x4ad67b8c4]   dbg_ep_queue: ep7in: req
ffffff87f99b9200 length 0/65536 zsI ==> -115
[ 1022.169411139       0x4ad67c066]   dbg_prepare: ep7in: trb
ffffffc019c95010 (E2:D0) buf 00000000ec490000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.169576087       0x4ad67ccc5]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.170078274       0x4ad67f26f]   dbg_ep_queue: ep7in: req
ffffff87f99b9f00 length 0/65536 zsI ==> -115
[ 1022.170208430       0x4ad67fc32]   dbg_prepare: ep7in: trb
ffffffc019c95020 (E3:D0) buf 00000000ec250000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.170371764       0x4ad680873]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.170872128       0x4ad682df9]   dbg_ep_queue: ep7in: req
ffffff87f99b8300 length 0/65536 zsI ==> -115
[ 1022.170970722       0x4ad68355e]   dbg_prepare: ep7in: trb
ffffffc019c95030 (E4:D0) buf 00000000ec260000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.171125462       0x4ad6840f9]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.171634524       0x4ad686727]   dbg_ep_queue: ep7in: req
ffffff87f99b8400 length 0/65536 zsI ==> -115
[ 1022.171735826       0x4ad686ec0]   dbg_prepare: ep7in: trb
ffffffc019c95040 (E5:D0) buf 00000000ec270000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.171895358       0x4ad687ab7]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.182774472       0x4ad6baaa6]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 2, Length = 4)
[ 1022.182947858       0x4ad6bb7a7]   dbg_ep_queue: ep7in: req
ffffff87f99b9d00 length 0/65536 zsI ==> -115
[ 1022.183025149       0x4ad6bbd73]   dbg_prepare: ep7in: trb
ffffffc019c95050 (E6:D0) buf 00000000ec280000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.183143222       0x4ad6bc64e]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.183251451       0x4ad6bce6c]   dbg_ep_queue: ep4out: req
ffffff87dfc95400 length 0/16384 zsI ==> -115
[ 1022.183383118       0x4ad6bd84c]   dbg_prepare: ep4out: trb
ffffffc019b01060 (E7:D0) buf 00000000eef10000 size 16384 ctrl 00000819
(HlcS:sC:normal)
[ 1022.183535045       0x4ad6be3b1]   dbg_send_ep_cmd: ep4out: cmd
'Update Transfer' [80007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.183907024       0x4ad6bff98]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.184168014       0x4ad6c132a]   dbg_ep_queue: ep7in: req
ffffff87f99b9e00 length 0/65536 zsI ==> -115
[ 1022.184271139       0x4ad6c1ae6]   dbg_prepare: ep7in: trb
ffffffc019c95060 (E7:D0) buf 00000000ec290000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.184420774       0x4ad6c261f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.185503951       0x4ad6c775c]   dbg_ep_queue: ep7in: req
ffffff87f99b9500 length 0/65536 zsI ==> -115
[ 1022.185601764       0x4ad6c7eb2]   dbg_prepare: ep7in: trb
ffffffc019c95070 (E8:D0) buf 00000000ec2a0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.185755358       0x4ad6c8a38]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.186173587       0x4ad6ca995]   dbg_ep_queue: ep7in: req
ffffff87f99b9100 length 0/65536 zsI ==> -115
[ 1022.186274472       0x4ad6cb126]   dbg_prepare: ep7in: trb
ffffffc019c95080 (E9:D0) buf 00000000ec2b0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.186410670       0x4ad6cbb5d]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.186732962       0x4ad6cd389]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.186942181       0x4ad6ce33a]   dbg_ep_queue: ep7in: req
ffffff87f99b9700 length 0/65536 zsI ==> -115
[ 1022.187042181       0x4ad6ceaba]   dbg_prepare: ep7in: trb
ffffffc019c95090 (E10:D0) buf 00000000ec2c0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.187183118       0x4ad6cf54c]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.187754160       0x4ad6d2020]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.188227545       0x4ad6d43a1]   dbg_ep_queue: ep7in: req
ffffff87f99b8d00 length 0/65536 zsI ==> -115
[ 1022.188451295       0x4ad6d5469]   dbg_prepare: ep7in: trb
ffffffc019c950a0 (E11:D0) buf 00000000ec2d0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.188795410       0x4ad6d6e38]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.190817910       0x4ad6e05e8]   dbg_ep_queue: ep7in: req
ffffff87f99b8600 length 0/65536 zsI ==> -115
[ 1022.190989264       0x4ad6e12c2]   dbg_prepare: ep7in: trb
ffffffc019c950b0 (E12:D0) buf 00000000ec2e0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.191262285       0x4ad6e273c]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.192143378       0x4ad6e6951]   dbg_ep_queue: ep7in: req
ffffff87f99b9400 length 0/65536 zsI ==> -115
[ 1022.192392076       0x4ad6e7bf8]   dbg_prepare: ep7in: trb
ffffffc019c950c0 (E13:D0) buf 00000000edc20000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.192731087       0x4ad6e9565]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.195348743       0x4ad6f59b8]   dbg_ep_queue: ep7in: req
ffffff87f99b9c00 length 0/65536 zsI ==> -115
[ 1022.195548847       0x4ad6f68ba]   dbg_prepare: ep7in: trb
ffffffc019c950d0 (E14:D0) buf 00000000eb4b0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.195788483       0x4ad6f7ab3]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.197640149       0x4ad700593]   dbg_ep_queue: ep7in: req
ffffff87f99b8b00 length 0/65536 zsI ==> -115
[ 1022.197829212       0x4ad7013c1]   dbg_prepare: ep7in: trb
ffffffc019c950e0 (E15:D0) buf 00000000eb4a0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.198138691       0x4ad702af7]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.199082493       0x4ad7071c0]   dbg_ep_queue: ep7in: req
ffffff87f99b8200 length 0/65536 zsI ==> -115
[ 1022.199285618       0x4ad7080fc]   dbg_prepare: ep7in: trb
ffffffc019c950f0 (E16:D0) buf 00000000eb490000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.199590253       0x4ad7097d6]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.201521139       0x4ad7128a6]   dbg_ep_queue: ep7in: req
ffffff87f99b9900 length 0/65536 zsI ==> -115
[ 1022.201770774       0x4ad713b5f]   dbg_prepare: ep7in: trb
ffffffc019c95100 (E17:D0) buf 00000000eda20000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.202101087       0x4ad715426]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.203201712       0x4ad71a6b1]   dbg_ep_queue: ep7in: req
ffffff87a77b0300 length 0/65536 zsI ==> -115
[ 1022.203411816       0x4ad71b673]   dbg_prepare: ep7in: trb
ffffffc019c95110 (E18:D0) buf 00000000eda10000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.203741608       0x4ad71cf2f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.205594785       0x4ad725a2c]   dbg_ep_queue: ep7in: req
ffffff8024deb100 length 0/65536 zsI ==> -115
[ 1022.205789368       0x4ad7268c4]   dbg_prepare: ep7in: trb
ffffffc019c95120 (E19:D0) buf 00000000eda00000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.206042910       0x4ad727bc9]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.206948014       0x4ad72bfab]   dbg_ep_queue: ep7in: req
ffffff8031a29c00 length 0/65536 zsI ==> -115
[ 1022.207191035       0x4ad72d1e4]   dbg_prepare: ep7in: trb
ffffffc019c95130 (E20:D0) buf 00000000ed9f0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.207491139       0x4ad72e867]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.209417701       0x4ad7378e4]   dbg_ep_queue: ep7in: req
ffffff8031a28200 length 0/65536 zsI ==> -115
[ 1022.209585670       0x4ad73857d]   dbg_prepare: ep7in: trb
ffffffc019c95140 (E21:D0) buf 00000000ed9e0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.209880097       0x4ad739b92]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.210870618       0x4ad73e5dc]   dbg_ep_queue: ep7in: req
ffffff87823adb00 length 0/65536 zsI ==> -115
[ 1022.211070462       0x4ad73f4d9]   dbg_prepare: ep7in: trb
ffffffc019c95150 (E22:D0) buf 00000000ed9d0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.211367389       0x4ad740b1e]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.212341243       0x4ad745428]   dbg_ep_queue: ep7in: req
ffffff80516bdf00 length 0/65536 zsI ==> -115
[ 1022.212615254       0x4ad7468b5]   dbg_prepare: ep7in: trb
ffffffc019c95160 (E23:D0) buf 00000000eaff0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.212903639       0x4ad747e56]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.215038066       0x4ad751e6b]   dbg_ep_queue: ep7in: req
ffffff80516bd400 length 0/65536 zsI ==> -115
[ 1022.215279056       0x4ad75307e]   dbg_prepare: ep7in: trb
ffffffc019c95170 (E24:D0) buf 00000000eb000000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.215585201       0x4ad754774]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.217435358       0x4ad75d237]   dbg_ep_queue: ep7in: req
ffffff80516bc500 length 0/65536 zsI ==> -115
[ 1022.217643639       0x4ad75e1d6]   dbg_prepare: ep7in: trb
ffffffc019c95180 (E25:D0) buf 00000000eb010000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.217942962       0x4ad75f849]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.218891191       0x4ad763f67]   dbg_ep_queue: ep7in: req
ffffff80516bc600 length 0/65536 zsI ==> -115
[ 1022.219142754       0x4ad765245]   dbg_prepare: ep7in: trb
ffffffc019c95190 (E26:D0) buf 00000000e9f40000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.219440722       0x4ad76689e]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.221245826       0x4ad76f000]   dbg_ep_queue: ep7in: req
ffffff80516bda00 length 0/65536 zsI ==> -115
[ 1022.221383899       0x4ad76fa5b]   dbg_prepare: ep7in: trb
ffffffc019c951a0 (E27:D0) buf 00000000e9f30000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.221613951       0x4ad770b9c]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.222426035       0x4ad774884]   dbg_ep_queue: ep7in: req
ffffff80516bcc00 length 0/65536 zsI ==> -115
[ 1022.222624472       0x4ad775766]   dbg_prepare: ep7in: trb
ffffffc019c951b0 (E28:D0) buf 00000000e9f20000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.222921504       0x4ad776dae]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.223955306       0x4ad77bb36]   dbg_ep_queue: ep7in: req
ffffff80516bc100 length 0/65536 zsI ==> -115
[ 1022.224171087       0x4ad77cb65]   dbg_prepare: ep7in: trb
ffffffc019c951c0 (E29:D0) buf 00000000e9f10000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.224515826       0x4ad77e540]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.226496399       0x4ad7879cb]   dbg_ep_queue: ep7in: req
ffffff80516bd600 length 0/65536 zsI ==> -115
[ 1022.226714212       0x4ad788a21]   dbg_prepare: ep7in: trb
ffffffc019c951d0 (E30:D0) buf 00000000ed610000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.226996608       0x4ad789f4f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.227871139       0x4ad78e0e6]   dbg_ep_queue: ep7in: req
ffffff80516bd700 length 0/65536 zsI ==> -115
[ 1022.228041556       0x4ad78edae]   dbg_prepare: ep7in: trb
ffffffc019c951e0 (E31:D0) buf 00000000ed620000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.228346139       0x4ad790487]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.230203691       0x4ad798fd7]   dbg_ep_queue: ep7in: req
ffffff80516bdc00 length 0/65536 zsI ==> -115
[ 1022.230418743       0x4ad799ff8]   dbg_prepare: ep7in: trb
ffffffc019c951f0 (E32:D0) buf 00000000ea2e0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.230673431       0x4ad79b313]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.231428899       0x4ad79ebbb]   dbg_ep_queue: ep7in: req
ffffff80362e7100 length 0/65536 zsI ==> -115
[ 1022.231627389       0x4ad79fa9f]   dbg_prepare: ep7in: trb
ffffffc019c95200 (E33:D0) buf 00000000ed470000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.231867806       0x4ad7a0ca6]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.233866660       0x4ad7aa290]   dbg_ep_queue: ep7in: req
ffffff80362e7e00 length 0/65536 zsI ==> -115
[ 1022.234058014       0x4ad7ab0ea]   dbg_prepare: ep7in: trb
ffffffc019c95210 (E34:D0) buf 00000000ec870000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.234295618       0x4ad7ac2bc]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.235085670       0x4ad7afdfd]   dbg_ep_queue: ep7in: req
ffffff80362e7000 length 0/65536 zsI ==> -115
[ 1022.235273483       0x4ad7b0c13]   dbg_prepare: ep7in: trb
ffffffc019c95220 (E35:D0) buf 00000000eb230000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.235526504       0x4ad7b1f0d]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.236322962       0x4ad7b5ac9]   dbg_ep_queue: ep7in: req
ffffff8041076d00 length 0/65536 zsI ==> -115
[ 1022.236553379       0x4ad7b6c11]   dbg_prepare: ep7in: trb
ffffffc019c95230 (E36:D0) buf 00000000eb220000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.236865149       0x4ad7b8374]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.239204472       0x4ad7c32e6]   dbg_ep_queue: ep7in: req
ffffff8041076f00 length 0/65536 zsI ==> -115
[ 1022.239361608       0x4ad7c3eaf]   dbg_prepare: ep7in: trb
ffffffc019c95240 (E37:D0) buf 00000000eb210000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.239594577       0x4ad7c5028]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.241303795       0x4ad7cd059]   dbg_ep_queue: ep7in: req
ffffff8041077000 length 0/65536 zsI ==> -115
[ 1022.241560410       0x4ad7ce398]   dbg_prepare: ep7in: trb
ffffffc019c95250 (E38:D0) buf 00000000ea730000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.241866972       0x4ad7cfa97]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.242850254       0x4ad7d4455]   dbg_ep_queue: ep7in: req
ffffff8041076b00 length 0/65536 zsI ==> -115
[ 1022.243098899       0x4ad7d56fb]   dbg_prepare: ep7in: trb
ffffffc019c95260 (E39:D0) buf 00000000eb840000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.243399785       0x4ad7d6d8d]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.247736920       0x4ad7eb2d5]   dbg_ep_queue: ep7in: req
ffffff8041076400 length 0/65536 zsI ==> -115
[ 1022.247987285       0x4ad7ec59c]   dbg_prepare: ep7in: trb
ffffffc019c95270 (E40:D0) buf 00000000ec7b0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.248292910       0x4ad7edc88]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.249930566       0x4ad7f575b]   dbg_ep_queue: ep7in: req
ffffff8041077f00 length 0/65536 zsI ==> -115
[ 1022.250121712       0x4ad7f65b1]   dbg_prepare: ep7in: trb
ffffffc019c95280 (E41:D0) buf 00000000ec7a0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.250417493       0x4ad7f7be0]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.251359524       0x4ad7fc288]   dbg_ep_queue: ep7in: req
ffffff8041077400 length 0/65536 zsI ==> -115
[ 1022.251551035       0x4ad7fd0e4]   dbg_prepare: ep7in: trb
ffffffc019c95290 (E42:D0) buf 00000000ec790000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.251853847       0x4ad7fe79a]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.253491972       0x4ad806276]   dbg_ep_queue: ep7in: req
ffffff8041077100 length 0/65536 zsI ==> -115
[ 1022.253677389       0x4ad80705e]   dbg_prepare: ep7in: trb
ffffffc019c952a0 (E43:D0) buf 00000000ec780000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.253960827       0x4ad8085a0]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.254907649       0x4ad80cca3]   dbg_ep_queue: ep7in: req
ffffff8041076c00 length 0/65536 zsI ==> -115
[ 1022.255097702       0x4ad80dae4]   dbg_prepare: ep7in: trb
ffffffc019c952b0 (E44:D0) buf 00000000ec770000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.255395358       0x4ad80f137]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.262690202       0x4ad831454]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.273617650       0x4ad8647e4]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 2, Length = 48)
[ 1022.274048431       0x4ad866832]   dbg_ep_queue: ep7in: req
ffffff87b6feb800 length 0/65536 zsI ==> -115
[ 1022.274240306       0x4ad867696]   dbg_prepare: ep7in: trb
ffffffc019c952c0 (E45:D0) buf 00000000ea740000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.274538743       0x4ad868cf8]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.275258118       0x4ad86c2ec]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.279635722       0x4ad880b3f]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 48/48 zsI ==> 0
[ 1022.280563587       0x4ad8850d6]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.284439420       0x4ad897386]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.287758275       0x4ad8a6c6f]   dbg_ep_queue: ep7in: req
ffffff87b6feb300 length 0/65536 zsI ==> -115
[ 1022.287975462       0x4ad8a7cb9]   dbg_prepare: ep7in: trb
ffffffc019c952d0 (E46:D0) buf 00000000ea750000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.288308170       0x4ad8a95ad]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.301895827       0x4ad8e90c1]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 6, Length = 4)
[ 1022.302244316       0x4ad8eaae3]   dbg_ep_queue: ep7in: req
ffffff87b6febe00 length 0/65536 zsI ==> -115
[ 1022.302395098       0x4ad8eb632]   dbg_prepare: ep7in: trb
ffffffc019c952e0 (E47:D0) buf 00000000ea760000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.302627441       0x4ad8ec79f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.303233066       0x4ad8ef50b]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.306936660       0x4ad900ad1]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.307401035       0x4ad902da4]   dbg_ep_queue: ep7in: req
ffffff80404e2e00 length 0/65536 zsI ==> -115
[ 1022.307555566       0x4ad90393b]   dbg_prepare: ep7in: trb
ffffffc019c952f0 (E48:D0) buf 00000000ea770000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.307798900       0x4ad904b7b]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.308401608       0x4ad9078b0]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.309304993       0x4ad90bc71]   dbg_ep_queue: ep7in: req
ffffff80404e2800 length 0/65536 zsI ==> -115
[ 1022.309509785       0x4ad90cbcc]   dbg_prepare: ep7in: trb
ffffffc019c95300 (E49:D0) buf 00000000ea780000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.309798952       0x4ad90e17d]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.310672181       0x4ad9122fa]   dbg_ep_queue: ep7in: req
ffffff80404e2a00 length 0/65536 zsI ==> -115
[ 1022.310847858       0x4ad913027]   dbg_prepare: ep7in: trb
ffffffc019c95310 (E50:D0) buf 00000000ea790000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.311195410       0x4ad914a38]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.312244420       0x4ad9198e5]   dbg_ep_queue: ep7in: req
ffffff80404e3000 length 0/65536 zsI ==> -115
[ 1022.312465150       0x4ad91a973]   dbg_prepare: ep7in: trb
ffffffc019c95320 (E51:D0) buf 00000000ea7a0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.312797233       0x4ad91c25b]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.314916452       0x4ad92614d]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.325852650       0x4ad959584]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 6, Length = 12)
[ 1022.326294993       0x4ad95b6b0]   dbg_ep_queue: ep7in: req
ffffff882a491900 length 0/65536 zsI ==> -115
[ 1022.326578275       0x4ad95cbef]   dbg_prepare: ep7in: trb
ffffffc019c95330 (E52:D0) buf 00000000ebfa0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.326888483       0x4ad95e333]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.327583796       0x4ad96175a]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.332992337       0x4ad97acfd]   dbg_ep_queue: ep7in: req
ffffff882a490e00 length 0/65536 zsI ==> -115
[ 1022.333192337       0x4ad97bbfd]   dbg_prepare: ep7in: trb
ffffffc019c95340 (E53:D0) buf 00000000ebfb0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.333523014       0x4ad97d4ca]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.334494525       0x4ad981da7]   dbg_ep_queue: ep7in: req
ffffff8783db4200 length 0/65536 zsI ==> -115
[ 1022.334681712       0x4ad982bb1]   dbg_prepare: ep7in: trb
ffffffc019c95350 (E54:D0) buf 00000000eda50000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.334962858       0x4ad9840c7]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.335479889       0x4ad98678f]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 12/12 zsI ==> 0
[ 1022.335813327       0x4ad988090]   dbg_ep_queue: ep7in: req
ffffff8783db4f00 length 0/65536 zsI ==> -115
[ 1022.335940618       0x4ad988a1c]   dbg_prepare: ep7in: trb
ffffffc019c95360 (E55:D0) buf 00000000eda60000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.336141035       0x4ad989924]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.336539785       0x4ad98b70d]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.338893743       0x4ad996799]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.341042806       0x4ad9a08c6]   dbg_ep_queue: ep7in: req
ffffff8035aff600 length 0/65536 zsI ==> -115
[ 1022.341269316       0x4ad9a19c3]   dbg_prepare: ep7in: trb
ffffffc019c95370 (E56:D0) buf 00000000eda70000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.341530150       0x4ad9a2d53]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.342426816       0x4ad9a7093]   dbg_ep_queue: ep7in: req
ffffff8035affd00 length 0/65536 zsI ==> -115
[ 1022.342604785       0x4ad9a7dec]   dbg_prepare: ep7in: trb
ffffffc019c95380 (E57:D0) buf 00000000eda80000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.342875775       0x4ad9a923f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.343732598       0x4ad9ad283]   dbg_ep_queue: ep7in: req
ffffff8035afff00 length 0/65536 zsI ==> -115
[ 1022.343903327       0x4ad9adf50]   dbg_prepare: ep7in: trb
ffffffc019c95390 (E58:D0) buf 00000000eda90000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.344171921       0x4ad9af375]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.364524785       0x4ada0e9ed]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 7, Length = 4)
[ 1022.365009785       0x4ada10e4d]   dbg_ep_queue: ep7in: req
ffffff8035afea00 length 0/65536 zsI ==> -115
[ 1022.365185671       0x4ada11b7d]   dbg_prepare: ep7in: trb
ffffffc019c953a0 (E59:D0) buf 00000000ec390000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.365383066       0x4ada12a4b]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.365934212       0x4ada153a2]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.366373379       0x4ada17491]   dbg_ep_queue: ep7in: req
ffffff8035afef00 length 0/65536 zsI ==> -115
[ 1022.366529369       0x4ada18044]   dbg_prepare: ep7in: trb
ffffffc019c953b0 (E60:D0) buf 00000000ec3a0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.366786869       0x4ada19394]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.367645619       0x4ada1d3fc]   dbg_ep_queue: ep7in: req
ffffff8035afed00 length 0/65536 zsI ==> -115
[ 1022.367845358       0x4ada1e2f7]   dbg_prepare: ep7in: trb
ffffffc019c953c0 (E61:D0) buf 00000000ec3b0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.368156660       0x4ada1fa50]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.377212181       0x4ada4a17a]   dbg_ep_queue: ep4out: req
ffffff87ebc49d00 length 0/16384 zsI ==> -115
[ 1022.377354942       0x4ada4ac2f]   dbg_prepare: ep4out: trb
ffffffc019b01070 (E8:D0) buf 00000000e9d00000 size 16384 ctrl 00000819
(HlcS:sC:normal)
[ 1022.377629160       0x4ada4c0c0]   dbg_send_ep_cmd: ep4out: cmd
'Update Transfer' [80007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.380190619       0x4ada580dc]   dbg_ep_queue: ep7in: req
ffffff8035afe300 length 0/65536 zsI ==> -115
[ 1022.380402806       0x4ada590c6]   dbg_prepare: ep7in: trb
ffffffc019c953d0 (E62:D0) buf 00000000ec3c0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.380751764       0x4ada5aaf2]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.386202337       0x4ada743bd]   dbg_ep_queue: ep7in: req
ffffff8035affc00 length 0/65536 zsI ==> -115
[ 1022.386417702       0x4ada753e4]   dbg_prepare: ep7in: trb
ffffffc019c953e0 (E63:D0) buf 00000000eaee0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.386682285       0x4ada767bc]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.387703744       0x4ada7b458]   dbg_ep_queue: ep7in: req
ffffff887524fe00 length 0/65536 zsI ==> -115
[ 1022.387833900       0x4ada7be1b]   dbg_prepare: ep7in: trb
ffffffc019c953f0 (E64:D0) buf 00000000eaef0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.388036087       0x4ada7cd45]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.389338171       0x4ada82eed]   dbg_ep_queue: ep7in: req
ffffff80457e1d00 length 0/65536 zsI ==> -115
[ 1022.389460931       0x4ada83822]   dbg_prepare: ep7in: trb
ffffffc019c95400 (E65:D0) buf 00000000eaf00000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.389669681       0x4ada847ca]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.390441348       0x4ada881aa]   dbg_ep_queue: ep7in: req
ffffff80457e0600 length 0/65536 zsI ==> -115
[ 1022.390606608       0x4ada88e0f]   dbg_prepare: ep7in: trb
ffffffc019c95410 (E66:D0) buf 00000000eaf10000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.390872546       0x4ada8a201]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.391738744       0x4ada8e2f8]   dbg_ep_queue: ep7in: req
ffffff80457e0400 length 0/65536 zsI ==> -115
[ 1022.391913379       0x4ada8f011]   dbg_prepare: ep7in: trb
ffffffc019c95420 (E67:D0) buf 00000000eaf20000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.392182598       0x4ada90442]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.396914994       0x4adaa6730]   dbg_ep_queue: ep7in: req
ffffff80457e0500 length 0/65536 zsI ==> -115
[ 1022.397088067       0x4adaa742b]   dbg_prepare: ep7in: trb
ffffffc019c95430 (E68:D0) buf 00000000eaf30000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.397316660       0x4adaa8550]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.397921712       0x4adaab2b1]   dbg_ep_queue: ep7in: req
ffffff80457e1800 length 0/65536 zsI ==> -115
[ 1022.398042337       0x4adaabbbd]   dbg_prepare: ep7in: trb
ffffffc019c95440 (E69:D0) buf 00000000eaf40000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.398289890       0x4adaace4e]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.399133379       0x4adab0d91]   dbg_ep_queue: ep7in: req
ffffff80457e0d00 length 0/65536 zsI ==> -115
[ 1022.399333796       0x4adab1c99]   dbg_prepare: ep7in: trb
ffffffc019c95450 (E70:D0) buf 00000000eaf50000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.399632233       0x4adab32fb]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.404179004       0x4adac87fd]   dbg_ep_queue: ep7in: req
ffffff80457e0f00 length 0/65536 zsI ==> -115
[ 1022.404378171       0x4adac96ed]   dbg_prepare: ep7in: trb
ffffffc019c95460 (E71:D0) buf 00000000eaf60000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.404734785       0x4adacb1ac]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.410588379       0x4adae68b2]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.410961869       0x4adae84b4]   dbg_ep_queue: ep7in: req
ffffff80457e1000 length 0/65536 zsI ==> -115
[ 1022.411142442       0x4adae9240]   dbg_prepare: ep7in: trb
ffffffc019c95470 (E72:D0) buf 00000000eaf70000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.411424473       0x4adaea766]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.412038223       0x4adaed56f]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.415723223       0x4adafe9cf]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.417173171       0x4adb0568d]   dbg_ep_queue: ep7in: req
ffffff80457e0e00 length 0/65536 zsI ==> -115
[ 1022.417383640       0x4adb06656]   dbg_prepare: ep7in: trb
ffffffc019c95480 (E73:D0) buf 00000000eaf80000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.417703744       0x4adb07e58]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.428008223       0x4adb3832f]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 7, Length = 18)
[ 1022.428451452       0x4adb3a46c]   dbg_ep_queue: ep7in: req
ffffff80412da900 length 0/65536 zsI ==> -115
[ 1022.428650879       0x4adb3b361]   dbg_prepare: ep7in: trb
ffffffc019c95490 (E74:D0) buf 00000000eaf90000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.428904785       0x4adb3c66c]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.429569004       0x4adb3f83e]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.435199577       0x4adb59e89]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 18/18 zsI ==> 0
[ 1022.435548119       0x4adb5b8ac]   dbg_ep_queue: ep7in: req
ffffff80412db600 length 0/65536 zsI ==> -115
[ 1022.435729213       0x4adb5c641]   dbg_prepare: ep7in: trb
ffffffc019c954a0 (E75:D0) buf 00000000eafa0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.436015150       0x4adb5dbb3]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.436670306       0x4adb60cd7]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.440005410       0x4adb706f9]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.440531869       0x4adb72e74]   dbg_ep_queue: ep7in: req
ffffff80412db900 length 0/65536 zsI ==> -115
[ 1022.440733796       0x4adb73d99]   dbg_prepare: ep7in: trb
ffffffc019c954b0 (E76:D0) buf 00000000eafb0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.441077806       0x4adb75766]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.461501661       0x4adbd5331]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 8, Length = 4)
[ 1022.461715202       0x4adbd6334]   dbg_ep_queue: ep7in: req
ffffff80412db000 length 0/65536 zsI ==> -115
[ 1022.461813744       0x4adbd6a98]   dbg_prepare: ep7in: trb
ffffffc019c954c0 (E77:D0) buf 00000000eafc0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.461959942       0x4adbd758f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.462336140       0x4adbd91c7]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.464558640       0x4adbe3876]   dbg_ep_queue: ep7in: req
ffffff80412dbb00 length 0/65536 zsI ==> -115
[ 1022.464688223       0x4adbe422e]   dbg_prepare: ep7in: trb
ffffffc019c954d0 (E78:D0) buf 00000000ea9f0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.464831296       0x4adbe4ce9]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.465334473       0x4adbe72a6]   dbg_ep_queue: ep7in: req
ffffff80320f0b00 length 0/65536 zsI ==> -115
[ 1022.465464838       0x4adbe7c6d]   dbg_prepare: ep7in: trb
ffffffc019c954e0 (E79:D0) buf 00000000eaa00000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.465629213       0x4adbe88c1]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.466198119       0x4adbeb36d]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.466381036       0x4adbec124]   dbg_ep_queue: ep7in: req
ffffff80320f0500 length 0/65536 zsI ==> -115
[ 1022.466480567       0x4adbec89b]   dbg_prepare: ep7in: trb
ffffffc019c954f0 (E80:D0) buf 00000000eaa10000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.466621713       0x4adbed331]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.466946973       0x4adbeeb96]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.467227963       0x4adbf00a9]   dbg_ep_queue: ep7in: req
ffffff80320f1c00 length 0/65536 zsI ==> -115
[ 1022.467327233       0x4adbf081b]   dbg_prepare: ep7in: trb
ffffffc019c95500 (E81:D0) buf 00000000ed890000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.467481348       0x4adbf13ab]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.467845358       0x4adbf2ef8]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.468130879       0x4adbf4461]   dbg_ep_queue: ep7in: req
ffffff80320f1800 length 0/65536 zsI ==> -115
[ 1022.468229577       0x4adbf4bc8]   dbg_prepare: ep7in: trb
ffffffc019c95510 (E82:D0) buf 00000000ed880000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.468393223       0x4adbf580e]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.479144629       0x4adc27e6a]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 8, Length = 20)
[ 1022.479358275       0x4adc28e6f]   dbg_ep_queue: ep7in: req
ffffff80320f0300 length 0/65536 zsI ==> -115
[ 1022.479457442       0x4adc295df]   dbg_prepare: ep7in: trb
ffffffc019c95520 (E83:D0) buf 00000000ed870000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.479599473       0x4adc2a086]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.479977286       0x4adc2bcdd]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.482375411       0x4adc370b8]   dbg_ep_queue: ep7in: req
ffffff80407e7000 length 0/65536 zsI ==> -115
[ 1022.482486348       0x4adc3790a]   dbg_prepare: ep7in: trb
ffffffc019c95530 (E84:D0) buf 00000000ed860000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.482658848       0x4adc385fa]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.483628171       0x4adc3cead]   dbg_ep_queue: ep7in: req
ffffff80407e7b00 length 0/65536 zsI ==> -115
[ 1022.483802234       0x4adc3dbbb]   dbg_prepare: ep7in: trb
ffffffc019c95540 (E85:D0) buf 00000000ed850000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.484092963       0x4adc3f189]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.485673431       0x4adc46812]   dbg_ep_queue: ep7in: req
ffffff80407e6600 length 0/65536 zsI ==> -115
[ 1022.485894525       0x4adc478a7]   dbg_prepare: ep7in: trb
ffffffc019c95550 (E86:D0) buf 00000000ed840000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.486238588       0x4adc49275]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.487288588       0x4adc4e135]   dbg_ep_queue: ep7in: req
ffffff80407e7a00 length 0/65536 zsI ==> -115
[ 1022.487499473       0x4adc4f106]   dbg_prepare: ep7in: trb
ffffffc019c95560 (E87:D0) buf 00000000eb240000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.487851088       0x4adc50b65]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.495430671       0x4adc743dd]   dbg_ep_queue: ep7in: req
ffffff80407e6f00 length 0/65536 zsI ==> -115
[ 1022.495655827       0x4adc754c0]   dbg_prepare: ep7in: trb
ffffffc019c95570 (E88:D0) buf 00000000ec1b0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.495946244       0x4adc76a88]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.501360567       0x4adc9009b]   dbg_ep_queue: ep7in: req
ffffff80407e7d00 length 0/65536 zsI ==> -115
[ 1022.501554838       0x4adc90f2d]   dbg_prepare: ep7in: trb
ffffffc019c95580 (E89:D0) buf 00000000ec1a0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.501869681       0x4adc926ca]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.503020723       0x4adc97d1e]   dbg_ep_queue: ep7in: req
ffffff80407e6400 length 0/65536 zsI ==> -115
[ 1022.503238275       0x4adc98d6f]   dbg_prepare: ep7in: trb
ffffffc019c95590 (E90:D0) buf 00000000ec190000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.503578067       0x4adc9a6eb]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.523925932       0x4adcf9d02]   dbg_ep_queue: ep7in: req
ffffff80407e7f00 length 0/65536 zsI ==> -115
[ 1022.524124057       0x4adcfabdf]   dbg_prepare: ep7in: trb
ffffffc019c955a0 (E91:D0) buf 00000000ec180000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.524470932       0x4adcfc5e3]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.530028692       0x4add166b7]   dbg_ep_queue: ep7in: req
ffffff87fec7f900 length 0/65536 zsI ==> -115
[ 1022.530220879       0x4add17521]   dbg_prepare: ep7in: trb
ffffffc019c955b0 (E92:D0) buf 00000000ec170000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.530517546       0x4add18b61]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.531490359       0x4add1d458]   dbg_ep_queue: ep7in: req
ffffff87fec7fe00 length 0/65536 zsI ==> -115
[ 1022.531729421       0x4add1e645]   dbg_prepare: ep7in: trb
ffffffc019c955c0 (E93:D0) buf 00000000ef160000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.532045150       0x4add1fdf3]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.545574317       0x4add5f4a3]   dbg_ep_queue: ep7in: req
ffffff87fec7fb00 length 0/65536 zsI ==> -115
[ 1022.545770984       0x4add60363]   dbg_prepare: ep7in: trb
ffffffc019c955d0 (E94:D0) buf 00000000ef170000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.546076973       0x4add61a56]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.547103848       0x4add6675a]   dbg_ep_queue: ep7in: req
ffffff87fec7e800 length 0/65536 zsI ==> -115
[ 1022.547298484       0x4add675f3]   dbg_prepare: ep7in: trb
ffffffc019c955e0 (E95:D0) buf 00000000ef180000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.547601296       0x4add68ca9]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.552093640       0x4add7dd96]   dbg_ep_queue: ep7in: req
ffffff885fa9a900 length 0/65536 zsI ==> -115
[ 1022.552297077       0x4add7ecd8]   dbg_prepare: ep7in: trb
ffffffc019c955f0 (E96:D0) buf 00000000ef190000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.552638067       0x4add8066b]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.573464994       0x4adde2070]   dbg_ep_queue: ep7in: req
ffffff885fa9ba00 length 0/65536 zsI ==> -115
[ 1022.573702338       0x4adde323d]   dbg_prepare: ep7in: trb
ffffffc019c95600 (E97:D0) buf 00000000eb7f0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.573976400       0x4adde46cb]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.574876921       0x4adde8a56]   dbg_ep_queue: ep7in: req
ffffff885fa9ab00 length 0/65536 zsI ==> -115
[ 1022.575055932       0x4adde97c2]   dbg_prepare: ep7in: trb
ffffffc019c95610 (E98:D0) buf 00000000eb800000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.575347025       0x4addead97]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.579944942       0x4ade0066f]   dbg_ep_queue: ep7in: req
ffffff885fa9b200 length 0/65536 zsI ==> -115
[ 1022.580162755       0x4ade016c5]   dbg_prepare: ep7in: trb
ffffffc019c95620 (E99:D0) buf 00000000eb810000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.580503796       0x4ade03059]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.581910255       0x4ade099d5]   dbg_ep_queue: ep7in: req
ffffff885fa9a200 length 0/65536 zsI ==> -115
[ 1022.582079786       0x4ade0a68d]   dbg_prepare: ep7in: trb
ffffffc019c95630 (E100:D0) buf 00000000ed790000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.582295203       0x4ade0b6b4]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.582898744       0x4ade0e3f9]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 20/20 zsI ==> 0
[ 1022.583323119       0x4ade103cc]   dbg_ep_queue: ep7in: req
ffffff885fa9b100 length 0/65536 zsI ==> -115
[ 1022.583522390       0x4ade112bf]   dbg_prepare: ep7in: trb
ffffffc019c95640 (E101:D0) buf 00000000ead50000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.583817286       0x4ade128dc]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.584498900       0x4ade15bfb]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.587180203       0x4ade22515]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.599248588       0x4ade5ae35]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 9, Length = 4)
[ 1022.600250984       0x4ade5f964]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.600711609       0x4ade61bef]   dbg_ep_queue: ep7in: req
ffffff885fa9a000 length 0/65536 zsI ==> -115
[ 1022.600886036       0x4ade62904]   dbg_prepare: ep7in: trb
ffffffc019c95650 (E102:D0) buf 00000000ec570000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.601202911       0x4ade640c8]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.606840046       0x4ade7e792]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.607197286       0x4ade8025c]   dbg_ep_queue: ep7in: req
ffffff885fa9bc00 length 0/65536 zsI ==> -115
[ 1022.607397703       0x4ade81164]   dbg_prepare: ep7in: trb
ffffffc019c95660 (E103:D0) buf 00000000eace0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.607700776       0x4ade8281f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.608335463       0x4ade857b9]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.611118223       0x4ade9286e]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.621105932       0x4adec1583]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 9, Length = 28)
[ 1022.621645151       0x4adec3df4]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.622513015       0x4adec7f0a]   dbg_ep_queue: ep7in: req
ffffff8036148600 length 0/65536 zsI ==> -115
[ 1022.622615880       0x4adec86c1]   dbg_prepare: ep7in: trb
ffffffc019c95670 (E104:D0) buf 00000000eefd0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.622773015       0x4adec928a]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.623310515       0x4adecbada]   dbg_ep_queue: ep7in: req
ffffff8036149100 length 0/65536 zsI ==> -115
[ 1022.623415828       0x4adecc2c0]   dbg_prepare: ep7in: trb
ffffffc019c95680 (E105:D0) buf 00000000eefc0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.623573796       0x4adecce99]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.623890776       0x4adece660]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 28/28 zsI ==> 0
[ 1022.624102599       0x4adecf642]   dbg_ep_queue: ep7in: req
ffffff8036149500 length 0/65536 zsI ==> -115
[ 1022.624200046       0x4adecfd92]   dbg_prepare: ep7in: trb
ffffffc019c95690 (E106:D0) buf 00000000edc10000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.624350567       0x4aded08db]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.624678953       0x4aded217d]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.626562078       0x4adedaeb9]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.626845515       0x4adedc3fa]   dbg_ep_queue: ep7in: req
ffffff8036149e00 length 0/65536 zsI ==> -115
[ 1022.626948015       0x4adedcbaa]   dbg_prepare: ep7in: trb
ffffffc019c956a0 (E107:D0) buf 00000000edc00000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.627103432       0x4adedd752]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.627602599       0x4adedfcc2]   dbg_ep_queue: ep7in: req
ffffff8036149f00 length 0/65536 zsI ==> -115
[ 1022.627706505       0x4adee048d]   dbg_prepare: ep7in: trb
ffffffc019c956b0 (E108:D0) buf 00000000ed930000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.627865828       0x4adee1080]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.630117130       0x4adeeb959]   dbg_ep_queue: ep7in: req
ffffff8036149700 length 0/65536 zsI ==> -115
[ 1022.630221609       0x4adeec12f]   dbg_prepare: ep7in: trb
ffffffc019c956c0 (E109:D0) buf 00000000ed920000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.630383276       0x4adeecd4f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.630885515       0x4adeef2fa]   dbg_ep_queue: ep7in: req
ffffff8036149400 length 0/65536 zsI ==> -115
[ 1022.630989057       0x4adeefabe]   dbg_prepare: ep7in: trb
ffffffc019c956d0 (E110:D0) buf 00000000ec000000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.631148640       0x4adef06b6]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.631657234       0x4adef2cdc]   dbg_ep_queue: ep7in: req
ffffff8036148500 length 0/65536 zsI ==> -115
[ 1022.631758380       0x4adef3471]   dbg_prepare: ep7in: trb
ffffffc019c956e0 (E111:D0) buf 00000000ed440000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.631921609       0x4adef40af]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.647709942       0x4adf3e0d0]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 2, Length = 4)
[ 1022.648254265       0x4adf409a3]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.650697911       0x4adf4c0e9]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.651091244       0x4adf4de69]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.651928536       0x4adf51d35]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.653585203       0x4adf59974]   dbg_ep_queue: ep7in: req
ffffff8036148400 length 0/65536 zsI ==> -115
[ 1022.653697547       0x4adf5a1e1]   dbg_prepare: ep7in: trb
ffffffc019c956f0 (E112:D0) buf 00000000ed450000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.653861922       0x4adf5ae35]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.663434005       0x4adf87c1f]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 2, Length = 4)
[ 1022.663868640       0x4adf89cb6]   dbg_ep_queue: ep7in: req
ffffff8036149c00 length 0/65536 zsI ==> -115
[ 1022.664063119       0x4adf8ab4c]   dbg_prepare: ep7in: trb
ffffffc019c95700 (E113:D0) buf 00000000ed460000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.664363849       0x4adf8c1da]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.665098328       0x4adf8f8f1]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.670846870       0x4adfaa815]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.671775932       0x4adfaedc2]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.675540151       0x4adfc0814]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.688456140       0x4adffd0c7]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 2, Length = 48)
[ 1022.689053380       0x4adfffd92]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.694700724       0x4ae01a51f]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 48/48 zsI ==> 0
[ 1022.695633015       0x4ae01eb0a]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.699347807       0x4ae0301a7]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.701885828       0x4ae03c000]   dbg_ep_queue: ep7in: req
ffffff8036148900 length 0/65536 zsI ==> -115
[ 1022.702083588       0x4ae03ced5]   dbg_prepare: ep7in: trb
ffffffc019c95710 (E114:D0) buf 00000000ea900000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.702366557       0x4ae03e40e]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.703397495       0x4ae043160]   dbg_ep_queue: ep7in: req
ffffff8036148700 length 0/65536 zsI ==> -115
[ 1022.703586245       0x4ae043f88]   dbg_prepare: ep7in: trb
ffffffc019c95720 (E115:D0) buf 00000000eb2f0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.703887859       0x4ae045627]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.713802182       0x4ae073dba]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 2, Length = 48)
[ 1022.714216453       0x4ae075ccd]   dbg_ep_queue: ep7in: req
ffffff804123dd00 length 0/65536 zsI ==> -115
[ 1022.714408224       0x4ae076b2e]   dbg_prepare: ep7in: trb
ffffffc019c95730 (E116:D0) buf 00000000eb300000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.714717807       0x4ae078266]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.715446245       0x4ae07b90a]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.719827078       0x4ae090199]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 48/48 zsI ==> 0
[ 1022.720788484       0x4ae0949b3]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.724179578       0x4ae0a4809]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.736732338       0x4ae0df57e]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 3, Length = 4)
[ 1022.736956453       0x4ae0e064c]   dbg_ep_queue: ep7in: req
ffffff804123cd00 length 0/65536 zsI ==> -115
[ 1022.737055724       0x4ae0e0dbe]   dbg_prepare: ep7in: trb
ffffffc019c95740 (E117:D0) buf 00000000eb310000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.737201193       0x4ae0e18a7]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.737563068       0x4ae0e33cb]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.739713901       0x4ae0ed51c]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.740156297       0x4ae0ef64a]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.741988224       0x4ae0f7faf]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.752077964       0x4ae12746a]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 3, Length = 4)
[ 1022.752518536       0x4ae129574]   dbg_ep_queue: ep7in: req
ffffff804123d800 length 0/65536 zsI ==> -115
[ 1022.752726505       0x4ae12a50d]   dbg_prepare: ep7in: trb
ffffffc019c95750 (E118:D0) buf 00000000eb320000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.753026922       0x4ae12bb95]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.753707651       0x4ae12eea4]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.754700099       0x4ae133912]   dbg_ep_queue: ep7in: req
ffffff804123c500 length 0/65536 zsI ==> -115
[ 1022.754917130       0x4ae134959]   dbg_prepare: ep7in: trb
ffffffc019c95760 (E119:D0) buf 00000000eb330000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.755243953       0x4ae1361dc]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.756343224       0x4ae13b44e]   dbg_ep_queue: ep7in: req
ffffff804123c300 length 0/65536 zsI ==> -115
[ 1022.756562651       0x4ae13c4c3]   dbg_prepare: ep7in: trb
ffffffc019c95770 (E120:D0) buf 00000000ef080000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.756885672       0x4ae13dcfd]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.759069943       0x4ae1480d0]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.760008693       0x4ae14c738]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.763579266       0x4ae15d303]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.777242339       0x4ae19d3bd]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 3, Length = 18)
[ 1022.777676714       0x4ae19f451]   dbg_ep_queue: ep7in: req
ffffff804123d300 length 0/65536 zsI ==> -115
[ 1022.777875620       0x4ae1a033c]   dbg_prepare: ep7in: trb
ffffffc019c95780 (E121:D0) buf 00000000ef090000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.778174787       0x4ae1a19ac]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.778887495       0x4ae1a4f21]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.779869474       0x4ae1a98c6]   dbg_ep_queue: ep7in: req
ffffff882a2a0000 length 0/65536 zsI ==> -115
[ 1022.780090568       0x4ae1aa95b]   dbg_prepare: ep7in: trb
ffffffc019c95790 (E122:D0) buf 00000000ef0a0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.780426974       0x4ae1ac296]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.781897182       0x4ae1b30da]   dbg_ep_queue: ep7in: req
ffffff882a2a1d00 length 0/65536 zsI ==> -115
[ 1022.782098120       0x4ae1b3fec]   dbg_prepare: ep7in: trb
ffffffc019c957a0 (E123:D0) buf 00000000ef0b0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.782390828       0x4ae1b55e0]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.783450151       0x4ae1ba553]   dbg_ep_queue: ep7in: req
ffffff882a2a1800 length 0/65536 zsI ==> -115
[ 1022.783658224       0x4ae1bb4ee]   dbg_prepare: ep7in: trb
ffffffc019c957b0 (E124:D0) buf 00000000ef0c0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.783968641       0x4ae1bcc36]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.784595828       0x4ae1bfb41]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 18/18 zsI ==> 0
[ 1022.785443380       0x4ae1c3ad2]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.791376766       0x4ae1df7d3]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.804292130       0x4ae21c079]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 3, Length = 18)
[ 1022.804729526       0x4ae21e147]   dbg_ep_queue: ep7in: req
ffffff882a2a0800 length 0/65536 zsI ==> -115
[ 1022.804898224       0x4ae21edee]   dbg_prepare: ep7in: trb
ffffffc019c957c0 (E125:D0) buf 00000000ef0d0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.805207755       0x4ae220525]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.805904787       0x4ae22396d]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.811321505       0x4ae23cfae]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 18/18 zsI ==> 0
[ 1022.812270464       0x4ae2416da]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.818837703       0x4ae260364]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.828776505       0x4ae28ecce]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep1in)
[ 1022.829417807       0x4ae291ce7]   dbg_send_ep_cmd: ep1in: cmd 'End
Transfer' [30d08] params 00000000 00000000 00000000 --> status: Successful
[ 1022.829974110       0x4ae29469f]   dbg_ep_queue: ep7in: req
ffffff882a2a0600 length 0/65536 zsI ==> -115
[ 1022.830181453       0x4ae29562c]   dbg_prepare: ep7in: trb
ffffffc019c957d0 (E126:D0) buf 00000000ef0e0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.830523953       0x4ae296fdc]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.835320568       0x4ae2ad79c]   dbg_send_ep_cmd: ep1in: cmd 'Clear
Stall' [405] params 00000000 00000000 00000000 --> status: Successful
[ 1022.836142391       0x4ae2b153e]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.839761453       0x4ae2c24ad]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.851694943       0x4ae2fa3b0]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep2in)
[ 1022.852198745       0x4ae2fc978]   dbg_send_ep_cmd: ep2in: cmd 'End
Transfer' [50d08] params 00000000 00000000 00000000 --> status: Successful
[ 1022.852715516       0x4ae2ff03a]   dbg_ep_queue: ep7in: req
ffffff882a2a0a00 length 0/65536 zsI ==> -115
[ 1022.852917183       0x4ae2fff5a]   dbg_prepare: ep7in: trb
ffffffc019c957e0 (E127:D0) buf 00000000ed800000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.853264266       0x4ae301962]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.854985672       0x4ae309a7d]   dbg_ep_queue: ep7in: req
ffffff80411f2700 length 0/65536 zsI ==> -115
[ 1022.855185672       0x4ae30a97d]   dbg_prepare: ep7in: trb
ffffffc019c957f0 (E128:D0) buf 00000000ed810000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.855513797       0x4ae30c219]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.856140880       0x4ae30f122]   dbg_send_ep_cmd: ep2in: cmd 'Clear
Stall' [405] params 00000000 00000000 00000000 --> status: Successful
[ 1022.856903068       0x4ae312a4c]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.860470360       0x4ae3235d8]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.872198485       0x4ae35a573]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep1out)
[ 1022.872832391       0x4ae35d4ff]   dbg_send_ep_cmd: ep1out: cmd 'End
Transfer' [20d08] params 00000000 00000000 00000000 --> status: Successful
[ 1022.873367912       0x4ae35fd28]   dbg_ep_queue: ep7in: req
ffffff80411f2c00 length 0/65536 zsI ==> -115
[ 1022.873584995       0x4ae360d70]   dbg_prepare: ep7in: trb
ffffffc019c95800 (E129:D0) buf 00000000ed820000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.873920672       0x4ae36269d]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.875639318       0x4ae36a783]   dbg_ep_queue: ep7in: req
ffffff80411f3e00 length 0/65536 zsI ==> -115
[ 1022.875859422       0x4ae36b806]   dbg_prepare: ep7in: trb
ffffffc019c95810 (E130:D0) buf 00000000ed830000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.876198224       0x4ae36d16f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.876805360       0x4ae36fef8]   dbg_send_ep_cmd: ep1out: cmd
'Clear Stall' [405] params 00000000 00000000 00000000 --> status: Successful
[ 1022.877437703       0x4ae372e65]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.877918953       0x4ae37527d]   dbg_send_ep_cmd: ep1out: cmd
'Start Transfer' [406] params 00000000 efff8000 00000000 --> status:
Successful
[ 1022.878399943       0x4ae37768f]   dbg_ep_queue: ep7in: req
ffffff80411f3200 length 0/65536 zsI ==> -115
[ 1022.878612495       0x4ae378680]   dbg_prepare: ep7in: trb
ffffffc019c95820 (E131:D0) buf 00000000eefb0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.878961453       0x4ae37a0ac]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.880047964       0x4ae37f229]   dbg_ep_queue: ep7in: req
ffffff8783b85000 length 0/65536 zsI ==> -115
[ 1022.880264162       0x4ae380260]   dbg_prepare: ep7in: trb
ffffffc019c95830 (E132:D0) buf 00000000edbf0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.880618016       0x4ae381cea]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.882651089       0x4ae38b566]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.892666506       0x4ae3ba48e]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep2out)
[ 1022.893373068       0x4ae3bd98c]   dbg_send_ep_cmd: ep2out: cmd 'End
Transfer' [40d08] params 00000000 00000000 00000000 --> status: Successful
[ 1022.893799683       0x4ae3bf98a]   dbg_ep_queue: ep7in: req
ffffff8783b84600 length 0/65536 zsI ==> -115
[ 1022.893977079       0x4ae3c06d8]   dbg_prepare: ep7in: trb
ffffffc019c95840 (E133:D0) buf 00000000edbe0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.894305620       0x4ae3c1f7c]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.895391037       0x4ae3c70e4]   dbg_ep_queue: ep7in: req
ffffff8783b85a00 length 0/65536 zsI ==> -115
[ 1022.895609266       0x4ae3c8142]   dbg_prepare: ep7in: trb
ffffffc019c95850 (E134:D0) buf 00000000edbd0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.895956089       0x4ae3c9b45]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.897702495       0x4ae3d1e40]   dbg_ep_queue: ep7in: req
ffffff80410f9d00 length 0/65536 zsI ==> -115
[ 1022.897912860       0x4ae3d2e07]   dbg_prepare: ep7in: trb
ffffffc019c95860 (E135:D0) buf 00000000edbc0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.898272287       0x4ae3d48fc]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.899269162       0x4ae3d93c1]   dbg_send_ep_cmd: ep2out: cmd
'Clear Stall' [405] params 00000000 00000000 00000000 --> status: Successful
[ 1022.899932495       0x4ae3dc580]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.900630360       0x4ae3df9d8]   dbg_send_ep_cmd: ep2out: cmd
'Start Transfer' [406] params 00000000 efff6000 00000000 --> status:
Successful
[ 1022.901128745       0x4ae3e1f38]   dbg_ep_queue: ep7in: req
ffffff8036150000 length 0/65536 zsI ==> -115
[ 1022.901330151       0x4ae3e2e53]   dbg_prepare: ep7in: trb
ffffffc019c95870 (E136:D0) buf 00000000eef60000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.901672026       0x4ae3e47f7]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.904160985       0x4ae3f02a4]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.921364422       0x4ae440ce5]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 6, Length = 4)
[ 1022.921800099       0x4ae442d93]   dbg_ep_queue: ep7in: req
ffffff8036151700 length 0/65536 zsI ==> -115
[ 1022.921997443       0x4ae443c5f]   dbg_prepare: ep7in: trb
ffffffc019c95880 (E137:D0) buf 00000000ead90000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.922300829       0x4ae445320]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.923021037       0x4ae448925]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.927955464       0x4ae45fb3a]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.928871558       0x4ae463fef]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.932513120       0x4ae47510d]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.934033797       0x4ae47c319]   dbg_ep_queue: ep7in: req
ffffff8036151e00 length 0/65536 zsI ==> -115
[ 1022.934250099       0x4ae47d352]   dbg_prepare: ep7in: trb
ffffffc019c95890 (E138:D0) buf 00000000ead80000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.934584787       0x4ae47ec6c]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.935629579       0x4ae483ac8]   dbg_ep_queue: ep7in: req
ffffff8036151500 length 0/65536 zsI ==> -115
[ 1022.935826714       0x4ae484991]   dbg_prepare: ep7in: trb
ffffffc019c958a0 (E139:D0) buf 00000000ead70000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.936146297       0x4ae486189]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.946096141       0x4ae4b4bc7]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 6, Length = 12)
[ 1022.946547808       0x4ae4b6da6]   dbg_ep_queue: ep7in: req
ffffff8036151f00 length 0/65536 zsI ==> -115
[ 1022.946751975       0x4ae4b7cf6]   dbg_prepare: ep7in: trb
ffffffc019c958b0 (E140:D0) buf 00000000ead60000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.947053433       0x4ae4b9393]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.947751975       0x4ae4bc7f7]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.952134631       0x4ae4d10aa]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 12/12 zsI ==> 0
[ 1022.953025516       0x4ae4d537a]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.958759475       0x4ae4f0187]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.969596193       0x4ae522e47]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 3, Length = 4)
[ 1022.970075308       0x4ae525236]   dbg_ep_queue: ep7in: req
ffffff8036150900 length 0/65536 zsI ==> -115
[ 1022.970291141       0x4ae526267]   dbg_prepare: ep7in: trb
ffffffc019c958c0 (E141:D0) buf 00000000ec3e0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.970599735       0x4ae52798b]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.971311350       0x4ae52aeeb]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1022.971822912       0x4ae52d548]   dbg_ep_queue: ep7in: req
ffffff8036151d00 length 0/65536 zsI ==> -115
[ 1022.972027912       0x4ae52e4a8]   dbg_prepare: ep7in: trb
ffffffc019c958d0 (E142:D0) buf 00000000edad0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.972335412       0x4ae52fbb8]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.974049995       0x4ae537c51]   dbg_ep_queue: ep7in: req
ffffff8036151b00 length 0/65536 zsI ==> -115
[ 1022.974229735       0x4ae5389cb]   dbg_prepare: ep7in: trb
ffffffc019c958e0 (E143:D0) buf 00000000edac0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.974516870       0x4ae539f55]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.975572287       0x4ae53ee7c]   dbg_ep_queue: ep7in: req
ffffff8036151200 length 0/65536 zsI ==> -115
[ 1022.975791402       0x4ae53feeb]   dbg_prepare: ep7in: trb
ffffffc019c958f0 (E144:D0) buf 00000000ebfe0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.976107600       0x4ae5416a2]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.976763120       0x4ae5447cd]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 4/4 zsI ==> 0
[ 1022.977552339       0x4ae5482fe]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.978111350       0x4ae54acea]   dbg_ep_queue: ep7in: req
ffffff878b889f00 length 0/65536 zsI ==> -115
[ 1022.978319527       0x4ae54bc87]   dbg_prepare: ep7in: trb
ffffffc019c95900 (E145:D0) buf 00000000ebff0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.978651089       0x4ae54d565]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.979900620       0x4ae55331c]   dbg_ep_queue: ep7in: req
ffffff803594c200 length 0/65536 zsI ==> -115
[ 1022.980128173       0x4ae55442d]   dbg_prepare: ep7in: trb
ffffffc019c95910 (E146:D0) buf 00000000eac80000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1022.980458485       0x4ae555cf3]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1022.983477443       0x4ae563f60]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1022.996707912       0x4ae5a1fa9]   dbg_trace_log_ctrl: Get String
Descriptor(Index = 3, Length = 18)
[ 1022.997687860       0x4ae5a6928]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1023.003303277       0x4ae5c0e4f]   dbg_gadget_giveback: ep0out: req
ffffff80362f1900 length 18/18 zsI ==> 0
[ 1023.004248589       0x4ae5c5535]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1023.008228225       0x4ae5d7faf]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1023.008766246       0x4ae5da808]   dbg_ep_queue: ep7in: req
ffffff803594d800 length 0/65536 zsI ==> -115
[ 1023.008965673       0x4ae5db6fd]   dbg_prepare: ep7in: trb
ffffffc019c95920 (E147:D0) buf 00000000ea1d0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.009302183       0x4ae5dd03a]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.011210152       0x4ae5e5f53]   dbg_ep_queue: ep7in: req
ffffff803594dd00 length 0/65536 zsI ==> -115
[ 1023.011413798       0x4ae5e6e99]   dbg_prepare: ep7in: trb
ffffffc019c95930 (E148:D0) buf 00000000ea1e0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.011735308       0x4ae5e86b6]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.020703277       0x4ae612750]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep5in)
[ 1023.021306089       0x4ae615486]   dbg_send_ep_cmd: ep5in: cmd 'End
Transfer' [b0d08] params 00000000 00000000 00000000 --> status: Successful
[ 1023.021717183       0x4ae61735a]   dbg_ep_queue: ep7in: req
ffffff803594c100 length 0/65536 zsI ==> -115
[ 1023.021927652       0x4ae618323]   dbg_prepare: ep7in: trb
ffffffc019c95940 (E149:D0) buf 00000000ea860000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.022247339       0x4ae619b1d]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.027116454       0x4ae63084e]   dbg_send_ep_cmd: ep5in: cmd 'Clear
Stall' [405] params 00000000 00000000 00000000 --> status: Successful
[ 1023.027839110       0x4ae633e7f]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1023.031545360       0x4ae645478]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1023.033938173       0x4ae6507ed]   dbg_ep_queue: ep7in: req
ffffff803594d100 length 0/65536 zsI ==> -115
[ 1023.034156871       0x4ae651854]   dbg_prepare: ep7in: trb
ffffffc019c95950 (E150:D0) buf 00000000ea850000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.034489735       0x4ae65314b]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.043397548       0x4ae67cd61]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep4in)
[ 1023.043979996       0x4ae67f911]   dbg_send_ep_cmd: ep0out: cmd 'Set
Stall' [404] params 00000000 00000000 00000000 --> status: Successful
[ 1023.044686558       0x4ae682e0f]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1023.045223589       0x4ae685655]   dbg_ep_queue: ep7in: req
ffffff803594ca00 length 0/65536 zsI ==> -115
[ 1023.045426141       0x4ae686586]   dbg_prepare: ep7in: trb
ffffffc019c95960 (E151:D0) buf 00000000ea840000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.045776402       0x4ae687fcb]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.117953590       0x4ae7da515]   dbg_ep_queue: ep7in: req
ffffff803594c600 length 0/65536 zsI ==> -115
[ 1023.118069944       0x4ae7dadcf]   dbg_prepare: ep7in: trb
ffffffc019c95970 (E152:D0) buf 00000000ea830000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.118228538       0x4ae7db9b4]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.118744683       0x4ae7de06a]   dbg_ep_queue: ep7in: req
ffffff803594c800 length 0/65536 zsI ==> -115
[ 1023.118850673       0x4ae7de85e]   dbg_prepare: ep7in: trb
ffffffc019c95980 (E153:D0) buf 00000000eab40000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.119006038       0x4ae7df404]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.119531038       0x4ae7e1b64]   dbg_ep_queue: ep7in: req
ffffff803594c700 length 0/65536 zsI ==> -115
[ 1023.119639371       0x4ae7e2384]   dbg_prepare: ep7in: trb
ffffffc019c95990 (E154:D0) buf 00000000eab50000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.119798694       0x4ae7e2f77]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.120593850       0x4ae7e6b1a]   dbg_ep_queue: ep7in: req
ffffff803594c300 length 0/65536 zsI ==> -115
[ 1023.120696194       0x4ae7e72c7]   dbg_prepare: ep7in: trb
ffffffc019c959a0 (E155:D0) buf 00000000eab60000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.120830204       0x4ae7e7cd4]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.121205673       0x4ae7e98fe]   dbg_ep_queue: ep7in: req
ffffff803594cc00 length 0/65536 zsI ==> -115
[ 1023.121267913       0x4ae7e9da8]   dbg_prepare: ep7in: trb
ffffffc019c959b0 (E156:D0) buf 00000000eab70000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.121368902       0x4ae7ea53b]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.121821298       0x4ae7ec729]   dbg_ep_queue: ep7in: req
ffffff803594d400 length 0/65536 zsI ==> -115
[ 1023.121925048       0x4ae7ecef1]   dbg_prepare: ep7in: trb
ffffffc019c959c0 (E157:D0) buf 00000000eab80000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.122079996       0x4ae7eda90]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.122589683       0x4ae7f00cb]   dbg_ep_queue: ep7in: req
ffffff878dcfb700 length 0/65536 zsI ==> -115
[ 1023.122690100       0x4ae7f0852]   dbg_prepare: ep7in: trb
ffffffc019c959d0 (E158:D0) buf 00000000eab90000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.122843954       0x4ae7f13dc]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.123348329       0x4ae7f39b0]   dbg_ep_queue: ep7in: req
ffffff8051647800 length 0/65536 zsI ==> -115
[ 1023.123445985       0x4ae7f4103]   dbg_prepare: ep7in: trb
ffffffc019c959e0 (E159:D0) buf 00000000eaba0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.123606663       0x4ae7f4d10]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.137959163       0x4ae838181]   dbg_ep_queue: ep7in: req
ffffff8051646a00 length 0/65536 zsI ==> -115
[ 1023.138059788       0x4ae83890c]   dbg_prepare: ep7in: trb
ffffffc019c959f0 (E160:D0) buf 00000000eac90000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.138204527       0x4ae8393e7]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.138663694       0x4ae83b657]   dbg_ep_queue: ep7in: req
ffffff8051647500 length 0/65536 zsI ==> -115
[ 1023.138756298       0x4ae83bd49]   dbg_prepare: ep7in: trb
ffffffc019c95a00 (E161:D0) buf 00000000eaca0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.138899736       0x4ae83c80b]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.139371454       0x4ae83eb6c]   dbg_ep_queue: ep7in: req
ffffff8051647e00 length 0/65536 zsI ==> -115
[ 1023.139462756       0x4ae83f245]   dbg_prepare: ep7in: trb
ffffffc019c95a10 (E162:D0) buf 00000000ea940000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.139610569       0x4ae83fd5b]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.140145256       0x4ae842575]   dbg_ep_queue: ep7in: req
ffffff8051647300 length 0/65536 zsI ==> -115
[ 1023.140269944       0x4ae842ecf]   dbg_prepare: ep7in: trb
ffffffc019c95a20 (E163:D0) buf 00000000ef2b0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.140431715       0x4ae843af1]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.141369996       0x4ae848150]   dbg_ep_queue: ep7in: req
ffffff8051646f00 length 0/65536 zsI ==> -115
[ 1023.141466454       0x4ae84888c]   dbg_prepare: ep7in: trb
ffffffc019c95a30 (E164:D0) buf 00000000ec930000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.141607079       0x4ae849318]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.142078121       0x4ae84b66c]   dbg_ep_queue: ep7in: req
ffffff8051646e00 length 0/65536 zsI ==> -115
[ 1023.142171715       0x4ae84bd71]   dbg_prepare: ep7in: trb
ffffffc019c95a40 (E165:D0) buf 00000000ec920000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.142316715       0x4ae84c851]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.142774892       0x4ae84eaaf]   dbg_ep_queue: ep7in: req
ffffff8051647900 length 0/65536 zsI ==> -115
[ 1023.142865465       0x4ae84f17a]   dbg_prepare: ep7in: trb
ffffffc019c95a50 (E166:D0) buf 00000000ead40000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.143010100       0x4ae84fc52]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.143476975       0x4ae851f56]   dbg_ep_queue: ep7in: req
ffffff8051646000 length 0/65536 zsI ==> -115
[ 1023.143568121       0x4ae85262c]   dbg_prepare: ep7in: trb
ffffffc019c95a60 (E167:D0) buf 00000000ead30000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.143707913       0x4ae8530a8]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.144168381       0x4ae855331]   dbg_ep_queue: ep7in: req
ffffff8051646300 length 0/65536 zsI ==> -115
[ 1023.144263746       0x4ae855a58]   dbg_prepare: ep7in: trb
ffffffc019c95a70 (E168:D0) buf 00000000ead20000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.144428850       0x4ae8566ba]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.145168486       0x4ae859e33]   dbg_ep_queue: ep7in: req
ffffff8036be0500 length 0/65536 zsI ==> -115
[ 1023.145260361       0x4ae85a517]   dbg_prepare: ep7in: trb
ffffffc019c95a80 (E169:D0) buf 00000000ead10000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.145404527       0x4ae85afe7]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.145942496       0x4ae85d841]   dbg_ep_queue: ep7in: req
ffffff8036be0600 length 0/65536 zsI ==> -115
[ 1023.146044111       0x4ae85dfdf]   dbg_prepare: ep7in: trb
ffffffc019c95a90 (E170:D0) buf 00000000ead00000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.146197288       0x4ae85eb5c]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.146708121       0x4ae8611ac]   dbg_ep_queue: ep7in: req
ffffff8036be0d00 length 0/65536 zsI ==> -115
[ 1023.146819319       0x4ae861a03]   dbg_prepare: ep7in: trb
ffffffc019c95aa0 (E171:D0) buf 00000000eacf0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.146980361       0x4ae862617]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.147499267       0x4ae864d03]   dbg_ep_queue: ep7in: req
ffffff8036be0a00 length 0/65536 zsI ==> -115
[ 1023.147603486       0x4ae8654d3]   dbg_prepare: ep7in: trb
ffffffc019c95ab0 (E172:D0) buf 00000000e9f50000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.147759371       0x4ae866084]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.156838069       0x4ae89096b]   dbg_ep_queue: ep7in: req
ffffff8034719f00 length 0/65536 zsI ==> -115
[ 1023.156954319       0x4ae891223]   dbg_prepare: ep7in: trb
ffffffc019c95ac0 (E173:D0) buf 00000000eb850000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.157118433       0x4ae891e72]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.157632756       0x4ae894505]   dbg_ep_queue: ep7in: req
ffffff8034719a00 length 0/65536 zsI ==> -115
[ 1023.157735829       0x4ae894cc0]   dbg_prepare: ep7in: trb
ffffffc019c95ad0 (E174:D0) buf 00000000eb860000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.158022288       0x4ae89623c]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.158926871       0x4ae89a614]   dbg_ep_queue: ep7in: req
ffffff8034718d00 length 0/65536 zsI ==> -115
[ 1023.159103590       0x4ae89b355]   dbg_prepare: ep7in: trb
ffffffc019c95ae0 (E175:D0) buf 00000000eb870000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.159384163       0x4ae89c860]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.160989892       0x4ae8a40ce]   dbg_ep_queue: ep7in: req
ffffff8034718e00 length 0/65536 zsI ==> -115
[ 1023.161258694       0x4ae8a54f7]   dbg_prepare: ep7in: trb
ffffffc019c95af0 (E176:D0) buf 00000000ed3b0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.161574111       0x4ae8a6c9f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.162484475       0x4ae8ab0e6]   dbg_ep_queue: ep7in: req
ffffff8034719000 length 0/65536 zsI ==> -115
[ 1023.162656663       0x4ae8abdd0]   dbg_prepare: ep7in: trb
ffffffc019c95b00 (E177:D0) buf 00000000ed2b0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.162967861       0x4ae8ad527]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.163894631       0x4ae8b1aa9]   dbg_ep_queue: ep7in: req
ffffff8034718300 length 0/65536 zsI ==> -115
[ 1023.164088902       0x4ae8b293b]   dbg_prepare: ep7in: trb
ffffffc019c95b10 (E178:D0) buf 00000000ed2c0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.164371767       0x4ae8b3e73]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.165915881       0x4ae8bb242]   dbg_ep_queue: ep7in: req
ffffff8034719d00 length 0/65536 zsI ==> -115
[ 1023.166052027       0x4ae8bbc77]   dbg_prepare: ep7in: trb
ffffffc019c95b20 (E179:D0) buf 00000000ed2d0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.166231402       0x4ae8bc9eb]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.166856298       0x4ae8bf8c9]   dbg_ep_queue: ep7in: req
ffffff8034719100 length 0/65536 zsI ==> -115
[ 1023.167108225       0x4ae8c0baf]   dbg_prepare: ep7in: trb
ffffffc019c95b30 (E180:D0) buf 00000000ebec0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.167443381       0x4ae8c24d1]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.169139736       0x4ae8ca40b]   dbg_ep_queue: ep7in: req
ffffff8034719500 length 0/65536 zsI ==> -115
[ 1023.169304736       0x4ae8cb06b]   dbg_prepare: ep7in: trb
ffffffc019c95b40 (E181:D0) buf 00000000ebeb0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.169585934       0x4ae8cc582]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.170661715       0x4ae8d1631]   dbg_ep_queue: ep7in: req
ffffff8034718100 length 0/65536 zsI ==> -115
[ 1023.170886402       0x4ae8d270b]   dbg_prepare: ep7in: trb
ffffffc019c95b50 (E182:D0) buf 00000000ebea0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.171230725       0x4ae8d40df]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.172247184       0x4ae8d8d1b]   dbg_ep_queue: ep7in: req
ffffff8034719600 length 0/65536 zsI ==> -115
[ 1023.172469319       0x4ae8d9dc3]   dbg_prepare: ep7in: trb
ffffffc019c95b60 (E183:D0) buf 00000000ebe90000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.172805569       0x4ae8db6fb]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.174974631       0x4ae8e59a9]   dbg_ep_queue: ep7in: req
ffffff803349b600 length 0/65536 zsI ==> -115
[ 1023.175190152       0x4ae8e69d3]   dbg_prepare: ep7in: trb
ffffffc019c95b70 (E184:D0) buf 00000000ebe80000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.175539111       0x4ae8e83ff]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.188130882       0x4ae923461]   dbg_ep_queue: ep7in: req
ffffff803349b300 length 0/65536 zsI ==> -115
[ 1023.188321194       0x4ae9242a8]   dbg_prepare: ep7in: trb
ffffffc019c95b80 (E185:D0) buf 00000000ebe70000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.188658746       0x4ae925bf8]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.190428538       0x4ae92e0b4]   dbg_ep_queue: ep7in: req
ffffff803349b200 length 0/65536 zsI ==> -115
[ 1023.190614007       0x4ae92ee9d]   dbg_prepare: ep7in: trb
ffffffc019c95b90 (E186:D0) buf 00000000ebe60000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.190940257       0x4ae930715]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.191989996       0x4ae9355d1]   dbg_ep_queue: ep7in: req
ffffff803349a100 length 0/65536 zsI ==> -115
[ 1023.192203954       0x4ae9365dc]   dbg_prepare: ep7in: trb
ffffffc019c95ba0 (E187:D0) buf 00000000ebe50000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.192541819       0x4ae937f33]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.194312027       0x4ae9403f7]   dbg_ep_queue: ep7in: req
ffffff803349b000 length 0/65536 zsI ==> -115
[ 1023.194530569       0x4ae94145b]   dbg_prepare: ep7in: trb
ffffffc019c95bb0 (E188:D0) buf 00000000ebe40000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.194877079       0x4ae942e58]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.195929475       0x4ae947d47]   dbg_ep_queue: ep7in: req
ffffff803349ae00 length 0/65536 zsI ==> -115
[ 1023.196142184       0x4ae948d3a]   dbg_prepare: ep7in: trb
ffffffc019c95bc0 (E189:D0) buf 00000000ebe30000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.196469840       0x4ae94a5cd]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.198264319       0x4ae952c63]   dbg_ep_queue: ep7in: req
ffffff803349a000 length 0/65536 zsI ==> -115
[ 1023.198437600       0x4ae953962]   dbg_prepare: ep7in: trb
ffffffc019c95bd0 (E190:D0) buf 00000000ebe20000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.198773850       0x4ae95529a]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.199845361       0x4ae95a2f7]   dbg_ep_queue: ep7in: req
ffffff80415ef700 length 0/65536 zsI ==> -115
[ 1023.200060152       0x4ae95b313]   dbg_prepare: ep7in: trb
ffffffc019c95be0 (E191:D0) buf 00000000ebe10000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.200404111       0x4ae95ccdf]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.202159163       0x4ae965080]   dbg_ep_queue: ep7in: req
ffffff80415ee000 length 0/65536 zsI ==> -115
[ 1023.202372340       0x4ae96607d]   dbg_prepare: ep7in: trb
ffffffc019c95bf0 (E192:D0) buf 00000000ebe00000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.202710986       0x4ae9679e3]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.203785465       0x4ae96ca79]   dbg_ep_queue: ep7in: req
ffffff80415ee500 length 0/65536 zsI ==> -115
[ 1023.204057548       0x4ae96dee1]   dbg_prepare: ep7in: trb
ffffffc019c95c00 (E193:D0) buf 00000000ebdf0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.204389163       0x4ae96f7c0]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.210107548       0x4ae98a4a1]   dbg_ep_queue: ep7in: req
ffffff80415ee800 length 0/65536 zsI ==> -115
[ 1023.210324892       0x4ae98b4ee]   dbg_prepare: ep7in: trb
ffffffc019c95c10 (E194:D0) buf 00000000ebde0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.210672600       0x4ae98cf02]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.211746819       0x4ae991f93]   dbg_ep_queue: ep7in: req
ffffff80415ef500 length 0/65536 zsI ==> -115
[ 1023.211959059       0x4ae992f7e]   dbg_prepare: ep7in: trb
ffffffc019c95c20 (E195:D0) buf 00000000ebdd0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.212289267       0x4ae994842]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.213948746       0x4ae99c4b8]   dbg_ep_queue: ep7in: req
ffffff885f1b3000 length 0/65536 zsI ==> -115
[ 1023.214117913       0x4ae99d168]   dbg_prepare: ep7in: trb
ffffffc019c95c30 (E196:D0) buf 00000000ebdc0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.214447392       0x4ae99ea1e]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.215538330       0x4ae9a3bf0]   dbg_ep_queue: ep7in: req
ffffff885f1b2200 length 0/65536 zsI ==> -115
[ 1023.215757392       0x4ae9a4c5e]   dbg_prepare: ep7in: trb
ffffffc019c95c40 (E197:D0) buf 00000000ebdb0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.216079996       0x4ae9a6490]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.217743850       0x4ae9ae15a]   dbg_ep_queue: ep7in: req
ffffff8035b0d900 length 0/65536 zsI ==> -115
[ 1023.217955413       0x4ae9af138]   dbg_prepare: ep7in: trb
ffffffc019c95c50 (E198:D0) buf 00000000ebda0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.218278850       0x4ae9b097a]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.219367392       0x4ae9b5b1f]   dbg_ep_queue: ep7in: req
ffffff804123b200 length 0/65536 zsI ==> -115
[ 1023.219573590       0x4ae9b6a95]   dbg_prepare: ep7in: trb
ffffffc019c95c60 (E199:D0) buf 00000000ebd90000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.219904111       0x4ae9b835f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.221574632       0x4ae9c00a9]   dbg_ep_queue: ep7in: req
ffffff804123b300 length 0/65536 zsI ==> -115
[ 1023.221764892       0x4ae9c0eee]   dbg_prepare: ep7in: trb
ffffffc019c95c70 (E200:D0) buf 00000000ebd80000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.222103434       0x4ae9c2852]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.223237444       0x4ae9c7d5f]   dbg_ep_queue: ep7in: req
ffffff804123b400 length 0/65536 zsI ==> -115
[ 1023.223448225       0x4ae9c8d2e]   dbg_prepare: ep7in: trb
ffffffc019c95c80 (E201:D0) buf 00000000ebd70000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.223776507       0x4ae9ca5cd]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.225346298       0x4ae9d1b89]   dbg_ep_queue: ep7in: req
ffffff804123ba00 length 0/65536 zsI ==> -115
[ 1023.225529267       0x4ae9d2942]   dbg_prepare: ep7in: trb
ffffffc019c95c90 (E202:D0) buf 00000000ebd60000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.225852652       0x4ae9d4183]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.226903277       0x4ae9d904f]   dbg_ep_queue: ep7in: req
ffffff804123b700 length 0/65536 zsI ==> -115
[ 1023.227120152       0x4ae9da093]   dbg_prepare: ep7in: trb
ffffffc019c95ca0 (E203:D0) buf 00000000ebd50000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.227445257       0x4ae9db8f5]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.232581611       0x4ae9f3a2f]   dbg_ep_queue: ep7in: req
ffffff804123bc00 length 0/65536 zsI ==> -115
[ 1023.232691767       0x4ae9f4272]   dbg_prepare: ep7in: trb
ffffffc019c95cb0 (E204:D0) buf 00000000ebd40000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.232853850       0x4ae9f4e9a]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.233267757       0x4ae9f6da5]   dbg_ep_queue: ep7in: req
ffffff804123a200 length 0/65536 zsI ==> -115
[ 1023.233348434       0x4ae9f73b2]   dbg_prepare: ep7in: trb
ffffffc019c95cc0 (E205:D0) buf 00000000ebd30000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.233476038       0x4ae9f7d44]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.233825309       0x4ae9f9776]   dbg_ep_queue: ep7in: req
ffffff804123bf00 length 0/65536 zsI ==> -115
[ 1023.233893017       0x4ae9f9c8a]   dbg_prepare: ep7in: trb
ffffffc019c95cd0 (E206:D0) buf 00000000ebd20000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.233999423       0x4ae9fa485]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.234321246       0x4ae9fbca8]   dbg_ep_queue: ep7in: req
ffffff804123af00 length 0/65536 zsI ==> -115
[ 1023.234386350       0x4ae9fc18a]   dbg_prepare: ep7in: trb
ffffffc019c95ce0 (E207:D0) buf 00000000ebd10000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.234495621       0x4ae9fc9bc]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.234831507       0x4ae9fe2ed]   dbg_ep_queue: ep7in: req
ffffff8034115f00 length 0/65536 zsI ==> -115
[ 1023.234896350       0x4ae9fe7ca]   dbg_prepare: ep7in: trb
ffffffc019c95cf0 (E208:D0) buf 00000000ebd00000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.235002705       0x4ae9fefc4]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.235325830       0x4aea00800]   dbg_ep_queue: ep7in: req
ffffff8034115400 length 0/65536 zsI ==> -115
[ 1023.235391194       0x4aea00ce7]   dbg_prepare: ep7in: trb
ffffffc019c95d00 (E209:D0) buf 00000000ebcf0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.235497288       0x4aea014dc]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.235823225       0x4aea02d4e]   dbg_ep_queue: ep7in: req
ffffff8034114500 length 0/65536 zsI ==> -115
[ 1023.235889996       0x4aea03250]   dbg_prepare: ep7in: trb
ffffffc019c95d10 (E210:D0) buf 00000000ebce0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.235993590       0x4aea03a15]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.236684892       0x4aea06dee]   dbg_ep_queue: ep7in: req
ffffff8034114600 length 0/65536 zsI ==> -115
[ 1023.236778694       0x4aea074f7]   dbg_prepare: ep7in: trb
ffffffc019c95d20 (E211:D0) buf 00000000ea5f0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.236898434       0x4aea07df2]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.237396559       0x4aea0a34f]   dbg_ep_queue: ep7in: req
ffffff882ad06f00 length 0/65536 zsI ==> -115
[ 1023.237501298       0x4aea0ab29]   dbg_prepare: ep7in: trb
ffffffc019c95d30 (E212:D0) buf 00000000ea600000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.237657600       0x4aea0b6e2]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.238187392       0x4aea0de9e]   dbg_ep_queue: ep7in: req
ffffff882ad07b00 length 0/65536 zsI ==> -115
[ 1023.238289007       0x4aea0e63d]   dbg_prepare: ep7in: trb
ffffffc019c95d40 (E213:D0) buf 00000000ea610000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.238450934       0x4aea0f262]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.238958694       0x4aea11877]   dbg_ep_queue: ep7in: req
ffffff882ad07100 length 0/65536 zsI ==> -115
[ 1023.239060152       0x4aea12013]   dbg_prepare: ep7in: trb
ffffffc019c95d50 (E214:D0) buf 00000000ea620000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.239222548       0x4aea12c41]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.239743382       0x4aea15351]   dbg_ep_queue: ep7in: req
ffffff882ad07900 length 0/65536 zsI ==> -115
[ 1023.239845882       0x4aea15b01]   dbg_prepare: ep7in: trb
ffffffc019c95d60 (E215:D0) buf 00000000ea630000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.240004475       0x4aea166e6]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.240832705       0x4aea1a505]   dbg_ep_queue: ep7in: req
ffffff882ad07700 length 0/65536 zsI ==> -115
[ 1023.240938434       0x4aea1acf2]   dbg_prepare: ep7in: trb
ffffffc019c95d70 (E216:D0) buf 00000000ea640000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.241107600       0x4aea1b9a2]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.241623590       0x4aea1e055]   dbg_ep_queue: ep7in: req
ffffff882ad07400 length 0/65536 zsI ==> -115
[ 1023.241734371       0x4aea1e8a4]   dbg_prepare: ep7in: trb
ffffffc019c95d80 (E217:D0) buf 00000000ea650000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.241891038       0x4aea1f465]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.242396819       0x4aea21a53]   dbg_ep_queue: ep7in: req
ffffff80516af300 length 0/65536 zsI ==> -115
[ 1023.242505569       0x4aea2227b]   dbg_prepare: ep7in: trb
ffffffc019c95d90 (E218:D0) buf 00000000ea660000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.242664632       0x4aea22e69]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.243205205       0x4aea256f4]   dbg_ep_queue: ep7in: req
ffffff80516aee00 length 0/65536 zsI ==> -115
[ 1023.243306663       0x4aea25e90]   dbg_prepare: ep7in: trb
ffffffc019c95da0 (E219:D0) buf 00000000ea670000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.243465986       0x4aea26a84]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.243871038       0x4aea288e5]   dbg_ep_queue: ep7in: req
ffffff80516ae800 length 0/65536 zsI ==> -115
[ 1023.243956767       0x4aea28f52]   dbg_prepare: ep7in: trb
ffffffc019c95db0 (E220:D0) buf 00000000ea680000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.244104944       0x4aea29a6f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.244896455       0x4aea2d5cc]   dbg_ep_queue: ep7in: req
ffffff80516af200 length 0/65536 zsI ==> -115
[ 1023.244953590       0x4aea2da15]   dbg_prepare: ep7in: trb
ffffffc019c95dc0 (E221:D0) buf 00000000eb6f0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.245065517       0x4aea2e27a]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.245422444       0x4aea2fd3f]   dbg_ep_queue: ep7in: req
ffffff80516af400 length 0/65536 zsI ==> -115
[ 1023.245523903       0x4aea304db]   dbg_prepare: ep7in: trb
ffffffc019c95dd0 (E222:D0) buf 00000000eb6e0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.245689267       0x4aea31142]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.246187496       0x4aea336a0]   dbg_ep_queue: ep7in: req
ffffff80516ae500 length 0/65536 zsI ==> -115
[ 1023.246288330       0x4aea33e30]   dbg_prepare: ep7in: trb
ffffffc019c95de0 (E223:D0) buf 00000000eb6d0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.246424319       0x4aea34863]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.246923278       0x4aea36dcf]   dbg_ep_queue: ep7in: req
ffffff80516ae700 length 0/65536 zsI ==> -115
[ 1023.247020257       0x4aea37515]   dbg_prepare: ep7in: trb
ffffffc019c95df0 (E224:D0) buf 00000000eb6c0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.247177600       0x4aea380e2]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.247662653       0x4aea3a543]   dbg_ep_queue: ep7in: req
ffffff80412cad00 length 0/65536 zsI ==> -115
[ 1023.247757913       0x4aea3ac68]   dbg_prepare: ep7in: trb
ffffffc019c95e00 (E225:D0) buf 00000000eb6b0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.247914944       0x4aea3b82f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.248863746       0x4aea3ff58]   dbg_ep_queue: ep7in: req
ffffff80412cb300 length 0/65536 zsI ==> -115
[ 1023.248952913       0x4aea40608]   dbg_prepare: ep7in: trb
ffffffc019c95e10 (E226:D0) buf 00000000eb6a0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.249104840       0x4aea4116d]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.249609007       0x4aea4373d]   dbg_ep_queue: ep7in: req
ffffff80412ca700 length 0/65536 zsI ==> -115
[ 1023.249715934       0x4aea43f42]   dbg_prepare: ep7in: trb
ffffffc019c95e20 (E227:D0) buf 00000000eb690000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.249872444       0x4aea44aff]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.250365725       0x4aea46ffe]   dbg_ep_queue: ep7in: req
ffffff80412cb900 length 0/65536 zsI ==> -115
[ 1023.250480725       0x4aea4789e]   dbg_prepare: ep7in: trb
ffffffc019c95e30 (E228:D0) buf 00000000eb680000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.250644319       0x4aea484e3]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.254240153       0x4aea59293]   dbg_ep_queue: ep7in: req
ffffff8036be7f00 length 0/65536 zsI ==> -115
[ 1023.254346038       0x4aea59a84]   dbg_prepare: ep7in: trb
ffffffc019c95e40 (E229:D0) buf 00000000eb670000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.254505830       0x4aea5a680]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.255009475       0x4aea5cc46]   dbg_ep_queue: ep7in: req
ffffff8036be7400 length 0/65536 zsI ==> -115
[ 1023.255116611       0x4aea5d44f]   dbg_prepare: ep7in: trb
ffffffc019c95e50 (E230:D0) buf 00000000eb660000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.255273642       0x4aea5e016]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.255823850       0x4aea6095a]   dbg_ep_queue: ep7in: req
ffffff8036be7100 length 0/65536 zsI ==> -115
[ 1023.255922965       0x4aea610c9]   dbg_prepare: ep7in: trb
ffffffc019c95e60 (E231:D0) buf 00000000eb650000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.256092809       0x4aea61d86]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.256945309       0x4aea65d76]   dbg_ep_queue: ep7in: req
ffffff8036be6200 length 0/65536 zsI ==> -115
[ 1023.257050048       0x4aea66551]   dbg_prepare: ep7in: trb
ffffffc019c95e70 (E232:D0) buf 00000000eb640000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.257209475       0x4aea67147]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.257722080       0x4aea697b8]   dbg_ep_queue: ep7in: req
ffffff8036be7000 length 0/65536 zsI ==> -115
[ 1023.257825361       0x4aea69f77]   dbg_prepare: ep7in: trb
ffffffc019c95e80 (E233:D0) buf 00000000eb630000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.257986923       0x4aea6ab95]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.258489163       0x4aea6d141]   dbg_ep_queue: ep7in: req
ffffff8036be6400 length 0/65536 zsI ==> -115
[ 1023.258592757       0x4aea6d905]   dbg_prepare: ep7in: trb
ffffffc019c95e90 (E234:D0) buf 00000000eb620000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.258753694       0x4aea6e517]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.259256715       0x4aea70ad1]   dbg_ep_queue: ep7in: req
ffffff8036be7b00 length 0/65536 zsI ==> -115
[ 1023.259360830       0x4aea712a0]   dbg_prepare: ep7in: trb
ffffffc019c95ea0 (E235:D0) buf 00000000eb610000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.259522965       0x4aea71ec9]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.260022236       0x4aea7443b]   dbg_ep_queue: ep7in: req
ffffff8036be7200 length 0/65536 zsI ==> -115
[ 1023.260129684       0x4aea74c4a]   dbg_prepare: ep7in: trb
ffffffc019c95eb0 (E236:D0) buf 00000000eb600000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.260286403       0x4aea7580b]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.260969059       0x4aea78b3e]   dbg_ep_queue: ep7in: req
ffffff8036be7300 length 0/65536 zsI ==> -115
[ 1023.261049423       0x4aea79145]   dbg_prepare: ep7in: trb
ffffffc019c95ec0 (E237:D0) buf 00000000eb5f0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.261182444       0x4aea79b3f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.266982496       0x4aea94e41]   dbg_ep_queue: ep7in: req
ffffff8036be7700 length 0/65536 zsI ==> -115
[ 1023.267087809       0x4aea95626]   dbg_prepare: ep7in: trb
ffffffc019c95ed0 (E238:D0) buf 00000000eb5e0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.267248121       0x4aea9622c]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.267766350       0x4aea9890a]   dbg_ep_queue: ep7in: req
ffffff87a230a800 length 0/65536 zsI ==> -115
[ 1023.267865465       0x4aea9907a]   dbg_prepare: ep7in: trb
ffffffc019c95ee0 (E239:D0) buf 00000000eb5d0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.268021298       0x4aea99c29]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.268850413       0x4aea9da58]   dbg_ep_queue: ep7in: req
ffffff87a230bf00 length 0/65536 zsI ==> -115
[ 1023.268931976       0x4aea9e076]   dbg_prepare: ep7in: trb
ffffffc019c95ef0 (E240:D0) buf 00000000eb5c0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.269074267       0x4aea9eb23]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.269570621       0x4aeaa105c]   dbg_ep_queue: ep7in: req
ffffff87a230b800 length 0/65536 zsI ==> -115
[ 1023.269678226       0x4aeaa186e]   dbg_prepare: ep7in: trb
ffffffc019c95f00 (E241:D0) buf 00000000eb5b0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.269827965       0x4aeaa23aa]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.270329007       0x4aeaa493d]   dbg_ep_queue: ep7in: req
ffffff87a230a500 length 0/65536 zsI ==> -115
[ 1023.270436246       0x4aeaa5148]   dbg_prepare: ep7in: trb
ffffffc019c95f10 (E242:D0) buf 00000000eb5a0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.270594007       0x4aeaa5d1d]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.271095726       0x4aeaa82be]   dbg_ep_queue: ep7in: req
ffffff87a230ad00 length 0/65536 zsI ==> -115
[ 1023.271196976       0x4aeaa8a56]   dbg_prepare: ep7in: trb
ffffffc019c95f20 (E243:D0) buf 00000000eb590000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.271341142       0x4aeaa9526]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.271835153       0x4aeaaba33]   dbg_ep_queue: ep7in: req
ffffff87a230b400 length 0/65536 zsI ==> -115
[ 1023.271927392       0x4aeaac11e]   dbg_prepare: ep7in: trb
ffffffc019c95f30 (E244:D0) buf 00000000eb580000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.272069788       0x4aeaacbcc]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.272873903       0x4aeab081b]   dbg_ep_queue: ep7in: req
ffffff87a230b500 length 0/65536 zsI ==> -115
[ 1023.272967080       0x4aeab0f18]   dbg_prepare: ep7in: trb
ffffffc019c95f40 (E245:D0) buf 00000000eb570000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.273120048       0x4aeab1a91]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.273599476       0x4aeab3e86]   dbg_ep_queue: ep7in: req
ffffff87a230a900 length 0/65536 zsI ==> -115
[ 1023.273693434       0x4aeab4592]   dbg_prepare: ep7in: trb
ffffffc019c95f50 (E246:D0) buf 00000000eb560000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.273837496       0x4aeab5060]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.274332653       0x4aeab7583]   dbg_ep_queue: ep7in: req
ffffff87a230ba00 length 0/65536 zsI ==> -115
[ 1023.274429319       0x4aeab7cc3]   dbg_prepare: ep7in: trb
ffffffc019c95f60 (E247:D0) buf 00000000eb200000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.274575205       0x4aeab87b4]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.275036298       0x4aeabaa49]   dbg_ep_queue: ep7in: req
ffffff87a230a700 length 0/65536 zsI ==> -115
[ 1023.275136194       0x4aeabb1c7]   dbg_prepare: ep7in: trb
ffffffc019c95f70 (E248:D0) buf 00000000eb1f0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.275283694       0x4aeabbcd7]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.275765153       0x4aeabe0f3]   dbg_ep_queue: ep7in: req
ffffff87a230b100 length 0/65536 zsI ==> -115
[ 1023.275870934       0x4aeabe8e2]   dbg_prepare: ep7in: trb
ffffffc019c95f80 (E249:D0) buf 00000000eb1e0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.276023851       0x4aeabf45a]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.278351246       0x4aeaca2e8]   dbg_ep_queue: ep7in: req
ffffff87a230b700 length 0/65536 zsI ==> -115
[ 1023.278454111       0x4aeacaa9f]   dbg_prepare: ep7in: trb
ffffffc019c95f90 (E250:D0) buf 00000000eb1d0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.278606090       0x4aeacb605]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.279121611       0x4aeacdcaf]   dbg_ep_queue: ep7in: req
ffffff87a230b200 length 0/65536 zsI ==> -115
[ 1023.279218278       0x4aeace3ef]   dbg_prepare: ep7in: trb
ffffffc019c95fa0 (E251:D0) buf 00000000eb1c0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.279350465       0x4aeacedd9]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.279762913       0x4aead0cc8]   dbg_ep_queue: ep7in: req
ffffff87a230ab00 length 0/65536 zsI ==> -115
[ 1023.279846246       0x4aead1308]   dbg_prepare: ep7in: trb
ffffffc019c95fb0 (E252:D0) buf 00000000eb1b0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.279981715       0x4aead1d31]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.280774111       0x4aead589f]   dbg_ep_queue: ep7in: req
ffffff87a230bd00 length 0/65536 zsI ==> -115
[ 1023.280875153       0x4aead6033]   dbg_prepare: ep7in: trb
ffffffc019c95fc0 (E253:D0) buf 00000000eb1a0000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.281033278       0x4aead6c0f]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.281477028       0x4aead8d57]   dbg_ep_queue: ep7in: req
ffffff87a230aa00 length 0/65536 zsI ==> -115
[ 1023.281561090       0x4aead93a5]   dbg_prepare: ep7in: trb
ffffffc019c95fd0 (E254:D0) buf 00000000eb190000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.281692132       0x4aead9d79]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.282070101       0x4aeadb9d2]   dbg_ep_queue: ep7in: req
ffffff87a230ac00 length 0/65536 zsI ==> -115
[ 1023.282154892       0x4aeadc02e]   dbg_prepare: ep7in: trb
ffffffc019c95fe0 (E0:D0) buf 00000000ec420000 size 65536 ctrl 00000811
(Hlcs:sC:normal)
[ 1023.282282809       0x4aeadc9c6]   dbg_send_ep_cmd: ep7in: cmd
'Update Transfer' [f0007] params 00000000 00000000 00000000 --> status:
Successful
[ 1023.462871351       0x4aee2b1f1]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep5in)
[ 1023.463591559       0x4aee2e7f0]   dbg_send_ep_cmd: ep5in: cmd 'Clear
Stall' [405] params 00000000 00000000 00000000 --> status: Successful
[ 1023.464325726       0x4aee31f00]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1023.475501716       0x4aee66532]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1023.486669997       0x4aee9aad0]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep4in)
[ 1023.487402185       0x4aee9e1bb]   dbg_send_ep_cmd: ep0out: cmd 'Set
Stall' [404] params 00000000 00000000 00000000 --> status: Successful
[ 1023.488117497       0x4aeea1761]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1023.900745884       0x4af62fa82]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep5in)
[ 1023.900949530       0x4af6309c7]   dbg_send_ep_cmd: ep5in: cmd 'Clear
Stall' [405] params 00000000 00000000 00000000 --> status: Successful
[ 1023.901353280       0x4af632810]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1023.903403800       0x4af63c1da]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1023.912550050       0x4af666fd2]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep4in)
[ 1023.912934738       0x4af668cab]   dbg_send_ep_cmd: ep0out: cmd 'Set
Stall' [404] params 00000000 00000000 00000000 --> status: Successful
[ 1023.913361561       0x4af66acae]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1024.336480573       0x4afe2a29b]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep5in)
[ 1024.336855573       0x4afe2bebc]   dbg_send_ep_cmd: ep5in: cmd 'Clear
Stall' [405] params 00000000 00000000 00000000 --> status: Successful
[ 1024.337264531       0x4afe2dd68]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1024.351910156       0x4afe727d4]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1024.363139896       0x4afea720f]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep4in)
[ 1024.363898281       0x4afeaaaf0]   dbg_send_ep_cmd: ep0out: cmd 'Set
Stall' [404] params 00000000 00000000 00000000 --> status: Successful
[ 1024.364734010       0x4afeae99e]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1024.776173803       0x4b063739a]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep5in)
[ 1024.776907188       0x4b063aa9b]   dbg_send_ep_cmd: ep5in: cmd 'Clear
Stall' [405] params 00000000 00000000 00000000 --> status: Successful
[ 1024.777646147       0x4b063e208]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1024.788641980       0x4b0671ab8]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1024.799682397       0x4b06a56bf]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep4in)
[ 1024.800442605       0x4b06a8fc3]   dbg_send_ep_cmd: ep0out: cmd 'Set
Stall' [404] params 00000000 00000000 00000000 --> status: Successful
[ 1024.801184584       0x4b06ac769]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1025.222173752       0x4b0e61d99]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep5in)
[ 1025.222991669       0x4b0e65af1]   dbg_send_ep_cmd: ep5in: cmd 'Clear
Stall' [405] params 00000000 00000000 00000000 --> status: Successful
[ 1025.223850731       0x4b0e69b5f]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1025.239023492       0x4b0eb0d54]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1025.248963179       0x4b0edf6ce]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep4in)
[ 1025.249709846       0x4b0ee2ecd]   dbg_send_ep_cmd: ep0out: cmd 'Set
Stall' [404] params 00000000 00000000 00000000 --> status: Successful
[ 1025.250533440       0x4b0ee6c93]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1025.667084535       0x4b16875e7]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep5in)
[ 1025.667827764       0x4b168ada6]   dbg_send_ep_cmd: ep5in: cmd 'Clear
Stall' [405] params 00000000 00000000 00000000 --> status: Successful
[ 1025.668635993       0x4b168ea44]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1025.674777764       0x4b16ab6e7]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1025.684733597       0x4b16da197]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep4in)
[ 1025.685336150       0x4b16dcec7]   dbg_send_ep_cmd: ep0out: cmd 'Set
Stall' [404] params 00000000 00000000 00000000 --> status: Successful
[ 1025.686112608       0x4b16e0904]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
Successful
[ 1025.698842347       0x4b171c3bf]   dbg_send_ep_cmd: ep0out: cmd 'Set
Stall' [404] params 00000000 00000000 00000000 --> status: Successful
[ 1026.444051569       0x4b24c1670]   dbg_send_ep_cmd: ep0out: cmd
'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: No
Resource
[ 1027.225705425       0x4b3311678]   dbg_trace_log_ctrl: Clear Endpoint
Feature(Halt ep5in)
[ 1027.225820165       0x4b3311f14]   dbg_send_ep_cmd: ep5in: cmd 'Clear
Stall' [405] params 00000000 00000000 00000000 --> status: Successful
[ 1027.225931467       0x4b331276c]   dbg_send_ep_cmd: ep0in: cmd 'Start
Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[ 1027.234311467       0x4b3339bed]   dbg_ep_dequeue: ep7in: req
ffffff87f99b8f00 length 0/61696 zsI ==> -115
[ 1027.247409123       0x4b337723f]   dbg_send_ep_cmd: ep7in: cmd 'End
Transfer' [f0d08] params 00000000 00000000 00000000 --> status: Timed Out

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
