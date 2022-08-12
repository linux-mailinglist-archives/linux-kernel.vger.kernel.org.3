Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B793E590EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbiHLKIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiHLKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:08:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA9CA6C26;
        Fri, 12 Aug 2022 03:08:40 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id j3so518602ljo.0;
        Fri, 12 Aug 2022 03:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=Lmz4Vp5Brwa2cnS1Itqbq4P7WlJbdn5Ij99xtrfTr8M=;
        b=iEyjjw4/6LOvsqXXLJfKSDsKCPFS1lsCd3GFjln5BRbpEVK+IxPLTm7rcyG93QIZk+
         88yi8KH6gvXJDvAT2iJmEEgic6e5xx0q1DKAArQr6IsDtfmi59kqWYa2UGaGfXS3VSaK
         Ue1RRivzkHWRRntJf8Nj3UygycU591g7FvDbXXPISHrJl0pSI+iaxhQbKbKFIDo009Nx
         YRbrQ96bnjJ32m+mQlKOnmdnhn9CdHqdOUXvvoSlLCe1vmnHBmTBp6k2Z+fdg9MFNnzG
         j1uItRCaZ/Xq/eonFgQcwhzRDK2O+3EbVyX7YZw1+qPPUoViEfraU5/ALcyhG2omF8g+
         Zsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=Lmz4Vp5Brwa2cnS1Itqbq4P7WlJbdn5Ij99xtrfTr8M=;
        b=scFRtmceAkTfJuf6YYgppAv7E88MgG3LVamnh2HDuGHT7WUqkCegxkJB9/AQJMs7w6
         SIfDEDhOu3/1RaTCMOw/w3tO7iz6SVqejkVHYKiMdKEf4X9TmyXipx/GmEjsptQp0ri5
         sy+KiclDtLDb0jBe0Mn/SXMZji9H2bLvYnG6/iRtCh4OKY/jitFn79VeTobD78i4/G+m
         hEvDhYe34J9DQ4Fv2XxeGsiWbwJfh+Xr1Y/oxaEciVzxTP9BVhdfUKRgCyUutiQHl1n5
         bPrD05zaXDAf0BgJI6dk+xQ8ogc/Xqgi4fDbDd6TnWID/ccAySA3EDS5TCr9fL5bcrZL
         P/8Q==
X-Gm-Message-State: ACgBeo32DCwA++mQXqQhJNiCkuHp8tyWKX1ROIvBqCKY0hfi/DUbXLS6
        LGffRPxIhc9t8c5i/d1F0f07Ihynbc154w==
X-Google-Smtp-Source: AA6agR48G+sAfnTk456AdMmoWmwqiUxwIqWZm+aCORAI6x+9Wf6EMIhQ9lCGq1KjCDmWMsEc4se5Fg==
X-Received: by 2002:a2e:7311:0:b0:25e:c66f:2be0 with SMTP id o17-20020a2e7311000000b0025ec66f2be0mr908055ljc.100.1660298919064;
        Fri, 12 Aug 2022 03:08:39 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k2-20020ac24562000000b0048a79e3dd6csm165585lfm.26.2022.08.12.03.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:08:38 -0700 (PDT)
Date:   Fri, 12 Aug 2022 13:08:17 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 0/7] Devm helpers for regulator get and enable
Message-ID: <cover.1660292316.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="THWirS5KE0K9xFXH"
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


--THWirS5KE0K9xFXH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Devm helpers for regulator get and enable

First patch in the series is actually just a simple documentation fix
which could be taken in as it is now.

A few* drivers seem to use pattern demonstrated by pseudocode:

- devm_regulator_get()
- regulator_enable()
- devm_add_action_or_reset(regulator_disable())

Introducing devm helpers for this pattern would remove bunch of code from
drivers. Typically following:

- replace 3 calls (devm_regulator_get[_optional](), regulator_enable(),
  devm_add_action_or_reset()) with just one
  (devm_regulator_get_enable[_optional]()).
- drop disable callback.
- remove stored pointer to struct regulator - which can lead to problem
  when an devm action for regulator_disable is used.

I believe this simplifies things by removing some dublicated code.

The suggested managed 'get_enable' APIs do not return the pointer to
regulators for user because any call to regulator_disable()
(or regulator_enable()) may easily lead to regulator enable count imbalance
upon device detach. (Eg, if someone calls regulator_disable() and the
device is then detached before user has re-enabled the regulator). Not
returning the pointer to obtained regulator to caller is a good hint that
the enable/disable should not be manually handled when these APIs are used.

OTOH, not returning the pointer reduces the use-cases by not allowing
the consumers to perform other regulator actions. For example request the
voltages. A few drivers which used the "get, enable,
devm_action_to_disable" did also query the voltages. The API does not suit
needs of such users.

This series reowrks only a few drivers as I am short of time. So, there is
still plenty of fish in the sea for people who like to improve the code
(or count the beans ;]).

Finally - most of the converted drivers have not been tested (other than
compile-tested) due to lack of HW. All reviews and testing is _highly_
appreciated (as always!).

Revision history:

RFCv1 =3D> v2:
	- Add devm_regulator_bulk_get_enable() and
	  devm_regulator_bulk_put()
	- Convert a couple of drivers to use the new
	  devm_regulator_bulk_get_enable().
	- Squash all IIO patches into one.

Patch 1:
	Fix docmentation (devres API list) for regulator APIs
Patch 2:
	The new devm helpers.
Patch 3:
	Add new devm-helper APIs to docs.
Patch 4:
	simplified CLK driver(s)
Patch 5:
	simplified GPU driver(s)
Patch 6:
	simplified hwmon driver(s)
Patch 7:
	simplified IIO driver(s)

---

Matti Vaittinen (7):
  docs: devres: regulator: Add missing devm_* functions to devres.rst
  regulator: Add devm helpers for get and enable
  docs: devres: regulator: Add new get_enable functions to devres.rst
  clk: cdce925: simplify using devm_regulator_get_enable()
  gpu: drm: simplify drivers using devm_regulator_*get_enable*()
  hwmon: lm90: simplify using devm_regulator_get_enable()
  iio: Simplify drivers using devm_regulator_*get_enable()

 .../driver-api/driver-model/devres.rst        |  11 ++
 drivers/clk/clk-cdce925.c                     |  21 +--
 drivers/gpu/drm/bridge/sii902x.c              |  22 +--
 drivers/gpu/drm/meson/meson_dw_hdmi.c         |  23 +--
 drivers/hwmon/lm90.c                          |  21 +--
 drivers/iio/adc/ad7192.c                      |  15 +-
 drivers/iio/dac/ltc2688.c                     |  23 +--
 drivers/iio/gyro/bmg160_core.c                |  24 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   2 -
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  30 +---
 drivers/regulator/devres.c                    | 164 ++++++++++++++++++
 include/linux/regulator/consumer.h            |  27 +++
 12 files changed, 227 insertions(+), 156 deletions(-)

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

--THWirS5KE0K9xFXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL2JpAACgkQeFA3/03a
ocUSNQgAuAnEh7oW1oRPo5wLIiymBTMRDGKLvapsGYq8bT8IiRWVR/NN37Qd9GHU
VgE85GmmR24A+GFaR7q+L+mQWvDaumb+BgzGbPbeXnm5Dveh1vORzNhM6TvAgGCM
VpCgwcMRbSzCGEiYEvHcp5tiZ5Np7fUSmSuLz30BMES+TDdENIMbxGWb4Qa1pG3o
/5DaGsNxfF2H/5tdaH4S8t9MSKBvCXn4BmrIAEjCVRGZj9+2kSMb8cwNnrp9RBES
aePeoFBXuq8yiDwtJZn4vkzSle448d+Sg/VqDI0CFD/DBCa1/TAhQmuUM0f17KSD
wsLBh7G8SRracLoYB+zXLFT7fBaIHg==
=AV00
-----END PGP SIGNATURE-----

--THWirS5KE0K9xFXH--
