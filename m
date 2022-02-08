Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E4D4AD7A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiBHLib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359665AbiBHLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:36:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237DAC03BFDF;
        Tue,  8 Feb 2022 03:31:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8315B81A7F;
        Tue,  8 Feb 2022 11:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E89DC004E1;
        Tue,  8 Feb 2022 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644319884;
        bh=DLDUE4WWqThbG4l9rUbwx/KtsUESb9ujNNAkQOlmfGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=II/OFBBiJ9s5lFQ6vL4va5jBS7HoDcbGmAWk8g+WQI7xhUVj6yImIGDHc7tLuLe0L
         AIXelfs9GeUJLziSRUkrhRwGKcoga+UN0hS9mpzoQgaMgXE95lq0CDt9aceh+lfB6g
         bGdO1pGuwMsc0zgoiWSxSrikGOqdju+3e4HyhvHw=
Date:   Tue, 8 Feb 2022 12:31:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     hammer hsieh <hammerh0314@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        wells.lu@sunplus.com, "hammer.hsieh" <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH v7 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Message-ID: <YgJUiegS2Cc9MyHc@kroah.com>
References: <1644213481-20321-1-git-send-email-hammerh0314@gmail.com>
 <1644213481-20321-3-git-send-email-hammerh0314@gmail.com>
 <7aa14a1e-2814-0014-a682-f40666f635ac@kernel.org>
 <CAOX-t569-0aTu73eGSY3k+btAuVgueRY91Jd5b9kbpjmxPp+Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOX-t569-0aTu73eGSY3k+btAuVgueRY91Jd5b9kbpjmxPp+Dw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 07:16:52PM +0800, hammer hsieh wrote:
> Jiri Slaby <jirislaby@kernel.org> 於 2022年2月8日 週二 下午2:27寫道：
> >
> > Hi,
> >
> > On 07. 02. 22, 6:58, Hammer Hsieh wrote:
> > > +static void sunplus_shutdown(struct uart_port *port)
> > > +{
> > > +     unsigned long flags;
> > > +     unsigned int isc;
> > > +
> > > +     spin_lock_irqsave(&port->lock, flags);
> > > +
> > > +     isc = readl(port->membase + SUP_UART_ISC);
> > > +     isc &= ~(SUP_UART_ISC_RXM | SUP_UART_ISC_TXM);
> >
> > Is this correct? I mean: will the SUP_UART_ISC read contain the control
> > bits, not only status bits?
> >
> 
> I assume reviewers don't like writel(0,xxx).
> So I use definition to let the code easy to read.
> The purpose is to clear all interrupt.
> Bit[3:0] status bit only for read, write 1 or 0 no effect.
> 
> > > +     writel(isc, port->membase + SUP_UART_ISC);
> > > +
> > > +     spin_unlock_irqrestore(&port->lock, flags);
> > > +
> > > +     free_irq(port->irq, port);
> >
> > I am still waiting for explanation why this is safe with respect to
> > posted writes.
> >
> 
> Actually I'm not IC designer, not expert for bus design.
> About data incoherence issue between memory bus and peripheral bus.
> In case of AXI bus, use non-posted write can avoid data incoherence issue.
> What if in case of posted write:
> Send a specific command after last write command.
> SDCTRL identify specific command, means previous write command done.
> Then send interrupt signal to interrupt controller.
> And then interrupt controller send done signal to Master.
> Master receive done signal, means write command done.
> Then issue a interrupt or proceed next write command.

But how does the kernel know when the write is completed?  The kernel
seems to ignore that here entirely, so the write could actually complete
seconds later, which would not be a good thing, right?

Traditionally, we want to ensure that a write() completes, so on some
busses, we have to do a read to ensure that the write made it to the
hardware before we can continue on.  That is not happening here which is
why Jiri keeps bringing it up.  It looks broken to us, and you need to
document it somewhere (in the changelog?  In the top of the file?) as to
why this is not needed.

thanks,

greg k-h
