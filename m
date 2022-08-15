Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4E1593293
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiHOPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiHOPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:55:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5191A05A;
        Mon, 15 Aug 2022 08:55:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 26F5656D;
        Mon, 15 Aug 2022 17:54:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1660578899;
        bh=S8j7GbNbq17SRBvgGdMvUVVVDhDYQu28yqUMRIme4pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkMqLgeA3Hlou6eQxDNwuj/cAMOGRuZWf6psOJwAoE+lkqdgWTBYLUFWFiFmirC11
         MV/sX2S9rJ9pHMvTFjbnnwFQbUhcqWxVXtYbPHGpZY4nQn8qmWU8YDavgsBevmlt5n
         2eecXKodkdAhl5/HdCyGSGest6FWKhs5flNo+vq8=
Date:   Mon, 15 Aug 2022 18:54:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mark Brown <broonie@kernel.org>
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
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-hwmon@vger.kernel.org, linux-clk@vger.kernel.org,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Robert Foss <robert.foss@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        David Airlie <airlied@linux.ie>, linux-iio@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/7] Devm helpers for regulator get and enable
Message-ID: <YvpsRbguMXn74GhR@pendragon.ideasonboard.com>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
 <166057828406.697572.228317501909350108.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <166057828406.697572.228317501909350108.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 04:44:44PM +0100, Mark Brown wrote:
> On Fri, 12 Aug 2022 13:08:17 +0300, Matti Vaittinen wrote:
> > Devm helpers for regulator get and enable
> > 
> > First patch in the series is actually just a simple documentation fix
> > which could be taken in as it is now.
> > 
> > A few* drivers seem to use pattern demonstrated by pseudocode:
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> 
> Thanks!
> 
> [1/7] docs: devres: regulator: Add missing devm_* functions to devres.rst
>       commit: 9b6744f60b6b47bc0757a1955adb4d2c3ab22e13
> [2/7] regulator: Add devm helpers for get and enable
>       (no commit info)

I didn't have time to reply to the series yet, but I think this isn't a
great idea. There are two issues:

- With devres, you don't have full control over the order in which
  resources will be released, which means that you can't control the
  power off sequence, in particular if it needs to be sequenced with
  GPIOs and clocks. That's not a concern for all drivers, but this API
  will creep in in places where it shouldn't be used, driver authours
  should really pay attention to power management and not live with the
  false impression that everything will be handled automatically for
  them. In the worst cases, an incorrect power off sequence could lead
  to hardware damage.

- Powering regulators on at probe time and leaving them on is a very bad
  practice from a power management point of view, and should really be
  discouraged. Adding convenience helpers to make this easy is the wrong
  message, we should instead push driver authors to implement proper
  runtime PM.

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.

-- 
Regards,

Laurent Pinchart
