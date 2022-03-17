Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B2D4DCF31
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiCQUTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiCQUTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:19:47 -0400
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C169ED82;
        Thu, 17 Mar 2022 13:18:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id DCBC3FF86A;
        Thu, 17 Mar 2022 20:18:26 +0000 (UTC)
Date:   Thu, 17 Mar 2022 21:18:22 +0100
From:   Max Staudt <max@enpas.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220317211822.7d74b49c.max@enpas.org>
In-Reply-To: <20220314215843.xxf6rdxxfwb255s4@pengutronix.de>
References: <20220307214303.1822590-1-max@enpas.org>
 <20220314215843.xxf6rdxxfwb255s4@pengutronix.de>
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

Hi Marc,

Thanks a lot for your in-depth review, you caught a few things that show
how old this project is, and how much dust it has been gathering.

Comments below.




On Mon, 14 Mar 2022 22:58:43 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 07.03.2022 22:43:03, Max Staudt wrote:
> > diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> > index 1e660afcb61b..c25a0f8a397b 100644
> > --- a/drivers/net/can/Makefile
> > +++ b/drivers/net/can/Makefile
> > @@ -6,6 +6,7 @@
> >  obj-$(CONFIG_CAN_VCAN)		+= vcan.o
> >  obj-$(CONFIG_CAN_VXCAN)		+= vxcan.o
> >  obj-$(CONFIG_CAN_SLCAN)		+= slcan.o
> > +obj-$(CONFIG_CAN_ELMCAN)	+= elmcan.o  
> 
> Please keep that list sorted alphabetically. Please move the "config
> CAN_ELMCAN" accordingly.

I am not sure what sorting you mean. This part of the Makefile wasn't
sorted before, as the patch shows :)

And I've added elmcan next to slcan, as it's a similar exception, unlike
the (alphabetically sorted) regular drivers in a separate section below.


> You might want to list the (c) of the authors of the slcan.c

Done.


> > +#define pr_fmt(fmt) "[elmcan] " fmt  
> 
> Just "elmcan"

Done. Changed it to "elmcan: " to preserve legibility.


> Please move the MODULE_* to the end of the file

Done.


> > +#define ELM327_NAPI_WEIGHT 4
> > +
> > +#define ELM327_SIZE_RXBUF 256
> > +#define ELM327_SIZE_TXBUF 32
> > +
> > +#define ELM327_CAN_CONFIG_SEND_SFF           0x8000
> > +#define ELM327_CAN_CONFIG_VARIABLE_DLC       0x4000
> > +#define ELM327_CAN_CONFIG_RECV_BOTH_SFF_EFF  0x2000
> > +#define ELM327_CAN_CONFIG_BAUDRATE_MULT_8_7  0x1000
> > +
> > +#define ELM327_DUMMY_CHAR 'y'
> > +#define ELM327_DUMMY_STRING "y"
> > +#define ELM327_READY_CHAR '>'
> > +
> > +/* Bits in elm->cmds_todo */
> > +enum ELM_TODO {  
>         ^^^^^^^^
> small caps please, and Vincent alreadt commented on the name.

Small caps? Sorry, that's not possible in plain ASCII.
You probably mean something else, but I'm not sure what?

As for the name - done.


> > +struct elmcan {
> > +	/* This must be the first member when using alloc_candev()
> > */
> > +	struct can_priv can;  
> 
> Please use a consistent indention scheme, e.g. one space only.

Done.


> > +	/* State machine */
> > +	enum {
> > +		ELM_NOTINIT = 0,
> > +		ELM_GETDUMMYCHAR,
> > +		ELM_GETPROMPT,
> > +		ELM_RECEIVING,  
> 
> ELM_STATE_

Done.


> bool?
> u16?
> u8?

Thanks, fixing these makes me oddly happy.


> unused?
> unused?

True! Like the odd types above, these variables are artifacts of early
code versions (and my earlier C ugliness).


> > +/* Assumes elm->lock taken. */  
> 
> Remove comment and add...
> 
> > +static void elm327_send(struct elmcan *elm, const void *buf,
> > size_t len) +{
> > +	int actual;
> > +  
> 
> lockdep_assert_held(elm->lock);

That's a really good idea, thanks!


> > +static void elm327_send_frame(struct elmcan *elm, struct can_frame
> > *frame) +{
> > +	/* Schedule any necessary changes in ELM327's CAN
> > configuration */
> > +	if (elm->can_frame.can_id != frame->can_id) {
> > +		/* Set the new CAN ID for transmission. */
> > +		if ((frame->can_id & CAN_EFF_FLAG)  
> 
> Please move operator to the end of the line.

Done.


> > +static int elm327_parse_frame(struct elmcan *elm, size_t len)
> > +{
> > +	struct can_frame frame;
> > +	int hexlen;
> > +	int datastart;
> > +	int i;
> > +
> > +	memset(&frame, 0, sizeof(frame));  
> 
> please directly allocate an skb and fill it

Done.


> > +	/* Read CAN data length */
> > +	frame.can_dlc = (hex_to_bin(elm->rxbuf[datastart - 2]) <<
> > 0); +
> > +	/* Read CAN ID */
> > +	if (frame.can_id & CAN_EFF_FLAG) {
> > +		frame.can_id |= (hex_to_bin(elm->rxbuf[0]) << 28)
> > +			      | (hex_to_bin(elm->rxbuf[1]) << 24)
> > +			      | (hex_to_bin(elm->rxbuf[3]) << 20)
> > +			      | (hex_to_bin(elm->rxbuf[4]) << 16)
> > +			      | (hex_to_bin(elm->rxbuf[6]) << 12)
> > +			      | (hex_to_bin(elm->rxbuf[7]) << 8)
> > +			      | (hex_to_bin(elm->rxbuf[9]) << 4)
> > +			      | (hex_to_bin(elm->rxbuf[10]) << 0);
> > +	} else {
> > +		frame.can_id |= (hex_to_bin(elm->rxbuf[0]) << 8)
> > +			      | (hex_to_bin(elm->rxbuf[1]) << 4)
> > +			      | (hex_to_bin(elm->rxbuf[2]) << 0);
> > +	}  
> 
> Can you make use of hex2bin() here?

No. I've checked because Vincent already suggested it. hex2bin() is for
larger hexdumps of bytestreams, not for single 32-bit integers like
this here.

I'd be parsing into a buffer, then swapping endianness. Also, the
non-EFF case wouldn't change anyway. Since it's just this once and only
in the EFF case, I personally prefer to keep it clear and the same as
the non-EFF case.

tl;dr - not worth the bother, it just becomes harder to read.


> > +	/* Parse the data nibbles. */
> > +	for (i = 0; i < frame.can_dlc; i++) {
> > +		frame.data[i] = (hex_to_bin(elm->rxbuf[datastart +
> > 3*i]) << 4)
> > +			      | (hex_to_bin(elm->rxbuf[datastart +
> > 3*i + 1]));  
> 
> hex2bin()?

No, there are spaces between the nibble pairs.
Hence the 3*i instead of 2*i index.

A CAN data line received from ELM327 looks like this:

  123 D PL PL PL PL PL PL PL PL

PL are the payload bytes parsed here, and separated by spaces.

hex2bin() applies to strings like "PLPLPLPLPLPLPLPL".


> > +static void elm327_parse_line(struct elmcan *elm, size_t len)
> > +{
> > +	/* Skip empty lines */
> > +	if (!len)
> > +		return;
> > +
> > +	/* Skip echo lines */
> > +	if (elm->drop_next_line) {
> > +		elm->drop_next_line = 0;
> > +		return;
> > +	} else if (!_memstrcmp(elm->rxbuf, "AT")) {
> > +		return;
> > +	}
> > +
> > +	/* Regular parsing */
> > +	switch (elm->state) {
> > +	case ELM_RECEIVING:
> > +		if (elm327_parse_frame(elm, len)) {
> > +			/* Parse an error line. */
> > +			elm327_parse_error(elm, len);
> > +
> > +			/* Start afresh. */
> > +			elm327_kick_into_cmd_mode(elm);
> > +		}
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> > +/* Assumes elm->lock taken. */
> > +static void elm327_handle_prompt(struct elmcan *elm)
> > +{
> > +	struct can_frame *frame = &elm->can_frame;
> > +	char local_txbuf[20];  
> 
> How can you be sure, that the local_txbuf is large enough?

It's filled in this very same function, with sprintf() or a strcpy()
from one of the short strings in elm327_init_script (see next quote
below). I've calculated the maximum length that can occur out of all
these possibilities in the current code, and set that as the length of
local_txbuf.


> > +	/* Reconfigure ELM327 step by step as indicated by
> > elm->cmds_todo */
> > +	if (test_bit(TODO_INIT, &elm->cmds_todo)) {
> > +		strcpy(local_txbuf, *elm->next_init_cmd);  
> 
> strncpy()

For this, there would have to be an entry in elm327_init_script that is
longer than sizeof(local_txbuf) - 1. I highly doubt there ever will be,
and even if someone does come up with one (maybe a huge new command in a
future ELM327 revision), then strncpy would silently cut off the end and
induce unexpected failure. Most importantly, this failure would be
silent - the driver doesn't check the ELM's responses by design!

I suggest an assert here. How about something like this?

	if (strlen(*elm->next_init_cmd) < sizeof(local_txbuf))
		strcpy(local_txbuf, *elm->next_init_cmd);
	else
		WARN_ONCE(...)

If elm327_init_script contains an item longer than this buffer, then
the buffer size needs to be increased. Simple programming error IMHO.
I'd also add a comment to state this, next to elm327_init_script.

What do you think?


> > +	} else if (test_and_clear_bit(TODO_SILENT_MONITOR,
> > &elm->cmds_todo)) {
> > +		sprintf(local_txbuf, "ATCSM%i\r",
> > +			!(!(elm->can.ctrlmode &
> > CAN_CTRLMODE_LISTENONLY)));  
> 
> snprintf()

See above. This size is predictable, and used to size local_txbuf.

Thinking about it, since this size is easily predictable, the compiler
could also do it, and that would turn snprintf() into a compile time
check.

Unfortunately I couldn't make GCC shout at me for giving snprintf() too
small a buffer to fit all possible expansions of this format string. Is
this even possible?


> > +static int elmcan_netdev_open(struct net_device *dev)
> > +{
> > +	struct elmcan *elm = netdev_priv(dev);
> > +	int err;
> > +
> > +	spin_lock_bh(&elm->lock);
> > +	if (elm->hw_failure) {
> > +		netdev_err(elm->dev, "Refusing to open interface
> > after a hardware fault has been detected.\n");
> > +		spin_unlock_bh(&elm->lock);
> > +		return -EIO;
> > +	}  
> 
> How to recover from this error?

The user can detach and reattach the ldisc as often as desired.

There is currently no intention to recover automatically. Once
elm->hw_failure is set, something really weird must have happened such
as unexpected characters on the UART. Since these devices are usually a
PIC right next to a UART-USB bridge chip, which is why I deem this
indicative of hardware too faulty to be trusted in any way.

Regular "expected" errors are parsed and dealt with by sending error
frames in elm327_parse_error(). These do not trigger hw_failure.


> > +/* Send a can_frame to a TTY. */
> > +static netdev_tx_t elmcan_netdev_start_xmit(struct sk_buff *skb,
> > +					    struct net_device *dev)
> > +{
> > +	struct elmcan *elm = netdev_priv(dev);
> > +	struct can_frame *frame = (struct can_frame *)skb->data;
> > +
> > +	if (skb->len != sizeof(struct can_frame))
> > +		goto out;  
> 
> replace by
> 
>         if (can_dropped_invalid_skb(ndev, skb))
> 		return NETDEV_TX_OK;

Done, thanks!

In an earlier email to Vincent, I thought that invalid skbs can't
filter down here, but I was obviously wrong :)


> > +
> > +	if (!netif_running(dev))  {
> > +		netdev_warn(elm->dev, "xmit: iface is down.\n");
> > +		goto out;
> > +	}  
> 
> How should this happen?

It shouldn't. Vincent pointed it out too, and I've removed it.


> > +static const struct net_device_ops elmcan_netdev_ops = {
> > +	.ndo_open	= elmcan_netdev_open,
> > +	.ndo_stop	= elmcan_netdev_close,
> > +	.ndo_start_xmit	= elmcan_netdev_start_xmit,
> > +	.ndo_change_mtu	= can_change_mtu,
> > +};
> > +
> > +/* Get a reference to our struct, taking into account
> > locks/refcounts.
> > + * This is to ensure ordering in case we are shutting down, and to
> > ensure
> > + * there is a refcount at all (otherwise tty->disc_data may be
> > freed and
> > + * before we increment the refcount).
> > + * Use this for anything that can race against
> > elmcan_ldisc_close().
> > + */  
> 
> Please have a look, mainline uses RCU:
> 
> | 0ace17d56824 can, slip: Protect tty->disc_data in write_wakeup and
> close with RCU

Will do, thanks!


> > +static int elmcan_ldisc_open(struct tty_struct *tty)
> > +{
> > +	struct net_device *dev;
> > +	struct elmcan *elm;
> > +	int err;
> > +
> > +	if (!capable(CAP_NET_ADMIN))
> > +		return -EPERM;
> > +
> > +	if (!tty->ops->write)
> > +		return -EOPNOTSUPP;
> > +
> > +	dev = alloc_candev(sizeof(struct elmcan), 0);
> > +	if (!dev)
> > +		return -ENFILE;
> > +	elm = netdev_priv(dev);
> > +
> > +	elm->txbuf = kmalloc(ELM327_SIZE_TXBUF, GFP_KERNEL);  
> 
> Why do you allocate an extra buffer?

If I remember correctly, I was told that this is preferred because
drivers can DMA out of the aligned buffer. I didn't question that. I
can simply allocate a buffer as part of struct elmcan if you prefer.


> > +	if (!elm->txbuf) {
> > +		err = -ENOMEM;
> > +		goto out_err;
> > +	}
> > +
> > +	/* Configure TTY interface */
> > +	tty->receive_room = 65536; /* We don't flow control */
> > +	elm->txleft = 0; /* Clear TTY TX buffer */
> > +	spin_lock_init(&elm->lock);
> > +	atomic_set(&elm->refcount, 1);
> > +	INIT_WORK(&elm->tx_work, elmcan_ldisc_tx_worker);
> > +
> > +	/* Configure CAN metadata */
> > +	elm->can.state = CAN_STATE_STOPPED;  
> 
> net needed

Done, removed.
