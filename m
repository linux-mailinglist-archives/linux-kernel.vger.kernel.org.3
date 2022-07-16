Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89508576FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 17:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiGPPx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 11:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiGPPx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 11:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015016261;
        Sat, 16 Jul 2022 08:53:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0404661177;
        Sat, 16 Jul 2022 15:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31F5C34114;
        Sat, 16 Jul 2022 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657986831;
        bh=qKwOLqXKlfuxhy0Xj2JK6pTSgZmrElwNz+8WZgNuzn4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lzdz6+rdGZDJjMe/JE8tXoIyR52SOSrq+r5DoJ2QzhlgQPr9eAjYmiMOXOrWYgLRs
         WqEfTmREp8eLnAXuVxyzaQPmomyKmgxZ9bdbrUlBlbcCrvbMXjFNHALUH5OtU1b2un
         As03lE+S3jgXoQ9IZLZhYyEXMWBvB+AlVKoF29Yg5Was9+R9+d9/3n79/8QTdvzsiZ
         n8leYOechUGH7n+ixhbziX1NnBh2Z0/T7nO5hL230jGPgSNc+/PO/9p2kumb9gq/IE
         XuTeqMDll/BKOfFqUhvuCM7S1TqIw2Q+1Ml2CKclfDcwp/kKXuWCf1r0TN5sWRtJzU
         FrhEWHkc/Mddg==
Date:   Sat, 16 Jul 2022 17:03:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <20220716170344.0470eaae@jic23-huawei>
In-Reply-To: <2d8bbc776ef21a90576b6201cd84736f00c67957.camel@gmail.com>
References: <20220625150921.47769-1-ang.iglesiasg@gmail.com>
        <20220625164623.42ed8e1d@jic23-huawei>
        <2d8bbc776ef21a90576b6201cd84736f00c67957.camel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 17:42:49 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On s=C3=A1b, 2022-06-25 at 16:46 +0100, Jonathan Cameron wrote:
> > On Sat, 25 Jun 2022 17:09:12 +0200
> > Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> >  =20
> > > Adds compatibility with the new generation of this sensor, the
> > > BMP380
> > >=20
> > > Included basic sensor initialization to do pressure and temp
> > > measurements and allows tuning oversampling settings for each
> > > channel
> > > The compensation algorithms are adapted from the device datasheet
> > > and
> > > the repository https://github.com/BoschSensortec/BMP3-Sensor-API
> > >=20
> > > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com> =20
> >=20
> > Hi Angel,
> >=20
> > A few comments inline, but mostly looks good to me.

First a process comment.  Cut out anything you agree with.
Too many emails to read so focus on the bits where there are questions
or they will get missed.  Reviewers are happy to assume you agree
with them if you don't say otherwise :)


> >=20
> > Jonathan
...

>=20
> > > +
> > > +#define BMP380_FILTER_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GENMASK(3, 1)
> > > +#define BMP380_FILTER_OFF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > > +#define BMP380_FILTER_1X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(1)
> > > +#define BMP380_FILTER_3X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(2)
> > > +#define BMP380_FILTER_7X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(BIT(2) | BIT(1))
> > > +#define BMP380_FILTER_15X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(3)
> > > +#define BMP380_FILTER_31X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(BIT(3) | BIT(1))
> > > +#define BMP380_FILTER_63X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(BIT(3) | BIT(2))
> > > +#define BMP380_FILTER_127X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(BIT(3) | BIT(2) | BIT(1)) =20
> >=20
> > these are values, 0,1,2,3,4,5,6,7 not a bunch of bits.
> > So use with FIELD_PREP() =20
>=20
> Should I convert the values to a enumeration or simply declare the
> macros with the values? Thanks in advance

Slight preference for defines with the values.

J

