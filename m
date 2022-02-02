Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A545A4A6F71
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbiBBLDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiBBLDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:03:08 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF85C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:03:08 -0800 (PST)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 76B593F7DF;
        Wed,  2 Feb 2022 12:03:06 +0100 (CET)
Date:   Wed, 2 Feb 2022 12:03:05 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v10 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220202110305.gbow3e3stolb67v5@SoMainline.org>
References: <20211010043912.136640-1-bjorn.andersson@linaro.org>
 <20211010043912.136640-2-bjorn.andersson@linaro.org>
 <YXL0DyyPkS4/wfB7@ripper>
 <20211027211928.tjybwy2lokj6eoun@SoMainline.org>
 <YfSPYkbTXMOUGKkG@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfSPYkbTXMOUGKkG@yoga>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-28 18:50:42, Bjorn Andersson wrote:
> On Wed 27 Oct 16:19 CDT 2021, Marijn Suijten wrote:
> 
> > Hi Bjorn,
> > 
> > On 2021-10-22 10:25:35, Bjorn Andersson wrote:
> > > On Sat 09 Oct 21:39 PDT 2021, Bjorn Andersson wrote:
> > > 
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
> > > > ---
> > > 
> > > Any feedback on this?
> > 
> > I asked in #linux-msm whether anything is wrong with the patterns,
> > since my Sony Discovery (sdm630 with a pm660l) blinks way quicker on a
> > pattern that's supposed to stay on for 1s and off for 1s:
> > 
> >     echo "0 1000 255 1000" > /sys/class/leds/rgb\:status/hw_pattern
> > 
> > It however seems to be broken in the same way on an older version now
> > (this might be v9 or v8) which I don't remember to be the case.  Can you
> > double-check if this is all working fine on your side?  If so, I'll have
> > to find some time to debug it on my end.
> > 
> 
> I had missed the fact that LPG_RAMP_DURATION_REG is two registers for
> msg and lsb, for a total of 9 bits of duration. So what you saw was
> probably ticking at 232ms.
> 
> Note though that the pattern uses the last time as "high pause", so I
> expect that you should have seen 232 ms of off, followed by 464ms of
> light.

Visual inspection seems to confirm those numbers indeed!

> I've fixed this for v11, both rejecting invalid input and writing out
> all 9 bits.

Doesn't that 512ms limit, together with using only the last value for
hi_pause (and not the first value for lo_pause) force users to write
patterns in a certain way which is not easily conveyed to the caller
except by reading the comment in the driver?  I'd guess lo_pause can be
used even if not in ping-pong mode, it should just hold at the first
value for the given duration?

(That said hw_pattern is anyway already riddled with device-specific
information, such as only having one `delta_t` which functions as the
step size for every entry, and with the change above would need to be
sourced from another step that's not the first.)

Bit of a stretch, but perhaps worth noting anyway: should this be
written in documentation somewhere, together with pattern examples and
their desired outcome to function as testcases too?

- Marijn
