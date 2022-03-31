Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F954ED95C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiCaMKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbiCaMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:10:46 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2CC457B7;
        Thu, 31 Mar 2022 05:08:55 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648728531; bh=o0s8+g9O9ptEUPJSHpyizR5cnYWekpbCjfSIKFYgW5M=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=K3eA+hrvPQ7rnRY1xefkH25uA65TIlMtFlXRqItvNKPSb3gNDMCXKWCcU5KIow4zd
         PfxtaOk4qkcLF9IRD56uT6aamjWVop9XUyQMBd3EAUJcL3Etc+DHrF6uZzi/3mvFAw
         7uqF+SxBQG/o7hiwzQ6wVjEZH4pP+DD78fucp6Ss=
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC PATCH 5/5] ASoC: Add macaudio machine driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YkWXs/f7edZwg1+W@sirena.org.uk>
Date:   Thu, 31 Mar 2022 14:08:51 +0200
Cc:     =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4651D426-BA1A-418F-90E5-278C705DA984@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-6-povik+lin@cutebit.org>
 <YkWXs/f7edZwg1+W@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 31. 3. 2022, at 13:59, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Thu, Mar 31, 2022 at 02:04:49AM +0200, Martin Povi=C5=A1er wrote:
>=20
>> --- /dev/null
>> +++ b/sound/soc/apple/macaudio.c
>> @@ -0,0 +1,597 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * ASoC machine driver for Apple Silicon Macs
>> + *
>=20
> Please make the entire comment a C++ one so things look more
> intentional.
>=20
>> +		/* CPU side is bit and frame clock master, I2S with both =
clocks inverted */
>=20
> Please refer to clock providers here.
>=20
>> +		ret =3D of_property_read_string(np, "link-name", =
&link->name);
>> +		if (ret) {
>> +			dev_err(card->dev, "Missing link name\n");
>> +			goto err_put_np;
>> +		}
>=20
> This doesn't look like it's mandatory in the binding.

Good catch!

>> +static int macaudio_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +	struct snd_soc_card *card =3D rtd->card;
>> +	struct macaudio_snd_data *ma =3D snd_soc_card_get_drvdata(card);
>> +	struct snd_soc_component *component;
>> +	int ret, i;
>> +
>> +	if (rtd->num_codecs > 1) {
>> +		ret =3D macaudio_assign_tdm(rtd);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	for_each_rtd_components(rtd, i, component)
>> +		snd_soc_component_set_jack(component, &ma->jack, NULL);
>=20
> What is the jack configuration this is attempting to describe?  It =
looks
> like you have some dedicated speaker driver devices which are going to
> get attached to jacks here for example.

We know the speakers will ignore the set_jack call. There=E2=80=99s one =
jack and
this way we know the jack codec will attach to it, for speakers it=E2=80=99=
s a no-op.
(If you prefer I will special-case it to the jack codec.)

>> +} macaudio_kctlfixes[] =3D {
>> +	{"* ASI1 Sel", "Left"},
>> +	{"* ISENSE Switch", "Off"},
>> +	{"* VSENSE Switch", "Off"},
>> +	{ }
>> +};
>> +
>> +static bool macaudio_kctlfix_matches(const char *pattern, const char =
*name)
>> +{
>> +	if (pattern[0] =3D=3D '*') {
>> +		int namelen, patternlen;
>> +
>> +		pattern++;
>> +		if (pattern[0] =3D=3D ' ')
>> +			pattern++;
>> +
>> +		namelen =3D strlen(name);
>> +		patternlen =3D strlen(pattern);
>> +
>> +		if (namelen > patternlen)
>> +			name +=3D (namelen - patternlen);
>> +	}
>> +
>> +	return !strcmp(name, pattern);
>> +}
>=20
> This looks worryingly like use case configuration.

I go over this in the cover letter! This is fixing the TDM slot =
selection
and disabling voltage/current sensing on the speaker amp codecs, which =
have
no business being exposed to userspace as options. This is not use case,
this not letting people blow their speakers from userspace.

>=20
>> +/*
>> + * Maybe this could be a general ASoC function?
>> + */
>> +static void snd_soc_kcontrol_set_strval(struct snd_soc_card *card,
>> +				struct snd_kcontrol *kcontrol, const =
char *strvalue)
>=20
> No, we should not be setting user visible control values from the
> kernel.  This shouldn't be a machine driver function either.  What are
> you trying to accomplish here?

See above.

Martin

