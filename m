Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4E859F4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiHXIEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiHXID6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:03:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4986054
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:03:57 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oQlMR-0008Gu-Vj; Wed, 24 Aug 2022 10:03:39 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oQlMQ-0002AW-S9; Wed, 24 Aug 2022 10:03:38 +0200
Date:   Wed, 24 Aug 2022 10:03:38 +0200
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
Message-ID: <20220824080338.humjny4fabhmx3z7@pengutronix.de>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-3-alice.guo@oss.nxp.com>
 <20220816062330.z2fvurteg337krw2@pengutronix.de>
 <AM6PR04MB60537292F559EC012F0EB510E2719@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220822080010.ecdphpm3i26cco5f@pengutronix.de>
 <20220822140347.GA4087281@roeck-us.net>
 <AM6PR04MB6053E26CB59410EBCC2C93AEE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220823091027.ezyxkn64asajvjom@pengutronix.de>
 <20220823120219.GA203169@roeck-us.net>
 <AM6PR04MB60535EC5B774004AF996BDA5E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB60535EC5B774004AF996BDA5E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
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

Hi Alice,

On 22-08-24, Alice Guo (OSS) wrote:

...

> > > > Hi Guenter and Marco,
> > > >
> > > > 1. did you see any issues?
> > > > This WDOG Timer first appeared in i.MX7ULP, no one report issues
> > > > probably because few people use i.MX7ULP. This issue was found when
> > > > we did a stress test on it. When we reconfigure the WDOG Timer,
> > > > there is a certain probability that it reset. The reason for the
> > > > error is that when WDOG_CS[CMD32EN] is 0, the unlock sequence is two
> > > > 16-bit writes (0xC520, 0xD928) to the CNT register within 16 bus
> > > > clocks, and improper unlock sequence causes the WDOG to reset.
> > > > Adding mb() is to guarantee that two 16-bit writes are finished within 16
> > bus clocks.
> > >
> > > After this explanation the whole imx7ulp_wdt_init() seems a bit buggy
> > > because writel_relaxed() as well as writel() are 32bit access functions.
> > > So the very first thing to do is to enable the 32-bit mode.
> > >
> > Agreed. This is much better than having extra code to deal with both 16-bit
> > and 32-bit access.
> > 
> > > Also this is a explanation worth to be added to the commit message ;)
> > >
> > 
> > Definitely. Also, the use of mb(), if it should indeed be needed, would have to
> > be explained in a code comment.
> > 
> > Thanks,
> > Guenter
> 
> Hi Marco and Guenter,
> 
> Thank you for your comments. I plan to enable support for 32-bit
> unlock command write words in bootloader. In this way, there is no
> need to distinguish whether the unlock command is a 32-bit command or
> a 16-bit command in driver.

Please don't move this into the bootloader, enabling it within the init
seq. is just fine. If you move it into the bootloader then you can't
ensure that the bit is set since there are plenty of bootloaders out
there.

As I said, just drop the "16bit" unlock sequence from the init function
because the unlock is handled just fine in all the watchdog_ops.

Regards,
  Marco
