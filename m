Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01560478596
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhLQHe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:34:29 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:36793 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbhLQHe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:34:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFgjG5mM1z4xbd;
        Fri, 17 Dec 2021 18:34:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639726467;
        bh=VpmjPo2ixktYtFXZ6Hllv/WQwWKoT4H3HFR60bbjaCY=;
        h=Date:From:To:Cc:Subject:From;
        b=F7H26NAKpFBvS5HNlp5vRpzJoN20V3olba+BLoVYsJW41JogzYPxLnEclgIlNZ/Yo
         Sofv+6kHkIsZRrNctYRYBLEzkhEw7fudtEsJApZPAteQdofSCf4EHSC7x8w71Ojf+x
         Yhl7uTz1O5wspkSharNFpXHQcmpqfWkwsGWCorc/1dArn1CH5eDWt4hLYBUkY010fJ
         kSUlNn4nz+cBHkzuXgyACcH/th2HhYPgS/DYDEDHIbAlVP9mmeGQU8dNBSPzUUynCv
         y9pNlfZJ2KEMF5Fwh1h7id5qvJoLcbudV6UFx3zGQ6ebt2u4nbHgZ610Pq3UB0boIA
         uCEAUbqrbazzQ==
Date:   Fri, 17 Dec 2021 18:34:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the userns tree
Message-ID: <20211217183425.5ace9d3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_qJI_+Tq5vWe30eZvxCsKCP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_qJI_+Tq5vWe30eZvxCsKCP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the userns tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ERROR: modpost: ".do_exit" [drivers/vhost/vhost.ko] undefined!

Caused by commit

  eb55e716ac1a ("exit: Stop exporting do_exit")

interacting with commit

  bbf761db7dbb ("vhost: use user_worker to check RLIMITs")

from the vhost tree.

I have added the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 17 Dec 2021 18:24:30 +1100
Subject: [PATCH] fix up for "vhost: use user_worker to check RLIMITs"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8cf259d798c0..b605a79533bb 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -374,7 +374,7 @@ static int vhost_worker(void *data)
 	}
=20
 	complete(worker->exit_done);
-	do_exit(0);
+	make_task_dead(0);
 }
=20
 static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)

This lead to:

ERROR: modpost: ".make_task_dead" [drivers/vhost/vhost.ko] undefined!

so I added the following as well.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 17 Dec 2021 18:30:09 +1100
Subject: [PATCH] fix 2 for "vhost: use user_worker to check RLIMITs"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/exit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index 6c4b04531f17..dfa3e8f6ffeb 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -890,6 +890,7 @@ void __noreturn make_task_dead(int signr)
=20
 	do_exit(signr);
 }
+EXPORT_SYMBOL_GPL(make_task_dead);
=20
 SYSCALL_DEFINE1(exit, int, error_code)
 {

--=20
Cheers,
Stephen Rothwell

--Sig_/_qJI_+Tq5vWe30eZvxCsKCP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG8PYEACgkQAVBC80lX
0GzV8ggAjLThx/i2X9VW9nMPe941yWnxXgcIXwYxyJJf7nOI5eZa3gXF09gowR1Z
KSh5DCOuDM+baeeXxFr6vuUkF/vjPXL+y0+PeZSC0BG2p2waKWs11RPqCjp09Cou
jONdtZJeqkb31C26XwBoO+qUcEjkvuPCpLXsCLC934EMGC2dUIJ/aa7AVNtAsPWF
V9n00fgH5ZaYTCkQSqPqDIF2RtiW+W5+61ZD8zwBWPmmA1ydMZaI8cdd3E1KK3O/
StqfhLHB09+ri1io7LwIG1SrB91lujyYxv7VBHGMC55LEDW6CgB8i4014dwyRDTh
Czv61Bf0q50CeEmJBrHK4vQxeMQXpg==
=A0fr
-----END PGP SIGNATURE-----

--Sig_/_qJI_+Tq5vWe30eZvxCsKCP--
