Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C1D50B57A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446826AbiDVKqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446828AbiDVKqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:46:30 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6BE27FC0;
        Fri, 22 Apr 2022 03:43:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1650624211; bh=4zKNiCJ9mR8YNKg4xV+9DRTe5znRz0G2bXHhsbBhsuc=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=rbvLx9uVaZ9KLhaZck/JuJlU9H9gFERagLBhE3o2ytCZKQ11iJiiO/8KqezzNuSTn
         pQCc4HfjB8ZDB11RdeTfmScFbabJXyS6U+rAc6/SCe8v9PGAjQPSd/0lUJEYEhBJb/
         DAcjFfxZ553jXRIzeWyzghfGmwfRSlnEi3hT8HRc=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YkXKmxJ0R3qpUoH4@sirena.org.uk>
Date:   Fri, 22 Apr 2022 12:43:30 +0200
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
Message-Id: <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <YkWfziQzprEsWL72@sirena.org.uk>
 <CCE4A06E-6D6F-457D-B3C5-C36209BF38D3@cutebit.org>
 <YkW4MPh8VWc8eSGg@sirena.org.uk>
 <6D199EAB-FE14-4030-96A7-2E0E89D25FAB@cutebit.org>
 <YkXKmxJ0R3qpUoH4@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 31. 3. 2022, at 17:36, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Thu, Mar 31, 2022 at 05:04:32PM +0200, Martin Povi=C5=A1er wrote:
>>> On 31. 3. 2022, at 16:18, Mark Brown <broonie@kernel.org> wrote:
>=20
>>> Yes, having two devices driving the bus at the same time wouldn't be
>>> great.  How is the TDM slot selection for the signals done in the
>>> hardware, I'm not seeing anything immediately obvious in the driver?
>>> I'd have thought that things would be implemented such that you =
could
>>> implement speaker protection on all speakers simultaneously but =
perhaps
>>> not.
>=20
>> I don=E2=80=99t know. I would have to go study the details of this. =
Should I see
>> if I can find a combination of =E2=80=98ASI1 Sel=E2=80=99 =
=E2=80=98VSENSE=E2=80=99 =E2=80=98ISENSE=E2=80=99 settings
>> that would lead to driver conflict on one of the models, or is there
>> a chance we could hide those controls just on the basis of =E2=80=98it =
doesn=E2=80=99t
>> do anything usable and is possibly dangerous=E2=80=99?
>=20
> If ISENSE and VSENSE output are controlled by the same mux as routing
> then we should lock one of the controls out for at least stereo =
devices
> (it might be a good idea to check if the output is actually high Z =
when
> ISENSE and VSENSE are off rather than just driving zeros, if not it
> definitely has to be the routing control).  My instinct is that it's
> better to preserve the ability to implement speaker protection in =
future
> since that is something that'd be broadly useful, especially if =
someone
> comes up with a generic speaker protection implementation in which =
case
> there should be an awful lot of systems out there which could benefit.=20=


Sorry for having put this on hold for a while.

I looked in the TAS2770 and TAS2764 drivers/datasheets, and to answer
the questions we had:

 * VSENSE/ISENSE output slots are configured independently of audio =
samples
   routing. Kernel drivers configure the slots based on the =
'ti,imon-slot-no'
   and 'ti,vmon-slot-no' properties of devicetree.

 * By default codecs transmit Hi-Z for duration of unused slots.

So once we supply the devicetree props it should be electrically sound
under any configuration of userspace knobs.

One final thought on the playback routing controls: On systems with >2
speakers, the codecs need to be assigned slots through set_tdm_slot.
The macaudio driver RFCed here assigns a single slot to each speaker,
making the effect of each speaker's routing control this:

  'I2C offset' -- uses a random slot

  'Left' 'Right' 'LeftRight' -- uses the single slot we configured

I suppose I better assign two slots to speakers in each left-right pair
of the same kind (e.g. woofer 1, woofer 2, tweeter). This way the
routing control will mimic its behavior from simple stereo systems but
replicated within each left-right pair.  (I would prefer to hide the
controls altogether, but as I learned that hiding things unless proven
dangerous is an ASoC non-goal, this way I can make the controls do
something interesting.)

Martin

