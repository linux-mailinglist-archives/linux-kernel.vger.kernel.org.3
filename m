Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839545395C5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346760AbiEaR7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245246AbiEaR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:59:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CDF8A33B
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:59:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f8398e99dcso121200197b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=43It4tY6rrOkbTtcYBE6N6l07cvQ+0q2w708BzUCfdQ=;
        b=cXZh0iB2YUeKYWSq/DnFCdl8EfWrduss4aKiLDcCamYQxpSehyBOr4Mc2Id9+hCYIK
         pk3kI/d2LS9MbBzExeYMvn/w+d4BmVB0YXSZ+skDu8gCDQ3DefzaGupJW4tsBoH/0Tg+
         itlbwwf2hGrxNFki2bplHtgCS3/hLVA8ID0F6auJlQRpeiZQCF8S7rUif4r9upjflXJL
         tta6rNIuKi3PgSzLcLV7gdpXYPxvnG4I6+k00Zk93DDHs0fuyQHXktG7wVbOX3zpHbqC
         rMlQDftQ/vo1M9BEP+YAucYerbdaEQaRjqsL2EpO/thbKjx2KFc7UlCDU1haZRZ2U9Vu
         luaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=43It4tY6rrOkbTtcYBE6N6l07cvQ+0q2w708BzUCfdQ=;
        b=Fv36H2E+0b8D9gWVCH8OwHfkF43WNC6ZGVokbwo8rvC2TVgQ+5p654Ozs4QGHWHyWK
         8Z9i09su24v+es5whinPXYamhOnJV8N9uAfDvZwy6XAWgcx7T2qWwZcgPVY7KXiyL0Gc
         6MVqSeLm4bdL9P+TcP7a8PDmTkh4yUOFwtAlPMT+62RgqnR3ZhD7+q9Jphd/3Iipu7Az
         L8PY8r9qA7LDPAU41+m5VFaLsYMOcIEma/mWU/tCklzYS2B6xbMoJYDlOqN/vR1gl/D3
         S0shJrTl8MJtuMmPVB9VPWyUzHNhXIKAe0NNZ67aXcsXRu7IOuArV8Cs9RV35QsOga4D
         c+XQ==
X-Gm-Message-State: AOAM532cGAuvc60jFxg2HB1F5choYGLECwqRJnQ/KSdwRCc+P+NqKls6
        SB0+lzt+QGe19jEoIi3VvF7aAmTFXBC+fF8bhoI=
X-Google-Smtp-Source: ABdhPJzYg2PfrP7VAcOIhffi51zcFsynl9sjjnou+I9ggql8TYO0BMoIPH151gDfL/0kxSkXR0y1Lgi6goCkxQD9zNE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:1067:12fc:51e8:95dc])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:13c2:b0:641:b6d:a151 with
 SMTP id y2-20020a05690213c200b006410b6da151mr59039298ybu.348.1654019955516;
 Tue, 31 May 2022 10:59:15 -0700 (PDT)
Date:   Tue, 31 May 2022 10:59:10 -0700
Message-Id: <20220531175910.890307-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; h=from:subject;
 bh=3APPK7JF94JGhsLYsP/k0BDbTWmcKvSdC5cUDwc7HEc=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBilldu8L6b8RrGC/uxYEv0Gt9ac9FJ70jAIdFrFvYx
 EHOOhWyJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYpZXbgAKCRBMtfaEi7xW7kl4C/
 sGCz2eKwsUVqQBfjgycK9T1O2Q00Tu+HFofNAQbx4mkHJHNeWBFRwG6hwpCmtJsW1AQhMexHawitij
 pRuOxuW5Ao3CKRsq7h1iSypEEHTZS/6XWLZ4UxwcSb92I77OqdviGLpbXPcLemLi/A9xHEY8qGF59K
 1I/dRgW2S2WNN/JKkJAmD2dGFd5o5rQ7VNSzkyE1DKve/bllIIPEenvR5Wep0d8UsmTmIlGzgIeceM
 e/ChPrDIOk5qG+Wu+IU8w7j3qutB0PEBfQ4q87dg2S1ig0AuZM+26vIplp3oRylAQXIVPDgFkRntua
 HCXqLh35oofnfgIshwTLivkIn6qKnQLkl0QTxTR0yaCSodf/LxrbqP2rMFFHKW4/Ez8KfYrbyTYKIi
 oYTzkdFvZILF1O7dNfDPlCfOWVDM8lu6KcdQjRJxGi88gu/WOymYVreOEvQCadOf161KxVBiPmrsba
 XlOq1MdW5ZjjeDMHq020MIhgpTiSklSjuh41GqNOyeM/w=
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH] cfi: Fix __cfi_slowpath_diag RCU usage with cpuidle
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU_NONIDLE usage during __cfi_slowpath_diag can result in an invalid
RCU state in the cpuidle code path:

  WARNING: CPU: 1 PID: 0 at kernel/rcu/tree.c:613 rcu_eqs_enter+0xe4/0x138
  ...
  Call trace:
    rcu_eqs_enter+0xe4/0x138
    rcu_idle_enter+0xa8/0x100
    cpuidle_enter_state+0x154/0x3a8
    cpuidle_enter+0x3c/0x58
    do_idle.llvm.6590768638138871020+0x1f4/0x2ec
    cpu_startup_entry+0x28/0x2c
    secondary_start_kernel+0x1b8/0x220
    __secondary_switched+0x94/0x98

Instead, call rcu_irq_enter/exit to wake up RCU only when needed and
disable interrupts for the entire CFI shadow/module check when we do.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/cfi.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/cfi.c b/kernel/cfi.c
index 9594cfd1cf2c..08102d19ec15 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -281,6 +281,8 @@ static inline cfi_check_fn find_module_check_fn(unsigned long ptr)
 static inline cfi_check_fn find_check_fn(unsigned long ptr)
 {
 	cfi_check_fn fn = NULL;
+	unsigned long flags;
+	bool rcu_idle;
 
 	if (is_kernel_text(ptr))
 		return __cfi_check;
@@ -290,13 +292,21 @@ static inline cfi_check_fn find_check_fn(unsigned long ptr)
 	 * the shadow and __module_address use RCU, so we need to wake it
 	 * up if necessary.
 	 */
-	RCU_NONIDLE({
-		if (IS_ENABLED(CONFIG_CFI_CLANG_SHADOW))
-			fn = find_shadow_check_fn(ptr);
+	rcu_idle = !rcu_is_watching();
+	if (rcu_idle) {
+		local_irq_save(flags);
+		rcu_irq_enter();
+	}
+
+	if (IS_ENABLED(CONFIG_CFI_CLANG_SHADOW))
+		fn = find_shadow_check_fn(ptr);
+	if (!fn)
+		fn = find_module_check_fn(ptr);
 
-		if (!fn)
-			fn = find_module_check_fn(ptr);
-	});
+	if (rcu_idle) {
+		rcu_irq_exit();
+		local_irq_restore(flags);
+	}
 
 	return fn;
 }
-- 
2.36.1.255.ge46751e96f-goog

