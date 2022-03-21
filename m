Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC124E1EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344136AbiCUCHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiCUCHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:07:34 -0400
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E9A627CF9;
        Sun, 20 Mar 2022 19:06:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id D8ADBFF93C;
        Mon, 21 Mar 2022 02:06:05 +0000 (UTC)
Date:   Mon, 21 Mar 2022 03:06:03 +0100
From:   Max Staudt <max@enpas.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220321030603.2feac810.max@enpas.org>
In-Reply-To: <20220317205542.2re5x73gqys5fl2n@pengutronix.de>
References: <20220307214303.1822590-1-max@enpas.org>
        <20220314215843.xxf6rdxxfwb255s4@pengutronix.de>
        <20220317211822.7d74b49c.max@enpas.org>
        <20220317205542.2re5x73gqys5fl2n@pengutronix.de>
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

On Thu, 17 Mar 2022 21:55:42 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 17.03.2022 21:18:22, Max Staudt wrote:
> > > > +/* Bits in elm->cmds_todo */
> > > > +enum ELM_TODO {    
> > >         ^^^^^^^^
> > > small caps please, and Vincent alreadt commented on the name.  
> > 
> > Small caps? Sorry, that's not possible in plain ASCII.
> > You probably mean something else, but I'm not sure what?  
> 
> I meant to say lowercase, sorry for the confusion.

Ah, thanks for the clarification!


> > > > +	/* Regular parsing */
> > > > +	switch (elm->state) {
> > > > +	case ELM_RECEIVING:
> > > > +		if (elm327_parse_frame(elm, len)) {
> > > > +			/* Parse an error line. */
> > > > +			elm327_parse_error(elm, len);
> > > > +
> > > > +			/* Start afresh. */
> > > > +			elm327_kick_into_cmd_mode(elm);
> > > > +		}
> > > > +		break;
> > > > +	default:
> > > > +		break;
> > > > +	}
> > > > +}
> > > > +
> > > > +/* Assumes elm->lock taken. */
> > > > +static void elm327_handle_prompt(struct elmcan *elm)
> > > > +{
> > > > +	struct can_frame *frame = &elm->can_frame;
> > > > +	char local_txbuf[20];    
> > > 
> > > How can you be sure, that the local_txbuf is large enough?  
> > 
> > It's filled in this very same function, with sprintf() or a strcpy()
> > from one of the short strings in elm327_init_script (see next quote
> > below). I've calculated the maximum length that can occur out of all
> > these possibilities in the current code, and set that as the length
> > of local_txbuf.  
> 
> You can use something like "local_txbuf[sizeof("ATZ;ATDT0815;ATH")]"
> with the longest ATZ command you can produce here.

That's a great idea, thanks!


> > > > +	/* Reconfigure ELM327 step by step as indicated by
> > > > elm->cmds_todo */
> > > > +	if (test_bit(TODO_INIT, &elm->cmds_todo)) {
> > > > +		strcpy(local_txbuf, *elm->next_init_cmd);    
> > > 
> > > strncpy()  
> > 
> > For this, there would have to be an entry in elm327_init_script
> > that is longer than sizeof(local_txbuf) - 1. I highly doubt there
> > ever will be, and even if someone does come up with one (maybe a
> > huge new command in a future ELM327 revision), then strncpy would
> > silently cut off the end and induce unexpected failure. Most
> > importantly, this failure would be silent - the driver doesn't
> > check the ELM's responses by design!
> > 
> > I suggest an assert here. How about something like this?
> > 
> > 	if (strlen(*elm->next_init_cmd) < sizeof(local_txbuf))
> > 		strcpy(local_txbuf, *elm->next_init_cmd);
> > 	else
> > 		WARN_ONCE(...)
> >
> > If elm327_init_script contains an item longer than this buffer, then
> > the buffer size needs to be increased. Simple programming error
> > IMHO. I'd also add a comment to state this, next to
> > elm327_init_script.
> > 
> > What do you think?  
> 
> You can use BUILD_BUG_ON() (see linux/build_bug.h) inside your C
> function to make a compile time check, or static_assert() outside of C
> functions.

Thanks! But... what would be the expression being checked? The desire
is to compare the size of local_txbuf against the size of each member
of elm327_init_script - it seems counterintuitive to me to loop over
them all and have a BUILD_BUG_ON() as the loop body. Does the compiler
optimise that away?


> > > > +	} else if (test_and_clear_bit(TODO_SILENT_MONITOR,
> > > > &elm->cmds_todo)) {
> > > > +		sprintf(local_txbuf, "ATCSM%i\r",
> > > > +			!(!(elm->can.ctrlmode &
> > > > CAN_CTRLMODE_LISTENONLY)));    
> > > 
> > > snprintf()  
> > 
> > See above. This size is predictable, and used to size local_txbuf.
> > 
> > Thinking about it, since this size is easily predictable, the
> > compiler could also do it, and that would turn snprintf() into a
> > compile time check.
> > 
> > Unfortunately I couldn't make GCC shout at me for giving snprintf()
> > too small a buffer to fit all possible expansions of this format
> > string. Is this even possible?  
> 
> In user space, I've seen warnings like that, not sure about the
> kernel.

Ditto.

Okay, then I can plop in snprintf() anyway, and maybe the compiler will
start shouting a few years down the road when this kind of warning is
enabled in kernel builds. Unless you no longer see the need :)


> > > > +static int elmcan_netdev_open(struct net_device *dev)
> > > > +{
> > > > +	struct elmcan *elm = netdev_priv(dev);
> > > > +	int err;
> > > > +
> > > > +	spin_lock_bh(&elm->lock);
> > > > +	if (elm->hw_failure) {
> > > > +		netdev_err(elm->dev, "Refusing to open
> > > > interface after a hardware fault has been detected.\n");
> > > > +		spin_unlock_bh(&elm->lock);
> > > > +		return -EIO;
> > > > +	}    
> > > 
> > > How to recover from this error?  
> > 
> > The user can detach and reattach the ldisc as often as desired.
> > 
> > There is currently no intention to recover automatically. Once
> > elm->hw_failure is set, something really weird must have happened
> > such as unexpected characters on the UART. Since these devices are
> > usually a PIC right next to a UART-USB bridge chip, which is why I
> > deem this indicative of hardware too faulty to be trusted in any
> > way.
> > 
> > Regular "expected" errors are parsed and dealt with by sending error
> > frames in elm327_parse_error(). These do not trigger hw_failure.  
> 
> Ok, in other drivers I usually do a full reset during an ifdown/ifup
> cycle....at least for non hot plug-able devices.

Yeah, this one is hotpluggable by definition, and I'm not sure that
resuming communications is a good idea once a UART sanity test in the
driver has failed. In case the UART is unreliable, trying to reset the
interface may do more harm than good.

And if anyone builds this interface internally into their product,
non-hotpluggable and with this driver, then may mercy be upon them.
This driver really isn't meant for them. All ELM327 devices I've ever
seen are a UART via RS232, USB, BT, or TCP, and hot-pluggable by the
user.

I have thought about a reset as a thing to maybe implement later down
the road, but so far when I tried to implement more lenient error
handling, I got a bad feeling about it.

Fun fact: elm327_hw_failure() used to be called elm327_panic() in early
versions of the driver, because I just give up on UART errors :)


> > > > +	elm->txbuf = kmalloc(ELM327_SIZE_TXBUF, GFP_KERNEL);
> > > >  
> > > 
> > > Why do you allocate an extra buffer?  
> > 
> > If I remember correctly, I was told that this is preferred because
> > drivers can DMA out of the aligned buffer. I didn't question that. I
> > can simply allocate a buffer as part of struct elmcan if you
> > prefer.  
> 
> You can force proper alignment with marking the memory as
> ____cacheline_aligned. Extra bonus for checking (and optimizing)
> structure packing with the "pahole" tool.

Thanks! Will do then, this simplifies things.



Max
