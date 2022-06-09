Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FC9544DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiFINmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbiFINmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:42:18 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691F3FEF;
        Thu,  9 Jun 2022 06:42:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1654782130; bh=tvrYkSFFBhOsiav8I6p+1rTRBiUVpZlVK8alorHDY7A=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=IMMgtCRpisiNaxxnvTT3evMSU1zXtF+eiWPSRNvyKpmyEasVNFhUxwP3qX6Af4JPV
         vrTi9PGPbLDxuZag7Ffa/annlnguM8rRVOJ/mpeUlwn2GhgdNx7811x0hiWGwnQE9p
         UjrD+4wbtRU9z4FP/gmW2Ws4vOQ7KieXgsSh97DE=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH v2 5/5] ASoC: apple: Add macaudio machine driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <YqHylN3xba9XFrF8@sirena.org.uk>
Date:   Thu, 9 Jun 2022 15:42:09 +0200
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
Message-Id: <0E611F13-96E3-41FD-9550-F900B2EFB00A@cutebit.org>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-6-povik+lin@cutebit.org>
 <YqHylN3xba9XFrF8@sirena.org.uk>
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


> On 9. 6. 2022, at 15:16, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Mon, Jun 06, 2022 at 09:19:10PM +0200, Martin Povi=C5=A1er wrote:
>=20
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
>=20
> As far as I can tell this demux is entirely software based - why not
> just expose the routing control to userspace and let it handle
> switching (which I suspect may be more featureful than what's
> implemented here)?

Well, userspace should have the other two muxes at its disposal to
implement any routing/switching it wishes -- but in addition we are
also offering letting kernel take care of the switching, by pointing
the muxes to the demux.

I assume (but I don=E2=80=99t know the extent of what=E2=80=99s possible =
with UCM files),
that this will be of some value to users running plain ALSA with no
sound server.

>> +static int macaudio_jack_event(struct notifier_block *nb, unsigned =
long event,
>> +                               void *data)
>> +{
>> +       struct snd_soc_jack *jack =3D data;
>> +       struct macaudio_snd_data *ma =3D =
snd_soc_card_get_drvdata(jack->card);
>> +
>> +       ma->jack_plugin_state =3D !!event;
>> +
>> +       if (!ma->plugin_demux_kcontrol)
>> +               return 0;
>> +
>> +       snd_soc_dapm_mux_update_power(&ma->card.dapm, =
ma->plugin_demux_kcontrol,
>> +                                     ma->jack_plugin_state,
>> +                                     (struct soc_enum *) =
&macaudio_plugin_demux_enum, NULL);
>> +
>> +       return 0;
>> +}
>=20
> This should be integrated with the core jack detection stuff in
> soc-jack.c and/or the core stuff that's wrapping - that way you'll
> ensure that events are generated and status readable via all the
> interfaces userspace might be looking for.  The ASoC stuff also has =
some
> DAPM integration for turning on/off outputs which might DTRT for you =
if
> you do need it in kernel.

Aren=E2=80=99t all the right events to userspace generated already by =
the
codec calling snd_soc_jack_report?

I looked at the existing DAPM integration but I couldn=E2=80=99t figure =
out
how to switch the demux with it.

