Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99855448B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350231AbiFVIIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiFVIIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:08:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6F735DE9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:08:15 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1o3vPI-0003t3-C9; Wed, 22 Jun 2022 10:08:12 +0200
Message-ID: <abbc4d80377dcf5393afa143f9d3542cd2cd45a7.camel@pengutronix.de>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Date:   Wed, 22 Jun 2022 10:08:10 +0200
In-Reply-To: <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
         <20220620134758.1286480-2-aisheng.dong@nxp.com>
         <YrCM0reni+x/KWsG@sirena.org.uk>
         <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
         <YrCXILblKsp6DuN3@sirena.org.uk>
         <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
         <YrCznap77OyHu4bO@sirena.org.uk>
         <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
         <YrHkXH1M4NydBfQT@sirena.org.uk>
         <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
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

Hi Aisheng, hi Mark,

Am Dienstag, dem 21.06.2022 um 18:16 +0000 schrieb Aisheng Dong:
> > From: Mark Brown <broonie@kernel.org>
> > Sent: Tuesday, June 21, 2022 11:32 PM
> > 
> > On Tue, Jun 21, 2022 at 02:56:58PM +0000, Aisheng Dong wrote:
> > 
> > > > so if we can't satisfy the read from the cache then we'll hit
> > > > the
> > > > cache_only check and return -EBUSY before we start trying to do
> > > > any
> > > > physical I/O.  The debugfs code will handle that gracefully,
> > > > indicating that it couldn't get a value for the volatile
> > > > register by
> > > > showing all Xs for the value.  If none of the registers are
> > > > cached
> > > > then the file won't be terribly useful but it at least
> > > > shouldn't cause any
> > errors with accessing the device when it's powered down.
> > 
> > > That means we have to use cache_only mode to workaround the
> > > issue, right?
> > > I saw that cache_only mode has to be explicated enable/disable by
> > > driver, commonly used in device rpm in kernel right now.
> > 
> > Yes.
> > 
> > > However, things are a little bit complicated on i.MX that 1) imx
> > > blkctl needs follow strict registers r/w flow interleaved with
> > > handshakes with upstream gpc power operations and delay may be
> > > needed
> > > between registers writing
> > > 2) blkctl itself does not enable runtime pm, it simply call rpm
> > > to
> > > resume upstream power domains devices and necessary clocks before
> > > r/w
> > registers.
> > 
> > I'm not sure I fully understand the issue here?  If the driver can
> > safely manage
> > the hardware surely it can safely manage cache only mode too?  If
> > there are
> > duplicate resumes then cache only enable/disable is a boolean flag
> > rather than
> > refcounted so that shouldn't be a problem.
> > 
> 
> I still can't see an easy and safe to way to do it.
> What I'm wondering is whether it's worth to do it if need to
> introducing considerable
> complexities in driver to overcome this issue if it can be simply
> disabled.
> Anyway, I will try to investigate it.
> 
> > > Furthermore, current imx blkctl is a common driver used by many
> > > devices
> > [1].
> > > Introducing volatile registers and cache may bloat the driver a
> > > lot
> > unnecessarily.
> > 
> > You don't actually need to have a cache to use cache only mode, if
> > there are
> > no cached registers then you'll just get -EBUSY on any access to
> > the registers
> > but that's hopefully fine since at the minute things will just fall
> > over anyway.
> > You shouldn't even need to flag registers as volatile if there's no
> > cache since it's
> > not really relevant without a cache.
> > 
> 
> After a quick try initially, I found two issues:
> 1. There's a warning dump if using cache_only without cache
> void regcache_cache_only(struct regmap *map, bool enable)
> {
>         map->lock(map->lock_arg);
>         WARN_ON(map->cache_bypass && enable);
>         ...
> }
> 2. It seems _regmap_write() did not handle cache_only case well
> without cache.
> It may still writes HW even for cache_only mode?
> 
> I guess we may need fix those two issues first before we can safely
> use it?
> 
Why would you write to a cache only regmap. The debugfs interface only
allows to dump the registers, no?

I think it wouldn't be too hard to fix this for the blk-ctrl drivers.
I'll give it a try today.

> > > The simplest way for i.MX case may be just disabling debugfs as
> > > it
> > > can't reflect the actually HW state without power. So we would
> > > wish the
> > regmap core could provide an option to users.
> > 
> > The goal here is to describe the regmap itself so that there's less
> > fragility as
> > things change and we don't needlessly disable anything else that
> > happens to
> > be added to debugfs in the future due to having an overly generic
> > flag, and we
> > get the ability to directly catch access to the hardware that
> > misses doing
> > power management properly while we're at it.
> > 
> > We already have a way to describe it being unsafe to access the
> > hardware, we
> > may as well use it.
> > 
> > > And I noticed that syscon [2] seems have the same issue since the
> > > following
> > commit:
> > 
> > > commit 9b947a13e7f6017f18470f665992dbae267852b3
> > > Author: David Lechner <david@lechnology.com>
> > > Date:   Mon Feb 19 15:43:02 2018 -0600
> > 
> > >     regmap: use debugfs even when no device
> > 
> > >     This registers regmaps with debugfs even when they do not
> > > have an
> > >     associated device. For example, this is common for syscon
> > > regmaps.
> > 
> > That's a different thing, that's due to us naming the directory
> > after the struct
> > device but syscons being created before we have that struct device
> > available.
> 
> Yes, but syscon has the same issue that the system may hang if dump
> registers
> through debugfs without power on.
> How would you suggest for this case as syscon is also a common
> driver?
> 
This is a general issue. If something uses a syscon that is inside a
power-domain where the runtime PM is controlled by some other entity,
how is it safe to use the syscon at all? Every access might end up
locking up the system. So those syscons really need to learn some kind
of runtime PM handling.

Regards,
Lucas


