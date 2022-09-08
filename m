Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81735B28C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIHV46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiIHV4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:56:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AD1109019
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d82-20020a25e655000000b006a8fc4506c0so10696057ybh.18
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=rhfWVw2Tt6GniVljFSWWIZP6qvrP1Bt+EpFQklJviQg=;
        b=rBEPQ4+OEMorFD29QkedGsA5RpGHUqTP7GLuQ0VPeUKArjbKJU8SW+fxXED2Vd5a1h
         JJUUSU520wi2pjhCxnuq64qsHd7eeRMOLTOxRcJREUzEeMCnZffzC9Sejn5br6Dp3oRI
         VtYNY/fx0j2QmFk6XksNtrBgzLzZc7TZuBNeE1R7P3dhP8AW0152lJLseebduBWoGVwY
         56ZWPGa+w9Poid6Sqb4ezZ8XSDwmza2TOXUIpjx5plHpJsxzs8aTSsCu3tvyVQfzL4Yq
         +vz6teO2Y1xnr+a4/sJVXBA8aGm7OpXVW/b+4LPfwoav6RhVJFXhZfDrJxw8jeUR7dLb
         c0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=rhfWVw2Tt6GniVljFSWWIZP6qvrP1Bt+EpFQklJviQg=;
        b=UW78jfz+9y4F4Dd2jlBbdyTbhphBz4lnisf3CcEo30oCR+GU5g8/ms4xGQWU74XVp9
         s+u0Vlcq5KmkOWMJNkyKdwhsH3mtypgXN0zcgNuFHz3L8gPy82GGCrsOFQhfZU8/QUjG
         sqhqrUFdkZsSqprMFrZjSaGe3IQhCRrG5UCEDsUCmx4t60NCuGrzqIuWPKL3m4wwNUK1
         AehKqbFMaFvUrvX0VOnpJyPUCeNg9YTcmofTXw7QQLvUwjGOymS8SWYZytkOnZMey0pm
         kzbb6FRpG/66RyVjTcTKDaN0NiHtALzi4IUQY9QUi9lY+yNTqZG8Wy4Z5SUTjan18PLa
         2S+w==
X-Gm-Message-State: ACgBeo2FHJB9Y1FrnlagRNU8Hv9j0kD9St9bvKPVxMZvOni0y9jYUT4B
        3MO5WM1kGIxD8xilfYWc5muwCSc3dOEYGDWGFLUXdXNvAfGitMfMGgZ4swUUkoPrR+P8hM7yoAS
        bC5sG6oX3tzPNx2Lh6dqY1WhPnB7+0/1ddTeA2SHdJOXNavCz/vVw1RGjv1qL48mPz2m6CfXz1V
        f5z6K2VwPHJg==
X-Google-Smtp-Source: AA6agR4VEuPwY0OLtERuEFUSCoro8TKqIchnXzuH3Fn0GxKp01Y7VKyK5nLSYCSe8NlEN8Re6tpG69iiBtglmydYWFk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a81:a055:0:b0:345:1b99:ed4e with SMTP
 id x82-20020a81a055000000b003451b99ed4emr9315882ywg.328.1662674143700; Thu,
 08 Sep 2022 14:55:43 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:56 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2636; i=samitolvanen@google.com;
 h=from:subject; bh=w7QGhX+Lm2u0dGfo5IkCUJxEEQABg5P9ss63DNtvmfM=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS1pTQ7rbPML1xK3u3MyRnli2UqPoMtOjmJxcUm
 IFPo2WSJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktQAKCRBMtfaEi7xW7l+3C/
 9AJdP32IFBSwJ7l2Qym+RBRnr2ygFJQYgT1jNXFKJ9xpuJIadyULM6tlc8ytuNOwFEV+GZmK7GAUzY
 fl9ZCj5ZBpeNQD2a9xAEEqKgTyWFYTNcMoGQo5PiHm7rWb5AQ+nvPPnf85/qKp+rwgzULwfVIld+eD
 FWRTqltYYgZAzgpZYfOCpRrGPOaqR9In1p9rLuyY8Be1/2J1L+Ee1GwtSs/sWW+AlnQ8ZzJs9qrK2m
 dLb084sArMyaehwUYetynBFE7OB75y2bxXFJ/xThRF8muTmxxh5kabj/uKOqaSE+fcD0ozIZQlmtlt
 g+T3ZgD3tKdwL16ckdrWO4h/QV4q9xl4kwT1DrUyt+PRxclovxjt//IUNblQ6qc6zbvpt9Oa6qk4p3
 YF0hXH2cZQ27IY2KxWq2Yux8LPDHQFIsN1eSOo1TZ5eh14FO8rq8Caf8fkJ6NmCKZVh+AZ0d+fW1r6
 kNPtER09RCEOJgr553VIBlOmBbi0KAwQohDMzytED2ld8=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 14/22] treewide: Drop WARN_ON_FUNCTION_MISMATCH
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
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

CONFIG_CFI_CLANG no longer breaks cross-module function address
equality, which makes WARN_ON_FUNCTION_MISMATCH unnecessary. Remove
the definition and switch back to WARN_ON_ONCE.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 include/asm-generic/bug.h | 16 ----------------
 kernel/kthread.c          |  3 +--
 kernel/workqueue.c        |  2 +-
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index ba1f860af38b..4050b191e1a9 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -220,22 +220,6 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 # define WARN_ON_SMP(x)			({0;})
 #endif
 
-/*
- * WARN_ON_FUNCTION_MISMATCH() warns if a value doesn't match a
- * function address, and can be useful for catching issues with
- * callback functions, for example.
- *
- * With CONFIG_CFI_CLANG, the warning is disabled because the
- * compiler replaces function addresses taken in C code with
- * local jump table addresses, which breaks cross-module function
- * address equality.
- */
-#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_MODULES)
-# define WARN_ON_FUNCTION_MISMATCH(x, fn) ({ 0; })
-#else
-# define WARN_ON_FUNCTION_MISMATCH(x, fn) WARN_ON_ONCE((x) != (fn))
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3c677918d8f2..28a6b7ab4a0f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1050,8 +1050,7 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	struct timer_list *timer = &dwork->timer;
 	struct kthread_work *work = &dwork->work;
 
-	WARN_ON_FUNCTION_MISMATCH(timer->function,
-				  kthread_delayed_work_timer_fn);
+	WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
 
 	/*
 	 * If @delay is 0, queue @dwork->work immediately.  This is for
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aeea9731ef80..16df315d2a3d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1651,7 +1651,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work = &dwork->work;
 
 	WARN_ON_ONCE(!wq);
-	WARN_ON_FUNCTION_MISMATCH(timer->function, delayed_work_timer_fn);
+	WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
 	WARN_ON_ONCE(timer_pending(timer));
 	WARN_ON_ONCE(!list_empty(&work->entry));
 
-- 
2.37.2.789.g6183377224-goog

