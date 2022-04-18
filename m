Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C1B50603B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiDRXdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiDRXdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:33:16 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 14D57AE43
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:30:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650324635; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: To: To: From: From: Date:
 Sender: Sender; bh=EwsT33pUVnuEsrNDQMK2HIpchqoo7809zU3be87TZK4=; b=YRLaADjCsI5wOXhdDO+Ryo/0C2vIE9GrhQkgWGRvbr2luHoLAZEyEM193rJWgevIhT8D8fzW
 CbxBL5VzzuQxsKa5GPRAHqnxobG2OC+y1Ezu/bSN9RiUnii1vv2b57SV2FsTFtPwWPQK6/06
 0UsprcrIl2EWz+T3kgOOh0ZjgwYvwutgkQ79BrSId8HXu+9ISbE4iz28YBWXSSprJE+8BIxk
 fSlU3797Hxxu721B5SlCGxP1dk7QPbY4BezQs3mca3TgnKkTlYp+mLjOFo21uN3FpDmxdtAa
 cwmhtLi0JqCiVhXKSZnNwOdb+XESEwPYXhRGonoPCOib5SxdGv1uaw==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (186-250-90-1.mhnet.com.br [186.250.90.1]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 625df49877e17d301dfc5d9e (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 18 Apr 2022 23:30:32 GMT
Sender: codeagain@codeagain.dev
Date:   Mon, 18 Apr 2022 20:30:26 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH v3 1/3] staging: vme: Move vme_user to staging KConfig
Message-ID: <f6e6d1d2b02385f11848022f154007ef191181c1.1650321310.git.codeagain@codeagain.dev>
References: <cover.1650321310.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ko7y2xunhwulay2h"
Content-Disposition: inline
In-Reply-To: <cover.1650321310.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ko7y2xunhwulay2h
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

--ko7y2xunhwulay2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYl30kgAKCRAZtd3tyEY2
kqpYAQDVAKKyckdRSKCGBHnP8fVN6mP2Gj0q7nrpyryF38y3fgD+O5vZedtKgOcQ
fzsS2B0wlSgeSjCE5aEAkVsWqKAaKg4=
=i9W+
-----END PGP SIGNATURE-----

--ko7y2xunhwulay2h--
