Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5095559A662
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350188AbiHSTSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351340AbiHSTRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:17:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC48E113690;
        Fri, 19 Aug 2022 12:17:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v4so5412199ljg.0;
        Fri, 19 Aug 2022 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xzdVVHmtZRriXapACke53/SRuio/InSt3Zk2iFRlPMw=;
        b=dBhWSOZbQ2Xbgy3Ny3xxOzEic/aw28e5m/hS3zofyeosyHrea9yPBaTxXUhMHLt4fG
         P2RZB37ZjWU5/jrM4PW2d+okZJHzW5+s6LtLHbQBNr076jdxKGFD740dZxyV5U2kddoP
         84JNqglnWlYB8cqq7KVpAxOCt6zS7RSw8F++s9UNvWnoXyIC6dcya14amZ6gjaP7RElm
         BJsemeyoww1Lw3V67P9usuOZPe+UW1oiUm+Zg3EkHOj5cPSQux+74UUmQowtshXvVASU
         jVmAae5APdKpcZ/YsYfRreVLMDaufWhzqIYhqwsfMKGzMeoAPpHVCfylZ3Sb84PdXEMl
         y44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xzdVVHmtZRriXapACke53/SRuio/InSt3Zk2iFRlPMw=;
        b=d7jwbwj4g90oYmUfyvK5zcdS47UU7gNtBBTfmvnBITzjVOLqgu7RCjphypAw65G9mK
         vddnB2nfEjHIH9TpylgNJXwKMr83S5UY17xKZabSUXaKk7DDVnA30+5Ln4EWnDaZ/fse
         5bYlcjHZ7H9RR0bwwXQ3OJfpdI2LGmPyfTEJUdOxCy6e2ma5iWHOr6UC8hJ9z2cm2xX6
         I8WFDnwJyp/qgnVEtkpOjawrvkA4Sur2Zx7LrqSGzQ9ktEk+jsipRGC+F3SuVg24nK16
         OrLach3WQc7a9eipbQB8FH9AiPmUimi1V5hLARe1VBbsBUl7sD1Jlnpho33Qxwb7p4Ox
         73vg==
X-Gm-Message-State: ACgBeo08hS7I+KP5wsKSCio40EbkBZCwBNZD1W6D+OW6x50DhN46xc/p
        POuIrsv6Wjc92ZPKVyOOxnk=
X-Google-Smtp-Source: AA6agR7rYcmTwq3ho26bX4GMTccrLp/k1JBUluYXVhLcYgbOFQAcbyqZoWl0rX0e/CH1m3AChRXBAg==
X-Received: by 2002:a2e:b443:0:b0:261:423d:b4e5 with SMTP id o3-20020a2eb443000000b00261423db4e5mr2504597ljm.348.1660936654908;
        Fri, 19 Aug 2022 12:17:34 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id e17-20020ac24e11000000b0048af3c315efsm731659lfr.191.2022.08.19.12.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:17:33 -0700 (PDT)
Date:   Fri, 19 Aug 2022 22:17:28 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/14] docs: devres: regulator: Add new get_enable
 functions to devres.rst
Message-ID: <55efb5a23822b8e1558d560a6ad906eadbc39a17.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BzN6wCs0O/0C90nr"
Content-Disposition: inline
In-Reply-To: <cover.1660934107.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BzN6wCs0O/0C90nr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the new devm_regulator_get_enable() and
devm_regulator_get_enable_optional() to devres.rst

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v2 =3D> v3
No changes

RFCv1 =3D> v2:
 - Add devm_regulator_bulk_put() and devm_regulator_bulk_get_enable()
---
 Documentation/driver-api/driver-model/devres.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentati=
on/driver-api/driver-model/devres.rst
index 882b14089454..f667b33bbda5 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -407,7 +407,11 @@ PWM
 REGULATOR
   devm_regulator_bulk_register_supply_alias()
   devm_regulator_bulk_get()
+  devm_regulator_bulk_get_enable()
+  devm_regulator_bulk_put()
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

--BzN6wCs0O/0C90nr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL/4cgACgkQeFA3/03a
ocWTPAgAwIlKEsWv5usaL75jQOi7ze2HPx06VkzvDIcg0xxu1QpMXOGVdvzfdLXi
sZIb2LttbalDpQDsKirjxeqQpJzac1mp4+yydzj1YQzaOxddlATsLV9g14dXG94r
OOgyzNbaGGKeQDLRJ6N39AyfHzRO1h9NHEQnu1guzMUExqWFN1zXcTpooRBIZGKA
h3mpjGMmGEypTYKeZ/EsXIOAUHyVQ/BfV0aHZNHmP48O4+QoKSS6/KupA8IFwUrd
7sHMZ4FSLMJl6DGJe+acVRBXPzptNipdYwERJEBjKb3Zu+dxd0BWT2EaMRbYNDDf
wDumUgPOiPfPobID5aHiwP5gx+h+NQ==
=VTfq
-----END PGP SIGNATURE-----

--BzN6wCs0O/0C90nr--
