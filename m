Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3BB573490
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiGMKt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiGMKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:49:24 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F88F512D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:49:23 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10bffc214ffso13594445fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0qbtyN99cK4mvvoIfMSBe5OF0ud0j/RvqyS1bVE6mvI=;
        b=sXB+ofZcK/LAavIEMbNzS/RppLU91VekRLLRnUUUcz3hySTTc6+0Cvua8FUkiVxVGg
         CsTVCiHCUD1z4IM42vHJMA1uOkBt6I7mtUS60EAxhXVSoPtEVliIZBvRkuyyvQtCk8hA
         66pq7A7KqdeGi1FN7GT5tm4aikbw5w61zMUS1fiHFrnzCMlQV8Jw//jjkP1lOCFkXbIa
         ROCqeK2HTfqyZsaRk/4Wj5YWXDmdl1HXQFtpuVdPu+2F6c/OHkm0lv85b8gGrIjb2VUo
         RDSDzkk/tL6hnUqnkLS36YykDayz89At8iHg1Y4kpzRCSDJDqidw81a8cVJzvCrMpOn8
         4+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0qbtyN99cK4mvvoIfMSBe5OF0ud0j/RvqyS1bVE6mvI=;
        b=g//h/QoP7tq5PFbvb+CSra1erxZaCT/vsp6fzMt/bvaDb3ScxO2yHmpbONYKeGzSSU
         ldC6lmFpI0+pOTOc+T7mxIemEpnH2tgkZGyhOXwFxUHxirZx8X7IhmJEgSpOk2zuS5TQ
         tIthSN3JaqdVM/h3FTQIhF8nn5eTPNWVxj1lH1uR5Llp4ZLl/LUqLe5lS2kc3oOmZ3zG
         yZCNMOnst4+QC74dZenKIfDmZlIG327oWNOeX6T+DMJvJr9VKYRRsnOwQZhu8AbP58Py
         z7AJ0AYhAW9w2o1TB85wGFUiquPr6KZ1GCDnP5PnoTkcpLHZ3uJt4XjGfq5q4UZjPP7u
         sudA==
X-Gm-Message-State: AJIora8PuP3G/R7v3YEB2mY8qOx9RL+71ZDu2FpGshzNgNwZ6qcps8Up
        Z3LT/hJ2IvlcGy1Ihlg8O/jNTz2Qpve7kg==
X-Google-Smtp-Source: AGRyM1vnYIv2SCtg3vNhrycTOKsBFW2nBeSaxhdLJl9YJXsQI1oTuKI7/YPl9gNCgl5gRtUFw9mYLQ==
X-Received: by 2002:a05:6870:d349:b0:f5:e9ea:5200 with SMTP id h9-20020a056870d34900b000f5e9ea5200mr4350244oag.235.1657709363243;
        Wed, 13 Jul 2022 03:49:23 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id s3-20020a4adb83000000b0035eb4e5a6c8sm4608924oou.30.2022.07.13.03.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 03:49:22 -0700 (PDT)
Date:   Wed, 13 Jul 2022 06:49:20 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: Re: [PATCH v2 1/6] gpio: i8255: Introduce the i8255 module
Message-ID: <Ys6jMPk/6MsFCjv3@fedora>
References: <cover.1657216200.git.william.gray@linaro.org>
 <6be749842a4ad629c8697101f170dc7e425ae082.1657216200.git.william.gray@linaro.org>
 <CACRpkdZn-PV6H+uBcoONt=SThGBAODy-YG=rkx5OX-rcpeE+aw@mail.gmail.com>
 <YszlP1+sBhxvz3Fo@fedora>
 <CAMRc=Mc0=nL_t9Fwmb1uNbsa_v4L4M5BJm2y-vZ8PV47Ryk+Sw@mail.gmail.com>
 <CAHp75Vd5QThEE9S+iL0e3rG+FHoPdts082R4H_beMv990ouGzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="icV+DHR0LXSRpmr9"
Content-Disposition: inline
In-Reply-To: <CAHp75Vd5QThEE9S+iL0e3rG+FHoPdts082R4H_beMv990ouGzQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--icV+DHR0LXSRpmr9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 13, 2022 at 12:10:51PM +0200, Andy Shevchenko wrote:
> On Wed, Jul 13, 2022 at 9:40 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Tue, Jul 12, 2022 at 5:06 AM William Breathitt Gray
> > <william.gray@linaro.org> wrote:
> > > On Mon, Jul 11, 2022 at 03:02:10PM +0200, Linus Walleij wrote:
>=20
> ...
>=20
> > > I think I'll move this to gpio/driver.h as per Andy Shevchenko's
> >
> > I don't think this is what Andy meant. I think he suggested moving
> > this header into drivers/gpio/ because it doesn't make sense for it to
> > be publicly accessible for anyone else than the GPIO drivers.
> >
> > Andy: correct me if I'm wrong.
>=20
> No, you are right. I was talking about localizing the header to drivers/g=
pio.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

Sure, I can move it to drivers/gpio/i8255.h to keep it local to the GPIO
drivers. It'll be trivia to move this out if the need ever arrives in
the future so I have no problem with that.

William Breathitt Gray

--icV+DHR0LXSRpmr9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYs6jMAAKCRC1SFbKvhIj
KwnXAQCJpBVEphHMhfC/JnJ+qSOjVUOzzJKeTHZ6fLTeBbKs+QD/Y2JHqr7hRysr
KB/A0pp9RCId3EJp53kUALdYlbwR0Aw=
=153X
-----END PGP SIGNATURE-----

--icV+DHR0LXSRpmr9--
