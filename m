Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727B1590EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiHLKMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiHLKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:11:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC517E817;
        Fri, 12 Aug 2022 03:11:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d14so679220lfl.13;
        Fri, 12 Aug 2022 03:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dwxBURFo8GfnRI0NoBKurAx1Epv/InunwJ0Fniey2+M=;
        b=isxZWuJD6JPjv4gSweEK+c6jx0jXPontIi3rfRMQZeZLaKnP8Wpj3sQq7uY3+GxipH
         Hh4ereoCyP/uGczAlUx3QBGDFSxPFBgHXTxjCvGylL3jYcJnRzkZ6aAH+PDH5CS+F/Bq
         mgTS84oc373yZtxsn8AKXTWtdS2lHt3X6AWU8E46DdgSYYHvwmVKXtDNAgyyZBJg/9/s
         2HGEmfZlYeToj1K84q1q9CjsEO1WHpWFHYWuRFUbXPwvBB3dWS/noTL/Ik8YW5LxBvfa
         oLMX9s3Fe9EFc5jJYPLphQ8DfjGf5woinm7MBoX7uT6i4lYU2vAgKKsTbXgN2Ka/kufT
         maMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dwxBURFo8GfnRI0NoBKurAx1Epv/InunwJ0Fniey2+M=;
        b=s5AbwTALOFdIBuSB9RRgNUyfbmlq1vqbk5I/NWZSsW8Sm1wt3+HEnAe2kMd5/Q71wY
         Cq5CN7qxymOBOvFYwxeVfgmx62rnSbAhS4ZZOW34ERzAZ2Fvp6Z5oAAYDGYE2M0KVNWL
         k2hmuNjE5menSJB4KalULU2Mx7LAg6ZlkAaOoMfWQDXAX7TpPMknZkUU/o9dVukwdoTV
         ZJ4jMT+u0MJH6FZmnpzglqvbnCNsuOiXVPCuDRWFORZWnN3LppIpGucCAc/xDcuxuiOD
         WSRT7QpdF6Jvp+G2sJkSyj4qLYQtJdJ7N3bvoNdtZaqC8oQMFxkknniPY1QqvoTQ53Hv
         XxSQ==
X-Gm-Message-State: ACgBeo1Icrjh7unT3lKn8FsWSVB+8AdyBO9Q7RcJc7HNGJ71QaAaJ5i2
        i5cCS+mjG15NdzYEIFbfLe8=
X-Google-Smtp-Source: AA6agR4eoBbZjCh+vk3G97u9WdjS4o7HVHcVMu3O5LRnkhbK2DM8Ty4q8UTMBXM32zG5rbvfQD3REw==
X-Received: by 2002:ac2:418a:0:b0:48b:aa2:1d9f with SMTP id z10-20020ac2418a000000b0048b0aa21d9fmr1147227lfh.195.1660299111725;
        Fri, 12 Aug 2022 03:11:51 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b14-20020ac25e8e000000b0048b365176d9sm155517lfq.286.2022.08.12.03.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:11:49 -0700 (PDT)
Date:   Fri, 12 Aug 2022 13:11:46 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] hwmon: lm90: simplify using
 devm_regulator_get_enable()
Message-ID: <8959965542d71bb5ea5a928b539ff804eaa58f42.1660292316.git.mazziesaccount@gmail.com>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MQq/gT6q2s4rf3c5"
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


--MQq/gT6q2s4rf3c5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
add_action_or_reset(regulator_disable)' and use the
devm_regulator_get_enable().

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>

---
RFCv1 =3D> v2:
- No changes
---
 drivers/hwmon/lm90.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 3820f0e61510..2ab561ec367c 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1848,12 +1848,6 @@ static void lm90_remove_pec(void *dev)
 	device_remove_file(dev, &dev_attr_pec);
 }
=20
-static void lm90_regulator_disable(void *regulator)
-{
-	regulator_disable(regulator);
-}
-
-
 static const struct hwmon_ops lm90_ops =3D {
 	.is_visible =3D lm90_is_visible,
 	.read =3D lm90_read,
@@ -1865,24 +1859,13 @@ static int lm90_probe(struct i2c_client *client)
 	struct device *dev =3D &client->dev;
 	struct i2c_adapter *adapter =3D client->adapter;
 	struct hwmon_channel_info *info;
-	struct regulator *regulator;
 	struct device *hwmon_dev;
 	struct lm90_data *data;
 	int err;
=20
-	regulator =3D devm_regulator_get(dev, "vcc");
-	if (IS_ERR(regulator))
-		return PTR_ERR(regulator);
-
-	err =3D regulator_enable(regulator);
-	if (err < 0) {
-		dev_err(dev, "Failed to enable regulator: %d\n", err);
-		return err;
-	}
-
-	err =3D devm_add_action_or_reset(dev, lm90_regulator_disable, regulator);
+	err =3D devm_regulator_get_enable(dev, "vcc");
 	if (err)
-		return err;
+		return dev_err_probe(dev, err, "Failed to enable regulator\n");
=20
 	data =3D devm_kzalloc(dev, sizeof(struct lm90_data), GFP_KERNEL);
 	if (!data)
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

--MQq/gT6q2s4rf3c5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL2J2EACgkQeFA3/03a
ocXWzwgAx00ve0BRtfmRxnMqjlBzkRl0AnPA9SRGeZzAogR0YXxGUzT4Fp/r4E1S
DEnAg886PdzUfTHk5bdQ2FeWzCxLLEFAr8kIVq+AC38dPDGCKQnZO1fx4Sgfqkuz
hE3qxt+hwtMuVFm1kT9yjXdvI6FLzknJe6bRqePqi5cRkJZnsn2bHAJGdmlrC1Vk
FvIdYfkfcAqe1dbJkvGphq+veDqZuYTg/Wim7bLKPcCheGjf59XEMOyL1haYAJwx
odKFuxOemlwTxyP/PruF+uSauWP86JQMyDWuBCCPcwVXH5TmZmnzdwkpTUdc7Cu7
X57ydTmuqsNnMSeO2T4zvyFfHzW9TQ==
=JoAl
-----END PGP SIGNATURE-----

--MQq/gT6q2s4rf3c5--
