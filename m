Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B80357C60A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiGUIRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiGUIR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:17:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92927E019
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:17:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u13so1598335lfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXTgtlqLJ4/ccGg/ZVcRqRwbk2jzjIpBAEnjuKYHOG8=;
        b=ECKSOnUYc5HaMnhSUPrnMRaZKeYAD7ValXquz6QlXsQRvt6pM3dc1Zh6iuvqMQqs1p
         vkficU6A26aKu3AISdyt/5LgUlepuAeYYShiP7XLRoKI4zCLuJHsAlBPu3unpyQeF/nL
         tHMzK4wJUtu4FbnPes5doM3OThzn7D/fceMjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXTgtlqLJ4/ccGg/ZVcRqRwbk2jzjIpBAEnjuKYHOG8=;
        b=0Xb+NtlFgipB2rHrAAmSb4krSeMM0Il0EoO7WezhoTCDc+54rTOL2rOOb/GTSgZjca
         1wm0ObMoT6QT3165eR4jhKVdxkfmih6Af+8O3inURwOHucP9kMNPZ0Y4MPvTJeBNoI26
         GNtgOjDy7k3G3OTIV98hB4Op6KErKDs7pdrrWRGSjy4G7Pt2PUSJkOu5HwxIXRerKydh
         DjnDhhQRP0MBFh2p4xaFNihbz3x/neb1gtbh07EwodoBBCMVEyz2IWiw6LAqYRQhszE9
         pj0ll/lLYtQFlkajc0AR9fMWdFw3TKFeeOuN/o0lMvY1MtbDyZjEGU0E8K4FjCv9Ffsp
         LV3g==
X-Gm-Message-State: AJIora/PwKM/+WRay1uBX3ZBCnoreCF8it1V+Y0+CAcQibPYJTAwaMwF
        eAlirh76j8C6ymoPqxisFY616eet1Ns1QKK3s/+13w==
X-Google-Smtp-Source: AGRyM1syTT0nDSlzBPl3yxxmAFp/qrDcpgxuTHgeAQieT1mLOMdlSf1rR2uu6j+2gJMs2n8OiBAmZwYrMBl4iqln7Ks=
X-Received: by 2002:a05:6512:32c1:b0:489:e9de:2f0 with SMTP id
 f1-20020a05651232c100b00489e9de02f0mr23244981lfg.117.1658391446244; Thu, 21
 Jul 2022 01:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220716170007.2020037-1-dario.binacchi@amarulasolutions.com>
 <20220716170007.2020037-6-dario.binacchi@amarulasolutions.com> <20220718102203.66y6glwwphptl2tu@pengutronix.de>
In-Reply-To: <20220718102203.66y6glwwphptl2tu@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Thu, 21 Jul 2022 10:17:15 +0200
Message-ID: <CABGWkvqxKBVa_pGhg-aThn76wz-rpiVAqgFNDT-HNd1_Bz7WXw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] can: slcan: send the listen-only command to the adapter
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

On Mon, Jul 18, 2022 at 12:22 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> The subject can be enhanced, as the listen-only command ist not send
> unconditionally. What about: "add support for listen-only mode"?

I like it.

>
> On 16.07.2022 19:00:07, Dario Binacchi wrote:
> > In case the bitrate has been set via ip tool, this patch changes the
> > driver to send the listen-only ("L\r") command to the adapter.
>
> ...but only of CAN_CTRLMODE_LISTENONLY is requested.
>
> What about:
>
> For non-legacy, i.e. ip based configuration, add support for listen-only
> mode. If listen-only is requested send a listen-only ("L\r") command
> instead of an open ("O\r") command to the adapter..

I agree with you. It's definitely clearer.

Thanks and regards,
Dario
>
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> >  drivers/net/can/slcan/slcan-core.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
> > index 7a1540507ecd..d97dfeccbf9c 100644
> > --- a/drivers/net/can/slcan/slcan-core.c
> > +++ b/drivers/net/can/slcan/slcan-core.c
> > @@ -711,10 +711,21 @@ static int slcan_netdev_open(struct net_device *dev)
> >                       }
> >               }
> >
> > -             err = slcan_transmit_cmd(sl, "O\r");
> > -             if (err) {
> > -                     netdev_err(dev, "failed to send open command 'O\\r'\n");
> > -                     goto cmd_transmit_failed;
> > +             /* listen-only command overrides open command */
>
> I think this comment can be removed.
>
> > +             if (sl->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
> > +                     err = slcan_transmit_cmd(sl, "L\r");
> > +                     if (err) {
> > +                             netdev_err(dev,
> > +                                        "failed to send listen-only command 'L\\r'\n");
> > +                             goto cmd_transmit_failed;
> > +                     }
> > +             } else {
> > +                     err = slcan_transmit_cmd(sl, "O\r");
> > +                     if (err) {
> > +                             netdev_err(dev,
> > +                                        "failed to send open command 'O\\r'\n");
> > +                             goto cmd_transmit_failed;
> > +                     }
> >               }
> >       }
> >
> > @@ -801,6 +812,7 @@ static int slcan_open(struct tty_struct *tty)
> >       /* Configure CAN metadata */
> >       sl->can.bitrate_const = slcan_bitrate_const;
> >       sl->can.bitrate_const_cnt = ARRAY_SIZE(slcan_bitrate_const);
> > +     sl->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY;
> >
> >       /* Configure netdev interface */
> >       sl->dev = dev;
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
