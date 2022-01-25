Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF8749B994
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbiAYRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:05:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:59652 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354582AbiAYRCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643130170; x=1674666170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/mTnNtkyEJI+5x7IYcfDbJkXYf2eGevEJEqfSB40thE=;
  b=N/W7+AqbiKQN6UkwT8j4bUeEbG6LhoswMuiKiqyNgjeChq37mtJSW39W
   vIMkyQYIyubAeopmeDBsqZa9MNXtpIlaMeGLVJF4Xpor3qJTiRFwG+Ip2
   6np9U1sRt0O5NM0P1A/Ev0LNDgXvGJcBtShp+RdV4wz/62ldsEONX+y8C
   pLDU7MyJyB+HMm2ws+oafnTX1Uq7JsFsUoSK6F/s2d3qqoWF9HZGs0mCw
   zSD4P/dk9jFib81i+55OQGlceKlOz5NRWd0zcYJ6ZrqORDHc/MmDc3BFl
   jBuTFMMO1MIKOkyFA35NdxUzndd39mXmtPR9d9Hrr6ZMC5mVtHSLDO8eE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246294502"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246294502"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 08:54:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="477174004"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 08:54:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCP4m-00EJqX-Ce;
        Tue, 25 Jan 2022 18:53:48 +0200
Date:   Tue, 25 Jan 2022 18:53:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Wander Costa <wcosta@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Message-ID: <YfArHDfrVHw7ApDx@smile.fi.intel.com>
References: <20211029201402.428284-1-wander@redhat.com>
 <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
 <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org>
 <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
 <11ec4350-b890-4949-cf8f-bc62d530d64f@nvidia.com>
 <CAAq0SU=9R3Y_SAdM+HaqavzWBRd1Li-b5bnZZLd5Opfgd0vnkQ@mail.gmail.com>
 <fa42a60c-954a-acc0-3962-f00427153f78@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa42a60c-954a-acc0-3962-f00427153f78@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:40:27PM +0000, Jon Hunter wrote:
> 
> On 25/01/2022 10:29, Wander Costa wrote:
> > On Tue, Jan 25, 2022 at 7:06 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> > > 
> > > 
> > > On 25/01/2022 09:36, Jiri Slaby wrote:
> > > 
> > > ...
> > > 
> > > > > The test is bogus:
> > > > >           use_fifo = (up->capabilities & UART_CAP_FIFO) &&
> > > > >                   port->fifosize > 1 &&
> > > > >                   (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO)
> > > > > 
> > > > > FCR is write only. Reading it, one gets IIR contents.
> > > > 
> > > > In particular, the test is checking whether there is no interrupt
> > > > pending (UART_FCR_ENABLE_FIFO == UART_IIR_NO_INT). So it oscillates
> > > > between use_fifo and not, depending on the interrupt state of the chip.
> > > > 
> > > > Could you change it into something like this:
> > > > --- a/drivers/tty/serial/8250/8250_port.c
> > > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > > @@ -3396,7 +3396,7 @@ void serial8250_console_write(struct
> > > > uart_8250_port *up, const char *s,
> > > > 
> > > >           use_fifo = (up->capabilities & UART_CAP_FIFO) &&
> > > >                   port->fifosize > 1 &&
> > > > -               (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &&
> > > > +               (up->fcr & UART_FCR_ENABLE_FIFO) &&
> > > >                   /*
> > > >                    * After we put a data in the fifo, the controller will
> > > > send
> > > >                    * it regardless of the CTS state. Therefore, only use
> > > > fifo
> > > > 
> > > > 
> > > > And see whether it fixes the issue. Anyway, of what port type is the
> > > > serial port (what says dmesg/setserial about that)?
> > > 
> > > 
> > > Thanks. Unfortunately, this did not fix it. The port type is PORT_TEGRA ...
> > > 
> > >    70006000.serial: ttyS0 at MMIO 0x70006000 (irq = 72, base_baud = 25500000) is a Tegra
> > 
> > I see PORT_TEGRA has different values for fifosize and tx_loadsz.
> > Maybe we should use tx_loadsz.
> > Could you please give a try to this patch:
> > 
> > diff --git a/drivers/tty/serial/8250/8250_port.c
> > b/drivers/tty/serial/8250/8250_port.c
> > index 2abb3de11a48..d3a93e5d55f7 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -3343,7 +3343,7 @@ static void serial8250_console_fifo_write(struct
> > uart_8250_port *up,
> >   {
> >          int i;
> >          const char *end = s + count;
> > -       unsigned int fifosize = up->port.fifosize;
> > +       unsigned int fifosize = up->tx_loadsz;
> >          bool cr_sent = false;
> > 
> >          while (s != end) {
> > @@ -3409,8 +3409,8 @@ void serial8250_console_write(struct
> > uart_8250_port *up, const char *s,
> >          }
> > 
> >          use_fifo = (up->capabilities & UART_CAP_FIFO) &&
> > -               port->fifosize > 1 &&
> > -               (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &&
> > +               up->tx_loadsz > 1 &&
> > +               (up->fcr & UART_FCR_ENABLE_FIFO) &&
> >                  /*
> >                   * After we put a data in the fifo, the controller will send
> >                   * it regardless of the CTS state. Therefore, only use fifo
> > 
> 
> 
> Thanks. Yes that does fix it.
> 
> Andy, does this work for X86?

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

No, it does NOT fix an issue (I see it on a handful x86) with the legacy UART
(means the 8250_pnp is in use). And I believe the same will be the case on LPSS
ones (8250_dw / 8250_lpss) and HSU (8250_mid), because the patch influences on
all of them.

-- 
With Best Regards,
Andy Shevchenko


