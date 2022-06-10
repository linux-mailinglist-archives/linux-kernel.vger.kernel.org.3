Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5C3547022
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349408AbiFJXhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350784AbiFJXgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C62290BCF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so6014197b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c2CIP9lJW3Vwk5QL6viVMvuyWt16DF+L+Hkpp3NHFPU=;
        b=bZ0OwARdGc3yu8CswzfT+1uQ6TcGmp1AR/m1+MAFrKy37VbeoHqWN4ZXuy7LkPp7D+
         FDmJFl/mZmgSREzzUNarX0PhaWe0cRxh46RzI9WvN5gFuTRWabOKhtlGV3v1xePxwNU+
         qWf5OkYVxmYyHD7fbiyxlqaTuhls0/3Xvims4ZjiTf649xL9NryzLpQLw96MAtUzmzgd
         /VweRNmEe08BkfrTtgryJL56gtCVFt2xeCCJvTTmrHe62eKfSPtMacqwEFncv9tJeWAR
         f33zRw8XryiGdqTxGisO1fsoa99c+RLTNe/z8Z9/SmjulnrcdevMsW/NHF8oe4AkLXlj
         ZCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c2CIP9lJW3Vwk5QL6viVMvuyWt16DF+L+Hkpp3NHFPU=;
        b=47SyO3bKx1NvjQv10he7Qsx/ktnqzpoRVHmXoYrQTRPWffuRycmFuOJ/J72yw/B220
         4ahs28d568E1lsvvdQ1HCLgbtQJodEnSRas/AhAPnsUw1JPEx2ioMo5C60t7QtM3U2mY
         /1kRtE4WrU3a+whxfSwHSHWbyym3wYF6ugxP+1MSchrWi97sHil66scrEaSpYk22fOQe
         7S9anZEsqDQKl9VCsuN9QXcY515o/Qsb1uVq4o7wRS1a+xpo2UdPKVpxy0sqqK5Mr4iQ
         d0NBiMy4xA5jfoh2/qSP3iDNym3b6+lEM78rnKg3vKpywdHfBd/tVvC2M56Re8MjUB1Y
         Aufw==
X-Gm-Message-State: AOAM531GizgEhupbkI+lHYLxsEejROkorIpDYDv7U/nYBgPZ4Y1eCHEe
        Vy8mHzYCDcRkGqdVlqI/VYdeoNVKLS4RBKL4+Vc4qX6OyGYXrPav39gw6+TBaNQYNNHLidXs4+c
        bPxaDAvPuPB0NNf8QuB8iG6Y20kQW95NWf2sbYHzkHbdcwNZFmP1fat1YFI4y7NGVmz5VexTaiG
        4xXhvJHNexDQ==
X-Google-Smtp-Source: ABdhPJzbLjbgBkiT7ukd1d/Nm2vzD579Psp0PgoL3wD0GPfrTh6ciaa1jHBKL7NVGhlMo4aiyWjAedJH7pKBZesYTqU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a5b:982:0:b0:63e:7d7e:e2f2 with SMTP
 id c2-20020a5b0982000000b0063e7d7ee2f2mr44757278ybq.549.1654904146897; Fri,
 10 Jun 2022 16:35:46 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:06 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2540; h=from:subject;
 bh=wkxTracRlh48gJXB/sqV6igwxwar57UIoToIvjngLK8=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9UuxPblg4Uoded/YFk1E0wzoSbYH57F/K8/DM+S
 r1qJ8O6JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLgAKCRBMtfaEi7xW7rY/C/
 4m/NOSBpwS0Czw/rZryoUepjdULMbzlVZDXNI27hhZMA63z8eMpozt3+ZW/D0tiuzcAUVGcaodI08b
 S6UpbNtPb+dQ1HWqeDj5jIEVXUt5IytXnHQfT8ygUin8anKc0V79P4Tzz4dyM1lOs8NgXH/OziIhbK
 LxQZFid9wKx35uD/iVHVtVMzjB8Y6xOUMH3R9x2iKBFoHtzuicfledhljWW7RVSsnuL3+9OD7jOmkl
 JCeTQ2IyZMOvaP9A+oXOxAbLf79bs1+a/IFWldHwUMPFSHkOPRPlaRRC4PD89HDhYumL9sJvsS70rZ
 MK5OWPrVCi4qfhYXQU8hi0F54skmllftnoDVL79ukfhZAksebFSxjPLrCGfBAEMfwmC6hrc+nJ9MPQ
 oFY8wvdD6Zo2R7bmBMYQVY55UyE1VvdU5S/UY237DWflo1b/Q/pa1Zp+gbKLMYaP0Q8I7cjsoK3DIy
 B//tJN9fdzFinWYpnVwZLbolnTKtnXMh6uck7H3DDeukM=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 13/20] treewide: Drop WARN_ON_FUNCTION_MISMATCH
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 544fd4097406..19d446f4e3a9 100644
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
index 4056f2a3f9d5..2fed7bb018a7 100644
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
2.36.1.476.g0c4daa206d-goog

