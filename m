Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353D0464640
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346593AbhLAFJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbhLAFJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:09:52 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1701FC061574;
        Tue, 30 Nov 2021 21:06:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J3n9x4sgjz4xR7;
        Wed,  1 Dec 2021 16:06:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638335190;
        bh=tIXmFJB4Pv3ffFWXCgXpzhPi8XCIVcB/zJT8cO+Mf70=;
        h=Date:From:To:Cc:Subject:From;
        b=L89B5BTsvC8e0qND6rEmhcXWfLQdbwBTOL2AnkzaSa2a/+Ukg9uY1EDrGv9WJ46nD
         8ftL4o6pUWCYeUj1P0uFdaRpA40YJf9SX28dMAfNVAYJKb9PSDn2oevNoD2P3EaH5R
         7A9un+HlEh92QJHq7vow702+2ZDVfHMrywDS9v/+goAcIPIHDyFVxassFYXUmil+4M
         NB/X3kXklVhG5RrF7vJkz8k/hPpfvZ0IsKIgjiQd2Jr7JNOhDMS5cgCeMdepSSBpbQ
         u216z8DhRIQL243VbValGDSSNYFFnQxvtz4PZpQSLbHVSZ4q1emdScdBX7PjhuJeRP
         K7cm2Hk9jrk5Q==
Date:   Wed, 1 Dec 2021 16:06:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: linux-next: build failure after merge of the akpm tree
Message-ID: <20211201160626.401d828d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XI7hZZorkNhkMfJx3n5c/TS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XI7hZZorkNhkMfJx3n5c/TS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/base/firmware_loader/fallback_table.c:60:53: error: macro "EXPORT_S=
YMBOL_NS_GPL" requires 2 arguments, but only 1 given
   60 | EXPORT_SYMBOL_NS_GPL(register_firmware_config_sysctl);
      |                                                     ^
In file included from include/linux/linkage.h:7,
                 from include/linux/printk.h:8,
                 from include/asm-generic/bug.h:22,
                 from arch/x86/include/asm/bug.h:84,
                 from include/linux/bug.h:5,
                 from include/linux/mmdebug.h:5,
                 from include/linux/gfp.h:5,
                 from include/linux/slab.h:15,
                 from drivers/base/firmware_loader/fallback_table.c:6:
include/linux/export.h:166: note: macro "EXPORT_SYMBOL_NS_GPL" defined here
  166 | #define EXPORT_SYMBOL_NS_GPL(sym, ns) __EXPORT_SYMBOL(sym, "_gpl", =
#ns)
      |=20
drivers/base/firmware_loader/fallback_table.c:60:1: error: data definition =
has no type or storage class [-Werror]
   60 | EXPORT_SYMBOL_NS_GPL(register_firmware_config_sysctl);
      | ^~~~~~~~~~~~~~~~~~~~
drivers/base/firmware_loader/fallback_table.c:60:1: error: type defaults to=
 'int' in declaration of 'EXPORT_SYMBOL_NS_GPL' [-Werror=3Dimplicit-int]
drivers/base/firmware_loader/fallback_table.c:67:55: error: macro "EXPORT_S=
YMBOL_NS_GPL" requires 2 arguments, but only 1 given
   67 | EXPORT_SYMBOL_NS_GPL(unregister_firmware_config_sysctl);
      |                                                       ^
In file included from include/linux/linkage.h:7,
                 from include/linux/printk.h:8,
                 from include/asm-generic/bug.h:22,
                 from arch/x86/include/asm/bug.h:84,
                 from include/linux/bug.h:5,
                 from include/linux/mmdebug.h:5,
                 from include/linux/gfp.h:5,
                 from include/linux/slab.h:15,
                 from drivers/base/firmware_loader/fallback_table.c:6:
include/linux/export.h:166: note: macro "EXPORT_SYMBOL_NS_GPL" defined here
  166 | #define EXPORT_SYMBOL_NS_GPL(sym, ns) __EXPORT_SYMBOL(sym, "_gpl", =
#ns)
      |=20
drivers/base/firmware_loader/fallback_table.c:67:1: error: data definition =
has no type or storage class [-Werror]
   67 | EXPORT_SYMBOL_NS_GPL(unregister_firmware_config_sysctl);
      | ^~~~~~~~~~~~~~~~~~~~
drivers/base/firmware_loader/fallback_table.c:67:1: error: type defaults to=
 'int' in declaration of 'EXPORT_SYMBOL_NS_GPL' [-Werror=3Dimplicit-int]

Caused by commit

  8419b29bbf54 ("firmware_loader-move-firmware-sysctl-to-its-own-files-fix-=
fix")

I have applied the following for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 1 Dec 2021 15:58:34 +1100
Subject: [PATCH] firmware_loader-move-firmware-sysctl-to-its-own-files-fix-3

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/base/firmware_loader/fallback_table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/f=
irmware_loader/fallback_table.c
index c3fb8292acb8..e5ac098d0742 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -57,13 +57,13 @@ int register_firmware_config_sysctl(void)
 		return -ENOMEM;
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(register_firmware_config_sysctl);
+EXPORT_SYMBOL_NS_GPL(register_firmware_config_sysctl, FIRMWARE_LOADER_PRIV=
ATE);
=20
 void unregister_firmware_config_sysctl(void)
 {
 	unregister_sysctl_table(firmware_config_sysct_table_header);
 	firmware_config_sysct_table_header =3D NULL;
 }
-EXPORT_SYMBOL_NS_GPL(unregister_firmware_config_sysctl);
+EXPORT_SYMBOL_NS_GPL(unregister_firmware_config_sysctl, FIRMWARE_LOADER_PR=
IVATE);
=20
 #endif /* CONFIG_SYSCTL */
--=20
2.33.0

--=20
Cheers,
Stephen Rothwell

--Sig_/XI7hZZorkNhkMfJx3n5c/TS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGnAtIACgkQAVBC80lX
0Gx1qQf+NtczOB9oceo3OcmUOy3zCA9LGMJUcc0iayyxSsWVq2qDYDw3/hBK+tTx
IUNY7Ss4B/VtNMzSciIkEnR2badixqP+GoM40os8FTbNm8uDJbnyo8UKxtebAmmg
BejP7atiGFlr1+UMRbTykGhFHKXdYKGqrPyWvHfG6f2ANgzAZYwZHJ0g1V2eOpV2
l1Qd+VL/Z24WQqRt7oSEtRv5dsTc/czrqGl9Dz03jx52n4ykL+WWBnHgT9luG2G/
wr31o+z+GMqVyOQmnEiND9i1B+yK8pZ7JptXFOMfSkRrIbqg/oIJg8Sy/QaX1h6t
8dYjaTFLv/m7vLB5d1KhUbqjE6qIYA==
=RZWg
-----END PGP SIGNATURE-----

--Sig_/XI7hZZorkNhkMfJx3n5c/TS--
