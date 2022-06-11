Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480FE5474DD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiFKNld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiFKNlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:41:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6FCB2F;
        Sat, 11 Jun 2022 06:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9189BB80B51;
        Sat, 11 Jun 2022 13:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D40C34116;
        Sat, 11 Jun 2022 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654954888;
        bh=3E8V+Y/yWmCjrt9LqOYei7eYzA3X29NTZvx+kCzyhhc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j+r9oQfnFLkuSNzbrMs5l526KP3kWGt9UpJGLoVW+EpWcqvKrMYYz2g10k2vfaSJM
         xmj+wUu5q3JcQySkDowFQymHNnKPzh47thUzkEisYJbQxTwbl5CnqGKjzgDq//tloo
         MvvBFMpC/0cVL29P3Rr33cwYV1q0Z0CF98qahZELKG2ynBGyVu3N7/hf+TTMTjr1Gu
         R1HhuNR0TKe809cxizvLUcH9yVtysywMFqWFjXyBtu6XdI25svw0YTU+SXRUxPtHh5
         t+njqOCJqVqqCv5bxzic+SQLXW7PBaK5NjVJMD0SYSoBX+HCm1bsRphEJDFgJhNpjG
         FdtX2dFiapouA==
Date:   Sat, 11 Jun 2022 14:50:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/49] iio: fix opencoded for_each_set_bit()
Message-ID: <20220611145034.07efd279@jic23-huawei>
In-Reply-To: <20220604164113.2ed4f681@jic23-huawei>
References: <20220210224933.379149-1-yury.norov@gmail.com>
        <20220210224933.379149-5-yury.norov@gmail.com>
        <2d5e9096-e40d-13af-234a-539108df1c50@wanadoo.fr>
        <20220604164113.2ed4f681@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jun 2022 16:41:13 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 11 Feb 2022 18:17:37 +0100
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>=20
> > Le 10/02/2022 =C3=A0 23:48, Yury Norov a =C3=A9crit=C2=A0: =20
> > > iio_simple_dummy_trigger_h() is mostly an opencoded for_each_set_bit(=
).
> > > Using for_each_set_bit() make code much cleaner, and more effective.
> > >=20
> > > Signed-off-by: Yury Norov <yury.norov-Re5JQEeQqe8AvxtiuMwx3w@public.g=
mane.org>
> > > ---
> > >   drivers/iio/dummy/iio_simple_dummy_buffer.c | 48 ++++++++----------=
---
> > >   1 file changed, 19 insertions(+), 29 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/ii=
o/dummy/iio_simple_dummy_buffer.c
> > > index d81c2b2dad82..3bc1b7529e2a 100644
> > > --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> > > +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> > > @@ -45,41 +45,31 @@ static irqreturn_t iio_simple_dummy_trigger_h(int=
 irq, void *p)
> > >   {
> > >   	struct iio_poll_func *pf =3D p;
> > >   	struct iio_dev *indio_dev =3D pf->indio_dev;
> > > +	int i =3D 0, j;
> > >   	u16 *data;
> > >  =20
> > >   	data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> > >   	if (!data)
> > >   		goto done;
> > >  =20
> > > -	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklengt=
h)) {
> > > -		/*
> > > -		 * Three common options here:
> > > -		 * hardware scans: certain combinations of channels make
> > > -		 *   up a fast read.  The capture will consist of all of them.
> > > -		 *   Hence we just call the grab data function and fill the
> > > -		 *   buffer without processing.
> > > -		 * software scans: can be considered to be random access
> > > -		 *   so efficient reading is just a case of minimal bus
> > > -		 *   transactions.
> > > -		 * software culled hardware scans:
> > > -		 *   occasionally a driver may process the nearest hardware
> > > -		 *   scan to avoid storing elements that are not desired. This
> > > -		 *   is the fiddliest option by far.
> > > -		 * Here let's pretend we have random access. And the values are
> > > -		 * in the constant table fakedata.
> > > -		 */
> > > -		int i, j;
> > > -
> > > -		for (i =3D 0, j =3D 0;
> > > -		     i < bitmap_weight(indio_dev->active_scan_mask,
> > > -				       indio_dev->masklength);
> > > -		     i++, j++) {
> > > -			j =3D find_next_bit(indio_dev->active_scan_mask,
> > > -					  indio_dev->masklength, j);
> > > -			/* random access read from the 'device' */
> > > -			data[i] =3D fakedata[j];
> > > -		}
> > > -	}
> > > +	/*
> > > +	 * Three common options here:
> > > +	 * hardware scans: certain combinations of channels make
> > > +	 *   up a fast read.  The capture will consist of all of them.
> > > +	 *   Hence we just call the grab data function and fill the
> > > +	 *   buffer without processing.
> > > +	 * software scans: can be considered to be random access
> > > +	 *   so efficient reading is just a case of minimal bus
> > > +	 *   transactions.
> > > +	 * software culled hardware scans:
> > > +	 *   occasionally a driver may process the nearest hardware
> > > +	 *   scan to avoid storing elements that are not desired. This
> > > +	 *   is the fiddliest option by far.
> > > +	 * Here let's pretend we have random access. And the values are
> > > +	 * in the constant table fakedata.
> > > +	 */   =20
> >=20
> > Nitpicking: you could take advantage of the tab you save to use the ful=
l=20
> > width of the line and save some lines of code. =20
>=20
> Tweaked whilst applying.
>=20
> Sorry this one took so long. I marked it as a patch that I'd revisit if a=
nd
> tidy up if there was no v2 sent, but then managed to forget about it until
> I came to do a clean out of patchwork today.
>=20
> Anyhow, now applied to the togreg branch of iio.git - initially pushed out
> as testing for 0-day to see if we missed anything.

And dropped again during a rebase as a different version has gone upstream
through a pull request to Linus.

Whilst I have no strong opinion on that in general, I am a little grumpy
that a version was merged that was never posted to the mailing lists (that
I can find on lore.kernel.org.)  Sure the changes were minor and easy to ve=
rify
as harmless, but none the less they should have been posted.

Jonathan

>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Just my 2c.
> >=20
> > CJ
> >=20
> >  =20
> > > +	for_each_set_bit(j, indio_dev->active_scan_mask, indio_dev->masklen=
gth)
> > > +		data[i++] =3D fakedata[j];
> > >  =20
> > >   	iio_push_to_buffers_with_timestamp(indio_dev, data,
> > >   					   iio_get_time_ns(indio_dev));   =20
> >  =20
>=20

