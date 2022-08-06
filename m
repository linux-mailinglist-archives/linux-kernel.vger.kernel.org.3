Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC38758B712
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiHFQvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiHFQvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:51:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD1EDEAB;
        Sat,  6 Aug 2022 09:51:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C02BB807E5;
        Sat,  6 Aug 2022 16:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB00C4347C;
        Sat,  6 Aug 2022 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659804693;
        bh=Oh2K/3bcZIMdXmQON7AZPIv0AYx4m5BoaE07zhj6VoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FcY5wVauh6a1++B+RZiyOB3YKli8kMdbrXs3RlHdwnVq1Bq7NDrcu/ZxBe/Fca1mW
         gV5FfxzqYf2tmuZz7OAIDqynIrKuNKyNPsVsWEehV8qXiIClGYVyhaL7mrSEXuoKbb
         zEd36DmWaDYG1/inQ7AXrTQZdaBc3unsO6faURZ5UyvMJ6MRRnyAuzo5lV+Tv/VTK4
         4+1oeW33fSYkw2/HF6UTUGqFQl8116/sX0elcFdO0nNL1AhF3bCpEMzOALV6lAD6AU
         +3m3v75Jh6PI4Kw8q7UIBtYvpLjYTB/v/UC65kZvW4dGnfayS709MWfNNsnxb/PrRO
         QUBvhnqlimrSw==
Date:   Sat, 6 Aug 2022 18:01:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com, William Breathitt Gray <william.gray@linaro.org>
Subject: Re: [PATCH v3 2/2] iio: time: capture-tiecap: capture driver
 support for ECAP
Message-ID: <20220806180153.1eb22591@jic23-huawei>
In-Reply-To: <98d17617-72b5-6330-d4f5-1bece928ceab@baylibre.com>
References: <20220728175124.468461-1-jpanis@baylibre.com>
        <20220728175124.468461-3-jpanis@baylibre.com>
        <20220731164116.30e91f34@jic23-huawei>
        <11b7436b-5c31-671e-ba77-435fe8e3b767@baylibre.com>
        <98d17617-72b5-6330-d4f5-1bece928ceab@baylibre.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2022 15:28:09 +0200
Julien Panis <jpanis@baylibre.com> wrote:

> On 01/08/2022 16:08, Julien Panis wrote:
> >
> >
> > On 31/07/2022 17:41, Jonathan Cameron wrote: =20
> >> On Thu, 28 Jul 2022 19:51:24 +0200
> >> Julien Panis <jpanis@baylibre.com> wrote:
> >> =20
> >>> ECAP hardware on AM62x SoC supports capture feature. It can be used
> >>> to timestamp events (falling/rising edges) detected on signal input=20
> >>> pin.
> >>>
> >>> This commit adds capture driver support for ECAP hardware on AM62x So=
C.
> >>>
> >>> In the ECAP hardware, capture pin can also be configured to be in
> >>> PWM mode. Current implementation only supports capture operating mode.
> >>> Hardware also supports timebase sync between multiple instances, but
> >>> this driver supports simple independent capture functionality.
> >>>
> >>> Signed-off-by: Julien Panis <jpanis@baylibre.com> =20
> >> Hi Julien,
> >>
> >> So this isn't the first ecap driver we've had proposed, but the previo=
us
> >> one was a few years ago and never reached v2.
> >> https://lore.kernel.org/all/20200818153614.6438-1-dts86@cornell.edu/
> >>
> >> Honestly I can't remember much about it, but maybe the discussion arou=
nd
> >> that will be worth a reread. =20
> >
> > Hi Jonathan, thank you for your review.
> >
> > I read the discussion about previous attempt, before submitting this=20
> > patch. There were
> > interesting comments indeed.
> >
> > But in this previous attempt, only one-shot pulses were handled=20
> > (moreover, global IRQ flag
> > was not cleared, so I'm not sure that IRQ could be raised more than=20
> > once).
> >
> > However, ECAP can be used to make time measurements for any type of=20
> > "square waveform".
> > That's why I tried to make this event mode configurable. Besides,=20
> > using a continuous mode allows
> > handling much more signal types (not only single pulses).
> > =20
> >>
> >> The use of ABI here is unusual. So I'd definitely like to see some=20
> >> documentation
> >> probably as a file in the main kernel documentation to explain what=20
> >> the interface
> >> is an how that relates to what is being captured. =20
> >
> > OK, I will add some userspace documentation.
> > =20
> >>
> >> First thing to note here is the channel type of IIO_INDEX is now not=20
> >> actually
> >> used any more because we moved all the relevant drivers over to the=20
> >> counter
> >> subsystem (and we failed to mark it deprecated). =20
> >
> > I evaluated this counter subsystem before starting development.=20
> > Counting events is not "a priori"
> > the goal when using ECAP.
> >
> > Nevertheless, maybe "counter_push_event" function could do the job. If=
=20
> > I use counter API :
> > # Option 1 : CAP1/2/3/4 registers could be seen as 4 channels of the=20
> > same counter...
> > but there are not channels, there are just sequential timestamps=20
> > actually. So I'm afraid this leads
> > to misunderstanding for the user.
> > Moreover, the user will have to read several entries (counts 1/2/3/4)=20
> > to gather timestamps from
> > the same input signal, which is not very convenient.
> > # Option 2 : Either CAP 1/2/3/4 events could be gathered in a single=20
> > channel...but then it will not
> > be possible to configure their polarity (rising/falling edge)=20
> > individually (unless I did
> > not understand well counter framework documentation).
> >
> > So, even with counter framework, it will lead to some diverted use of=20
> > the framwork, since ECAP
> > is a very specific hardware that do not fit 100% counter philosophy.
> >
> > I admit that ECAP do not fit 100% IIO philosophy either.
> >
> > Maybe misc API would be more relevant actually. Any opinion about it=20
> > will be welcome. :-) =20
>=20
> [Answering my own mail]
>=20
> I got a closer look at counter framework. It is not suitable at all for=20
> ECAP. Initially, I thought that
> "counter_push_event" function could be used, but the only timestamp=20
> handled by this function
> is a software timestamp. I strongly doubt that counter framework=20
> maintainer would accept
> some modification here to support hardware timestamp : a patch rejection=
=20
> would be
> legitimate, since a counter is dedicated to "event counting". Whereas=20
> ECAP is dedicated to
> "event timestamping".
+CC William. =20

one thing to note is that a hardware timestamp is just a freerunning
counter.  As such, you can capture it alongside other data in a similar
fashion to any mutliple counter acquisition (which is the same as we
will be doing with this in IIO anyway).

>=20
> Beside, ECAP has 4 timestamp registers but they are used to capture=20
> timestamps for a
> single input pin (only 1 channel). In ECAP context, 'index X" is used to=
=20
> identify CAP X
> (used to capture event X detected on a single pin, with X =3D 0/1/2/3/0..=
.).
> In counter framework, "index X" is used to identify channel X (among=20
> several pins).
> So, the word "index" has not the same meaning in counter framework than=20
> in ECAP device.
> Somehow, this ECAP index (0/1/2/3 for CAP1/2/3/4 registers) must be=20
> logged with timestamp
> because it is an important part of signal info for the user (raw=20
> consecutive timestamps
> are not enough).
>=20
> So, here is my proposal for my next version :
> (1) Replace IIO_INDEX by IIO_COUNT channel (already used in=20
> "stm32-timer-trigger.c" driver)

IIO_COUNT might work, but don't use that driver as a basis. It's a leftover
that was complex to clean up that no one has had the time to do yet.

We want to be careful that any meaning we assign to ABI via this driver
doesn't cause legacy problems.

> # In ECAP documentation, the word "index" is not used. The word used to=20
> speak about this
> 0->1->2->3->0 sequenced counter is "Mod4 counter".
> (2) Configure event mode with 4 sysfs entries (to remove the mix of=20
> buffers and events interfaces)
> # User will see 4 files (1 file for each CAP timestamp) named=20
> "falling_edge_active_0/1/2/3".
> Writing 1 will select falling edge/ Writing 0 will select rising edge.

Naming should reflect the channel to which it applies. So add a prefix to
that. Maybe in_countX_falling_edge_active etc (I'm not sure how this
would fit together as a whole ABI however).

A few questions / comments that might help me get my head around this.

There isn't a direct association between a wire and a channel in IIO.
We have various derived channels.  It's more about measuring 'one thing'.

So we could treat these various signals as aspects of a given thing.
Perhaps simply as events (though the interface for those assumes a common
timestamp basis with the host OS).  In that case we'd have 4 events
and every time one fired we'd push an even across to userspace.

Or we treat them as 4 aspects in a 'scan'.  That means we only get
data once all enabled 'edges' are seen, as we push them all together
as 4 channels.  Those channels contain the 4 timestamps from one
sequence of 0,1,2,3.  Either could be abstract counts, or could be
4 timestamps.

I'm not really sure which approach would work out better.

Rule of thumb. IIO events are for asynchronous things like threshold crossi=
ng
detections.  Arguably your detections here are in that category, but because
they happen, 0,1,2,3,0,1,2,3 etc they also look like channel scans - where
we normally pretend they are simultaneous measurements of different signals.
They are rarely actually simultaneous as normally there is a mux involved
somewhere and they channels are sampled sequentially and when a scan is fin=
ished
the hardware may well immediately start on the next one.



>=20
> Would it be an acceptable alternative for you, Jonathan ? Would either=20
> (1) and/or (2) be a "no-go" ?

It may take us a few more iterations to come to a conclusion and even if
the counter subsystem is looking unlikely I'd still like William's input
on this even if it ends up in IIO.  He spent quite some time hammering
odd devices into IIO before there was a counter subsystem.

Thanks,

Jonathan

>=20
> > =20
> >>
> >> Anyhow, I've reviewed below, but need docs to discuss this in depth.=
=C2=A0=20
> >> In particular
> >> the mix of buffers and events interfaces is unlikely to be an=20
> >> acceptable path
> >> forwards. =20
> >
> > OK, I will consider alternatives.
> > =20
> >>
> >> Jonathan =20
>=20

