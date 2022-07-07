Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB456A8AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiGGQxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiGGQxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:53:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAE559252;
        Thu,  7 Jul 2022 09:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06D3F6244C;
        Thu,  7 Jul 2022 16:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7E8C3411E;
        Thu,  7 Jul 2022 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657212786;
        bh=oeKhu9Proyv+SOwlbKwi9FoGyKNdIXPkHb7LOnZiNeE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lvEUcujjIvCPcMQbsplCbc1Rnnwk5iAOmHFwVZRzfggqKe6/44ptYgU/JBH8Irsnd
         EpvBJXHZ7OxrQFvthDQWiYQDtQYcxY9rz11Qzg9xW5tIl0mrxnWAoEeTWz1thhX+40
         V3CnEcAGHvtN4SJcQEpf3OP0I5I6fPR2BQWXz912Z3UYeRd/zVL7Uu+sO2irn/tWAq
         mjFitbJXq7FwPoM6LqfPDo2GCZKds7oJStVlaMHUQFaSCOLx1+zi4vXa0k4heta/v6
         so6TGqxu4Htgi8/EMyZKWv2Fggnaaeo8dVNvqKBNp9Gf217HY41QZ2Apypd71aCU/m
         v95Ojz+5a7l4w==
Date:   Thu, 7 Jul 2022 18:02:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: Add rtq6056 support
Message-ID: <20220707180248.2f8d1b0f@jic23-huawei>
In-Reply-To: <CADiBU38FbZ87EHn_UDy-rS6V2bGDdLZJOcqNZsS03MzbNaVaKA@mail.gmail.com>
References: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
        <1656469212-12717-3-git-send-email-u0084500@gmail.com>
        <CAHp75Vd2bxFA5PmjEtgAjJfCf9YZENq_fb9b2VHmMmmHdqGJSw@mail.gmail.com>
        <CADiBU384ZwKL_+i1zRL9qfVt-NLo=pnf8zrGna4Sxt+toYZdWg@mail.gmail.com>
        <CADiBU3_sU8bj29x2Qs9y9fM2YDYcKvNBkBuzfpzuCkAjSeTu+Q@mail.gmail.com>
        <CAHp75VeiuJjiPFFh0pEGGH4+UEn0g5902UhAJL93Ho2WvH0_gg@mail.gmail.com>
        <CADiBU38FbZ87EHn_UDy-rS6V2bGDdLZJOcqNZsS03MzbNaVaKA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 09:41:39 +0800
ChiYuan Huang <u0084500@gmail.com> wrote:

> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=B8=85=E6=99=A85:52=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >
> > On Mon, Jul 4, 2022 at 9:27 AM ChiYuan Huang <u0084500@gmail.com> wrote=
: =20
> > > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=884=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:16=E5=AF=AB=E9=81=93=EF=
=BC=9A =20
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B4=
7=E6=9C=881=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:05=E5=AF=AB=E9=
=81=93=EF=BC=9A =20
> > > > > On Wed, Jun 29, 2022 at 4:23 AM cy_huang <u0084500@gmail.com> wro=
te: =20
> >
> > ...
> > =20
> > > > > > +       *val =3D DIV_ROUND_UP(1000000, sample_time); =20
> > > > >
> > > > > USEC_PER_SEC ?
> > > > > =20
> > > > No, sample time is (vshunt convesion time + vbus conversion time) *
> > > > average sample.
> > > > And the sample freq returns the unit by HZ (sample frequency per se=
cond)
> > > > =20
> > > The 'sample time' is unit by micro-second like as you mentioned. =20
> >
> > Ah, then it should be MICRO, so we will get Hz.
> > =20
> > > > > > +       return IIO_VAL_INT;
> > > > > > +} =20
> >
> > ...
> > =20
> > > > > > +       struct {
> > > > > > +               u16 vals[RTQ6056_MAX_CHANNEL];
> > > > > > +               int64_t timestamp;
> > > > > > +       } data __aligned(8); =20
> > > > >
> > > > > Hmm... alignment of this struct will be at least 4 bytes, but
> > > > > shouldn't we rather be sure that the timestamp member is aligned
> > > > > properly? Otherwise this seems fragile and dependent on
> > > > > RTQ6056_MAX_CHANNEL % 4 =3D=3D 0.
> > > > > =20
> > > > Yap, from the 'max channel', it already guarantee this struct will =
be
> > > > aligned at lease 4.
> > > > Actually, It can be removed. =20
> >
> > I think for the safest side it should be given to the timestamp member.=
 No?
> > =20
> Sorry, following your comment, Why to use 'align' for the timestamp membe=
r?
> the data member already guarantee 2 * 4 =3D 8 byte, then timestamp will
> be 8 byte aligned, right?
>=20
> what you mentioned is to put __aligned(8) only for timestamp.
>=20
> I try to put aligned in two ways ( one is only for timestamp, another
> is the whole struct). the result is the same.
> From my thinking, in this case, the struct is already 8 byte aligned
> for timestamp member. don't you think to put 'aligned' is redundant?

On the 8 byte alignment question...  Look up alignment of s64 on x86_32...
It's 4 byte aligned. We had a lot of 'fun' fixing this a few years ago.

So the marking of __aligned(8) for the timestamp does 2 things (and it
takes a fairly close reading of the c spec to check this).

1) Forces alignment of the timestamp. Needed so we can cheaply write
the timestamp
2) Forces alignment of the containing structure.

The combination of these 2 enforces the padding being
consistent across architectures whether or not they align s64 to
4 or 8 bytes.  This last part is the subtle element that
explains why on some architectures you need the __aligned(8) on the
timestamp not the outer structure.

Jonathan




> > --
> > With Best Regards,
> > Andy Shevchenko =20

