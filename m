Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EBD4E7E08
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiCYTpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiCYTpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:45:08 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B18422AC67;
        Fri, 25 Mar 2022 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648235762; x=1679771762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mwdD6ExlenSkXt5cpCHsjyIG+DgW6SJ0DIMwGaDZqAk=;
  b=RYef9418cWOe5cUp3xsqFA93f60kOxfL7XnZlszMrihwXodm4stDmyt6
   m8d+nsad9oeWtW3X0vHhv9+3rfaseJIfh2L21ayoeEJLLUd2hGodnmVss
   mzhioj1FdvxYxekaqB4c38AeytrNbeHNBmDQ8sgmAF3arqtem0mVmKAOM
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Mar 2022 11:35:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 11:35:55 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 11:35:55 -0700
Received: from [10.110.11.236] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 25 Mar
 2022 11:35:55 -0700
Message-ID: <153d7be4-601a-9768-5c7f-6a532d66d324@quicinc.com>
Date:   Fri, 25 Mar 2022 11:35:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH v2 1/3] usb: dwc3: Flush pending SETUP data during
 stop active xfers
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20220216000835.25400-1-quic_wcheng@quicinc.com>
 <20220216000835.25400-2-quic_wcheng@quicinc.com>
 <eeee97bf-2987-3cfb-217e-42615d8d864b@codeaurora.org>
 <26c82c13-d047-853e-12af-e916596c5c52@synopsys.com>
 <469213d0-526a-e26e-88c2-b34b2aa8dfe7@codeaurora.org>
 <e2a15c5e-f437-3dfb-6c49-a97a094eaaae@synopsys.com>
 <6d3470af-5d75-a989-dc21-00f42c022af0@quicinc.com>
 <4b91bf76-02e5-c680-862a-1ef4ed53eea4@synopsys.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <4b91bf76-02e5-c680-862a-1ef4ed53eea4@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2022 6:51 PM, Thinh Nguyen wrote:
> Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 3/23/2022 5:39 PM, Thinh Nguyen wrote:
>>> Hi Wesley,
>>>
>>> Wesley Cheng wrote:
>>>> Hi Thinh,
>>>>
>>>> On 3/22/2022 6:31 PM, Thinh Nguyen wrote:
>>>>> Hi Wesley,
>>>>>
>>>>> Wesley Cheng wrote:
>>>>>> Hi Thinh,
>>>>>>
>>>>>> On 2/15/2022 4:08 PM, Wesley Cheng wrote:
>>>>>>> While running the pullup disable sequence, if there are pending SETUP
>>>>>>> transfers stored in the controller, then the ENDTRANSFER commands on non
>>>>>>> control eps will fail w/ ETIMEDOUT.  As a suggestion from SNPS, in order
>>>>>>> to drain potentially cached SETUP packets, SW needs to issue a
>>>>>>> STARTTRANSFER command.  After issuing the STARTTRANSFER, and retrying the
>>>>>>> ENDTRANSFER, the command should succeed.  Else, if the endpoints are not
>>>>>>> properly stopped, the controller halt sequence will fail as well.
>>>>>>>
>>>>>>> One limitation is that the current logic will drop the SETUP data
>>>>>>> being received (ie dropping the SETUP packet), however, it should be
>>>>>>> acceptable in the pullup disable case, as the device is eventually
>>>>>>> going to disconnect from the host.
>>>>>>>
>>>>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>>>>> ---
>>>>>> Just wondering if you had any inputs for this particular change?  I
>>>>>> think on the dequeue path discussion you had some concerns with parts of
>>>>>> this change?  I think the difficult part for the pullup disable path is
>>>>>> that we have this API running w/ interrupts disabled, so the EP0 state
>>>>>> won't be able to advance compared to the dequeue case.
>>>>>
>>>>> This doesn't sound right. The pullup disable (or device initiated
>>>>> disconnect) should wait for the EP0 state to be EP0_SETUP_PHASE before
>>>>> proceeding, which it does.
>>>>>
>>>> That is correct, but even though that check is passed, it doesn't
>>>> prevent the host from sending another SETUP token between the pending
>>>> setup packet check and run/stop clear.
>>>>
>>>
>>> That should be fine, because we would have the TRB ready for that SETUP
>>> packet.
>>>
>> I agree, its valid for the controller to be able to receive the next
>> setup packet.
>>
>>>>>>
>>>>>> Ideally, if there is a way to ensure that we avoid reading further setup
>>>>>> packets, that would be nice, but from our discussions with Synopsys,
>>>>>> this was not possible. (controller is always armed and ready to ACK
>>>>>> setup tokens)
>>>>>>
>>>>>> I did evaluate keeping IRQs enabled and periodically releasing/attaining
>>>>>> the lock between the stop active xfer calls, but that opened another can
>>>>>> of worms.  If you think this is the approach we should take, I can take
>>>>>> a look at this implementation further.
>>>>>>
>>>>>
>>>>> This patch doesn't look right to me. The change I suggested before
>>>>> should address this (I believe Greg already picked it up). What other
>>>>> problem do you see, I'm not clear what's the problem here. One potential
>>>>> problem that I can see is that currently dwc3 driver doesn't wait for
>>>>> active endpoints to complete/end before clearing the run_stop bit on
>>>>> device initiated disconnect, but I'm not sure if that's what you're seeing.
>>>>>
>>>>> Please help clarify further. If there's trace points log, that'd help.
>>>>>
>>>> Main difference between the issue Greg recently pulled in and this one
>>>> is that this is on the pullup disable patch (no dequeue involved).  In
>>>> this situation we will also stop active transfers, so that the
>>>> controller can halt properly.
>>>>
>>>> I attached a few files, and will give a summary of them below:
>>>> 1.  pullup_disable_timeout.txt - ftrace of an instance of when we see
>>>> several endxfer timeouts.  Refer to line#2016.
>>>>
>>>> 2.  lecroy+ftrace_snip.png - picture showing a matching bus sniffer log
>>>> and a ftrace collected (difference instance to #1)
>>>>
>>>> #2 will show that we completed a SETUP transfer before entering into
>>>> dwc3_gadget_stop_active_transfers().  In here, we then see DWC ACK
>>>> another SETUP token, which leads to endxfer timeouts on all subsequent
>>>> endpoints.
>>>
>>> Thanks for the captures. I think the problem here is because the dwc3
>>> driver disables the control endpoint. It shouldn't do that.
>>>
>>> Can you try this:
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index ab725d2262d6..f0b9ea353620 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -1010,12 +1010,12 @@ static int __dwc3_gadget_ep_disable(struct
>>> dwc3_ep *dep)
>>>         if (dep->flags & DWC3_EP_STALL)
>>>                 __dwc3_gadget_ep_set_halt(dep, 0, false);
>>>
>>> -       reg = dwc3_readl(dwc->regs, DWC3_DALEPENA);
>>> -       reg &= ~DWC3_DALEPENA_EP(dep->number);
>>> -       dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
>>> -
>>> -       /* Clear out the ep descriptors for non-ep0 */
>>>         if (dep->number > 1) {
>>> +               reg = dwc3_readl(dwc->regs, DWC3_DALEPENA);
>>> +               reg &= ~DWC3_DALEPENA_EP(dep->number);
>>> +               dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
>>> +
>>> +               /* Clear out the ep descriptors for non-ep0 */
>>>                 dep->endpoint.comp_desc = NULL;
>>>                 dep->endpoint.desc = NULL;
>>>         }
>>>
>> I was able to reproduce the endxfer timeout w/ the above change.  I'm
>> assuming you didn't want me to include any parts of my change while
>> testing, right?
>>
Hi Thinh,

> 
> Right, please don't add additional code. I can't review knowing what
> else was changed.
> 
Sure. There was one change from my patch that I pulled over, which
resolved some enumeration issues I saw (while testing your change, as well):

@@ -885,12 +885,13 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep
*dep, unsigned int action)
 		reg |= DWC3_DALEPENA_EP(dep->number);
 		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);

-		if (usb_endpoint_xfer_control(desc))
-			goto out;
-
 		/* Initialize the TRB ring */
 		dep->trb_dequeue = 0;
 		dep->trb_enqueue = 0;
+
+		if (usb_endpoint_xfer_control(desc))
+			goto out;
+
 		memset(dep->trb_pool, 0,
 		       sizeof(struct dwc3_trb) * DWC3_TRB_NUM);

This was added because I saw that there were instances where the SETUP
TRB was referencing dwc->ep0_trb[1].  However, I believe that for the
SETUP phase, we should always be using dwc->ep0_trb[0] as we are passing
in the ep0_trb_addr (DMA addr for ep0_trb[0]) as part of
dwc3_ep0_start_trans()

>> Current sequence in dwc3_gadget_pullup(0) is that we should call
>> dwc3_stop_active_transfers() before we call __dwc3_gadget_stop().
>> (gadget stop will call the ep disable for EP[0] and EP[1])  This might
>> be why the issue would still be occurring.
>>
>> The attached ftrace that captures a situation where a forced BUG will
>> occur on the first instance of the timeout.
>>
>> [ 1573.687689437       0x724885c22]   event (000020c0): ep0out: Transfer
>> Not Ready [0] (Not Active) [Status Phase]
>> [ 1573.687738707       0x724885fd3]   dbg_send_ep_cmd: ep0out: cmd
>> 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status:
>> Successful
>> [ 1573.698040582       0x7248b6477]   dbg_send_ep_cmd: ep1out: cmd 'End
>> Transfer' [20c08] params 00000000 00000000 00000000 --> status: Timed Out
>>
>> We definitely started the STATUS phase, so host could have read it and
>> sent the next SETUP packet while we were already in the
>> dwc3_stop_active_transfers() loop.
> 
> Yeah, pullup() is another async call that can trigger the same problem.
> 
> 
> 
> [ 1573.687193134       0x7248836e8]   dbg_send_ep_cmd: ep0out: cmd 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
> [ 1573.687263291       0x724883c2b]   event (0000c040): ep0out: Transfer Complete (sIL) [Setup Phase]
> [ 1573.687287145       0x724883df6]   dbg_trace_log_ctrl: Clear Interface Feature(Function Suspend)
> 
> Trace indicates that this is ClearFeature(Interface.FuncSuspend)
> 
> 
> [ 1573.687372301       0x724884459]   dbg_send_ep_cmd: ep0in: cmd 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
> [ 1573.687400634       0x724884679]   event (000010c2): ep0in: Transfer Not Ready [0] (Not Active) [Data Phase]
> [ 1573.687471155       0x724884bc2]   event (000090c2): ep0in: Transfer Not Ready [0] (Active) [Data Phase]
> [ 1573.687495009       0x724884d8d]   event (0000c042): ep0in: Transfer Complete (sIL) [Data Phase]
> [ 1573.687544697       0x724885146]   dbg_gadget_giveback: ep0out: req ffffff87a6768800 length 20/20 ZsI ==> 0
> 
> But there's data stage. Is this non-standard/vendor request?
> We probably need to fix the tracepoint to properly print vendor
> requests.
> 
Correct, its most likely a vendor specific command handled by our
function driver.

> 
> [ 1573.687593187       0x7248854e9]   dbg_ep_queue: ep5in: req ffffff87a6769000 length 0/8 zsI ==> -115
> [ 1573.687619645       0x7248856e6]   dbg_prepare: ep5in: trb ffffffc05a97d1a0 (E27:D26) buf 00000000ee07f600 size 1x 8 ctrl 00000811 (Hlcs:sC:normal)
> [ 1573.687660270       0x7248859f2]   dbg_send_ep_cmd: ep5in: cmd 'Update Transfer' [b0007] params 00000000 00000000 00000000 --> status: Successful
> [ 1573.687689437       0x724885c22]   event (000020c0): ep0out: Transfer Not Ready [0] (Not Active) [Status Phase]
> [ 1573.687738707       0x724885fd3]   dbg_send_ep_cmd: ep0out: cmd 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
> 
> It's still in status stage, it never reached Setup phase.
> 
> 
> [ 1573.698040582       0x7248b6477]   dbg_send_ep_cmd: ep1out: cmd 'End Transfer' [20c08] params 00000000 00000000 00000000 --> status: Timed Out
> 
> That's why it's possible to time out here. The Setup Phase should
> have been prepared before we can issue End Transfer.
> 
> I can't see where the pullup() begins as this log is missing register
> read/write trace events. Looks like the wait_for_completion_timeout()
> is insufficient. I assume it happens right after previous Setup
Yes, I've noticed that the wait_for_completion() call isn't too reliable
as it isn't under a spinlock.  This mechanism worked well for the
dequeue case since we checked for the EP0 state while the lock was held.

> phase. There's no spin_lock, so the driver can proceed with the
> new control request before it reaches dwc3_stop_active_transfers().
> 
> Can you try this. (yes, the code looks ugly right now, but it's just
> to confirm my suspicion)
> 
Sure, I think I did something earlier as well, where I just manually
polled for EP0state to reach back to SETUP, but there was always a
possibility for host to initiate a SETUP packet while we loop across all
15 eps.  If this doesn't work, I can take it a step further and check
EP0 state in between each stop active transfer call.  I'll try to repro
it w/ this change and get you some traces.

Thanks
Wesley Cheng

> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index ab725d2262d6..3b40411556ff 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2506,6 +2506,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  
>         is_on = !!is_on;
>         dwc->softconnect = is_on;
> +
> +retry:
>         /*
>          * Per databook, when we want to stop the gadget, if a control transfer
>          * is still in process, complete it and get the core into setup phase.
> @@ -2541,6 +2543,24 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>                 return 0;
>         }
>  
> +       if (!is_on) {
> +               spin_lock_irqsave(&dwc->lock, flags);
> +               if (dwc->ep0state != EP0_SETUP_PHASE) {
> +                       spin_unlock_irqrestore(&dwc->lock, flags);
> +                       goto retry;
> +               }
> +
> +               /*
> +                * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
> +                * Section 4.1.8 Table 4-7, it states that for a device-initiated
> +                * disconnect, the SW needs to ensure that it sends "a DEPENDXFER
> +                * command for any active transfers" before clearing the RunStop
> +                * bit.
> +                */
> +               dwc3_stop_active_transfers(dwc);
> +               spin_unlock_irqrestore(&dwc->lock, flags);
> +       }
> +
>         /*
>          * Synchronize and disable any further event handling while controller
>          * is being enabled/disabled.
> @@ -2553,14 +2573,6 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>                 u32 count;
>  
>                 dwc->connected = false;
> -               /*
> -                * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
> -                * Section 4.1.8 Table 4-7, it states that for a device-initiated
> -                * disconnect, the SW needs to ensure that it sends "a DEPENDXFER
> -                * command for any active transfers" before clearing the RunStop
> -                * bit.
> -                */
> -               dwc3_stop_active_transfers(dwc);
>                 __dwc3_gadget_stop(dwc);
>  
>                 /*
> 
> Thanks,
> Thinh
