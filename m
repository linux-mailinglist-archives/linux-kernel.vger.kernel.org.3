Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04C6590EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbiHLKJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbiHLKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:09:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBD7A8CEB;
        Fri, 12 Aug 2022 03:09:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so721460lfr.2;
        Fri, 12 Aug 2022 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=yuAKn5slzZuEhtPm1LsezhtP3pivs5CCHH3xY7WDuVQ=;
        b=bY3a2ss7fDRzPC2k43zDwqSVkA56ODbouc/Mh4zivAGhRzzZE0J3tJIe4H888Enb+s
         xmSBomn3yZpqHIyyC9R+EPw4jJo7oslGkIosXdGkptn4Bt3U3NkYXbKLWJFSA4AT4z2W
         Xzf/RNoxKtJYgKfOFXAZ8GJ+cRyJWev8k4O+EAd8KpRgtZSoT0xuE/LALlxK81Ozsowv
         uDIlkI9/MmrzBmW0dnsWKiixPMXEdGjuIntvRpM9lIFAM+8IHitt0pVq1lSnmC0yCgvV
         11ZrCffi2v6AibbzxHR5URpXRBWu+uCY2ZaHyFAWgUhTJGEDQlWMh85QCOXX8Zz4MeDY
         /gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yuAKn5slzZuEhtPm1LsezhtP3pivs5CCHH3xY7WDuVQ=;
        b=pg6nk4f3T+1pfKCEgn/TCffJUfwExpqCBK03GVxZn29VuKiQbpjVL6ED1ec1h4VrCP
         Me4ZTDgNVi6MMjy+186f+LYIgCICwONpUNOxpsf9Kpj6Z1p91SvdRQUxm6RA2r+4+nO4
         nSiX0e36IzOO65HwDT8teJ628wX42pdSZH0O09nXAvIKaBflp+WKeMtnyIYaXWwzQoxU
         Ualp/ii9xiY8MNmvIdzEVBEMGkT1p1tgiBIQNrc3b+1qSJmsfRY1C/xDjaEqoRPu2QgW
         QFE3H3T050/cR1UFhqJNNIdLEtdgCRNSbc5H734IqU38kPLXIKfZvwbJoNf6/hC79btb
         0QiA==
X-Gm-Message-State: ACgBeo2ym966XURmOzQ8Je4U22Hz6Kzabcrlfm+twTfKfr5VdDcC5m8W
        hnrgUe/9Ip4FhkWrLINaDqM=
X-Google-Smtp-Source: AA6agR615W7kd9vT2AUcBZx3elPnt+50MwFv4xr43ufV0vRP94aIGxI1HACvs/SH5Oh+6FhoIDBMtQ==
X-Received: by 2002:a05:6512:139d:b0:48d:3e4:6802 with SMTP id p29-20020a056512139d00b0048d03e46802mr983209lfa.424.1660298966644;
        Fri, 12 Aug 2022 03:09:26 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id u10-20020a05651220ca00b0048b0bf9f4bfsm160695lfr.140.2022.08.12.03.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:09:25 -0700 (PDT)
Date:   Fri, 12 Aug 2022 13:09:03 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Peter Rosin <peda@axentia.se>,
        Aswath Govindraju <a-govindraju@ti.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] docs: devres: regulator: Add missing devm_* functions
 to devres.rst
Message-ID: <5efc0c90342b0a0ef3322b8fc1472b84cfc0eb45.1660292316.git.mazziesaccount@gmail.com>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wQt+00N+A/DYJkCw"
Content-Disposition: inline
In-Reply-To: <cover.1660292316.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wQt+00N+A/DYJkCw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A few managed regulator functions were missing from the API list.

Add missing functions.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
RFCv1 =3D> v2:
- No changes

This one is actually a documentation fix which adds existing APIs to the
list. I guess this patch is good for being merged independently from the
rest of the series.
---
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

--wQt+00N+A/DYJkCw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL2Jr8ACgkQeFA3/03a
ocXdkggAhZ5XSYLhVfVt8rPclxoH54IJ1sSVH8uiR1UkwWAR3bfg6ql8HfNaSuR0
frdTUki174UogGNj7mnoA+XGwRq4o+a8TQuzRGCkf/x6dQFPK6ElvxkEBTLFfXPT
UXw1SPfNuq1I5CxaugCDZdnBlI5DampIh5uNwl6bai1VNrArwI0KqUTTWMECXIRS
GDmAYNIgM90IyXnVvlDpk79tBbqCn/ZLow+bVGUX6hI2f4Nloh0Z97WJFwoI2X6/
8tXRb5Rp6T4upFI0G1PgdoToGPkNZej9o/EOlpm1KbS/DKcyxEgU5Uo95GnTwW1P
4w51sAt7IkDjNFC9tBw7h8dVxZiFYw==
=Y1jp
-----END PGP SIGNATURE-----

--wQt+00N+A/DYJkCw--
