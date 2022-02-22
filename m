Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B827E4BF5BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiBVKYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiBVKYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:24:13 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FECA83013;
        Tue, 22 Feb 2022 02:23:43 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K2wHd5ZpXz9sSV;
        Tue, 22 Feb 2022 11:23:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wzHtau34bAPV; Tue, 22 Feb 2022 11:23:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K2wHd4pBLz9sSN;
        Tue, 22 Feb 2022 11:23:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 933C18B77A;
        Tue, 22 Feb 2022 11:23:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 31ddN_IQDOwK; Tue, 22 Feb 2022 11:23:41 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 740838B775;
        Tue, 22 Feb 2022 11:23:41 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MANWH51075620
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 11:23:32 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MANW8f1075619;
        Tue, 22 Feb 2022 11:23:32 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Fixup for 87b31159f78a ("module: Move all into module/")
Date:   Tue, 22 Feb 2022 11:23:24 +0100
Message-Id: <cab881354cedd64c53ce4e35ef8c86806baad99c.1645525354.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645525381; l=1233; s=20211009; h=from:subject:message-id; bh=uSuQR2ZSU2t0Tv6BQdmIRToKcnjRDFHb05bjC+21ZUk=; b=S04yDIIXntxpV57+gsfk6Nx6NjKz3xlXNnVKb+XBmcAWgYG3toqyi73cBY/OkEJRWme1vD8sEP8W t0i6mF5WCRLTFBKOBN8qRVE6D27ZVPE82EKBpJJOV6tDpVis3Hct
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 87b31159f78a ("module: Move all into module/")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/Makefile        | 1 -
 kernel/module/Makefile | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index 3a6380975c57..04cb6932c0d3 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -29,7 +29,6 @@ KCOV_INSTRUMENT_softirq.o := n
 KCSAN_SANITIZE_softirq.o = n
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
-KCOV_INSTRUMENT_module.o := n
 KCOV_INSTRUMENT_extable.o := n
 KCOV_INSTRUMENT_stacktrace.o := n
 # Don't self-instrument.
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 686ca921fc8f..b57953bd47eb 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -3,6 +3,10 @@
 # Makefile for linux kernel module support
 #
 
+# These are called from save_stack_trace() on slub debug path,
+# and produce insane amounts of uninteresting coverage.
+KCOV_INSTRUMENT_main.o := n
+
 obj-$(CONFIG_MODULES) += main.o
 obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
-- 
2.34.1

