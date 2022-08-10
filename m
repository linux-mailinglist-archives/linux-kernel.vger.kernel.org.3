Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A5E58EB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiHJL3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiHJL3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:29:40 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765E96F546;
        Wed, 10 Aug 2022 04:29:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d14so20764109lfl.13;
        Wed, 10 Aug 2022 04:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zyQncW0FI88VXCnhEMRRxk76nEkFXEItNVzGssoDpEc=;
        b=pGCX3jZR6L4dwd5GUK5HlMvpSN9kZZFQqmCnJg6p+fjhVdpRx63Kkw27pANqW854YC
         k8+0anm8I6jlPwabkd2ACE+1WF78jotyaCmCnRvg+PxaD8ZttYR66oGMJhnky9DtasRk
         /XJIRgg4LWB54EolltMdv7NJiaJ/Ndabri3jAkOzUadwgCVcTuPnyZ5bfa9ElCAEstLd
         fL6fFNziP67gQagP9gJioSbpK6bc3/mBgANT28Br0A7pjGbNnUnC3TLtCXP0YbmNfdea
         hucNdep3dcVjaGYfmBQfk9LHFDBmrviTBW03/6S+CI1KOoXglzFHzPFHlEYSNMuoQ3Mm
         Q84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zyQncW0FI88VXCnhEMRRxk76nEkFXEItNVzGssoDpEc=;
        b=l8uhfeX/EylbEY8TaypfIZv7iJQA3IzqnEmgg6ORQQpUAP3HHZIWy+cObslN9gNhHQ
         UczjLb3UWySehQFRhImvg/HzHZhqKk78TsH1BAJUdDNLtYQH/Ey+mNCDs4DiFYiH2N6P
         8bDDlghfILKtLkrtN1HUZc/yxh0yZgfyD5K6lyC/aWFwBM3iGJxmNl1rAx10YTqYlk79
         g7C+Yvufcn2SBnRoRe6yydpYcnUfUYLHuu0khnqv6aFATvHNOaQIbXC7sUS9gJXzuvyL
         0kNWL6I5v5kqVCd6xyma4mnfyFuWl8tksNibe1AEKgRkdgkoPZsGnTY5Bj1/dJBeHsiD
         c2Wg==
X-Gm-Message-State: ACgBeo3WMvtLzhlhguuPbkXi75qQ9jsbKi78mtx1zlgtVHd9ApWat+BK
        2c2EHlny8ttOha1h40MyPmg=
X-Google-Smtp-Source: AA6agR7nUCE9WDtimgmPGy6/vwoHYHIQrllNUBcKiuBtxVNqgo/Ek7dorqsX0BPq333hWX32VRfxTw==
X-Received: by 2002:ac2:4e07:0:b0:48a:f6f2:8555 with SMTP id e7-20020ac24e07000000b0048af6f28555mr8913936lfr.200.1660130977716;
        Wed, 10 Aug 2022 04:29:37 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c26-20020ac25f7a000000b0048d2547b3a5sm194525lfc.147.2022.08.10.04.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:29:36 -0700 (PDT)
Date:   Wed, 10 Aug 2022 14:29:15 +0300
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
Subject: [RFC PATCH 1/7] docs: devres: regulator: Add missing devm_*
 functions to devres.rst
Message-ID: <8f8d755d573080144a8b9369d05b71dda2165106.1660127865.git.mazziesaccount@gmail.com>
References: <cover.1660127865.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K/Mcy/68muy1+BEu"
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


--K/Mcy/68muy1+BEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A few managed regulator functions were missing from the API list.

Add missing functions.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
This one is actually a documentation fix which adds existing APIs to the
list. I guess this patch is good for being merged independently from the
rest of the series (which is just an RFC atm).

 Documentation/driver-api/driver-model/devres.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentati=
on/driver-api/driver-model/devres.rst
index 2d39967bafcc..271d1eb2234b 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -406,10 +406,17 @@ PWM
   devm_fwnode_pwm_get()
=20
 REGULATOR
+  devm_regulator_bulk_register_supply_alias()
   devm_regulator_bulk_get()
   devm_regulator_get()
+  devm_regulator_get_exclusive()
+  devm_regulator_get_optional()
+  devm_regulator_irq_helper()
   devm_regulator_put()
   devm_regulator_register()
+  devm_regulator_register_notifier()
+  devm_regulator_register_supply_alias()
+  devm_regulator_unregister_notifier()
=20
 RESET
   devm_reset_control_get()
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

--K/Mcy/68muy1+BEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmLzlooACgkQeFA3/03a
ocXb9Qf/cIT21tEv7nNH0U2HyoG3MYG+kcR9gXgRYDOgwac0KPZv4P8JtusxiRzR
19Pg4Yl1jFLkTPxtP1+ANFakSEd5LeOBDEUNG+LW6Es0KViqCUAG5DyDBmbhiF1C
yrnS1Cellp4nHZ+5GugecKO1524VLPQMlsYOABxggMzG+6wtYb7FL7Le74K+Yx7k
3PcXj2T3unrkyJ+dIscs77KcZfkwKfPbRqgNQdANc4frpyUbMAVCnQio2b83rItE
0OOOInzEMyD7SEAUxr9vV4t+2/yr/wZzaI/byC/NKahfRYYuO9aU+xXnJjMvxlIj
b4QCYUixBYJ9ere6Fu/yawizzZ7DUg==
=Jefo
-----END PGP SIGNATURE-----

--K/Mcy/68muy1+BEu--
