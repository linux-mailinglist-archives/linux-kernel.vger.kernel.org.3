Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3D512A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242327AbiD1Die (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241736AbiD1DiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:38:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980DA267;
        Wed, 27 Apr 2022 20:35:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C6361A94;
        Thu, 28 Apr 2022 03:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D2BC385AE;
        Thu, 28 Apr 2022 03:35:00 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, dalias@libc.org,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 3/4] m68knommu: add definitions to support elf_fdpic program loader
Date:   Thu, 28 Apr 2022 13:33:18 +1000
Message-Id: <20220428033319.239341-4-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428033319.239341-1-gerg@linux-m68k.org>
References: <20220428033319.239341-1-gerg@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few required defines to support using the binfmt_elf_fdpic
loader on the m68k architecture. The values are defined to be consistent
with those used on arm and sh which support this too.

The most important m68k specific change is the register initialization.
The pt_reg structure only contains a subset of the architecture general
registers, so we are more limited than to be expected on what can be used.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/include/asm/elf.h         | 9 +++++++++
 arch/m68k/include/uapi/asm/ptrace.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/arch/m68k/include/asm/elf.h b/arch/m68k/include/asm/elf.h
index 3d387ceaea3f..2def06a99b08 100644
--- a/arch/m68k/include/asm/elf.h
+++ b/arch/m68k/include/asm/elf.h
@@ -60,6 +60,13 @@ typedef struct user_m68kfp_struct elf_fpregset_t;
    is actually used on ASV.  */
 #define ELF_PLAT_INIT(_r, load_addr)	_r->a1 = 0
 
+#define ELF_FDPIC_PLAT_INIT(_r, _exec_map_addr, _interp_map_addr, dynamic_addr) \
+        do { \
+                (_r)->d3 = _exec_map_addr; \
+                (_r)->d4 = _interp_map_addr; \
+                (_r)->d5 = dynamic_addr; \
+        } while(0)
+
 #if defined(CONFIG_SUN3) || defined(CONFIG_COLDFIRE)
 #define ELF_EXEC_PAGESIZE	8192
 #else
@@ -114,4 +121,6 @@ typedef struct user_m68kfp_struct elf_fpregset_t;
 
 #define ELF_PLATFORM  (NULL)
 
+#define ELF_FDPIC_CORE_EFLAGS  0
+
 #endif
diff --git a/arch/m68k/include/uapi/asm/ptrace.h b/arch/m68k/include/uapi/asm/ptrace.h
index 19a1b9d0d858..5b50ea592e00 100644
--- a/arch/m68k/include/uapi/asm/ptrace.h
+++ b/arch/m68k/include/uapi/asm/ptrace.h
@@ -74,7 +74,12 @@ struct switch_stack {
 
 #define PTRACE_GET_THREAD_AREA    25
 
+#define PTRACE_GETFDPIC	31
+
 #define PTRACE_SINGLEBLOCK	33	/* resume execution until next branch */
 
+#define PTRACE_GETFDPIC_EXEC	0
+#define PTRACE_GETFDPIC_INTERP	1
+
 #endif /* __ASSEMBLY__ */
 #endif /* _UAPI_M68K_PTRACE_H */
-- 
2.25.1

