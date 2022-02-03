Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1D54A9119
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 00:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355958AbiBCXUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 18:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiBCXUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 18:20:03 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5932DC061714;
        Thu,  3 Feb 2022 15:20:03 -0800 (PST)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AC3A83F710;
        Fri,  4 Feb 2022 00:20:01 +0100 (CET)
Date:   Fri, 4 Feb 2022 00:20:00 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <c_skakit@qti.qualcomm.com>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v11 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220203232000.btb2qt7t6rmmnayw@SoMainline.org>
References: <20220129005429.754727-1-bjorn.andersson@linaro.org>
 <20220129005429.754727-2-bjorn.andersson@linaro.org>
 <20220202111833.ibeq3udj37dkfv6l@SoMainline.org>
 <Yfrj7DnXET6fT3BX@ripper>
 <CAOCOHw7LS=NALXzHMN6LauEqrjDk2y27VoQtaT4tkHJiYxM7MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCOHw7LS=NALXzHMN6LauEqrjDk2y27VoQtaT4tkHJiYxM7MQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-02 16:08:29, Bjorn Andersson wrote:
> On Wed, Feb 2, 2022 at 2:04 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Wed 02 Feb 03:18 PST 2022, Marijn Suijten wrote:
> >
> > > On 2022-01-28 16:54:29, Bjorn Andersson wrote:
> > > > The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> > > > PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
> > > > with their output being routed to various other components, such as
> > > > current sinks or GPIOs.
> > > >
> > > > Each LPG instance can operate on fixed parameters or based on a shared
> > > > lookup-table, altering the duty cycle over time. This provides the means
> > > > for hardware assisted transitions of LED brightness.
> > > >
> > > > A typical use case for the fixed parameter mode is to drive a PWM
> > > > backlight control signal, the driver therefor allows each LPG instance
> > > > to be exposed to the kernel either through the LED framework or the PWM
> > > > framework.
> > > >
> > > > A typical use case for the LED configuration is to drive RGB LEDs in
> > > > smartphones etc, for which the driver support multiple channels to be
> > > > ganged up to a MULTICOLOR LED. In this configuration the pattern
> > > > generators will be synchronized, to allow for multi-color patterns.
> > > >
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > >
> > > Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> > >
> > > There may still be some things to improve based on whether lo_pause
> > > works in non-ping-pong mode - to alleviate the requirement for the first
> > > delta_t to be at most 512ms - but this patch should not be delayed much
> > > longer and that's perhaps for a followup patch.  Same for my request for
> > > documentation and examples which at the same time serve as some form of
> > > tests to see if everything works as desired.
> > >
> >
> > I've been considering lopause to be the value before we start the
> > pattern, but I think you're right in that it denotes how long we should
> > hold the first value.
> >
> > So I think it might make sense in the predefined "<value> <delay> <value>
> > <delay>" scheme to use first <delay> as to calculate lo-pause. I think
> > it has to be calculated, because the first value will iiuc be held
> > for (lopause + 1) * delay ms.

As mentioned in v10 that seems like a great idea, as long as we can
carefully validate and communicate these numbers to the user; both
through documentation and kernel error messages when values are
ultimately rejected.

Again, perhaps it might be better to postpone this to a separate
patchset as to not block the use of LPG for backlights which is arguably
more important than some fancy phone notification led patterns.

> > > I also vaguely remember other (downstream) drivers to support more than
> > > 512ms per step by (drastically?) changing PWM period, but not sure how
> > > that worked again nor if it was reliable.
> > >
> >
> > Thinking about it again, while 512 is the 9th bit, we should be able to
> > represent [0..1023] with 9 bits...
> >
> 
> Sorry, my mind was elsewhere as I wrote that. [0..511] is what we got.

Yes, 9 bits in total and BIT(8) being the highest settable ^^

- Marijn
