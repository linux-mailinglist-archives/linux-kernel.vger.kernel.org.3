Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9643C591FF7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiHNOAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHNOAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:00:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E175F208;
        Sun, 14 Aug 2022 07:00:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D5BA0CE0B5B;
        Sun, 14 Aug 2022 14:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48707C433D6;
        Sun, 14 Aug 2022 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660485638;
        bh=5quOdUdxhAZcn4wmKsavNkuPZIcet95JzlPQ7tPtJRs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oGic86wOTXYJZDlRz4Dx+RZnbPvprjBU0wWZ2ciiTlzDpylVYR21gOr2FbjpVLDpm
         Z76cecFo4kB3r6zVBjsa26serkVeFQDKx571BWRm05yY6nPWyVtynB0MpalOmd4gJP
         LoKN7c+BgIxItJF93WSTHvTCVEnTJAI1NNKq5sLFyLGEaH0ZKBxePq6FB6sabryEb+
         pJNCv6u5Ji4JthrdZs6LnWTra8VYMIabPczU1vPqvaxqBprgeMR5G8ncCXiKwoW2lr
         EhO817tD2ZwTdQn56/uLnD4jd7nCKEGNcqzlr4H2/Cw3Y8AEJr6YnAzc1CrEqG1ban
         rf6S70fulfPhA==
Date:   Sun, 14 Aug 2022 15:11:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <20220814151105.0fabff05@jic23-huawei>
In-Reply-To: <61774fbafd3ce64a93d94202a77d242e8001778a.camel@gmail.com>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
        <462251c4bca30b53f06307043ad52d859eb8d5c1.1659872590.git.ang.iglesiasg@gmail.com>
        <CAHp75VexAQ5BQEyoAJq9r8uY1MussTy12bUyLd5z6GtJSbf0NQ@mail.gmail.com>
        <61774fbafd3ce64a93d94202a77d242e8001778a.camel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022 12:47:20 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On lun, 2022-08-08 at 11:08 +0200, Andy Shevchenko wrote:
> > On Sun, Aug 7, 2022 at 1:56 PM Angel Iglesias <ang.iglesiasg@gmail.com>=
 wrote: =20
> > >=20
> > > Adds compatibility with the new generation of this sensor, the BMP380
> > >=20
> > > Includes basic sensor initialization to do pressure and temp
> > > measurements and allows tuning oversampling settings for each channel.
> > >=20
> > > The compensation algorithms are adapted from the device datasheet and
> > > the repository https://github.com/BoschSensortec/BMP3-Sensor-API =20
> >=20
> > Missed period.
> >=20
> > ...
> >  =20
> > > =C2=A0 *
> > > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BM=
P180-DS000-121.pdf
> > > =C2=A0 *
> > > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BM=
P280-DS001-12.pdf
> > > =C2=A0 *
> > > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BM=
E280_DS001-11.pdf =20
> >=20
> > Seems like the above links are unresponsive now? Perhaps you may fix
> > them as well in a separate patch? =20
>=20
> Sure. Should I include this patch in this next version of this series, or=
 should
> I send the patch as a standalone change?

Either way is fine. Thanks for tidying this up!

>=20
> > > + *
> > > https://www.bosch-sensortec.com/media/boschsensortec/downloads/datash=
eets/bst-bmp388-ds001.pdf =20
> >=20
> > ...
> >  =20
> > > +/* See datasheet Section 3.11.1. */ =20
> >=20
> > Again, a bit of consistency in (one-line) comments, please.
> >  =20
> > > +struct bmp380_calib {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 T1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 T2;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s8=C2=A0 T3;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s16 P1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s16 P2;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s8=C2=A0 P3;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s8=C2=A0 P4;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 P5;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 P6;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s8=C2=A0 P7;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s8=C2=A0 P8;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s16 P9;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s8=C2=A0 P10;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s8=C2=A0 P11;
> > > +}; =20
> >=20
> > __packed ?
Nope - the unpacking is done on filling this array.

Could reorder to reduce size a little but given the naming vs datasheet
that would look very odd. I'd leave this as it is.


> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Compensated pressure is in c=
Pa (centipascals) */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D 100000; =20
> >=20
> > Anything to use from units.h?

Not sure we want to add centi to killo conversion!
That combination is rather rare.

Jonathan
