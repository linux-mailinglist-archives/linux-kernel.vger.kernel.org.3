Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07FD50B95A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448305AbiDVOCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbiDVOCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:02:25 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA295A14D;
        Fri, 22 Apr 2022 06:59:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1650635966; bh=OPTWL88wx7VdNdMeR/dWu1A51DUlJpqaNYL/YGs6XU4=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=Rbo9vOumJP9KdV5finiGzAkBjNKa7iRrORw6kpRN7GZJVDKj+sDP8c87S3ooJhE8w
         RmVwoV+40VfncKdNwpM6URe0HikudfpNioWiaVoIAeWelg1UjFDZ3snkX8kd4Ua1fk
         ZhO9IvMfylt6vU+wjVjf33M2BIv+zqp+rae0xle0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YmKoXbh04ZEs3dSZ@sirena.org.uk>
Date:   Fri, 22 Apr 2022 15:59:25 +0200
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
Message-Id: <0E735637-EDA8-4A68-8B43-01BCEC41245C@cutebit.org>
References: <YkXKmxJ0R3qpUoH4@sirena.org.uk>
 <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
 <YmKPQ6kLCPz+2XTJ@sirena.org.uk>
 <B68302F2-3D77-4065-8A16-A9CC690AE10B@cutebit.org>
 <YmKSgHrbb/7koM36@sirena.org.uk>
 <A1574F30-62D2-467D-A40B-8FD7C6B8BCFA@cutebit.org>
 <YmKeEKa0w2xLM9cL@sirena.org.uk>
 <6F6130F3-381C-4AB7-B618-CDC4C4A37C9B@cutebit.org>
 <YmKjL9bOtOmsFWTs@sirena.org.uk>
 <3CD969AD-7316-4D83-AD92-CC85ED817125@cutebit.org>
 <YmKoXbh04ZEs3dSZ@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 22. 4. 2022, at 15:06, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Fri, Apr 22, 2022 at 02:53:54PM +0200, Martin Povi=C5=A1er wrote:
>=20
>>> Oh, I see - the speaker actually allows configuration of the slots
>>> independently.  Usually the left/right thing on mono devices only =
does
>>> something for I2S where the bus clocking enforces that there be both
>>> left and right channels.  Either configuration is fine by me TBH, if =
you
>>> can do that then you could just keep them mapped to the same channel
>>> then mark the control as disabled since it should have no effect.
>=20
>> Well but is there some established way to mark a control as disabled?
>=20
> snd_ctl_activate_id().

Ha! Great.

>> Another issue here is that if I disable it I can=E2=80=99t leave the =
routing
>> control in it=E2=80=99s default value, which is =E2=80=98I2C =
Offset=E2=80=99 and makes the speaker
>> amp ignore the slot mapping.
>=20
> Sure, that's fine - if a control genuinely has no effect it's fine to
> hide it from userspace.  The issue is where it's just that you don't =
see
> the use, if the control demonstrably does nothing then that's fine.

So I assume I can set the control from the machine driver then disable =
it.

Anyway, good, this is what I meant earlier when I said the controls I =
want
to hide are 'useless/confusing at best=E2=80=99. I must walk back that =
they are
=E2=80=98dangerous at worst=E2=80=99, but I am glad we can hide them =
anyway. (Not all of
them of course, ISENSE/VSENSE will not be hidden, neither the routing
control on systems with single mono speaker.)

