Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919EF5A4573
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiH2Iut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiH2Iup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:50:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F913F9B;
        Mon, 29 Aug 2022 01:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D35A7B80D85;
        Mon, 29 Aug 2022 08:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EF0C433D6;
        Mon, 29 Aug 2022 08:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661763040;
        bh=RjnPCuRTzjQD0nHdYRw7Zc90H9msuTPEGQ6Kegg8IkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fE9vrp2sEYOAVmi5eV51nA98d2CLU2EPmC2mLxLSiy425vKYeyF5t6E4mGDPy30/X
         edtXJ2SKa/3hV71LWf+rn4O1kyJ+iUh7ztSzr8KbQq4b2X0or4ZwZqXyjVXVINTvcM
         kJ+bkniH0OOg3QVjygs/bFsUzSBEK6t0B1u1a+aJkFgPF5XpSEmaxOynPaonZdtfPt
         CHdMY0ZXbe1TrTMFc7FlO/LbXaMDSBNrT2RV6UP3x3G8EqTMdXJx1kTJ4e4AHT9/y+
         OLWs4eCVRLGKy8jA8IMMYrV8awWYQudE2DS0pCPOtbvnmtxG3uRhOvwhlA1iQDYus0
         4WGyqKIIkvXHg==
Received: by pali.im (Postfix)
        id 96A247DE; Mon, 29 Aug 2022 10:50:37 +0200 (CEST)
Date:   Mon, 29 Aug 2022 10:50:37 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 3/3] tty: serial: use uart_port_tx_limit() helper
Message-ID: <20220829085037.ec6qdrklgy4cbmym@pali>
References: <20220411105405.9519-1-jslaby@suse.cz>
 <20220411105405.9519-4-jslaby@suse.cz>
 <20220411115141.o2i3rlfcyzg6qlnz@pali>
 <0a1f4ce9-4158-b8ab-1837-68da06f20407@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a1f4ce9-4158-b8ab-1837-68da06f20407@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 August 2022 09:27:01 Jiri Slaby wrote:
> On 11. 04. 22, 13:51, Pali Rohár wrote:
> > On Monday 11 April 2022 12:54:05 Jiri Slaby wrote:
> > > uart_port_tx_limit() is a new helper to send characters to the device.
> > > Use it in these drivers.
> > > 
> > > It means we have to define two new uart hooks: tx_ready() and put_char()
> > > to do the real job now.
> > > 
> > > And mux.c also needs to define tx_done(). But I'm not sure if the driver
> > > really wants to wait for all the characters to dismiss from the HW fifo
> > > at this code point. Hence I marked this as FIXME.
> > > 
> > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > > Cc: bcm-kernel-feedback-list@broadcom.com
> > > Cc: "Pali Rohár" <pali@kernel.org>
> > > Cc: Kevin Cernekee <cernekee@gmail.com>
> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > > Cc: Orson Zhai <orsonzhai@gmail.com>
> > > Cc: Baolin Wang <baolin.wang7@gmail.com>
> > > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > Cc: linux-riscv@lists.infradead.org
> > > ---
> > >   drivers/tty/serial/21285.c           | 40 +++++++--------------
> > >   drivers/tty/serial/altera_jtaguart.c | 43 ++++++----------------
> > >   drivers/tty/serial/amba-pl010.c      | 40 ++++-----------------
> > >   drivers/tty/serial/apbuart.c         | 37 ++++---------------
> > >   drivers/tty/serial/bcm63xx_uart.c    | 48 ++++++-------------------
> > >   drivers/tty/serial/mux.c             | 48 ++++++++-----------------
> > >   drivers/tty/serial/mvebu-uart.c      | 47 +++++++-----------------
> > >   drivers/tty/serial/omap-serial.c     | 53 +++++++---------------------
> > >   drivers/tty/serial/pxa.c             | 43 +++++-----------------
> > >   drivers/tty/serial/rp2.c             | 36 ++++++-------------
> > >   drivers/tty/serial/serial_txx9.c     | 40 ++++-----------------
> > >   drivers/tty/serial/sifive.c          | 48 ++++---------------------
> > >   drivers/tty/serial/sprd_serial.c     | 41 ++++-----------------
> > >   drivers/tty/serial/st-asc.c          | 51 ++++----------------------
> > >   drivers/tty/serial/vr41xx_siu.c      | 42 ++++------------------
> > >   15 files changed, 143 insertions(+), 514 deletions(-)
> > ...
> > > diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> > > index 0429c2a54290..3d07ab9eb15e 100644
> > > --- a/drivers/tty/serial/mvebu-uart.c
> > > +++ b/drivers/tty/serial/mvebu-uart.c
> > > @@ -194,6 +194,16 @@ static unsigned int mvebu_uart_tx_empty(struct uart_port *port)
> > >   	return (st & STAT_TX_EMP) ? TIOCSER_TEMT : 0;
> > >   }
> > > +static bool mvebu_uart_tx_ready(struct uart_port *port)
> > > +{
> > > +	return !(readl(port->membase + UART_STAT) & STAT_TX_FIFO_FUL);
> > 
> > mvebu-uart.c driver in its tx_ready function should probably use
> > STAT_TX_RDY macro (access to STAT_TX_RDY bit in register).
> > 
> > Documentation for UART1 (STD) about this bit says:
> > 
> > This bit is set when TRANS_HLD (our UART_TSH macro) is empty and ready
> > for the CPU to write the next character to be transmitted out. The TSR
> > can still shift out the previous character when this bit is set. This
> > bit is cleared when the CPU writes to TRANS_HLD.
> > 
> > For UART2 (EXT) there is just information: UART Tx Ready for 1 Byte
> > Write. UART2 (EXT) has also bit (bit 5) which indicates that CPU can
> > load 4 bytes, but seems that this is not used by mvebu-uart.c driver.
> > 
> > Macro STAT_TX_RDY() is polled also in wait_for_xmitr() function.
> 
> Hi,
> so care to send fixes for the two issues :)? The series is not meant to
> change behavior...

Ok, I will look at it after your patches are merged to prevent merge conflicts.
