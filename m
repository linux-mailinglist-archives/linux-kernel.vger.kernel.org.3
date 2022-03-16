Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61E54DAA16
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353693AbiCPF5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiCPF53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:57:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE908433B8;
        Tue, 15 Mar 2022 22:56:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KJKJt13c2z4xc5;
        Wed, 16 Mar 2022 16:56:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647410174;
        bh=02nk9lW8BCCctxls3pqsMzGJixoyf2zsAdcAg+KrNmw=;
        h=Date:From:To:Cc:Subject:From;
        b=IhQ6OJ4+GAYzBh/Kb7HDPjOMM2mxAGJqRV1EJX1WwzR/Pxijz3RnA6L/8EH4BV5N8
         ERN8mTlgFtjvVixVpmOYavfcs7/+S2hhqwVaOHcChULSAAIS252i8QkpM0fEC3MZOK
         hOopxkVX5x7CbDg9eBPBXW1xzdfAeeUN9TAFPvKEnM7F90Utp1Zodt/is91zplShWH
         fEpgfB55EBQId1nQJ2DrhGWgttihQwgaiseBy/ox2yiDYsVpbrwBqZcrZ8qMtyof0d
         gwPoYmkYCE5prmmBJ88isqw7ucSJf4yMeD5+VJS/SX/3UlmgC8IEPipNRxhRcccYxs
         8SgJ6pKDdFMdQ==
Date:   Wed, 16 Mar 2022 16:56:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the userns tree
Message-ID: <20220316165612.4f50faad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5X9PVaMngZ9FYee3la2En_e";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5X9PVaMngZ9FYee3la2En_e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the userns tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

kernel/sched/fair.c: In function 'init_numa_balancing':
kernel/sched/fair.c:2884:9: error: implicit declaration of function 'init_t=
ask_work'; did you mean 'init_irq_work'? [-Werror=3Dimplicit-function-decla=
ration]
 2884 |         init_task_work(&p->numa_work, task_numa_work);
      |         ^~~~~~~~~~~~~~
      |         init_irq_work
kernel/sched/fair.c: In function 'task_tick_numa':
kernel/sched/fair.c:2935:25: error: implicit declaration of function 'task_=
work_add' [-Werror=3Dimplicit-function-declaration]
 2935 |                         task_work_add(curr, work, TWA_RESUME);
      |                         ^~~~~~~~~~~~~
kernel/sched/fair.c:2935:51: error: 'TWA_RESUME' undeclared (first use in t=
his function)
 2935 |                         task_work_add(curr, work, TWA_RESUME);
      |                                                   ^~~~~~~~~~

Maybe caused by commit

  03248addadf1 ("resume_user_mode: Move to resume_user_mode.h")
or
  8ca07e17c9dd ("task_work: Remove unnecessary include from posix_timers.h")

interacting with (maybe) commit

  c4ad6fcb67c4 ("sched/headers: Reorganize, clean up and optimize kernel/sc=
hed/fair.c dependencies")

from the tip tree.

I have applied this merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 16 Mar 2022 16:41:42 +1100
Subject: [PATCH] fixup for moving of linux/task_work.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 89d21fda106c..7a6678fdffb0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -31,6 +31,7 @@
 #include <linux/lockdep_api.h>
 #include <linux/softirq.h>
 #include <linux/refcount_api.h>
+#include <linux/task_work.h>
 #include <linux/topology.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/cond_resched.h>
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/5X9PVaMngZ9FYee3la2En_e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIxe/wACgkQAVBC80lX
0Gy8UAf8DUEireL9zIc1o+fiDIhFC1CN+Fc+k9f9Bd3igsa/td+ZD8V8W6HqQaD2
wxHO08w+cqHILA0w4Vvb2C/BHLTwYT+hX5oTXqIYloWzqs4xhdFK2M9R3vH9Bb7T
T4oC34D2u3MJKUtK2Ve6Ycudt7ilOUQUdx1MUyuGjd4JNX9RlC8GGv0gAXVOVhSX
YlCqlwRPPA0e2AfZw7OnSywnUmN9/Vhih+/NYbudgojXA82lVY7BKTJX5wo76/P6
QNBQlUAHZeWWjFQ67io1+cf2zhekno05phl/RpcZkmwlUH5LtSSDTVwoArw0hDsY
/bfYLzi3pzLr265oEpj9V4JxjSMjig==
=otb0
-----END PGP SIGNATURE-----

--Sig_/5X9PVaMngZ9FYee3la2En_e--
