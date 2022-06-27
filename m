Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B212A55DFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiF0Nsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiF0NsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:48:20 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73935247;
        Mon, 27 Jun 2022 06:48:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6ED768106;
        Mon, 27 Jun 2022 13:43:04 +0000 (UTC)
Date:   Mon, 27 Jun 2022 16:48:13 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <Yrm1HaUtjTMcSIE+@atomide.com>
References: <20220615062455.15490-1-tony@atomide.com>
 <Yrmfr3GfXYhclKXA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrmfr3GfXYhclKXA@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [220627 12:23]:
> On Wed, Jun 15, 2022 at 09:24:55AM +0300, Tony Lindgren wrote:
> > We want to enable runtime PM for serial port device drivers in a generic
> > way. To do this, we want to have the serial core layer manage the
> > registered serial port controllers. For runtime PM, we need a way to find
> > the serial ports for each serial port controller device.
> > 
> > The serial core manages ports. Each serial controller can have multiple
> > ports. As serial core has no struct device, and the serial port device
> > drivers have their own driver data, we cannot currently start making
> > use of serial core generic data easily without changing all the serial
> > port device drivers.
> 
> Really?  Why not make struct uart_port a real struct device?

Okie dokie

> > We could consider adding a serial core specific struct device. It would
> > be a child of the serial port device, and would allow us eventually to use
> > device_links to add generic runtime PM calls for example. But as the serial
> > core layer is not a device driver, driver specific features would need to
> > be added, and are probably not justified for a virtual device.
> 
> I think it's very justified, let's not paper over this whole thing by
> adding a kref stuck in in the middle and trying to hook up the PM code
> to it, instead of just using all of the PM logic that the driver model
> already provides.

OK. Having the serial controller be the parent device for the port device
will make runtime PM work as designed :)

> > Considering the above, let's improve the serial core layer so we can
> > manage the serial port controllers better. Let's register the controllers
> > with the serial core layer in addition to the serial ports.
> 
> Why can't controllers be a device as well?

The controllers are devices already probed by the serial port drivers.
What's missing is mapping the ports (as devices based on the comments
above) to the controller devices. I don't think we need another struct
device for the serial controller in addition to the serial port driver
device and it's child port devices.

> Let's try to work with the driver model here, not work around it, if at
> all possible.  We never did a full conversion of the serial layer to the
> driver core all those decades ago.  Perhaps now is the time to really do
> that.

Yes so it seems.

Regards,

Tony
