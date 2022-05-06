Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60951D32E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390036AbiEFIUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390048AbiEFIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:20:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5731368333
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:16:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 96AD01F910;
        Fri,  6 May 2022 08:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651824974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vMtR9RH4hTYIsMANbyKvgkBZPC808rHyRFlpC3fYLRo=;
        b=BDN/cKlwvO99GE7qhWLk8USYXX45YH1F8Sy30e3vxmtG4E3B6lAp9+pe0VDCuA3jQJXAq8
        09OWYYPDLZtCK3iTfGb2Fr9k6sgJbBQOKNa4REs7Bb455QeO8QWOXXKAOAHBnojDeb5esX
        P70Rn/O1tBYx6sw0icRrV5yH/BLX1Wg=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3A0D22C142;
        Fri,  6 May 2022 08:16:13 +0000 (UTC)
Date:   Fri, 6 May 2022 10:16:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Message-ID: <YnTZTQv/oGwMiXud@alley>
References: <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
 <Ym/Z7PYPqvWPEjuL@alley>
 <45849b63-d7a8-5cc3-26ad-256a28d09991@samsung.com>
 <87pmktm2a9.fsf@jogness.linutronix.de>
 <87a6bwapij.fsf@jogness.linutronix.de>
 <87zgjvd2zb.fsf@jogness.linutronix.de>
 <b7c81f02-039e-e877-d7c3-6834728d2117@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7c81f02-039e-e877-d7c3-6834728d2117@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-05-06 08:43:02, Marek Szyprowski wrote:
> Hi John,
> 
> On 06.05.2022 00:33, John Ogness wrote:
> > On 2022-05-05, John Ogness <john.ogness@linutronix.de> wrote:
> >> I will go through and check if all access to AML_UART_CONTROL is
> >> protected by port->lock.
> > The startup() callback of the uart_ops is not called with the port
> > locked. I'm having difficulties identifying if the startup() callback
> > can occur after the console was already registered via meson_uart_init()
> > and could be actively printing, but I see other serial drivers are
> > protecting their registers in the startup() callback with the
> > port->lock.

I guess that it is used by the early console before the racy
code is called.

> > Could you try booting the meson hardware with the following change? (And
> > removing any previous debug changes I posted?)
> 
> Bingo! It looks that the startup() is called when getty initializes 
> console. This fixed the issues observed on the Amlogic Meson based boards.
> 
> Feel free to add:
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Uff, it is a huge relief that it has got fixed.

Best Regards,
Petr
