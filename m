Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F9550B778
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447601AbiDVMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbiDVMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:39:03 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ACD54BCB;
        Fri, 22 Apr 2022 05:36:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1650630964; bh=OSdl6aaUeic9SF9BLtfTgFqL689pyLDLZc4/GdJKq8o=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=KOTSsrVYpbp9H5eGEznDOrhNsmP3WRoz8CT6HguROZySCUrsZqVTT44KHKkohBvsd
         e+qME5tm+XjxZ4vuL1KYQmlgCHruAzaW6CvVg1UJa3itnrutntNc5vnK3SEYU/nmJ3
         tQziBxksfZFdSSzcb3CTR1FRn4UKO1OQJamlKnM0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YmKeEKa0w2xLM9cL@sirena.org.uk>
Date:   Fri, 22 Apr 2022 14:36:03 +0200
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
Message-Id: <6F6130F3-381C-4AB7-B618-CDC4C4A37C9B@cutebit.org>
References: <YkWfziQzprEsWL72@sirena.org.uk>
 <CCE4A06E-6D6F-457D-B3C5-C36209BF38D3@cutebit.org>
 <YkW4MPh8VWc8eSGg@sirena.org.uk>
 <6D199EAB-FE14-4030-96A7-2E0E89D25FAB@cutebit.org>
 <YkXKmxJ0R3qpUoH4@sirena.org.uk>
 <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
 <YmKPQ6kLCPz+2XTJ@sirena.org.uk>
 <B68302F2-3D77-4065-8A16-A9CC690AE10B@cutebit.org>
 <YmKSgHrbb/7koM36@sirena.org.uk>
 <A1574F30-62D2-467D-A40B-8FD7C6B8BCFA@cutebit.org>
 <YmKeEKa0w2xLM9cL@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 22. 4. 2022, at 14:22, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Fri, Apr 22, 2022 at 01:44:06PM +0200, Martin Povi=C5=A1er wrote:
>=20
>>> So previously each speaker would get two slots but now it just gets =
one?
>=20
>> No the other way around. Previously (with the driver as it is RFCed),
>> each speaker gets a single slot, and 'Left', 'Right' and =
=E2=80=98LeftRight'
>> values of the routing control don't do anything different from each
>> other (well except maybe 'LeftRight' lessens the volume due to how
>> the chip handles the edge case of mixing down two channels from the
>> same slot).
>=20
>> With the new arrangement I am proposing, the two speakers in a =
left-right
>> pair get both the same two slots, meaning they get to choose one of =
the
>> two slots based on the 'Left' 'Right' value of their routing control.
>=20
> Ah, I think the confusion here is that I'm using slot and channel
> interchangably whereas you're saying that previously the driver would
> allocate two channels to each speaker with duplicate data?

I guess you could say that. Not that there=E2=80=99s duplicate data on =
the I2S
bus, but the speaker amp would previously be configured to look for the
left and right channel in the same TDM slot (see e.g. set_tdm_slot of
tas2770 [0]).  (Each speaker amp drives a single speaker, but it still
has a notion of left and right channel.)

[0] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/so=
und/soc/codecs/tas2770.c#n416

