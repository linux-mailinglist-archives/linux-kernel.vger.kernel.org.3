Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3294147A866
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhLTLIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhLTLIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:08:52 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF53C061574;
        Mon, 20 Dec 2021 03:08:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHcK96x25z4xQs;
        Mon, 20 Dec 2021 22:08:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639998527;
        bh=y/dGlh1bWpgvYhxF0WE04aBGI8HJ9xycdz1eDKu9sco=;
        h=Date:From:To:Cc:Subject:From;
        b=E2oberPIH986lmkUXoP7P4J6wUsCoFwcrEzrsY340NrXNWn28betu+enblRzTYdWw
         LXDWROZMyxYTPSuvvkkxi6bdita26O0Bhhhlzyjgp7XkB2fQtV2LRUM4H+TQvWDoDi
         o8fsVYr+C/SGNBi4fzwyuNZE/mQZBL+RZpfx7xm0GyZTA+fU98nLLVR5uJdTzcubGp
         sG/nX2zo3hw3G0ICC/NaQA9x+1lj+EjXUMCRJg/8bDyNDYs6U0fFwtgM/XfjFC0HxM
         WsoCgW0FQG9v7PcUVGz2zzIBD358YgZ7bhtZTAhXnfDJ5YWSkbw9oqN0wEyf0bNJaL
         4wGBP+Uo1siVQ==
Date:   Mon, 20 Dec 2021 22:08:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Armin Wolf <W_Armin@gmx.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the akpm tree
Message-ID: <20211220220843.735da08f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3o/FjkrRNfy.xCOU8MbTLzM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3o/FjkrRNfy.xCOU8MbTLzM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/hwmon/dell-smm-hwmon.c: In function 'i8k_ioctl':
drivers/hwmon/dell-smm-hwmon.c:454:31: error: implicit declaration of funct=
ion 'PDE_DATA'; did you mean 'NODE_DATA'? [-Werror=3Dimplicit-function-decl=
aration]
  454 |  struct dell_smm_data *data =3D PDE_DATA(file_inode(fp));
      |                               ^~~~~~~~
      |                               NODE_DATA
drivers/hwmon/dell-smm-hwmon.c:454:31: error: initialization of 'struct del=
l_smm_data *' from 'int' makes pointer from integer without a cast [-Werror=
=3Dint-conversion]
cc1: all warnings being treated as errors

Caused by commit

  2dd082773083 ("proc: remove PDE_DATA() completely")

interacting with commit

  073bd07205af ("hwmon: (dell-smm) Unify i8k_ioctl() and i8k_ioctl_unlocked=
()")

from the hwmon-staging tree.

I applied the following fixup patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 20 Dec 2021 22:04:57 +1100
Subject: [PATCH] fixup for "proc: remove PDE_DATA() completely"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/hwmon/dell-smm-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index baec55c1d83d..145034a324c4 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -451,7 +451,7 @@ static int i8k_get_power_status(void)
=20
 static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 {
-	struct dell_smm_data *data =3D PDE_DATA(file_inode(fp));
+	struct dell_smm_data *data =3D pde_data(file_inode(fp));
 	int __user *argp =3D (int __user *)arg;
 	int speed, err;
 	int val =3D 0;
--=20
2.33.0

--=20
Cheers,
Stephen Rothwell

--Sig_/3o/FjkrRNfy.xCOU8MbTLzM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHAZDsACgkQAVBC80lX
0GxdOwf+Msc+uRWSp1bEelqjgOSLlWQ+6DtvdtvUkvm207r9TFArUb6EgzLT094T
Ojc5WtHXNYfYftHpmW4m1Iqu7e8sri/GxoVf0JaHlXJklUndyfunF12Sx5KVkrMN
zJEDw9QQckDaeuk5YXawqAZVDiaouXIcE8Sl7LDMiz0FljDYSKIoplHHzcnWdqro
fFAT2WsYzjefXLjpeWH1AzeV0fHplE3Rhx7MIHa6iPhgxHVMDHTRfLredehhAApp
eAjAWY2xTC8MjPRNDuxP8t65zman4ah2UnW9zCC0kmYfTLKDpirhJwMA2h4JDObx
afHQS5JysV+aFws8ZMnj+c6mhT8DDg==
=+yb4
-----END PGP SIGNATURE-----

--Sig_/3o/FjkrRNfy.xCOU8MbTLzM--
