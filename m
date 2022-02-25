Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A1D4C3AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiBYBcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiBYBcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:32:04 -0500
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 622802692F8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:31:28 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1645752692; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=K+XmApZQdXR1HUEXrCkOu9b2VJ1TSc815VBzlsctYBU=; b=xKp+vveGJg1b/su4tJtuHrsQpQtgrMnSUuGJgX8mWK7drBnFdCP7t2vJGoMxpbpBlesLZ06W
 S65ABwepuwYqVC2LQ5tR+UvHrBG0U/0t7eodY0w99JcH3OMy+qF1UlLoSXeWxmmAiKDzepRj
 rgubphrOr+k9m25pqsIJN4JRwVc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6218316b18892df15f73348c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Feb 2022 01:31:23
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3BB78C43616; Fri, 25 Feb 2022 01:31:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from [192.168.1.17] (cpe-75-80-185-151.san.res.rr.com [75.80.185.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FFFEC4360C;
        Fri, 25 Feb 2022 01:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5FFFEC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <1714910d-f923-d0c7-72a9-0c1d098f783f@codeaurora.org>
Date:   Thu, 24 Feb 2022 17:31:19 -0800
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
From:   Wesley Cheng <wcheng@codeaurora.org>
In-Reply-To: <810de66c-7d73-fae0-9356-b06b48134ad6@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 2/24/2022 5:26 PM, Thinh Nguyen wrote:
> Hi Wesley,
> 
> Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 2/22/2022 6:59 PM, Thinh Nguyen wrote:
>>> Hi Wesley,
>>>
> 
> <snip>
> 
>>>
>>> Can you provide a full trace?
>>>
>> Sorry for doing this, but we didn't have a way to share the file
>> directly, so I have to paste the trace below. :/
>>
>>> Btw, when you experiment with increasing the timeout to 10 seconds, did
>>> you use the mdelay() in each loop? The delta time for End Transfer
>>> timeout here seems very small.
>>>
>> This particular run did not modify the timeout for the cmd status polling.
>>
>> Is that something that you want to try?  Not pertaining to this dequeue
>> situation, during the pullup disable path debug, I noticed that as long
>> as there was a pending EP0 SETUP packet (not data/status) cached in the
>> controller, it would also have endxfer timeouts on non-control EPs.  We
>> were able to capture a bus sniffer log + ftrace, and it showed that at
>> the point of the error, the lecroy/bus log saw a SETUP token ACK'ed,
>> while on the ftrace, there were endxfer timeouts for all non-control EPs
>> (due to the dwc3_gadget_stop_active_transfers() call)
>>
>> Thanks
>> Wesley
>>
>> TRACE
>> ---------------------------------------------------------------------
>>
> 
> <snip>
> 
>> [ 1023.912550050       0x4af666fd2]   dbg_trace_log_ctrl: Clear Endpoint
>> Feature(Halt ep4in)
>> [ 1023.912934738       0x4af668cab]   dbg_send_ep_cmd: ep0out: cmd 'Set
>> Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>> [ 1023.913361561       0x4af66acae]   dbg_send_ep_cmd: ep0out: cmd
>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>> Successful
>> [ 1024.336480573       0x4afe2a29b]   dbg_trace_log_ctrl: Clear Endpoint
>> Feature(Halt ep5in)
>> [ 1024.336855573       0x4afe2bebc]   dbg_send_ep_cmd: ep5in: cmd 'Clear
>> Stall' [405] params 00000000 00000000 00000000 --> status: Successful
>> [ 1024.337264531       0x4afe2dd68]   dbg_send_ep_cmd: ep0in: cmd 'Start
>> Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>> [ 1024.351910156       0x4afe727d4]   dbg_send_ep_cmd: ep0out: cmd
>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>> Successful
>> [ 1024.363139896       0x4afea720f]   dbg_trace_log_ctrl: Clear Endpoint
>> Feature(Halt ep4in)
>> [ 1024.363898281       0x4afeaaaf0]   dbg_send_ep_cmd: ep0out: cmd 'Set
>> Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>> [ 1024.364734010       0x4afeae99e]   dbg_send_ep_cmd: ep0out: cmd
>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>> Successful
>> [ 1024.776173803       0x4b063739a]   dbg_trace_log_ctrl: Clear Endpoint
>> Feature(Halt ep5in)
>> [ 1024.776907188       0x4b063aa9b]   dbg_send_ep_cmd: ep5in: cmd 'Clear
>> Stall' [405] params 00000000 00000000 00000000 --> status: Successful
>> [ 1024.777646147       0x4b063e208]   dbg_send_ep_cmd: ep0in: cmd 'Start
>> Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>> [ 1024.788641980       0x4b0671ab8]   dbg_send_ep_cmd: ep0out: cmd
>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>> Successful
>> [ 1024.799682397       0x4b06a56bf]   dbg_trace_log_ctrl: Clear Endpoint
>> Feature(Halt ep4in)
>> [ 1024.800442605       0x4b06a8fc3]   dbg_send_ep_cmd: ep0out: cmd 'Set
>> Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>> [ 1024.801184584       0x4b06ac769]   dbg_send_ep_cmd: ep0out: cmd
>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>> Successful
>> [ 1025.222173752       0x4b0e61d99]   dbg_trace_log_ctrl: Clear Endpoint
>> Feature(Halt ep5in)
>> [ 1025.222991669       0x4b0e65af1]   dbg_send_ep_cmd: ep5in: cmd 'Clear
>> Stall' [405] params 00000000 00000000 00000000 --> status: Successful
>> [ 1025.223850731       0x4b0e69b5f]   dbg_send_ep_cmd: ep0in: cmd 'Start
>> Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>> [ 1025.239023492       0x4b0eb0d54]   dbg_send_ep_cmd: ep0out: cmd
>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>> Successful
>> [ 1025.248963179       0x4b0edf6ce]   dbg_trace_log_ctrl: Clear Endpoint
>> Feature(Halt ep4in)
>> [ 1025.249709846       0x4b0ee2ecd]   dbg_send_ep_cmd: ep0out: cmd 'Set
>> Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>> [ 1025.250533440       0x4b0ee6c93]   dbg_send_ep_cmd: ep0out: cmd
>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>> Successful
>> [ 1025.667084535       0x4b16875e7]   dbg_trace_log_ctrl: Clear Endpoint
>> Feature(Halt ep5in)
>> [ 1025.667827764       0x4b168ada6]   dbg_send_ep_cmd: ep5in: cmd 'Clear
>> Stall' [405] params 00000000 00000000 00000000 --> status: Successful
>> [ 1025.668635993       0x4b168ea44]   dbg_send_ep_cmd: ep0in: cmd 'Start
>> Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>> [ 1025.674777764       0x4b16ab6e7]   dbg_send_ep_cmd: ep0out: cmd
>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>> Successful
>> [ 1025.684733597       0x4b16da197]   dbg_trace_log_ctrl: Clear Endpoint
>> Feature(Halt ep4in)
>> [ 1025.685336150       0x4b16dcec7]   dbg_send_ep_cmd: ep0out: cmd 'Set
>> Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>> [ 1025.686112608       0x4b16e0904]   dbg_send_ep_cmd: ep0out: cmd
>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>> Successful
>> [ 1025.698842347       0x4b171c3bf]   dbg_send_ep_cmd: ep0out: cmd 'Set
>> Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>> [ 1026.444051569       0x4b24c1670]   dbg_send_ep_cmd: ep0out: cmd
>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: No
>> Resource
> 
> Why did this fail with No Resource? Was it sent before the control TRB
> completion?
> 
>> [ 1027.225705425       0x4b3311678]   dbg_trace_log_ctrl: Clear Endpoint
>> Feature(Halt ep5in)
>> [ 1027.225820165       0x4b3311f14]   dbg_send_ep_cmd: ep5in: cmd 'Clear
>> Stall' [405] params 00000000 00000000 00000000 --> status: Successful
>> [ 1027.225931467       0x4b331276c]   dbg_send_ep_cmd: ep0in: cmd 'Start
>> Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>> [ 1027.234311467       0x4b3339bed]   dbg_ep_dequeue: ep7in: req
>> ffffff87f99b8f00 length 0/61696 zsI ==> -115
>> [ 1027.247409123       0x4b337723f]   dbg_send_ep_cmd: ep7in: cmd 'End
>> Transfer' [f0d08] params 00000000 00000000 00000000 --> status: Timed Out
>>
> 
> If the Start Transfer for ep0 failed and the Setup packet can't be
> DMA'ed out, the End Transfer may not go through.
> 
> Can you leave the log unfiltered and is it possible to send as
> attachment? It's missing some important info in this log.
> 
Are there any specific logs you were looking for?
trace_dwc3_event
trace_dwc3_prepare_trb

Part of reproducing this issue will not allow me to enable tracing, so I
have to make changes in our driver to reroute the logs elsewhere.  So
far I've added changes to do:
	trace_dwc3_ctrl_req
	trace_dwc3_ep_queue
	trace_dwc3_ep_dequeue
	trace_dwc3_gadget_giveback
	trace_dwc3_gadget_ep_cmd

I can add the above 2 tracepoints as well, but wondering if you needed
anything else.

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
