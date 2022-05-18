Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE952C0C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbiERQYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbiERQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:24:13 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A4F1F1CAC;
        Wed, 18 May 2022 09:24:12 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id d137so4507936ybc.13;
        Wed, 18 May 2022 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhSiyOtTgaVAjZan+u734uFv0uo0oRV2yOrUrfVrqPI=;
        b=ftlbUEnn8IO7BNvrI7YTiIMgh3qQlAmfrLh0Fl+h5QRnIhLZOLq7WI9ET85EyJ1Cpa
         quiq3mVM0pSHuB73vN+hp9E0iwqTc8Q2gPAth7OPnjHd0nWoVzu2/cpWgfYb+y9Xs/CT
         13RjgC/epaBnZqz1vw+83XxJ43JzpRxDBh7Wc820RLUFcpiauU3G/zbmbdHJBS0XYuGe
         YdrUzvCJmONGzOoAceOEQ3o0w9C/91OfsbIcqp3tsCvmJmNJtnvrtazNsUrJ9CcA5AMc
         StCt/z6SFfAvZCsu2oVV40hbI9dAj+dtvfqAHg1ICepWLt8DobL36pOZDgdr6ytYwt1K
         Ahpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhSiyOtTgaVAjZan+u734uFv0uo0oRV2yOrUrfVrqPI=;
        b=s6u8bJXbbE9AIT+uo8RCnZ7xqwTEVArE3B4rVwKbrQsDkOP/VJSgWGAI8bpAHwIaN4
         NzbvtI/CekvZXY3UUgMXd5k7vtyxoG7H7xL0OdIs9kV7/k4AF19JQqJmIXuhyG74x0Ep
         1bCnVEiyyO4iE5KVtgGOTWSPoS977Si9ZwJ/vILWCFO2aR1/IFBNcJXXXyc0hohBsQmH
         3QBI2F9tkHHXDmsu/oU9n8TiN355qP2uD3HWAYHoDHXDI2jM2VCyMjYeiDsYkJ8CYxhx
         Q5aFySZsvfWk7B0pn4glOAX670MKapmgLmoKmJX595i19+tmW4HR+g75LjEXoqpDhR4L
         5BRA==
X-Gm-Message-State: AOAM531VG2viUzdvWTUUwoO1XMCICCjHWiW91NLxA+VyAgU+BJYJi+Fw
        FO8leC6k+1BQmK0PwXRsDcaxRWkrIYPGJVQOB1U=
X-Google-Smtp-Source: ABdhPJwpx4YSwofMVxD1GzkihxNpPcH9+j+L8tVg2vc3hhwdL2JpKktwokGCaMrXTskUVRl3/A/eAkWgAdBeGWzmuUI=
X-Received: by 2002:a25:3145:0:b0:64e:ac9a:eb27 with SMTP id
 x66-20020a253145000000b0064eac9aeb27mr401338ybx.630.1652891051851; Wed, 18
 May 2022 09:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220512182921.193462-1-max@enpas.org>
In-Reply-To: <20220512182921.193462-1-max@enpas.org>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 19 May 2022 01:24:00 +0900
Message-ID: <CAMZ6RqJqW+RuPOe6wYkAQh500BzVWnx9hcSAC3bvC7zYNYV-iw@mail.gmail.com>
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

Forgot one comment.

On Fri 13 May 2022 at 03:29, Max Staudt <max@enpas.org> wrote:
[...]
> +/* Send a can_frame to a TTY. */
> +static netdev_tx_t can327_netdev_start_xmit(struct sk_buff *skb,
> +                                           struct net_device *dev)
> +{
> +       struct can327 *elm = netdev_priv(dev);
> +       struct can_frame *frame = (struct can_frame *)skb->data;
> +
> +       if (can_dropped_invalid_skb(dev, skb))
> +               return NETDEV_TX_OK;
> +
> +       /* BHs are already disabled, so no spin_lock_bh().
> +        * See Documentation/networking/netdevices.txt
> +        */
> +       spin_lock(&elm->lock);
> +
> +       /* We shouldn't get here after a hardware fault:
> +        * can_bus_off() calls netif_carrier_off()
> +        */
> +       WARN_ON_ONCE(elm->uart_side_failure);
> +
> +       if (!elm->tty ||
> +           elm->uart_side_failure ||
> +           elm->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
> +               spin_unlock(&elm->lock);
> +               goto out;
> +       }
> +
> +       netif_stop_queue(dev);
> +
> +       elm327_send_frame(elm, frame);
> +       spin_unlock(&elm->lock);
> +
> +       dev->stats.tx_packets++;
> +       dev->stats.tx_bytes += frame->len;

Do not increase tx_bytes for RTR frame. c.f.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cc4b08c31b5c51352f258032cc65e884b3e61e6a

Also, when is the frame freed? Did you double check there is no race
condition resulting in a use after free on frame->len? Similar to:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=03f16c5075b22c8902d2af739969e878b0879c94

> +       can_led_event(dev, CAN_LED_EVENT_TX);

Please adjust according to Oliver's patch.

> +out:
> +       kfree_skb(skb);
> +       return NETDEV_TX_OK;
> +}
> +
> +static const struct net_device_ops can327_netdev_ops = {
> +       .ndo_open       = can327_netdev_open,
> +       .ndo_stop       = can327_netdev_close,
> +       .ndo_start_xmit = can327_netdev_start_xmit,
> +       .ndo_change_mtu = can_change_mtu,
> +};
[...]

Yours sincerely,
Vincent Mailhol
