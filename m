Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A742655D9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiF0M2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiF0M2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:28:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C767363F4;
        Mon, 27 Jun 2022 05:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92733B81110;
        Mon, 27 Jun 2022 12:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28F7C3411D;
        Mon, 27 Jun 2022 12:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656332899;
        bh=ItpgoEcOuwDEFm+eFghMeChypkh3vU8dbMK2C/PstZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Pzi1/gcvjNfq0hTLc2246UYLr1cBss+sqkSAubLHFv005K2lJhz/KgtJq0as3QSN
         YoyVuLjwAMvFv8mn7Ysasd3NK1lDlUI8ECSp+h1GOD0XAsmSlAXz85XZwoi6GMCPfe
         eyyHKtgLIi2ya+3tyMXACRZSaq+SGyR9ewTfOLZQ=
Date:   Mon, 27 Jun 2022 14:16:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <Yrmfr3GfXYhclKXA@kroah.com>
References: <20220615062455.15490-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615062455.15490-1-tony@atomide.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 09:24:55AM +0300, Tony Lindgren wrote:
> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered serial port controllers. For runtime PM, we need a way to find
> the serial ports for each serial port controller device.
> 
> The serial core manages ports. Each serial controller can have multiple
> ports. As serial core has no struct device, and the serial port device
> drivers have their own driver data, we cannot currently start making
> use of serial core generic data easily without changing all the serial
> port device drivers.

Really?  Why not make struct uart_port a real struct device?

> We could consider adding a serial core specific struct device. It would
> be a child of the serial port device, and would allow us eventually to use
> device_links to add generic runtime PM calls for example. But as the serial
> core layer is not a device driver, driver specific features would need to
> be added, and are probably not justified for a virtual device.

I think it's very justified, let's not paper over this whole thing by
adding a kref stuck in in the middle and trying to hook up the PM code
to it, instead of just using all of the PM logic that the driver model
already provides.

> Considering the above, let's improve the serial core layer so we can
> manage the serial port controllers better. Let's register the controllers
> with the serial core layer in addition to the serial ports.

Why can't controllers be a device as well?

Let's try to work with the driver model here, not work around it, if at
all possible.  We never did a full conversion of the serial layer to the
driver core all those decades ago.  Perhaps now is the time to really do
that.

thanks,

greg k-h
