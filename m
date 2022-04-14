Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0428501758
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356413AbiDNP24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346530AbiDNN52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:57:28 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B68695F8F0;
        Thu, 14 Apr 2022 06:47:18 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9933A92009C; Thu, 14 Apr 2022 15:47:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9485992009B;
        Thu, 14 Apr 2022 14:47:17 +0100 (BST)
Date:   Thu, 14 Apr 2022 14:47:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PING][PATCH v3 0/2] serial: 8250: Fixes for Oxford Semiconductor
 950 UARTs
In-Reply-To: <CAHp75VdOf3+j8yQh=-f6iCN_gRhisgoQjov2kK1fhgv7xaBJRg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2204141421190.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203310114210.44113@angie.orcam.me.uk> <alpine.DEB.2.21.2204132103190.9383@angie.orcam.me.uk> <CAHp75VdOf3+j8yQh=-f6iCN_gRhisgoQjov2kK1fhgv7xaBJRg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022, Andy Shevchenko wrote:

> > >  Here's v3 of the outstanding fixes for Oxford Semiconductor 950 UARTs.
> > > As the change for the default FIFO rx trigger level has been already
> > > merged with commit d7aff291d069 ("serial: 8250: Define RX trigger levels
> > > for OxSemi 950 devices") only one patch of the original series remains.
> >
> >  Ping for:
> > <https://lore.kernel.org/lkml/alpine.DEB.2.21.2203310114210.44113@angie.orcam.me.uk/>
> 
> I still didn't get the answer why BOTHER can't be used instead of
> spreading the old hack.

 I just fail to see any sense in repeating myself over and over.

> You mentioned fractional baud rates and
> something else, and I asked why do you need them and from where you
> got the limitation of 16-bit values for dividers when using BOTHER.

 Sigh, I have documented it there with the original submission 10 months 
ago and then repeated with every reiteration:

>  Finally the 16-bit UART_DIV_MAX limitation of the baud rate requested
> with `serial8250_get_baud_rate' makes the standard rates of 200bps and
> lower inaccessible in the regular way with the baud base of 15625000.
> That could be avoided by tweaking our 8250 driver core appropriately, but
> I have figured out with modern serial port usage that would not be the
> best use of my time.  Someone who does have a real need to use an Oxford
> device at these low rates can step in and make the necessary chances.

 To put it shortly: the `spd_cust' feature is out there and it works, and 
contrary to what you assert requires no maintenance effort if you just 
leave it alone, while the alternative has various shortcomings that do 
require effort if they were to be addressed.  So please just get over it 
and let users choose what suits them best while letting developers focus 
on other stuff that keeps waiting.  If someone is happy with what BOTHER 
offers, then by no means I keep them from using it.

 I fail to understand really why a piece of code to correct and improve 
broken UART baud rate calculation has to be stuck in limbo for almost a 
year.  There is nothing wrong with this code and it has a proper change 
description and my observation has been that actually broken code often 
with half a sentence serving as justification gets accepted with no fuss 
all the time. :(

  Maciej
