Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B294D3074
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiCINvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiCINvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:51:00 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F1D15040D;
        Wed,  9 Mar 2022 05:50:01 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x200so4458396ybe.6;
        Wed, 09 Mar 2022 05:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OrtQgExP6/KGNZe+vOK3wRMpwvlZoou7SgFiBOAfw8s=;
        b=QoT5mcZE5tMyNjKM/83OEXhrdq3PQK46qinahRYJ5Nt7bCWUZb07va0meMzUZ4GS9M
         6G/3skJ7A+DDiiqH8L78vSDBGFcIIp/lnZxyhGrTKGNp/bNiTsyCvut2LCcktTkfFpf9
         MCYMYk2HSOd/HzigmXL3yM+S0jFZw9Z1yAlUF+G17pXP0hE1Po23eo/M0O6TnRg3et5t
         ywzLOQ+jU1eSTm+iZ6gLOTzoRwmHrHI1DSg2i0K23mDbfufUFPvzthbgNF5gvgBDN56G
         rWh5XPbn/L7Qp6nC7efi1CKbVAD7Gl5nyoMGhc7gL1TA3AN1TCsppM8JJg9N2gidlAp6
         X20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OrtQgExP6/KGNZe+vOK3wRMpwvlZoou7SgFiBOAfw8s=;
        b=U4dvyFflc9kFcJcFtW9blEkQcuqVEYwX845yMCrR8UE7sYLuU5t4Xv86952sm4AV71
         +Ad+hkzDQbdz5cj4y/sFyLw8Dvw/iIQOI1wcQg3QYBf3Sc+lFZCThSGicOVkfMf2jZ0U
         rfvigmxHFUcnuhiJobt07W+HDJGdZHVKqqNITfiREDerzPgEVXihHfz4qWFBCCYHTFjp
         gIHKxg5OX2a3pPcawOBeAugemO4E+kWuIcpujh5IlhY9qzLq9znGqzb5LIV1By3NZnJU
         uDoX8M9YTPj1HiSlUfKGWJUID2ysX6nqSawF6/lWsvn88sXaJ7UcXw6T8hp0xRdlhFc+
         ruXQ==
X-Gm-Message-State: AOAM532fJMY6jhzecqgwXGXDlVgR8grIBe6GNfyTSmzJVEKdUtiqFjeI
        RtsSHS6p2GS65lRv00PHVsOMNUw3hLo7dGHqYKA=
X-Google-Smtp-Source: ABdhPJw69v6Zg6XPfiTCu+6z6/HscwUMgFfaB5ymMuufT2DApxnvYz/KwY0EjKUM3Z+q+nmjxH/Nis35H8yc/g1dhwI=
X-Received: by 2002:a25:4c3:0:b0:629:2692:5a46 with SMTP id
 186-20020a2504c3000000b0062926925a46mr13442909ybe.500.1646833800621; Wed, 09
 Mar 2022 05:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20220307214303.1822590-1-max@enpas.org> <CAMZ6RqJZObevKPc29jW+m6i0eAgestTbw8KCPXxSGHzSXK7cRg@mail.gmail.com>
 <20220309135414.34f77251.max@enpas.org>
In-Reply-To: <20220309135414.34f77251.max@enpas.org>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 9 Mar 2022 22:49:49 +0900
Message-ID: <CAMZ6RqJJ-PO=WeFeuXk4iC9GHLXz_ZMWtsVCm6sGVGbmeE5U1Q@mail.gmail.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 9 Mar 2022 at 21:54, Max Staudt <max@enpas.org> wrote:
> Thanks a lot Vincent for your review!
>
> Most points are self explanatory, for the others I've added replies
> below.
>
>
>
> On Tue, 8 Mar 2022 16:01:12 +0900
> Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
>
> > Hi Max, this is a partial review.
> >
> > > +/* Bits in elm->cmds_todo */
> > > +enum ELM_TODO {
> > > +       TODO_CAN_DATA =3D 0,
> > > +       TODO_CANID_11BIT,
> > > +       TODO_CANID_29BIT_LOW,
> > > +       TODO_CANID_29BIT_HIGH,
> > > +       TODO_CAN_CONFIG_PART2,
> > > +       TODO_CAN_CONFIG,
> > > +       TODO_RESPONSES,
> > > +       TODO_SILENT_MONITOR,
> > > +       TODO_INIT
> >
> > Nitpick but the TODO name is bugging me. What does this acronym mean?
> > Is it possible to change this so it doesn't look like a FIXME tag?
>
> Good point, I'll change it.
>
> It's an ordered list of things to send next to the adapter.

Then TX_QUEUE or TX_FIFO sounds like a better name then.

> For
> example, whenever the sending CAN ID needs to be changed, the relevant
> TODO_* bits are set, and the new CAN ID is sent down the UART before a
> payload (*_DATA) is ever sent.
>

Also, prefix the enum entries with your module name.
e.g. ELM327_

>
> > > +       frame.can_id =3D CAN_ERR_FLAG;
> > > +       frame.can_dlc =3D CAN_ERR_DLC;
> > > +       frame.data[5] =3D 'R';
> > > +       frame.data[6] =3D 'I';
> > > +       frame.data[7] =3D 'P';
> > > +       elm327_feed_frame_to_netdev(elm, &frame);
> >
> > There is a framework to notify a bus off. Refer to:
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/etas=
_es58x/es58x_core.c#L815
>
> Thanks, will do.
>
>
> > > +/* Compare a buffer to a fixed string */
> > > +static inline int _memstrcmp(const u8 *mem, const char *str)
> > > +{
> > > +       return memcmp(mem, str, strlen(str));
> >
> > strcpy()?

I think you got it but I meant strcmp()=E2=80=A6

> > Did you check for buffer overflow?
>
> There is no buffer overflow, as this only ever takes string constants
> as *str. The compiler figures out the strlen() and can generate an
> optimised memcmp() for this given string length.

Are you sure that the compiler does not already produce optimized
code for strcmp()? Did you check the assembly output?

> It's the caller's job to ensure that *mem is large enough.
>
>
> > > +
> > > +       /* Use spaces in CAN ID to distinguish 29 or 11 bit address
> > > length.
> > > +        * No out-of-bounds access:
> > > +        * We use the fact that we can always read from elm->rxbuf.
> > > +        */
> > > +       if (elm->rxbuf[2] =3D=3D ' ' && elm->rxbuf[5] =3D=3D ' ' &&
> > > +           elm->rxbuf[8] =3D=3D ' ' && elm->rxbuf[11] =3D=3D ' ' &&
> > > +           elm->rxbuf[13] =3D=3D ' ') {
> >
> > Define an inline function elm327_is_eff().
>
> It would only be used this one time, so I don't see the utility? It'd
> just make it harder to read, IMHO.
>
> It's ASCII lexer/parser code, so it's bound to be ugly... :(

That comment was a nitpick, and it is about colors and taste. So
I won't insist more.

>
> > > +       /* Read CAN ID */
> > > +       if (frame.can_id & CAN_EFF_FLAG) {
> > > +               frame.can_id |=3D (hex_to_bin(elm->rxbuf[0]) << 28)
> > > +                             | (hex_to_bin(elm->rxbuf[1]) << 24)
> > > +                             | (hex_to_bin(elm->rxbuf[3]) << 20)
> > > +                             | (hex_to_bin(elm->rxbuf[4]) << 16)
> > > +                             | (hex_to_bin(elm->rxbuf[6]) << 12)
> > > +                             | (hex_to_bin(elm->rxbuf[7]) << 8)
> > > +                             | (hex_to_bin(elm->rxbuf[9]) << 4)
> > > +                             | (hex_to_bin(elm->rxbuf[10]) << 0);
> > > +       } else {
> > > +               frame.can_id |=3D (hex_to_bin(elm->rxbuf[0]) << 8)
> > > +                             | (hex_to_bin(elm->rxbuf[1]) << 4)
> > > +                             | (hex_to_bin(elm->rxbuf[2]) << 0);
> >
> > hex2bin()?
>
> Good idea!
>
>
> > > +       /* Parse the data nibbles. */
> > > +       for (i =3D 0; i < frame.can_dlc; i++) {
> >
> > frame.can_dlc is deprecated. Use frame.len instead.
>
> Thanks!
>
>
> [ ... snip self explanatory stuff ... ]
>
>
> > > +       case ELM_RECEIVING:
> > > +               /* Find <CR> delimiting feedback lines. */
> > > +               for (len =3D 0;
> > > +                    (len < elm->rxfill) && (elm->rxbuf[len] !=3D
> > > '\r');
> >
> > Did you use ./script/checkpath?
>
> checkpatch? Yes I did (and kudos to whoever wrote it).
>
> Why?

Because I thought that checkpath would have spotted some
unnecessary parentheses... But I was wrong.

For reference, if put in an "if" statement, you would have got this output:

CHECK: Unnecessary parentheses around 'len < elm->rxfill'
+    if ((len < elm->rxfill) && (elm->rxbuf[len] !=3D '\r')) {

I was expecting the for loop to yield the same.

>
> > > +/* Dummy needed to use can_rx_offload */
> > > +static struct sk_buff *elmcan_mailbox_read(struct can_rx_offload
> > > *offload,
> > > +                                          unsigned int n, u32
> > > *timestamp,
> > > +                                          bool drop)
> > > +{
> > > +       WARN_ON_ONCE(1); /* This function is a dummy, so don't call
> > > it! */ +
> > > +       return ERR_PTR(-ENOBUFS);
> > > +}
> >
> > Could you elaborate on why you need can_rx_offload if the mailbox
> > feature is not needed?
>
> The code previously used netif_rx_ni(), and Marc noted that it may
> reorder packets. To avoid that, he suggested rx_offload:
>
>   Message-ID: 88c08b2c-aa4a-8858-6267-deeeac2796df@pengutronix.de
>
>   https://www.spinics.net/lists/linux-can/msg01859.html
>
>
> But rx_offload needs the mailbox_read function, even if it's a dummy,
> because can_rx_offload_add_fifo() checks:
>
>         if (!offload->mailbox_read)
>                 return -EINVAL;

I think that there should not be a dummy functions like this one.

Either we agree that using can_rx_offload without implementing
the mailbox_read() is OK and in that case, the can_rx_offload
framework should be modified to allow mailbox_read() to be a NULL
pointer.

Either it is not the case and you use the more classic
netif_rx().

And I do not have the answer. I haven't studied can_rx_offload
enough to be a judge here. Sorry.

@Marc, any thoughts?

>
> > > +/* Send a can_frame to a TTY. */
> > > +static netdev_tx_t elmcan_netdev_start_xmit(struct sk_buff *skb,
> > > +                                           struct net_device *dev)
> > > +{
> > > +       struct elmcan *elm =3D netdev_priv(dev);
> > > +       struct can_frame *frame =3D (struct can_frame *)skb->data;
> > > +
> > > +       if (skb->len !=3D sizeof(struct can_frame))
> > > +               goto out;
> >
> > Isn=E2=80=99t this aleardy guaranteed by the upper layers?
>
> Copy-pasta from slcan.c - will look into it.

Also give a look at can_dropped_invalid_skb().

>
> > > +       if (!netif_running(dev))  {
> > > +               netdev_warn(elm->dev, "xmit: iface is down.\n");
> > > +               goto out;
> > > +       }
> >
> > Even if this check succeeds, interface might still go down at the
> > next cycle. What is the purpose of checking if interface is up here?
>
> No purpose. It's copy-pasta from slip.c via slcan.c.
