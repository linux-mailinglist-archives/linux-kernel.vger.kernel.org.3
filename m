Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E138850BD3C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449760AbiDVQjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244740AbiDVQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:39:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED35B5EBF8;
        Fri, 22 Apr 2022 09:36:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k22so11853471wrd.2;
        Fri, 22 Apr 2022 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nzdc/ks+JHPz/IU8irHs9P8Kh9bpN5eH9plIljHG7oQ=;
        b=PqkHrT1qSvZu4ZrgZMD1n0zm8LnfgiSdwGkwmgnd62Np7ngJf0yz90e7zYmo846pQi
         uKuIPqP4QAVVbCaMnh5t9RCHD4UIK/PtT4HInQxSmRoX4K+7AJ+uui5fKqmcUMWbjAKm
         RsuJkodBXUjTTUpdHnRILkO06f7Z+Vubdq0QphYLPf8EkURqgFsBsMD8hemCLdX8Yhs5
         p1OTx29S3O1cAFzL0ugl7epAzIJHYw0XLKVljVn9lNV9pM29G9cMfYZ/swYIwJZtcHLJ
         Ge9J6ZUUzkmMRvJQA75N6tQP31P6YEnP5BkLpGscunZn3S06MRJaHud+S4XBktXa8r2U
         Y73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nzdc/ks+JHPz/IU8irHs9P8Kh9bpN5eH9plIljHG7oQ=;
        b=h1yfzNkhKAr9Lqoq+kdr5yPMwxbDFGTl/3Vr2I4irGVfW2A9vP0vkWmv749+8mcouZ
         WuGej1RvNSqctEr4ieeZMW84m5uDeRtz1JpF3xS1RBo8K7OUBPJB4Eek7/jeqJMvK08u
         PLXeBOfBloRrGlspY7uwdzMpNTNrDU5Rh43EFPcpgUUVg83Hkh9r0+7aLeEkWuWqAnoD
         46i+vG8njdQ2DFOTdj/LU9hfFVhvApSoYsGwW0t+eN8t8cgnAONzCf5SyH35J+aFidEw
         DE/4/ZPzt1iVLjzQEGiWf3CRcwDAfBiUXmHusfa8FSAHC3RaQxk97uFBu+wC2PSANVEt
         S05w==
X-Gm-Message-State: AOAM532Q30Li+nvbeauyATuknq5TdYmvTvSX991WsGwb+qS1QaVbr/Yg
        t+sKItgDkGhAwvfsVVE/X8u1QvF0+r4=
X-Google-Smtp-Source: ABdhPJycfMCExbocK4CTFYnMCJ5AMovSVlBgIBIn2IHWSSU2Fo1wvPrbaHnvSwJVuM//lZkhStUfwg==
X-Received: by 2002:adf:ee92:0:b0:20a:c0a6:3b40 with SMTP id b18-20020adfee92000000b0020ac0a63b40mr4395889wro.535.1650645373419;
        Fri, 22 Apr 2022 09:36:13 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b0038ec7fcb979sm5089374wms.26.2022.04.22.09.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:36:11 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:36:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, hammer.hsieh@sunplus.com
Subject: Re: [PATCH v4 0/2] Add PWM driver for Suplus SP7021 SoC
Message-ID: <YmLZeL6qT7/fqN4Y@orome>
References: <1647945781-10191-1-git-send-email-hammerh0314@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NmoK/FckjoF1x3zn"
Content-Disposition: inline
In-Reply-To: <1647945781-10191-1-git-send-email-hammerh0314@gmail.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NmoK/FckjoF1x3zn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 22, 2022 at 06:42:59PM +0800, Hammer Hsieh wrote:
> This is a patch series for PWM driver for Suplus SP7021 SoC.
>=20
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> many peripherals (ex: UART. I2C, SPI, SDIO, eMMC, USB, SD card and
> etc.) into a single chip. It is designed for industrial control.
>=20
> Refer to:
> https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
> https://tibbo.com/store/plus1.html
>=20
> Refer to (PWM):
> https://sunplus.atlassian.net/wiki/spaces/doc/pages/461144198/12.+Pulse+W=
idth+Modulation+PWM
>=20
> Hammer Hsieh (2):
>   dt-bindings: pwm: Add bindings doc for Sunplus SoC SP7021 PWM Driver
>   pwm: sunplus-pwm: Add Sunplus SoC SP7021 PWM Driver
>=20
>  .../bindings/pwm/sunplus,sp7021-pwm.yaml           |  42 ++++
>  MAINTAINERS                                        |   6 +
>  drivers/pwm/Kconfig                                |  11 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-sunplus.c                          | 232 +++++++++++++++=
++++++
>  5 files changed, 292 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/sunplus,sp7021-=
pwm.yaml
>  create mode 100644 drivers/pwm/pwm-sunplus.c

Applied, thanks.

Thierry

--NmoK/FckjoF1x3zn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi2XgACgkQ3SOs138+
s6HAsBAArLKb72YRhyDWdRms+SssklS4ylXgGyqxWEGrUTdKYdggww0CHEDn+Ysh
Rhg31H2qrigVJRcivqwLcoezFRvxbWmtRIGlTLPU+3fCFHqsePy8CUxSHR07y2li
1a1QVnwo5q56cXnn17wXAm79y8+9wDAEwZYMaeIDcVITRgzj4a5J6vsScdGMGLkM
k+qIcBaszTVJF0gPkZXJih3CHWmOaf8hq3p1Hy/SSWvdLhBd/ycdi979p8B22J9T
kxfPB3v8sdp1cxIXoWjaqDnGrUN/kiZtK36QAMxVuaxd+E5dPPoCDyPcQ8l7IcJg
npEWPX5wkd/8Y7F0mRY9iZafbfcq4v/qN+UbQRLMNheKci2iyCoCFcrR2K1LB70c
mtktNHmvGEgngA4J4cjB2pOGjN9Y85Rg7zL70BRebLUg0sLUcnD7c1hnKQcXwYtO
KRkoA2EKoJzi0j94D1n/9hwgEPKTvUZttCuDd1TbuLCgckbo+3eMo1MHnQ/WV9RO
6NjIa4LdcAInx/C4Hw0q5K1COCi4Nrm7Z6WyNOMUSQIJUKCzt/nxgE3DsizU4HDO
Yffx5MjRx8JuBEh/24u0ynfmNpPNHLTTEVs8wmBd4K/yCgxCjBC/G/ckYnYZT0Tg
E4ejSNSYKnzSpQ4+ckKvSCSp55p/4WnY+6M9M1HAxixgFEiPdYM=
=FEhy
-----END PGP SIGNATURE-----

--NmoK/FckjoF1x3zn--
