Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C129550B28
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 16:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiFSOVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 10:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiFSOVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 10:21:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01738DEA7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 967C56113E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 14:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6477C34114;
        Sun, 19 Jun 2022 14:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655648497;
        bh=Deh2yz+RdHe0bqejh7KLmvRo/vKvIicrQJmRCKRGvsU=;
        h=Date:From:To:Cc:Subject:From;
        b=MuO6AqR6O2PHSXUq9xhbLarWG6lm2RVjk7/3PgQQcdjd7tIU07pdQON2XN+qvG6mA
         clZZo1aKwek/WbI5bHNXgJhlJM7oLNrcg714pc9qaP9ItumTUS/ypyGXE/H6hCUWdx
         7KMC3u2oF2uuh81PC0Wb2FWU+7s8Crn67gq2QV4mE/ti7B1D5ZogtJZESq56tApNlj
         UP1ELwG/Eht0zdX+7lsvuhi2DGjoxK8jMmsPWu8xDA5JZhEKu5WIo7JAT+XdQsgR29
         EmSAX629Hc4CrHt4/o0/zSy9LeYzWUL/Qfg7I8u97bod0r84J6MTSsyj9biCveknHK
         Uq5xeTqOduTeA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5DD594096F; Sun, 19 Jun 2022 11:21:34 -0300 (-03)
Date:   Sun, 19 Jun 2022 11:21:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 FYI] tools headers arm64: Sync arm64's cputype.h with the
 kernel sources
Message-ID: <Yq8w7p4omYKNwOij@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used not to be copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To get the changes in:

  cae889302ebf5a9b ("KVM: arm64: vgic-v3: List M1 Pro/Max as requiring the SEIS workaround")

That addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' differs from latest version at 'arch/arm64/include/asm/cputype.h'
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/asm/cputype.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index e09d6908a21d36b1..8aa0d276a63628f5 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -36,7 +36,7 @@
 #define MIDR_VARIANT(midr)	\
 	(((midr) & MIDR_VARIANT_MASK) >> MIDR_VARIANT_SHIFT)
 #define MIDR_IMPLEMENTOR_SHIFT	24
-#define MIDR_IMPLEMENTOR_MASK	(0xff << MIDR_IMPLEMENTOR_SHIFT)
+#define MIDR_IMPLEMENTOR_MASK	(0xffU << MIDR_IMPLEMENTOR_SHIFT)
 #define MIDR_IMPLEMENTOR(midr)	\
 	(((midr) & MIDR_IMPLEMENTOR_MASK) >> MIDR_IMPLEMENTOR_SHIFT)
 
@@ -118,6 +118,10 @@
 
 #define APPLE_CPU_PART_M1_ICESTORM	0x022
 #define APPLE_CPU_PART_M1_FIRESTORM	0x023
+#define APPLE_CPU_PART_M1_ICESTORM_PRO	0x024
+#define APPLE_CPU_PART_M1_FIRESTORM_PRO	0x025
+#define APPLE_CPU_PART_M1_ICESTORM_MAX	0x028
+#define APPLE_CPU_PART_M1_FIRESTORM_MAX	0x029
 
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
@@ -164,6 +168,10 @@
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
 #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
+#define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
+#define MIDR_APPLE_M1_FIRESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM_PRO)
+#define MIDR_APPLE_M1_ICESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_MAX)
+#define MIDR_APPLE_M1_FIRESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM_MAX)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
 #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
@@ -172,7 +180,7 @@
 
 #ifndef __ASSEMBLY__
 
-#include "sysreg.h"
+#include <asm/sysreg.h>
 
 #define read_cpuid(reg)			read_sysreg_s(SYS_ ## reg)
 
-- 
2.36.1

