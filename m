Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A5B4ED97E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiCaMSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiCaMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:18:45 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09616419B9;
        Thu, 31 Mar 2022 05:16:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648729016; bh=2YK9PobV56vBSewgMTaSA0OXwlHtMdyVGAlP+LxlCGs=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=DHnb0BoWtg1BWG7/iwtgO9Fh9MZFwAdD9k0FZmKZs8K6KK0pDvQm5w6KeOVLYa0ej
         zRpdy8PZwATSMFjvTyJT22o1/6WO5D2qWJqwbkeMrEeS0FeqiHM8zL741fH5dtKZgc
         JBWvre/zYpZCNjRXkdp5D3X7eX0JxZa9p6RLkJ34=
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC PATCH 5/5] ASoC: Add macaudio machine driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <4651D426-BA1A-418F-90E5-278C705DA984@cutebit.org>
Date:   Thu, 31 Mar 2022 14:16:56 +0200
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
Message-Id: <F6666436-293B-4D13-8A61-D5ED620BEB05@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-6-povik+lin@cutebit.org>
 <YkWXs/f7edZwg1+W@sirena.org.uk>
 <4651D426-BA1A-418F-90E5-278C705DA984@cutebit.org>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 31. 3. 2022, at 14:08, Martin Povi=C5=A1er <povik@cutebit.org> =
wrote:
>=20
>>=20
>> On 31. 3. 2022, at 13:59, Mark Brown <broonie@kernel.org> wrote:
>>=20
>> On Thu, Mar 31, 2022 at 02:04:49AM +0200, Martin Povi=C5=A1er wrote:
>>=20
>>> --- /dev/null
>>> +++ b/sound/soc/apple/macaudio.c
>>> @@ -0,0 +1,597 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * ASoC machine driver for Apple Silicon Macs
>>> + *

(snip)

>>> +/*
>>> + * Maybe this could be a general ASoC function?
>>> + */
>>> +static void snd_soc_kcontrol_set_strval(struct snd_soc_card *card,
>>> +				struct snd_kcontrol *kcontrol, const =
char *strvalue)
>>=20
>> No, we should not be setting user visible control values from the
>> kernel.  This shouldn't be a machine driver function either.  What =
are
>> you trying to accomplish here?
>=20
> See above.
>=20
> Martin

One thing I didn=E2=80=99t point out. The controls we are setting here =
are not
visible from userspace. That=E2=80=99s the point of the =E2=80=98filter=E2=
=80=99 card method
I am trying to establish in the other commit. With it, the card decides
which controls are okay to be exported and which should be hidden.

Here we are only setting hidden controls.

Martin

