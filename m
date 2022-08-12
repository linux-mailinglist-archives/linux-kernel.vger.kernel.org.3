Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C526590ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiHLKLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbiHLKLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:11:08 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C64E9E2FD;
        Fri, 12 Aug 2022 03:11:05 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v10so473992ljh.9;
        Fri, 12 Aug 2022 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=YBESrMui2lJGUDH8gauYExAGcJloTmJ6fo0JKbMJrZE=;
        b=KG66GScxKTWnb2YliYi2xu0dDLLOpEKNiyaeJ3KMwg0eVANR31JFg+AVhTEWoe+RX6
         G77KToWSiXQCBVzf6fhe/qlaY/MpFuT0spXs7ao/4d3R7aI5FAk1F9SlAbCUYJ2EtH8+
         PhYb7F2++TQ4whJ4y82sYJO3aI8bem66o1JARjAOUizdjJObdqBBHiiW5W01ooVWmSNZ
         jAofvWJsV8Pp74xuk94130J80OEQq3LUG4IqP5V/KlAh3VNE/32P/s1oAIfBgnPtwWCM
         V3YOE3X14tBqA1tuZC2WcjVsMLBiodw/hFhVOgB2RjKob9TBLBIZ1mEwsVGK4ESlTVE9
         22pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YBESrMui2lJGUDH8gauYExAGcJloTmJ6fo0JKbMJrZE=;
        b=i89s+e8Q72Zm3XaoDzlqBJvTw/ZRXS3XiiJWt4r4y+yAwST36rAM3grdjiayyb7EnJ
         uF3CljQT0l44xOfMYC7RCr1vT+h9WQlUrcT7XxwR2oWSaKV1g+F1I2HDr9+A8Jt2HRjQ
         y8YLK6Jh0olhkwpPfsnjCLZhZP+qlC3xSyE+BHGiI3DDx0IRr3ilsa61gObXMwOSJupL
         8wwSyLWspbZufjKvIQLVZ7T3EVAVmm2o5kvVuWMQ2QreutpVubzx73e8g/8uDzPkAJKE
         pYo+lzQK0AicGcj/dArGVAJR5wxd6uxkPtsaUakvX7x8F8AcOsQYhYkuPUvqgFcZqPyq
         2Z0w==
X-Gm-Message-State: ACgBeo3ASImcHmmAKn+Oa8XkXTzSCFnGh8iATQ/YUCbI7s8zTq1uzfTZ
        y1IRxAXa9GjNnNNakE2U+aY=
X-Google-Smtp-Source: AA6agR4s+4Zw2E9mA/PvLeRL3I+oRWCY4/wi3HIj6UEgSySlWtPngzYCuCHLkvJZFpx4cdHYb2gTmA==
X-Received: by 2002:a2e:9555:0:b0:260:3dc:12fb with SMTP id t21-20020a2e9555000000b0026003dc12fbmr977569ljh.125.1660299063444;
        Fri, 12 Aug 2022 03:11:03 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id n16-20020a05651203f000b0048b29b24761sm163629lfq.91.2022.08.12.03.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:11:02 -0700 (PDT)
Date:   Fri, 12 Aug 2022 13:10:57 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] docs: devres: regulator: Add new get_enable functions
 to devres.rst
Message-ID: <f166788988b1d47d2064303e53424c6224869821.1660292316.git.mazziesaccount@gmail.com>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aS0Vg+fv2MO10oy3"
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


--aS0Vg+fv2MO10oy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the new devm_regulator_get_enable() and
devm_regulator_get_enable_optional() to devres.rst

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
RFCv1 =3D> v2:
 - Add devm_regulator_bulk_put() and devm_regulator_bulk_get_enable()
---
 Documentation/driver-api/driver-model/devres.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentati=
on/driver-api/driver-model/devres.rst
index 271d1eb2234b..89f87ae613f0 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -408,7 +408,11 @@ PWM
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

--aS0Vg+fv2MO10oy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL2JzEACgkQeFA3/03a
ocV78ggAporlbjPuasQq+tnOPaUEpGa6VzAkxMkmplUJuAgr7D8qW7cyXVlAS9aa
qg1lvRD72jyNddYE/1VYWbQJ7EhToj7uZh5ontYxrLSdol4PUk0nESmz0QVVwktM
9oIXHnz78UrhLyfmD8k1HzOkwyzQcBpOC/LTdu2mQ/Uk5jdZW2dI9T+YIUcMqSLp
V/U7lmLq7T7SLdEKpebXt1RJselxNCJbdEh8isnTK5WY3OWvgSbFDmk6J5XQlRlN
ki6DaC/geB6oGpr4Xa71t8XaMMwhhqVRDFX8mO6KWXr1OWUYw2FHf7ZUEGlI3V+l
qwk9xGsNwdFKaaAw8HI15RQncJy/SA==
=rIMz
-----END PGP SIGNATURE-----

--aS0Vg+fv2MO10oy3--
