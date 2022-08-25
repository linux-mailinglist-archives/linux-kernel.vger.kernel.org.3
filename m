Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F2D5A0C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiHYJCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiHYJCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:02:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E7211C21
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:02:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oR8kF-0000gi-L7; Thu, 25 Aug 2022 11:01:47 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oR8kE-0006VQ-KU; Thu, 25 Aug 2022 11:01:46 +0200
Date:   Thu, 25 Aug 2022 11:01:46 +0200
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
Message-ID: <20220825090146.62qsg4ve4j62k76f@pengutronix.de>
References: <AM6PR04MB6053E26CB59410EBCC2C93AEE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220823091027.ezyxkn64asajvjom@pengutronix.de>
 <20220823120219.GA203169@roeck-us.net>
 <AM6PR04MB60535EC5B774004AF996BDA5E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220824080338.humjny4fabhmx3z7@pengutronix.de>
 <AM6PR04MB6053D8E0A9AD24757095BFB5E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220824090622.ubbuf4doyul7d42r@pengutronix.de>
 <AM6PR04MB605317170101019C75BA9290E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220825075016.rhwvlfl6xv2ibro3@pengutronix.de>
 <AM6PR04MB605318CED02AEA616D820D83E2729@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB605318CED02AEA616D820D83E2729@AM6PR04MB6053.eurprd04.prod.outlook.com>
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

On 22-08-25, Alice Guo (OSS) wrote:
> 
> > -----Original Message-----
> > From: Marco Felsch <m.felsch@pengutronix.de>
> > Sent: Thursday, August 25, 2022 3:50 PM
> > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>; wim@linux-watchdog.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> > linux-watchdog@vger.kernel.org
> > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
> > unlock sequence
> > 
> > On 22-08-24, Alice Guo (OSS) wrote:
> > >
> > > > -----Original Message-----
> > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > > Sent: Wednesday, August 24, 2022 5:06 PM
> > > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > > Cc: Guenter Roeck <linux@roeck-us.net>; wim@linux-watchdog.org;
> > > > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > > dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> > > > linux-watchdog@vger.kernel.org
> > > > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory
> > > > barrier for unlock sequence
> > > >
> > > > Hi Alice,
> > > >
> > > > On 22-08-24, Alice Guo (OSS) wrote:
> > > > > > -----Original Message-----
> > > > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > > > > Sent: Wednesday, August 24, 2022 4:04 PM
> > > > > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > > > > Cc: Guenter Roeck <linux@roeck-us.net>; wim@linux-watchdog.org;
> > > > > > shawnguo@kernel.org; s.hauer@pengutronix.de;
> > festevam@gmail.com;
> > > > > > linux-arm-kernel@lists.infradead.org;
> > > > > > linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > > > > > kernel@pengutronix.de; linux-watchdog@vger.kernel.org
> > > > > > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory
> > > > > > barrier for unlock sequence
> > > > > >
> > > > > > Hi Alice,
> > > > > >
> > > > > > On 22-08-24, Alice Guo (OSS) wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > > > > Hi Guenter and Marco,
> > > > > > > > > >
> > > > > > > > > > 1. did you see any issues?
> > > > > > > > > > This WDOG Timer first appeared in i.MX7ULP, no one
> > > > > > > > > > report issues probably because few people use i.MX7ULP.
> > > > > > > > > > This issue was found when we did a stress test on it.
> > > > > > > > > > When we reconfigure the WDOG Timer, there is a certain
> > > > > > > > > > probability that it reset. The reason for the error is
> > > > > > > > > > that when WDOG_CS[CMD32EN] is 0, the unlock sequence is
> > > > > > > > > > two 16-bit writes (0xC520, 0xD928) to the CNT register
> > > > > > > > > > within 16 bus clocks, and improper unlock sequence
> > > > > > > > > > causes the
> > > > > > WDOG to reset.
> > > > > > > > > > Adding mb() is to guarantee that two 16-bit writes are
> > > > > > > > > > finished within 16
> > > > > > > > bus clocks.
> > > > > > > > >
> > > > > > > > > After this explanation the whole imx7ulp_wdt_init() seems
> > > > > > > > > a bit buggy because writel_relaxed() as well as writel()
> > > > > > > > > are 32bit access
> > > > > > functions.
> > > > > > > > > So the very first thing to do is to enable the 32-bit mode.
> > > > > > > > >
> > > > > > > > Agreed. This is much better than having extra code to deal
> > > > > > > > with both 16-bit and 32-bit access.
> > > > > > > >
> > > > > > > > > Also this is a explanation worth to be added to the commit
> > > > > > > > > message
> > > > > > > > > ;)
> > > > > > > > >
> > > > > > > >
> > > > > > > > Definitely. Also, the use of mb(), if it should indeed be
> > > > > > > > needed, would have to be explained in a code comment.
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Guenter
> > > > > > >
> > > > > > > Hi Marco and Guenter,
> > > > > > >
> > > > > > > Thank you for your comments. I plan to enable support for
> > > > > > > 32-bit unlock command write words in bootloader. In this way,
> > > > > > > there is no need to distinguish whether the unlock command is
> > > > > > > a 32-bit command or a 16-bit command in driver.
> > > > > >
> > > > > > Please don't move this into the bootloader, enabling it within
> > > > > > the init seq. is just fine. If you move it into the bootloader
> > > > > > then you can't ensure that the bit is set since there are plenty
> > > > > > of bootloaders out
> > > > there.
> > > > > >
> > > > > > As I said, just drop the "16bit" unlock sequence from the init
> > > > > > function because the unlock is handled just fine in all the
> > watchdog_ops.
> > > > > >
> > > > > > Regards,
> > > > > >   Marco
> > > > >
> > > > > Hi Marco,
> > > > >
> > > > > Sorry, I did not tell you that all watchdog control bits, timeout
> > > > > value, and window value cannot be set until the watchdog is unlocked.
> > > >
> > > > You don't have to according the RM:
> > > > 8<------------------------------------------------------------------
> > > > ----
> > > > 59.5.2 Disable Watchdog after Reset
> > > >
> > > > All of watchdog registers are unlocked by reset. Therefore, unlock
> > > > sequence is unnecessary, but it needs to write all of watchdog
> > > > registers to make the new configuration take effect. The code
> > > > snippet below shows an example of disabling watchdog after reset.
> > > > 8<------------------------------------------------------------------
> > > > ----
> > > >
> > > > also the RM tells us:
> > > > 8<------------------------------------------------------------------
> > > > ----
> > > > 59.4.3.1 Configuring the Watchdog Once
> > > >
> > > > The new configuration takes effect only after all registers except
> > > > CNT are written after reset. Otherwise, the WDOG uses the reset
> > > > values by default. If window mode is not used (CS[WIN] is 0),
> > > > writing to WIN is not required to make the new configuration take effect.
> > > > 8<------------------------------------------------------------------
> > > > ----
> > > >
> > > > > Support for 32-bit unlock command write words in enabled in
> > > > > imx7ulp_wdt_init now.
> > > >
> > > > So.. after reading the IMX7ULP RM, which was not my intention, I
> > > > found out that most of the WDOG_CS regiter bits are write-once bits.
> > > > This means if you didn't set it within the bootloader you still in case
> > "59.4.3.1".
> > > >
> > > > So the imx7ulp_wdt_init() function just needs to check if the
> > > > WDOG_CS_UPDATE bit was set. If it is not the case, then you need to
> > > > write the WDOG_CS register as currently done. If the bit is set,
> > > > than you need know that the bootloader did the job for you and you
> > > > can exit
> > > > imx7ulp_wdt_init() early. In both cases the unlock is not required.
> > > >
> > > > Can you please check/test if this is working for you?
> > > >
> > > > Regards,
> > > >   Marco
> > > >
> > >
> > > Hi Marco,
> > >
> > > Rom code has already configured the WDOG once, so we cannot use "
> > > Configuring the Watchdog Once".
> > 
> > What? How does the ROM code configure the WDOG? Also this would be
> > worth a comment within the code. Also still assume that this "16bit unlock"
> > seq.
> > is useless since you writing 32bit anyway.
> > 
> > Regards,
> >   Marco
> 
> Hi Marco,
> 
> The ROM code of i.MX7ULP configures the WDOG to support 16-bit unlock
> command. I plan to add a comment to explain it in code, and keep
> "mb(); writel_relaxed; writel_relaxed; mb()" unchanged.

As said, the writel_relaxed() is also 32bit writes. Please just use the
correct APIs for the stuff you wanna do. In your case, if you want 16bit
access functions you need to use writew() function and you can drop the
mb(). But after reading the RM again, I think you can go with writel()
since 32bit writes are okay, but you need to pass the two 16bit unlock
commands. For that you just need to ensure that the timing is correct,
as noted in the RM.

Also I read that the WDOG1 is only programmed in serial downloader mode
to reset the device if no activity was found on the serial/usb bus. Also
this only happen if the fuse for it was burned, but the RM says also:
"The watchdog is enabled by default after reset.". Can you please read
the Watchdog status register and post it here?

Also after after reading the RM I found the ULK bit "This read-only bit
indicates whether WDOG is unlocked or not." If this bit is 0 the device
is locked and we need a unlock command else we can just write the config
to the device. The unlock command can than be: two writel() commands
which are adding the barriers for free.

Regards,
  Marco


> Best Regards,
> Alice Guo
> 
> 
> 
> 
> 
> 
> 
> 
> 
