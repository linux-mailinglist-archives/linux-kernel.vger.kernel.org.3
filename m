Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23854EDC52
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbiCaPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiCaPG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:06:27 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA0531DC6;
        Thu, 31 Mar 2022 08:04:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648739073; bh=Gbs6tg3skhw4iV8rn16Vi4dTeQOEU2j8Ua0eJjFEIRI=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=UxK4BkneLgDYJnS9yHUey/xTnu7DvHl4N0bAER7LwYK9NaIywtoi1EgnY8dqwpDk1
         T8BGOYtJy+NLEeIQ+tGNddxWMikOZNYJoWHVMjgVjx5hiNwemRZTjiqj7ehZmEmmqI
         EkzlDxIPdcETMFA6N2eOy7+Q7vE2bXwkK1VUiDQo=
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YkW4MPh8VWc8eSGg@sirena.org.uk>
Date:   Thu, 31 Mar 2022 17:04:32 +0200
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
Message-Id: <6D199EAB-FE14-4030-96A7-2E0E89D25FAB@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <YkWfziQzprEsWL72@sirena.org.uk>
 <CCE4A06E-6D6F-457D-B3C5-C36209BF38D3@cutebit.org>
 <YkW4MPh8VWc8eSGg@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 31. 3. 2022, at 16:18, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Thu, Mar 31, 2022 at 03:28:12PM +0200, Martin Povi=C5=A1er wrote:
>>> On 31. 3. 2022, at 14:34, Mark Brown <broonie@kernel.org> wrote:
>=20
>>> The broad issue here is that what you consider ridiculous someone =
else
>>> might have some bright ideas for configuring dynamically - if things =
are
>>> being exposed for dynamic configuration it's probably because =
someone
>>> wanted them, if the control is genuinely useless then it should just =
be
>=20
>> Well but these are codec drivers reused on different systems, it can =
both
>> be 'not genuinely useless=E2=80=99 on some system and ridiculous to =
leave open on
>> the systems I am trying to write drivers for.
>=20
> It wouldn't be the first time that we've had someone turn up with a =
new
> idea for how to configure an already existing bit of hardware, part of
> the reason for this approach is that people do get surprised by user
> creativity with their systems.
>=20
>>> The TDM swap thing you're mentioning looks like it's a left/right
>>> selection which people do use sometimes as a way of doing mono mixes =
and
>>> reorientation.  The ISENSE/VSENSE is less obvious, though it's =
possible
>>> there's issues with not having enough slots on a heavily used TDM =
bus or
>>> sometimes disabling the speaker protection processing for whatever
>>> reason.
>=20
>> Not only that. On TAS2770 the default value for =E2=80=98ASI1 Sel=E2=80=
=99 is =E2=80=98I2C offset=E2=80=99
>> meaning the speaker amp driver ignores my set_tdm_slot calls. If you =
tell
>> me it=E2=80=99s okay to change that behaviour and it won=E2=80=99t be =
considered backwards
>> compatibility breaking, that would be part of the solution I am =
seeking
>> here.
>=20
> Having the default state be muted or not routed is quite common, UCM
> files or equivalent are typically required for embedded style hardware
> like this.
>=20
>> But even then, what for example if the system has a single speaker =
(as it
>> does on the Mac mini to be covered by this driver) and the I2S bus is =
left
>> undriven for the duration of unused TDM slots? That may genuinely =
pose
>> a risk of people blowing their speakers by switching something in =
alsamixer.
>=20
> Right, so that's a more sensible and valid use case.  We do have the
> platform_max feature available for precisely this reason - that's
> probably more appropriate here since if there's a danger of people
> blowing their speaker with a floating input they could also blow their
> speaker with just a very loud audio signal so limiting the volume =
people
> can set on the speaker driver seems sensible and would also cover them
> for misrouting.  Whatever the device might pick up from noise on an
> undriven bus could also be played as audio down the bus.  This does
> become a little fun with speaker protection as we'd want to raise the
> kernel limit so that userspace can dynamically manage the volume to
> contorl power (though that might be done with software control), but
> it's easy enoguh to raise limits later.
>=20
> On the other hand it seems like userspace might reasonably choose to =
do
> a mono mix for this output entirely in software, in which case telling
> the speaker amp to pick up one channel would make sense, or to just =
play
> out a stereo signal over I2S and have the amplifier do a mono mix and
> I'm not seeing why we'd force one or the other in the machine driver.

Granted. If we make sure the volume caps are there to prevent damage
under arbitrary input (which we should anyway) that covers slot
misconfiguration too.

>> The ISENSE/VSENSE controls are also actually useless on these systems =
as we
>> are not doing anything to pick up the measured values (which are sent =
back
>> over the I2S lines). I don=E2=80=99t know if there can be driver =
conflict between
>=20
> Presumably someone might want to work on figuring that out though, and
> from a hardware safety point of view it would be better if they did.
>=20
>> two speaker amps trying to drive the I2S lines at the same time =
should
>> the user happen to enable SENSE facilities on more than one of them.
>> Now I can grudgingly study that and rule it out but I would rather =
hide
>> the controls altogether.
>=20
> Yes, having two devices driving the bus at the same time wouldn't be
> great.  How is the TDM slot selection for the signals done in the
> hardware, I'm not seeing anything immediately obvious in the driver?
> I'd have thought that things would be implemented such that you could
> implement speaker protection on all speakers simultaneously but =
perhaps
> not.

I don=E2=80=99t know. I would have to go study the details of this. =
Should I see
if I can find a combination of =E2=80=98ASI1 Sel=E2=80=99 =E2=80=98VSENSE=E2=
=80=99 =E2=80=98ISENSE=E2=80=99 settings
that would lead to driver conflict on one of the models, or is there
a chance we could hide those controls just on the basis of =E2=80=98it =
doesn=E2=80=99t
do anything usable and is possibly dangerous=E2=80=99?

>> That=E2=80=99s the reasoning anyway. To reiterate, seems to me the =
controls
>> are useless/confusing at best and dangerous at worst.
>=20
> I'm just not seeing an issue for the slot selection.

Yeah, agreed there=E2=80=99s no (damage) issue as we should to proper =
volume
caps anyway.

Martin

