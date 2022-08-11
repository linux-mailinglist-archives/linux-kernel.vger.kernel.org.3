Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BDF59058A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiHKRPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiHKROn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:14:43 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0771145E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:58:34 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b2so1201790qkh.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=BtahUn8ztRbdF6bgP7iWCOgaLjKN7omiziYuT9SboMI=;
        b=qhV73eXrR+Eyj+mjJSGZh0NceqY5l0YCeIOIOOn678iEs+ADJfEUdsIznLrlUaboN/
         zXlPEh3qvlYk7/qGobO+lnJ18Tj/GCWHnxexaLfDuVkhG2y2FRH+Enquev9r5tW+h0X8
         G3I5QcnbrH1A7fNePL+jzSL7jsax4QXG4cYFzl1+gft5tqjkJrGU1DFylq/2LO07T6OX
         xibBTzsfi2A3vSG/oc53TpUNHlXENf7mmJjm/DRYbAPGVZEzGK8MkQmkqro13z69lrxo
         Ts4FoWpuy5wBw5YsPSwRWlRMAXmRfs6fnH5vXEE9DQRK4swynyfXgVfvzmdNw5GR0kOd
         +LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=BtahUn8ztRbdF6bgP7iWCOgaLjKN7omiziYuT9SboMI=;
        b=fDb5jcKhURal3GZ2s8I65IzGMOnVJEDzRMohHRY+DCJrWfIhSV8eU2oswFX/PKXtcG
         35uaF+U/h0d1gHmaKBtnPdgW2i2i+l/nxELWa00+7+gwj01u00oC6+YBN2GbgJy+8r4G
         4QJ69m6tdrO/1v8I6jdcU2R4lPfz4EhRPGC0Lz5WCpZ3oMa/p3MuJYJZrJkq1lvRQ4De
         8y9oFyKBSfRsP0iTvG6I1EQr6tLZ7+zuhNoYlVaq6OrM1ZL1kmMMjtRUBhDqCrE1yKCO
         UpfbU4yZad/YC+p1kapbaQh+03kyk9yeC5xXbRM9L1tG59zCXLSnZEy1Pn/Wy4TDT/m2
         Nqqg==
X-Gm-Message-State: ACgBeo1+/wOyIQ8aD5PQ40zs5GMRKDBDg5+DrL8oP/XQouaNg3+e629k
        IlhDXMNmdgr57gOtLsbgM6iduQ==
X-Google-Smtp-Source: AA6agR6H82uoI2xwIb1+Kz1R7unIjtXFvMihttxZVyPC2ke6j9PeGArLg2PeNRG76kgfyNmsPnL39g==
X-Received: by 2002:a05:620a:2606:b0:6b9:a803:aecb with SMTP id z6-20020a05620a260600b006b9a803aecbmr5886354qko.656.1660237114037;
        Thu, 11 Aug 2022 09:58:34 -0700 (PDT)
Received: from fedora ([23.82.142.207])
        by smtp.gmail.com with ESMTPSA id t9-20020ac87609000000b00342fc6a8e25sm1921345qtq.50.2022.08.11.09.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 09:58:32 -0700 (PDT)
Date:   Thu, 11 Aug 2022 12:58:31 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/4] regmap: mmio: Extending to support IO ports
Message-ID: <YvU1Nw4bvr1Ki/Ob@fedora>
References: <20220808203401.35153-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rUUOkd+8RcEzdopk"
Content-Disposition: inline
In-Reply-To: <20220808203401.35153-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rUUOkd+8RcEzdopk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 08, 2022 at 11:33:56PM +0300, Andy Shevchenko wrote:
> Currently regmap MMIO doesn't support IO ports, while being inconsistent
> in used IO accessors. Fix the latter and extend framework with the
> former.
>=20
> Changelog v2:
> - dropped the first two patches (Mark)
> - split the last patch to two (Mark)
>=20
> Andy Shevchenko (4):
>   regmap: mmio: Remove mmio_relaxed member from context
>   regmap: mmio: Get rid of broken 64-bit IO
>   regmap: mmio: Introduce IO accessors that can talk to IO port
>   regmap: mmio: Fix MMIO accessors to avoid talking to IO port
>=20
>  drivers/base/regmap/regmap-mmio.c | 140 +++++++++++++++++++-----------
>  include/linux/regmap.h            |   3 +
>  2 files changed, 91 insertions(+), 52 deletions(-)
>=20
> --=20
> 2.35.1

Thank you for adding this support. These changes should allow me to
update the PC104 drivers to make use of regmap MMIO for device
communication. Here's my ack for this patch series:

Acked-by: William Breathitt Gray <william.gray@linaro.org>

--rUUOkd+8RcEzdopk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYvU1NwAKCRC1SFbKvhIj
K8VPAQDscpMrM6bi+TQUykYqt4iQmWqAI+rPTbbo4r1oKDKfQQD/aMQiJwLTj41F
H1Q1sE5eIcTFD6rvjUMxdeiB3MB5BwA=
=A/+x
-----END PGP SIGNATURE-----

--rUUOkd+8RcEzdopk--
