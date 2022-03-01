Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A894C80C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiCACKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiCACKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:10:21 -0500
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 9535F5370D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:09:40 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1646100580; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=1hxcr2socS+98Sm4idY3K+fwv3ttzvq//moLJFGWmng=; b=kme+9X5/e+JdmsDbHf80BAgIYmu3HPnOi7/GtayT/OTKpB4qVLhVBarhmXqCilWIk+3gldbF
 eWsdqE/sMy6ejpmPtj/WIbSl8fKAxs1BKQV9h3hbSAHxD0KCTTHaZtR1DjG3tsTzjpz5xDy5
 YY1WHIah+xA/HunUw77bAlzm2qc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 621d8063ea5f8dddb5e878ea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Mar 2022 02:09:39
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DE4A0C43616; Tue,  1 Mar 2022 02:09:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from [192.168.1.17] (cpe-75-80-185-151.san.res.rr.com [75.80.185.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35B20C4338F;
        Tue,  1 Mar 2022 02:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 35B20C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <b0196760-0495-bd8d-7f41-e46f971b0beb@codeaurora.org>
Date:   Mon, 28 Feb 2022 18:09:36 -0800
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
From:   Wesley Cheng <wcheng@codeaurora.org>
In-Reply-To: <b2eca3ba-5c36-c788-629c-016bd36be8a7@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 2/28/2022 5:09 PM, Thinh Nguyen wrote:
> Hi Wesley,
> 
> Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 2/24/2022 5:44 PM, Thinh Nguyen wrote:
>>> Wesley Cheng wrote:
>>>> Hi Thinh,
>>>>
>>>> On 2/24/2022 5:26 PM, Thinh Nguyen wrote:
>>>>> Hi Wesley,
>>>>>
>>>>> Wesley Cheng wrote:
>>>>>> Hi Thinh,
>>>>>>
>>>>>> On 2/22/2022 6:59 PM, Thinh Nguyen wrote:
>>>>>>> Hi Wesley,
>>>>>>>
>>>>>
>>>>> <snip>
>>>>>
>>>>>>>
>>>>>>> Can you provide a full trace?
>>>>>>>
>>>>>> Sorry for doing this, but we didn't have a way to share the file
>>>>>> directly, so I have to paste the trace below. :/
>>>>>>
>>>>>>> Btw, when you experiment with increasing the timeout to 10 seconds, did
>>>>>>> you use the mdelay() in each loop? The delta time for End Transfer
>>>>>>> timeout here seems very small.
>>>>>>>
>>>>>> This particular run did not modify the timeout for the cmd status polling.
>>>>>>
>>>>>> Is that something that you want to try?  Not pertaining to this dequeue
>>>>>> situation, during the pullup disable path debug, I noticed that as long
>>>>>> as there was a pending EP0 SETUP packet (not data/status) cached in the
>>>>>> controller, it would also have endxfer timeouts on non-control EPs.  We
>>>>>> were able to capture a bus sniffer log + ftrace, and it showed that at
>>>>>> the point of the error, the lecroy/bus log saw a SETUP token ACK'ed,
>>>>>> while on the ftrace, there were endxfer timeouts for all non-control EPs
>>>>>> (due to the dwc3_gadget_stop_active_transfers() call)
>>>>>>
>>>>>> Thanks
>>>>>> Wesley
>>>>>>
>>>>>> TRACE
>>>>>> ---------------------------------------------------------------------
>>>>>>
>>>>>
>>>>> <snip>
>>>>>
>>>>>> [ 1023.912550050       0x4af666fd2]   dbg_trace_log_ctrl: Clear Endpoint
>>>>>> Feature(Halt ep4in)
>>>>>> [ 1023.912934738       0x4af668cab]   dbg_send_ep_cmd: ep0out: cmd 'Set
>>>>>> Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>>>>>> [ 1023.913361561       0x4af66acae]   dbg_send_ep_cmd: ep0out: cmd
>>>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>>>>>> Successful
>>>>>> [ 1024.336480573       0x4afe2a29b]   dbg_trace_log_ctrl: Clear Endpoint
>>>>>> Feature(Halt ep5in)
>>>>>> [ 1024.336855573       0x4afe2bebc]   dbg_send_ep_cmd: ep5in: cmd 'Clear
>>>>>> Stall' [405] params 00000000 00000000 00000000 --> status: Successful
>>>>>> [ 1024.337264531       0x4afe2dd68]   dbg_send_ep_cmd: ep0in: cmd 'Start
>>>>>> Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>>>>>> [ 1024.351910156       0x4afe727d4]   dbg_send_ep_cmd: ep0out: cmd
>>>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>>>>>> Successful
>>>>>> [ 1024.363139896       0x4afea720f]   dbg_trace_log_ctrl: Clear Endpoint
>>>>>> Feature(Halt ep4in)
>>>>>> [ 1024.363898281       0x4afeaaaf0]   dbg_send_ep_cmd: ep0out: cmd 'Set
>>>>>> Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>>>>>> [ 1024.364734010       0x4afeae99e]   dbg_send_ep_cmd: ep0out: cmd
>>>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>>>>>> Successful
>>>>>> [ 1024.776173803       0x4b063739a]   dbg_trace_log_ctrl: Clear Endpoint
>>>>>> Feature(Halt ep5in)
>>>>>> [ 1024.776907188       0x4b063aa9b]   dbg_send_ep_cmd: ep5in: cmd 'Clear
>>>>>> Stall' [405] params 00000000 00000000 00000000 --> status: Successful
>>>>>> [ 1024.777646147       0x4b063e208]   dbg_send_ep_cmd: ep0in: cmd 'Start
>>>>>> Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>>>>>> [ 1024.788641980       0x4b0671ab8]   dbg_send_ep_cmd: ep0out: cmd
>>>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>>>>>> Successful
>>>>>> [ 1024.799682397       0x4b06a56bf]   dbg_trace_log_ctrl: Clear Endpoint
>>>>>> Feature(Halt ep4in)
>>>>>> [ 1024.800442605       0x4b06a8fc3]   dbg_send_ep_cmd: ep0out: cmd 'Set
>>>>>> Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>>>>>> [ 1024.801184584       0x4b06ac769]   dbg_send_ep_cmd: ep0out: cmd
>>>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>>>>>> Successful
>>>>>> [ 1025.222173752       0x4b0e61d99]   dbg_trace_log_ctrl: Clear Endpoint
>>>>>> Feature(Halt ep5in)
>>>>>> [ 1025.222991669       0x4b0e65af1]   dbg_send_ep_cmd: ep5in: cmd 'Clear
>>>>>> Stall' [405] params 00000000 00000000 00000000 --> status: Successful
>>>>>> [ 1025.223850731       0x4b0e69b5f]   dbg_send_ep_cmd: ep0in: cmd 'Start
>>>>>> Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>>>>>> [ 1025.239023492       0x4b0eb0d54]   dbg_send_ep_cmd: ep0out: cmd
>>>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>>>>>> Successful
>>>>>> [ 1025.248963179       0x4b0edf6ce]   dbg_trace_log_ctrl: Clear Endpoint
>>>>>> Feature(Halt ep4in)
>>>>>> [ 1025.249709846       0x4b0ee2ecd]   dbg_send_ep_cmd: ep0out: cmd 'Set
>>>>>> Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>>>>>> [ 1025.250533440       0x4b0ee6c93]   dbg_send_ep_cmd: ep0out: cmd
>>>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>>>>>> Successful
>>>>>> [ 1025.667084535       0x4b16875e7]   dbg_trace_log_ctrl: Clear Endpoint
>>>>>> Feature(Halt ep5in)
>>>>>> [ 1025.667827764       0x4b168ada6]   dbg_send_ep_cmd: ep5in: cmd 'Clear
>>>>>> Stall' [405] params 00000000 00000000 00000000 --> status: Successful
>>>>>> [ 1025.668635993       0x4b168ea44]   dbg_send_ep_cmd: ep0in: cmd 'Start
>>>>>> Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>>>>>> [ 1025.674777764       0x4b16ab6e7]   dbg_send_ep_cmd: ep0out: cmd
>>>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>>>>>> Successful
>>>>>> [ 1025.684733597       0x4b16da197]   dbg_trace_log_ctrl: Clear Endpoint
>>>>>> Feature(Halt ep4in)
>>>>>> [ 1025.685336150       0x4b16dcec7]   dbg_send_ep_cmd: ep0out: cmd 'Set
>>>>>> Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>>>>>> [ 1025.686112608       0x4b16e0904]   dbg_send_ep_cmd: ep0out: cmd
>>>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>>>>>> Successful
>>>>>> [ 1025.698842347       0x4b171c3bf]   dbg_send_ep_cmd: ep0out: cmd 'Set
>>>>>> Stall' [404] params 00000000 00000000 00000000 --> status: Successful
>>>>>> [ 1026.444051569       0x4b24c1670]   dbg_send_ep_cmd: ep0out: cmd
>>>>>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: No
>>>>>> Resource
>>>>>
>>>>> Why did this fail with No Resource? Was it sent before the control TRB
>>>>> completion?
>>>>>
>>>>>> [ 1027.225705425       0x4b3311678]   dbg_trace_log_ctrl: Clear Endpoint
>>>>>> Feature(Halt ep5in)
>>>>>> [ 1027.225820165       0x4b3311f14]   dbg_send_ep_cmd: ep5in: cmd 'Clear
>>>>>> Stall' [405] params 00000000 00000000 00000000 --> status: Successful
>>>>>> [ 1027.225931467       0x4b331276c]   dbg_send_ep_cmd: ep0in: cmd 'Start
>>>>>> Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
>>>>>> [ 1027.234311467       0x4b3339bed]   dbg_ep_dequeue: ep7in: req
>>>>>> ffffff87f99b8f00 length 0/61696 zsI ==> -115
>>>>>> [ 1027.247409123       0x4b337723f]   dbg_send_ep_cmd: ep7in: cmd 'End
>>>>>> Transfer' [f0d08] params 00000000 00000000 00000000 --> status: Timed Out
>>>>>>
>>>>>
>>>>> If the Start Transfer for ep0 failed and the Setup packet can't be
>>>>> DMA'ed out, the End Transfer may not go through.
>>>>>
>>>>> Can you leave the log unfiltered and is it possible to send as
>>>>> attachment? It's missing some important info in this log.
>>>>>
>>>> Are there any specific logs you were looking for?
>>>> trace_dwc3_event
>>>> trace_dwc3_prepare_trb
>>>>
>>>> Part of reproducing this issue will not allow me to enable tracing, so I
>>>> have to make changes in our driver to reroute the logs elsewhere.  So
>>>> far I've added changes to do:
>>>> 	trace_dwc3_ctrl_req
>>>> 	trace_dwc3_ep_queue
>>>> 	trace_dwc3_ep_dequeue
>>>> 	trace_dwc3_gadget_giveback
>>>> 	trace_dwc3_gadget_ep_cmd
>>>>
>>>> I can add the above 2 tracepoints as well, but wondering if you needed
>>>> anything else.
>>>>
>>>
>>> If possible, please have these in addition to the above.
>>>
>>> trace_dwc3_event
>>> trace_dwc3_complete_trb
>>>
>> Enabled the traces you recommended.  I think it captures it pretty clear
>> where the status phase was still in progress when the dequeue came in,
>> which led to the end transfer timeout.  Let me know if you need another log.
>>
> 
> Thanks for the trace! I think I see the problem.
> 
> [ 2181.481956865       0x9dc63f265]   dbg_complete: ep6in: trb ffffffc01e7f52a0 (E43:D43) buf 00000000ebaf0000 size 1x 0 ctrl 00000810 (hlcs:sC:normal)
> [ 2181.482044730       0x9dc63f8fc]   dbg_gadget_giveback: ep6in: req ffffff8860657500 length 8/8 zsI ==> 0
> [ 2181.482222490       0x9dc640651]   event (0000c040): ep0out: Transfer Complete (sIL) [Setup Phase]
> [ 2181.482273271       0x9dc640a20]   dbg_trace_log_ctrl: Get Interface Status(Intf = 4, Length = 20)
> [ 2181.482334782       0x9dc640ebc]   dbg_ep_queue: ep6in: req ffffff8860657500 length 0/8 zsI ==> -115
> [ 2181.482357386       0x9dc64106e]   dbg_prepare: ep6in: trb ffffffc01e7f52b0 (E44:D43) buf 00000000ea578000 size 1x 8 ctrl 00000811 (Hlcs:sC:normal)
> [ 2181.482391865       0x9dc641304]   dbg_send_ep_cmd: ep6in: cmd 'Update Transfer' [d0007] params 00000000 00000000 00000000 --> status: Successful
> [ 2181.482485615       0x9dc641a0d]   dbg_send_ep_cmd: ep0out: cmd 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
> [ 2181.482565303       0x9dc642006]   event (000010c0): ep0out: Transfer Not Ready [0] (Not Active) [Data Phase]
> [ 2181.482719417       0x9dc642b96]   event (00002040): ep0out: Transfer Complete (Sil) [Data Phase]
> [ 2181.482814938       0x9dc6432c0]   dbg_gadget_giveback: ep0out: req ffffff87df84d900 length 20/20 zsI ==> 0
> [ 2181.482926084       0x9dc643b16]   event (000020c2): ep0in: Transfer Not Ready [0] (Not Active) [Status Phase]
> [ 2181.483024261       0x9dc644272]   dbg_send_ep_cmd: ep0in: cmd 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
> 
> The control status isn't completed here.
> 
> [ 2181.483069521       0x9dc6445d7]   dbg_ep_dequeue: ep2in: req ffffff879f5a8b00 length 0/63680 zsI ==> -115
> [ 2181.496068792       0x9dc6814c9]   dbg_send_ep_cmd: ep2in: cmd 'End Transfer' [50d08] params 00000000 00000000 00000000 --> status: Timed Out
> 
> But the dequeue may come when host already sent a new Setup packet.
> The ep0out hasn't started yet at the point.
> 
> Due to various system latency, I can see that this can happen when
> the dwc3 driver hasn't received the interrupt notified the status stage
> event yet.
> 
> If that's the case, the host may have already sent the Setup packet
> at this point. So the End Transfer may get stuck if the Setup packet
> isn't DMA out yet.
> 
> Can you try the change below to see if it resolves the issue?
Thanks, Thinh.  Sure I'll give it a try with this change.  This is very
similar to the change proposed here as well:

https://lore.kernel.org/linux-usb/20220216000835.25400-3-quic_wcheng@quicinc.com/

One thing to mention is that, I'm not sure how dependable checking soley
the ep0state would be.  I've seen some scenarios where we'd run into the
end transfer timeout during the time between inspecting the SETUP packet
(dwc3_ep0_inspect_setup()) and when the data phase is queued.  The
timing of the data phase can potentially differ if it is a vendor
specific control request.

This is what led me to try w/ marking the endxfer delay after getting a
timed out scenario.  Just something to consider :).  I'll let you know
how it goes!  Thanks again.

Thanks
Wesley Cheng

> Code is not tested. Let me know if the logic makes sense. The change is
> to delay End Transfer when the Start Transfer for ep0out is completed.
> 
> Thanks,
> Thinh
> 
> 
> 
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index eb9c1efced05..c55eddff0239 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -736,6 +736,7 @@ struct dwc3_ep {
>  #define DWC3_EP_FIRST_STREAM_PRIMED    BIT(10)
>  #define DWC3_EP_PENDING_CLEAR_STALL    BIT(11)
>  #define DWC3_EP_TXFIFO_RESIZED         BIT(12)
> +#define DWC3_EP_DELAY_STOP             BIT(13)
>  
>         /* This last one is specific to EP0 */
>  #define DWC3_EP0_DIR_IN                        BIT(31)
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 658739410992..ccd1bf3e1f18 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -271,6 +271,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>  {
>         struct dwc3_ep                  *dep;
>         int                             ret;
> +       int                             i;
>  
>         complete(&dwc->ep0_in_setup);
>  
> @@ -279,6 +280,19 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>                         DWC3_TRBCTL_CONTROL_SETUP, false);
>         ret = dwc3_ep0_start_trans(dep);
>         WARN_ON(ret < 0);
> +
> +       for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
> +               struct dwc3_ep *dwc3_ep;
> +               dwc3_ep = dwc->eps[i];
> +               if (!dwc3_ep)
> +                       continue;
> +
> +               if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
> +                       continue;
> +
> +               dep->flags &= ~DWC3_EP_DELAY_STOP;
> +               dwc3_stop_active_transfer(dwc3_ep, true, true);
> +       }
>  }
>  
>  static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 183b90923f51..e164ecad06ac 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -654,9 +654,6 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
>         return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
>  }
>  
> -static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
> -               bool interrupt);
> -
>  /**
>   * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
>   * @dwc: pointer to the DWC3 context
> @@ -1898,6 +1895,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
>          * and endpoint STALL is cleared.
>          */
>         if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
> +           (dep->flags & DWC3_EP_DELAY_STOP) ||
>             (dep->flags & DWC3_EP_WEDGE) ||
>             (dep->flags & DWC3_EP_STALL)) {
>                 dep->flags |= DWC3_EP_DELAY_START;
> @@ -2033,6 +2031,9 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
>                 if (r == req) {
>                         struct dwc3_request *t;
>  
> +                       if (dwc->ep0state != EP0_SETUP_PHASE)
> +                               dep->flags |= DWC3_EP_DELAY_STOP;
> +
>                         /* wait until it is processed */
>                         dwc3_stop_active_transfer(dep, true, true);
>  
> @@ -2116,7 +2117,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
>                 list_for_each_entry_safe(req, tmp, &dep->started_list, list)
>                         dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
>  
> -               if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
> +               if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
> +                   (dep->flags & DWC3_EP_DELAY_STOP)) {
>                         dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
>                         return 0;
>                 }
> @@ -3596,7 +3598,7 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
>         }
>  }
>  
> -static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
> +void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>         bool interrupt)
>  {
>         struct dwc3_gadget_ep_cmd_params params;
> @@ -3604,6 +3606,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>         int ret;
>  
>         if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
> +           (dep->flags & DWC3_EP_DELAY_STOP) ||
>             (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
>                 return;
>  
> diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
> index 77df4b6d6c13..f763380e672e 100644
> --- a/drivers/usb/dwc3/gadget.h
> +++ b/drivers/usb/dwc3/gadget.h
> @@ -116,6 +116,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
>                 gfp_t gfp_flags);
>  int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
>  void dwc3_ep0_send_delayed_status(struct dwc3 *dwc);
> +void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt);
>  
>  /**
>   * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
> 
> 
>  
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
