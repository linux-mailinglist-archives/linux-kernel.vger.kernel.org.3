Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7291C50E148
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbiDYNOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241937AbiDYNOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:14:22 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A9A222A0;
        Mon, 25 Apr 2022 06:11:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1650892275; bh=/hL2s+lh63ESjiRaWWsxzMR/f4Yu9cM9nehZyfa7E0g=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=nFr8CC12dlvYY0ye7Cw0D5/WM1QFzo3/SRqKTUxMe0my0I7ZZ4f4xN63aMSAhhq2V
         OgPLAz4XUoeMd0sgXUnHtJxv0EqXekSKCJIIp1n11uLXZByvyi8+OxY5VoUmh4xT5z
         V4a8aqsvCFfG35Gz9e1wkkDP63AmJJdfBJEfXrw0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH 3/5] HACK: ASoC: Tolerate N-cpus-to-M-codecs links
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YmaaPa8A03rWV7HE@sirena.org.uk>
Date:   Mon, 25 Apr 2022 15:11:14 +0200
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
Message-Id: <4CF6B0A7-F218-4798-BB21-18D563309D5C@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-4-povik+lin@cutebit.org>
 <YkrkbBNYULLgeS5w@sirena.org.uk>
 <904EB8A1-5561-4555-8030-B85703E24F2E@cutebit.org>
 <YmaTHTKWAfM7FCcY@sirena.org.uk>
 <9F8BCBA8-5EE3-4F87-9518-91CB7AB4E077@cutebit.org>
 <YmaaPa8A03rWV7HE@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 25. 4. 2022, at 14:55, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Mon, Apr 25, 2022 at 02:34:33PM +0200, Martin Povi=C5=A1er wrote:
>>> On 25. 4. 2022, at 14:25, Mark Brown <broonie@kernel.org> wrote:
>=20
>>> If you register two separate DAIs (well, links) with the API without
>>> doing anything else the API will just expose them to userspace as =
two
>>> separate things with no indication that they're related.
>=20
>> Sure, but what I am addressing here is a single DAI link with =
multiple
>> CPU DAIs, invoked in DT like this:
>=20
>> 	dai-link@0 {
>> 		link-name =3D "Speakers";
>> 		mclk-fs =3D <256>;
>>=20
>> 		cpu {
>> 			sound-dai =3D <&mca 0>, <&mca 1>;
>> 		};
>> 		codec {
>> 			sound-dai =3D <&speaker_left_woof1>,
>> 				<&speaker_right_woof1>,
>> 				<&speaker_left_tweet>,
>> 				<&speaker_right_tweet>,
>> 				<&speaker_left_woof2>,
>> 				<&speaker_right_woof2>;
>> 		};
>> 	};
>=20
> You could parse this into two separate links for the benefit of the
> framewokr if you're using a custom machine driver (which I suspect you
> probably have to).

Yeah, this is parsed by the =E2=80=98macaudio=E2=80=99 machine driver =
from the series.

>>>> What about this interim solution: In case of N-to-M links we put in
>>>> the most restrictive condition for checking capture/playback stream
>>>> validity: we check all of the CPU DAIs. Whatever ends up being the
>>>> proper solution later can only be less restrictive than this.
>=20
>>> That's not the issue here?
>=20
>> Well to me it looks like it is. Because if I invoke the DAI link like
>> I quoted above, and the platform driver supports it, the =
playback/capture
>> stream validity check is the only place it breaks down. =
Notwithstanding
>> this may be the wrong API as you wrote.
>=20
> I am surprised that doesn't otherwise explode TBH - at the very least
> I'd expect it to show two PCMs to userspace which if I'm understanding
> your description correctly isn't really what's going on.

I fill in a single snd_soc_dai_link, it exposes a single PCM and works
like a charm. That is as long as I patch the playback/capture check in
question.

I read that to be the clear intention of ASoC code: a DAI link becomes
one snd_soc_pcm_runtime.

