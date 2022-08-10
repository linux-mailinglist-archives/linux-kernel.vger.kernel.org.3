Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E80A58EB58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiHJLdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiHJLdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:33:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CA775FED;
        Wed, 10 Aug 2022 04:33:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j3so8613315ljo.0;
        Wed, 10 Aug 2022 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=g2OJvOZZHZIxUC/pgYnk9p8BpXsVB+Oo8nJt9r6IY80=;
        b=NSGsGPyT4xwwMmbAE+M4xP1n8h/WRufFIaybXJLwRWeuynTXVnNFE9ZGER+xYFWZzr
         TX2PM8oTgJ0wo96tXegmpoHDHfmy1/l6BPF2xwjKj/y9gvMJJoxoSHxh82j2WlM1P6nn
         5pCPWAdJ/Oko3EUHWbXtBkz3T5fiblQB4VW3pRt9zzCAHeItc6vh1MJ7m/LCV7RfPoST
         W8c68l23tBQlVRll49YKBbJkjiNgStsDLK9jWKsrfqKZEkcBe/zXUI8rYVB+AUqwZeSo
         i5jlIHxcn1JzYyXq3dwmDYoJ34C7LbSYRLwUgaLe7Yyom5jTN0Z8kJGUjG2H/EqEXnSv
         ukEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=g2OJvOZZHZIxUC/pgYnk9p8BpXsVB+Oo8nJt9r6IY80=;
        b=ezSwY5ok0KBJxiZNdSY3pv6ngMn4gx+OJfOOfatilgzQi7ip7z/2WRXIraXZATH877
         d/tTUAB/BRgFeaVvV44GzX18o2bEgWEvpdCXy7LM3JnEPYWFil5pQ9reu/KzttrrG1ns
         XdWJTCVHBEQoB9iZ5LNXd5Pn4pHmoZ6fUHM29f2u5fqM4JkvXXPZJWRkIUSt+jWTleWY
         X1FlwQmS3b/PXH5nkWARhn4uDL6P/YdKWl5ETpEdrsLifRWMPuo/Rqx+Qr0GYDAw0TT2
         LCizO5Ih/0Mgy1Loa9FhJVe0OMtRKKXDkxD4HOXGDT1jdNDIOxsuqzNiRFnYqUD0n8ML
         qj9A==
X-Gm-Message-State: ACgBeo1sMIdAADUHMEU3ZqNHahel0jbEYpg7DFMX0HhB2ml70c5AMG97
        nRnfQubnEXcB8PRHwen9NIQ=
X-Google-Smtp-Source: AA6agR7ZMOfUoxveidPh6nF5e7B+hqw59U+fxlV00cwI92nJPJOyeF5w8Zat6EbqCptnPKDJiw+0kw==
X-Received: by 2002:a2e:bf01:0:b0:25f:df1a:f39d with SMTP id c1-20020a2ebf01000000b0025fdf1af39dmr4312867ljr.365.1660131183928;
        Wed, 10 Aug 2022 04:33:03 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c6-20020a056512074600b0048b309aeb09sm306204lfs.226.2022.08.10.04.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:33:03 -0700 (PDT)
Date:   Wed, 10 Aug 2022 14:32:49 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/7] adc: ad7192: simplify using
 devm_regulator_get_enable()
Message-ID: <7ca58a7014a2149a3190336247b13e683fdf6e33.1660127865.git.mazziesaccount@gmail.com>
References: <cover.1660127865.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AlIRRVcwMTECGNfK"
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


--AlIRRVcwMTECGNfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
add_action_or_reset(regulator_disable)' and use the
devm_regulator_get_enable_optional(). Also drop the seemingly unused
struct member 'dvdd'.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/adc/ad7192.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d71977be7d22..8a52c0dec3f9 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -177,7 +177,6 @@ struct ad7192_chip_info {
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
-	struct regulator		*dvdd;
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				fclk;
@@ -1015,19 +1014,9 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
=20
-	st->dvdd =3D devm_regulator_get(&spi->dev, "dvdd");
-	if (IS_ERR(st->dvdd))
-		return PTR_ERR(st->dvdd);
-
-	ret =3D regulator_enable(st->dvdd);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified DVdd supply\n");
-		return ret;
-	}
-
-	ret =3D devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->dvdd);
+	ret =3D devm_regulator_get_enable(&spi->dev, "dvdd");
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd su=
pply\n");
=20
 	ret =3D regulator_get_voltage(st->avdd);
 	if (ret < 0) {
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

--AlIRRVcwMTECGNfK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmLzl2EACgkQeFA3/03a
ocWJzggAuNdP+4gZx9YJtU8uytBkhkDgWYzALjcpMwvRUK7cUe2AwcfXRTxrDAFw
Gy8Jf1M77P9kTtErYASrn81QYDcudYUqAITwf9HMFMQKJu6LlytffVyDO45E/mkr
X68cwNVou5IfMU3++b3yCd5sQ3QL816BmS9NTM5MddX9/oBsoZIFaZLIzcYFIkLg
JyBlgMUE6hcNfJAjIuJBMBRwL3+11KLMl4xPCv0Ygxrh5QUrVkeCdAeTGoTPjOrw
953B4+RRtfzdcWM+CfBL97tXscPGquOcZcQFyh6JQD9AOvsghGTFK3Qjool9FTxR
6IAWbNGUgqjPD5nGWy7baDJDQpi+9w==
=4mV1
-----END PGP SIGNATURE-----

--AlIRRVcwMTECGNfK--
