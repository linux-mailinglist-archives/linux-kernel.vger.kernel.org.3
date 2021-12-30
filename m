Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E72481C06
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbhL3M1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:27:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43472 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239191AbhL3M1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:27:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9580A616AB;
        Thu, 30 Dec 2021 12:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B54C36AEA;
        Thu, 30 Dec 2021 12:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640867230;
        bh=jtRDTNUABNjxRYAFcGzm5lwPyIQ9Sfjf1gd358LMomE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w5t0JwdJUbRUNni+Y/Ko4RuRl4SknYmbIq0b+hxBe6zqYWCNmCddSRML+b6x0cGWN
         bYXduHtQc7KlYFW74rgjSU0/fw0Iv8Cs6nXwdA/A4SUe6qz9FCE/w/tDrwJIfFN494
         CC5GtbM5p5//HMU7+jQbWZlKSShxJfQ9/4A2ZcIE=
Date:   Thu, 30 Dec 2021 13:27:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 03/10] serial: 8250_bcm7271: Propagate error codes from
 brcmuart_probe()
Message-ID: <Yc2lmzJgn/nEbC5r@kroah.com>
References: <20211224142917.6966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224142917.6966-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VdC+JifneoYRS3yoXoAhio+TXQzca3pku7ug=A_ewWrsg@mail.gmail.com>
 <CA+V-a8tzcCtnD9GDm8g+-84tKAdcPaj3Qy0s=vJmn5qMxLp=3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8tzcCtnD9GDm8g+-84tKAdcPaj3Qy0s=vJmn5qMxLp=3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 12:20:02PM +0000, Lad, Prabhakar wrote:
> Hi Andy,
> 
> Thank you for the review.
> 
> On Sat, Dec 25, 2021 at 11:20 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> >
> >
> > On Friday, December 24, 2021, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >>
> >> In case of failures brcmuart_probe() always returned -ENODEV, this
> >> isn't correct for example platform_get_irq_byname() may return
> >> -EPROBE_DEFER to handle such cases propagate error codes in
> >> brcmuart_probe() in case of failures.
> >>
> >> Fixes: 41a469482de25 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
> >> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >> ---
> >>  drivers/tty/serial/8250/8250_bcm7271.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
> >> index 7ecfcc650d28..cc60a7874e8b 100644
> >> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> >> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> >> @@ -1074,14 +1074,18 @@ static int brcmuart_probe(struct platform_device *pdev)
> >>                 priv->rx_bufs = dma_alloc_coherent(dev,
> >>                                                    priv->rx_size,
> >>                                                    &priv->rx_addr, GFP_KERNEL);
> >> -               if (!priv->rx_bufs)
> >> +               if (!priv->rx_bufs) {
> >> +                       ret = -EINVAL;
> >
> >
> >
> > For memory allocation we usually return -ENOMEM.
> >
> Agreed, will fix that.

Just send a follow-on patch for that, thanks.

greg k-h
