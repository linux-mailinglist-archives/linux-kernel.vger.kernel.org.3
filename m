Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD78E50A38A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389817AbiDUPDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiDUPC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:02:29 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 51C724550D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:59:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650553179; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: To: To: From: From: Date:
 Sender: Sender; bh=2FfySmyUi61V40qd9e4vY+mMpu2WKzNDDsFY/pOvwG8=; b=DSmjlPIcVdLExJVg97Q5KGee/NX7gkkXivuTasF9zAzftf4olyEnnxW7TrOiFrgVqp0JKfgZ
 wpPNSMV7nrse4ygpriYE40mnGTOQy+yoPY9uPYem899BZFlvKha/WHDdFVDvmG20mZYqdcFi
 XaQdseHuZbCNV8itLfIP8NUDAbxVK4S+eqAuFJs3dqETpzBTcv42hLJ9wq8Ip9KWQxhW/sXn
 uKrSP5bxC2fRnYK/0qn7a7A4F9zbgAVRFSclNLV09/LKtAkKNFhxKbOhPzys+2a5QnP9PT+D
 le043xMvPzhtuAyLIKNYlrc4sXfPy1e32oCAmn6Wq0JReIsF9VS8PA==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (dynamic-user.170.84.57.33.mhnet.com.br
 [170.84.57.33]) by smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6261715ab77b16c56e3e69e1 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 21 Apr 2022 14:59:38 GMT
Sender: codeagain@codeagain.dev
Date:   Thu, 21 Apr 2022 11:59:34 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH v4 3/3] staging: vme: Move 'vme/devices/' to 'vme_user/'
Message-ID: <2cd7de9a426c443a5ea618682d605ecfd751d798.1650544175.git.codeagain@codeagain.dev>
References: <cover.1650544175.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ysqdnui3ra2l3lsk"
Content-Disposition: inline
In-Reply-To: <cover.1650544175.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ysqdnui3ra2l3lsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In <db3b9e990e75573402cda22faf933760f076c033> ("Staging: VME: move VME=20
drivers out of staging") the vme code, board and bridge drivers were
moved out of the staging tree, remaining only the VME user device=20
driver.

Since this driver is the only one remaining in staging, such multi-level
structure confuses more than helps. The current structure is as follows:

 - drivers/staging/vme/
                       Makefile
                       devices/
                               Kconfig
                               Makefile
                               vme_user.c
                               vme_user.h

The top-level Makefile has the only function of calling another Makefile
into the devices/ subdirectory. This latter only compiles the vme_user=20
driver, since there is no other in the staging tree.

This patch removes the unnecessary Makefile from the 'vme/' dir, move
the contents of 'vme/devices' into the 'vme/' dir, and renames it to
'vme_user/' (the driver name), allowing a straightforward understanding
of this driver's contents. Furthermore, it updates the MAINTAINERS file
to properly reflect the new paths.

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
---
 MAINTAINERS                                          | 2 +-
 drivers/staging/Kconfig                              | 3 +--
 drivers/staging/Makefile                             | 2 +-
 drivers/staging/vme/Makefile                         | 2 --
 drivers/staging/{vme/devices =3D> vme_user}/Kconfig    | 0
 drivers/staging/{vme/devices =3D> vme_user}/Makefile   | 0
 drivers/staging/{vme/devices =3D> vme_user}/vme_user.c | 0
 drivers/staging/{vme/devices =3D> vme_user}/vme_user.h | 0
 8 files changed, 3 insertions(+), 6 deletions(-)
 delete mode 100644 drivers/staging/vme/Makefile
 rename drivers/staging/{vme/devices =3D> vme_user}/Kconfig (100%)
 rename drivers/staging/{vme/devices =3D> vme_user}/Makefile (100%)
 rename drivers/staging/{vme/devices =3D> vme_user}/vme_user.c (100%)
 rename drivers/staging/{vme/devices =3D> vme_user}/vme_user.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ed62dcd144e..efc38961f792 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21010,7 +21010,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 F:	Documentation/driver-api/vme.rst
-F:	drivers/staging/vme/
+F:	drivers/staging/vme_user/
 F:	drivers/vme/
 F:	include/linux/vme*
=20
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index e4dcf411030d..e117811ec832 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -86,7 +86,6 @@ source "drivers/staging/fieldbus/Kconfig"
=20
 source "drivers/staging/qlge/Kconfig"
=20
-
-source "drivers/staging/vme/devices/Kconfig"
+source "drivers/staging/vme_user/Kconfig"
=20
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 65e317922e3f..db7287de0faf 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_OCTEON_ETHERNET)	+=3D octeon/
 obj-$(CONFIG_OCTEON_USB)	+=3D octeon-usb/
 obj-$(CONFIG_VT6655)		+=3D vt6655/
 obj-$(CONFIG_VT6656)		+=3D vt6656/
-obj-$(CONFIG_VME_BUS)		+=3D vme/
+obj-$(CONFIG_VME_BUS)		+=3D vme_user/
 obj-$(CONFIG_IIO)		+=3D iio/
 obj-$(CONFIG_FB_SM750)		+=3D sm750fb/
 obj-$(CONFIG_USB_EMXX)		+=3D emxx_udc/
diff --git a/drivers/staging/vme/Makefile b/drivers/staging/vme/Makefile
deleted file mode 100644
index cf2f686ccffe..000000000000
--- a/drivers/staging/vme/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-y				+=3D devices/
diff --git a/drivers/staging/vme/devices/Kconfig b/drivers/staging/vme_user=
/Kconfig
similarity index 100%
rename from drivers/staging/vme/devices/Kconfig
rename to drivers/staging/vme_user/Kconfig
diff --git a/drivers/staging/vme/devices/Makefile b/drivers/staging/vme_use=
r/Makefile
similarity index 100%
rename from drivers/staging/vme/devices/Makefile
rename to drivers/staging/vme_user/Makefile
diff --git a/drivers/staging/vme/devices/vme_user.c b/drivers/staging/vme_u=
ser/vme_user.c
similarity index 100%
rename from drivers/staging/vme/devices/vme_user.c
rename to drivers/staging/vme_user/vme_user.c
diff --git a/drivers/staging/vme/devices/vme_user.h b/drivers/staging/vme_u=
ser/vme_user.h
similarity index 100%
rename from drivers/staging/vme/devices/vme_user.h
rename to drivers/staging/vme_user/vme_user.h
--=20
2.35.3
=20

--ysqdnui3ra2l3lsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYmFxVgAKCRAZtd3tyEY2
krlvAQDDn7lzGOuuR0sliolPWkeZtxB1Nst95cgEgmdl85zMYQD9E9OZC1NeH2NY
/pqn13eWXlOs9OWZWrKcf26A/h57QwU=
=JZHj
-----END PGP SIGNATURE-----

--ysqdnui3ra2l3lsk--
