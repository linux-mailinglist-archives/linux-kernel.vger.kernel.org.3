Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE7C54B56C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356641AbiFNQH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356586AbiFNQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:07:52 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C071D31216
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:07:51 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id hh4so6401058qtb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QGL6M7nYFKkFOZJW1ooTez5ps5/tex6kEMYFPY/6DWc=;
        b=qVdSMmJB8c7dsSRO08SDxynq3+Gde7IHucaeWgoEJG2+5G9d4MfQ4KQ/HfQRwnV7Hx
         YLBjm0oAOoGySIM8iFODFKHkafHC1t1OxQZjNCzvcY+y0eezP1k9rN1M8MD3XBFgX/mY
         dfP8FgakoODi0F0M0COXe+EQ5Zv1XU0UAXKOkTh07E3fbQklDLBOOE9UzYznSDtuVw51
         lPvCk52F/zsVIyooZXRfdVAWd3oJ1O2IUHdy63KCPPi+GFWDM2gDe/7jeWguuo12NtZy
         8oUGJuHTDX9s8sg2VLWZ+dQmgwBwAG/b1ln09HX2+if4hmg1nz1dvrXBx8ShqzQycwuc
         sTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QGL6M7nYFKkFOZJW1ooTez5ps5/tex6kEMYFPY/6DWc=;
        b=hsVXTDlJGDd8Xdngz3ZxMfyFE28TzxWBl7WyUc9IGosh0oBbKmtJvTX6NauvRo/xGO
         bf2b+k4eo12dFQhlfE+C6g7+E3NwzU8YF7RaBCC/J5ISrqfenXjn2fOXIEekXtveYgNh
         mC8EC+pURYL+/FIPH5zvpMUdRYqPMwX2FyVa5tmYc6c3Wca5PLH28Dto9VfPiOGF+NaW
         KNM6tSCLr9k1DqJpU7BqHlMsUO1bJ2qVekxYPP6tEufIHaR99zDqW0+NE7tELJpWVeNP
         GDN8t+BvJxM+iX9nYI5Hug3NpXZzVAgZzGnSF0LQe14wGperhN/cBmbqpj7/Kt16qp8b
         Qw5A==
X-Gm-Message-State: AOAM532rmuwWOT9MDhnsxzjQG0L4+hk+ynyo6Y+hkgcShELVXe8t64kh
        KG0VWQZJTyj6jlTHprqZjIawiA==
X-Google-Smtp-Source: ABdhPJx0zstN3/LiuQUr+lgF3PKAz8GbdYXd8PQi9kN6BlsT06qTg3EQMk0C8Mb0sJh0s2PQB+ti9Q==
X-Received: by 2002:a05:622a:28d:b0:305:1546:a5c2 with SMTP id z13-20020a05622a028d00b003051546a5c2mr4750753qtw.111.1655222870341;
        Tue, 14 Jun 2022 09:07:50 -0700 (PDT)
Received: from fedora ([23.82.142.207])
        by smtp.gmail.com with ESMTPSA id bk7-20020a05620a1a0700b006a75a8fd54asm9744925qkb.84.2022.06.14.09.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:07:49 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:07:47 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH] counter: 104-quad-8: Implement and utilize register
 structures
Message-ID: <YqiyU46LB7XZw1D8@fedora>
References: <20220601203629.73858-1-william.gray@linaro.org>
 <20220614121302.27a13e4d@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="42JKffhXIMnIXNn/"
Content-Disposition: inline
In-Reply-To: <20220614121302.27a13e4d@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--42JKffhXIMnIXNn/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2022 at 12:13:02PM +0100, Jonathan Cameron wrote:
> On Wed,  1 Jun 2022 16:36:29 -0400
> William Breathitt Gray <william.gray@linaro.org> wrote:
>=20
> > Reduce magic numbers and improve code readability by implementing and
> > utilizing named register data structures.
> >=20
> > Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> In this particular case this does clean up the + 1's scattered through
> the code to access the control registers so I'm more or less convinced
> readability is improved.  The access via an offset from a base is
> a very common pattern though in kernel drivers, so reviewers tend
> to be used to it, hence I'm not sure I'd want to see lots of drivers
> go this way.  Fine here though.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> > ---
> >  drivers/counter/104-quad-8.c | 166 ++++++++++++++++++++---------------
> >  1 file changed, 93 insertions(+), 73 deletions(-)
> >=20
> > diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> > index 43dde9abfdcf..a1ec04313926 100644
> > --- a/drivers/counter/104-quad-8.c
> > +++ b/drivers/counter/104-quad-8.c
> > @@ -33,6 +33,36 @@ MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt li=
ne numbers");
> > =20
> >  #define QUAD8_NUM_COUNTERS 8
> > =20
> > +/**
> > + * struct channel_reg - channel register structure
> > + * @data:	Count data
> > + * @control:	Channel flags and control
> > + */
> > +struct channel_reg {
> > +	u8 data;
> > +	u8 control;
> > +};
> > +
> > +/**
> > + * struct quad8_reg - device register structure
> > + * @channel:		quadrature counter data and control
> > + * @interrupt_status:	channel interrupt status
> > + * @channel_oper:	enable/reset counters and interrupt functions
> > + * @index_interrupt:	enable channel interrupts
> > + * @reserved:		reserved for Factory Use
> > + * @index_input_levels:	index signal logical input level
> > + * @cable_status:	differential encoder cable status
> > + */
> > +struct quad8_reg {
> > +	struct channel_reg channel[QUAD_NUM_COUNTERS];

Oops, this should be QUAD8_NUM_COUNTERS here. I'll submit a v2 with this
typo fixed when I get a chance and then give this patch some more time
for others to test; assuming no other changes, I'll add your
Reviewed-by tag as well.

Thanks,

William Breathitt Gray

--42JKffhXIMnIXNn/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYqiyUwAKCRC1SFbKvhIj
K0VhAP9FAYbWvOMCKmgB0drDoGsDL0pDRKsKvbyfZNFA907m0wEA/I9NkOxK7b9K
6Puo9ZHLts7q49pQt5sVNmN6VizIMwU=
=81SX
-----END PGP SIGNATURE-----

--42JKffhXIMnIXNn/--
