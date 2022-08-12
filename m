Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534C6590ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiHLKLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbiHLKLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:11:22 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A08BAB1AD;
        Fri, 12 Aug 2022 03:11:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u3so701251lfk.8;
        Fri, 12 Aug 2022 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=aLFMMy8sY7JakSoVwJi7F7tkYJbV0p0vrNiVSXwI33Q=;
        b=g3fQSUdZRhNr/Lh1HQZu8MtvXU5V43uZ3QtsGL/7TNjEpRexPInHyQ/FTUVcyYirYK
         PjZspZUtTwlNNIeoRZzMQry0I4PcRmA4YSqtL5zWHuAejyExLQiBSGJ0ddkoOOKlT8wQ
         1x0Q/8cEiH6ZgrLMaE2A9Ne/Zn82Kj+a2UHJoxHLCvVzCSlHHSoPtMbGbw/S+bB1Di+R
         M3XqxOWErbXyqfzUQ8YaqzAMzM+Ku6dgrnMcHKN9BvWBmbY2wN1LjoRglG3nWers6eMs
         qYoy24HbrClTD2pX2ni9qbfSV9TfbGYaHDJX+YkqWufG5u/3TA2W2f2RgnMJle4wxPCJ
         6i/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=aLFMMy8sY7JakSoVwJi7F7tkYJbV0p0vrNiVSXwI33Q=;
        b=wsuUwTpYBsfV3+KdwLN4oSI7DRxFrUqj7iqijZJeJhMBDpKgJKlD3L9VeOjyosX9a4
         c/B6USBGcDFQJoGLKJvl4pDZ61QxD8ILPNzrGYFM5Dsb6c7lqSFzHFG6UNCk6qBBcsv5
         sVQ+/YpwVO+UjQV8dWSayJX36s67mbmEoyY0L6Yt/jwBITs3AgCHMufSSJaK/Hb8tR/W
         GUc8bqFqQtPyI+PZfCk+VE1gNox1jLAEHVfNS2FdwOBkBXqlNp3oZpVfLkOaa3EaPidb
         GEHr6tArjGf+p121ub3Esum9ukA6ELNZKgU1aaIN/bKJRZPsXliq0mJYUkmbYDbEs5KW
         3sVA==
X-Gm-Message-State: ACgBeo1Um2tW1O7fVdIw33kNYUPx2PjIrdT611ad1cxoukHDtNiYhWFU
        Y/rrQrOrqKFHI1SeTfsaOvsXb7DM9imriA==
X-Google-Smtp-Source: AA6agR7oahz66TXK+4xNXwJ7WBweepHiLx1X956pR6Ll0CKUFsU/T6iafnKR0xdF0fNekUNxKpZZ6A==
X-Received: by 2002:a05:6512:12c5:b0:48c:df54:a41a with SMTP id p5-20020a05651212c500b0048cdf54a41amr987403lfg.464.1660299079802;
        Fri, 12 Aug 2022 03:11:19 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v4-20020a05651203a400b0048b17ecee71sm154675lfp.302.2022.08.12.03.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:11:19 -0700 (PDT)
Date:   Fri, 12 Aug 2022 13:11:16 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] clk: cdce925: simplify using
 devm_regulator_get_enable()
Message-ID: <18255e2d364e19d4a4ba6c6329892a7a77c92ecd.1660292316.git.mazziesaccount@gmail.com>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7YgUNn3cJXMVqVHU"
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


--7YgUNn3cJXMVqVHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify the driver using devm_regulator_get_enable() instead of
open-coding the devm_add_action_or_reset().

A (minor?) functional change is that we don't print an error in case of a
deferred probe. Now we also print the error no matter which of the
involved calls caused the failure.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
RFCv1 =3D> v2:
- No changes
---
 drivers/clk/clk-cdce925.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index ef9a2d44e40c..6350682f7e6d 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -603,28 +603,15 @@ of_clk_cdce925_get(struct of_phandle_args *clkspec, v=
oid *_data)
 	return &data->clk[idx].hw;
 }
=20
-static void cdce925_regulator_disable(void *regulator)
-{
-	regulator_disable(regulator);
-}
-
 static int cdce925_regulator_enable(struct device *dev, const char *name)
 {
-	struct regulator *regulator;
 	int err;
=20
-	regulator =3D devm_regulator_get(dev, name);
-	if (IS_ERR(regulator))
-		return PTR_ERR(regulator);
-
-	err =3D regulator_enable(regulator);
-	if (err) {
-		dev_err(dev, "Failed to enable %s: %d\n", name, err);
-		return err;
-	}
+	err =3D devm_regulator_get_enable(dev, name);
+	if (err)
+		dev_err_probe(dev, err, "Failed to enable %s:\n", name);
=20
-	return devm_add_action_or_reset(dev, cdce925_regulator_disable,
-					regulator);
+	return err;
 }
=20
 /* The CDCE925 uses a funky way to read/write registers. Bulk mode is
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

--7YgUNn3cJXMVqVHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL2J0MACgkQeFA3/03a
ocVv2QgAo/YlNOW1HA2mG+CxYq7xFKcBzQbPKj/51C44Hv7PuOZ9qYKQl2y0ALO2
W9nyE1+wXsUrxSpRSh3RR84zgGGTiTVoZcSwjvgWhsd/DFQRRM+tYwdVCvCxuHK9
eAAEN+/nNjDmsBlWtCP/6+3ET6F5AyOvkqw9MFQK1qS9UxErBIT9PESsvFNcPv9z
fmvywKBtskYFk1KKsVEJcg1Fjj01MsV7IjagPW9O25cXGLtWAoi54Zr7TpnWrMw/
335TVbgmXr0NKguxFMGICeYv8lIsO2fEycNIEazSjI//t4UebsJUK1Ah/RFOwFBA
OZUe74M3LJAT+rE9WV/YV2RYnAYhBA==
=ZUnt
-----END PGP SIGNATURE-----

--7YgUNn3cJXMVqVHU--
