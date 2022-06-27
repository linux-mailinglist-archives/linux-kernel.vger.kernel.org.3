Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AF155D72C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiF0Ikn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiF0Ikk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:40:40 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A695C6313;
        Mon, 27 Jun 2022 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1656319239; x=1687855239;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=on5GEhLSPeEeD9pSzUDQAdj9+heGus4n4IvHxRiN4uY=;
  b=LYM2UCauaneLqacW0SkJgmWmDE2//VI/HJgrQph3iSnn3Z7kTqiOacNP
   zvmR9ngsSpNOcHw0AN7YAl3ONFp1JeXD0pc3zRuhNDWgbGShiP/uhiYZS
   wlonfLFTtvWw1rY/n6DVFeNvw7pV5CtHS8OPtPb8h9QIDdhIikarea318
   AOujv4T+8VLHA1Po+6NrQ3oVWsOtedRQZs0OhfMRL2oXZgfS6MyIpi6jz
   zgUuRlV4BT9/BYUSi+z5w12IhscUbZoy1wNJlE+MygI+t+zrQdGuPZOrf
   l0KdY9DHYov5uYbeVMWClpUORp9AAelV07mAbgb0dR1av1HaI5h0jzaIb
   A==;
X-IronPort-AV: E=Sophos;i="5.92,225,1650924000"; 
   d="scan'208";a="24684535"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Jun 2022 10:40:37 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 27 Jun 2022 10:40:37 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 27 Jun 2022 10:40:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1656319237; x=1687855237;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=on5GEhLSPeEeD9pSzUDQAdj9+heGus4n4IvHxRiN4uY=;
  b=J99YHCqquxpSQIft96YfqKlT+t47roCs6Y8+ueodnrqNVq43cMdjZc/g
   6OhVSXdZ+N95rZ7B9CRq1R42ocIZu0xmsAlHLhxtphRTPwpu5j0e4OK/+
   QL1a+Unq3J7+TcgoQWY1KQ6rfoPiQ4sayRMIMQoHVNoBIvFMs5T6xHHdB
   OdxmmuhNeWt5jTCBXKBSvwtxUQCTEW1oUq8MBOMYa2h7j3Cu8hk1QaSOV
   dLNcSQNWmievEqBdpmCgKNEkQEhwVRcwwEqRkU5SSDAZySjqNYaRRHWVo
   Qnt1w8WVtQFINZPzuvGBPvpCcvHs5j1h+Szcu7pF6bKncIaCJy8bFzHD/
   A==;
X-IronPort-AV: E=Sophos;i="5.92,225,1650924000"; 
   d="scan'208";a="24684534"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Jun 2022 10:40:37 +0200
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.49.136])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id D0194280071;
        Mon, 27 Jun 2022 10:40:36 +0200 (CEST)
Message-ID: <383f5d66d6828a5f09f5705f6ff98e3727ecfdf2.camel@ew.tq-group.com>
Subject: Re: [PATCH] serial: Revert RS485 polarity change on UART open
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Date:   Mon, 27 Jun 2022 10:40:36 +0200
In-Reply-To: <b2f29129f966685105e09781620b85c8f4f1a88e.camel@ew.tq-group.com>
References: <20220329085050.311408-1-matthias.schiffer@ew.tq-group.com>
         <20220329100328.GA2090@wunner.de>
         <b2f29129f966685105e09781620b85c8f4f1a88e.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-29 at 12:39 +0200, Matthias Schiffer wrote:
> On Tue, 2022-03-29 at 12:03 +0200, Lukas Wunner wrote:
> > [cc += Ilpo, Lino]
> > 
> > On Tue, Mar 29, 2022 at 10:50:50AM +0200, Matthias Schiffer wrote:
> > > While the change of the RS485 polarity in
> > > commit d3b3404df318 ("serial: Fix incorrect rs485 polarity on uart
> > > open")
> > > might have made sense based on the original intention of the
> > > rs485-rts-active-low flag (*), this is not how it is implemented in
> > > various drivers:
> > [...]
> > > [(*) My understanding of the mentioned commit's description is that
> > > rs485-rts-active-low should have referred to the electical signal
> > > level
> > > of the RTS pin, rather than the logical RTS state as understood by
> > > the
> > > UART controller.]
> 
> Hi Lukas,
> 
> > Since RTS is often just a GPIO on a pin controller that's configured
> > to function as RTS, my expectation would be that the same rules apply
> > to RTS polarity as those that apply to *any* GPIO.
> > 
> > According to Documentation/devicetree/bindings/gpio/gpio.txt:
> > 
> > "A gpio-specifier should contain a flag indicating the GPIO polarity;
> > active-
> >  high or active-low. If it does, the following best practices should
> > be
> >  followed:
> >  The gpio-specifier's polarity flag should represent the physical
> > level at the
> >                                                          ^^^^^^^^^^^^
> > ^^
> >  GPIO controller that achieves (or represents, for inputs) a
> > logically asserted
> >  value at the device."
> 
> Yes, that would make sense to me as well, but as described, this is not
> how the majority of drivers that I looked at works at the moment :(
> 
> I'm not particularly attached to any of the interpretations, but it
> would be great to have some consistency here. And if the majority of
> drivers does it the "wrong" way, maybe we should accept that to keep
> the breakage as small as possible?
> 
> > 
> > > At least the 8250 and the i.MX UART drivers interpret rs485-rts-
> > > active-low
> > 
> > Which 8250 driver are you referring to specifically?  When developing
> > d3b3404df318, I tested with 8250_bcm2835aux.c and amba-pl011.c.  Both
> > worked exactly the way they should.
> 
> I tested with 8250_omap.c, which does not implement the RS485 handling
> itself, but refers to the generic code in 8250_port.c. In fact, my
> first attempt to get the RS485 to work on my device was the following
> (which matches the originally intended interpretation of the polarity
> flag, but breaks existing users):
> 
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1460,9 +1460,9 @@ void serial8250_em485_stop_tx(struct
> uart_8250_port *p)
>         unsigned char mcr = serial8250_in_MCR(p);
>  
>         if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
> -               mcr |= UART_MCR_RTS;
> -       else
>                 mcr &= ~UART_MCR_RTS;
> +       else
> +               mcr |= UART_MCR_RTS;
>         serial8250_out_MCR(p, mcr);
>  
>         /*
> @@ -1611,9 +1611,9 @@ void serial8250_em485_start_tx(struct
> uart_8250_port *up)
>                 serial8250_stop_rx(&up->port);
>  
>         if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
> -               mcr |= UART_MCR_RTS;
> -       else
>                 mcr &= ~UART_MCR_RTS;
> +       else
> +               mcr |= UART_MCR_RTS;
>         serial8250_out_MCR(up, mcr);
>  }
> 
> > If imx.c and others have historically interpreted rs485-rts-active-
> > low
> > to mean that the physical level is "high" when active, then we could
> > just
> > amend imx_uart_probe() such that after calling uart_get_rs485_mode(),
> > the SER_RS485_RTS_ON_SEND and SER_RS485_RTS_AFTER_SEND bits are
> > flipped.  Would that work for you?
> > 
> 
> I guess that would work. The fact that even the different
> variants of the 8250 are implemented inconsistently makes this
> especially ugly... It certainly puts a damper on the efforts to make
> the handling of RS485 in serial drivers more generic.
> 
> 
> > I'll go through the drivers to check which ones are affected.  I'm
> > sorry
> > that you're seeing breakage, it's surprising to me that these
> > different
> > interpretations of rs485-rts-active-low exist.
> > Thanks,
> > 
> > Lukas
> 

Hi Lukas,

do you know if there has been any progress on this issue? I see that
there has been quite a bit of activity in the RS485 code in linux-next, 
but I didn't have time to check if that has any effect on the polarity
issue so far.

Thanks,
Matthias

