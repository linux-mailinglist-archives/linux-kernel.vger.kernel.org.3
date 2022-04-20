Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66A1508366
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376739AbiDTIbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356317AbiDTIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:30:59 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6164935267
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1650443293;
  x=1681979293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v8LWDDcHCeryoL0yiBGiT7o390KlBFvaYjqfzBcj75E=;
  b=i1MsQnctOEFDVMfTUkQsN+avotk5hkUEhiwjBNPy6CVVlWsvZlBG9+q5
   KxQK1TtYtf3cdFdqRtdxjAOw8yMyaVAx3YFVDbK6DjgZsqXa1uGf6RhvQ
   10hZuh2P0bB22qug7k2IwhErSmP/APnIKSLPZmTtw40sAjMmpT+j/Gq75
   AcoOhnk2qmGU+GBJHlEkRf2BvTbZn1Ue+0aSA1B8xPM05wZ7nir/EAVzO
   2mxoudG83uyl1/J6UF2GAIS4DLqO9ZIlr6pEBWRjh5NKPkNCdzPVwcWdK
   Ll64TIMDsu13ga05SVkAHTgQ+4cL6jD6kwltNLCT60xtR/BJ6WdiOQhw0
   Q==;
Message-ID: <487bbd00-d763-0a86-9984-1dfd957fbb38@axis.com>
Date:   Wed, 20 Apr 2022 10:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mailbox: forward the hrtimer if not queued and under a
 lock
Content-Language: en-US
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     kernel <kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220331070115.29421-1-bjorn.ardo@axis.com>
 <CABb+yY1zrHYLBjY_EoC7bkTsWcKOhzCjp-5vgvqP0HEAJicdXQ@mail.gmail.com>
 <c4aa28b2-5550-ed39-3869-556b451ff54b@axis.com>
 <CABb+yY1BNsdMq7CNOBDk3sn7uvpL4=-fT7eOcbuL-+Yjz+iqHw@mail.gmail.com>
From:   Bjorn Ardo <bjorn.ardo@axis.com>
In-Reply-To: <CABb+yY1BNsdMq7CNOBDk3sn7uvpL4=-fT7eOcbuL-+Yjz+iqHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail04w.axis.com
 (10.20.40.10)
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 4/19/22 16:10, Jassi Brar wrote:
> I don't have access to your client driver, but if it submits another
> message from rx_callback() that is the problem.
>
> Please have a look at how other platforms do, for example
> imx_dsp_rproc_rx_tx_callback()
>
> /**
>   * mbox_chan_received_data - A way for controller driver to push data
>   *              received from remote to the upper layer.
>   * @chan: Pointer to the mailbox channel on which RX happened.
>   * @mssg: Client specific message typecasted as void *
>   *
>   * After startup and before shutdown any data received on the chan
>   * is passed on to the API via atomic mbox_chan_received_data().
>   * The controller should ACK the RX only after this call returns.
>   */
> void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
>
> If not this, please share your client code as well.
>
> thanks.


In rx_callback() we call tasklet_hi_schedule() to schedule a tasklet and 
this tasklet calls mbox_send_message(). The mailbox is setup with 
.tx_block = false.

I do not quite understand how calling mbox_send_message() from another 
contex (like a work thread as in imx_dsp_rproc_rx_tx_callback()) will 
resolve the race, could you explain this? Or do you mean that it should 
not be called from any interrupt context at all? Looking at the 
documentation of mbox_send_message() it states:


  * This function could be called from atomic context as it simply
  * queues the data and returns a token against the request.


If I look at the code in msg_submit() the part that calls 
hrtimer_active() and hrtimer_start() is completely without a lock. Also 
the code in txdone_hrtimer() that calls hrtimer_forward_now() is without 
a lock. So I cannot see anything preventing these two functions to be 
called concurrently on two different processors (as they do in my 
trace). And looking at the hr_timer code then hrtimer_active() will 
return true if the hrtimer is currently executing txdone_hrtimer().

The way I see the race is if the timer has called txdone_hrtimer() and 
it has passed the part with the for-loop looking at the individual 
channels when the msg_submit() runs. Then txdone_hrtimer() has decided 
to not restart the timer, but hrtimer_active() will still return true 
for a while (until txdone_hrtimer() return completely and the hrtimer 
code can change its status). In this time there is nothing that prevents 
msg_submit() from running, adding a new message that the timer should 
monitor. But if it manages to call hrtimer_active() in the time period 
before the hrtimer code updates it then the current code will never 
start the timer.

Also the poll_hrt is shared between all channels in the mailbox, so it 
does not have to be the same mailbox channel that hrtimer is currently 
waiting for that is calling msg_submit(). So not calling 
mbox_send_message() from rx_callback() will only alter timing for that 
channel. There could still be a race between two different mailbox channels.


This is my understanding of the current code, please tell me if I have 
missed or misunderstood any part of it?


Our current solution are using 4 different mailbox channels 
asynchronously. The code is part of a larger system, but I can put down 
some time and try and extract the relevant parts if you still think this 
is a client issue? But with my current understanding of the code, the 
race between msg_submit() and txdone_hrtimer() is quite clear, and with 
my proposed patch that removes this race we have be able to run for very 
long time without any problems (that is several days). Without the fix 
we get the race after 5-10 min.


Best Regards,

Björn



