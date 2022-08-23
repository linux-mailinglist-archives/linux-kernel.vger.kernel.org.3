Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2B059D25A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbiHWHdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239948AbiHWHdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:33:45 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943321CB3C;
        Tue, 23 Aug 2022 00:33:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661240018; bh=ftKfGYt19SPqa6Cn1sVIOkBEC6upRTpfHplVCy06jFo=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=H2XDFgnSF0seYKYphMwMhHDHqvRe6U0bfcLzS8zKgohwWKDbnplD1OTsGdzFzUesC
         EXVXvyNF2rFo3RgQI1j1rhIzyKzx/qHIwzcftBWDYQMgr+DDehE+AIDXG7Y798yxxt
         BqmeeC/X+Bkyi8b2lTLSDnDHrQyrL46eu6s+QWUo=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 3/4] ASoC: apple: mca: Start new platform driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <YwO/aqs7eqZx07kS@sirena.org.uk>
Date:   Tue, 23 Aug 2022 09:33:36 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <24C0ABFA-BF71-4492-8A6A-E9BE1462B403@cutebit.org>
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-4-povik+lin@cutebit.org>
 <YwO/aqs7eqZx07kS@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 22. 8. 2022, at 19:39, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Fri, Aug 19, 2022 at 02:54:29PM +0200, Martin Povi=C5=A1er wrote:
>=20
> This all looks good, one style nit and a couple of requests for
> clarification below but basically this is fine.
>=20
>> +++ b/sound/soc/apple/mca.c
>> @@ -0,0 +1,1149 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Apple SoCs MCA driver
>> + *
>> + * Copyright (C) The Asahi Linux Contributors
>> + *
>> + * The MCA peripheral is made up of a number of identical units =
called clusters.
>=20
> Please make the entire comment block a C++ one so things look more
> intentional.

Is this so that it does not look like the SPDX header was added
mechanically? I will do it, just curious what the reasoning is.

>=20
>> +#define USE_RXB_FOR_CAPTURE
>=20
> What's this all about?

There=E2=80=99s something we can configure one way or the other way in =
the
hardware (choosing RXA or RXB unit in a cluster for capture). Since this=20=

driver developed along reverse-engineering the hardware, this switch
got built in. I want to keep it for future experimentation. Also, as
the driver=E2=80=99s side gig is documenting the hardware, this way it
documents more.

>> +static int mca_fe_enable_clocks(struct mca_cluster *cl)
>> +{
>> +	struct mca_data *mca =3D cl->host;
>> +	int ret;
>> +
>> +	ret =3D clk_prepare_enable(cl->clk_parent);
>> +	if (ret) {
>> +		dev_err(mca->dev,
>> +			"cluster %d: unable to enable clock parent: =
%d\n",
>> +			cl->no, ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * We can't power up the device earlier than this because
>> +	 * the power state driver would error out on seeing the device
>> +	 * as clock-gated.
>> +	 */
>> +	cl->pd_link =3D device_link_add(mca->dev, cl->pd_dev,
>> +				      DL_FLAG_STATELESS | =
DL_FLAG_PM_RUNTIME |
>> +					      DL_FLAG_RPM_ACTIVE);
>=20
> I'm not clear on this dynamically adding and removing device links =
stuff
> - it looks like the main (only?) purpose is to take a runtime PM
> reference to the target device which is fine but it's not clear why
> device links are involved given that the links are created and =
destroyed
> every time the DAI is used, AFAICT always in the same fixed
> relationship.  It's not a problem, it's just unclear.

Indeed the only purpose is powering up the cluster=E2=80=99s power =
domain (there=E2=80=99s
one domain for each cluster). Adding the links is the only way I know to
do it. They need to be added dynamically (as opposed to statically =
linking,
say, the DAI=E2=80=99s ->dev to the cluster=E2=80=99s ->pd_dev, which I =
guess may do
something similar), because we need to sequence the power-up/power-down
with the enablement of the clocks.

Martin

