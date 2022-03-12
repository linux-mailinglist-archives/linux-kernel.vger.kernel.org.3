Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0166D4D7103
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 22:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiCLVXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 16:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiCLVW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 16:22:58 -0500
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8F9C184B53;
        Sat, 12 Mar 2022 13:21:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id DEE0F101CB4;
        Sat, 12 Mar 2022 21:21:48 +0000 (UTC)
Date:   Sat, 12 Mar 2022 22:21:42 +0100
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220312222142.21591629.max@enpas.org>
In-Reply-To: <CAMZ6RqJJ-PO=WeFeuXk4iC9GHLXz_ZMWtsVCm6sGVGbmeE5U1Q@mail.gmail.com>
References: <20220307214303.1822590-1-max@enpas.org>
        <CAMZ6RqJZObevKPc29jW+m6i0eAgestTbw8KCPXxSGHzSXK7cRg@mail.gmail.com>
        <20220309135414.34f77251.max@enpas.org>
        <CAMZ6RqJJ-PO=WeFeuXk4iC9GHLXz_ZMWtsVCm6sGVGbmeE5U1Q@mail.gmail.com>
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

Hi Vincent,
(Hi Marc,)

Thank you for your in-depth look at it - especially regarding stale
things that reflect its age, such as cf->can_dlc vs. cf->len. This
driver has been gathering some dust. I've reworked the code according
to your review.



@Marc - could you please have a look at this?

The elmcan code currently has a dummy mailbox_read() function for
rx_offload because can_rx_offload_add_fifo() requires it - is this
intentional?




@Vincent - two more things have remained, and I hope it's okay once I
explain them:

1. _memstrcmp() - memcmp() vs. str(n)cmp()

The _memstrcmp() function does not compare strings, it compares raw
buffers. I am just using C strings for the fixed buffers to compare
against, as that allows for shorter and easier to read code. The NUL
byte at the end of those strings goes unused.

Also, I have not looked at the assembly produced, since the semantics
are different: str(n)cmp() needs to look for NUL bytes in the buffer(s),
which is unnecessary here. As a bonus, NUL will never even occur
because my code filters those bytes out upon reception from the UART
(it's a documented quirk of the ELM327).

Finally, even if I were to use strcmp(), the code would still look just
as ugly. Except the machine would also look for NUL bytes, and the next
human to read the code would wonder why I'm comparing strings and not
buffers.

Hence memcmp(), to help the code self-document and the compiler
optimise - I hope that's okay.



2. Useless parentheses in a for loop's condition:

I left those in there because it gets hard to read otherwise, IMHO.
It's really a matter of taste though, and if you insist, I'll remove
them. With if, it's easier to keep it readable:

	if (a == 1
         && b == 2) {
		...
	}

Whereas with for, I've already used multiple lines to visually separate
the initialiser, the condition, and the incrementer. Hence the
parentheses to visually separate the two subconditions.

Matter of taste really, and I'll change it if you insist.




That's it!
Everything else is already patched for a future v4 of the code. I'll CC
you once I send that out. But I'd like to wait for Marc's feedback
first.



Thanks,

Max
