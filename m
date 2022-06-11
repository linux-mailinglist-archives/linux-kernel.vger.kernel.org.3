Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E65474C7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiFKNQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiFKNP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:15:57 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C733B62A27;
        Sat, 11 Jun 2022 06:15:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 9960E100022;
        Sat, 11 Jun 2022 13:15:53 +0000 (UTC)
Date:   Sat, 11 Jun 2022 15:15:51 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220611151551.5024f51e.max@enpas.org>
In-Reply-To: <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
References: <20220602213544.68273-1-max@enpas.org>
 <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
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

@Marc, Wolfgang - one SocketCAN design question about bitrate setting at
the end. I'd appreciate your opinion on my dummy do_set_bittiming().

Comments for Vincent below.



On Sat, 4 Jun 2022 00:12:39 +0900
Vincent Mailhol <vincent.mailhol@gmail.com> wrote:

> Hi Max,
> 
> I gave a final deep look into your driver. I found a few things which
> went through the cracks of my previous reviews. But overall, it start
> to look good. Well done and looking forward for the v8.

Thank you for your continued support! :)


> Are elm327 and can327 synonymous?

No. ELM327 is the OBD interpreter chip, made by ELM Electronics, that
my driver, can327, speaks to.

If you have an idea for a catchier name, please let me know while it's
not upstream yet ;)

I only changed the driver name from elmcan to can327 because I wanted to
emphasise that it's not something official done by ELM.


> Not sure if there is a convention of how many empty lines there should
> be before a new section in a .rst file. However, three new lines seems
> above average (had a quick peek, other .rst files usually use one or
> two new lines).

Not sure either. I find it easier to read with extra visual cues, and
to provide them to others.

If there are no complaints, I'd prefer keep it as-is.


> Information about baudrate parameters is given twice. You could
> combine the two paragraphs not to repeat yourself.

Good idea, will do.


> > +The line discipline can be attached on a command prompt as
> > follows:: +
> > +    sudo ldattach \
> > +           --debug \
> > +           --speed 38400 \
> > +           --eightbits \
> > +           --noparity \
> > +           --onestopbit \
> > +           --iflag -ICRNL,INLCR,-IXOFF \
> > +           30 \
> > +           /dev/ttyUSB0
> > +
> > +To change the ELM327's serial settings, please refer to its data
> > +sheet. This needs to be done before attaching the line discipline.
> > +
> > +Once the ldisc is attached, the CAN interface starts out
> > unconfigured. +Set the speed before starting it:  
> 
> Shouldn't you use a double column :: here to indicate that the next
> block is a piece of code?

Whoops. Yes, I should. Thanks!


> > +    # The interface needs to be down to change parameters
> > +    sudo ip link set can0 down
> > +    sudo ip link set can0 type can bitrate 500000
> > +    sudo ip link set can0 up
> > +
> > +500000 bit/s is a common rate for OBD-II diagnostics.
> > +If you're connecting straight to a car's OBD port, this is the
> > speed +that most cars (but not all!) expect.
> > +
> > +After this, you can set out as usual with candump, cansniffer, etc.
> > +
> > +
> > +
> > +Known limitations of the controller
> > +------------------------------------
> > +
> > +- Clone devices ("v1.5" and others)
> > +
> > +  Sending RTR frames is not supported and will be dropped silently.
> > +
> > +  Receiving RTR with DLC 8 will appear to be a regular frame with
> > +  the last received frame's DLC and payload.
> > +
> > +  "``AT CSM``" not supported, thus no ACK-ing frames while
> > listening:
> > +  "``AT MA``" will always be silent. However, immediately after
> > +  sending a frame, the ELM327 will be in "receive reply" mode, in
> > +  which it *does* ACK any received frames. Once the bus goes silent
> > +  or an error occurs (such as BUFFER FULL), the ELM327 will end
> > reply
> > +  reception mode on its own and can327 will fall back to "``AT
> > MA``"
> > +  in order to keep monitoring the bus.  
> 
> Maybe two sentences of what is an AT command would be helpful? It is
> the Hayes command set, isn't it?
> https://en.wikipedia.org/wiki/Hayes_command_set

It is not Hayes, not at all. Why they chose the AT prefix, I do not
know. Modems use it to auto-detect the terminal's speed, while the
ELM327 does not. Its baud rate is changed with yet another one of these
ATxx commands, after which you need to adapt your terminal's baud rate
accordingly.

Please just see the "AT" prefix as a fixed part of the commands you can
send it, with no further meaning. It's like prefixing every magic
incantation by "abracadabra" or something.


> Also, a quick memo of what the acronym CSM and MA mean would be great
> (so that we do not need to have to constantly cross check the
> datasheet).

Good idea!


> > +
> > +- All versions
> > +
> > +  No full duplex operation is supported. The driver will switch
> > +  between input/output mode as quickly as possible.
> > +
> > +  The length of outgoing RTR frames cannot be set. In fact, some
> > +  clones (tested with one identifying as "``v1.5``") are unable to
> "> +  send RTR frames at all.
> > +
> > +  We don't have a way to get real-time notifications on CAN errors.
> > +  While there is a command (``AT CS``) to retrieve some basic
> > stats,
> > +  we don't poll it as it would force us to interrupt reception
> > mode. +
> > +
> > +- Versions prior to 1.4b
> > +
> > +  These versions do not send CAN ACKs when in monitoring mode (AT
> > MA).
> > +  However, they do send ACKs while waiting for a reply immediately
> > +  after sending a frame. The driver maximizes this time to make the
> > +  controller as useful as possible.
> > +
> > +  Starting with version 1.4b, the ELM327 supports the "``AT CSM``"
> > +  command, and the "listen-only" CAN option will take effect.
> > +
> > +
> > +- Versions prior to 1.4
> > +
> > +  These chips do not support the "``AT PB``" command, and thus
> > cannot
> > +  change bitrate or SFF/EFF mode on-the-fly. This will have to be
> > +  programmed by the user before attaching the line discipline. See
> > the
> > +  data sheet for details.
> > +
> > +
> > +- Versions prior to 1.3
> > +
> > +  These chips cannot be used at all with can327. They do not
> > support
> > +  the "``AT D1``" command, which is necessary to avoid parsing
> > conflicts
> > +  on incoming data, as well as distinction of RTR frame lengths.
> > +
> > +  Specifically, this allows for easy distinction of SFF and EFF
> > +  frames, and to check whether frames are complete. While it is
> > possible
> > +  to deduce the type and length from the length of the line the
> > ELM327
> > +  sends us, this method fails when the ELM327's UART output buffer
> > +  overruns. It may abort sending in the middle of the line, which
> > will
> > +  then be mistaken for something else.  
> 
> Nitpick but I would prefer ascending order: 1.3 then 1.4, then 1.4b
> and so on.

Hm. Fair enough. In return, please let me explain my thinking - maybe
you find it useful:

With reverse ordering, you can start from the top, and then continue
down the list until you hit your own device's version version. As you
go further down, more limitations will accumulate, until you stop
reading when reaching your device's version. Everything below can be
ignored.

Matter of preference indeed. If you insist, I'll change it around.


> > +Communication example
> > +----------------------
> > +
> > +This is a short and incomplete introduction on how to talk to an
> > ELM327. +
> > +
> > +The ELM327 has two modes:
> > +
> > +- Command mode
> > +- Reception mode
> > +
> > +In command mode, it expects one command per line, terminated by CR.
> > +By default, the prompt is a "``>``", after which a command can be
> > +entered::
> > +
> > +    >ATE1
> > +    OK
> > +    >
> > +
> > +The init script in the driver switches off several configuration
> > options +that are only meaningful in the original OBD scenario the
> > chip is meant +for, and are actually a hindrance for can327.
> > +
> > +
> > +When a command is not recognized, such as by an older version of
> > the +ELM327, a question mark is printed as a response instead of
> > OK:: +
> > +    >ATUNKNOWN
> > +    ?
> > +    >
> > +
> > +At present, can327 does not evaluate this response and silently
> > assumes +that all commands are recognized. It is structured such
> > that it will +degrade gracefully when a command is unknown. See the
> > sections above on +known limitations for details.  
> 
> This information is repeted twice whithin a dozen of lines. When I
> read it, it was still fresh in my memory. Removing this paragraph
> won't hurt, I think.

The reason why I repeated it is for casual readers that don't read the
entire document top to bottom. Or who may have done so, and then jump
into the middle of it - e.g. only reading this "Communication example"
section.

Do you still want me to remove the dupe?


> > +When a CAN frame is to be sent, the target address is configured,
> > after +which the frame is sent as a command that consists of the
> > data's hex +dump::
> > +
> > +    >ATSH123
> > +    OK
> > +    >DEADBEEF12345678
> > +    OK
> > +    >
> > +
> > +The above interaction sends the frame "``DE AD BE EF 12 34 56
> > 78``" with +the 11 bit CAN ID ``0x123``.  
> 
> Use the standard terminology:
> 11 bit CAN ID -> SFF (standard frame format)
> 
> ...
> 
> Use the standard terminology:
> 29 bit CAN frames -> EFF (extended frame format)

Done.


> > +can327 uses to tell the two apart::
> > +
> > +    12 34 56 78 8 DEADBEEF12345678
> > +
> > +The ELM327 will receive both 11 and 29 bit frames - the current CAN
> > +config (``ATPB``) does not matter.
> > +
> > +
> > +If the ELM327's internal UART sending buffer runs full, it will
> > abort +the monitoring mode, print "BUFFER FULL" and drop back into
> > command +mode. Note that in this case, unlike with other error
> > messages, the +error message may appear on the same line as the
> > last (usually +incomplete) data frame::
> > +
> > +    12 34 56 78 8 DEADBEEF123 BUFFER FULL  
> 
> Would be beneficial to put this section before the "known limitations"
> one. It gives some nice context and help to better understand the
> topics raised and reading this first really

True, good point.


> > diff --git a/Documentation/networking/device_drivers/can/index.rst
> > b/Documentation/networking/device_drivers/can/index.rst index
> > 58b6e0ad3030..c4f724db4908 100644 ---
> > a/Documentation/networking/device_drivers/can/index.rst +++
> > b/Documentation/networking/device_drivers/can/index.rst @@ -10,6
> > +10,7 @@ Contents: .. toctree::
> >     :maxdepth: 2
> >
> > +   can327
> >     freescale/flexcan  
> 
> This part of the patch does not apply. It conflicts with
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=5f02ecbe08d6a3434a14b92bee98adec76e8808e
> 
> Please rebase on the latest version on net-next.

Thanks, will do. I may wait for your cleanup patches to appear, though.


> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>  
> 
> linux/moduleparam.h is not needed, right? Please make sure to clean up
> unused headers.

Oh, true, the dreaded module parameter that was removed in v3.

I'll clean up.

BTW, in case anyone is wondering - no user of the out-of-tree version
has complained about this module parameter going missing, so it was
indeed unnecessary!


> > +#include <linux/atomic.h>
> > +#include <linux/bitops.h>
> > +#include <linux/ctype.h>
> > +#include <linux/delay.h>
> > +#include <linux/errno.h>
> > +#include <linux/if_ether.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/lockdep.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/skbuff.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/string.h>
> > +#include <linux/tty.h>
> > +#include <linux/tty_ldisc.h>
> > +#include <linux/workqueue.h>
> > +
> > +#include <uapi/linux/tty.h>
> > +
> > +#include <linux/can.h>
> > +#include <linux/can/dev.h>
> > +#include <linux/can/error.h>
> > +#include <linux/can/led.h>  
> 
> Rebase on net-next (or can-next) and remove CAN LED. c.f.:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=6c1e423a3c84953edcf91ff03ab97829b287184a

Done. Thanks!


> > +static int elm327_parse_frame(struct can327 *elm, size_t len)
> > +{
> > +       struct can_frame *frame;
> > +       struct sk_buff *skb;
> > +       int hexlen;
> > +       int datastart;
> > +       int i;
> > +
> > +       lockdep_assert_held(&elm->lock);
> > +
> > +       skb = alloc_can_skb(elm->dev, &frame);
> > +       if (!skb)
> > +               return -ENOMEM;
> > +
> > +       /* Find first non-hex and non-space character:
> > +        *  - In the simplest case, there is none.
> > +        *  - For RTR frames, 'R' is the first non-hex character.
> > +        *  - An error message may replace the end of the data line.
> > +        */
> > +       for (hexlen = 0; hexlen <= len; hexlen++) {
> > +               if (hex_to_bin(elm->rxbuf[hexlen]) < 0 &&
> > +                   elm->rxbuf[hexlen] != ' ') {
> > +                       break;
> > +               }
> > +       }
> > +
> > +       /* Sanity check whether the line is really a clean hexdump,
> > +        * or terminated by an error message, or contains garbage.
> > +        */
> > +       if (hexlen < len &&
> > +           !isdigit(elm->rxbuf[hexlen]) &&
> > +           !isupper(elm->rxbuf[hexlen]) &&
> > +           '<' != elm->rxbuf[hexlen] &&
> > +           ' ' != elm->rxbuf[hexlen]) {
> > +               /* The line is likely garbled anyway, so bail.
> > +                * The main code will restart listening.
> > +                */
> > +               return -ENODATA;  
> 
> Here (and on other return statement of this function), I think you
> have a memory leak on skb. You probably need a goto label to free the
> skb when error occurs.

Oh no, you're right! Thank you so much for spotting this.

This happened during the transition to use alloc_can_skb(). I used to
have a CAN frame on the stack, so no leak could happen.

I've checked the other sites where I retrofitted alloc_can_* as well,
all is good now.


> > +/* Send a can_frame to a TTY. */
> > +static netdev_tx_t can327_netdev_start_xmit(struct sk_buff *skb,
> > +                                           struct net_device *dev)
> > +{
> > +       struct can327 *elm = netdev_priv(dev);
> > +       struct can_frame *frame = (struct can_frame *)skb->data;
> > +
> > +       if (can_dropped_invalid_skb(dev, skb))
> > +               return NETDEV_TX_OK;
> > +
> > +       /* This check will be part of can_dropped_invalid_skb()
> > +        * in future kernels.
> > +        */
> > +       if (elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> > +               goto out;
> > +
> > +       /* We shouldn't get here after a hardware fault:
> > +        * can_bus_off() calls netif_carrier_off()
> > +        */
> > +       if (elm->uart_side_failure) {
> > +               WARN_ON_ONCE(elm->uart_side_failure);
> > +               goto out;
> > +       }
> > +
> > +       netif_stop_queue(dev);
> > +
> > +       /* BHs are already disabled, so no spin_lock_bh().
> > +        * See Documentation/networking/netdevices.txt
> > +        */
> > +       spin_lock(&elm->lock);
> > +       elm327_send_frame(elm, frame);
> > +       spin_unlock(&elm->lock);
> > +
> > +       dev->stats.tx_packets++;
> > +       dev->stats.tx_bytes += frame->len;
> > +
> > +       can_led_event(dev, CAN_LED_EVENT_TX);
> > +
> > +out:
> > +       kfree_skb(skb);
> > +       return NETDEV_TX_OK;  
> 
> So here, you never loopback the skb. For what I understand, the
> controller does not provide such loopback features.
> 
> However, local loopback is a core part of SocketCAN Concept, c.f.:
> https://docs.kernel.org/networking/can.html#local-loopback-of-sent-frames

That part of the documentation links onto itself because two sections
bear the same name :(

So both sections together confirm that the CAN core performs the local
echo for me, because I never set IFF_ECHO. That's what I have been
building on - just like slcan. can327 can't provide exact information
anyway. Since even reception won't work until transmission is done
(ELM327 provides a half-duplex interface on its UART), it won't reorder
events.

Okay, thinking deeper, I can think of *one* race case: Something flowing
into the UART RX buffer while the UART TX buffer is being constructed.
The ELM327 needs to be taken out of reception mode, and put into sending
mode. The echo packet should be delayed until reception mode is
successfully terminated and thus all UART RX data up until then is
parsed (and any CAN frames are piped into SocketCAN).

I'll see to fixing this. This is nagging me now.


> It is still better to loopback even if you can not know for sure if
> the transmission is successfull.
> The easiest way to loopback your skb by using can_put_echo_skb() and
> then can_get_echo_skb() right away, similar to what cc770 does:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/cc770/cc770.c#L698
> 
> If you do so, do not forget to adjust your call to alloc_candev() to
> add room for one echo skb.

See above.


> > +/* ELM327 can only handle bitrates that are integer divisors of
> > 500 kHz,
> > + * or 7/8 of that. Divisors are 1 to 64.
> > + * Currently we don't implement support for 7/8 rates.
> > + */
> > +static const u32 can327_bitrate_const[64] = {  
> 
> Nitpick but I preffer not to specify the size and let the compiler do
> it for me: static const u32 can327_bitrate_const[] = {
> 
> If you are worried about the size, you can always do:
> static_assert(sizeof(can327_bitrate_const) == 64);

Nah, no worries here, I don't remember why I did this so I'll remove
the size :)


> 
> > +        7812,  7936,  8064,  8196,  8333,  8474,  8620,  8771,
> > +        8928,  9090,  9259,  9433,  9615,  9803, 10000, 10204,
> > +       10416, 10638, 10869, 11111, 11363, 11627, 11904, 12195,
> > +       12500, 12820, 13157, 13513, 13888, 14285, 14705, 15151,
> > +       15625, 16129, 16666, 17241, 17857, 18518, 19230, 20000,
> > +       20833, 21739, 22727, 23809, 25000, 26315, 27777, 29411,
> > +       31250, 33333, 35714, 38461, 41666, 45454, 50000, 55555,
> > +       62500, 71428, 83333, 100000, 125000, 166666, 250000, 500000
> > +};
> > +
> > +/* Dummy needed to use bitrate_const */
> > +static int can327_do_set_bittiming(struct net_device *netdev)
> > +{
> > +       return 0;
> > +}  
> 
> Is this dummy function really needed? If think that access to
> can_priv::do_set_bittiming is always garded. Setting it to NULL should
> be OK. c.f.:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev/netlink.c#L198

drivers/net/can/dev/netlink.c - can_changelink():

	/* Calculate bittiming parameters based on
	 * bittiming_const if set, otherwise pass bitrate
	 * directly via do_set_bitrate(). Bail out if neither
	 * is given.
	 */
	if (!priv->bittiming_const && !priv->do_set_bittiming)
		return -EOPNOTSUPP;

can327 has neither of these two, so I provide a dummy for one.

What should I do instead?


While at it, a comment in elm327_init mentioned bittiming_const - that
was from the pre-bitrate_const (< v4.11) times, and I've now updated it
to mention bitrate_const instead.



Thank you for the thorough review!

Max
