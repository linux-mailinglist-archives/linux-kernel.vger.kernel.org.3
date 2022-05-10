Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D96F52111C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbiEJJli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbiEJJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:41:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF24F31;
        Tue, 10 May 2022 02:37:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 88E461F896;
        Tue, 10 May 2022 09:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652175444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qcfAdFbkeA1g2Kl2Spj7OETJ7n3bgekm6dIioojJcl8=;
        b=V54Hntelf6pY6fAx/5lPsUuPLcR7TM2P2PkyAjxf5AXhodVs+nRJMTrUKMY87vv/V9LRqO
        YWVj+YsmEOYLsr92BgVlFds/ZEIaxMM1YHwFuffoAmYhI9n6UEn611z7FxRtmK/9jtdLtE
        mrJ5wsKIErdVYKKUNV0X0INQoCXRwro=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BA5C72C141;
        Tue, 10 May 2022 09:37:23 +0000 (UTC)
Date:   Tue, 10 May 2022 11:37:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v1] serial: meson: acquire port->lock in startup()
Message-ID: <YnoyU3fydh46e2Sc@alley>
References: <20220508103547.626355-1-john.ogness@linutronix.de>
 <cf593ff3-bf57-ccd3-9a25-b28cc604d6f4@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf593ff3-bf57-ccd3-9a25-b28cc604d6f4@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-05-09 09:36:40, Neil Armstrong wrote:
> On 08/05/2022 12:35, John Ogness wrote:
> > The uart_ops startup() callback is called without interrupts
> > disabled and without port->lock locked, relatively late during the
> > boot process (from the call path of console_on_rootfs()). If the
> > device is a console, it was already previously registered and could
> > be actively printing messages.
> > 
> > Since the startup() callback is reading/writing registers used by
> > the console write() callback (AML_UART_CONTROL), its access must
> > be synchronized using the port->lock. Currently it is not.
> > 
> > The startup() callback is the only function that explicitly enables
> > interrupts. Without the synchronization, it is possible that
> > interrupts become accidentally permanently disabled.
> > 
> > CPU0                           CPU1
> > meson_serial_console_write     meson_uart_startup
> > --------------------------     ------------------
> > spin_lock(port->lock)
> > val = readl(AML_UART_CONTROL)
> > uart_console_write()
> >                                 writel(INT_EN, AML_UART_CONTROL)
> > writel(val, AML_UART_CONTROL)
> > spin_unlock(port->lock)
> > 
> > Add port->lock synchronization to meson_uart_startup() to avoid
> > racing with meson_serial_console_write().
> > 
> > Also add detailed comments to meson_uart_reset() explaining why it
> > is *not* using port->lock synchronization.
> > 
> > Link: https://lore.kernel.org/lkml/2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >   drivers/tty/serial/meson_uart.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> > index 2bf1c57e0981..39021dac09cc 100644
> > --- a/drivers/tty/serial/meson_uart.c
> > +++ b/drivers/tty/serial/meson_uart.c
> > @@ -253,6 +253,14 @@ static const char *meson_uart_type(struct uart_port *port)
> >   	return (port->type == PORT_MESON) ? "meson_uart" : NULL;
> >   }
> > +/*
> > + * This function is called only from probe() using a temporary io mapping
> > + * in order to perform a reset before setting up the device. Since the
> > + * temporarily mapped region was successfully requested, there can be no
> > + * console on this port at this time. Hence it is not necessary for this
> > + * function to acquire the port->lock. (Since there is no console on this
> > + * port at this time, the port->lock is not initialized yet.)
> > + */
> >   static void meson_uart_reset(struct uart_port *port)
> >   {
> >   	u32 val;
> > @@ -267,9 +275,12 @@ static void meson_uart_reset(struct uart_port *port)
> >   static int meson_uart_startup(struct uart_port *port)
> >   {
> > +	unsigned long flags;
> >   	u32 val;
> >   	int ret = 0;
> > +	spin_lock_irqsave(&port->lock, flags);
> > +
> >   	val = readl(port->membase + AML_UART_CONTROL);
> >   	val |= AML_UART_CLEAR_ERR;
> >   	writel(val, port->membase + AML_UART_CONTROL);
> > @@ -285,6 +296,8 @@ static int meson_uart_startup(struct uart_port *port)
> >   	val = (AML_UART_RECV_IRQ(1) | AML_UART_XMIT_IRQ(port->fifosize / 2));
> >   	writel(val, port->membase + AML_UART_MISC);
> > +	spin_unlock_irqrestore(&port->lock, flags);
> > +
> >   	ret = request_irq(port->irq, meson_uart_interrupt, 0,
> >   			  port->name, port);
> > 
> > base-commit: 672c0c5173427e6b3e2a9bbb7be51ceeec78093a
> 
> Thanks for fixing this, it may also fix an uart apparent lockup I encountered
> several time while developing on the platform, but the target was still alive
> so it matches.
> 
> So I'll add:
> Fixes: ff7693d079e5 ("ARM: meson: serial: add MesonX SoC on-chip uart driver")
> 
> and
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Neil, may I assume that you are going to queue this fix for 5.19, please?

Feel free to add:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
