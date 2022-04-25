Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C6550E06F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiDYMiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241901AbiDYMhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:37:47 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C83AD115;
        Mon, 25 Apr 2022 05:34:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1650890074; bh=sn38mP3GRcYFS204SS01F9po0IjaiD5EuJVQTsfix0c=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=qzxfZ3Vnf6IGzTPAEIKZUigZLKF+DgDhUpHC6GbPhg8VP+3Se4CCdtWbiDqK5s2Xm
         K29Pj7BPaWZedmssU+FSgBeA5FqUPAlItY4SuEb+MGyi4q8mz/gn0A9Uz2NKw1Q39n
         6v8X9tfBGgqVMS2EswXnoy7z992EBMZFhoG8EZB8=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH 3/5] HACK: ASoC: Tolerate N-cpus-to-M-codecs links
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YmaTHTKWAfM7FCcY@sirena.org.uk>
Date:   Mon, 25 Apr 2022 14:34:33 +0200
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
Message-Id: <9F8BCBA8-5EE3-4F87-9518-91CB7AB4E077@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-4-povik+lin@cutebit.org>
 <YkrkbBNYULLgeS5w@sirena.org.uk>
 <904EB8A1-5561-4555-8030-B85703E24F2E@cutebit.org>
 <YmaTHTKWAfM7FCcY@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 25. 4. 2022, at 14:25, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Fri, Apr 22, 2022 at 04:06:06PM +0200, Martin Povi=C5=A1er wrote:
>>> On 4. 4. 2022, at 14:28, Mark Brown <broonie@kernel.org> wrote:
>=20
>>> We need to figure out an interface for describing which CODEC/CPU
>>> combinations are connected to each other.  I'm not seeing a great =
way to
>>> do that right now, probably some side data table is going to be =
needed,
>>> or perhaps the CPU DAI drivers can be persuaded to only have one DAI
>>> actually register and claim to support more channels?  I'm not sure =
how
>>> a configuraiton like this is going to work at userspace level if the
>>> multiple CPU DAIs end up being visible...
>=20
>> To understand the issue better: How could the multiple CPU DAIs be
>> visible from userspace?
>=20
> If you register two separate DAIs (well, links) with the API without
> doing anything else the API will just expose them to userspace as two
> separate things with no indication that they're related.

Sure, but what I am addressing here is a single DAI link with multiple
CPU DAIs, invoked in DT like this:

	dai-link@0 {
		link-name =3D "Speakers";
		mclk-fs =3D <256>;

		cpu {
			sound-dai =3D <&mca 0>, <&mca 1>;
		};
		codec {
			sound-dai =3D <&speaker_left_woof1>,
				<&speaker_right_woof1>,
				<&speaker_left_tweet>,
				<&speaker_right_tweet>,
				<&speaker_left_woof2>,
				<&speaker_right_woof2>;
		};
	};

>> What about this interim solution: In case of N-to-M links we put in
>> the most restrictive condition for checking capture/playback stream
>> validity: we check all of the CPU DAIs. Whatever ends up being the
>> proper solution later can only be less restrictive than this.
>=20
> That's not the issue here?

Well to me it looks like it is. Because if I invoke the DAI link like
I quoted above, and the platform driver supports it, the =
playback/capture
stream validity check is the only place it breaks down. Notwithstanding
this may be the wrong API as you wrote.

>> As a reminder what happens on the Macs: the platform driver drives
>> all the CPU-side I2S ports that belong to the link with the same =
data,
>> so the particular CPU/CODEC wiring doesn=E2=80=99t matter.
>=20
> Oh, that's not something I was aware of.  In that case this is the =
wrong
> API - you should be using DPCM to map one front end onto multiple back
> ends (Kirkwood does something similar IIRC, there will be other =
examples
> but that's probably the simplest).  The back ends probably don't =
really
> need to know that they're on the same physical bus (if indeed they =
are).

I guess I need to look into that.

