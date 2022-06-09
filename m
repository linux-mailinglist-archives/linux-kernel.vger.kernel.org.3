Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6E05450C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343599AbiFIP1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344419AbiFIP1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:27:21 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251CA2CDC1;
        Thu,  9 Jun 2022 08:27:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1654788433; bh=tALHUrTOMSE2jyi1V2Vz4netgKaq9LwC6aSHlEUoNCQ=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=N2XIV2T7wzMQm8Zsocz031ygN/7fCfeKvkIJIfo7sFoe5ROn34/ORCn1pzggJdOQf
         hg60OOlz9D+EuA2Knk9b1qFrtn6/zSDrXarDHfHqmwaeHdo8vfJllnnh5INpeE6SXJ
         rZzElq51cuoAyHVf/Hnkt/un+Bz+L6RhXR2imqfI=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH v2 5/5] ASoC: apple: Add macaudio machine driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <YqIOwrRN8rPUF7Y8@sirena.org.uk>
Date:   Thu, 9 Jun 2022 17:27:12 +0200
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
Message-Id: <7F1B2324-4376-4776-BA6D-FBC8892F10C2@cutebit.org>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-6-povik+lin@cutebit.org>
 <YqH2uCgaedf0HQPE@sirena.org.uk>
 <8961DDD2-93FF-4A18-BCA2-90FCE298F517@cutebit.org>
 <YqIOwrRN8rPUF7Y8@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 9. 6. 2022, at 17:16, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Thu, Jun 09, 2022 at 04:09:57PM +0200, Martin Povi=C5=A1er wrote:
>>> On 9. 6. 2022, at 15:33, Mark Brown <broonie@kernel.org> wrote:
>=20
>>>> +		/*
>>>> +		 * Primary FE
>>>> +		 *
>>>> +		 * The mclk/fs ratio at 64 for the primary frontend is =
important
>>>> +		 * to ensure that the headphones codec's idea of left =
and right
>>>> +		 * in a stereo stream over I2S fits in nicely with =
everyone else's.
>>>> +		 * (This is until the headphones codec's driver supports
>>>> +		 * set_tdm_slot.)
>>>> +		 *
>>>> +		 * The low mclk/fs ratio precludes transmitting more =
than two
>>>> +		 * channels over I2S, but that's okay since there is the =
secondary
>>>> +		 * FE for speaker arrays anyway.
>>>> +		 */
>>>> +		.mclk_fs =3D 64,
>>>> +	},
>=20
>>> This seems weird - it looks like it's confusing MCLK and the bit =
clock
>>> for the audio bus.  These are two different clocks.  Note that it's =
very
>>> common for devices to require a higher MCLK/fs ratio to deliver the =
best
>>> audio performance, 256fs is standard.
>=20
>> On these machines we are not producing any other clock for the codecs
>> besides the bit clock, so I am using MCLK interchangeably for it. (It =
is
>> what the sample rate is derived from after all.)
>=20
> Please don't do this, you're just making everything needlessly hard to
> understand by using standard terminology inappropriately and there's a
> risk of breakage further down the line with drivers implementing the
> standard ops.

OK

>> One of the codec drivers this is to be used with (cs42l42) expects to =
be
>> given the I2S bit clock with
>=20
>>  snd_soc_dai_set_sysclk(dai, 0, mclk, SND_SOC_CLOCK_IN);
>=20
> That's very, very non-standard...
>=20
>> I can rename mclk to bclk in all of the code to make it clearer =
maybe.
>> Also the platform driver can take the bit clock value from =
set_bclk_ratio,
>> instead of set_sysclk from where it takes it now. The cs42l42 driver =
I can
>> patch too to accept set_bclk_ratio.
>=20
> ...indeed, set_bclk_ratio() is a better interface for setting the bclk
> ratio - the CODEC driver should really be doing that as well.

OK, adding that to my TODOs.

>>> This shouldn't be open coded in a driver, please factor it out into =
the
>>> core so we've got an API for "set limit X on control Y" then call =
that.
>=20
>> There=E2=80=99s already snd_soc_limit_volume, but it takes a fixed =
control name.
>> Can I extend it to understand patterns beginning with a wildcard, =
like
>> '* Amp Gain Volume=E2=80=99?
>=20
> Or add a new call that does that.

OK
