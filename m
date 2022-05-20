Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EECA52F3C3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiETT1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiETT1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:27:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08BB18629D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:27:46 -0700 (PDT)
Received: from zn.tnic (p200300ea974657be329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57be:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BE0D1EC0426;
        Fri, 20 May 2022 21:27:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653074865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=+RYiv3PFxO/YJSRE9ylxIA88+11elBPDb5u7knl7jco=;
        b=CMuNlyNg4Il2UYPqEUil+lFGCHe7PlP6fK8Ktv9WHJDEI8t9YfvlSpELt7KvDjz1+C4Pku
        f62D9aFMbflqzxE8m6k16YsAxyMq0F+RMbRXdeU0YOGIjfyJricpU0dv97eB77IhP7b8Af
        JzdJXluJ1mNrBJMCxA8GU9kS+wSOrL8=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/extable: Annotate ex_handler_msr_mce() as a dead end
Date:   Fri, 20 May 2022 21:27:29 +0200
Message-Id: <20220520192729.23969-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Fix

  vmlinux.o: warning: objtool: fixup_exception+0x2d6: unreachable instruction

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/extable.h | 4 ++--
 tools/objtool/check.c          | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index 155c991ba95e..6ac53e98fff4 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -42,9 +42,9 @@ extern int ex_get_fixup_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
 
 #ifdef CONFIG_X86_MCE
-extern void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr);
+extern void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr);
 #else
-static inline void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr) { }
+static inline void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr) { }
 #endif
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_X86_64)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 190b2f6e360a..c23e46c4a882 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -185,7 +185,8 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"do_group_exit",
 		"stop_this_cpu",
 		"__invalid_creds",
-               "cpu_startup_entry",
+		"cpu_startup_entry",
+		"ex_handler_msr_mce",
 	};
 
 	if (!func)
-- 
2.35.1

