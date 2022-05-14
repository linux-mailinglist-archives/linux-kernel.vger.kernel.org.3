Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256275270C7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 13:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiENLEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 07:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiENLEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 07:04:45 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3529DBC8;
        Sat, 14 May 2022 04:04:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 1E6ADFF959;
        Sat, 14 May 2022 11:04:41 +0000 (UTC)
Date:   Sat, 14 May 2022 13:04:30 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220514130430.44a2aa21.max@enpas.org>
In-Reply-To: <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
References: <20220512182921.193462-1-max@enpas.org>
 <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
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

On Fri, 13 May 2022 11:38:31 +0900
Vincent Mailhol <vincent.mailhol@gmail.com> wrote:

> Nice improvement since v3, thanks! Here are my new comments.

Well, thanks for and thanks to your review!

Replies below, a few style things (branching/goto) omitted.


> > +/* Bits in elm->cmds_todo */
> > +enum elm327_to_to_do_bits {  
> 
> to_to_do? Name looks like a typo. Also, do not see the value on the
> _bits suffix. I suggest:
> 
> enum elm327_tx_do {

Indeed, a typo! It should have been elm327_to_to_do_bits. It's named
*_bits because the elem's indices are used to index bits in cmds_todo
in struct can327.

I guess your suggestion is nice, because it fits with the named indices.


> > +struct can327 {
> > +       /* This must be the first member when using alloc_candev()
> > */
> > +       struct can_priv can;
> > +
> > +       struct can_rx_offload offload;
> > +
> > +       /* TTY buffers */
> > +       u8 rxbuf[ELM327_SIZE_RXBUF];
> > +       u8 txbuf[ELM327_SIZE_TXBUF] ____cacheline_aligned;  
> 
> Out of curiosity, any rationale for the use of ____cacheline_aligned
> here?

Actually, I've checked now and it seems to not be necessary at all.

This was originally a kmalloc()'d buffer, in order to pass aligned
memory to tty->ops->write(). However, there are other (though few)
ldiscs that pass unaligned memory, and there aren't any checks in
serdev either, so I'll drop the forced alignment.


> > +static void elm327_kick_into_cmd_mode(struct can327 *elm)
> > +{
> > [...]
> 
> (frame->can_id & CAN_EFF_FLAG) ^ (elm->can_frame_to_send.can_id &
> CAN_EFF_FLAG)
> 
> can be factorized as:
> 
> (frame->can_id ^ elm->can_frame_to_send.can_id) & CAN_EFF_FLAG

Yes :)


> > +/* Compare buffer to string length, then compare buffer to fixed
> > string.
> > + * This ensures two things:
> > + *  - It flags cases where the fixed string is only the start of
> > the
> > + *    buffer, rather than exactly all of it.
> > + *  - It avoids byte comparisons in case the length doesn't match.
> > + *
> > + * strncmp() cannot be used here because it accepts the following
> > wrong case:
> > + *   strncmp("CAN ER", "CAN ERROR", 6);  
> 
> What about:
> strncmp("CAN ER", "CAN ERROR", 7);
> ?

NAK, because this may overread the buffer by one byte (the NUL byte).
I am comparing naked bytes, not NUL-terminated strings.


> > +static void elm327_parse_error(struct can327 *elm, size_t len)
> > +{
> > +       struct can_frame *frame;
> > +       struct sk_buff *skb;
> > +
> > +       lockdep_assert_held(&elm->lock);
> > +
> > +       skb = alloc_can_err_skb(elm->dev, &frame);
> > +       if (!skb)
> > +               /* It's okay to return here:
> > +                * The outer parsing loop will drop this UART
> > buffer.
> > +                */
> > +               return;
> > +
> > +       /* Filter possible error messages based on length of RX'd
> > line */
> > +       if (check_len_then_cmp(elm->rxbuf, len, "UNABLE TO
> > CONNECT")) {  
> 
> Is this equivalent?
>       if (!strncmp(elm->rxbuf, "UNABLE TO CONNECT", len + 1)) {

No. We can use (len) bytes in elm->rxbuf, not (len+1).

There are no C strings in this buffer. There are no NUL chars in this
buffer. There are no trailing bytes we can overread into.


> > +static void elm327_handle_prompt(struct can327 *elm)
> > +{
> > +       struct can_frame *frame = &elm->can_frame_to_send;
> > +       /* Size this buffer for the largest ELM327 line we may
> > generate,
> > +        * which is currently an 8 byte CAN frame's payload hexdump.
> > +        * Items in elm327_init_script must fit here, too!
> > +        */
> > +       char local_txbuf[sizeof("0102030405060708\r")];
> > +
> > +       lockdep_assert_held(&elm->lock);
> > +
> > +       if (!elm->cmds_todo) {
> > +               /* Enter CAN monitor mode */
> > +               elm327_send(elm, "ATMA\r", 5);
> > +               elm->state = ELM327_STATE_RECEIVING;
> > +
> > +               /* We will be in the default state once this
> > command is
> > +                * sent, so enable the TX packet queue.
> > +                */
> > +               netif_wake_queue(elm->dev);
> > +
> > +               return;
> > +       }
> > +
> > +       /* Reconfigure ELM327 step by step as indicated by
> > elm->cmds_todo */
> > +       if (test_bit(ELM327_TX_DO_INIT, &elm->cmds_todo)) {
> > +               snprintf(local_txbuf, sizeof(local_txbuf),
> > +                        "%s",
> > +                        *elm->next_init_cmd);
> > +
> > +               elm->next_init_cmd++;
> > +               if (!(*elm->next_init_cmd)) {
> > +                       clear_bit(ELM327_TX_DO_INIT,
> > &elm->cmds_todo);
> > +                       /* Init finished. */
> > +               }
> > +
> > +       } else if (test_and_clear_bit(ELM327_TX_DO_SILENT_MONITOR,
> > &elm->cmds_todo)) {
> > +               snprintf(local_txbuf, sizeof(local_txbuf),
> > +                        "ATCSM%i\r",
> > +                        !(!(elm->can.ctrlmode &
> > CAN_CTRLMODE_LISTENONLY)));  
> 
> The second pair of brackets look superficial:
>                snprintf(local_txbuf, sizeof(local_txbuf),
>                         "ATCSM%i\r",
>                         !!(elm->can.ctrlmode &
> CAN_CTRLMODE_LISTENONLY));

True, thanks for catching this.


> > +static void elm327_parse_rxbuf(struct can327 *elm)
> > +{
> > +       size_t len;
> > +       int i;
> > +
> > +       lockdep_assert_held(&elm->lock);
> > +
> > +       switch (elm->state) {
> > +       case ELM327_STATE_NOTINIT:
> > +               elm->rxfill = 0;
> > +               break;
> > +
> > +       case ELM327_STATE_GETDUMMYCHAR:
> > +       {  
> 
> Is this braket need?

No it's not, it's a leftover from before moving "int i;" to the
function head.


> > +
> > +       case ELM327_STATE_GETPROMPT:
> > +               /* Wait for '>' */
> > +               if (elm327_is_ready_char(elm->rxbuf[elm->rxfill -
> > 1]))
> > +                       elm327_handle_prompt(elm);
> > +
> > +               elm->rxfill = 0;
> > +               break;
> > +
> > +       case ELM327_STATE_RECEIVING:
> > +               /* Find <CR> delimiting feedback lines. */
> > +               for (len = 0;
> > +                    (len < elm->rxfill) && (elm->rxbuf[len] !=
> > '\r');
> > +                    len++) {
> > +                       /* empty loop */  
> 
> Question of taste but would prefer a while look with the len++ in the
> body (if you prever to do as above, no need to argue, just keep it
> like it is).

Good point, I think a while() would be easier on the eyes indeed.


> 
> > +               }
> > +
> > +               if (len == ELM327_SIZE_RXBUF) {
> > +                       /* Line exceeds buffer. It's probably all
> > garbage.
> > +                        * Did we even connect at the right baud
> > rate?
> > +                        */
> > +                       netdev_err(elm->dev,
> > +                                  "RX buffer overflow. Faulty
> > ELM327 or UART?\n");
> > +                       elm327_uart_side_failure(elm);
> > +                       break;  
> 
> Can you have just a single break at the end of the case instead of
> having it in every branches of the if/else?

Agreed, the status quo is ugly. I'll look into it.


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
> > +       /* BHs are already disabled, so no spin_lock_bh().
> > +        * See Documentation/networking/netdevices.txt
> > +        */
> > +       spin_lock(&elm->lock);  
> 
> Do you need to hold the lock here? Isn't it possible to move this line
> after the next if so that you do not have to unclock in the error
> path?

It is possible.

Even better: I forgot to remove the elm->tty check as part of PATCHv4,
and elm->uart_side_failure cannot be unset while the netdev is up. So
we can push the locking way further down after any remaining checks :)


> > +               spin_unlock(&elm->lock);
> > +               goto out;
> > +       }
> > +
> > +       netif_stop_queue(dev);
> > +
> > +       elm327_send_frame(elm, frame);
> > +       spin_unlock(&elm->lock);
> > +
> > +       dev->stats.tx_packets++;
> > +       dev->stats.tx_bytes += frame->len;
> > +
> > +       can_led_event(dev, CAN_LED_EVENT_TX);
> > +
> > +out:  
> 
> The benefit of the goto label is to factorize code. If you have only
> one goto, you might as well prefer to remove the label and do the
> kfree_skb inside the if block.

But then I also have to duplicate the return... matter of taste :)


> > +       kfree_skb(skb);  
> 
> Maybe you want to increment dev->stats here?

This already happens above, but only in case the frame is actually
queued on the UART.


> > +       return NETDEV_TX_OK;
> > +}
> > +
> > +static const struct net_device_ops can327_netdev_ops = {
> > +       .ndo_open       = can327_netdev_open,
> > +       .ndo_stop       = can327_netdev_close,
> > +       .ndo_start_xmit = can327_netdev_start_xmit,
> > +       .ndo_change_mtu = can_change_mtu,
> > +};
> > +
> > +static bool can327_is_valid_rx_char(char c)
> > +{
> > +       return (isdigit(c) ||
> > +               isupper(c) ||
> > +               c == ELM327_DUMMY_CHAR ||
> > +               c == ELM327_READY_CHAR ||
> > +               c == '<' ||
> > +               c == 'a' ||
> > +               c == 'b' ||
> > +               c == 'v' ||
> > +               c == '.' ||
> > +               c == '?' ||
> > +               c == '\r' ||
> > +               c == ' ');  
> 
> Remark: if this function gets called a lot, you might what so create
> an lookup array and:
> 
> return c < sizeof(can327_is_valid_rx_char_lookup) &&
> can327_is_valid_rx_char_lookup[c];
> 
> This should be faster.

It does get called for every byte RX'd via UART. I'll have a look at
your LUT idea, it does sound good :)


> > +                       /* Check for stray characters on the UART
> > line.
> > +                        * Likely caused by bad hardware.
> > +                        */
> > +                       if (!can327_is_valid_rx_char(*cp)) {
> > +                               netdev_err(elm->dev,
> > +                                          "Received illegal
> > character %02x.\n",
> > +                                          *cp);  
> 
> Might make sense to put the netdev_err message inside
> can327_is_valid_rx_char().

Sorry, I prefer to keep can327_is_valid_rx_char() purely functional,
and the side effects in this function here. :)


> > +                               elm327_uart_side_failure(elm);
> > +
> > +                               goto out;
> > +                       }
> > +
> > +                       elm->rxbuf[elm->rxfill++] = *cp;
> > +               }
> > +
> > +               cp++;
> > +       }
> > +
> > +       if (count >= 0) {
> > +               netdev_err(elm->dev, "Receive buffer overflowed.
> > Bad chip or wiring?"); +
> > +               elm327_uart_side_failure(elm);
> > +
> > +               goto out;
> > +       }
> > +
> > +       elm327_parse_rxbuf(elm);
> > +
> > +out:
> > +       spin_unlock_bh(&elm->lock);  
> 
> If the out label has a single statement, can be better to just repalce
> all the goto out with spin_unlock_bh(&elm->lock);

It would be spin_unlock_bh() plus return...
Yeah, I guess it's easier to read.


> Question: did you try to send/receive DLC greater than 8? (c.f.
> CAN_CTRLMODE_CC_LEN8_DLC)

Yes, I have :)

It is entirely unsupported by the hardware:
 - On RX, DLC > 8 is reported as 8.
 - On TX, the DLC is constructed by the ELM327 depending on the
   payload, so DLC > 8 is impossible.



Thanks for your review!

Max
