Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A655DF4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245035AbiF1IcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241877AbiF1IcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:32:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CE62D1D8;
        Tue, 28 Jun 2022 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656405133; x=1687941133;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2kqXa/uuLryKUFs3CLbGBD4etwbcUy4VHXIUo9tYGK4=;
  b=LEVPB3/vXo+at6YRCU8O0vDKzzxD2b8WiylDwv6IZ/j3wVXsKiTELTAL
   6AdS0clRVgvYc0bNHuq1g3iHegZW+qx4yODv3caqZ6GSLYCTbjxRLGg+k
   n1QfU5pl04jkfCfW6dBY7lPGRbiM69X1U7AUQ5GxXSgjRqLXFHWrSi3oy
   LAE5ZXaHtAE3PW89P86ITAjX1vw7xPyDl/PT0v2n8aYuRzC3sagdu467e
   CJd45vSeabwfhL65mPsq+5TKHWi7xnyjpFuejxSdBXihKKcEMSI++gHTc
   3utqS9PDS6voCnP4fk2fRPYkzqBb75c5u+05B+lX9NMwlFZqrE0W78HtF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="264716123"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="264716123"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:32:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646818234"
Received: from iannetti-mobl.ger.corp.intel.com ([10.251.216.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:32:09 -0700
Date:   Tue, 28 Jun 2022 11:31:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 2/8] serial: core, 8250: set RS485 termination gpio in
 serial core
In-Reply-To: <067e6fa2-6015-2eea-5719-8b75fb08882c@gmx.de>
Message-ID: <9239f2ea-1a1c-ff27-70b9-931ab99c16@linux.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de> <20220622154659.8710-3-LinoSanfilippo@gmx.de> <20220625195844.GB2879@wunner.de> <067e6fa2-6015-2eea-5719-8b75fb08882c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2022, Lino Sanfilippo wrote:

> On 25.06.22 at 21:58, Lukas Wunner wrote:
> > On Wed, Jun 22, 2022 at 05:46:53PM +0200, Lino Sanfilippo wrote:
> >> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>
> >> In serial8250_em485_config() the termination GPIO is set with the uart_port
> >> spinlock held. This is an issue if setting the GPIO line can sleep (e.g.
> >> since the concerning GPIO expander is connected via SPI or I2C).
> >>
> >> Fix this by setting the termination line outside of the uart_port spinlock
> >> in the serial core.
> > [...]
> >> --- a/drivers/tty/serial/serial_core.c
> >> +++ b/drivers/tty/serial/serial_core.c
> >> @@ -1400,6 +1411,7 @@ static int uart_set_rs485_config(struct uart_port *port,
> >>  	if (ret)
> >>  		return ret;
> >>  	uart_sanitize_serial_rs485(port, &rs485);
> >> +	uart_set_rs485_termination(port, &rs485);
> >>
> >>  	spin_lock_irqsave(&port->lock, flags);
> >>  	ret = port->rs485_config(port, &rs485);
> >
> > That's one way to solve the issue.  Another would be to push
> > acquisition of the port spinlock down into drivers.
> >
> > I think in most drivers we don't need to take the port spinlock at all
> > or only for a few specific register accesses.  So taking the lock here
> > in the midlayer is likely unwarranted.  However, changing that requires
> > going through every single driver's ->rs485_config() callback and
> > checking whether it needs the lock or not.
> 
> As a first step its sufficient to take the lock in each drivers rs485_config()
> function and remove it from uart_set_rs485_config(). Then after time sort out
> the drivers that dont require the lock and remove it from their function.
> 
> However the point of this patch was also to generalize the handling of the
> termination GPIO, so I would still see this placed in uart_set_rs485_config().

Additional thing to consider is that core currently handles also the 
port->rs485 assignment under spinlock when ->rs485_config() was 
successful. TIOCSRS485 ioctl calls are synchronized by other primitives 
wrt. each other (port mutex and now also termios_rwsem) but drivers 
probably would like to see consistent rs485 which can only be realized by 
holding port->lock.


-- 
 i.

