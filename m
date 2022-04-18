Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6B7505BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245089AbiDRPvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345756AbiDRPua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:50:30 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BF15B867;
        Mon, 18 Apr 2022 08:28:41 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B226092009E; Mon, 18 Apr 2022 17:28:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id AC96192009C;
        Mon, 18 Apr 2022 16:28:40 +0100 (BST)
Date:   Mon, 18 Apr 2022 16:28:40 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] serial: 8250: Add proper clock handling for OxSemi
 PCIe devices
In-Reply-To: <CAHp75Vc6n+86jhhK2JRSZ=f6ZBV46Kz=Ayq=dWTHFbB-Hr+C7A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2204181531330.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204161848030.9383@angie.orcam.me.uk> <alpine.DEB.2.21.2204162141010.9383@angie.orcam.me.uk> <CAHp75Vc6n+86jhhK2JRSZ=f6ZBV46Kz=Ayq=dWTHFbB-Hr+C7A@mail.gmail.com>
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

On Mon, 18 Apr 2022, Andy Shevchenko wrote:

> > With the baud base set to 15625000 and the unsigned 16-bit UART_DIV_MAX
> > limitation imposed by `serial8250_get_baud_rate' standard baud rates
> > below 300bps become unavailable in the regular way, e.g. the rate of
> > 200bps requires the baud base to be divided by 78125 and that is beyond
> > the unsigned 16-bit range.  The historic spd_cust feature can still be
> > used to obtain such rates if so required.
> >
> > See Documentation/tty/device_drivers/oxsemi-tornado.rst for more details.
> 
> I'm not sure I understand how this change can have the 8250_port
> changes which were done in the previous patches. What did I miss?

 You mean the `->mcr' part?  It's required to keep the CLKSEL bit set at 
all times.

> Also, looking at the below if the two *_icr_*() functions were moved
> from 8250_port, how they have been used before? Dead code?

 They continue being used throughout 8250_port.c: `serial_icr_read' in 
`autoconfig_has_efr' and `serial_icr_write' in `serial8250_stop_tx', 
`__start_tx', and `serial8250_do_startup'.  If they were dead, GCC would 
complain about their presence (without `__maybe_unused' annotation or an 
equivalent syntax to get the `unused' function atttribute).

 Now `serial_icr_write' is also used by `pci_oxsemi_tornado_set_divisor', 
and for consistency I chose to export `serial_icr_read' as well.

 Let me know if these explanations have cleared your concerns.

> > +       /* Old custom speed handling.  */
> > +       if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
> 
> This part is not needed.  We have a BOTHER mechanism in the kernel
> that works for each driver that supports it in the generic way, hence
> the user space tool wouldn't be patched to support this exact card
> separately. Using SPD_CUST is a step back.

 As previously discussed I maintain this is a reasonable compromise until 
we have issues with BOTHER and other regular termios interfaces such as 
B200 fixed; specifically the 16-bit UART_DIV_MAX limitation making it 
impossible to request baud rates below 300bps, as also noted in the change 
description, and the inability to set exact clock rates which may be 
required in some applications relying on the presence of the SPD_CUST 
feature.

 NB I agree that wiring SPD_CUST to the 38400bps baud rate hasn't been 
particularly fortunate, but that's what used to be available in terms of 
the API back in 1990s, as I previously explained.

 I have now posted v5 with the grammatical issues fixed and an additional 
update to make use of the DIV_ROUND_CLOSEST macro I have come across while 
looking into an unrelated issue.

 Thank you for your review.

  Maciej
