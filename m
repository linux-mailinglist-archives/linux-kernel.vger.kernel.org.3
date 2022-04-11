Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A84FC4CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349520AbiDKTQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiDKTQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:16:10 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17301EECB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:13:53 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KcdnD30bpz9sV5;
        Mon, 11 Apr 2022 21:13:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5gGs-u6Ay1cu; Mon, 11 Apr 2022 21:13:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KcdnD1pbGz9sV4;
        Mon, 11 Apr 2022 21:13:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 166C18B76E;
        Mon, 11 Apr 2022 21:13:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iGQeiEsNUe2J; Mon, 11 Apr 2022 21:13:51 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.78])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B1E3F8B763;
        Mon, 11 Apr 2022 21:13:51 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 23BJDeXM972781
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 21:13:40 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 23BJDdYn972780;
        Mon, 11 Apr 2022 21:13:39 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] lkdtm/bugs: Don't expect thread termination without CONFIG_UBSAN_TRAP
Date:   Mon, 11 Apr 2022 21:13:39 +0200
Message-Id: <363b58690e907c677252467a94fe49444c80ea76.1649704381.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1649704418; l=2871; s=20211009; h=from:subject:message-id; bh=RLwexbMQAWzDpT+/wG8yGNeAAZhFmV03nOMJ5ww5lXc=; b=13GCUW2rr5U6kuQjAbew1WPESq+ym971NZs/YcOfavRAXzJpoV/hvf03fqbsNGKYiOPXls4d7RNV RiVKT4/NCCXrDGkOqCau+eo/aOKYCDmU2AGTGvPH4sLsO+cHZfj3
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

When you don't select CONFIG_UBSAN_TRAP, you get:

  # echo ARRAY_BOUNDS > /sys/kernel/debug/provoke-crash/DIRECT
[  102.265827] ================================================================================
[  102.278433] UBSAN: array-index-out-of-bounds in drivers/misc/lkdtm/bugs.c:342:16
[  102.287207] index 8 is out of range for type 'char [8]'
[  102.298722] ================================================================================
[  102.313712] lkdtm: FAIL: survived array bounds overflow!
[  102.318770] lkdtm: Unexpected! This kernel (5.16.0-rc1-s3k-dev-01884-g720dcf79314a ppc) was built with CONFIG_UBSAN_BOUNDS=y

It is not correct because when CONFIG_UBSAN_TRAP is not selected
you can't expect array bounds overflow to kill the thread.

Modify the logic so that when the kernel is built with
CONFIG_UBSAN_BOUNDS but without CONFIG_UBSAN_TRAP, you get a warning
about CONFIG_UBSAN_TRAP not been selected instead.

This also require a fix of pr_expected_config(), otherwise the
following error is encountered.

  CC      drivers/misc/lkdtm/bugs.o
drivers/misc/lkdtm/bugs.c: In function 'lkdtm_ARRAY_BOUNDS':
drivers/misc/lkdtm/bugs.c:351:2: error: 'else' without a previous 'if'
  351 |  else
      |  ^~~~

Fixes: c75be56e35b2 ("lkdtm/bugs: Add ARRAY_BOUNDS to selftests")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Fix pr_expected_config(), otherwise it can't be used in an if/else sequence.
---
 drivers/misc/lkdtm/bugs.c  | 5 ++++-
 drivers/misc/lkdtm/lkdtm.h | 5 ++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index f21854ac5cc2..0f4dd9621b75 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -346,7 +346,10 @@ void lkdtm_ARRAY_BOUNDS(void)
 	kfree(not_checked);
 	kfree(checked);
 	pr_err("FAIL: survived array bounds overflow!\n");
-	pr_expected_config(CONFIG_UBSAN_BOUNDS);
+	if (IS_ENABLED(CONFIG_UBSAN_BOUNDS))
+		pr_expected_config(CONFIG_UBSAN_TRAP);
+	else
+		pr_expected_config(CONFIG_UBSAN_BOUNDS);
 }
 
 void lkdtm_CORRUPT_LIST_ADD(void)
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index f508096e8fd9..9c21a4ca0482 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -8,15 +8,14 @@
 
 extern char *lkdtm_kernel_info;
 
-#define pr_expected_config(kconfig)				\
-{								\
+#define pr_expected_config(kconfig)	do {			\
 	if (IS_ENABLED(kconfig)) 				\
 		pr_err("Unexpected! This %s was built with " #kconfig "=y\n", \
 			lkdtm_kernel_info);			\
 	else							\
 		pr_warn("This is probably expected, since this %s was built *without* " #kconfig "=y\n", \
 			lkdtm_kernel_info);			\
-}
+} while (0)
 
 #ifndef MODULE
 int lkdtm_check_bool_cmdline(const char *param);
-- 
2.35.1

