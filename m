Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29F55A1569
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiHYPPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbiHYPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:15:37 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D4A13F6A;
        Thu, 25 Aug 2022 08:15:34 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 61991240009;
        Thu, 25 Aug 2022 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661440530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=84ZmLwDIKgsqnnt6/JKYNVV5p2wu7p/YXThFoSbG1zY=;
        b=VU3rmFmycNvDDl419/SEf0QRNmaG9UlRucXib33CWOC19YV6EhHGf9uBfMvc/wIvwepCJx
        uLJ5DabslAp8P+CZi5Yt9azkF0Zuidg90TwXriVB7hyZ9/MZ7XZnXGiQkCIhQa/jLeliur
        jnvajkcEMVRIt8wr95tO/nTNl0otD570bkLNjol/AURDYEH18p0mHymvFX8NW8DaHYDVk2
        qiScBKfQWCb8XS3ooFkBciBHraGmG7jfs66dajbmyIr7/DIhdjIa7jcCWpuXGN2qr6yT5f
        4YkYd+vY04gMkpOhRf+jApAhGxCglZvN7sd8wqH28pZ1j4U6j55MJ+PSsSvPwA==
Date:   Thu, 25 Aug 2022 17:15:29 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [RESEND] rtc: hym8563: try multiple times to init device
Message-ID: <YweSEVYJtSY6G/98@mail.local>
References: <20220821122613.245026-1-linux@fw-web.de>
 <5fd3f684-1d20-c646-04a4-09f32d765f8d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd3f684-1d20-c646-04a4-09f32d765f8d@arm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 25/08/2022 15:19:02+0100, Robin Murphy wrote:
> On 2022-08-21 13:26, Frank Wunderlich wrote:
> > From: Peter Geis <pgwipeout@gmail.com>
> > 
> > RTC sometimes does not respond the first time in init.
> > Try multiple times to get a response.
> > 
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > discussion from v1
> > https://patchwork.kernel.org/project/linux-rockchip/patch/20220608161150.58919-2-linux@fw-web.de/
> > 
> > On Fri, Jul 8, 2022 at 12:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > > FWIW, given that HYM8563 is fairly common on RK3288 boards - I can't say
> > > I've ever noticed an issue with mine, for instance - it seems dubious
> > > that this would be a general issue of the chip itself. Are you sure it's
> > > not a SoC or board-level issue with the I2C bus being in a funny initial
> > > state, timings being marginal, or suchlike?
> > 
> > Peter Geis <pgwipeout@gmail.com>:
> > I don't think this is an SoC issue since this is the first instance
> > I've encountered it. Mind you we don't have the reset lines hooked up
> > at all for the Rockchip i2c driver, so it's possible that's the case,
> > but I'd imagine it would be observed more broadly if that was the
> > case. I've tried pushing the timings out pretty far as well as bumping
> > up the drive strength to no change. It seems to occur only with the
> > hym rtc used on this board. I suspect it's a new variant of the hym
> > that has slightly different behavior.
> 
> Sure, if it's documented somewhere that Hayou (or if the BPI-R2 Pro
> schematic is to be believed, AnalogTek) decided to innovate a new "sometimes
> doesn't work" feature for a chip that's been in production for a decade or
> more, and that 2 retries at 20ms intervals is what's recommended, then I'm
> open to believing that this isn't a complete hack. Or at least if someone
> can say they've scoped the pins and confirmed that nothing looks suspect at
> the protocol level when this happens that could explain it.
> 

Just to be clear, this is also my opinion and I'm not going to apply
that, especially since the IP of the RTC is not just a decade old, it is
actually from 1999. It doesn't suddenly stop working.

> Otherwise, I'll remain unconvinced that it isn't a coincidence that this has
> shown up while bringing up a new board with a new SoC, and hacking a mature
> common driver to bodge around an issue that isn't fully understood, and
> could very conceivably lie elsewhere, is not the right answer. Especially
> when it involves a board vendor... let's say, whose reputation proceeds
> them.
> 
> Since I'm not above wasting 20 minutes of my time to prove a point, for
> starters the schematic seems to imply that it's using a variant of RK809
> where LDO4, used as the I/O supply for i2c3, is off by default, so on the
> face of it it could be something as stupidly simple as the RTC probe racing
> with the PMIC or I/O domain probe. Sure, the DT claims it's already on at
> boot, but *is* it? Maybe that was true with some downstream bootloader, but
> do we know that's what you're using to boot mainline? Maybe this something
> so obvious that you've already confirmed and taken it for granted, but the
> patch as presented doesn't give me the confidence to rule *anything* out.
> 

Thanks for your input!

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
