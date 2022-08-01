Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D3C5863FF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbiHAGUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239816AbiHAGU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:20:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6851E42
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:20:12 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oIOmY-0002T6-6k; Mon, 01 Aug 2022 08:20:02 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oIOmS-0001nM-L1; Mon, 01 Aug 2022 08:19:56 +0200
Date:   Mon, 1 Aug 2022 08:19:56 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
Message-ID: <20220801061956.3wkakhwatvqlngff@pengutronix.de>
References: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 22-07-30, Adam Ford wrote:
> Hey all,
> 
> I am trying to test Jagan's patch series [1] to add support for the
> samsung dsim bridge which is used on the imx8mm to output DSI video.
> The DSIM gets the video from the mxsfb, and in my case, the DSI is
> sent to the adv7535 for connecting to HDMI.

So you're using the NXP recommended evalboard setup :)

> I have been able to get the device tree setup and I don't get any
> errors.  The Linux system appears to think the video is connected as
> determined by modetest:

...

> Unfortunately, there is no video in my monitor, and my monitor states
> there is no signal.

This is pretty much known, at least on our side. We also have a few more
patches on top of the series [1] for fixing the horizontal porches.  Our
current status is that we can get only one mode out of the ADV7535 which
is 1080P. Our assumption is that the ADV7535 needs some attentions
(fixes) but we can't verify that since the documentation is under NDA.

> If I use NXP's downstream kernel, this same hardware configuration
> works fine and I can see the video.

This is because of the NXP downstream kernel porch 'calculation' and
workarounds. The values they are using for calculation don't take any
mode values into account and instead they are using a table. We don't
know where those values come from.

> I have checked the clk_summary, and the working and non-working
> conditions both have clock rates that are the same for DSI, LCDIF and
> related items.  The power domains connected to the lcdif and the dsi
> show they are active.
> 
> Since I go no errors, and  Linux looks like it's happy, I was hoping
> someone from who better understands the interconnections between all
> these bridge layers might be able to offer a suggestion of something
> to investigate and/or try.
> 
> The kernel repo I am using is from Jagan located here:
> 
> [1] - https://github.com/openedev/kernel
> 
> I am not convinced it's a device tree issue since I get no errors when
> the drivers enumerate, but I can provide my device tree updates if
> that helps.

Please see above. Our debugging showed that there is a strange behaviour
of the ADV7535 but we don't have any documentation.

Regards,
  Marco
