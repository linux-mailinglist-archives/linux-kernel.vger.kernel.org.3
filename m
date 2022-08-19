Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480FC599820
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347414AbiHSIvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345441AbiHSIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:51:19 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A206DAA3E;
        Fri, 19 Aug 2022 01:51:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l19so766746ljg.8;
        Fri, 19 Aug 2022 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=YYb32OgkJ0s/CNydDFv99LO68KFPvhp/aUcVd7yfU0A=;
        b=jbD8r2NhHlY02SxRUOwA3RQpK/gqw7eNTHa83A22RBQ2+gaewbboNWLxd/c4LeEgvI
         J4B+z3TytiOuQMkJYOF6d0adc3kI7CG5fGTzLvAS0Njz8NgcSgbxnH0hLqp0dvBMNCWK
         OXFN1+UxXKOPmUe+DKRTAXrRqRfXDaJxUQcw4jT8IzMnq+IUZnc1P4sl2ReAjCyiNobz
         MF7G4sTirEimFBPQQmgkiWu5NxkEqCUel5wkEc3RVfLO19sEIjUYeof1UUDzxVMVLbTy
         c7dTarxc835+ruifFHDvTwBBalUZADg5/3anDQDuOCxZWv41/yP9n67jE+Ruq+S9RF7V
         WvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=YYb32OgkJ0s/CNydDFv99LO68KFPvhp/aUcVd7yfU0A=;
        b=TIZsIzmbOznuq/sxuCE3Cq7qfahvdDF40ItPQC5tjCHvFBlp4YFnGPI/dwnW85x2kE
         fnszNtCOZcGWrdSimoQrrGb6lvDmQ1/B5ZAYCMn6Rds2BQgEP8TzNpjvRD0wuAeKmaWT
         wyP10zPT5jrbtDsEZthdBwvfHaW3dTxqLcj5ow4DE5f9zY7GeZLO7O9sxC7cnvZylpzv
         MVL3ezLF/f0xjcPHbgQXS+IPpIfNuDxrF63/iFTYoFJGDGgD9bnibt6bbQD9/kpYPAzd
         ESyzNxntHpcfSSfwYQxk2Vhh3afGKsj2Gl45pne0LxaBr+U+tVxvzGq+5z00IeKplxSC
         RiPg==
X-Gm-Message-State: ACgBeo3Zk7dVpRSriZaArM8R27bt2UedGOYD4vlOFEbeh1jfZJ0sSZz/
        6gxXGFVo5Im5uJuOPg5rSQ4=
X-Google-Smtp-Source: AA6agR6bYlcupkF9JZiahcCo3EWFXSEOj21nhZRdfNbLZcZr/mmxykFhieCcfZEBT9nJBANXyBJDYA==
X-Received: by 2002:a2e:844a:0:b0:255:46b9:5e86 with SMTP id u10-20020a2e844a000000b0025546b95e86mr1779635ljh.388.1660899076756;
        Fri, 19 Aug 2022 01:51:16 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x3-20020a056512046300b0047f7722b73csm557234lfd.142.2022.08.19.01.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:51:15 -0700 (PDT)
Date:   Fri, 19 Aug 2022 11:51:07 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: ad7292: Prevent regulator double disable
Message-ID: <Yv9O+9sxU7gAv3vM@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j8siMrN4F96COOfa"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j8siMrN4F96COOfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7292 tries to add an devm_action for disabling a regulator at
device detach using devm_add_action_or_reset(). The
devm_add_action_or_reset() does call the release function should adding
action fail. The driver inspects the value returned by
devm_add_action_or_reset() and manually calls regulator_disable() if
adding the action has failed. This leads to double disable and messes
the enable count for regulator.

Do not manually call disable if devm_add_action_or_reset() fails.

Fixes: 506d2e317a0a ("iio: adc: Add driver support for AD7292")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

The bug was found during browsing the code. I don't have the hardware to
test this so reviewing and testing is highly appreciated.
---
 drivers/iio/adc/ad7292.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index 92c68d467c50..a2f9fda25ff3 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -287,10 +287,8 @@ static int ad7292_probe(struct spi_device *spi)
=20
 		ret =3D devm_add_action_or_reset(&spi->dev,
 					       ad7292_regulator_disable, st);
-		if (ret) {
-			regulator_disable(st->reg);
+		if (ret)
 			return ret;
-		}
=20
 		ret =3D regulator_get_voltage(st->reg);
 		if (ret < 0)
--=20
2.37.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--j8siMrN4F96COOfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/Tu8ACgkQeFA3/03a
ocUO4gf/azvFounl1vyk3T14IF7Feghc/XD57U3YdHlt7xSuxeimG0glII68S28H
x59nP9Vrzr3xMTnAVIxqGLBDDvm1Gt8fCR/3w7fxQzxIZ5jq4XSi4FtBmSsdyev3
kYFgtaK9tO+awvdBry7Kh9o7cCf5IQ+hdku+H7ADInC/jAOXquD7aUHUBOnaLirR
/PS9zV3lIdKKkEPUh3sIcnMkODsKRjwPyWLRkNDDo5kinCbmSG5n0qt34aLyKBAR
bmy7POEi7RMM7LBPmODHc85BFCD0UEEIp3tAdcOozzKp8HpuFyn9ilP8FSW7jo+K
76lm1/T0VOVZ4z35+1M8ipEnXJB1hg==
=wdVz
-----END PGP SIGNATURE-----

--j8siMrN4F96COOfa--
