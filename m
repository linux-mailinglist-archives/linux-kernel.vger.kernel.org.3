Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FF9586132
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiGaUHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiGaUHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:07:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B01C65DC;
        Sun, 31 Jul 2022 13:07:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7D966108F;
        Sun, 31 Jul 2022 20:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E2AC433D6;
        Sun, 31 Jul 2022 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659298052;
        bh=+qfOhp/3423pXOH1mc2GCsLtY504nNGk6+866UHD/8U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q/4PXuK6Rm1ZDU5zh+PHtVqkHDkeja0FxrqhVm6uZudzjJy+dN7y49IqpX3GLjOcV
         8s7rEFRNCfdirL0JMqdTxaeQ/cBotEp7msPl0PDKI+3ainWh1VGy/sclLGnELfCHao
         4BAI44Mu6iO+dCJhGBUYxIV3iE3Txleh1W0emyYFc/RnfD+UbUJiOQ5NB0IUZgyMgo
         +wr+R4/MF+IBurVsqO3af7YGDruWmDvQtm34ibhZcfJlvR522/Glh324xNkWvXeDxk
         aNWVpQAprEg99s2R+E9KYrrg/jzPg/BcP9FYCqsFVU4xeykTgs+ZWR2dHwW9XqWpIC
         eDMN43OtAHrLA==
Date:   Sun, 31 Jul 2022 21:17:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti =?UTF-8?B?TGVodGltw6RraQ==?= <matti.lehtimaki@gmail.com>
Cc:     linux-iio@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: st_sensors: Retry ID verification on failure
Message-ID: <20220731211743.6ab9264f@jic23-huawei>
In-Reply-To: <6c839ba3-b671-76fb-95e1-94bf2f2da303@gmail.com>
References: <20220724164316.68393-1-matti.lehtimaki@gmail.com>
        <20220731170057.2b8ac00e@jic23-huawei>
        <6c839ba3-b671-76fb-95e1-94bf2f2da303@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022 21:51:55 +0300
Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com> wrote:

> On 31.7.2022 19.00, Jonathan Cameron wrote:
> > On Sun, 24 Jul 2022 19:43:15 +0300
> > Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com> wrote:
> >  =20
> >> Some sensors do not always start fast enough to read a valid ID from
> >> registers at first attempt. Let's retry at most 3 times with short sle=
ep
> >> in between to fix random timing issues.
> >>
> >> Signed-off-by: Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com> =20
> > Hi Matti,
> >=20
> > My gut feeling is this isn't in a fast path, so why not just wait
> > for whatever the documented power up time of the sensor is?
> >=20
> > I'd expect to see a sleep in st_sensors_power_enable() if one is
> > required. =20
>=20
> In the specification for the sensor (lis2hh12) I have on my device I
> found that the maximum boot time of the sensor (starting from Vdd power
> on) is defined as 20 ms. Not sure if the other sensors supported by the
> driver have different values but based on checking a couple of
> specifications I didn't find any bigger values so far.
>=20
> >> +			msleep(20); =20
> > How do we know 60msecs is long enough for all sensors? =20
>=20
> Based on the specification for the sensor I have and also driver used in
> Android kernel for my device (it uses a 3 x 20 ms loop) I think 20 ms is
> a good value but to be sure a slightly longer might make sense. As
> suggested in the other review comment by changing the regmap_read to
> regmap_read_poll_timeout the function doesn't always need to wait at
> least 20 ms in case first read doesn't provide the correct value, if a
> suitable shorter poll interval is used (something like 1-10 ms).
>=20
> However testing on my device has shown that I still need to have a loop
> or at least a retry possibility because I have noticed a rare random
> read error (-6, happens after some time not at first read) when reading
> the id from the hardware. This could be due to for example internal
> init failure of the sensor chip causing an internal reset. Because of
> this read error regmap_read_poll_timeout returns with an error and
> without retrying to read the id the sensor probe fails.

Nasty. If you can get a confirmation that it's a possible failure on startup
from the manufacturer then I'd be happier with that justification to retry
rather than just sleep for say 30msec after power on.

Jonathan

>=20
> -Matti

