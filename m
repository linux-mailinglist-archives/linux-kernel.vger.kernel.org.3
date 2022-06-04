Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25F253D62C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 10:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiFDIxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 04:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiFDIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 04:53:37 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCE520BD3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 01:53:35 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 2548p0xo013521;
        Sat, 4 Jun 2022 17:51:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2548p0xo013521
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654332661;
        bh=FEAy194PWq95HNbYDnr1IqurmUH0R2wQrRmS1HC000s=;
        h=From:To:Cc:Subject:Date:From;
        b=P1D+qmFKkOacKls3HlfteNNBNbd46qHxatZFOoNxKzKI7qCjiD7P5mXwp51JouN3e
         WvF8ToAxeBgnAny1boG6PxhPcFE42TG+1OSnhr8UtAAdz6ncuHuVA8tYENs6QfI3sM
         R7zrVo8VuWsASAk7d2fQbqnma/rf8H1xhe6AIQvgD7tfZNaCMvngd+gv9Z7Ts9DriX
         13zgBwgocKc9E2+G04x8jh+7ayALIgY71pdsjLPXaAxidMveTXBtRz/2VdmC2kvynE
         XgeL5A8l2/cFWe37pBB8rsG3m6zg1mV5SdHi56K64Ec4xfdDZdXuPvUfnN3zpyZUwQ
         XIOXj7GpyrfGw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Diana Craciun <diana.craciun@nxp.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Jason Yan <yanaijie@huawei.com>, Rob Herring <robh@kernel.org>,
        Scott Wood <oss@buserror.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: get rid of #include <generated/compile.h>
Date:   Sat,  4 Jun 2022 17:50:50 +0900
Message-Id: <20220604085050.4078927-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You cannot include <generated/compile.h> here because it is generated
in init/Makefile but there is no guarantee that it happens before
arch/powerpc/mm/nohash/kaslr_booke.c is compiled for parallel builds.

The places where you can reliably include <generated/compile.h> are:

  - init/          (because init/Makefile can specify the dependency)
  - arch/*/boot/   (because it is compiled after vmlinux)

Commit f231e4333312 ("hexagon: get rid of #include <generated/compile.h>")
fixed the last breakage at that time, but powerpc re-added this.

<genearated/compile.h> was unneeded because 'build_str' is almost the
same as 'linux_banner' defined in init/version.c

Let's copy the solution from MIPS.
(get_random_boot() in arch/mips/kernel/relocate.c)

Fixes: 6a38ea1d7b94 ("powerpc/fsl_booke/32: randomize the kernel image offset")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

If this gets into the mainline before -rc2 or -rc3,
I will base my kbuild work on top of this.


 arch/powerpc/mm/nohash/kaslr_booke.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 96c38f971603..5f81c076621f 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -18,7 +18,6 @@
 #include <asm/prom.h>
 #include <asm/kdump.h>
 #include <mm/mmu_decl.h>
-#include <generated/compile.h>
 #include <generated/utsrelease.h>
 
 struct regions {
@@ -36,10 +35,6 @@ struct regions {
 	int reserved_mem_size_cells;
 };
 
-/* Simplified build-specific string for starting entropy. */
-static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
-		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
-
 struct regions __initdata regions;
 
 static __init void kaslr_get_cmdline(void *fdt)
@@ -70,7 +65,8 @@ static unsigned long __init get_boot_seed(void *fdt)
 {
 	unsigned long hash = 0;
 
-	hash = rotate_xor(hash, build_str, sizeof(build_str));
+	/* build-specific string for starting entropy. */
+	hash = rotate_xor(hash, linux_banner, strlen(linux_banner));
 	hash = rotate_xor(hash, fdt, fdt_totalsize(fdt));
 
 	return hash;
-- 
2.32.0

