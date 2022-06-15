Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2195D54CD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344676AbiFOPl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343666AbiFOPlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:41:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB682E69F;
        Wed, 15 Jun 2022 08:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0413B81FCF;
        Wed, 15 Jun 2022 15:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E576EC341C0;
        Wed, 15 Jun 2022 15:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655307712;
        bh=EAA3Azn3zkhFS/Ot5emXZhUefpbKo+kEHuUwCMH0LPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4UipNLrp3WNMHucHUuifh15FEX/nllQKBJlZEuZWpeXYLM8douoREw5JSNcVLuKJ
         LaBME81wPi7GoNxz+7mMktLGgySyigflsedq2/ns8wztfg4Iho0Uc49r3dED3YFbF9
         zKpUcJa117dHI8kEydatzJsfXst13R97F/r1HpU5jn5FbmjJikEJvpNrLbA2ULYlrl
         ZZuTjMq+wbpb7oNIfikrYk+SIohsXC8uyaGDPnMycXd1JVzpZLIAzjSw9xPJdLqj4B
         rON0UzFO2OhKyDJarTOz7XiBmt213Qrz4hwrkMzG7qQ4+s+NlPRZX5RaDCMMKOfdxl
         P3JCPzoTKdQaQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 1/3] jump_label: s390: avoid pointless initial NOP patching
Date:   Wed, 15 Jun 2022 17:41:40 +0200
Message-Id: <20220615154142.1574619-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220615154142.1574619-1-ardb@kernel.org>
References: <20220615154142.1574619-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3163; h=from:subject; bh=EAA3Azn3zkhFS/Ot5emXZhUefpbKo+kEHuUwCMH0LPE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiqf2xG1ymoBz9IKMWz3MwIADl1yxGlpyR56uL9VFy ai6CpXuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqn9sQAKCRDDTyI5ktmPJHtHC/ 0U81hqfZSWk33aswA9H9jfe168v0moIpOEXskVMC7qfkvsjXU0K9Bn8P5Pxnmgr6gB+mTkua6B+FxN qy9WosoDrqWkaFaZRR/BeJIBTVH+k71eNXbb1ZF1A9c1Hty523HD6NoO1lS/mtrgs7YClhFI3e/JHT CXrQ7oewn0W/Y0VdqxaLQ1e1XedCuQIveGqFvYvmek+q7p4jueu+iAeQARkyM+Z2CtG9tOwHw/f8XJ BYBLccAUQELO0ALQKvoZYUag0pdrYZE5qjFtgf0PEdxHeTiPp0RiW2tVTPywEnKrrd8t6TywScLHXN AhtymQTrcWI6dXEa6XkVWD4a/nTRl5Q+qfCTLR2VvgywkZsRxUREU4CxOXN6a710i3X+aIq1ktEyZP VX6hLOsZqdcisIcoc/oaVx+CSb6q5Xsz9cIXb6sLbkcJV5pfMyCzktkqRpQIroRXtKQUcCUi3jmFW3 D5hWJVu+5DHJf8Zm1i99LkKPs1t5cy6fGgOGbE2CAHNKk=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patching NOPs into other NOPs at boot time serves no purpose, so let's
use the same NOP encodings at compile time and runtime.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/s390/include/asm/jump_label.h |  5 ++---
 arch/s390/kernel/jump_label.c      | 23 +++++---------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 916cfcb36d8a..895f774bbcc5 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -10,7 +10,6 @@
 #include <linux/stringify.h>
 
 #define JUMP_LABEL_NOP_SIZE 6
-#define JUMP_LABEL_NOP_OFFSET 2
 
 #ifdef CONFIG_CC_IS_CLANG
 #define JUMP_LABEL_STATIC_KEY_CONSTRAINT "i"
@@ -21,12 +20,12 @@
 #endif
 
 /*
- * We use a brcl 0,2 instruction for jump labels at compile time so it
+ * We use a brcl 0,<offset> instruction for jump labels so it
  * can be easily distinguished from a hotpatch generated instruction.
  */
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl	0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
+	asm_volatile_goto("0:	brcl 0,%l[label]\n"
 			  ".pushsection __jump_table,\"aw\"\n"
 			  ".balign	8\n"
 			  ".long	0b-.,%l[label]-.\n"
diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index 6bec000c6c1c..d764f0d229ab 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -44,14 +44,8 @@ static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
 	panic("Corrupted kernel text");
 }
 
-static struct insn orignop = {
-	.opcode = 0xc004,
-	.offset = JUMP_LABEL_NOP_OFFSET >> 1,
-};
-
 static void jump_label_transform(struct jump_entry *entry,
-				 enum jump_label_type type,
-				 int init)
+				 enum jump_label_type type)
 {
 	void *code = (void *)jump_entry_code(entry);
 	struct insn old, new;
@@ -63,27 +57,22 @@ static void jump_label_transform(struct jump_entry *entry,
 		jump_label_make_branch(entry, &old);
 		jump_label_make_nop(entry, &new);
 	}
-	if (init) {
-		if (memcmp(code, &orignop, sizeof(orignop)))
-			jump_label_bug(entry, &orignop, &new);
-	} else {
-		if (memcmp(code, &old, sizeof(old)))
-			jump_label_bug(entry, &old, &new);
-	}
+	if (memcmp(code, &old, sizeof(old)))
+		jump_label_bug(entry, &old, &new);
 	s390_kernel_write(code, &new, sizeof(new));
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
-	jump_label_transform(entry, type, 0);
+	jump_label_transform(entry, type);
 	text_poke_sync();
 }
 
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
 				     enum jump_label_type type)
 {
-	jump_label_transform(entry, type, 0);
+	jump_label_transform(entry, type);
 	return true;
 }
 
@@ -95,6 +84,4 @@ void arch_jump_label_transform_apply(void)
 void __init_or_module arch_jump_label_transform_static(struct jump_entry *entry,
 						       enum jump_label_type type)
 {
-	jump_label_transform(entry, type, 1);
-	text_poke_sync();
 }
-- 
2.35.1

