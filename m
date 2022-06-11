Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC0D547684
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiFKQmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiFKQmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:42:07 -0400
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1718B6266;
        Sat, 11 Jun 2022 09:42:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 13EA8100022;
        Sat, 11 Jun 2022 16:42:00 +0000 (UTC)
Date:   Sat, 11 Jun 2022 18:41:57 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220611184157.06271432.max@enpas.org>
In-Reply-To: <CAMZ6RqLb3irjBrpiOv23Hg6vVpzK4d31Pvat2AOS3EC0+e_=3A@mail.gmail.com>
References: <20220602213544.68273-1-max@enpas.org>
        <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
        <20220611151551.5024f51e.max@enpas.org>
        <CAMZ6RqLb3irjBrpiOv23Hg6vVpzK4d31Pvat2AOS3EC0+e_=3A@mail.gmail.com>
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

On Sat, 11 Jun 2022 23:42:39 +0900
Vincent Mailhol <vincent.mailhol@gmail.com> wrote:

> > > Are elm327 and can327 synonymous?  
> >
> > No. ELM327 is the OBD interpreter chip, made by ELM Electronics,
> > that my driver, can327, speaks to.
> >
> > If you have an idea for a catchier name, please let me know while
> > it's not upstream yet ;)
> >
> > I only changed the driver name from elmcan to can327 because I
> > wanted to emphasise that it's not something official done by ELM.  
> 
> I think it is common to name the driver after the hardware regardless
> if it is official or not.
> You have many drivers named after companies without their blessing
> (random example: hid-nintendo, pretty sure Nintendo did not
> participate in the making of this).
> And it makes it easier to research.

I agree, hence the original name. I don't want to pick a fight with
anyone though, and a good alternative does exist (can327), so I prefer
to play it safe, at least this time.

IMHO, to anyone who knows what an ELM327 is and who is looking for this
driver, the "327" in the name is very likely to hint at what it is. Not
many CAN devices are called 327 ;)

There are also several compatible parts with extended features, so
locking in on the original chip's name may be counter productive anyway.


> > > Nitpick but I would prefer ascending order: 1.3 then 1.4, then
> > > 1.4b and so on.  
> >
> > Hm. Fair enough. In return, please let me explain my thinking -
> > maybe you find it useful:
> >
> > With reverse ordering, you can start from the top, and then continue
> > down the list until you hit your own device's version version. As
> > you go further down, more limitations will accumulate, until you
> > stop reading when reaching your device's version. Everything below
> > can be ignored.
> >
> > Matter of preference indeed. If you insist, I'll change it around.  
> 
> Here, we enter the domain of taste and colours. I gave you my
> preferences. Use it as an input and make the final decision. It is
> already really great that you took time to write the documentation.

Thanks! I'll think about it until I release v8.


> > > > +At present, can327 does not evaluate this response and silently
> > > > assumes +that all commands are recognized. It is structured such
> > > > that it will +degrade gracefully when a command is unknown. See
> > > > the sections above on +known limitations for details.  
> > >
> > > This information is repeted twice whithin a dozen of lines. When I
> > > read it, it was still fresh in my memory. Removing this paragraph
> > > won't hurt, I think.  
> >
> > The reason why I repeated it is for casual readers that don't read
> > the entire document top to bottom. Or who may have done so, and
> > then jump into the middle of it - e.g. only reading this
> > "Communication example" section.  
> 
> This indeed applies to long documents. Yours is succinct enough not to
> have this issue.
> 
> > Do you still want me to remove the dupe?  
> 
> Same as above, I won't force you. You can make an educated choice to
> keep it or not based on the feedback I provided you.

Okay. With the new section ordering, I'll shorten it to a mention, and
refer to the known limitations below. I prefer to still mention it, as
the actual description only comes later. Kind of like having to declare
functions that are only defined after a call site.


> > Thanks, will do. I may wait for your cleanup patches to appear,
> > though.  
> 
> The v5 of my cleanup is already in the master branch of
> linux-can-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/
> 
> But you might have a conflict on drivers/net/can/Kconfig so better to
> wait for the v6 (or apply my patches manually if you are in a hurry).

Your v6 just hit linux-can-next, so I'll rebase on that.


> > > So here, you never loopback the skb. For what I understand, the
> > > controller does not provide such loopback features.
> > >
> > > However, local loopback is a core part of SocketCAN Concept, c.f.:
> > > https://docs.kernel.org/networking/can.html#local-loopback-of-sent-frames
> > >  
> >
> > That part of the documentation links onto itself because two
> > sections bear the same name :(  
> 
> Loopback doc links onto itself? Or should I say that it *loopbacks*
> onto itself? Don't know if the pun is intended but find it funny.

Kinda like googling "recursion" ;)

What are the odds that this mistake happened for the loopback topic!

No but seriously, there are two sections called "Local Loopback of Sent
Frames", and while they are meant to reference each other, the one in
local-loopback-of-sent-frames references itself
(socketcan-local-loopback1) instead of socketcan-local-loopback2 .

I'll send a patch...


> Do as you prefer. If you do not want the mainstream release to be
> further delayed, I think it is fully acceptable to go with the lazy
> direct loopback as I suggested and then later on provide a new patch.

I agree, I'd rather leave the code as-is now, and fix it incrementally.
Especially since you've reviewed it so thoroughly, and I don't want to
unravel this again, and it works well enough as-is. After all, the
documentation does start by saying that there are no guarantees ;)

Do you see any problem with leaving it as-is, i.e. not setting
IFF_ECHO, and thus having the CAN stack do the the for us? As far as I
can see, it is equivalent...


> I am happy with your answers. I let you make the final call on all of
> my nitpicks and do what you think is best. Because I am done with the
> review please add the following to your next version:
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Woohoo! 8 years after getting the hardware and working on it on and
off, this project is nearing the finish line. Thank you!


Max
