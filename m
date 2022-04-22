Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E450B625
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447051AbiDVLbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiDVLbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:31:17 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0703754F9F;
        Fri, 22 Apr 2022 04:28:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1650626900; bh=nnRPoDn9UVOQmCSWBi2f0yPJ71M+pe94PUc3/C0TV6E=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=BAChplZkXMuMU7YQjAHHfzse8aIDAhSV5emQZaIx7Fr664MnS1WotKU9oMqA0G08L
         oXMJk5Zl8gsP1sytZjTBTyJAUSP9cPK8UoNsouQlgULCRve8jQJ5qZOdAtY4pCgwnh
         ywCL6HvHVjTcsUbT0ceA4vN62COm59lDp5Bn/fMM=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YmKPQ6kLCPz+2XTJ@sirena.org.uk>
Date:   Fri, 22 Apr 2022 13:28:20 +0200
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
Message-Id: <B68302F2-3D77-4065-8A16-A9CC690AE10B@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <YkWfziQzprEsWL72@sirena.org.uk>
 <CCE4A06E-6D6F-457D-B3C5-C36209BF38D3@cutebit.org>
 <YkW4MPh8VWc8eSGg@sirena.org.uk>
 <6D199EAB-FE14-4030-96A7-2E0E89D25FAB@cutebit.org>
 <YkXKmxJ0R3qpUoH4@sirena.org.uk>
 <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
 <YmKPQ6kLCPz+2XTJ@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 22. 4. 2022, at 13:19, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Fri, Apr 22, 2022 at 12:43:30PM +0200, Martin Povi=C5=A1er wrote:
>=20
>> I looked in the TAS2770 and TAS2764 drivers/datasheets, and to answer
>> the questions we had:
>=20
>> * VSENSE/ISENSE output slots are configured independently of audio =
samples
>>   routing. Kernel drivers configure the slots based on the =
'ti,imon-slot-no'
>>   and 'ti,vmon-slot-no' properties of devicetree.
>=20
>> * By default codecs transmit Hi-Z for duration of unused slots.
>=20
>> So once we supply the devicetree props it should be electrically =
sound
>> under any configuration of userspace knobs.
>=20
> Great, that's a relief.
>=20
>> One final thought on the playback routing controls: On systems with =
>2
>> speakers, the codecs need to be assigned slots through set_tdm_slot.
>> The macaudio driver RFCed here assigns a single slot to each speaker,
>> making the effect of each speaker's routing control this:
>=20
>>  'I2C offset' -- uses a random slot
>=20
>>  'Left' 'Right' 'LeftRight' -- uses the single slot we configured
>=20
>> I suppose I better assign two slots to speakers in each left-right =
pair
>> of the same kind (e.g. woofer 1, woofer 2, tweeter). This way the
>> routing control will mimic its behavior from simple stereo systems =
but
>> replicated within each left-right pair.  (I would prefer to hide the
>> controls altogether, but as I learned that hiding things unless =
proven
>> dangerous is an ASoC non-goal, this way I can make the controls do
>> something interesting.)
>=20
> I don't quite grasp the difference between the arrangement you're
> proposing and assigning a single slot to each speaker?  Possibly it's
> just a reordering of the slots?

Ah, maybe what=E2=80=99s missing is the fact that the way the speaker =
amp drivers
are written, if they are assigned two slots with a call to set_tdm_slot,
the first slot is considered 'left' and the second is 'right'.

So in the arrangement I am proposing the 'Left', 'Right' and 'LeftRight'
values of the routing control have the nominal effect (within the =
left-right
speaker pair), while in the other arrangement it is as I described =
above.

