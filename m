Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803B9542E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbiFHKph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbiFHKp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E2DBBCC3;
        Wed,  8 Jun 2022 03:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B908E61336;
        Wed,  8 Jun 2022 10:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6051C3411D;
        Wed,  8 Jun 2022 10:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654685127;
        bh=ynyYyfkfJ6SlhYBng8HGwErHOBt9df5GswrHDhXe7mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZyVBfbNO/46P8aRTRJWgYHsaNKt85Lfx6yK2uR27gXHu31Hsn3u4GFCUnlDeWVFJ
         nZaIrl56r1KHtvyzYXtqNdP5aiUxIaP20hen8svrKQNH4fZsh1Vsmff3lkGwk3zICg
         /IeETw1talyz0JNE5ryOafk6k0AJpLHHDbZNRu/qj52H0c7JhdwyMUUJL0+aJHrLcr
         gqmslKQbarll87u7Djp4aeyWAAzj0gSNQe4RiCPygYX1GSwaCLToOIPV5WNjIjr93Q
         9xdb4XDpllKG1JKwstPZV/0daWZhi7t1LCvvKB6v5oIQovx9b0ElUwb/kqlEnGA1+I
         C+2Vmd+e2khyA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/3] jump_label: s390: avoid pointless initial NOP patching
Date:   Wed,  8 Jun 2022 12:45:10 +0200
Message-Id: <20220608104512.1176209-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608104512.1176209-1-ardb@kernel.org>
References: <20220608104512.1176209-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3163; h=from:subject; bh=ynyYyfkfJ6SlhYBng8HGwErHOBt9df5GswrHDhXe7mc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBioH2z8uiifCcodhcR3hXc8lJS1WnqKJGg+ZB6Jt0J yamDoA6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqB9swAKCRDDTyI5ktmPJMkCDA CCL23njunOCQo0qjeRP1JcvaBTrPyHc2H6HENGAEBzzOHzFqRoVI4hgYHesRdEBIy1PDNlJBBcV/Ps Kwe2cplJuBN1U0Tqw1VfP9sXZ5Zi+OusuPFOw+XgNyUXGO/cr1YQxQ4YryJ0uV4f70911SpmDgLewO DLRt1BAKDj1kLju1sPtYfi8rMIivDdwOeLPg4UynXhsYmtjkjqe6ivUUK0AUK3D2hSrz7tIfLh1ECy QD7L77R1UmK2JycGjFL3n+rfHMDgY637t56gcVSuFb5sS+QdS2DueWLoE6Z1GWS9P/RS8zjfAmrLve 3DmwvGY7AxGcZQveq+j+OJTIqxGngjsEbgqRjxL8tOW0wxC2CwYxpQa1QiH9RKqbfxK8F3GyMl1S7e eryEQo+N8Y1UyTYP7icsLp0rqYLaWpoIePjZfiC52g6nDnh4XQkZllPwq8L/bsQeE5PW5TdcCBZwYV 4QG9A3HCYfxr9ZeJZ/F5t6PoWjqUMM76uWNVRBoZeyU0M=
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
2.30.2

