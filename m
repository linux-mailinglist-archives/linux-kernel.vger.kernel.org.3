Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0171D5A9606
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiIALuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiIALtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:49:24 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268C513A7CE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:49:24 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MJK7z2XFgz9spJ;
        Thu,  1 Sep 2022 13:49:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dI9fUUuuIjIG; Thu,  1 Sep 2022 13:49:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MJK7t3Fhkz9spM;
        Thu,  1 Sep 2022 13:48:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 530978B78C;
        Thu,  1 Sep 2022 13:48:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WGUP9WX4_YwN; Thu,  1 Sep 2022 13:48:58 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.131])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B69D68B787;
        Thu,  1 Sep 2022 13:48:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 281Bmrcu1768897
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 13:48:54 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 281BmrFF1768896;
        Thu, 1 Sep 2022 13:48:53 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, sv@linux.ibm.com,
        bgray@linux.ibm.com, agust@denx.de, jpoimboe@kernel.org,
        peterz@infradead.org, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, chenzhongjin@huawei.com
Subject: [PATCH v3 5/6] powerpc: Prepare arch_static_call_transform() for supporting inline static calls
Date:   Thu,  1 Sep 2022 13:48:24 +0200
Message-Id: <634f62e54c30a66f59534f9203d8efd396570b2b.1662032631.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1662032631.git.christophe.leroy@csgroup.eu>
References: <cover.1662032631.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662032901; l=2315; s=20211009; h=from:subject:message-id; bh=v818iNsphGuqENkFhVx9ll1kxCYkbm5RmUNxbFzbxBc=; b=vg0iK+sEatw1urtjXmd/2J1SpaP7lUKcIK9iUR/QioDNb6vvtzcZFmytEur6l9GbhyREsBRGqjiZ 13K4uT6qBTevscGPx09ZCjVVXtrAaKN1Daj3cb6UJKJ+apIRAiNa
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

Reorganise arch_static_call_transform() in order to ease the support
of inline static calls in following patch:
- remove 'target' to nhide whether it is a 'return 0' or not.
- Don't bail out if 'tramp' is NULL, just do nothing until next patch.

Note that 'target' was 'tramp + PPC_SCT_RET0', is_short was perforce
true. So in the 'if (func && !is_short)' leg, target was perforce
equal to 'func'.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: New. Split out of following patch.
---
 arch/powerpc/kernel/static_call.c | 36 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/static_call.c b/arch/powerpc/kernel/static_call.c
index 863a7aa24650..97765b9e1c5b 100644
--- a/arch/powerpc/kernel/static_call.c
+++ b/arch/powerpc/kernel/static_call.c
@@ -8,26 +8,32 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
 	int err;
 	bool is_ret0 = (func == __static_call_return0);
-	unsigned long target = (unsigned long)(is_ret0 ? tramp + PPC_SCT_RET0 : func);
-	bool is_short = is_offset_in_branch_range((long)target - (long)tramp);
-
-	if (!tramp)
-		return;
+	unsigned long _tramp = (unsigned long)tramp;
+	unsigned long _func = (unsigned long)func;
+	unsigned long _ret0 = _tramp + PPC_SCT_RET0;
+	bool is_short = is_offset_in_branch_range((long)func - (long)(site ? : tramp));
 
 	mutex_lock(&text_mutex);
 
-	if (func && !is_short) {
-		err = patch_instruction(tramp + PPC_SCT_DATA, ppc_inst(target));
-		if (err)
-			goto out;
+	if (tramp) {
+		if (func && !is_short) {
+			err = patch_instruction(tramp + PPC_SCT_DATA, ppc_inst(_func));
+			if (err)
+				goto out;
+		}
+
+		if (!func)
+			err = patch_instruction(tramp, ppc_inst(PPC_RAW_BLR()));
+		else if (is_ret0)
+			err = patch_branch(tramp, _ret0, 0);
+		else if (is_short)
+			err = patch_branch(tramp, _func, 0);
+		else
+			err = patch_instruction(tramp, ppc_inst(PPC_RAW_NOP()));
+	} else {
+		err = 0;
 	}
 
-	if (!func)
-		err = patch_instruction(tramp, ppc_inst(PPC_RAW_BLR()));
-	else if (is_short)
-		err = patch_branch(tramp, target, 0);
-	else
-		err = patch_instruction(tramp, ppc_inst(PPC_RAW_NOP()));
 out:
 	mutex_unlock(&text_mutex);
 
-- 
2.37.1

