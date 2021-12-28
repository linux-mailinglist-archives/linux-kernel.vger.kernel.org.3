Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE12480C15
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbhL1RaY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 12:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhL1RaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:30:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774E1C061574;
        Tue, 28 Dec 2021 09:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0716A612E2;
        Tue, 28 Dec 2021 17:30:22 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id EB3CFC36AE8;
        Tue, 28 Dec 2021 17:30:14 +0000 (UTC)
Date:   Tue, 28 Dec 2021 17:35:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 00/23] counter: cleanups and device lifetime fixes
Message-ID: <20211228173558.3702faa2@jic23-huawei>
In-Reply-To: <c8f6446e-748b-5845-ae60-5d6b8f3e8d39@metafoo.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <c8f6446e-748b-5845-ae60-5d6b8f3e8d39@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 13:25:25 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 12/27/21 10:45 AM, Uwe Kleine-König wrote:
> > [...]
> >
> >   - I wonder why counter is a bus and not a class device type. There is
> >     no driver that would ever bind a counter device, is there? So
> >     /sys/bus/counter/driver is always empty.
> >  
> There used to be a time when GKH said that we do not want new driver 
> classes. And all new subsystems should use bus since bus is a superset 
> of class. This restriction has been eased since then.
> 
> But it was around when the IIO subsystem was merged and since the 
> counter subsystem originated from the IIO subsystem I assume it just 
> copied this.
> 

Yup. Discussion about this back then with one view being there
should never have been class in the first place.

https://lore.kernel.org/lkml/4B571DA4.6070603@cam.ac.uk/

For anyone who loves the history of these things...

FWIW I think Greg suggested IIO should be a bus because we were hanging
a bunch of different types of device off a class and it was getting messy.
Kay then gave some history on class vs bus and suggested no new
subsystem should use class.

Ah well, opinions change over time!

Also interesting to see we were discussing a bridge to input all that
time ago and it's still not gone beyond various prototypes (with
exception of touch screens).

Jonathan
