Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B629158EB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiHJLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiHJLbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:31:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7439D6DF96;
        Wed, 10 Aug 2022 04:31:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x19so12538260lfq.7;
        Wed, 10 Aug 2022 04:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=orgHsxCL/eDSeRNUzdbN1mK+oxAKvucrAmf97xEKdZ4=;
        b=aQBbvfoxFa5ZcvxCLanORYq1fw6LPa6LJS0OX6FJ0JtBpG5jUfth69xuLBOg1Pb36N
         W/3oXgvSrJxxSowDotXK1W7QR/tQX+wOJ3vc4ZGNP50sdBTohycLImlEEdHbKEBuf6MC
         JDEqLFaQ55xdrfizREF5egPILUc0JxUeBxHGr1fIVbur0jVNRixK97P/J6FvCi3W0bl/
         nVGWZFxHEAsOeqCKKqYc0OzbCU9uunyxjcDwiCxvsWOMqVzjq8xc69l946Q6IWAuQHF9
         xtbIuMg/I1lCvB7wvfHTh1n7CSw6HjBr/3kT7LuX25ZQH0TEdPtlJG17wzbGaE0jSWen
         f/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=orgHsxCL/eDSeRNUzdbN1mK+oxAKvucrAmf97xEKdZ4=;
        b=nAkYku9lWJOk0KuKTmL2DIeq/QAXf9AHLU4gLL83+FgVLHfD26OE6gL25kA1NpQULJ
         ilUQLhyAxvIh1j21BgXostRqF6YGw3IXf3PO/iCcJ7mn5BsSFLRwhLEI4dZakuNNBOfC
         Ymz/LQ21n8aEc5Mp0Wc8kcvNvchcw3utwbVcLcL5P6RebbP7yPtqCiDqKpd9vX43Esnv
         fTnIcIhCXjfTLxG9MM3EHA3FBvQLamTatdOCkIJgoN8VQq8EJUD8s7u3yURTpLVUAS11
         NuD6WZyrCgYnqGB2+Etd1yw1MWgcXvoUQjcX7cJC0Unc2Jafxz55FYKu1hIFMLTmn9CR
         Yr6w==
X-Gm-Message-State: ACgBeo0BEIcXALls2yF3ryx48fM0NFYB0A1EXprdx9iEw9q7MqZqj68h
        CMaBpfDJ+4r+VEzJ+dQOHLCh6M+8xzhwgQ==
X-Google-Smtp-Source: AA6agR7JBR57kzyt+os6biJsAEIfgSQ8d2KfZwIU6MqbBsmV7bTr8/YkqnI+aQiMYBwj/s8+hOWD6g==
X-Received: by 2002:a05:6512:32c5:b0:48b:969a:9c24 with SMTP id f5-20020a05651232c500b0048b969a9c24mr6704678lfg.300.1660131091804;
        Wed, 10 Aug 2022 04:31:31 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f18-20020a19ae12000000b0048b998be041sm300359lfc.309.2022.08.10.04.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:31:30 -0700 (PDT)
Date:   Wed, 10 Aug 2022 14:31:16 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/7] clk: cdce925: simplify using
 devm_regulator_get_enable()
Message-ID: <7daaf2e66cc72d646e88a93e8cca39e104ef6505.1660127865.git.mazziesaccount@gmail.com>
References: <cover.1660127865.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pjh2KveCiReW/EIb"
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


--pjh2KveCiReW/EIb
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

--pjh2KveCiReW/EIb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmLzlwQACgkQeFA3/03a
ocXROAgAmxCDpZZxZ93CGZ6jIwXn4OGmKyfR7a6PjxqD5qL2rGck9VBS1VZPenS7
+C7/Qu9ViKNCG+VU2ftVKQDh/PhHC83+6e7YPJQERS53clNvRZoth/Qntoaer1FA
T3mWCTJyo/UDvWGixLOCtC4dMUXHys9vHKyTOiHXAGFU/rsvWHu0alSrv7ENm3Wr
TzJWewPAYrUbHVGBG8/E3rYVTdQB7tAKYtC8h0ZqFwQwi6hrp4I8Vy1Y3TTdfX7K
HDUFrIGbVEbISD+fLFTlTR8i2BNiUAVGfb+QAZSX6gkLUMGlaxylNKG73ovbvg3X
Y3/dNRzZrKxRMPaGVYCbBKZUOnJ/qQ==
=3blC
-----END PGP SIGNATURE-----

--pjh2KveCiReW/EIb--
