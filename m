Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8254EDA82
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbiCaNaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiCaNaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:30:07 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63B921407F;
        Thu, 31 Mar 2022 06:28:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648733293; bh=FqpImksSRH/JJvKR/ulJSRGHTSt/GyGpFRyHrvn1QsA=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=MBSuw9NCJQJZHI3KRt9+1ulyJ4a3V4JhY7uI9iZxHWLzP3jUpdwml9m42q1qNJsbk
         R60yeOiOde688B+GPChoGgwZDt0y9W7vTuNyF1XTsVDJ17DpwZ83iQ7bmQ3NoYDfS9
         5C3oCbksu6ywcCH64WsSJYi1QP5VD5yUPpYuSPBc=
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YkWfziQzprEsWL72@sirena.org.uk>
Date:   Thu, 31 Mar 2022 15:28:12 +0200
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
Message-Id: <CCE4A06E-6D6F-457D-B3C5-C36209BF38D3@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <YkWfziQzprEsWL72@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 31. 3. 2022, at 14:34, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Thu, Mar 31, 2022 at 02:04:44AM +0200, Martin Povi=C5=A1er wrote:
>=20
>> I put together a machine-level ASoC driver for recent Apple Macs (the
>> ones with ARM64 SoCs) and want to gauge opinions.
>=20
> This would be a bit easier to review with a description of the =
hardware.

The typical hardware configuration the driver is supposed to be used =
with
is this:

 * SoC with couple of I2S ports.

 * Array of speakers with individual speaker amp chips, hooked to a =
single
   I2S bus or split between two of the SoC=E2=80=99s I2S ports. Speakers =
can be
   one, two, four or six in total. The speaker amp chips resemble either
   TAS2770 or TAS2764.=20

 * Jack codec hooked to a separate I2S port, operating independently.
   (Codec driver supports set_jack.)

The example in the binding patch describes an actual arrangement on one
piece of hardware.

>> Commit 2 adds a new ASoC card method (filter_controls) to let the =
card
>> prevent some codec kcontrols from being visible to userspace. For =
example
>> the TAS2770 speaker amp driver would be happy to expose TDM slot =
selection
>> and ISENSE/VSENSE enables which is ridiculous. I am all ears on how =
to
>> make the patch acceptable to upstream.
>=20
> The broad issue here is that what you consider ridiculous someone else
> might have some bright ideas for configuring dynamically - if things =
are
> being exposed for dynamic configuration it's probably because someone
> wanted them, if the control is genuinely useless then it should just =
be
> removed.  Rather than getting in the way of people's policy arguments
> about how to set things we expose them to userspace and let userspace
> worry about it, usually with the help of UCM files.  The general
> userspace model is that people interact with their sound server more
> than the hardware card.  This is also helpful for people developing =
use
> cases, it means they're not having to get the kernel rebuilt to tune
> things.

Well but these are codec drivers reused on different systems, it can =
both
be 'not genuinely useless=E2=80=99 on some system and ridiculous to =
leave open on
the systems I am trying to write drivers for.

> The TDM swap thing you're mentioning looks like it's a left/right
> selection which people do use sometimes as a way of doing mono mixes =
and
> reorientation.  The ISENSE/VSENSE is less obvious, though it's =
possible
> there's issues with not having enough slots on a heavily used TDM bus =
or
> sometimes disabling the speaker protection processing for whatever
> reason.

Not only that. On TAS2770 the default value for =E2=80=98ASI1 Sel=E2=80=99=
 is =E2=80=98I2C offset=E2=80=99
meaning the speaker amp driver ignores my set_tdm_slot calls. If you =
tell
me it=E2=80=99s okay to change that behaviour and it won=E2=80=99t be =
considered backwards
compatibility breaking, that would be part of the solution I am seeking
here.

But even then, what for example if the system has a single speaker (as =
it
does on the Mac mini to be covered by this driver) and the I2S bus is =
left
undriven for the duration of unused TDM slots? That may genuinely pose
a risk of people blowing their speakers by switching something in =
alsamixer.
Now I can actually make sure the I2S data lines are always zeroed out in
the ASoC platform driver, but I would rather not even have to tie these
loose ends for a control there=E2=80=99s no reason to expose in the =
first place
(again, on this system).

The ISENSE/VSENSE controls are also actually useless on these systems as =
we
are not doing anything to pick up the measured values (which are sent =
back
over the I2S lines). I don=E2=80=99t know if there can be driver =
conflict between
two speaker amps trying to drive the I2S lines at the same time should
the user happen to enable SENSE facilities on more than one of them.
Now I can grudgingly study that and rule it out but I would rather hide
the controls altogether.

That=E2=80=99s the reasoning anyway. To reiterate, seems to me the =
controls
are useless/confusing at best and dangerous at worst.

Martin

