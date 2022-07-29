Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF26584C25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiG2GwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiG2GwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:52:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E90780509
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:52:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t17so6082561lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YdU07mGqFiuXuE6icp9hQwa4CmEM4aos/lBcDu+paA=;
        b=QyDv8RosvYisZ/L4YmozirAZZzmYZDY7TdGbixAgsSXGAEMlhYwhGViZucM5617Bwq
         fV3a4JWt23Iqm6dsVPBvn57Fjg+sTE8QK2DbulGxGwtopIFcrEzaPOs4gSAXH+BvB19R
         pQ/GZ878jdpwEKUB73n8wDCE4ozGeyUH3DzuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YdU07mGqFiuXuE6icp9hQwa4CmEM4aos/lBcDu+paA=;
        b=HI7PByZiujQ2o1h02CN+0QI87Xc2FfsMM/UtaEhUx49FYeSfoOBILT3/FSS12ErDBS
         XKg/VJg9TUh/OLvIpdEIuwFet5xcBtG9rk1F2FU2ni2YZCjx6f68KV/Qjnxvy+I7Q8ki
         726o/4yJtYNGdaNSC+e51yujHKSFKZ8dNB1fg4S8ZKrxgyepK7D9QocWd6dJZfI1+VNu
         bOdiEzSIuebEbaqT1yijzaY2V66jupmnY/QSskW5eWTu2J51ARCKvb2u9cx0U36FnQH5
         ZbgZHU0X6o51fIsZXYrt/HnopZIujxWpogbmAabJc3/4pWSVPUakb66d6W+fvjajk4Vb
         iOPQ==
X-Gm-Message-State: AJIora8S4BFv20rbzU4tK0pG/7M/Vnsaw6DsEaKI8CeSOe1YG3FheIaa
        6DUmPQzuix+BMHnSpXa8cXDgWJ6jgbolpgZ/aB9zJg==
X-Google-Smtp-Source: AGRyM1v+s6pbBabOtiq58q1rla6DcPiUzx1gexOuNWFWqJUbkqKm3CrTbCCRfCQTPYH+YpUhrxOvPPpTILQIGJdJmpU=
X-Received: by 2002:a05:6512:2811:b0:48a:d1e1:12d2 with SMTP id
 cf17-20020a056512281100b0048ad1e112d2mr781330lfb.153.1659077538787; Thu, 28
 Jul 2022 23:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220726210217.3368497-1-dario.binacchi@amarulasolutions.com>
 <20220726210217.3368497-9-dario.binacchi@amarulasolutions.com>
 <20220727113054.ffcckzlcipcxer2c@pengutronix.de> <20220727192839.707a3453.max@enpas.org>
 <20220727182414.3mysdeam7mtnqyfx@pengutronix.de> <CABGWkvoE8i--g_2cNU6ToAfZk9WE6uK-nLcWy7J89hU6RidLWw@mail.gmail.com>
 <20220728090228.nckgpmfe7rpnfcyr@pengutronix.de> <CABGWkvoYR67MMmqZ6bRLuL3szhVb-gMwuAy6Z4YMkaG0yw6Sdg@mail.gmail.com>
 <20220728105049.43gbjuctezxzmm4j@pengutronix.de> <20220728125734.1c380d25.max@enpas.org>
In-Reply-To: <20220728125734.1c380d25.max@enpas.org>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Fri, 29 Jul 2022 08:52:07 +0200
Message-ID: <CABGWkvo0B8XM+5qLhz3zY2DzyUrEQtQyJnd91VweUWDUcjyr5A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 8/9] can: slcan: add support to set bit time
 register (btr)
To:     Max Staudt <max@enpas.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>, netdev@vger.kernel.org
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

Hello Marc and Max,

On Thu, Jul 28, 2022 at 12:57 PM Max Staudt <max@enpas.org> wrote:
>
> On Thu, 28 Jul 2022 12:50:49 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> > On 28.07.2022 12:23:04, Dario Binacchi wrote:
> > > > > Does it make sense to use the device tree
> > > >
> > > > The driver doesn't support DT and DT only works for static serial
> > > > interfaces.
> >
> > Have you seen my remarks about Device Tree?
>
> Dario, there seems to be a misunderstanding about the Device Tree.
>
> It is used *only* for hardware that is permanently attached, present at
> boot, and forever after. Not for dyamically added stuff, and definitely
> not for ldiscs that have to be attached manually by the user.
>
>
> The only exception to this is if you have an embedded device with an
> slcan adapter permanently attached to one of its UARTs. Then you can
> use the serdev ldisc adapter to attach the ldisc automatically at boot.

It is evident that I am lacking some skills (I will try to fix it :)).
I think it is
equally clear that it is not worth going down this path.

>
> If you are actively developing for such a use case, please let us know,
> so we know what you're after and can help you better :)
>

I don't have a use case, other than to try, if possible, to make the driver
autonomous from slcand / slcan_attach for the CAN bus setup.

Returning to Marc's previous analysis:
"... Some USB CAN drivers query the bit timing const from the USB device."

Can we think of taking the gs_usb driver as inspiration for getting/setting the
bit timings?

https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/gs_usb.c#L951
https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/gs_usb.c#L510

and, as done with patches:

can: slcan: extend the protocol with CAN state info
can: slcan: extend the protocol with error info

further extend the protocol to get/set the bit timing from / to the adapter ?
In the case of non-standard bit rates, the driver would try, depending on the
firmware of the adapter, to calculate and set the bit timings autonomously.

Thanks and regards,
Dario

>
> Max



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
