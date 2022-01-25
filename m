Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E692A49B2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355916AbiAYLfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:35:38 -0500
Received: from foss.arm.com ([217.140.110.172]:36816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346922AbiAYLcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:32:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DBF811FB;
        Tue, 25 Jan 2022 03:32:14 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81B593F7D8;
        Tue, 25 Jan 2022 03:32:12 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH v2 2/7] linkage: add SYM_{ENTRY,START,END}_AT()
Date:   Tue, 25 Jan 2022 11:31:55 +0000
Message-Id: <20220125113200.3829108-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125113200.3829108-1-mark.rutland@arm.com>
References: <20220125113200.3829108-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the SYM_{ENTRY,START,END}() helpers define symbols in terms
of the current position within the section. In subsequent patches we'll
need to define symbols after moving this position.

This patch splits the core out of SYM_{ENTRY,START,END}() into
SYM_{ENTRY,START,END}_AT() macros which take a location argument,
with SYM_{ENTRY,START,END}() passing the current position.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/linkage.h | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index dbf8506decca0..d87c2acda2540 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -147,25 +147,43 @@
 
 /* === generic annotations === */
 
+#ifndef SYM_ENTRY_AT
+#define SYM_ENTRY_AT(name, location, linkage)		\
+	linkage(name) ASM_NL				\
+	.set name, location ASM_NL
+#endif
+
 /* SYM_ENTRY -- use only if you have to for non-paired symbols */
 #ifndef SYM_ENTRY
 #define SYM_ENTRY(name, linkage, align...)		\
-	linkage(name) ASM_NL				\
 	align ASM_NL					\
-	name:
+	SYM_ENTRY_AT(name, ., linkage)
+#endif
+
+/* SYM_START_AT -- use only if you have to */
+#ifndef SYM_START_AT
+#define SYM_START_AT(name, location, linkage)		\
+	SYM_ENTRY_AT(name, location, linkage)
 #endif
 
 /* SYM_START -- use only if you have to */
 #ifndef SYM_START
 #define SYM_START(name, linkage, align...)		\
-	SYM_ENTRY(name, linkage, align)
+	align ASM_NL					\
+	SYM_START_AT(name, ., linkage)
+#endif
+
+/* SYM_END_AT -- use only if you have to */
+#ifndef SYM_END_AT
+#define SYM_END_AT(name, location, sym_type)		\
+	.type name sym_type ASM_NL			\
+	.size name, location-name ASM_NL
 #endif
 
 /* SYM_END -- use only if you have to */
 #ifndef SYM_END
 #define SYM_END(name, sym_type)				\
-	.type name sym_type ASM_NL			\
-	.size name, .-name
+	SYM_END_AT(name, ., sym_type)
 #endif
 
 /* === code annotations === */
-- 
2.30.2

