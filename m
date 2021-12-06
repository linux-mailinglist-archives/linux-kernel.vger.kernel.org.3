Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831CB4695F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbhLFMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:50:54 -0500
Received: from foss.arm.com ([217.140.110.172]:56276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233165AbhLFMux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:50:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B45A1042;
        Mon,  6 Dec 2021 04:47:24 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6012A3F73D;
        Mon,  6 Dec 2021 04:47:22 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        maz@kernel.org, mingo@redhat.com, peterz@infradead.org,
        tabba@google.com, tglx@linutronix.de, will@kernel.org
Subject: [RFC PATCH 1/6] linkage: add SYM_{ENTRY,START,END}_AT()
Date:   Mon,  6 Dec 2021 12:47:10 +0000
Message-Id: <20211206124715.4101571-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211206124715.4101571-1-mark.rutland@arm.com>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
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

TODO:

* Handle tools/ copy

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/linkage.h | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index dbf8506decca..45a4c0fcef7d 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -147,25 +147,42 @@
 
 /* === generic annotations === */
 
+#ifndef SYM_ENTRY_AT
+#define SYM_ENTRY_AT(name, location, linkage, align...)	\
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
+	SYM_ENTRY_AT(name, ., linkage, align)
+#endif
+
+/* SYM_START_AT -- use only if you have to */
+#ifndef SYM_START_AT
+#define SYM_START_AT(name, location, linkage, align...)	\
+	SYM_ENTRY_AT(name, location, linkage, align)
 #endif
 
 /* SYM_START -- use only if you have to */
 #ifndef SYM_START
 #define SYM_START(name, linkage, align...)		\
-	SYM_ENTRY(name, linkage, align)
+	SYM_START_AT(name, ., linkage, align)
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

