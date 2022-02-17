Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE7C4B9B77
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbiBQIui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:50:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiBQIub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:50:31 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E49F2A229A;
        Thu, 17 Feb 2022 00:50:17 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4JzpS71R4gz9sSn;
        Thu, 17 Feb 2022 09:50:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zp3kcSnZ9IwF; Thu, 17 Feb 2022 09:50:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4JzpS424nDz9sSZ;
        Thu, 17 Feb 2022 09:50:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 366678B77A;
        Thu, 17 Feb 2022 09:50:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ntk_fVf6iUkT; Thu, 17 Feb 2022 09:50:12 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.225])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E760B8B763;
        Thu, 17 Feb 2022 09:50:11 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21H8o20x345518
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 09:50:02 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21H8o0Ew345517;
        Thu, 17 Feb 2022 09:50:00 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2] vsprintf: Fix %pK with kptr_restrict == 0
Date:   Thu, 17 Feb 2022 09:49:59 +0100
Message-Id: <107476128e59bff11a309b5bf7579a1753a41aca.1645087605.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645087798; l=4466; s=20211009; h=from:subject:message-id; bh=dLHQV1fFbxDzziI+jHDqlL7hJXcffZqPNoUQg+RXCaE=; b=RdE0988bpb7eoHvBctHTt7Ru8x9D9fQ3HjQYdmRhvuWi7m6yJjHUuh7V0DqMYUifRQrvveemrNJh 9gp6rlrPCUuFHTCKqA8XbR4Wzl/HmLOlT4BC8GcOS9d+L5eSZREJ
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

Although kptr_restrict is set to 0 and the kernel is booted with
no_hash_pointers parameter, the content of /proc/vmallocinfo is
lacking the real addresses.

  / # cat /proc/vmallocinfo
  0x(ptrval)-0x(ptrval)    8192 load_module+0xc0c/0x2c0c pages=1 vmalloc
  0x(ptrval)-0x(ptrval)   12288 start_kernel+0x4e0/0x690 pages=2 vmalloc
  0x(ptrval)-0x(ptrval)   12288 start_kernel+0x4e0/0x690 pages=2 vmalloc
  0x(ptrval)-0x(ptrval)    8192 _mpic_map_mmio.constprop.0+0x20/0x44 phys=0x80041000 ioremap
  0x(ptrval)-0x(ptrval)   12288 _mpic_map_mmio.constprop.0+0x20/0x44 phys=0x80041000 ioremap
    ...

According to the documentation for /proc/sys/kernel/, %pK is
equivalent to %p when kptr_restrict is set to 0.

Fixes: 5ead723a20e0 ("lib/vsprintf: no_hash_pointers prints all addresses as unhashed")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Refactor %p default handling into default_pointer()
---
 .../admin-guide/kernel-parameters.txt         |  3 +-
 lib/vsprintf.c                                | 36 +++++++++++--------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..c3133f97aa42 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3485,8 +3485,7 @@
 			difficult since unequal pointers can no longer be
 			compared.  However, if this command-line option is
 			specified, then all normal pointers will have their true
-			value printed.  Pointers printed via %pK may still be
-			hashed.  This option should only be specified when
+			value printed. This option should only be specified when
 			debugging the kernel.  Please do not use on production
 			kernels.
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b8129dd374c..7003c9ff787b 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -53,6 +53,10 @@
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
 
+/* Disable pointer hashing if requested */
+bool no_hash_pointers __ro_after_init;
+EXPORT_SYMBOL_GPL(no_hash_pointers);
+
 static noinline unsigned long long simple_strntoull(const char *startp, size_t max_chars, char **endp, unsigned int base)
 {
 	const char *cp;
@@ -848,6 +852,19 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
 	return pointer_string(buf, end, (const void *)hashval, spec);
 }
 
+static char *default_pointer(char *buf, char *end, const void *ptr,
+			     struct printf_spec spec)
+{
+	/*
+	 * default is to _not_ leak addresses, so hash before printing,
+	 * unless no_hash_pointers is specified on the command line.
+	 */
+	if (unlikely(no_hash_pointers))
+		return pointer_string(buf, end, ptr, spec);
+
+	return ptr_to_id(buf, end, ptr, spec);
+}
+
 int kptr_restrict __read_mostly;
 
 static noinline_for_stack
@@ -857,7 +874,7 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 	switch (kptr_restrict) {
 	case 0:
 		/* Handle as %p, hash and do _not_ leak addresses. */
-		return ptr_to_id(buf, end, ptr, spec);
+		return default_pointer(buf, end, ptr, spec);
 	case 1: {
 		const struct cred *cred;
 
@@ -2223,10 +2240,6 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
-/* Disable pointer hashing if requested */
-bool no_hash_pointers __ro_after_init;
-EXPORT_SYMBOL_GPL(no_hash_pointers);
-
 int __init no_hash_pointers_enable(char *str)
 {
 	if (no_hash_pointers)
@@ -2455,7 +2468,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'e':
 		/* %pe with a non-ERR_PTR gets treated as plain %p */
 		if (!IS_ERR(ptr))
-			break;
+			return default_pointer(buf, end, ptr, spec);
 		return err_ptr(buf, end, ptr, spec);
 	case 'u':
 	case 'k':
@@ -2465,16 +2478,9 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		default:
 			return error_string(buf, end, "(einval)", spec);
 		}
+	default:
+		return default_pointer(buf, end, ptr, spec);
 	}
-
-	/*
-	 * default is to _not_ leak addresses, so hash before printing,
-	 * unless no_hash_pointers is specified on the command line.
-	 */
-	if (unlikely(no_hash_pointers))
-		return pointer_string(buf, end, ptr, spec);
-	else
-		return ptr_to_id(buf, end, ptr, spec);
 }
 
 /*
-- 
2.34.1

