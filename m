Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D9E488EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 03:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbiAJCon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 21:44:43 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:44253 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbiAJCoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 21:44:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JXJ7k6BqJz4xQp;
        Mon, 10 Jan 2022 13:44:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641782675;
        bh=X9gEiAgzNEMkBxdg3FPLWb38MZXFN7WEk+znYiiyWQE=;
        h=Date:From:To:Cc:Subject:From;
        b=uQoa2BqhvKG8OFF9pMYwCWYkCpBn5eUSxYdcY9jPSurb+KIjw875a2tpGgct7olia
         IVZeVPbxr3l5uKgdd9MKRZBrEw3WaYIYXi5LPars0sll5CeV4kOo+bQCFYsLJX3J2n
         ZXmKoR6XeETfB280HUg2cmIErUli5xs1zT1Loq8L4+vSrSK+R70q7Yi3B8ZCPY9tYY
         4HbSDy3w+bgRB2FMHqVFCR+6MxyHBcgUNqavyGknQAOjSvahK7sml2ZbWtIYZrQG/Q
         k/dSEvqD/EBNOC8su1KKvyR5dyqzhf0RM8oS2LMuYYipU+mRY/HSmgbXJzlXYA2VkO
         kOuGnuJ9rok6g==
Date:   Mon, 10 Jan 2022 13:44:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Ed Brindley <kernel@maidavale.org>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drivers-x86 tree with the
 hwmon-staging tree
Message-ID: <20220110134434.675f608f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8z7SpmqSvj.DMk0NhBXkQgO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8z7SpmqSvj.DMk0NhBXkQgO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  MAINTAINERS

between commits:

  548820e21ce1 ("hwmon: (asus_wmi_sensors) Support X370 Asus WMI.")
  b87611d43757 ("hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.")

from the hwmon-staging tree and commit:

  0a6509b0926d ("platform/x86: Add Asus TF103C dock driver")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 41c43425f7f9,1dd2cbff0c6b..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -3017,20 -2988,13 +3017,27 @@@ W:	http://acpi4asus.sf.ne
  F:	drivers/platform/x86/asus*.c
  F:	drivers/platform/x86/eeepc*.c
 =20
+ ASUS TF103C DOCK DRIVER
+ M:	Hans de Goede <hdegoede@redhat.com>
+ L:	platform-driver-x86@vger.kernel.org
+ S:	Maintained
+ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drive=
rs-x86.git
+ F:	drivers/platform/x86/asus-tf103c-dock.c
+=20
 +ASUS WMI HARDWARE MONITOR DRIVER
 +M:	Ed Brindley <kernel@maidavale.org>
 +M:	Denis Pauk <pauk.denis@gmail.com>
 +L:	linux-hwmon@vger.kernel.org
 +S:	Maintained
 +F:	drivers/hwmon/asus_wmi_sensors.c
 +
 +ASUS WMI EC HARDWARE MONITOR DRIVER
 +M:	Eugene Shalygin <eugene.shalygin@gmail.com>
 +M:	Denis Pauk <pauk.denis@gmail.com>
 +L:	linux-hwmon@vger.kernel.org
 +S:	Maintained
 +F:	drivers/hwmon/asus_wmi_ec_sensors.c
 +
  ASUS WIRELESS RADIO CONTROL DRIVER
  M:	Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.com>
  L:	platform-driver-x86@vger.kernel.org

--Sig_/8z7SpmqSvj.DMk0NhBXkQgO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHbnZIACgkQAVBC80lX
0GxbxAf+PbO5RaLbpnZcPai4hNEF5GuBF9E9umNItHOtQPfWAzNIVersmnIV+hjX
qvutukFid5VcE1jjiEOAq5jmdKKp7jhW4B4yy9ZmBOnrKzie2JygPeXjSNpNJ6W5
5l3DFyquC98wJHog1vSeGwPsAP2YUTAWp56XayFyY4hiL3T9fe+4Ng6xzMQKkdl1
dIRHFuOePdKXkb4UcuvmOQ2wGfRpMazuhz5pe2F1iMmbtXeJMan52atDTb5aqI18
75mtERfy05XRFtRgxK0R/2XzKBTKBCLK4nefqjlUa/Sj4BHN/36vMiKsb/8MX7LF
BX8oReP4WDd9/Vz8zEKGXKHFvKChbw==
=/oOO
-----END PGP SIGNATURE-----

--Sig_/8z7SpmqSvj.DMk0NhBXkQgO--
