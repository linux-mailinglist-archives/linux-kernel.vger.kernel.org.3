Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3CE569499
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiGFVkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiGFVkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:40:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639231EAFE;
        Wed,  6 Jul 2022 14:40:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h17so10626460wrx.0;
        Wed, 06 Jul 2022 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dokAGctxNZzCQOXkt9wvJ+CfODgOflyLzQsxMjQPGIQ=;
        b=AR+bpOZyHZUP5vnHYCH9HxmxFRi8XQeVWl2gwRozdniz1cCiaJZbzvlLRERwjuPy94
         K+A1J7Diq+bQ0XPcKMKmGl9oVZOIZ6I1w55a7+/VJ3eFsTHsYELvyImw7tNXL/JZm1nm
         nugrZvhOV+XLpbSaDu6hZs/1Odib+aTjbJ4ZzBDVUTcQqF0VV7SkAbhtIKkC7osZPdck
         wofepqSj+6f0xbJQlG6Rw/sWSeuHEc6+KmOfGo7iaCXAy2tjG8QB5gNchte0EXAa0d7L
         KSz2TmL22xc7bn73HMFApm/NOVH4kp4LrkgKQ9u7uL8nkea3EMJJnzO+c48+CsnWMabL
         Ky6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dokAGctxNZzCQOXkt9wvJ+CfODgOflyLzQsxMjQPGIQ=;
        b=1fUxM0HVpJa0917w05Z+YGL7wQv2sYb/xj2nP/ycTXP5xuxXi4wDWJtGokLvBuJmw6
         RRefW/q514wovfZkmeAwv9labsc0gqicvzHq5+LSNqzNUz1+GV+egRFOaF1dXVM/q6A6
         iy2uHgE7DkCt+uFWcD+ZI1q4buYntaDg2Xo5U/LLVzQPsw4qzNZvXWQeBYjMYjqupANJ
         T0/btBA2zWBT+GgzNKydVlhdvlnYtsBAQ3KkKHTzYcqqRLFU/4ceU1lq9E+GbqjDli5G
         G0gEz405ICaTyijSu3X9yREzc3gLwmIj/vMLJyrFl5uLUBft5QyzEQB2+XVqSWSoFXvQ
         ov/w==
X-Gm-Message-State: AJIora+AXcYnHen0HRxa0NJTFYf1J+IA8a2zkCfpOUHhb/rY048Zx23Y
        9bU7fAhKNAqLtSapx70yakOMAx+t080=
X-Google-Smtp-Source: AGRyM1sQL07LhNlpjPHfY1ErIwMD5Q68uHvxZehgjE9C3xk7IqYZOhPqRd2PO9lVBujZZOF3ZrVU/w==
X-Received: by 2002:adf:e889:0:b0:21d:6510:b750 with SMTP id d9-20020adfe889000000b0021d6510b750mr21503205wrm.498.1657143604838;
        Wed, 06 Jul 2022 14:40:04 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m16-20020adfe950000000b0021d70a871cbsm6042996wrn.32.2022.07.06.14.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:40:03 -0700 (PDT)
Date:   Wed, 6 Jul 2022 23:40:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Dipen Patel <dipenp@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 02/12] docs: tegra194-hte.rst: don't include gpiolib.c
 twice
Message-ID: <YsYBMtHLygtss+9u@orome>
References: <cover.1656759988.git.mchehab@kernel.org>
 <de81b472f552bd651f140f0aa779a29652fffa62.1656759989.git.mchehab@kernel.org>
 <7e536472-60cd-c81f-254e-bab9fda7ed37@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U+NAIL9fGoHopV43"
Content-Disposition: inline
In-Reply-To: <7e536472-60cd-c81f-254e-bab9fda7ed37@nvidia.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U+NAIL9fGoHopV43
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 06, 2022 at 01:48:58PM -0700, Dipen Patel wrote:
> On 7/2/22 4:07 AM, Mauro Carvalho Chehab wrote:
> > All extern functions of drivers/gpio/gpiolib.c are already
> > inside the Kernel documentation, as driver-api/gpio/index.rst
> > already includes it.
> >
> > Placing a kernel-doc here will only cause mess, as the same symbol
> > will be placed on two parts of the document, causing breakages
> > in cross-references.
> >
> > So, instead, add a cross-reference there.
> >
> > This solves those Sphinx 3.1+ warnings:
> >     .../Documentation/driver-api/hte/tegra194-hte:28: ./drivers/gpio/gp=
iolib.c:2464: WARNING: Duplicate C declaration, also defined at driver-api/=
gpio/index:2464.
> >     .../Documentation/driver-api/hte/tegra194-hte:28: ./drivers/gpio/gp=
iolib.c:2493: WARNING: Duplicate C declaration, also defined at driver-api/=
gpio/index:2493.
> >     .../Documentation/driver-api/hte/tegra194-hte.rst:2464: WARNING: Du=
plicate C declaration, also defined at driver-api/gpio/index:2464.
> >     .../Documentation/driver-api/hte/tegra194-hte.rst:2464: WARNING: Du=
plicate C declaration, also defined at driver-api/gpio/index:2464.
> >     .../Documentation/driver-api/hte/tegra194-hte.rst:2464: WARNING: Du=
plicate C declaration, also defined at driver-api/gpio/index:2464.
> >     .../Documentation/driver-api/hte/tegra194-hte.rst:2493: WARNING: Du=
plicate C declaration, also defined at driver-api/gpio/index:2493.
> >     .../Documentation/driver-api/hte/tegra194-hte.rst:2493: WARNING: Du=
plicate C declaration, also defined at driver-api/gpio/index:2493.
> >     .../Documentation/driver-api/hte/tegra194-hte.rst:2493: WARNING: Du=
plicate C declaration, also defined at driver-api/gpio/index:2493.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > ---
> >
> > To avoid mailbombing on a large number of people, only mailing lists we=
re C/C on the cover.
> > See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.=
mchehab@kernel.org/
> >
> >  Documentation/driver-api/hte/tegra194-hte.rst | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentat=
ion/driver-api/hte/tegra194-hte.rst
> > index d29b7fe86f31..f2d617265546 100644
> > --- a/Documentation/driver-api/hte/tegra194-hte.rst
> > +++ b/Documentation/driver-api/hte/tegra194-hte.rst
> > @@ -25,8 +25,7 @@ and userspace consumers. The kernel space consumers c=
an directly talk to HTE
> >  subsystem while userspace consumers timestamp requests go through GPIO=
LIB CDEV
> >  framework to HTE subsystem.
> > =20
> > -.. kernel-doc:: drivers/gpio/gpiolib.c
> > -   :functions: gpiod_enable_hw_timestamp_ns gpiod_disable_hw_timestamp=
_ns
> > +See gpiod_enable_hw_timestamp_ns() and gpiod_disable_hw_timestamp_ns().
> > =20
> >  For userspace consumers, GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE flag must be
> >  specified during IOCTL calls. Refer to ``tools/gpio/gpio-event-mon.c``=
, which
>=20
> Acked-by: Dipen Patel <dipenp@nvidia.com>

Hi Jonathan,

here's another one that applies on top of that earlier patch. Can you
apply this to your tree?

Thanks,
Thierry

--U+NAIL9fGoHopV43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLGATIACgkQ3SOs138+
s6GoTQ/+MuNiUQDvboF/cEnMNnOO1FJN0Iai/Ct8u9j+ggIICgue1IaMQrUapG0q
b3Cdxo0vWzTFhlnBjjYOCH8z7t7xFvjSw9hAOcDYXILlJEOs0D3C9sQPm9AkXxW8
63ROj9bblMTWWEmYRAxNgLuMgtNr7SWCHFUwGs7XRTC9/4Hz1KyjYPQleFmTonCv
a49m7DxNpM4B/Px7P99zTjcyfiZbRx723gVBnPSiEH3sikEmGQlEShx5vjzN/4kK
q9Fed+Ef3dk7IaWjCIRjPXQ1NVV4SxDOWsgeofi0hS4p531Vg7z3MT48CQtRGJgJ
rsc2MiwwvFOg4S49jJPYAQlzrpvnrPOMYSJdwRZd/TrDGqdCmi9e6Pw1iIJERnOD
tmqXc+vkFMWRi8VNwNHi5otCMbzL0a2Z+ZaUsISOHqiIRC08cP+axryqDBec55ZB
B4FqdlJfVtufDY2Nhw65tkdiL4T3wF1e/YsHf9vqSBEUpG0J2zvyOPevpkmAGvJD
4q3ss0Ob8sy6qGGHMUhkCAMW6KinRQZnHYBWWsCXFrmAwqoRj1nq2jMQkoxdXQwl
CDh6r/MPjUh/IsF2zd7E4TQTtqxr1pD6XbIWa0/MnpiWAbXF+MUdhtp0qDlDrCvd
M5LZT8pjVX/j38u8wY7jWBQOzrqNtvawOOeNvNDhmPpmFsu4rag=
=BAQb
-----END PGP SIGNATURE-----

--U+NAIL9fGoHopV43--
