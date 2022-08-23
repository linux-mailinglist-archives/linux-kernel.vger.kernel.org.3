Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0E759E327
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356947AbiHWKwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350891AbiHWKo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:44:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F2974E04
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:10:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oQPvZ-0005FD-CQ; Tue, 23 Aug 2022 11:10:29 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oQPvX-0006WH-PG; Tue, 23 Aug 2022 11:10:27 +0200
Date:   Tue, 23 Aug 2022 11:10:27 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
 unlock sequence
Message-ID: <20220823091027.ezyxkn64asajvjom@pengutronix.de>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-3-alice.guo@oss.nxp.com>
 <20220816062330.z2fvurteg337krw2@pengutronix.de>
 <AM6PR04MB60537292F559EC012F0EB510E2719@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220822080010.ecdphpm3i26cco5f@pengutronix.de>
 <20220822140347.GA4087281@roeck-us.net>
 <AM6PR04MB6053E26CB59410EBCC2C93AEE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB6053E26CB59410EBCC2C93AEE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-23, Alice Guo (OSS) wrote:
> 
> 
> > -----Original Message-----
> > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > Sent: Monday, August 22, 2022 10:04 PM
> > To: Marco Felsch <m.felsch@pengutronix.de>
> > Cc: Alice Guo (OSS) <alice.guo@oss.nxp.com>; wim@linux-watchdog.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> > linux-watchdog@vger.kernel.org
> > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
> > unlock sequence
> > 
> > On Mon, Aug 22, 2022 at 10:00:10AM +0200, Marco Felsch wrote:
> > > On 22-08-22, Alice Guo (OSS) wrote:
> > > > > -----Original Message-----
> > > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > > > Sent: Tuesday, August 16, 2022 2:24 PM
> > > > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > > > Cc: wim@linux-watchdog.org; linux@roeck-us.net;
> > > > > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > > > > linux-arm-kernel@lists.infradead.org;
> > > > > linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > > > > kernel@pengutronix.de; linux-watchdog@vger.kernel.org
> > > > > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory
> > > > > barrier for unlock sequence
> > > > >
> > > > > On 22-08-16, Alice Guo (OSS) wrote:
> > > > > > From: Jacky Bai <ping.bai@nxp.com>
> > > > > >
> > > > > > Add explict memory barrier for the wdog unlock sequence.
> > > > >
> > > > > Did you inspected any failures? It's not enough to say what you
> > > > > did, you need to specify the why as well.
> > > > >
> > > > > Regards,
> > > > >   Marco
> > > >
> > > > Hi,
> > > >
> > > > Two 16-bit writes of unlocking the Watchdog should be completed within a
> > certain time. The first mb() is used to ensure that previous instructions are
> > completed.
> > > > The second mb() is used to ensure that the unlock sequence cannot be
> > affected by subsequent instructions. The reason will be added in the commit
> > log of v2.
> > >
> > > Hi,
> > >
> > > I know what memory barriers are. My question was, did you see any
> > > issues? Since the driver is used mainline and no one reported issues.
> > >
> > > Also just don't use the *_relaxed() versions is more common, than
> > > adding
> > > mb() calls around *_relaxed() versions.
> > >
> > 
> > Agreed with both. The series is a bit short in explaining _why_ the changes are
> > made.
> > 
> > Guenter
> > 
> > > Regards,
> > >   Marco
> > >
> > > >
> 
> Hi Guenter and Marco,
> 
> 1. did you see any issues?
> This WDOG Timer first appeared in i.MX7ULP, no one report issues
> probably because few people use i.MX7ULP. This issue was found when we
> did a stress test on it. When we reconfigure the WDOG Timer, there is
> a certain probability that it reset. The reason for the error is that
> when WDOG_CS[CMD32EN] is 0, the unlock sequence is two 16-bit writes
> (0xC520, 0xD928) to the CNT register within 16 bus clocks, and
> improper unlock sequence causes the WDOG to reset. Adding mb() is to
> guarantee that two 16-bit writes are finished within 16 bus clocks.

After this explanation the whole imx7ulp_wdt_init() seems a bit buggy
because writel_relaxed() as well as writel() are 32bit access functions.
So the very first thing to do is to enable the 32-bit mode.

Also this is a explanation worth to be added to the commit message ;)

> 2. Also just don't use the *_relaxed() versions is more common, than
> adding mb() calls around *_relaxed() versions.  Memory barriers cannot
> be added between two 16-bit writes. I do not know the reason.

As written above, writel() as well as writel_relaxed() are not 16-bit
access functions.

So to me it looks as you need first to ensure that 32-bit access mode is
enabled. After that you can write drop the to writel_relaxed() functions
and instead just write:

   writel(UNLOCK, wdt->base + WDOG_CNT);

Also why do we need to unlock the watchdog during imx7ulp_wdt_init()?
This is handled just fine during imx7ulp_wdt_enable() and during
imx7ulp_wdt_set_timeout(). So just drop those relaxed writes and
everything should be fine.

Regards,
  Marco
