Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC94D4075
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 05:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbiCJE4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 23:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiCJE4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:56:06 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6250A129BA3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 20:55:06 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id kk16so3723764qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 20:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7DpcR7BbS2KJBWXW5bKxdKwq/AyT8/ycEETpvFi3+q4=;
        b=eHo0ZYmR1wKXLCCdmUZtW/7DX5+UeImzDfDPkasTpU+zdcCiIqOKzNtRp31z+lmomD
         Tlxb1qCglzN1bk1clJ72tSdy6IXiWdF3x8mAez+wENMikz94fayDsUea78MfbonFMcc2
         3jbycTJHZJ42mzjZG/7KBTkRIFrXSgF0e/jdrlW6QDPPc1d3nwQHFOW6gBXVimvpoFvr
         C3PztTW6MxRUc3Xc/UOF6rFn7+GvDfVagbuZU6PoyKylTMHHbsJ9ckBuej9rE9X1tVKn
         f23yeyyJJ6Jstb4Fz04+RPvDZx6FfjxpCe/TtjuuD2l6+qPtmkONHiZc+wGEdAPU9ISt
         gOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7DpcR7BbS2KJBWXW5bKxdKwq/AyT8/ycEETpvFi3+q4=;
        b=SNtJFOhYg4AroFOU8celSQNIwSAzPOJNquR1ml58Fxanyx9Q4evzg3FrTsjhjm2lHR
         wpX64hZUZbWy9upBkxXv36hYF/sLPIPibm7cHuz+jckNioNwDr+slPIXrNtiDXHi6z60
         Hz/cSQ9cLYTFk9J8e9JslrNfM2ZpKmYsO4aRKftYMfKuRSSOKgqhTLVwYn6Hyyfb3FZ6
         pNrYV18naVrRaFe6CaWbiMRrFmSimkSaV12oh7dmx4NnrMiZwvN7noXWK4EoMny+M219
         ktL5b8jZOUlCTL0rvowAl9YnP5CZqM1kQmhIOHYkrB8a8ViR8Fg96iY0gzwO5e4H9iUr
         sjpw==
X-Gm-Message-State: AOAM533GYDHvmJWSsKp33RW/W/8+ZnONUh2aOPaR0XFLCno+et7yi7kL
        ckEq+NFMYx9IHX9UGy30jGg=
X-Google-Smtp-Source: ABdhPJxgmBJMeeB/xbBPvS98wubJqB33GyOxMmJTV+7zR/TCbgXuo6wBQevETyckwBSXaY01DUR/mQ==
X-Received: by 2002:ad4:5941:0:b0:433:75f:8627 with SMTP id eo1-20020ad45941000000b00433075f8627mr2397754qvb.122.1646888105521;
        Wed, 09 Mar 2022 20:55:05 -0800 (PST)
Received: from vultr.guest ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id c18-20020ac87dd2000000b002dd53a5563dsm2747749qte.25.2022.03.09.20.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 20:55:05 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] riscv: ftrace: no need to acquire text_mutex when executed in stop_machine
Date:   Thu, 10 Mar 2022 12:54:54 +0800
Message-Id: <20220310045454.672097-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's safe to patch text segment in stop_machine. No race is possible here.
Besides, there is a false positive for the lock assertion in
patch_insn_write() since the lock is not held by cpu migration thread.

So we actually don't need our ftrace_arch_code_modify_prepare/post(). And
the lock assertion in patch_insn_write() should be removed to avoid
producing lots of false positive warnings.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 arch/riscv/kernel/ftrace.c | 16 ++--------------
 arch/riscv/kernel/patch.c  | 12 +++++-------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4716f4cdc038..381ecdae4ea5 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -12,18 +12,6 @@
 #include <asm/patch.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
-{
-	mutex_lock(&text_mutex);
-	return 0;
-}
-
-int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
-{
-	mutex_unlock(&text_mutex);
-	return 0;
-}
-
 static int ftrace_check_current_call(unsigned long hook_pos,
 				     unsigned int *expected)
 {
@@ -136,9 +124,9 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 {
 	int out;
 
-	ftrace_arch_code_modify_prepare();
+	mutex_lock(&text_mutex);
 	out = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
-	ftrace_arch_code_modify_post_process();
+	mutex_unlock(&text_mutex);
 
 	return out;
 }
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 0b552873a577..b7c5dea70924 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -49,19 +49,17 @@ static void patch_unmap(int fixmap)
 }
 NOKPROBE_SYMBOL(patch_unmap);
 
+/*
+ * Before reaching here, unless executed by stop_machine, it was
+ * expected to lock the text_mutex already which could ensure that
+ * it was safe between each cores.
+ */
 static int patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	void *waddr = addr;
 	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
 	int ret;
 
-	/*
-	 * Before reaching here, it was expected to lock the text_mutex
-	 * already, so we don't need to give another lock here and could
-	 * ensure that it was safe between each cores.
-	 */
-	lockdep_assert_held(&text_mutex);
-
 	if (across_pages)
 		patch_map(addr + len, FIX_TEXT_POKE1);
 
-- 
2.25.1

