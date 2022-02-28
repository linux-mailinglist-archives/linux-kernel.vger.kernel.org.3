Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB04C7BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiB1VYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiB1VYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:24:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F8111091;
        Mon, 28 Feb 2022 13:23:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E03196115A;
        Mon, 28 Feb 2022 21:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71692C340F1;
        Mon, 28 Feb 2022 21:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646083437;
        bh=7QaD+tXLqarmJbeGijWj9hiygCezLVN/S/8WqSTJVNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFXPE/4x6iPsq+Tvg1FOZcG9d1EMvmtMIgbMv5HsD83YrDCus6HxIwFZ7eVnTr7j6
         pulm9WhwkT4qv2WFDdDRqtK2QH20HQOsAjyp2eUqP81AqXbeWq6atp6h+sz//gVpDG
         4Pm1fo1MmxF/AQH2ViiXrn94NuiEt2iTtFV5IpYI=
Date:   Mon, 28 Feb 2022 22:23:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V3] tty: serial: meson: Fix the compile link error
 reported by kernel test robot
Message-ID: <Yh09abhySKsjart4@kroah.com>
References: <20220228135530.6918-1-yu.tu@amlogic.com>
 <20220228142751.GF2812@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228142751.GF2812@kadam>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 05:27:52PM +0300, Dan Carpenter wrote:
> On Mon, Feb 28, 2022 at 09:55:30PM +0800, Yu Tu wrote:
> > Describes the calculation of the UART baud rate clock using a clock
> > frame. Forgot to add in Kconfig kernel test Robot compilation error
> > due to COMMON_CLK dependency.
> > 
> > Fixes: ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> > ---
> >  drivers/tty/serial/Kconfig      |  1 +
> >  drivers/tty/serial/meson_uart.c | 37 +++++++++++++++++++++++----------
> >  2 files changed, 27 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index e952ec5c7a7c..a0f2b82fc18b 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -200,6 +200,7 @@ config SERIAL_KGDB_NMI
> >  config SERIAL_MESON
> >  	tristate "Meson serial port support"
> >  	depends on ARCH_MESON || COMPILE_TEST
> > +	depends on COMMON_CLK
> >  	select SERIAL_CORE
> >  	help
> >  	  This enables the driver for the on-chip UARTs of the Amlogic
> 
> 
> This is a link issue.  The rest is an unrelated error handling fix.
> It should really be sent as two patches.

I'll take the first version of this patch, which just did this portion,
and the rest can be an independant change.

thanks,

greg k-h
