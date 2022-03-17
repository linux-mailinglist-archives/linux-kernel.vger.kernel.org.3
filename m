Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198844DCFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiCQVGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiCQVGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:06:50 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C106317A2FF;
        Thu, 17 Mar 2022 14:05:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 8E9FBFF86A;
        Thu, 17 Mar 2022 21:05:30 +0000 (UTC)
Date:   Thu, 17 Mar 2022 22:05:28 +0100
From:   Max Staudt <max@enpas.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220317220528.4cd8efaa.max@enpas.org>
In-Reply-To: <20220315102135.evgt4es7yb23sabb@pengutronix.de>
References: <20220307214303.1822590-1-max@enpas.org>
        <CAMZ6RqJZObevKPc29jW+m6i0eAgestTbw8KCPXxSGHzSXK7cRg@mail.gmail.com>
        <20220309135414.34f77251.max@enpas.org>
        <CAMZ6RqJJ-PO=WeFeuXk4iC9GHLXz_ZMWtsVCm6sGVGbmeE5U1Q@mail.gmail.com>
        <20220312222142.21591629.max@enpas.org>
        <20220315102135.evgt4es7yb23sabb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 11:21:35 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 12.03.2022 22:21:42, Max Staudt wrote:
> > @Vincent - two more things have remained, and I hope it's okay once
> > I explain them:
> > 
> > 1. _memstrcmp() - memcmp() vs. str(n)cmp()
> > 
> > The _memstrcmp() function does not compare strings, it compares raw
> > buffers. I am just using C strings for the fixed buffers to compare
> > against, as that allows for shorter and easier to read code. The NUL
> > byte at the end of those strings goes unused.
> > 
> > Also, I have not looked at the assembly produced, since the
> > semantics are different: str(n)cmp() needs to look for NUL bytes in
> > the buffer(s), which is unnecessary here. As a bonus, NUL will
> > never even occur because my code filters those bytes out upon
> > reception from the UART (it's a documented quirk of the ELM327).
> > 
> > Finally, even if I were to use strcmp(), the code would still look
> > just as ugly. Except the machine would also look for NUL bytes, and
> > the next human to read the code would wonder why I'm comparing
> > strings and not buffers.
> > 
> > Hence memcmp(), to help the code self-document and the compiler
> > optimise - I hope that's okay.  
> 
> Looking at the code:
> 
> > +/* Compare a buffer to a fixed string */
> > +static inline int _memstrcmp(const u8 *mem, const char *str)
> > +{
> > +     return memcmp(mem, str, strlen(str));  
> 
> The _memstrcmp is sometimes directly used. Where's the check that mem
> is valid for strlen(len)? Better only use _len_memstrcmp().

It's implicit in the code that calls it.

Anyway, you're the second reviewer to trip upon this (after Vincent),
so my take away is that my code is too confusing. I'll check if I can
just strncmp() it, to keep it simple.

Sorry for what's in large part a premature optimisation.
