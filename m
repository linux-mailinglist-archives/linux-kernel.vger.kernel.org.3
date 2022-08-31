Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CD55A7F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiHaNyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiHaNyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:54:08 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66273D5DF8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:54:06 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11f34610d4aso13415472fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=2vBWAvtzcXKGd5NJsUMnilyYTDXznzNY/TQmms6+KII=;
        b=cG8cDfsv5QvSBDoZm7Aq+8OqdEafgd5FbXRvkPLcrgDcNertkdRoTP6Q0hUlmXujOr
         aPvggXqOa/uiDVadZ2YbVStPiEwLj9Bt08HSr8n53mZoFwJNAP31iCEjkNQJ8eRGAXTE
         VdTCyDEL3AH6XydKcIiX6scLncoAT8kw6P10kVqDGvrw9wX1TKlvdsH/I0g24S7KWP2b
         iH2D6Svz6iySLqsU/8+4EG+Z4kq27tXc/U3hwh+RQk5KipwA6Z96RYnmsadWWJiox83N
         +p834aGtw7w6RTlRjDG0Ez0ig/7sZ2MGmTXMLgU/dKxmti5jkRBZ8a1k8iY+GspWdu1z
         o2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2vBWAvtzcXKGd5NJsUMnilyYTDXznzNY/TQmms6+KII=;
        b=guQNHX3IkHx16Ldf7UOiWjtNwJyfaWq6cRodIJYxdxEC/SE3+H/OF1OVKWe6+noyiC
         mI8gmEwiusjn93ECtrRvdw5P5l8fwvGfcjrlhAPrcPjMKbDLRFN2l9jTzq52P67Y7LJ5
         /pYkjHP7ujhEztJAI1nIGcns2s08xRGUl/9NNs5TnCTznSmvC6ar9IWJLeckGprYHl+E
         U/+t8GYT0zUgSeGIk1OYpq2nYvBX6XllMX/VVmuex9S9MZ+grI02M4b6TF+0KmLcK7/N
         bxTkJfrsS2HHsFdZhDiuYFyF+HKS1eyK37j7F+bZpQrVvadYxIeS/j+k3qapOt5KDOeu
         It2g==
X-Gm-Message-State: ACgBeo3xny53BA64WXdA1forx9vFiUvX1PSKdwH41teufes2fU1FlW30
        ysHQXgPMno/+hcS+pVGDrw44dA==
X-Google-Smtp-Source: AA6agR67u0SJXAlkLVV4jPdIX8Ho30HQ/23GRLHeMXw1FZCR2gyTrNDPY1QM7k8cecrlIGMT12MOGg==
X-Received: by 2002:a05:6870:538a:b0:11e:58c6:714d with SMTP id h10-20020a056870538a00b0011e58c6714dmr1488818oan.142.1661954045751;
        Wed, 31 Aug 2022 06:54:05 -0700 (PDT)
Received: from ishi ([2600:1700:5668:ac50::42])
        by smtp.gmail.com with ESMTPSA id y5-20020a056830208500b00636fd78dd57sm9112170otq.41.2022.08.31.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 06:54:04 -0700 (PDT)
Date:   Wed, 31 Aug 2022 09:54:02 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/6] isa: Ensure number of irq matches number of base
Message-ID: <Yw9n+m26FhEyxbNs@ishi>
References: <cover.1660839809.git.william.gray@linaro.org>
 <CAMRc=Md5Et-T++mZVw+jXnOWQS23o5hUOATYqs6b+pR1zr57Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dbsQY0s4JHIs9mz+"
Content-Disposition: inline
In-Reply-To: <CAMRc=Md5Et-T++mZVw+jXnOWQS23o5hUOATYqs6b+pR1zr57Yw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dbsQY0s4JHIs9mz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 31, 2022 at 02:35:51PM +0200, Bartosz Golaszewski wrote:
> On Fri, Aug 19, 2022 at 1:11 AM William Breathitt Gray
> <william.gray@linaro.org> wrote:
> >
> > Several ISA drivers support IRQ and call devm_request_irq() in their
> > device probe callbacks. These drivers typically provide an "irq" array
> > module parameter, which matches with the respective "base" array module
> > parameter, to specify what IRQ lines are used for each device. To reduce
> > code repetition, a module_isa_driver_with_irq helper macro is introduced
> > providing a check ensuring that the number of "irq" passed to the module
> > matches with the respective number of "base". The relevant ISA drivers
> > are updated accordingly to utilize the new module_isa_driver_with_irq
> > macro.
> >
> > William Breathitt Gray (6):
> >   isa: Introduce the module_isa_driver_with_irq helper macro
> >   counter: 104-quad-8: Ensure number of irq matches number of base
> >   gpio: 104-dio-48e: Ensure number of irq matches number of base
> >   gpio: 104-idi-48: Ensure number of irq matches number of base
> >   gpio: 104-idio-16: Ensure number of irq matches number of base
> >   gpio: ws16c48: Ensure number of irq matches number of base
> >
> >  drivers/counter/104-quad-8.c    |  5 ++--
> >  drivers/gpio/gpio-104-dio-48e.c |  5 ++--
> >  drivers/gpio/gpio-104-idi-48.c  |  5 ++--
> >  drivers/gpio/gpio-104-idio-16.c |  5 ++--
> >  drivers/gpio/gpio-ws16c48.c     |  5 ++--
> >  include/linux/isa.h             | 52 ++++++++++++++++++++++++++-------
> >  6 files changed, 57 insertions(+), 20 deletions(-)
> >
> >
> > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> > --
> > 2.37.2
> >
>=20
> Looks good to me, do you send your PRs directly to Linus? Do you want
> me to take this through the GPIO tree?
>=20
> Bart

Hi Bart,

Would you take this through the GPIO tree? I'm planning on submitting
some more patches later for these GPIO drivers so it will be convenient
to keep all these changes within the same tree.

Thanks,

William Breathitt Gray

--dbsQY0s4JHIs9mz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYw9n+gAKCRC1SFbKvhIj
Ky/sAP0bK5sxywOxdrhiCVbbRWd8IdE8JOfYoPQ8GWdbLNdK0wD/Rd5xIXwqp2S9
tjuO3ZOdTYHwXsrCo2H40VZtow3aMwc=
=JCzk
-----END PGP SIGNATURE-----

--dbsQY0s4JHIs9mz+--
