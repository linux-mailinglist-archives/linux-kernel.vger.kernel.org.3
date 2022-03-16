Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DDA4DB00E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355904AbiCPMsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiCPMsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:48:37 -0400
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [203.148.12.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D143B65D31;
        Wed, 16 Mar 2022 05:47:20 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 16 Mar
 2022 20:47:17 +0800
Received: from [10.29.8.49] (10.29.8.49) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 16 Mar
 2022 20:47:16 +0800
Message-ID: <e9c0fd5f-5573-40d9-bfdb-e18e034a05aa@zhaoxin.com>
Date:   Wed, 16 Mar 2022 20:47:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] USB: Fix xhci ERDP update issue
Content-Language: en-US
To:     Peter Chen <hzpeterchen@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <mathias.nyman@intel.com>, Alan Stern <stern@rowland.harvard.edu>,
        "USB list" <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>,
        <TimGuo@zhaoxin.com>, <tonywwang@zhaoxin.com>,
        <weitaowang@zhaoxin.com>
References: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com>
 <Yi7xJy70XZCA8RyN@kroah.com>
 <CAL411-o_2PSndEVXfa+ciLukSr5u5w8G9T63d2MpSm2Fpn5QTQ@mail.gmail.com>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <CAL411-o_2PSndEVXfa+ciLukSr5u5w8G9T63d2MpSm2Fpn5QTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.29.8.49]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/16 19:57, Peter Chen wrote:
> On Mon, Mar 14, 2022 at 10:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Mon, Mar 14, 2022 at 03:25:23PM +0800, WeitaoWang-oc@zhaoxin.com wrote:
>>> On some situations, software handles TRB events slower than adding TRBs,
>>> xhci_irq will not exit until all events are handled. If xhci_irq just
>>> handles 256 TRBs and exit, the temp variable(event_ring_deq) driver records
>>> in xhci irq is equal to driver current dequeue pointer. It will cause driver
>>> not update ERDP and software dequeue pointer lost sync with ERDP. On the
>>> next xhci_irq, the event ring is full but driver will not update ERDP as
>>> software dequeue pointer is equal to ERDP.
> 
> At the current driver, the ERDP is updated at most 128 TRBs, how is
> the above condition
> triggered?
> 
> Peter

If the number of TRB events to be processed in a given interrupt is 256.
ERDP is updated after only the first 128 TRB evnets are processed.
It will not be updated when another 128 TRB evnets are processed as 
event_ring_deq= "xhci->event_ring->dequeue", which will cause the 
software-recorded dequeue pointer is out of sync with ERDP on interrupt 
exit.

Weitao Wang
> 
> 
>>>
>>> [  536.377115] xhci_hcd 0000:00:12.0: ERROR unknown event type 37
>>> [  566.933173] sd 8:0:0:0: [sdb] tag#27 uas_eh_abort_handler 0 uas-tag 7
>>> inflight: CMD OUT
>>> [  566.933181] sd 8:0:0:0: [sdb] tag#27 CDB: Write(10) 2a 00 17 71 e6 78 00
>>> 00 08 00
>>> [  572.041186] xhci_hcd On some situataions,the0000:00:12.0: xHCI host not
>>> responding to stop endpoint command.
>>> [  572.057193] xhci_hcd 0000:00:12.0: Host halt failed, -110
>>> [  572.057196] xhci_hcd 0000:00:12.0: xHCI host controller not responding,
>>> assume dead
>>> [  572.057236] sd 8:0:0:0: [sdb] tag#26 uas_eh_abort_handler 0 uas-tag 6
>>> inflight: CMD
>>> [  572.057240] sd 8:0:0:0: [sdb] tag#26 CDB: Write(10) 2a 00 38 eb cc d8 00
>>> 00 08 00
>>> [  572.057244] sd 8:0:0:0: [sdb] tag#25 uas_eh_abort_handler 0 uas-tag 5
>>> inflight: CMD
>>>
>>> Fixed this issue by update software record temp variable when handles 128
>>> TRB events.
>>>
>>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>>> ---
>>>   drivers/usb/host/xhci-ring.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>>> index d0b6806..f970799 100644
>>> --- a/drivers/usb/host/xhci-ring.c
>>> +++ b/drivers/usb/host/xhci-ring.c
>>> @@ -3141,6 +3141,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
>>>                  if (event_loop++ < TRBS_PER_SEGMENT / 2)
>>>                          continue;
>>>                  xhci_update_erst_dequeue(xhci, event_ring_deq);
>>> +               event_ring_deq = xhci->event_ring->dequeue;
>>>
>>>                  /* ring is half-full, force isoc trbs to interrupt more
>>> often */
>>>                  if (xhci->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
>>> --
>>> 2.7.4
>>
>> Hi,
>>
>> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
>> a patch that has triggered this response.  He used to manually respond
>> to these common problems, but in order to save his sanity (he kept
>> writing the same thing over and over, yet to different people), I was
>> created.  Hopefully you will not take offence and will fix the problem
>> in your patch and resubmit it so that it can be accepted into the Linux
>> kernel tree.
>>
>> You are receiving this message because of the following common error(s)
>> as indicated below:
>>
>> - Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
>>    and can not be applied.  Please read the file,
>>    Documentation/email-clients.txt in order to fix this.
>>
>>
>> If you wish to discuss this problem further, or you have questions about
>> how to resolve this issue, please feel free to respond to this email and
>> Greg will reply once he has dug out from the pending patches received
>> from other developers.
>>
>> thanks,
>>
>> greg k-h's patch email bot
> .
