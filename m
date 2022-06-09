Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C3C5451B9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243678AbiFIQTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiFIQTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:19:43 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BED55BE;
        Thu,  9 Jun 2022 09:19:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1654791578; bh=4oG/+gfqOkTh35XvvWAtX5REN3FZwalZARzou9YHdB4=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=kd2Riq/FkSbvoJq2jjAf5MBgfp6q/RYP7eGUCErvWm+Pc0yqe6Br5pbsGU0kyhXou
         WDPbyTDjTow1Pf4Hs2LDNl7nBheIGLZdcovSs/jTdg8aYrDrO4ZaXPckBS7BU/FGVE
         A83JrJ3SU+rSCE3/BmHsI4XgoBLjxwceApHMXgZ0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH v2 5/5] ASoC: apple: Add macaudio machine driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <YqIWtzphzVGmbIOe@sirena.org.uk>
Date:   Thu, 9 Jun 2022 18:19:37 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DA6EE04-D23B-437B-8FBA-9223EAA71219@cutebit.org>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-6-povik+lin@cutebit.org>
 <YqHylN3xba9XFrF8@sirena.org.uk>
 <0E611F13-96E3-41FD-9550-F900B2EFB00A@cutebit.org>
 <YqILv21K+tZ00Qhx@sirena.org.uk>
 <2A0422B8-8367-457E-A146-730F7C3DE66B@cutebit.org>
 <YqIWtzphzVGmbIOe@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 9. 6. 2022, at 17:50, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Thu, Jun 09, 2022 at 05:24:49PM +0200, Martin Povi=C5=A1er wrote:
>>> On 9. 6. 2022, at 17:03, Mark Brown <broonie@kernel.org> wrote:
>=20
> Why is this off list?

By accident, added the CC list back with this reply (hopefully it
still attaches to the thread when people receive it).

>>> That's basically no userspaces at this point TBH.  I'm not convinced
>>> it's a good idea to be adding custom code for that use case.
>>=20
>> FWIW I know of at least one user of the WIP audio support on Macs who
>> would welcome this feature. My preference is to keep it in, but in
>> the end I guess it=E2=80=99s your call.
>=20
> I'd rather not have this open coded in individual drivers, we already
> have an unfortunate abundance of jack detection interfaces.  If we're
> going to add anything I'd rather it were in core code and TBH I'm
> struggling to be enthusiastic.

Noted.

> Can you say anything more about the use case?

I can restate: The alleged use case is running userspace without sound
server, but having playback switch transparently between speakers and
headphones even mid-stream based on jack detection.

>>>> I looked at the existing DAPM integration but I couldn=E2=80=99t =
figure out
>>>> how to switch the demux with it.
>=20
>>> Yes, it won't do that.  If you can't stream the same audio to both =
then
>>> you'd need something else.
>=20
>> I don=E2=80=99t understand what=E2=80=99s meant by streaming the same =
audio here.
>=20
> Playing one audio stream from the host which appears on both speakers
> and headphones - I don't know what the mixing and muxing capabilities =
of
> the hardware are.
>=20
>> Taking a guess: The existing DAPM integration can enable the =
headphones
>> path based on jack being plugged in, but it can=E2=80=99t disable the =
speakers
>> path like the demux does?
>=20
> No, that works perfectly fine - you can enable or disable pins =
depending
> on the jack state.

Ah, I peeked into soc-jack.c. What about this then: If I understand what
pins represent, they would be at the remote end of the DAPM paths. So if
for the speakers I add something like

   Headphones Codec Out =E2=80=94> Jack pin

                       +--> Always-on pin
                       |
   Speaker Amp Out -> Mux
                       |
                       +--> Jack inverted pin

and let userspace control the mux, it would in effect support the same
use cases as what I attempted in the code so far. Sounds somewhat right?

