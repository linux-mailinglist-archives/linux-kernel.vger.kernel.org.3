Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D62951DD1D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443666AbiEFQNb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 May 2022 12:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443595AbiEFQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:12:59 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8652712ACE;
        Fri,  6 May 2022 09:09:04 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3209C1C0BCD; Fri,  6 May 2022 18:09:03 +0200 (CEST)
Date:   Fri, 6 May 2022 18:09:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v14 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220506160901.GA1199@bug>
References: <20220303214300.59468-1-bjorn.andersson@linaro.org>
 <20220303214300.59468-2-bjorn.andersson@linaro.org>
 <20220504073009.GC8204@duo.ucw.cz>
 <YnKTAvQc6eDxTl14@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <YnKTAvQc6eDxTl14@ripper>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +    "255 500 0 500"
> > > +
> > > +        ^
> > > +        |
> > > +    255 +----+    +----+
> > > +        |    |    |    |      ...
> > > +      0 |    +----+    +----
> > > +        +---------------------->
> > > +        0    5   10   15     time (100ms)
> > > +
> > > +The LPG supports specifying a longer hold-time for the first and last element
> > > +in the pattern, the so called "low pause" and "high pause".
> > 
> > Please see
> > Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt . This
> > should really be compatible.
> 
> Unfortunately the LPG hardware only supports fixed duration (except for
> the ability to hold/extend the first and last duration in the pattern)
> and it also does not support gradual transition between the brightness
> levels.

Ok.

> As such the pattern sequence provided to hw_pattern looks to be the
> smae, but I don't see that it can be made compatible.
> 
> > Can I get either patch to disable pattern infrastructure for now or to
> > get it compatible?
> > 
> 
> I'd be happy to get this updated to your liking, but this was one of the
> drivers we discussed when we introduced the pattern trigger and led to
> the conclusion that we need the ability to do hw-specific patterns.
> 
> As such this document provides the hardware specific documentation, as
> we describe under "hw_pattern" in
> Documentation/ABI/testing/sysfs-class-led-trigger-pattern.
> 
> Please advice on what you would like me to do.

I'd like you to use same format leds-trigger-pattern describes.

If someone passes "255 500 0 500", that's requesting gradual transitions and
your hw can not do that. You return -EINVAL.

If someone wants that kind of blinking, they need to pass "255 0 255 500 0 0 0 500".

Best regards,
									Pavel


-- (english) http://www.livejournal.com/~pavelmachek (cesky, pictures) 
http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
