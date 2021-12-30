Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23571481C15
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbhL3Mbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbhL3Mbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:31:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F92BC061574;
        Thu, 30 Dec 2021 04:31:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08D33B81BE2;
        Thu, 30 Dec 2021 12:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F9CC36AEA;
        Thu, 30 Dec 2021 12:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640867509;
        bh=x2thwngD98NIaTMG6mDpgHTaaqtUUesBX+o4q4qEB94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0j9yqXcjDUcOM7/N9oFZHfYSVAqMtu4c063RjKJ4V1o04WVLUMFmGN1oM1oiiA8m
         yeyRkRx99lvwYdPVFf9an+xo9GGRgyU7C32C7s6Siap9V3F0piIJrFDdObsWZKLhjD
         tHDV3QKdXrnfrtUK8XEekDUOqC4wUhoi8Cpxmsyc=
Date:   Thu, 30 Dec 2021 13:31:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Lechner <david@lechnology.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v3 00/23] counter: cleanups and device lifetime fixes
Message-ID: <Yc2msulJ2Uc5eJZN@kroah.com>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
 <20211230085351.pywngltvdam25emx@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211230085351.pywngltvdam25emx@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 09:53:51AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Dec 29, 2021 at 04:44:18PM +0100, Uwe Kleine-König wrote:
> > this is v3 of my series to fix device lifetime issues in the counter
> > framework. This hopefully addresses all things pointed out for v2.
> > 
> > Note this depends on 60f07e74f86b (which is in next) now. Full diffstat
> > below.
> > 
> > Things that could be further improved:
> > 
> > [...]
> > 
> > Uwe Kleine-König (23):
> >   counter: Use container_of instead of drvdata to track counter_device
> >   counter: ftm-quaddec: Drop unused platform_set_drvdata()
> >   counter: microchip-tcb-capture: Drop unused platform_set_drvdata()
> >   counter: Provide a wrapper to access device private data
> >   counter: 104-quad-8: Convert to counter_priv() wrapper
> >   counter: interrupt-cnt: Convert to counter_priv() wrapper
> >   counter: microchip-tcb-capture: Convert to counter_priv() wrapper
> >   counter: intel-qep: Convert to counter_priv() wrapper
> >   counter: ftm-quaddec: Convert to counter_priv() wrapper
> >   counter: ti-eqep: Convert to counter_priv() wrapper
> >   counter: stm32-lptimer-cnt: Convert to counter_priv() wrapper
> >   counter: stm32-timer-cnt: Convert to counter_priv() wrapper
> >   counter: Provide alternative counter registration functions
> >   counter: Update documentation for new counter registration functions
> >   counter: 104-quad-8: Convert to new counter registration
> >   counter: interrupt-cnt: Convert to new counter registration
> >   counter: intel-qep: Convert to new counter registration
> >   counter: ftm-quaddec: Convert to new counter registration
> >   counter: microchip-tcb-capture: Convert to new counter registration
> >   counter: stm32-timer-cnt: Convert to new counter registration
> >   counter: stm32-lptimer-cnt: Convert to new counter registration
> >   counter: ti-eqep: Convert to new counter registration
> >   counter: remove old and now unused registration API
> > 
> >  Documentation/driver-api/generic-counter.rst |  10 +-
> >  drivers/counter/104-quad-8.c                 |  93 +++++-----
> >  drivers/counter/counter-core.c               | 186 ++++++++++++++-----
> >  drivers/counter/ftm-quaddec.c                |  36 ++--
> >  drivers/counter/intel-qep.c                  |  46 ++---
> >  drivers/counter/interrupt-cnt.c              |  38 ++--
> >  drivers/counter/microchip-tcb-capture.c      |  44 ++---
> >  drivers/counter/stm32-lptimer-cnt.c          |  51 ++---
> >  drivers/counter/stm32-timer-cnt.c            |  48 ++---
> >  drivers/counter/ti-eqep.c                    |  31 ++--
> >  include/linux/counter.h                      |  15 +-
> >  11 files changed, 356 insertions(+), 242 deletions(-)
> > 
> > Range-diff against v2:
> > [...]
> > 
> > base-commit: a7904a538933c525096ca2ccde1e60d0ee62c08e
> > prerequisite-patch-id: 9459ad8bc78190558df9123f8bebe28ca1c396ea
> 
> All patches have a blessing by at least one of William and Jonathan.
> The prerequisite commit (60f07e74f86b) is in Greg's char-misc-next branch.
> 
> Assuming noone still finds a problem in this series that requires me to
> respin I wonder who will pick it up? Greg?
> 
> Given that it fixes a possible use-after-free in all counter drivers,
> I'd like to see it hit before v5.17-rc1. For 5.16 it's probably too
> late.

Of course it is too later for 5.16, sorry.

I'll queue this up to my tree now, for 5.17-rc1, thanks.

greg k-h
