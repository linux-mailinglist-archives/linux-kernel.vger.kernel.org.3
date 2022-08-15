Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A9594D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbiHPBOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350844AbiHPBMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:12:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C09E2C52;
        Mon, 15 Aug 2022 13:58:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEACE612D1;
        Mon, 15 Aug 2022 20:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308B1C433D6;
        Mon, 15 Aug 2022 20:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660597137;
        bh=P12qdTrR/mo6a+68fRbwwR4HzHO3gQf0fab4VOnBYgI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BcsIiow7hvM6mlGnKs9wh7ZNo2tlc/huKm2krV8jvy09DrS5X70XXaode4XGPfimB
         oIiJ+10bBwXDKsn5AbMelcUhpMOWN2/rU3AxHTJeWEodJRtJ3ubT5keZ3PbCd1hYrQ
         DRTuL3P+/cj8v7Zs5y6I2kiDvUu6ezkXlmk6ePkmeyDMXUj1w1YTacEYoloze0OBOa
         nOUelwRoboaZyN2aMfvd3uTosB6wQr9Lw5Mxt1a/87W3S1wZCp39lL6lu4k296IxCM
         Q3SeeLM+vl6MYUK3MqwQgB1RuCzKtXb/n/RUO+gjRl5Tklq4D0IgZdSZlwdWhpsMCY
         EWQsEDwVk9dPw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YvqV9Mq6I3gXQaf2@pendragon.ideasonboard.com>
References: <cover.1660292316.git.mazziesaccount@gmail.com> <166057828406.697572.228317501909350108.b4-ty@kernel.org> <YvpsRbguMXn74GhR@pendragon.ideasonboard.com> <Yvp1Qkuh7xfeb/B2@sirena.org.uk> <YvqV9Mq6I3gXQaf2@pendragon.ideasonboard.com>
Subject: Re: (subset) [PATCH v2 0/7] Devm helpers for regulator get and enable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        dri-devel@lists.freedesktop.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-amlogic@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Michael Turq uette <mturquette@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-hwmon@vger.kernel.org, linux-clk@vger.kernel.org,
        Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>,
        Robert Foss <robert.foss@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        David Airlie <airlied@linux.ie>, linux-iio@vger.kernel.org
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Brown <broonie@kernel.org>
Date:   Mon, 15 Aug 2022 13:58:55 -0700
User-Agent: alot/0.10
Message-Id: <20220815205857.308B1C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Laurent Pinchart (2022-08-15 11:52:36)
> Hi Mark,
>=20
> On Mon, Aug 15, 2022 at 05:33:06PM +0100, Mark Brown wrote:
> > On Mon, Aug 15, 2022 at 06:54:45PM +0300, Laurent Pinchart wrote:
> >=20
> > > - With devres, you don't have full control over the order in which
> > >   resources will be released, which means that you can't control the
> > >   power off sequence, in particular if it needs to be sequenced with
> > >   GPIOs and clocks. That's not a concern for all drivers, but this API
> > >   will creep in in places where it shouldn't be used, driver authours
> > >   should really pay attention to power management and not live with t=
he
> > >   false impression that everything will be handled automatically for
> > >   them. In the worst cases, an incorrect power off sequence could lead
> > >   to hardware damage.

I think the main issue is that platform drivers are being asked to do
too much. We've put the burden on platform driver authors to intimately
understand how their devices are integrated, and as we all know they're
not very interested in these details because they already have a hard
time to write a driver just to make their latest gizmo whir. Throw in
power management and you get these wrappers that try to compartmentalize
power management logic away from the main part of the driver that's
plugging into the driver subsystem because the SoC integration logic is
constantly changing but the device core isn't.

We need to enhance the platform bus layer to make it SoC aware when the
platform device is inside an SoC, or "board" aware when the device lives
outside of an SoC, i.e. it's a discrete IC. The bus layer should manage
power state transitions for the platform devices, and the platform
drivers should only be able to request runtime power/performance state
changes through device PM APIs (dev_pm_*). If this can all be done
through genpds then it sounds great. We may need to write some generic
code for discrete ICs that enables regulators and then clks before
muxing out pins or something like that. Obviously, I don't have all the
details figured out.

The basic idea is that drivers should be focused on what they're
driving, not navigating the (sometimes) complex integration that's
taking place around them. When a device driver probe function is called
the device should already be powered on. When the driver is
removed/unbound, the power should be removed after the driver's remove
function is called. We're only going to be able to solve the power
sequencing and ordering problem by taking away power control and
sequencing from drivers.

> >=20
> > I basically agree with these concerns which is why I was only happy with
> > this API when Matti suggested doing it in a way that meant that the
> > callers are unable to access the regulator at runtime, this means that
> > if anyone wants to do any kind of management of the power state outside
> > of probe and remove they are forced to convert to the full fat APIs.
> > The general ordering concern with devm is that the free happens too late
> > but for the most part this isn't such a concern with regulators, they
> > might have delayed power off anyway due to sharing - it's no worse than
> > memory allocation AFAICT.  Given all the other APIs using devm it's
> > probably going to end up fixing some bugs.
> >=20
> > For sequencing I'm not convinced it's much worse than the bulk API is
> > anyway, and practically speaking I expect most devices that have
> > problems here will also need more control over power anyway - it's
> > certainly the common case that hardware has pretty basic requirements
> > and is fairly tolerant.
>=20
> I'm not extremely concerned here at the moment, as power should be the
> last thing to be turned off, after clocks and reset signals. As clocks
> and GPIOs will still be controlled manually in the driver .remove()
> function, it means that power will go last, which should be fine.
> However, should a devm_clk_get_enable() or similar function be

This API is implemented now.

> implemented, we'll run into trouble. Supplying active high input signals
> to a device that is not powered can lead to latch-up, which tends to
> only manifest after a statistically significant number of occurrences of
> the condition, and can slowly damage the hardware over time. This is a
> real concern as it will typically not be caught during early
> development. I think we would still be better off with requiring drivers
> to manually handle powering off the device until we provide a mechanism
> that can do so safely in an automated way.

Can you describe the error scenario further? I think it's driver author
error that would lead to getting and enabling the regulator after
getting and enabling a clk that drives out a clock signal on some pins
that aren't powered yet. I'm not sure that's all that much easier to do
with these sorts of devm APIs, but if it is then I'm concerned.

>=20
> > > - Powering regulators on at probe time and leaving them on is a very =
bad
> > >   practice from a power management point of view, and should really be
> > >   discouraged. Adding convenience helpers to make this easy is the wr=
ong
> > >   message, we should instead push driver authors to implement proper
> > >   runtime PM.
> >=20
> > The stick simply isn't working here as far as I can see.
>=20
> Do you think there's no way we can get it to work, instead of giving up
> and adding an API that goes in the wrong direction ? :-( I'll give a
> talk about the dangers of devm_* at the kernel summit, this is something
> I can mention to raise awareness of the issue among maintainers,
> hopefully leading to improvements through better reviews.
>=20

I agree with Mark, the stick isn't working. We discussed these exact
same issues for years with the devm clk get APIs. Search the archives.
