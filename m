Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DC64FBFB0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347563AbiDKO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiDKO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:59:01 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDBB17059
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:56:45 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KcX4X0kSMz9sTy;
        Mon, 11 Apr 2022 16:56:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C4HA8KL1UI-r; Mon, 11 Apr 2022 16:56:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KcX4W74KJz9sTw;
        Mon, 11 Apr 2022 16:56:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E091A8B76E;
        Mon, 11 Apr 2022 16:56:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gVNm8j7ZB0BX; Mon, 11 Apr 2022 16:56:43 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CA9488B763;
        Mon, 11 Apr 2022 16:56:43 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 23BEuYej960585
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 16:56:34 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 23BEuY1X960584;
        Mon, 11 Apr 2022 16:56:34 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] lkdtm/bugs: Don't expect thread termination without CONFIG_UBSAN_TRAP
Date:   Mon, 11 Apr 2022 16:56:33 +0200
Message-Id: <7c2d2a48034223a95cf4346c5a2255a0b9b25670.1649688637.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1649688992; l=1739; s=20211009; h=from:subject:message-id; bh=jwwWohV7yXLmpOMeCedag6V2XJ7SIl+kvTa8YLVpcy8=; b=tWrWBXicWW82s2WSQlaOA1OwPXdEW/U0fcBhz5uqRFwK1Hvc7kA0rD8I3YSFAvnQ5ZnV6LXW3qXB PGObulx9CejDfOP37YFauBxdJ9Bd+fQvjp2QybAKjPHOc8E9WHy4
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

Fixes: c75be56e35b2 ("lkdtm/bugs: Add ARRAY_BOUNDS to selftests")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/misc/lkdtm/bugs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
-- 
2.35.1

