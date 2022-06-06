Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C053F13F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiFFU6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiFFU5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:57:46 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8131A121CDB;
        Mon,  6 Jun 2022 13:46:26 -0700 (PDT)
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1654548384; bh=u1isTWSeb6uW/pN53wPvzFBUNL/gSgdFJGQPWKSaW/o=;
        h=From:Subject:Date:In-Reply-To:Cc:References;
        b=n6rrkdenyJM5fGxcP1ineL/wKFiL2O1e4negh1B68LMycRU1DPXgRDpnY6fIBNb1t
         LYMijEX+twveCJbi9rqr6bnQZAVxceHFRhT5/mtTIL0vXciYBe8biyQ7njEjoexISm
         A4UQjdhkVgeStbtx68mSA7BdlYbo2Hx9JLOBttqA=
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH v2 5/5] ASoC: apple: Add macaudio machine driver
Date:   Mon, 6 Jun 2022 22:46:23 +0200
In-Reply-To: <8e1641d0-b081-6301-db94-2c026166079a@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-6-povik+lin@cutebit.org>
 <8e1641d0-b081-6301-db94-2c026166079a@linux.intel.com>
Message-Id: <ED93F42F-5406-4D4F-B996-86F683EC09ED@cutebit.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I am having trouble delivering mail to linux.intel.com, so I reply to =
the list
and CC at least...)

> On 6. 6. 2022, at 22:02, Pierre-Louis Bossart =
<pierre-louis.bossart@linux.intel.com> wrote:
>=20
>=20
>> + * Virtual FE/BE Playback Topology
>> + * -------------------------------
>> + *
>> + * The platform driver has independent frontend and backend DAIs =
with the
>> + * option of routing backends to any of the frontends. The platform
>> + * driver configures the routing based on DPCM couplings in ASoC =
runtime
>> + * structures, which in turn is determined from DAPM paths by ASoC. =
But the
>> + * platform driver doesn't supply relevant DAPM paths and leaves =
that up for
>> + * the machine driver to fill in. The filled-in virtual topology can =
be
>> + * anything as long as a particular backend isn't connected to more =
than one
>> + * frontend at any given time. (The limitation is due to the =
unsupported case
>> + * of reparenting of live BEs.)
>> + *
>> + * The DAPM routing that this machine-level driver makes up has two =
use-cases
>> + * in mind:
>> + *
>> + * - Using a single PCM for playback such that it conditionally =
sinks to either
>> + *   speakers or headphones based on the plug-in state of the =
headphones jack.
>> + *   All the while making the switch transparent to userspace. This =
has the
>> + *   drawback of requiring a sample stream suited for both speakers =
and
>> + *   headphones, which is hard to come by on machines where tailored =
DSP for
>> + *   speakers in userspace is desirable or required.
>> + *
>> + * - Driving the headphones and speakers from distinct PCMs, having =
userspace
>> + *   bridge the difference and apply different signal processing to =
the two.
>> + *
>> + * In the end the topology supplied by this driver looks like this:
>> + *
>> + *  PCMs (frontends)                   I2S Port Groups (backends)
>> + *  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80                   =
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80
>> + *
>> + *  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90       =
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=
=BA =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90
>> + *  =E2=94=82 Primary  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=A4                 =E2=94=82 Mux =E2=94=82 =
=E2=94=80=E2=94=80=E2=96=BA =E2=94=82 Speakers =E2=94=82
>> + *  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98       =E2=94=82    =
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=96=BA =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>> + *                =E2=94=8C=E2=94=80=E2=94=80=E2=94=80 =E2=94=82 =
=E2=94=80=E2=94=80=E2=94=80=E2=94=98             =E2=96=B2
>> + *  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90  =E2=94=82    =E2=94=82       =
           =E2=94=82
>> + *  =E2=94=82Secondary =E2=94=9C=E2=94=80=E2=94=80=E2=94=98    =E2=94=82=
     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=90
>> + *  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98       =
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA=E2=94=82Plug-in =
Demux=E2=94=82
>> + *                     =E2=94=82     =
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=98
>> + *                     =E2=94=82                  =E2=94=82
>> + *                     =E2=94=82                  =E2=96=BC
>> + *                     =E2=94=82                 =
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90
>> + *                     =
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=
=BA =E2=94=82 Mux =E2=94=82 =E2=94=80=E2=94=80=E2=96=BA =E2=94=82Headphone=
s=E2=94=82
>> + *                                       =E2=94=94=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98     =
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98
>> + */
>=20
> In Patch2, the 'clusters' are described as front-ends, with I2S as
> back-ends. Here the PCMs are described as front-ends, but there's no
> mention of clusters. Either one of the two descriptions is outdated, =
or
> there's something missing to help reconcile the two pieces of =
information?

Both descriptions should be in sync. Maybe I don=E2=80=99t know the =
proper
terminology. In both cases the frontend is meant to be the actual I2S
transceiver unit, and backend the I2S port on the SoC=E2=80=99s =
periphery,
which can be routed to any of transceiver units. (Multiple ports can
be routed to the same unit, which means the ports will have the same
clocks and data line -- that's a configuration we need to support to
drive some of the speaker arrays, hence the backend/frontend
distinction).

Maybe I am using 'PCM' in a confusing way here? What I meant is a
subdevice that=E2=80=99s visible from userspace, because I have seen it =
used
that way in ALSA codebase.

>> +static int macaudio_copy_link(struct device *dev, struct =
snd_soc_dai_link *target,
>> +			       struct snd_soc_dai_link *source)
>> +{
>> +	memcpy(target, source, sizeof(struct snd_soc_dai_link));
>> +
>> +	target->cpus =3D devm_kcalloc(dev, target->num_cpus,
>> +				sizeof(*target->cpus), GFP_KERNEL);
>> +	target->codecs =3D devm_kcalloc(dev, target->num_codecs,
>> +				sizeof(*target->codecs), GFP_KERNEL);
>> +	target->platforms =3D devm_kcalloc(dev, target->num_platforms,
>> +				sizeof(*target->platforms), GFP_KERNEL);
>> +
>> +	if (!target->cpus || !target->codecs || !target->platforms)
>> +		return -ENOMEM;
>> +
>> +	memcpy(target->cpus, source->cpus, sizeof(*target->cpus) * =
target->num_cpus);
>> +	memcpy(target->codecs, source->codecs, sizeof(*target->codecs) * =
target->num_codecs);
>> +	memcpy(target->platforms, source->platforms, =
sizeof(*target->platforms) * target->num_platforms);
>=20
>=20
> use devm_kmemdup?

Looks like what I am looking for.

>> +
>> +	return 0;
>> +}
>=20
>> +static int macaudio_get_runtime_mclk_fs(struct snd_pcm_substream =
*substream)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd =3D =
asoc_substream_to_rtd(substream);
>> +	struct macaudio_snd_data *ma =3D =
snd_soc_card_get_drvdata(rtd->card);
>> +	struct snd_soc_dpcm *dpcm;
>> +
>> +	/*
>> +	 * If this is a FE, look it up in link_props directly.
>> +	 * If this is a BE, look it up in the respective FE.
>> +	 */
>> +	if (!rtd->dai_link->no_pcm)
>> +		return ma->link_props[rtd->dai_link->id].mclk_fs;
>> +
>> +	for_each_dpcm_fe(rtd, substream->stream, dpcm) {
>> +		int fe_id =3D dpcm->fe->dai_link->id;
>> +
>> +		return ma->link_props[fe_id].mclk_fs;
>> +	}
>=20
> I am not sure what the concept of mclk would mean for a front-end? =
This
> is typically very I2S-specific, i.e. a back-end property, no?

Right, that=E2=80=99s a result of the confusion from above. Hope I =
cleared it up
somehow. The frontend already decides the clocks and data serialization,
hence mclk/fs is a frontend-prop here.

>> +
>> +	return 0;
>> +}
>> +
>> +static int macaudio_dpcm_hw_params(struct snd_pcm_substream =
*substream,
>> +				   struct snd_pcm_hw_params *params)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd =3D =
asoc_substream_to_rtd(substream);
>> +	struct snd_soc_dai *cpu_dai =3D asoc_rtd_to_cpu(rtd, 0);
>> +	int mclk_fs =3D macaudio_get_runtime_mclk_fs(substream);
>> +	int i;
>> +
>> +	if (mclk_fs) {
>> +		struct snd_soc_dai *dai;
>> +		int mclk =3D params_rate(params) * mclk_fs;
>> +
>> +		for_each_rtd_codec_dais(rtd, i, dai)
>> +			snd_soc_dai_set_sysclk(dai, 0, mclk, =
SND_SOC_CLOCK_IN);
>> +
>> +		snd_soc_dai_set_sysclk(cpu_dai, 0, mclk, =
SND_SOC_CLOCK_OUT);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void macaudio_dpcm_shutdown(struct snd_pcm_substream =
*substream)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd =3D =
asoc_substream_to_rtd(substream);
>> +	struct snd_soc_dai *cpu_dai =3D asoc_rtd_to_cpu(rtd, 0);
>> +	struct snd_soc_dai *dai;
>> +	int mclk_fs =3D macaudio_get_runtime_mclk_fs(substream);
>> +	int i;
>> +
>> +	if (mclk_fs) {
>> +		for_each_rtd_codec_dais(rtd, i, dai)
>> +			snd_soc_dai_set_sysclk(dai, 0, 0, =
SND_SOC_CLOCK_IN);
>> +
>> +		snd_soc_dai_set_sysclk(cpu_dai, 0, 0, =
SND_SOC_CLOCK_OUT);
>> +	}
>> +}
>> +
>> +static const struct snd_soc_ops macaudio_fe_ops =3D {
>> +	.shutdown	=3D macaudio_dpcm_shutdown,
>> +	.hw_params	=3D macaudio_dpcm_hw_params,
>> +};
>> +
>> +static const struct snd_soc_ops macaudio_be_ops =3D {
>> +	.shutdown	=3D macaudio_dpcm_shutdown,
>> +	.hw_params	=3D macaudio_dpcm_hw_params,
>> +};
>> +
>> +static int macaudio_be_assign_tdm(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +	struct snd_soc_card *card =3D rtd->card;
>> +	struct macaudio_snd_data *ma =3D snd_soc_card_get_drvdata(card);
>> +	struct macaudio_link_props *props =3D =
&ma->link_props[rtd->dai_link->id];
>> +	struct snd_soc_dai *dai;
>> +	unsigned int mask;
>> +	int nslots, ret, i;
>> +
>> +	if (!props->tdm_mask)
>> +		return 0;
>> +
>> +	mask =3D props->tdm_mask;
>> +	nslots =3D __fls(mask) + 1;
>> +
>> +	if (rtd->num_codecs =3D=3D 1) {
>> +		ret =3D snd_soc_dai_set_tdm_slot(asoc_rtd_to_codec(rtd, =
0), mask,
>> +					       0, nslots, =
MACAUDIO_SLOTWIDTH);
>> +
>> +		/*
>> +		 * Headphones get a pass on -EOPNOTSUPP (see the comment
>> +		 * around mclk_fs value for primary FE).
>> +		 */
>> +		if (ret =3D=3D -EOPNOTSUPP && props->is_headphones)
>> +			return 0;
>> +
>> +		return ret;
>> +	}
>> +
>> +	for_each_rtd_codec_dais(rtd, i, dai) {
>> +		int slot =3D __ffs(mask);
>> +
>> +		mask &=3D ~(1 << slot);
>> +		ret =3D snd_soc_dai_set_tdm_slot(dai, 1 << slot, 0, =
nslots,
>> +					       MACAUDIO_SLOTWIDTH);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int macaudio_be_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +	struct snd_soc_card *card =3D rtd->card;
>> +	struct macaudio_snd_data *ma =3D snd_soc_card_get_drvdata(card);
>> +	struct macaudio_link_props *props =3D =
&ma->link_props[rtd->dai_link->id];
>> +	struct snd_soc_dai *dai;
>> +	int i, ret;
>> +
>> +	ret =3D macaudio_be_assign_tdm(rtd);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (props->is_headphones) {
>> +		for_each_rtd_codec_dais(rtd, i, dai)
>> +			snd_soc_component_set_jack(dai->component, =
&ma->jack, NULL);
>> +	}
>=20
> this is weird, set_jack() is invoked by the ASoC core. You shouldn't
> need to do this?

That=E2=80=99s interesting. Where would it be invoked? How does ASoC =
know which codec
it attaches to?

>> +
>> +	return 0;
>> +}
>> +
>> +static void macaudio_be_exit(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +	struct snd_soc_card *card =3D rtd->card;
>> +	struct macaudio_snd_data *ma =3D snd_soc_card_get_drvdata(card);
>> +	struct macaudio_link_props *props =3D =
&ma->link_props[rtd->dai_link->id];
>> +	struct snd_soc_dai *dai;
>> +	int i;
>> +
>> +	if (props->is_headphones) {
>> +		for_each_rtd_codec_dais(rtd, i, dai)
>> +			snd_soc_component_set_jack(dai->component, NULL, =
NULL);
>> +	}
>=20
> same, why is this needed?
>=20
>> +}
>> +
>> +static int macaudio_fe_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +	struct snd_soc_card *card =3D rtd->card;
>> +	struct macaudio_snd_data *ma =3D snd_soc_card_get_drvdata(card);
>> +	struct macaudio_link_props *props =3D =
&ma->link_props[rtd->dai_link->id];
>> +	int nslots =3D props->mclk_fs / MACAUDIO_SLOTWIDTH;
>> +
>> +	return snd_soc_dai_set_tdm_slot(asoc_rtd_to_cpu(rtd, 0), (1 << =
nslots) - 1,
>> +					(1 << nslots) - 1, nslots, =
MACAUDIO_SLOTWIDTH);
>> +}
>> +
>> +
>> +static int macaudio_jack_event(struct notifier_block *nb, unsigned =
long event,
>> +				void *data);
>> +
>> +static struct notifier_block macaudio_jack_nb =3D {
>> +	.notifier_call =3D macaudio_jack_event,
>> +};
>=20
> why is this needed? we have already many ways of dealing with the jack
> events (dare I say too many ways?).

Because I want to update the DAPM paths based on the jack status,
specifically I want to set macaudio_plugin_demux. I don=E2=80=99t know =
how
else it could be done.

>> +
>> +static int macaudio_probe(struct snd_soc_card *card)
>> +{
>> +	struct macaudio_snd_data *ma =3D snd_soc_card_get_drvdata(card);
>> +	int ret;
>> +
>> +	ma->pin.pin =3D "Headphones";
>> +	ma->pin.mask =3D SND_JACK_HEADSET | SND_JACK_HEADPHONE;
>> +	ret =3D snd_soc_card_jack_new(card, ma->pin.pin,
>> +			SND_JACK_HEADSET |
>> +			SND_JACK_HEADPHONE |
>> +			SND_JACK_BTN_0 | SND_JACK_BTN_1 |
>> +			SND_JACK_BTN_2 | SND_JACK_BTN_3,
>> +			&ma->jack, &ma->pin, 1);
>> +
>> +	if (ret < 0) {
>> +		dev_err(card->dev, "jack creation failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	snd_soc_jack_notifier_register(&ma->jack, &macaudio_jack_nb);
>> +
>> +	return ret;
>> +}
>> +
>> +static int macaudio_add_backend_dai_route(struct snd_soc_card *card, =
struct snd_soc_dai *dai,
>> +					  bool is_speakers)
>> +{
>> +	struct snd_soc_dapm_route routes[2];
>> +	int nroutes;
>> +	int ret;
>=20
> newline?
>=20
>> +	memset(routes, 0, sizeof(routes));
>> +
>> +	dev_dbg(card->dev, "adding routes for '%s'\n", dai->name);
>> +
>> +	if (is_speakers)
>> +		routes[0].source =3D "Speakers Playback";
>> +	else
>> +		routes[0].source =3D "Headphones Playback";
>> +	routes[0].sink =3D dai->playback_widget->name;
>> +	nroutes =3D 1;
>> +
>> +	if (!is_speakers) {
>> +		routes[1].source =3D dai->capture_widget->name;
>> +		routes[1].sink =3D "Headphones Capture";
>> +		nroutes =3D 2;
>> +	}
>> +
>> +	ret =3D snd_soc_dapm_add_routes(&card->dapm, routes, nroutes);
>> +	if (ret)
>> +		dev_err(card->dev, "failed adding dynamic DAPM routes =
for %s\n",
>> +			dai->name);
>> +	return ret;
>> +}
>> +
>> +static bool macaudio_match_kctl_name(const char *pattern, const char =
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
>> +
>> +static int macaudio_limit_volume(struct snd_soc_card *card,
>> +				 const char *pattern, int max)
>> +{
>> +	struct snd_kcontrol *kctl;
>> +	struct soc_mixer_control *mc;
>> +	int found =3D 0;
>> +
>> +	list_for_each_entry(kctl, &card->snd_card->controls, list) {
>> +		if (!macaudio_match_kctl_name(pattern, kctl->id.name))
>> +			continue;
>> +
>> +		found++;
>> +		dev_dbg(card->dev, "limiting volume on '%s'\n", =
kctl->id.name);
>> +
>> +		/*
>> +		 * TODO: This doesn't decrease the volume if it's =
already
>> +		 * above the limit!
>> +		 */
>> +		mc =3D (struct soc_mixer_control *)kctl->private_value;
>> +		if (max <=3D mc->max)
>> +			mc->platform_max =3D max;
>> +
>> +	}
>> +
>> +	return found;
>> +}
>> +
>> +static int macaudio_late_probe(struct snd_soc_card *card)
>> +{
>> +	struct macaudio_snd_data *ma =3D snd_soc_card_get_drvdata(card);
>> +	struct snd_soc_pcm_runtime *rtd;
>> +	struct snd_soc_dai *dai;
>> +	int ret, i;
>> +
>> +	/* Add the dynamic DAPM routes */
>> +	for_each_card_rtds(card, rtd) {
>> +		struct macaudio_link_props *props =3D =
&ma->link_props[rtd->dai_link->id];
>> +
>> +		if (!rtd->dai_link->no_pcm)
>> +			continue;
>> +
>> +		for_each_rtd_cpu_dais(rtd, i, dai) {
>> +			ret =3D macaudio_add_backend_dai_route(card, =
dai, props->is_speakers);
>> +
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	}
>> +
>> +	if (!ma->mdata) {
>> +		dev_err(card->dev, "driver doesn't know speaker limits =
for this model\n");
>> +		return void_warranty ? 0 : -EINVAL;
>> +	}
>> +
>> +	macaudio_limit_volume(card, "* Amp Gain", =
ma->mdata->spk_amp_gain_max);
>> +	return 0;
>> +}
>> +
>> +static const char * const macaudio_plugin_demux_texts[] =3D {
>> +	"Speakers",
>> +	"Headphones"
>> +};
>> +
>> +SOC_ENUM_SINGLE_VIRT_DECL(macaudio_plugin_demux_enum, =
macaudio_plugin_demux_texts);
>> +
>> +static int macaudio_plugin_demux_get(struct snd_kcontrol *kcontrol,
>> +			struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_dapm_context *dapm =3D =
snd_soc_dapm_kcontrol_dapm(kcontrol);
>> +	struct macaudio_snd_data *ma =3D =
snd_soc_card_get_drvdata(dapm->card);
>> +
>> +	/*
>> +	 * TODO: Determine what locking is in order here...
>> +	 */
>> +	ucontrol->value.enumerated.item[0] =3D ma->jack_plugin_state;
>> +
>> +	return 0;
>> +}
>> +
>> +static int macaudio_jack_event(struct notifier_block *nb, unsigned =
long event,
>> +				void *data)
>> +{
>> +	struct snd_soc_jack *jack =3D data;
>> +	struct macaudio_snd_data *ma =3D =
snd_soc_card_get_drvdata(jack->card);
>> +
>> +	ma->jack_plugin_state =3D !!event;
>> +
>> +	if (!ma->plugin_demux_kcontrol)
>> +		return 0;
>> +
>> +	snd_soc_dapm_mux_update_power(&ma->card.dapm, =
ma->plugin_demux_kcontrol,
>> +				      ma->jack_plugin_state,
>> +				      (struct soc_enum *) =
&macaudio_plugin_demux_enum, NULL);
>=20
> the term 'plugin' can be understood in many ways by different audio
> folks. 'plugin' is usually the term used for processing libraries =
(VST,
> LADSPA, etc). I think here you meant 'jack control'?

So =E2=80=98jack control=E2=80=99 would be understood as the jack =
plugged/unplugged status?

>=20
>> +
>> +	return 0;
>> +}
>> +
>=20

Martin

