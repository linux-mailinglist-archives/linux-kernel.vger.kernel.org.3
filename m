Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08D958BE7B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 02:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiHHAbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 20:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiHHAbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 20:31:07 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DDC5F66
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 17:31:05 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id i24so5449729qkg.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 17:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=TTVL22SGy2kq4yoKLlxt4wtHFOcNG2UjyfoZb7+GPYc=;
        b=Bqfs/jChXlFooFnJz+2onXIFBU/0f2/M/9bGouqL5DdwhiWsIZGRtzilB690W73ONK
         3pKt3IN68CoidnFFb0PlmwjWUso5syJG+DMJsde2+uYrMzQEAfOvHsSRnsfm9QtzU6VH
         e/6xD557EYfOQmW00ICN1ThiJKoJU/UI6sSsOFTHS/1FGkLFqR0rmLAf7mgHiKm24VDp
         nD4mm01Zc3O3oZ6XRW6tyG4eu0SDTCHK/pxJ7EwlzyJ+rf3w6UNibc7jREMEcQTn2FD3
         NcJVSOiip0LGv8s/+aYV13pN8B17H63uys7ODJwqy9PCRgGnMnOr9osBZPxs3Ew9knQh
         P7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=TTVL22SGy2kq4yoKLlxt4wtHFOcNG2UjyfoZb7+GPYc=;
        b=sim5uZSUl8v82lQANawDDeWrB8IETXIDxkOrVfuYlAK0ld33o8zpz7RInIDdkMHMyR
         qvrbyEBRuAhkgPlXj3bZf9yFudO0HyT3lTXCgPZZfKnZ8YID+uxRvYIb1633/0aTARcH
         TE8ukjooReuXmlEg2A+AzSKNqvfKt+wk8tg3XY2p8Vrf5fio+maiv+3PosGLAkm6HwFG
         HKVVNmZZr7btvJEkF7NFSgwLmbXBXxBP/Oaa0W64O2+YhDA4MQ+1igOY5BpMePfQQ0DN
         dXjdd31dNGD8jgrmUky5fJI1jjT4alZadYDnMLzMLUC4TVc1Yjn9iagHINuflbvkLEQX
         FwrQ==
X-Gm-Message-State: ACgBeo37BNZP11xRim7xcBcRv6PaHPAs2mvragFYWdlZ0fZ+KNtI8OYx
        H9v9JJDdBdXDoxY6iVM6Ya5CQw==
X-Google-Smtp-Source: AA6agR7y476NMI/Va5b5Wnm+3/tQDqWuNSVbx1d8PFcB+09gx3J9/jkL8mzqJW5eUOa6zFiSRmQSyA==
X-Received: by 2002:a37:c4b:0:b0:6b9:3ff3:a8c with SMTP id 72-20020a370c4b000000b006b93ff30a8cmr4495591qkm.325.1659918664507;
        Sun, 07 Aug 2022 17:31:04 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id k5-20020a05620a414500b006b93ef659c3sm3500813qko.39.2022.08.07.17.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 17:31:03 -0700 (PDT)
Date:   Sun, 7 Aug 2022 20:30:58 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mranostay@ti.com
Subject: Re: [PATCH v3 2/2] iio: time: capture-tiecap: capture driver support
 for ECAP
Message-ID: <YvBZQsiAm6f3yxME@fedora>
References: <20220728175124.468461-1-jpanis@baylibre.com>
 <20220728175124.468461-3-jpanis@baylibre.com>
 <20220731164116.30e91f34@jic23-huawei>
 <11b7436b-5c31-671e-ba77-435fe8e3b767@baylibre.com>
 <98d17617-72b5-6330-d4f5-1bece928ceab@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wLcvE1FSUtpXsS7A"
Content-Disposition: inline
In-Reply-To: <98d17617-72b5-6330-d4f5-1bece928ceab@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wLcvE1FSUtpXsS7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 02, 2022 at 03:28:09PM +0200, Julien Panis wrote:
>=20
>=20
> On 01/08/2022 16:08, Julien Panis wrote:
> >=20
> >=20
> > On 31/07/2022 17:41, Jonathan Cameron wrote:
> > > On Thu, 28 Jul 2022 19:51:24 +0200
> > > Julien Panis <jpanis@baylibre.com> wrote:
> > >=20
> > > > ECAP hardware on AM62x SoC supports capture feature. It can be used
> > > > to timestamp events (falling/rising edges) detected on signal
> > > > input pin.
> > > >=20
> > > > This commit adds capture driver support for ECAP hardware on AM62x =
SoC.
> > > >=20
> > > > In the ECAP hardware, capture pin can also be configured to be in
> > > > PWM mode. Current implementation only supports capture operating mo=
de.
> > > > Hardware also supports timebase sync between multiple instances, but
> > > > this driver supports simple independent capture functionality.
> > > >=20
> > > > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > > Hi Julien,
> > >=20
> > > So this isn't the first ecap driver we've had proposed, but the previ=
ous
> > > one was a few years ago and never reached v2.
> > > https://lore.kernel.org/all/20200818153614.6438-1-dts86@cornell.edu/
> > >=20
> > > Honestly I can't remember much about it, but maybe the discussion aro=
und
> > > that will be worth a reread.
> >=20
> > Hi Jonathan, thank you for your review.
> >=20
> > I read the discussion about previous attempt, before submitting this
> > patch. There were
> > interesting comments indeed.
> >=20
> > But in this previous attempt, only one-shot pulses were handled
> > (moreover, global IRQ flag
> > was not cleared, so I'm not sure that IRQ could be raised more than
> > once).
> >=20
> > However, ECAP can be used to make time measurements for any type of
> > "square waveform".
> > That's why I tried to make this event mode configurable. Besides, using
> > a continuous mode allows
> > handling much more signal types (not only single pulses).
> >=20
> > >=20
> > > The use of ABI here is unusual. So I'd definitely like to see some
> > > documentation
> > > probably as a file in the main kernel documentation to explain what
> > > the interface
> > > is an how that relates to what is being captured.
> >=20
> > OK, I will add some userspace documentation.
> >=20
> > >=20
> > > First thing to note here is the channel type of IIO_INDEX is now not
> > > actually
> > > used any more because we moved all the relevant drivers over to the
> > > counter
> > > subsystem (and we failed to mark it deprecated).
> >=20
> > I evaluated this counter subsystem before starting development. Counting
> > events is not "a priori"
> > the goal when using ECAP.
> >=20
> > Nevertheless, maybe "counter_push_event" function could do the job. If I
> > use counter API :
> > # Option 1 : CAP1/2/3/4 registers could be seen as 4 channels of the
> > same counter...
> > but there are not channels, there are just sequential timestamps
> > actually. So I'm afraid this leads
> > to misunderstanding for the user.
> > Moreover, the user will have to read several entries (counts 1/2/3/4) to
> > gather timestamps from
> > the same input signal, which is not very convenient.
> > # Option 2 : Either CAP 1/2/3/4 events could be gathered in a single
> > channel...but then it will not
> > be possible to configure their polarity (rising/falling edge)
> > individually (unless I did
> > not understand well counter framework documentation).
> >=20
> > So, even with counter framework, it will lead to some diverted use of
> > the framwork, since ECAP
> > is a very specific hardware that do not fit 100% counter philosophy.
> >=20
> > I admit that ECAP do not fit 100% IIO philosophy either.
> >=20
> > Maybe misc API would be more relevant actually. Any opinion about it
> > will be welcome. :-)
>=20
> [Answering my own mail]
>=20
> I got a closer look at counter framework. It is not suitable at all for
> ECAP. Initially, I thought that
> "counter_push_event" function could be used, but the only timestamp handl=
ed
> by this function
> is a software timestamp. I strongly doubt that counter framework maintain=
er
> would accept
> some modification here to support hardware timestamp : a patch rejection
> would be
> legitimate, since a counter is dedicated to "event counting". Whereas ECAP
> is dedicated to
> "event timestamping".
>=20
> Beside, ECAP has 4 timestamp registers but they are used to capture
> timestamps for a
> single input pin (only 1 channel). In ECAP context, 'index X" is used to
> identify CAP X
> (used to capture event X detected on a single pin, with X =3D 0/1/2/3/0..=
=2E).
> In counter framework, "index X" is used to identify channel X (among seve=
ral
> pins).
> So, the word "index" has not the same meaning in counter framework than in
> ECAP device.
> Somehow, this ECAP index (0/1/2/3 for CAP1/2/3/4 registers) must be logged
> with timestamp
> because it is an important part of signal info for the user (raw consecut=
ive
> timestamps
> are not enough).
>=20
> So, here is my proposal for my next version :
> (1) Replace IIO_INDEX by IIO_COUNT channel (already used in
> "stm32-timer-trigger.c" driver)
> # In ECAP documentation, the word "index" is not used. The word used to
> speak about this
> 0->1->2->3->0 sequenced counter is "Mod4 counter".
> (2) Configure event mode with 4 sysfs entries (to remove the mix of buffe=
rs
> and events interfaces)
> # User will see 4 files (1 file for each CAP timestamp) named
> "falling_edge_active_0/1/2/3".
> Writing 1 will select falling edge/ Writing 0 will select rising edge.
>=20
> Would it be an acceptable alternative for you, Jonathan ? Would either (1)
> and/or (2) be a "no-go" ?

Hi Julien,

I've taken a cursory look over the TI ECAP reference guide and your
descriptions in this thread. I think a device driver for this would fit
better in the Counter subsystem than IIO.

First I want to correct a minor misunderstanding: the "timestamp"
member of struct counter_event is simply a way to identify Counter
events on the system as a way of grouping multiple Counter watches. In
other words, the "timestamp" member here represents when a Counter event
was detected by the system, not when an event was logged on the counter
device hardware. Instead, hardware timestamps such as the CAPx registers
would be provided by the "value" member of struct counter_event.

Now, I have a few ideas for how we could expose the timestamps using a
Counter device driver, but first I want to make sure I understand
correctly what's happening in this device. If I understand correctly, we
have the following device components:

* CTR: 32-bit counter timer
* Mod4: 2-bit counter
* CAP1-CAP4: four 32-bit registers, each indepedently store a timestamp
* ECAP: input signal providing event trigger edges

Four edge polarities are configured corresponding to each CAPx register,
yet the input signal is still the same single ECAP pin. The event that
is fired is instead determined by the Mod4 counter: when Mod4 is 0 and
the edge of ECAP matches the polarity configured for CAP1 then an event
is triggered which saves the current CTR value to CAP1 and increments
Mod4 to 1, etc.

Is my understanding of how this device behaves correct?

If so, then one possible way to represent this device in the Counter
sysfs tree is something like this:

* CTR: /sys/bus/counter/devices/counterX/count0/count
* Mod4: /sys/bus/counter/devices/counterX/count1/count
* CAP1: /sys/bus/counter/devices/counterX/count1/cap1
* CAP2: /sys/bus/counter/devices/counterX/count1/cap2
* CAP3: /sys/bus/counter/devices/counterX/count1/cap3
* CAP4: /sys/bus/counter/devices/counterX/count1/cap4
* ECAP: /sys/bus/counter/devices/counterX/signal0/signal
* polarity1: /sys/bus/counter/devices/counterX/signal0/cap1_polarity
* polarity2: /sys/bus/counter/devices/counterX/signal0/cap2_polarity
* polarity3: /sys/bus/counter/devices/counterX/signal0/cap3_polarity
* polarity4: /sys/bus/counter/devices/counterX/signal0/cap4_polarity

This is just a tentative arrangement (you could also include "enable"
attributes as well), but it should give you an idea of how it could be
organized.

In your driver, you could then use counter_push_event() whenever you get
an event triggered. In userspace, your application will add Counter
watches for the CAPx registers they want. When an event triggers,
userspace can then received all four CAP register values at the same
time via the respective /dev/counterX character device node.

Would this design work for your needs?

William Breathitt Gray

--wLcvE1FSUtpXsS7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYvBZQgAKCRC1SFbKvhIj
K7+8AP0RAqFa0z7TA+xQGCCPd7QGkXZjANePk6mgACSxm/aTQAEA4/GTSnjLNJE7
FQdnZ5N+3+xTiMjmZuE6p4VoavBaIAU=
=F23d
-----END PGP SIGNATURE-----

--wLcvE1FSUtpXsS7A--
