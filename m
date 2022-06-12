Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA40F547A03
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 14:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiFLMDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 08:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiFLMD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 08:03:27 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74F3F27B0A;
        Sun, 12 Jun 2022 05:03:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id D783BFF9E2;
        Sun, 12 Jun 2022 12:03:22 +0000 (UTC)
Date:   Sun, 12 Jun 2022 14:03:20 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220612140217.6ad6d2f9.max@enpas.org>
In-Reply-To: <CAMZ6RqKzO7ya3Z-fx+FZ5vAsOy0B9Ec8TRagjysJEK0i4Z3asw@mail.gmail.com>
References: <20220602213544.68273-1-max@enpas.org>
 <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
 <20220611151551.5024f51e.max@enpas.org>
 <CAMZ6RqLb3irjBrpiOv23Hg6vVpzK4d31Pvat2AOS3EC0+e_=3A@mail.gmail.com>
 <20220611184157.06271432.max@enpas.org>
 <CAMZ6RqKzO7ya3Z-fx+FZ5vAsOy0B9Ec8TRagjysJEK0i4Z3asw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2022 10:33:51 +0900
Vincent Mailhol <vincent.mailhol@gmail.com> wrote:

> > I agree, hence the original name. I don't want to pick a fight with
> > anyone though, and a good alternative does exist (can327), so I
> > prefer to play it safe, at least this time.
> >
> > IMHO, to anyone who knows what an ELM327 is and who is looking for
> > this driver, the "327" in the name is very likely to hint at what
> > it is. Not many CAN devices are called 327 ;)
> >
> > There are also several compatible parts with extended features, so
> > locking in on the original chip's name may be counter productive
> > anyway.  
> 
> Generally speaking, I would be worried if everyone started to rename
> the drivers. What if I named my driver can58x instead of es58x and
> what if Marc named his driver can251xfd instead of mcp251xfd? Things
> will start to be really confusing.

Agreed. FWIW, I suggested can-* in the same vein as hid-*, which would
group CAN drivers together. It would then be can-mcp251xfd rather than
can251xfd. Anyway, no, I don't suggest renaming existing drivers, as
that'd be a hassle.


> But I did a quick search. Several clones also use the name can327. So
> in your particular case, I think this renaming is kind of acceptable.

Okay, thanks!

Since you deem can327 acceptable, let's leave it as it is.


As for this particular driver, I got unlucky with my device because it
can do more than CAN, yet I wanted the driver name to show that the
driver implements *only* CAN. Had I called it "elm327", it would have
been confusing to the casual user as to what the driver is really for:
CAN? K-Line? OBD? All of them? Hence why I always squeezed "can" into
the name somehow. It's an edge case, really.

For non-edge cases, thanks for alleviating my concerns about company
names etc. in driver names.


> > > Do as you prefer. If you do not want the mainstream release to be
> > > further delayed, I think it is fully acceptable to go with the
> > > lazy direct loopback as I suggested and then later on provide a
> > > new patch.  
> >
> > I agree, I'd rather leave the code as-is now, and fix it
> > incrementally. Especially since you've reviewed it so thoroughly,
> > and I don't want to unravel this again, and it works well enough
> > as-is. After all, the documentation does start by saying that there
> > are no guarantees ;)
> >
> > Do you see any problem with leaving it as-is, i.e. not setting
> > IFF_ECHO, and thus having the CAN stack do the the for us? As far
> > as I  
>                                                  ^^^
> do the what?
> > can see, it is equivalent...  
> 
> It seems a part of your answer is missing. I do not get what
> alternative solution you are considering instead of using IFF_ECHO.
> 
> What I propose should be a three line fix: add the IFF_ECHO, use the
> can_put_echo_skb() and the can_get_echo_skb().

The alternative solution is to leave it as-is: Iff IFF_ECHO is unset,
then in net/can/af_can.c - can_send() the CAN stack generates echo
frames for us.

It seems you weren't aware of this functionality, hence the
misunderstanding.

(except that I missed the RTR detail, see below)


> If leaving it as-is, can327 will behave differently than the other
> drivers. For example, candump will only record the RX frames when
> users expect to see both TX and RX. So that's my real concern.

Nope, it's not at all like this - candump shows the own sent packets
just fine!

This is one of the first things I ensured when I started the driver. I
wouldn't release a driver like that as it would drive me crazy as a
user.

Several other drivers don't provice IFF_ECHO - slcan, vxcan. And vcan
has it configurable. An interesting one is found in usb/ucan.c which
provides echo, but doesn't set IFF_ECHO. I suppose candump will show
sent packets twice when using ucan?


> The other thing is that the can_put_echo_skb() and can_get_echo_skb()
> do some other operations. For example, can_get_echo_skb() returns a
> length of zero for the RTR frames. If you do not use those helper
> functions, you have to do the check by hand and only increment
> stats->tx_bytes if the frame is not an RTR one.
> 
> If you leave it as is, then just fix the RTR length e.g. like that:
> https://elixir.bootlin.com/linux/v5.18/source/drivers/net/can/vcan.c#L95

Oh, I missed this detail. Very good point, thanks!

I'll apply the vcan RTR fix for now (ugly, but minimal code change), and
it can be removed once "proper" echo support is implemented in can327.


Okay, I think all my questions are handled now.

Thanks again!

Max
