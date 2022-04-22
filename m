Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D3650B97C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448332AbiDVOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448327AbiDVOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:09:03 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06D85A178;
        Fri, 22 Apr 2022 07:06:08 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1650636366; bh=ORZSwNwJzdGAfaoDUNcAQX21DFUv58T6uCJA7N2SVTc=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=AbzuRb2nCEb9tGr4A98sKwHCclqpfoPJ+JEHYNK5dLFftUJJVezy5owr1B+8cKlGs
         EB0kVx7hseoi7KhAq2vlaQ7VQTODoxwXzu3P5q2zC+JUDbdSULSZs5pfByRmgVh+RG
         00qNWyMt9UIzQnEd2gszyAChExbuYCQ9Q7gSyqNw=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH 3/5] HACK: ASoC: Tolerate N-cpus-to-M-codecs links
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YkrkbBNYULLgeS5w@sirena.org.uk>
Date:   Fri, 22 Apr 2022 16:06:06 +0200
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
Message-Id: <904EB8A1-5561-4555-8030-B85703E24F2E@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-4-povik+lin@cutebit.org>
 <YkrkbBNYULLgeS5w@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 4. 4. 2022, at 14:28, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Thu, Mar 31, 2022 at 02:04:47AM +0200, Martin Povi=C5=A1er wrote:
>=20
>> +#if 0
>> 				dev_err(rtd->card->dev,
>> 					"N cpus to M codecs link is not =
supported yet\n");
>> 				return -EINVAL;
>> +#endif
>> +				cpu_dai =3D asoc_rtd_to_cpu(rtd, 0);
>=20
> We need to figure out an interface for describing which CODEC/CPU
> combinations are connected to each other.  I'm not seeing a great way =
to
> do that right now, probably some side data table is going to be =
needed,
> or perhaps the CPU DAI drivers can be persuaded to only have one DAI
> actually register and claim to support more channels?  I'm not sure =
how
> a configuraiton like this is going to work at userspace level if the
> multiple CPU DAIs end up being visible...

To understand the issue better: How could the multiple CPU DAIs be
visible from userspace?

What about this interim solution: In case of N-to-M links we put in
the most restrictive condition for checking capture/playback stream
validity: we check all of the CPU DAIs. Whatever ends up being the
proper solution later can only be less restrictive than this.

As a reminder what happens on the Macs: the platform driver drives
all the CPU-side I2S ports that belong to the link with the same data,
so the particular CPU/CODEC wiring doesn=E2=80=99t matter.

