Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C1752C048
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbiERQcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbiERQcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:32:13 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14429AFAFE;
        Wed, 18 May 2022 09:32:10 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id d137so4547820ybc.13;
        Wed, 18 May 2022 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uayVpCC1eBrYAegb3COrd5jXgXqO970SEpGm9TSisnQ=;
        b=OL6XdaoriVped5yCN9aw3PcvVWLudDFf6W8HhuDr6Qp8wD1XkYnyDnceZKHcwp1uLU
         O0TgDqRINtHpSITcW32PN8LboZx2GJSqQeQASUcf4dld37DDvDBW1CiTYX4RQYxIJvwm
         FVFtIsyMBjdce1w/xuhDONhikNOfNgbOr3GHGktIl1NfYXgnbpKVy265kiZxEsW2qVEk
         Wwxe8TM/LSJRAjXYJDyIux8XOBUmwUih+frd5Iq07dIcD1z0EdW1bHhloQrgXtjBTps1
         Fprs2rOXkomu3fetYc4l4EnWwQXYwB1o1vVW0px+H2wIYS1ta66TtDSXm5kb+EOKAnvw
         aJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uayVpCC1eBrYAegb3COrd5jXgXqO970SEpGm9TSisnQ=;
        b=44S20JcZq+KiTmbYTdOWhCw5dPKkObrRgZr6VZD4BrkLEiwPNlq3tu2TZO8mIqc7BA
         SOfnhFc0t+QnTNdsWPzfTXa7+tg92a9H7REXbxq1cIcydQtPkY9WIGWPFUKyzukjBfly
         NmrPM2RxYsqS2AuncnhWv0Qmzr+kRyCNVrk9PqPciqh7SqTAcYqLHHCuWBS1B1exoU2O
         7ZMMpqHfkq9HUzWzSZ3A0/8uLAoNNzhDJirOckZYAN4jVDdg6cwogUMIl61uGLSDr5Oa
         jgbxAQL0oW2XzW8cNrfosQDtNGfdsfwLfaOo0ta9050IVtDALmMYPCxiIaP3yJ5s26f8
         hUaw==
X-Gm-Message-State: AOAM532Rm4JnfniQlG1UPI2R9m02xx6QpQZsXWYzptD23ZnRFtBCEvCJ
        gfRTObsdGFnAtu2sRMZ/2qZ+i4ffbXxaQqKfkvk=
X-Google-Smtp-Source: ABdhPJzUp6xpKisfhOxd9uQJGz88DPeNGapWqgTtrNqFkZdWFQHKK66l2ec8Tt56Ai/jEVMzyFzRwz4EAekJKLlFhBM=
X-Received: by 2002:a25:e093:0:b0:64d:6c85:6bc6 with SMTP id
 x141-20020a25e093000000b0064d6c856bc6mr433101ybg.500.1652891530181; Wed, 18
 May 2022 09:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220512182921.193462-1-max@enpas.org> <CAMZ6RqJqW+RuPOe6wYkAQh500BzVWnx9hcSAC3bvC7zYNYV-iw@mail.gmail.com>
In-Reply-To: <CAMZ6RqJqW+RuPOe6wYkAQh500BzVWnx9hcSAC3bvC7zYNYV-iw@mail.gmail.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 19 May 2022 01:31:59 +0900
Message-ID: <CAMZ6RqJwitvx26K_5+_mtbiBfUD8q5oaWcWo-a-GTouUG+uc0g@mail.gmail.com>
Subject: Re: [PATCH v6] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu. 19 May 2022 at 01:24, Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
> Forgot one comment.
>
> On Fri 13 May 2022 at 03:29, Max Staudt <max@enpas.org> wrote:
> [...]
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
> > +
> > +       /* We shouldn't get here after a hardware fault:
> > +        * can_bus_off() calls netif_carrier_off()
> > +        */
> > +       WARN_ON_ONCE(elm->uart_side_failure);
> > +
> > +       if (!elm->tty ||
> > +           elm->uart_side_failure ||
> > +           elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
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
>
> Do not increase tx_bytes for RTR frame. c.f.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cc4b08c31b5c51352f258032cc65e884b3e61e6a
>
> Also, when is the frame freed? Did you double check there is no race
> condition resulting in a use after free on frame->len? Similar to:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=03f16c5075b22c8902d2af739969e878b0879c94

Never mind, the free is just two lines below inside the out label.
Sorry for the noise.

> > +       can_led_event(dev, CAN_LED_EVENT_TX);
>
> Please adjust according to Oliver's patch.
>
> > +out:
> > +       kfree_skb(skb);
> > +       return NETDEV_TX_OK;
> > +}
> > +
> > +static const struct net_device_ops can327_netdev_ops = {
> > +       .ndo_open       = can327_netdev_open,
> > +       .ndo_stop       = can327_netdev_close,
> > +       .ndo_start_xmit = can327_netdev_start_xmit,
> > +       .ndo_change_mtu = can_change_mtu,
> > +};
> [...]
>
> Yours sincerely,
> Vincent Mailhol
