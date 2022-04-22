Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE0C50B657
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447133AbiDVLrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447119AbiDVLrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:47:04 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224E5546B5;
        Fri, 22 Apr 2022 04:44:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1650627847; bh=FpuPF57lqV2wF0ozxJVgJREDohc1ui5JNgdpVwE+l8w=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=dbRI4qKchxCMWHz/gRQ8gR1uvvn7q5BnJWLyllNZscu8zPDEr7VSPjV96/jjfK8Do
         8A5M9XStn6yvgo/Fy0WO7RvQsnYEZt0e7qpaI+kedi46sXd3oIbt4NUPGClhTAI4qc
         /vctMet+PKq2Cn8h8xKfhCfdMfXGEddPIrsxnkGo=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YmKSgHrbb/7koM36@sirena.org.uk>
Date:   Fri, 22 Apr 2022 13:44:06 +0200
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
Message-Id: <A1574F30-62D2-467D-A40B-8FD7C6B8BCFA@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <YkWfziQzprEsWL72@sirena.org.uk>
 <CCE4A06E-6D6F-457D-B3C5-C36209BF38D3@cutebit.org>
 <YkW4MPh8VWc8eSGg@sirena.org.uk>
 <6D199EAB-FE14-4030-96A7-2E0E89D25FAB@cutebit.org>
 <YkXKmxJ0R3qpUoH4@sirena.org.uk>
 <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
 <YmKPQ6kLCPz+2XTJ@sirena.org.uk>
 <B68302F2-3D77-4065-8A16-A9CC690AE10B@cutebit.org>
 <YmKSgHrbb/7koM36@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 22. 4. 2022, at 13:33, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Fri, Apr 22, 2022 at 01:28:20PM +0200, Martin Povi=C5=A1er wrote:
>>> On 22. 4. 2022, at 13:19, Mark Brown <broonie@kernel.org> wrote:
>>> On Fri, Apr 22, 2022 at 12:43:30PM +0200, Martin Povi=C5=A1er wrote:
>=20
>>>> One final thought on the playback routing controls: On systems with =
>2
>>>> speakers, the codecs need to be assigned slots through =
set_tdm_slot.
>>>> The macaudio driver RFCed here assigns a single slot to each =
speaker,
>>>> making the effect of each speaker's routing control this:
>=20
> ...
>=20
>>> I don't quite grasp the difference between the arrangement you're
>>> proposing and assigning a single slot to each speaker?  Possibly =
it's
>>> just a reordering of the slots?
>=20
>> Ah, maybe what=E2=80=99s missing is the fact that the way the speaker =
amp drivers
>> are written, if they are assigned two slots with a call to =
set_tdm_slot,
>> the first slot is considered 'left' and the second is 'right'.
>=20
>> So in the arrangement I am proposing the 'Left', 'Right' and =
'LeftRight'
>> values of the routing control have the nominal effect (within the =
left-right
>> speaker pair), while in the other arrangement it is as I described =
above.
>=20
> So previously each speaker would get two slots but now it just gets =
one?

No the other way around. Previously (with the driver as it is RFCed),
each speaker gets a single slot, and 'Left', 'Right' and =E2=80=98LeftRigh=
t'
values of the routing control don't do anything different from each
other (well except maybe 'LeftRight' lessens the volume due to how
the chip handles the edge case of mixing down two channels from the
same slot).

With the new arrangement I am proposing, the two speakers in a =
left-right
pair get both the same two slots, meaning they get to choose one of the
two slots based on the 'Left' 'Right' value of their routing control.

