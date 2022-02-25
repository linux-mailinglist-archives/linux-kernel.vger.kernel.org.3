Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF304C425C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiBYKdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbiBYKdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:33:32 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7E76197B7F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:32:59 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 21PAWd3d018756;
        Fri, 25 Feb 2022 11:32:39 +0100
Date:   Fri, 25 Feb 2022 11:32:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Steven Rostedt'" <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: Strange output on the console
Message-ID: <20220225103239.GA18720@1wt.eu>
References: <20220224230035.36547137@gandalf.local.home>
 <61226fc12ff9459d8daed8e346d6ab94@AcuMS.aculab.com>
 <20220225063637.GA18039@1wt.eu>
 <1dcb185901f04a5ea2476a449e371167@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dcb185901f04a5ea2476a449e371167@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 10:11:43AM +0000, David Laight wrote:
> From: Willy Tarreau
> > Sent: 25 February 2022 06:37
> > 
> > On Fri, Feb 25, 2022 at 06:12:35AM +0000, David Laight wrote:
> > > From: Steven Rostedt
> > > > Sent: 25 February 2022 04:01
> > > >
> > > > I've been noticing that my tests have been spitting out strange output on
> > > > the console. It would happen at boot up and then clear up. It looks like
> > > > something screwed up with the serial timing.
> > > >
> > > > Attached is a dmesg of one of my test runs as an example.
> > > >
> > > > I've noticed this on both 32 bit and 64 bit x86.
> > > >
> > > > I haven't had time to look deeper into this, but I figured I let you know
> > > > about it.
> > > >
> > > > And it always seems to happen right after:
> > > >
> > > >   Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > > >
> > > > Maybe this is a serial issue and not a printk one? :-/
> > >
> > > Looks very much like the serial baud rate is being reset.
> > 
> > I don't think it's the baud rate, characters are still readable, it
> > looks more like a fifo being too short and causing lots of chars to
> > be dropped.
> 
> Just before it recovers there is this output:
>     ATaitoscic nitahi tuPiet mfba Ae:   aD nCt AH0 nP0
> That is probably 'fifo not enabled'.
> 
> But the earlier output doesn't have many different characters in it.
> Which is typical of the baud rate being wrong.

I don't think so, here's the beginning of the capture:

  Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
  0SI 15Nto
  LgtAsri[dnei00ieC nm
  i:0eom:Soce
  [ad000Ade s:ii SSLtbueludAis002h00 1)ASrPn
  Ars004h00 7ARrPn

All of these chars are within the printable set, so there's a probability
of ~37% per char, so even for a short string of 9 chars like the first
line, that's a 0.01% chance of it respecting the set. That's why for me
it definitely doesn't correspond to a baud rate issue. With wrong baud
rates you get lots of garbage in the full 8-bit range.

In addition there are even upper case at the beginning of the lines which
probably correspond to the ones that are printed on these lines.

Willy
