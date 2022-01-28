Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981DD49F678
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbiA1Jgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbiA1Jgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:36:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5B7C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:36:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5BE12CE2441
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E280C340E0;
        Fri, 28 Jan 2022 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643362595;
        bh=+QVp2P6z/5hkENzAxChlX66KPbZhtS2K2BTf5vV7qfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnb7dnsi5eni9GvC/l4pzFqGTC8d8iwvc05YYZX+zmaLGZvf1fob2IKL2QM2ZgUxl
         ubcw9TyCtvrxFT49N5uaHnlTcqdc6KJsM2x40DGys2trAAOkqT0FL+r+gjXoSgamms
         8jCoGymdyX43ZElHAx2eB1Gb2f9wBCHzX+djoX2E=
Date:   Fri, 28 Jan 2022 10:36:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sami Kyostila <skyostil@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dtor@chromium.org,
        evanbenn@chromium.org, arnd@arndb.de
Subject: Re: [PATCH 1/2] drivers/misc: add a driver for HPS
Message-ID: <YfO5IJMPC8TnZM2A@kroah.com>
References: <20220127083545.1020423-1-skyostil@chromium.org>
 <20220127083545.1020423-2-skyostil@chromium.org>
 <YfJogh+yk1FHWSMC@kroah.com>
 <CAPuLczsKqFOsqf-d39HOMHZaFQb2vmv054HUOj2+amQGE=oPkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPuLczsKqFOsqf-d39HOMHZaFQb2vmv054HUOj2+amQGE=oPkw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 06:41:25PM +1100, Sami Kyostila wrote:
> to 27. tammik. 2022 klo 20.40 Greg KH (gregkh@linuxfoundation.org) kirjoitti:
> >
> > On Thu, Jan 27, 2022 at 07:35:44PM +1100, Sami Kyöstilä wrote:
> > > This patch introduces a driver for the ChromeOS snooping protection
> > > sensor (aka. HPS). The driver supports a sensor connected to the I2C bus
> > > and identified as "GOOG0020" in the ACPI tables.
> > >
> > > When loaded, the driver exports the sensor to userspace through a
> > > character device. This initial version of the device only supports power
> > > management, i.e., communicating with the sensor must be done through I2C
> > > from userspace.
> > >
> > > Power management is implemented by enabling the respective power GPIO
> > > while at least one userspace process holds an open fd on the character
> > > device. By default, the device is powered down if there are no active
> > > clients.
> > >
> > > Note that the driver makes no effort to preserve the state of the sensor
> > > between power down and power up events. Userspace is responsible for
> > > reinitializing any needed state once power has been restored.
> > >
> > > The device firmware, I2C protocol and other documentation is available
> > > at https://chromium.googlesource.com/chromiumos/platform/hps-firmware.
> >
> > How about a userspace tool that interacts with this new ioctl interface
> > as well so that we can understand how the driver is supposed to work?
> 
> Sure, here's a small example that shows how to read a magic register
> value from the device:
> https://gist.github.com/skyostil/13d60a288919d18d00b20e81dfe018cd
> 
> (Let me know if you'd prefer this to be checked into the tree somewhere.)

It should be somewhere so we know where to look and how this works and
who to complain to when it needs to be changed :)

thanks,

greg k-h
