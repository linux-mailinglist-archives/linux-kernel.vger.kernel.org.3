Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C6359BAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiHVIA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiHVIA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:00:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD9628713
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:00:26 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oQ2Lz-0002bL-TJ; Mon, 22 Aug 2022 10:00:11 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oQ2Ly-0006TF-A2; Mon, 22 Aug 2022 10:00:10 +0200
Date:   Mon, 22 Aug 2022 10:00:10 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
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
Message-ID: <20220822080010.ecdphpm3i26cco5f@pengutronix.de>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-3-alice.guo@oss.nxp.com>
 <20220816062330.z2fvurteg337krw2@pengutronix.de>
 <AM6PR04MB60537292F559EC012F0EB510E2719@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB60537292F559EC012F0EB510E2719@AM6PR04MB6053.eurprd04.prod.outlook.com>
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

On 22-08-22, Alice Guo (OSS) wrote:
> > -----Original Message-----
> > From: Marco Felsch <m.felsch@pengutronix.de>
> > Sent: Tuesday, August 16, 2022 2:24 PM
> > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > Cc: wim@linux-watchdog.org; linux@roeck-us.net; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; festevam@gmail.com;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> > linux-watchdog@vger.kernel.org
> > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
> > unlock sequence
> > 
> > On 22-08-16, Alice Guo (OSS) wrote:
> > > From: Jacky Bai <ping.bai@nxp.com>
> > >
> > > Add explict memory barrier for the wdog unlock sequence.
> > 
> > Did you inspected any failures? It's not enough to say what you did, you need
> > to specify the why as well.
> > 
> > Regards,
> >   Marco
> 
> Hi,
> 
> Two 16-bit writes of unlocking the Watchdog should be completed within a certain time. The first mb() is used to ensure that previous instructions are completed.
> The second mb() is used to ensure that the unlock sequence cannot be affected by subsequent instructions. The reason will be added in the commit log of v2.

Hi,

I know what memory barriers are. My question was, did you see any
issues? Since the driver is used mainline and no one reported issues.

Also just don't use the *_relaxed() versions is more common, than adding
mb() calls around *_relaxed() versions.

Regards,
  Marco

> 
> Best Regards,
> Alice Guo
> 
> > 
> > >
> > > Suggested-by: Ye Li <ye.li@nxp.com>
> > > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > Reviewed-by: Ye Li <ye.li@nxp.com>
> > > ---
> > >  drivers/watchdog/imx7ulp_wdt.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/watchdog/imx7ulp_wdt.c
> > > b/drivers/watchdog/imx7ulp_wdt.c index 014f497ea0dc..b8ac0cb04d2f
> > > 100644
> > > --- a/drivers/watchdog/imx7ulp_wdt.c
> > > +++ b/drivers/watchdog/imx7ulp_wdt.c
> > > @@ -179,9 +179,13 @@ static int imx7ulp_wdt_init(void __iomem *base,
> > unsigned int timeout)
> > >  	int ret;
> > >
> > >  	local_irq_disable();
> > > +
> > > +	mb();
> > >  	/* unlock the wdog for reconfiguration */
> > >  	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> > >  	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> > > +	mb();
> > > +
> > >  	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
> > >  	if (ret)
> > >  		goto init_out;
> > > --
> > > 2.17.1
> > >
> > >
> > >
> 
