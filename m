Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393A14ED2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiCaEK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiCaEJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:09:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09956EBBB6;
        Wed, 30 Mar 2022 20:55:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KTT6d4YTjz4xLb;
        Thu, 31 Mar 2022 14:19:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648696745;
        bh=E3hYx8szoYaLX1XgIgbRGhSpGe8jJggQuqTYlJ9XJW0=;
        h=Date:From:To:Cc:Subject:From;
        b=OCk8XCWrDROjJq4J0uswxT8wtI+Fxmf73nc1R04Z4W8XNkQsAIQVug+nNsv6/6vO6
         T3kzGUgw1WGblmDmUr2YWHZIobv+jigEjdObxq/7oj8jhSPQczcQWpQ8tiqxF+o05o
         FuRX0iG3Sx+ZcGqdaZcsgF3SZ7Yj83hPa1No0960WUpBI1tcElAhw0mQ3q1XoxSPXD
         xPcfoixEJ/fwo4dNMzwWSeCDETLXHmbYB5xxFBanxM7RqOuqfZm2LYtZdAL/IV9nbZ
         p4JakN7n8Pppeiir3FgrDe/dKDMDsOZVa7tXyWHGKFWkXJ0Y03CI5oYKw8nnJ0dZCR
         3diRQ8w6u7+pA==
Date:   Thu, 31 Mar 2022 14:18:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20220331141858.46b4df12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iJq6z=2XZ=qKPYISgRewnQq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iJq6z=2XZ=qKPYISgRewnQq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (arm64
defconfig) failed like this:

In file included from include/asm-generic/percpu.h:7,
                 from arch/arm64/include/asm/percpu.h:248,
                 from include/linux/irqflags.h:17,
                 from include/linux/spinlock.h:58,
                 from include/linux/irq.h:14,
                 from arch/arm64/kernel/irq.c:13:
arch/arm64/kernel/irq.c: In function 'init_irq_scs':
arch/arm64/kernel/irq.c:44:25: error: 'irq_shadow_call_stack_ptr' undeclare=
d (first use in this function)
   44 |                 per_cpu(irq_shadow_call_stack_ptr, cpu) =3D
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_=
pcpu_ptr'
  219 |         const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NU=
LL;    \
      |                                                      ^~~
include/linux/percpu-defs.h:269:35: note: in expansion of macro 'per_cpu_pt=
r'
  269 | #define per_cpu(var, cpu)       (*per_cpu_ptr(&(var), cpu))
      |                                   ^~~~~~~~~~~
arch/arm64/kernel/irq.c:44:17: note: in expansion of macro 'per_cpu'
   44 |                 per_cpu(irq_shadow_call_stack_ptr, cpu) =3D
      |                 ^~~~~~~
arch/arm64/kernel/irq.c:44:25: note: each undeclared identifier is reported=
 only once for each function it appears in
   44 |                 per_cpu(irq_shadow_call_stack_ptr, cpu) =3D
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_=
pcpu_ptr'
  219 |         const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NU=
LL;    \
      |                                                      ^~~
include/linux/percpu-defs.h:269:35: note: in expansion of macro 'per_cpu_pt=
r'
  269 | #define per_cpu(var, cpu)       (*per_cpu_ptr(&(var), cpu))
      |                                   ^~~~~~~~~~~
arch/arm64/kernel/irq.c:44:17: note: in expansion of macro 'per_cpu'
   44 |                 per_cpu(irq_shadow_call_stack_ptr, cpu) =3D
      |                 ^~~~~~~

Caused by commit

  aa0120feb340 ("arm64, scs: save scs_sp values per-cpu when switching stac=
ks")

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 31 Mar 2022 13:33:55 +1100
Subject: [PATCH] fix up for "arm64, scs: save scs_sp values per-cpu when sw=
itching stacks"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm64/kernel/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 4199f900714a..5a15e6a42cbf 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <asm/daifflags.h>
 #include <asm/vmap_stack.h>
+#include <asm/scs.h>
=20
 /* Only access this in an NMI enter/exit */
 DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
--=20
2.35.1

This then produced the following:

arch/arm64/kernel/stacktrace.c: In function 'arch_stack_walk_shadow':
arch/arm64/kernel/stacktrace.c:289:20: error: implicit declaration of funct=
ion 'task_scs'; did you mean 'task_lock'? [-Werror=3Dimplicit-function-decl=
aration]
  289 |         scs_base =3D task_scs(current);
      |                    ^~~~~~~~
      |                    task_lock
arch/arm64/kernel/stacktrace.c:289:18: warning: assignment to 'long unsigne=
d int *' from 'int' makes pointer from integer without a cast [-Wint-conver=
sion]
  289 |         scs_base =3D task_scs(current);
      |                  ^

I assume this has never been compiled with CONFIG_SHADOW_CALL_STACK not
set :-(

I have reverted these commits for today:

5c6df774c321 kasan: use stack_trace_save_shadow
0f63d30c44d6 arm64: implement stack_trace_save_shadow
aa0120feb340 arm64, scs: save scs_sp values per-cpu when switching stacks
636fecb8f05e stacktrace: add interface based on shadow call stack

--=20
Cheers,
Stephen Rothwell

--Sig_/iJq6z=2XZ=qKPYISgRewnQq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJFHaIACgkQAVBC80lX
0GzpXgf/ZmjlKQ6npWRw9eBljYrq6M4ZI9Yrr4Cq1J6tyEjlJf6I4FcO2gBQEK1X
fnGj3SmIv7MkHUz+wacWQn5ROkDqdCsyqEabNzNgw0omSlrep1G/F0Bt8jlNI1tz
qYa6M2janX36AL3GGIAP4+Csc1G9Qsp9IMSrn6WImxDidzkrMVVq2V+IB4tSf7Xt
BkAvz0RuIpI0CE0jyfsE+9YuCWVngxmm7OZio9bS6aewz9WIe82lkdaqKEDVcnfF
xN06/F/ecg9m/dcBFf30ma24EXlhFAZTYrPDdK0Rr2RQAvkrOwbtfIbwZebBlV0z
hcxBrdBVabvms6mbLB2pRlnjB6VwNA==
=GCb6
-----END PGP SIGNATURE-----

--Sig_/iJq6z=2XZ=qKPYISgRewnQq--
