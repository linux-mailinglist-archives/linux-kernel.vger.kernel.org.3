Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096A54D977E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346523AbiCOJT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346538AbiCOJT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:19:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9596F13D3F;
        Tue, 15 Mar 2022 02:18:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHnrx2HZnz4xvg;
        Tue, 15 Mar 2022 20:18:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647335923;
        bh=qKRtZYhERZZIQ1+1ePZpbu07BiR32VleXFJbK5n6jcg=;
        h=Date:From:To:Cc:Subject:From;
        b=drez3G/AgYNVI8zRiawEaZIoTQjqQC4iLs/D0+HU/CF23pJdl8Ofo2DJhrSIhXWBW
         gCJfp9VpAKxk0i8KuRda7z7avBe+vutiYGcy1u68lc5zgFqTMaHWbBmd8t+393fPPt
         Dq3+/yPXmMvWG0qxVS6KBpwqyMhzbo6+QOfTqI0ApbTw+m4huM4HNlWoc423cl7gFH
         UMQPw0Z9LmnbyETnvmQ5QpiAB1o8mzYiTvSn92v1wzj8xtKJ+vE3U7dJcqfOR+yooG
         uSHriS0ON1Ye/ynFOA98bRAuVq3zL3fMfLtM0isv2nt1T2YqfYvstrc8iElK/Wn25k
         lybrO1ci+EPYw==
Date:   Tue, 15 Mar 2022 20:18:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhen Ni <nizhen@uniontech.com>
Subject: linux-next: manual merge of the sysctl tree with the tip tree
Message-ID: <20220315201840.6146f234@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vj6a5IykJBDqtYDTjRghcBq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vj6a5IykJBDqtYDTjRghcBq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sysctl tree got a conflict in:

  kernel/sched/deadline.c

between commit:

  eb77cf1c151c ("sched/deadline: Remove unused def_dl_bandwidth")

from the tip tree and commit:

  ebb891f03580 ("sched: Move deadline_period sysctls to deadline.c")

from the sysctl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/sched/deadline.c
index 11cdc6d0c45f,9ed9ace11151..000000000000
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@@ -18,6 -18,42 +18,40 @@@
  #include "sched.h"
  #include "pelt.h"
 =20
 -struct dl_bandwidth def_dl_bandwidth;
 -
+ /*
+  * Default limits for DL period; on the top end we guard against small ut=
il
+  * tasks still getting ridiculously long effective runtimes, on the botto=
m end we
+  * guard against timer DoS.
+  */
+ static unsigned int sysctl_sched_dl_period_max =3D 1 << 22; /* ~4 seconds=
 */
+ static unsigned int sysctl_sched_dl_period_min =3D 100;     /* 100 us */
+ #ifdef CONFIG_SYSCTL
+ static struct ctl_table sched_dl_sysctls[] =3D {
+ 	{
+ 		.procname       =3D "sched_deadline_period_max_us",
+ 		.data           =3D &sysctl_sched_dl_period_max,
+ 		.maxlen         =3D sizeof(unsigned int),
+ 		.mode           =3D 0644,
+ 		.proc_handler   =3D proc_dointvec,
+ 	},
+ 	{
+ 		.procname       =3D "sched_deadline_period_min_us",
+ 		.data           =3D &sysctl_sched_dl_period_min,
+ 		.maxlen         =3D sizeof(unsigned int),
+ 		.mode           =3D 0644,
+ 		.proc_handler   =3D proc_dointvec,
+ 	},
+ 	{}
+ };
+=20
+ static int __init sched_dl_sysctl_init(void)
+ {
+ 	register_sysctl_init("kernel", sched_dl_sysctls);
+ 	return 0;
+ }
+ late_initcall(sched_dl_sysctl_init);
+ #endif
+=20
  static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_s=
e)
  {
  	return container_of(dl_se, struct task_struct, dl);

--Sig_/vj6a5IykJBDqtYDTjRghcBq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwWfAACgkQAVBC80lX
0GxLfQf/V/cFLNKZxqqa7AsbySP1m/9D9gKx0p6A/nWc12vo6lMBPGDYhFr+GWfg
LG1YEePaysIDSFDrAXOFFcrNGlpIvJIT/22cQiog30tODq+pOOeTEUUO70ajVOwI
pd9ijBl/pMG14eFDmdzeV8/CuYNrR3O5/g/VBWXRMV6FyFFFnPb/W+4KJXHiG7uW
ZMNMwOpJzIylR3e9quDXh5TX9FG2qNNjHTsZ+yZoeEKjGCsfdbtSVc0S4TaErcyx
l4vruB8I6url4v0v5XsJZui8Le+TyCVIIgnoG6s1v8YLL8gUBlpxtBSmkEAdL8u8
WTdj+mK0zVFOJKUc8xhbijse0cSzsw==
=jn33
-----END PGP SIGNATURE-----

--Sig_/vj6a5IykJBDqtYDTjRghcBq--
