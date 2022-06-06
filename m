Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A3A53EFE6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiFFUiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiFFUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:37:22 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488CAEE29;
        Mon,  6 Jun 2022 13:35:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1654547721; bh=vfmRHdsKy5jL3Jkg558Ih+Gkg25m+JW1BWtz6hVF+I4=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=Zp4+x16vSA/uhNUrENr7G3Ja9fHEb+dC8TemongFVg6cfy89mwvmpUWN+UecWyi+m
         0fOjdk0f7kDw9VOeUFI1A9djS8U2MgbR+iKH5OR/1g/BMqZ7d5h3CA1PWEH1iMw67n
         bWCoGFvgB5UrtKJwpQPs1QJPPvL568oBkOd05khg=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH v2 3/5] ASoC: apple: Add MCA platform driver for Apple
 SoCs
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <Yp5g43IxFQsUoS/y@sirena.org.uk>
Date:   Mon, 6 Jun 2022 22:35:20 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0FD0022-9DA1-4907-9737-19F7460B8EFF@cutebit.org>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-4-povik+lin@cutebit.org>
 <Yp5g43IxFQsUoS/y@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 6. 6. 2022, at 22:17, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Mon, Jun 06, 2022 at 09:19:08PM +0200, Martin Povi=C5=A1er wrote:
>=20
>> +++ b/sound/soc/apple/mca.c
>> @@ -0,0 +1,1122 @@
>> +/*
>> + * Apple SoCs MCA driver
>=20
> Please add SPDX headers to all your files.
>=20
>> +		mca_modify(cl, serdes_conf,
>> +			SERDES_CONF_SOME_RST, SERDES_CONF_SOME_RST);
>> +		(void) readl_relaxed(cl->base + serdes_conf);
>=20
> Please drop the cast, casts to/from void are generally a warning sign =
as
> they're unneeded in C.  If you want to document the barrier use a
> comment or wrapper function.
>=20
>> +	/*
>> +	 * Codecs require clocks at time of umute with the 'mute_stream' =
op.
>> +	 * We need to enable them here at the latest (frontend prepare =
would
>> +	 * be too late).
>> +	 */
>> +	if (!mca_fe_clocks_in_use(fe_cl)) {
>> +		ret =3D mca_fe_enable_clocks(fe_cl);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>=20
> This requirement is CODEC specific.  It's fine to bodge around to
> satisfy it though, especially given the restricted set of platforms =
this
> can be used with.
>=20
>> +	fe_cl =3D &mca->clusters[cl->port_driver];
>> +	if (!mca_fe_clocks_in_use(fe_cl))
>> +		return 0; /* Nothing to do */
>> +
>> +	cl->clocks_in_use[substream->stream] =3D false;
>> +
>> +	if (!mca_fe_clocks_in_use(fe_cl))
>> +		mca_fe_disable_clocks(fe_cl);
>=20
> Are you sure this doesn't need locking?

I am not sure. I need to study what locking is already done by =
ALSA/ASoC.
I assume the two stream directions here don=E2=80=99t share a lock =
already...

