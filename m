Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FC353F1C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiFFVdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiFFVdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:33:33 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DC7DF1C;
        Mon,  6 Jun 2022 14:33:29 -0700 (PDT)
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1654551206; bh=+/exdB0JbO+nLXpabEwimThmwTX/YRw3MYh/g5qrQCw=;
        h=From:Subject:Date:In-Reply-To:Cc:References;
        b=UW0fI63eEqIFC84D4DfboyXApEWNxFWkST1U3zk/5BwwvM2YzuodmMgSpUX5d/iMr
         iFyoPNL9O6cEzv0FlSxcX1G9oCwKqUmuQE+L2wG7NtFhocaJsIXRNGlvhuvQYNQ9qh
         UveFMU/j1zlk2zii+ywqfuAVw+N2PYBQFsEmyCOQ=
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH v2 5/5] ASoC: apple: Add macaudio machine driver
Date:   Mon, 6 Jun 2022 23:33:25 +0200
In-Reply-To: <15fd77de-9c6e-2e48-be4e-bae4abd7bb96@linux.intel.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, asahi@lists.linux.dev,
        Mark Kettenis <kettenis@openbsd.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-6-povik+lin@cutebit.org>
 <8e1641d0-b081-6301-db94-2c026166079a@linux.intel.com>
 <ED93F42F-5406-4D4F-B996-86F683EC09ED@cutebit.org>
 <15fd77de-9c6e-2e48-be4e-bae4abd7bb96@linux.intel.com>
Message-Id: <BF6B5D96-2073-4251-9B17-17C1B26A3E85@cutebit.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,SPF_FAIL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 6. 6. 2022, at 23:22, Pierre-Louis Bossart =
<pierre-louis.bossart@linux.intel.com> wrote:
>=20
> On 6/6/22 15:46, Martin Povi=C5=A1er wrote:
>> (I am having trouble delivering mail to linux.intel.com, so I reply =
to the list
>> and CC at least...)
>>=20
>>> On 6. 6. 2022, at 22:02, Pierre-Louis Bossart =
<pierre-louis.bossart@linux.intel.com> wrote:
>>>=20
>>>=20
>>>> + * Virtual FE/BE Playback Topology
>>>> + * -------------------------------
>>>> + *
>>>> + * The platform driver has independent frontend and backend DAIs =
with the
>>>> + * option of routing backends to any of the frontends. The =
platform
>>>> + * driver configures the routing based on DPCM couplings in ASoC =
runtime
>>>> + * structures, which in turn is determined from DAPM paths by =
ASoC. But the
>>>> + * platform driver doesn't supply relevant DAPM paths and leaves =
that up for
>>>> + * the machine driver to fill in. The filled-in virtual topology =
can be
>>>> + * anything as long as a particular backend isn't connected to =
more than one
>>>> + * frontend at any given time. (The limitation is due to the =
unsupported case
>>>> + * of reparenting of live BEs.)
>>>> + *
>>>> + * The DAPM routing that this machine-level driver makes up has =
two use-cases
>>>> + * in mind:
>>>> + *
>>>> + * - Using a single PCM for playback such that it conditionally =
sinks to either
>>>> + *   speakers or headphones based on the plug-in state of the =
headphones jack.
>>>> + *   All the while making the switch transparent to userspace. =
This has the
>>>> + *   drawback of requiring a sample stream suited for both =
speakers and
>>>> + *   headphones, which is hard to come by on machines where =
tailored DSP for
>>>> + *   speakers in userspace is desirable or required.
>>>> + *
>>>> + * - Driving the headphones and speakers from distinct PCMs, =
having userspace
>>>> + *   bridge the difference and apply different signal processing =
to the two.
>>>> + *
>>>> + * In the end the topology supplied by this driver looks like =
this:
>>>> + *
>>>> + *  PCMs (frontends)                   I2S Port Groups (backends)
>>>> + *  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80                   =
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80
>>>> + *
>>>> + *  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90       =
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=
=BA =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90
>>>> + *  =E2=94=82 Primary  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=A4                 =E2=94=82 Mux =E2=94=82=
 =E2=94=80=E2=94=80=E2=96=BA =E2=94=82 Speakers =E2=94=82
>>>> + *  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98       =E2=94=82    =
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=96=BA =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>>>> + *                =E2=94=8C=E2=94=80=E2=94=80=E2=94=80 =E2=94=82 =
=E2=94=80=E2=94=80=E2=94=80=E2=94=98             =E2=96=B2
>>>> + *  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90  =E2=94=82    =E2=94=82       =
           =E2=94=82
>>>> + *  =E2=94=82Secondary =E2=94=9C=E2=94=80=E2=94=80=E2=94=98    =E2=94=
=82     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=90
>>>> + *  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98       =
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA=E2=94=82Plug-in =
Demux=E2=94=82
>>>> + *                     =E2=94=82     =
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=98
>>>> + *                     =E2=94=82                  =E2=94=82
>>>> + *                     =E2=94=82                  =E2=96=BC
>>>> + *                     =E2=94=82                 =
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90
>>>> + *                     =
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=
=BA =E2=94=82 Mux =E2=94=82 =E2=94=80=E2=94=80=E2=96=BA =E2=94=82Headphone=
s=E2=94=82
>>>> + *                                       =E2=94=94=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=98     =
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98
>>>> + */
>>>=20
>>> In Patch2, the 'clusters' are described as front-ends, with I2S as
>>> back-ends. Here the PCMs are described as front-ends, but there's no
>>> mention of clusters. Either one of the two descriptions is outdated, =
or
>>> there's something missing to help reconcile the two pieces of =
information?
>>=20
>> Both descriptions should be in sync. Maybe I don=E2=80=99t know the =
proper
>> terminology. In both cases the frontend is meant to be the actual I2S
>> transceiver unit, and backend the I2S port on the SoC=E2=80=99s =
periphery,
>> which can be routed to any of transceiver units. (Multiple ports can
>> be routed to the same unit, which means the ports will have the same
>> clocks and data line -- that's a configuration we need to support to
>> drive some of the speaker arrays, hence the backend/frontend
>> distinction).
>>=20
>> Maybe I am using 'PCM' in a confusing way here? What I meant is a
>> subdevice that=E2=80=99s visible from userspace, because I have seen =
it used
>> that way in ALSA codebase.
>=20
> Yes, I think most people familiar with DPCM would take the 'PCM
> frontend' as some sort of generic DMA transfer from system memory, =
while
> the 'back end' is more the actual serial link. In your case, the
> front-end is already very low-level and tied to I2S already. I think
> that's fine, it's just that using different terms for 'cluster' and
> 'PCM' in different patches could lead to confusions.

OK, will take this into account then.

>>>> +static int macaudio_get_runtime_mclk_fs(struct snd_pcm_substream =
*substream)
>>>> +{
>>>> +	struct snd_soc_pcm_runtime *rtd =3D =
asoc_substream_to_rtd(substream);
>>>> +	struct macaudio_snd_data *ma =3D =
snd_soc_card_get_drvdata(rtd->card);
>>>> +	struct snd_soc_dpcm *dpcm;
>>>> +
>>>> +	/*
>>>> +	 * If this is a FE, look it up in link_props directly.
>>>> +	 * If this is a BE, look it up in the respective FE.
>>>> +	 */
>>>> +	if (!rtd->dai_link->no_pcm)
>>>> +		return ma->link_props[rtd->dai_link->id].mclk_fs;
>>>> +
>>>> +	for_each_dpcm_fe(rtd, substream->stream, dpcm) {
>>>> +		int fe_id =3D dpcm->fe->dai_link->id;
>>>> +
>>>> +		return ma->link_props[fe_id].mclk_fs;
>>>> +	}
>>>=20
>>> I am not sure what the concept of mclk would mean for a front-end? =
This
>>> is typically very I2S-specific, i.e. a back-end property, no?
>>=20
>> Right, that=E2=80=99s a result of the confusion from above. Hope I =
cleared it up
>> somehow. The frontend already decides the clocks and data =
serialization,
>> hence mclk/fs is a frontend-prop here.
>=20
> What confuses me in this code is that it looks possible that the =
front-
> and back-end could have different mclk values? I think a comment is
> missing that the values are identical, it's just that there's a
> different way to access it depending on the link type?

Well, that=E2=80=99s exactly what I am trying to convey by the comment =
above
in macaudio_get_runtime_mclk_fs. Maybe I should do something to make
it more obvious.

>>>> +static int macaudio_be_init(struct snd_soc_pcm_runtime *rtd)
>>>> +{
>>>> +	struct snd_soc_card *card =3D rtd->card;
>>>> +	struct macaudio_snd_data *ma =3D snd_soc_card_get_drvdata(card);
>>>> +	struct macaudio_link_props *props =3D =
&ma->link_props[rtd->dai_link->id];
>>>> +	struct snd_soc_dai *dai;
>>>> +	int i, ret;
>>>> +
>>>> +	ret =3D macaudio_be_assign_tdm(rtd);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	if (props->is_headphones) {
>>>> +		for_each_rtd_codec_dais(rtd, i, dai)
>>>> +			snd_soc_component_set_jack(dai->component, =
&ma->jack, NULL);
>>>> +	}
>>>=20
>>> this is weird, set_jack() is invoked by the ASoC core. You shouldn't
>>> need to do this?
>>=20
>> That=E2=80=99s interesting. Where would it be invoked? How does ASoC =
know which codec
>> it attaches to?
>=20
> sorry, my comment was partly invalid.
>=20
> set_jack() is invoked in the machine driver indeed, what I found =
strange
> is that you may have different codecs handling the jack? What is the
> purpose of that loop?

There=E2=80=99s no need for the loop, there=E2=80=99s a single codec. =
OK, will remove the loop
to make it less confusing.

>>>> +static int macaudio_jack_event(struct notifier_block *nb, unsigned =
long event,
>>>> +				void *data);
>>>> +
>>>> +static struct notifier_block macaudio_jack_nb =3D {
>>>> +	.notifier_call =3D macaudio_jack_event,
>>>> +};
>>>=20
>>> why is this needed? we have already many ways of dealing with the =
jack
>>> events (dare I say too many ways?).
>>=20
>> Because I want to update the DAPM paths based on the jack status,
>> specifically I want to set macaudio_plugin_demux. I don=E2=80=99t =
know how
>> else it could be done.
>=20
> I don't know either but I have never seen notifier blocks being used. =
I
> would think there are already ways to do this with DAPM events.
>=20
>=20
>>>> +static int macaudio_jack_event(struct notifier_block *nb, unsigned =
long event,
>>>> +				void *data)
>>>> +{
>>>> +	struct snd_soc_jack *jack =3D data;
>>>> +	struct macaudio_snd_data *ma =3D =
snd_soc_card_get_drvdata(jack->card);
>>>> +
>>>> +	ma->jack_plugin_state =3D !!event;
>>>> +
>>>> +	if (!ma->plugin_demux_kcontrol)
>>>> +		return 0;
>>>> +
>>>> +	snd_soc_dapm_mux_update_power(&ma->card.dapm, =
ma->plugin_demux_kcontrol,
>>>> +				      ma->jack_plugin_state,
>>>> +				      (struct soc_enum *) =
&macaudio_plugin_demux_enum, NULL);
>>>=20
>>> the term 'plugin' can be understood in many ways by different audio
>>> folks. 'plugin' is usually the term used for processing libraries =
(VST,
>>> LADSPA, etc). I think here you meant 'jack control'?
>>=20
>> So =E2=80=98jack control=E2=80=99 would be understood as the jack =
plugged/unplugged status?
>=20
> The 'Headphone Jack' or 'Headset Mic Jack' kcontrols typically track =
the
> status. Other terms are 'jack detection'. "plugin" is not a very =
common
> term here.

OK

