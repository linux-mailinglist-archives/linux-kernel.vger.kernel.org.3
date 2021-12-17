Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40971478578
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhLQHN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:13:29 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:56395 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLQHN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:13:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFgF24gG1z4xbd;
        Fri, 17 Dec 2021 18:13:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639725207;
        bh=hlI7VFVsUClAsaeRSpccCujbxp8wSxxA2+7VkBPB/vg=;
        h=Date:From:To:Cc:Subject:From;
        b=q8nthaHZiHADFWPZYCj3NhOkJL/Gg0Sp/v+dJhE2eEWyyA4zx7rBf0+4752VdY/L8
         a9/+8F12kLrHJwaxzy8zFnUpTe92ZE2J4EDfys/CfYkKabIPDNS2sMsRMjo7Bdzuzw
         SldHnlhnpQdN4et9Lgz2I69xfUKpwCBXAUTx7TE4vHT8KbZTteaKL+z/IKHnSYGx2A
         FlJxF1ZK+BoBDrOVCflz3To6fMfvEdL1Wk9dmp7t3sPgiOTKmWOEHewhmTtbePBEt8
         qUMp4G8BoXL0qKADffra4P9f9AR0Pm0SbfMlPr4Rd6dok3nQDwz/q8e9dldqslgNa1
         OY3/5MUhnkLag==
Date:   Fri, 17 Dec 2021 18:13:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     NeilBrown <neilb@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the userns tree
Message-ID: <20211217181325.4fa394c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JahM5cWo0Z7/_iCBehLHqZW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JahM5cWo0Z7/_iCBehLHqZW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the userns tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/lockd/svc.c: In function 'lockd':
fs/lockd/svc.c:188:2: error: implicit declaration of function 'module_put_a=
nd_exit'; did you mean 'module_put_and_kthread_exit'? [-Werror=3Dimplicit-f=
unction-declaration]
  188 |  module_put_and_exit(0);
      |  ^~~~~~~~~~~~~~~~~~~
      |  module_put_and_kthread_exit
fs/lockd/svc.c:189:1: error: no return statement in function returning non-=
void [-Werror=3Dreturn-type]
  189 | }
      | ^

Caused by commit

  ca3574bd653a ("exit: Rename module_put_and_exit to module_put_and_kthread=
_exit")

interacting with commit

  6b044fbaab02 ("lockd: use svc_set_num_threads() for thread start and stop=
")

from the cel tree.

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 17 Dec 2021 18:10:42 +1100
Subject: [PATCH] fix up for "lockd: use svc_set_num_threads() for thread st=
art
 and stop"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/lockd/svc.c             | 2 +-
 include/linux/sunrpc/svc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 4defefd89cbf..0475c5a5d061 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -185,7 +185,7 @@ lockd(void *vrqstp)
=20
 	svc_exit_thread(rqstp);
=20
-	module_put_and_exit(0);
+	module_put_and_kthread_exit(0);
 }
=20
 static int create_lockd_listener(struct svc_serv *serv, const char *name,
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index cf175d47c6b7..f35c22b3355f 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -65,7 +65,7 @@ struct svc_serv_ops {
 	void		(*svo_enqueue_xprt)(struct svc_xprt *);
=20
 	/* optional module to count when adding threads.
-	 * Thread function must call module_put_and_exit() to exit.
+	 * Thread function must call module_put_and_kthread_exit() to exit.
 	 */
 	struct module	*svo_module;
 };
--=20
2.33.0

--=20
Cheers,
Stephen Rothwell

--Sig_/JahM5cWo0Z7/_iCBehLHqZW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG8OJUACgkQAVBC80lX
0GxrNwf/QBMkxsDRXDYDAmqvCM0oNWt88mUlkXs/Q07nNMpzkQUlpf/NdAinyWp/
aFXXQgGG6XqHbxgtgzxB7d16aafjW5yliaKARR3mB6oX6POoWkBwu8NAVtTe1nqL
0oxYko9gy8SxNYOlIJZuUhc9hOAnAMMyTEBkXVaYVm0iQ4XVJMg47BCiMpMkjB1F
2lEk1VbEyuV2AZpM2XUcdasxHYW0bDnD7bpiJOAtMnHLA5qZ3pEBWFXn0jdRG+np
Zaok3CWuaLJep0sK7zMs/ALJXTUOnoGcqTex5xkELO8vdCS5T88FyC48q7lEn7dp
jufcQd15KiEXjsPdoPs8jHKlPqBdrA==
=3IPH
-----END PGP SIGNATURE-----

--Sig_/JahM5cWo0Z7/_iCBehLHqZW--
