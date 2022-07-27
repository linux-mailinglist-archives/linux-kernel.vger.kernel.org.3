Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8B582A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiG0Pz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiG0PzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:55:25 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93574BC8E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:55:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id p22so10491451lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PDTQ/RetiQxlbrzdC/imK9gPXTNVvINSs59kGAbwqGA=;
        b=hty/Yt/Hyu+c6keBAAiJoeEScAVrdl5lEZUVOyAcZs3U05jftsT/6KIrtVxTBoheWd
         Vp0uy3qOoIjFeXi/OXvpiHtJ6gjOq7f9Sx2ELlFrvgXjc8XtFm5COtYpTqCQEA6SJlRw
         8Aqjx3X/X9FVm0cF1QeCzGAa1wan2VdtjUTGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDTQ/RetiQxlbrzdC/imK9gPXTNVvINSs59kGAbwqGA=;
        b=Uc6+rJOEj0TVB2dKXfqio4KnLx8/tfWhuwUkBp6e+BZi8+6cNFcEQmf/blJDOQ/u7o
         IFk0yg5QuBRUe1HxbPziztNIEWab8qyB8uzHAs2xt1OEicfjGbEF+otL9qDi8SZFvYeI
         gErhmId5m79bAb94WGbP2NrcA5SscyWCkXTsxsILdmXlGnojZVBWcEdv7PuLt+Mb1Jfm
         mLIzasnJ/cntDS8ws8nyBoBqL9uMa/AXtxTr9TNXMV1S+hphLNguWzDdss/6ewWpNBt3
         pI4fUzv3olw3TS/0BH4VTwT+rva0Itb67GdyzoQ7+HE5y2Fmwymq6ZdmSrXQJd3K2Lq/
         cyCA==
X-Gm-Message-State: AJIora9JqQWbyFnEIqsNlakv7Qus/Wo3monxPvVzLs8ZmXZSbfKNSX5L
        LpkS2RDXvVfk5LXjCRmhoCoS9AMfLFKoPh36/xxjNA==
X-Google-Smtp-Source: AGRyM1ucm+uRRXzwVzVwdaFYHGcn8TvNPfNzyYXzc6R+fFlfR+szaSzVATcLy/6WiziVDqVKxpAFa44tdcg1HxtF1X0=
X-Received: by 2002:a05:651c:907:b0:25e:1db5:fc5d with SMTP id
 e7-20020a05651c090700b0025e1db5fc5dmr2577617ljq.237.1658937321931; Wed, 27
 Jul 2022 08:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220726210217.3368497-1-dario.binacchi@amarulasolutions.com>
 <20220726210217.3368497-9-dario.binacchi@amarulasolutions.com> <20220727113054.ffcckzlcipcxer2c@pengutronix.de>
In-Reply-To: <20220727113054.ffcckzlcipcxer2c@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 27 Jul 2022 17:55:10 +0200
Message-ID: <CABGWkvrmbQcCHdZ_ANb+_196d9HsAxAHc4QS94R19v5STHcbiA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 8/9] can: slcan: add support to set bit time
 register (btr)
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        netdev@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Max Staudt <max@enpas.org>
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

On Wed, Jul 27, 2022 at 1:31 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 26.07.2022 23:02:16, Dario Binacchi wrote:
> > It allows to set the bit time register with tunable values.
> > The setting can only be changed if the interface is down:
> >
> > ip link set dev can0 down
> > ethtool --set-tunable can0 can-btr 0x31c
> > ip link set dev can0 up
>
> As far as I understand, setting the btr is an alternative way to set the
> bitrate, right?

I thought of a non-standard bitrate or, in addition to the bitrate, the
possibility of enabling some specific CAN controller options. Maybe Oliver
could help us come up with the right answer.

This is the the slcan source code:
https://github.com/linux-can/can-utils/blob/cad1cecf1ca19277b5f5db39f8ef6f8ae426191d/slcand.c#L331
btr case cames after speed but they don't seem to be considered alternative.

> I don't like the idea of poking arbitrary values into a
> hardware from user space.

However this is already possible through the slcand and slcan_attach
applications.
Furthermore, the driver implements the LAWICEL ASCII protocol for CAN
frame transport over serial lines,
and this is one of the supported commands.

>
> Do you have a use case for this?

I use the applications slcand and slcan_attach as a reference, I try to make the
driver independent from them for what concerns the CAN setup. And the bit time
register setting is the last dependency.

Thanks and regards,
Dario

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
