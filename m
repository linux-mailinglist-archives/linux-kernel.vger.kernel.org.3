Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6161558EB48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiHJLb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiHJLaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:30:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4AF75FE5;
        Wed, 10 Aug 2022 04:30:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t1so20814336lft.8;
        Wed, 10 Aug 2022 04:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=eB7oLoCQF6payCuc5mHfMzJURoGI/V0Crtv4U4P2dAI=;
        b=jw+YMrEl/xDtcCkzbVNModdhkasctgvd4R8F/uvn33TCxkX+hwPGiENWLDDcWV7kAG
         cYkRt5HOJZdUkwEUjkNv6WJo5l171joS98ni5erRsormwBzF7FGYkRbxDuZ79NR8uxAi
         RuSd2LBFGE1qOW5SE65EpMVyY8jNTglYfR2hgI44ZVPBecA7V94u/Cky8Pk1zW5j4q7V
         0z7qLiUDEdGjmmHZj8dn73AwZA0m42JrmNjefT/i26Zgk5VldmU8thpLAgYR4nFZmXvo
         JdO4lmGwnrd3jqpxwNledgLr8aVcafZ/5z46W2+UBYsL6hR/0s2hYSZxsuC4BCkkZxIK
         s5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=eB7oLoCQF6payCuc5mHfMzJURoGI/V0Crtv4U4P2dAI=;
        b=rj163t9H1qByHt1ZosoVRDT3vA9USIVV+LIyDSK9FXdK89vTg8m4i9DScMZ9++rJ9o
         TQKnyo2Y6nnbiY5fuCb8uA2NTsmt5gk3LnUS6K8i3vV0Yzf0Z9f7DacyhRxJjjboNKQq
         FBiAkX5xLZhqt/SNc/7kGtXAcOPAf4FEDI5kp0m4/jmB9hHq8RBSxdxkPI+DkgCOvN1m
         ZWWRvlNjQAzLRLFZX10rT79nHKQ5FoR7aPyEZ3uwJaWUezIQf+R+CU1E/Uufzv3kGNBZ
         TZHeQRJPPpp2thTLxJ23oLK3YvxWhvnKBXo/q2DevCPk/WVTfh359Tt/WLoR7CH+UkhA
         Zs9Q==
X-Gm-Message-State: ACgBeo3uH+AQGge83gb58vyqCkfVi1i42m3C3UdQNC9rQUw2w4ZhzOrS
        8mS1ZATritlg/bwSJOR28Ew=
X-Google-Smtp-Source: AA6agR7b7RztjkrU1SD51bchus+hJlyMSsls6cXl5Pq+GNFYFU/CdxrG1O0ZZCdJRM+AX+zvDwB9dg==
X-Received: by 2002:ac2:4c4c:0:b0:48b:9780:2b3 with SMTP id o12-20020ac24c4c000000b0048b978002b3mr6500559lfk.682.1660131052543;
        Wed, 10 Aug 2022 04:30:52 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d23-20020a056512369700b00489c6c76385sm304917lfs.268.2022.08.10.04.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:30:51 -0700 (PDT)
Date:   Wed, 10 Aug 2022 14:30:36 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/7] docs: devres: regulator: Add new get_enable
 functions to devres.rst
Message-ID: <1f935c9ef14fd95663646c1dfd22483ac4b71fe1.1660127865.git.mazziesaccount@gmail.com>
References: <cover.1660127865.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b5brqWRO9x+JmUFp"
Content-Disposition: inline
In-Reply-To: <cover.1660127865.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5brqWRO9x+JmUFp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the new devm_regulator_get_enable() and
devm_regulator_get_enable_optional() to devres.rst

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 Documentation/driver-api/driver-model/devres.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentati=
on/driver-api/driver-model/devres.rst
index 271d1eb2234b..6ee8e9ab2478 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -409,6 +409,8 @@ REGULATOR
   devm_regulator_bulk_register_supply_alias()
   devm_regulator_bulk_get()
   devm_regulator_get()
+  devm_regulator_get_enable()
+  devm_regulator_get_enable_optional()
   devm_regulator_get_exclusive()
   devm_regulator_get_optional()
   devm_regulator_irq_helper()
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

--b5brqWRO9x+JmUFp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmLzltwACgkQeFA3/03a
ocWthwf/TFG58eWrBlE6Yb6BqzMfdJ4vdfY2vsp69hWKvC4iqjeJHjYDdpBisdwR
OB4kNTr1sTHZYV5ZB30kHHdFvrIfsd+6btFKzcBa1CjgLZ3h9AJ0rRsXuaxhaTDV
B/mz2U0vKaFPzuzS4HizIOGl73dvA7aoiKhdNIZeqgg5j5lWJwjUbtvUwMgIO1VB
4qFNTpdD23pxN8t1E/YHdh42nAFDG55p+IocqmMKn08FkSMbLu0BhHF/HUxoyh7U
gZuFwijAM25W0KmUgOBHIOQfx+zngVyT+kQf2IjGzRvqPBPHBjyFSvkeVbIel8n5
cODNmCZorwBXEhGlHyUAtl3wVQZxHw==
=eIgl
-----END PGP SIGNATURE-----

--b5brqWRO9x+JmUFp--
