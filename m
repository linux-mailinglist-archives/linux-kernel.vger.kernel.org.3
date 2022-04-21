Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A89A50A386
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353404AbiDUPBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389760AbiDUPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:01:21 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 05290443FA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:58:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650553111; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: To: To: From: From: Date:
 Sender: Sender; bh=U/Vuirm1Cqyi/duus9t1K0iWa5RpNfzC2Qa3t1+CPI0=; b=DVW7nbbfNSi6yIlzzPu30eEnoM7ChbeBZqyI9ULLsDOex7GUGCn1DooHCj5T0Dd42FlO9mOE
 MDGG4BC1hEOGibhmF9MJjwTb8E7z8UGZmYx1/PNSVJVryGo0giMoVXbK/efuBcKS/M5Adl/f
 7TQRfWcEIbisgfV+JFnf69WZZlpOQlHmUayP7zyP8C4aKV7UMdN9cM0i5yrsE7MuKfF5H+ay
 ZHHqNdS1y2gQwJn5qcWOeJ6S28z66j72FMHGPkjUdpAZnbO9X2EittVk6jVN6xB88Z6NO7vf
 E6MpBRatz6I4faHY/3FKqITySJkWxCZRrsjtYBcs0oyI3DIA5dpV0A==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (dynamic-user.170.84.57.33.mhnet.com.br
 [170.84.57.33]) by smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 62617115b77b16c56e3cd5b4 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 21 Apr 2022 14:58:29 GMT
Sender: codeagain@codeagain.dev
Date:   Thu, 21 Apr 2022 11:58:24 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH v4 1/3] staging: vme: Move vme_user to staging KConfig
Message-ID: <f6e6d1d2b02385f11848022f154007ef191181c1.1650544175.git.codeagain@codeagain.dev>
References: <cover.1650544175.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ph7ogsyaq3uoqzth"
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


--ph7ogsyaq3uoqzth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently, the VME_USER driver is in the staging tree Kconfig, unlike
other VME drivers already moved to the main portions of the kernel tree.
Its configuration is, however, nested into the VME_BUS config option,
which might be misleading.

Since the staging tree "[...] is used to hold stand-alone drivers and
filesystem that are not ready to be merged into the main portion of the
Linux kernel tree [...]"(from=20
https://lore.kernel.org/all/20090320172502.GA14647@kroah.com/T/),
staging drivers should appear nested into the Main Menu -> Device
Drivers -> Staging Drivers to make sure the user don't pick it without
being fully aware of its staging status as it could be the case in
Menu -> Device Drivers -> VME bridge support (the current location).

With this change menuconfig users will clearly know this is not a driver
in the main portion of the kernel tree and decide whether to build it or
not with that clearly in mind.

This change goes into the same direction of commit
<4b4cdf3979c32fa3d042d150f49449c74d048553> ("STAGING: Move staging
drivers back to staging-specific menu")

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
---
 drivers/staging/Kconfig | 2 ++
 drivers/vme/Kconfig     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index fc274737053d..e4dcf411030d 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -87,4 +87,6 @@ source "drivers/staging/fieldbus/Kconfig"
 source "drivers/staging/qlge/Kconfig"
=20
=20
+source "drivers/staging/vme/devices/Kconfig"
+
 endif # STAGING
diff --git a/drivers/vme/Kconfig b/drivers/vme/Kconfig
index 936392ca3c8c..c13dd9d2a604 100644
--- a/drivers/vme/Kconfig
+++ b/drivers/vme/Kconfig
@@ -15,6 +15,4 @@ source "drivers/vme/bridges/Kconfig"
=20
 source "drivers/vme/boards/Kconfig"
=20
-source "drivers/staging/vme/devices/Kconfig"
-
 endif # VME
--=20
2.35.3
=20

--ph7ogsyaq3uoqzth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYmFxEAAKCRAZtd3tyEY2
kiYGAQC0UB23/zTeMNGsmstonBCPQn7kvL+I1+TFiNqL10revgEAg3IToC3wNxPY
noWc9tzu42u/MJUsu7ElW7Dx+j3cyQs=
=j63k
-----END PGP SIGNATURE-----

--ph7ogsyaq3uoqzth--
