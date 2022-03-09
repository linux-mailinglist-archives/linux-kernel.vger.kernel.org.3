Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3834D2F80
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiCIMzU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Mar 2022 07:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiCIMzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:55:18 -0500
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C13A16040E;
        Wed,  9 Mar 2022 04:54:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id C1AD9FFAFC;
        Wed,  9 Mar 2022 12:54:16 +0000 (UTC)
Date:   Wed, 9 Mar 2022 13:54:14 +0100
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220309135414.34f77251.max@enpas.org>
In-Reply-To: <CAMZ6RqJZObevKPc29jW+m6i0eAgestTbw8KCPXxSGHzSXK7cRg@mail.gmail.com>
References: <20220307214303.1822590-1-max@enpas.org>
        <CAMZ6RqJZObevKPc29jW+m6i0eAgestTbw8KCPXxSGHzSXK7cRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot Vincent for your review!

Most points are self explanatory, for the others I've added replies
below.



On Tue, 8 Mar 2022 16:01:12 +0900
Vincent Mailhol <vincent.mailhol@gmail.com> wrote:

> Hi Max, this is a partial review.
> 
> > +/* Bits in elm->cmds_todo */
> > +enum ELM_TODO {
> > +       TODO_CAN_DATA = 0,
> > +       TODO_CANID_11BIT,
> > +       TODO_CANID_29BIT_LOW,
> > +       TODO_CANID_29BIT_HIGH,
> > +       TODO_CAN_CONFIG_PART2,
> > +       TODO_CAN_CONFIG,
> > +       TODO_RESPONSES,
> > +       TODO_SILENT_MONITOR,
> > +       TODO_INIT  
> 
> Nitpick but the TODO name is bugging me. What does this acronym mean?
> Is it possible to change this so it doesn't look like a FIXME tag?

Good point, I'll change it.

It's an ordered list of things to send next to the adapter. For
example, whenever the sending CAN ID needs to be changed, the relevant
TODO_* bits are set, and the new CAN ID is sent down the UART before a
payload (*_DATA) is ever sent.




> > +       frame.can_id = CAN_ERR_FLAG;
> > +       frame.can_dlc = CAN_ERR_DLC;
> > +       frame.data[5] = 'R';
> > +       frame.data[6] = 'I';
> > +       frame.data[7] = 'P';
> > +       elm327_feed_frame_to_netdev(elm, &frame);  
> 
> There is a framework to notify a bus off. Refer to:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/etas_es58x/es58x_core.c#L815

Thanks, will do.


> > +/* Compare a buffer to a fixed string */
> > +static inline int _memstrcmp(const u8 *mem, const char *str)
> > +{
> > +       return memcmp(mem, str, strlen(str));  
> 
> strcpy()?
> Did you check for buffer overflow?

There is no buffer overflow, as this only ever takes string constants
as *str. The compiler figures out the strlen() and can generate an
optimised memcmp() for this given string length.

It's the caller's job to ensure that *mem is large enough.


> > +
> > +       /* Use spaces in CAN ID to distinguish 29 or 11 bit address
> > length.
> > +        * No out-of-bounds access:
> > +        * We use the fact that we can always read from elm->rxbuf.
> > +        */
> > +       if (elm->rxbuf[2] == ' ' && elm->rxbuf[5] == ' ' &&
> > +           elm->rxbuf[8] == ' ' && elm->rxbuf[11] == ' ' &&
> > +           elm->rxbuf[13] == ' ') {  
> 
> Define an inline function elm327_is_eff().

It would only be used this one time, so I don't see the utility? It'd
just make it harder to read, IMHO.

It's ASCII lexer/parser code, so it's bound to be ugly... :(


> > +       /* Read CAN ID */
> > +       if (frame.can_id & CAN_EFF_FLAG) {
> > +               frame.can_id |= (hex_to_bin(elm->rxbuf[0]) << 28)
> > +                             | (hex_to_bin(elm->rxbuf[1]) << 24)
> > +                             | (hex_to_bin(elm->rxbuf[3]) << 20)
> > +                             | (hex_to_bin(elm->rxbuf[4]) << 16)
> > +                             | (hex_to_bin(elm->rxbuf[6]) << 12)
> > +                             | (hex_to_bin(elm->rxbuf[7]) << 8)
> > +                             | (hex_to_bin(elm->rxbuf[9]) << 4)
> > +                             | (hex_to_bin(elm->rxbuf[10]) << 0);
> > +       } else {
> > +               frame.can_id |= (hex_to_bin(elm->rxbuf[0]) << 8)
> > +                             | (hex_to_bin(elm->rxbuf[1]) << 4)
> > +                             | (hex_to_bin(elm->rxbuf[2]) << 0);  
> 
> hex2bin()?

Good idea!


> > +       /* Parse the data nibbles. */
> > +       for (i = 0; i < frame.can_dlc; i++) {  
> 
> frame.can_dlc is deprecated. Use frame.len instead.

Thanks!


[ ... snip self explanatory stuff ... ]


> > +       case ELM_RECEIVING:
> > +               /* Find <CR> delimiting feedback lines. */
> > +               for (len = 0;
> > +                    (len < elm->rxfill) && (elm->rxbuf[len] !=
> > '\r');  
> 
> Did you use ./script/checkpath?

checkpatch? Yes I did (and kudos to whoever wrote it).

Why?


> > +/* Dummy needed to use can_rx_offload */
> > +static struct sk_buff *elmcan_mailbox_read(struct can_rx_offload
> > *offload,
> > +                                          unsigned int n, u32
> > *timestamp,
> > +                                          bool drop)
> > +{
> > +       WARN_ON_ONCE(1); /* This function is a dummy, so don't call
> > it! */ +
> > +       return ERR_PTR(-ENOBUFS);
> > +}  
> 
> Could you elaborate on why you need can_rx_offload if the mailbox
> feature is not needed?

The code previously used netif_rx_ni(), and Marc noted that it may
reorder packets. To avoid that, he suggested rx_offload:

  Message-ID: 88c08b2c-aa4a-8858-6267-deeeac2796df@pengutronix.de

  https://www.spinics.net/lists/linux-can/msg01859.html


But rx_offload needs the mailbox_read function, even if it's a dummy,
because can_rx_offload_add_fifo() checks:

	if (!offload->mailbox_read)
		return -EINVAL;


> > +/* Send a can_frame to a TTY. */
> > +static netdev_tx_t elmcan_netdev_start_xmit(struct sk_buff *skb,
> > +                                           struct net_device *dev)
> > +{
> > +       struct elmcan *elm = netdev_priv(dev);
> > +       struct can_frame *frame = (struct can_frame *)skb->data;
> > +
> > +       if (skb->len != sizeof(struct can_frame))
> > +               goto out;  
> 
> Isn’t this aleardy guaranteed by the upper layers?

Copy-pasta from slcan.c - will look into it.


> > +       if (!netif_running(dev))  {
> > +               netdev_warn(elm->dev, "xmit: iface is down.\n");
> > +               goto out;
> > +       }  
> 
> Even if this check succeeds, interface might still go down at the
> next cycle. What is the purpose of checking if interface is up here?

No purpose. It's copy-pasta from slip.c via slcan.c.




Thanks again!

Max
