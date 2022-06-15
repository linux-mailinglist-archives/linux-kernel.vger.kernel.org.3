Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E7454C850
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347698AbiFOMTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbiFOMTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:19:34 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5801F366A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:19:33 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id l192so6388413qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Igm5tZYG7QF581SklELZumsNm7wuqz0+TVn6nJnUDOs=;
        b=F9P5Nsg3ql3uveTdk+RwkQbygV5xxgm1AKDcwLMc0I+XHHkTXlpTC9GinK6/z8VU++
         F1AQMsImyVYXETPACQTTBFIB06A6R6Yos+1ghiz+39i2T1ZddVMThmCMWLlDkcQg5weP
         DHcvISGY2d4cBB/X6J7AaiyCbj8YZAhDZN/cVGeZub2z/BSMM0eKusMLhO4eNIIGKjTX
         LbgAmKY4Ygbjq2dNwleLnvzBqY30qy0f/vIz8p8V+P1DAaHJ92jaqjirw73vJbsF2eOo
         BLqbTZgSMFuLM4xMMizV3Hsb6qKnc/WcLvkqmrYcN738qneoOTi8fCNZ2KyiGqp2ngCT
         xznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Igm5tZYG7QF581SklELZumsNm7wuqz0+TVn6nJnUDOs=;
        b=NAMmvXfrbIvySrb5M3OvwLzlzTFuspEIcbKijYClRRNnosFd9jBA+R+ZIdwqQFx6dL
         /kgGI1eh/gr4Dp/0cELWrcD5dqW48dtMqX/m5LRSKpTQnfAFNnyaGoB4rYP6iYKi4qIw
         HmzPGNs88uwVoaz5XmxwGVBUjLu83HxKP/VcesXJQptlzZ2EYHTMsGODiPbdoafuUfix
         JnicL1xbIq78yjmrwGGNXzLOpmaTND+clNOCQ7OPC4YIiSZqgzEPb85E7HLuMr+FC4ec
         INpG2rMrgdI2u0m3OH9twQg7EGJDnhXU0L0SXyJ4LaNcIsAiigSLGLd4rYUnUj+jU38y
         xzQA==
X-Gm-Message-State: AOAM531pyvDHfsqkwmdTI8DntdCKKa0hlQQ0xrQllBVsXvOldoZZWGJC
        K+9S9TGR63y01ttlGWRMZDg33Q==
X-Google-Smtp-Source: ABdhPJw7oD+kHgXwTTFZuhVhGiSNBra/UBVEkbc7aO1y49+Iz/0oIdB9I3X+1Yp58ZSvHKtdlclGew==
X-Received: by 2002:a05:620a:1206:b0:6a6:8436:526c with SMTP id u6-20020a05620a120600b006a68436526cmr7792538qkj.669.1655295572449;
        Wed, 15 Jun 2022 05:19:32 -0700 (PDT)
Received: from fedora ([23.82.142.209])
        by smtp.gmail.com with ESMTPSA id e10-20020a05620a014a00b0069fc13ce1f3sm11747021qkn.36.2022.06.15.05.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 05:19:32 -0700 (PDT)
Date:   Wed, 15 Jun 2022 08:19:30 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: stx104: Implement and utilize register
 structures
Message-ID: <YqnOUlE1nEnCC44B@fedora>
References: <cover.1654118389.git.william.gray@linaro.org>
 <a2dca9435f7f1f727c696a1faa0ab9e27927f9f3.1654118389.git.william.gray@linaro.org>
 <CAHp75VepZ8P_cqnN8qJ_Wb=xM0LW3y-a22tv1otDReFSqRDFYA@mail.gmail.com>
 <YqnIygHDSUbV5yws@fedora>
 <CAHp75Vcojz1d8uGcR5CMeSFcBDCxqzDbncU2Mp-LT4iDqw_+Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PZrNp5qxT1PaPDhw"
Content-Disposition: inline
In-Reply-To: <CAHp75Vcojz1d8uGcR5CMeSFcBDCxqzDbncU2Mp-LT4iDqw_+Pw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PZrNp5qxT1PaPDhw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2022 at 02:00:26PM +0200, Andy Shevchenko wrote:
> On Wed, Jun 15, 2022 at 1:55 PM William Breathitt Gray
> <william.gray@linaro.org> wrote:
> > On Wed, Jun 15, 2022 at 11:44:54AM +0200, Andy Shevchenko wrote:
> > > On Mon, Jun 6, 2022 at 4:27 PM William Breathitt Gray
> > > <william.gray@linaro.org> wrote:
> > > >
> > > > Reduce magic numbers and improve code readability by implementing a=
nd
> > > > utilizing named register data structures.
> > >
> > > Can we consider using regmap APIs instead?
>=20
> > The regmap API may be more appropriate here. I'll investigate and see if
> > I can convert this over to it.
>=20
> I just realized that this driver is for the old PC104 (like?) hardware
> that most likely uses IO ports, I don't remember if we have support
> for IO ports in regmap (MMIO -- yes for sure).
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

Hmm, I don't see IO ports mentioned in include/linux/regmap.h, so I
don't think the regmap API directly supports it (maybe someone familiar
with regmap knows). Although we do get a virtual mapping cookie via
ioport_map() in this driver, I don't know if we can pass that to the
regmap functions and have it actually work.

William Breathitt Gray

--PZrNp5qxT1PaPDhw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYqnOUgAKCRC1SFbKvhIj
K+q4AQCyG562pUOu+4/k36DQT2mwPUi0uNM6b5lulZ7bpEhHbQEA4D/hn0cRVqxX
y3z7ArocrkHEyGO13JYRmyMq83dcOAQ=
=Vdgt
-----END PGP SIGNATURE-----

--PZrNp5qxT1PaPDhw--
