Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75FB59970F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347327AbiHSIGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347315AbiHSIGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:06:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D85DC0BB
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:06:36 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oOx1P-0002ww-4l; Fri, 19 Aug 2022 10:06:27 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oOx1O-0000fi-Lu; Fri, 19 Aug 2022 10:06:26 +0200
Date:   Fri, 19 Aug 2022 10:06:26 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 4/4] media: mt9m111: remove .s_power callback
Message-ID: <20220819080626.34ghffj6hmkk5ntm@pengutronix.de>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-4-m.felsch@pengutronix.de>
 <20220818161408.76ofg2rjvp5whtof@uno.localdomain>
 <20220819071832.3mr7u7jhp2ud4fv6@pengutronix.de>
 <20220819073512.ulud7ppnrudxewdn@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819073512.ulud7ppnrudxewdn@uno.localdomain>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-19, Jacopo Mondi wrote:
> Hi Marco
> 
> On Fri, Aug 19, 2022 at 09:18:32AM +0200, Marco Felsch wrote:
> > Hi Jacopo,
> >
> > thanks for your fast feedback :)
> >
> > On 22-08-18, Jacopo Mondi wrote:
> > > Hi Marco
> > >
> > > On Thu, Aug 18, 2022 at 04:47:12PM +0200, Marco Felsch wrote:
> > > > This is in preparation of switching to the generic dev PM mechanism.
> > > > Since the .s_power callback will be removed in the near future move the
> > > > powering into the .s_stream callback. So this driver no longer depends
> > > > on the .s_power mechanism.
> > > >
> > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > >
> > > If you want to move to runtime_pm, I would implement it first and have
> > > s_power call the _resume and _suspend routines, as some platform
> > > drivers still use s_power() and some of them might depend on it.
> >
> > Do we really have platforms which depend on this? IMHO if that is the
> 
> $ git grep "v4l2_subdev_call(.*, s_power" drivers/media/platform/  | cut -d : -f1 | uniq  | wc -l
> 8
> 
> > case than we should fix those platfoms. Since new drivers shouldn't use
> > this callback anymore.
> 
> Patches are clearly welcome I guess..

:)

> > In my case, I worked on [1] and wondered why the sensor was enabled
> > before I told him to do so. Since I didn't implement the s_power()
> > callback, I had no chance to get enabled before.
> >
> 
> I'm not sure I got this part

What I mean is, that the MT9M131 sensor gets enabled and immediately
start sending frames before I told him to do so e.g. by calling
s_stream(). This can confuse the downstream device. The only way to get
enable the downstream device first is to add the s_power() callback.

> > Can we please decide:
> >  - Do we wanna get rid of the s_power() callback?
> 
> I think that would be everyone's desire, but drivers have to be moved
> away from it
> 
> >  - If not, how do we handle those devices then with drivers not
> >    implementing this callback?
> 
> By maintaining compatibility. I suggested to move to runtime_pm() and
> wrap _resume/_suspend in s_power(). 

But then you're introducing new drivers with s_power() callbacks and so
the behaviour isn't really changed.

> My understanding is that the two (runtime_pm/s_power) are mutually
> exclusive, but even if that was not the case, runtime_pm is reference
> counted, hence as long as calls are balanced this should work, right ?

Right but the s_power() behaviour is not changed and drivers still rely
on it to work as right now.

Regards,
  Marco
