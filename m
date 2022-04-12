Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3434FD479
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376406AbiDLHoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354204AbiDLHRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:17:14 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 725064B852
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:58:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1649746711; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=xpRZFsxytzgneOlsluEhnk6HH0jkgAUHzKO26/lNTYc=; b=Hf8fbU6shRw/5GzEsg4siGkpvS5qED3RnAsyTq+SMio33TKrDfogCJRbgXRsm4IzotFdGMJe
 ZFytFAFwncMwl4C0EMk/iFqu1swVQTRyGZMOzeP6nxbYRRR2f8Vk3igOHbUQnKHcauuiThtX
 gFNkSizsr/UrisgZWox2kwGAQHYTGr1XDWmpDzE8b//Gp/ejtHXrT2NfSE47piFBMwWX7nk6
 PBFonWd75EQqvyB+x+G8SQKjB2AmddyLXqAXcQIJHoht6kQBI99C092MMuIzpcvGZiamln17
 HI7K5K5TJ8yra5ta0gJH/LKbaytdsn6wH2UnYqVUNxeZo66s9ysmbQ==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (186-250-90-1.mhnet.com.br [186.250.90.1]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 625523167a6ca2b683fc51ef (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 12 Apr 2022 06:58:29 GMT
Sender: codeagain@codeagain.dev
Date:   Tue, 12 Apr 2022 03:58:25 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH v2 3/3] staging: vme: "drivers/staging/vme" tree cleanup
Message-ID: <142698e3761c1e7ba8b17cdd9dc077472ef81668.1649721450.git.codeagain@codeagain.dev>
References: <cover.1649721450.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iejrtspvkosvtjkp"
Content-Disposition: inline
In-Reply-To: <cover.1649721450.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iejrtspvkosvtjkp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In <db3b9e990e75> ("Staging: VME: move VME drivers out of staging") the
vme code, board and bridge drivers were moved out of the staging tree,
remaining only the VME user device driver.

Since this driver is the only one remaining in staging, such multi-level
struct confuses more than helps. The current structure is as follows:

- drivers/staging/vme/
                      +Makefile
                      +devices/
                               +Kconfig
                               +Makefile
                               +vme_user.c
                               +vme_user.h

The root Makefile has the only function of calling the other Makefile
into the devices/ subdirectory. This latter only compiles the vme_user
driver, since there is no other.

This patch allows a more straightforward understanding of this driver's
contents by removing the unnecessary Makefile from the 'vme/' subdir,
moving the contents of 'vme/devices' straight into 'vme/', and renaming
'vme/' to 'vme_user' (the driver name). It also adjusts the Kconfig and
the Makefile from drivers/staging to properly reflect the new structure.

CHANGELOG
v2:
- Added this patch to the patchset

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
---
 MAINTAINERS                                          | 2 +-
 drivers/staging/Kconfig                              | 2 +-
 drivers/staging/Makefile                             | 2 +-
 drivers/staging/vme/Makefile                         | 2 --
 drivers/staging/{vme/devices =3D> vme_user}/Kconfig    | 0
 drivers/staging/{vme/devices =3D> vme_user}/Makefile   | 0
 drivers/staging/{vme/devices =3D> vme_user}/vme_user.c | 0
 drivers/staging/{vme/devices =3D> vme_user}/vme_user.h | 0
 8 files changed, 3 insertions(+), 5 deletions(-)
 delete mode 100644 drivers/staging/vme/Makefile
 rename drivers/staging/{vme/devices =3D> vme_user}/Kconfig (100%)
 rename drivers/staging/{vme/devices =3D> vme_user}/Makefile (100%)
 rename drivers/staging/{vme/devices =3D> vme_user}/vme_user.c (100%)
 rename drivers/staging/{vme/devices =3D> vme_user}/vme_user.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..88423218e5e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21014,7 +21014,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 F:	Documentation/driver-api/vme.rst
-F:	drivers/staging/vme/
+F:	drivers/staging/vme_user/
 F:	drivers/vme/
 F:	include/linux/vme*
=20
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 0545850eb2ff..9f11592336f8 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -88,6 +88,6 @@ source "drivers/staging/qlge/Kconfig"
=20
 source "drivers/staging/wfx/Kconfig"
=20
-source "drivers/staging/vme/devices/Kconfig"
+source "drivers/staging/vme_user/Kconfig"
=20
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 3ffb35ccfae2..1dffa02121ee 100644
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
2.35.1


--iejrtspvkosvtjkp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYlUjEQAKCRAZtd3tyEY2
kl8eAP4snnu7VXp+5WvEdegb9U/Z3NohM0xIqXwMgaQE2l2o+AEA6FZFKAx2mukA
Rl951E2lmtYRuXPD2OZSk6mgMUWzGQg=
=sCQP
-----END PGP SIGNATURE-----

--iejrtspvkosvtjkp--
