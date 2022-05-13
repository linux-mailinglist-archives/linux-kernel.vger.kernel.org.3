Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F8E52665D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiEMPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbiEMPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:42:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22FD2409F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:42:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dk23so16993103ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gTvT1Njz7DvJoj6oJmGxwAJ3l74LLHxTpiRWi5YeMEs=;
        b=EcALLeSkYxkKn0Wiet+U+DUHYshlagRqJJCh+HvzSZcVLz7z8IA4NP2fUQJSYnCJpy
         M08vs5nu1mQftUPSfuHwVIfiSCia13X+PqKtF3OGygz4THbwXXcwlJjD6iPSELy1WDu8
         5DG6v7UPYsfAWejFbDvJ1PUR5NPRrK5suSR48G0TGRUU8qNwQ82eMoWHMN8XAS8MDjDo
         Odc7x8+n2I4JW2juGndQuKmBrWFccLzYQUDBn5ii3DDZM0LdvvfF4gMYr0PXOBBPYe0P
         5pf9JeGFRHon5uGvyTVgXJ7V8dvQSLT0cq9NkD3MX5lBljd/fPZpSCzdV4YfhHCR9JQC
         gbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTvT1Njz7DvJoj6oJmGxwAJ3l74LLHxTpiRWi5YeMEs=;
        b=ZM/htv0PHeSapQv8j7+jtw7hkjC5WBrwmVQuFcTqY2lmGH4k3tEpinZwb0Hy7pwfVa
         8i7tks4yxVtkf4zL1UpBx4tmYhdEHi2Ki5uC3yZG0q9ZaRQFdJ51JwQAiR2QeDAlTm6D
         EDzY/NNV7V/I9nyoT3Dkck9WrJt2ErNHxiY/zIkDhNEvP996uW6zuMrDDNh1oviK+lht
         h5Kb1oe0Wud0il+QTGFa827wMzlmtXQ48Ox0uVV5BDJVPd2Cx4F/japAL7wyYVrpMzLL
         RWIru+FFOG1dWOE2Pk4405dFM2nC8QbnU1TuW9bs8DTbMa9yic9mTz8vmGK7+TFYq11s
         gwwg==
X-Gm-Message-State: AOAM533PR8GN8WZNjGhM+QKR2pMwHLnPn1tFRWJTC4ZiK+gOEZPT/RtH
        m5Sd8fvxHMzOzumy8stkJKM=
X-Google-Smtp-Source: ABdhPJz0Ht2W3NN/AnII61buYrRZgbAx8k4/SwrpaTpWaYlVv8nPqV9cCvl9HmYHcJwCOKWl/JjIKw==
X-Received: by 2002:a17:906:6a16:b0:6f4:63ae:76c with SMTP id qw22-20020a1709066a1600b006f463ae076cmr4690738ejc.705.1652456522218;
        Fri, 13 May 2022 08:42:02 -0700 (PDT)
Received: from octofox.metropolis ([178.134.103.46])
        by smtp.gmail.com with ESMTPSA id h16-20020a1709066d9000b006f3ef214e73sm848313ejt.217.2022.05.13.08.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:42:01 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/2] xtensa: add trap handler for division by zero
Date:   Fri, 13 May 2022 08:41:50 -0700
Message-Id: <20220513154151.4135905-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513154151.4135905-1-jcmvbkbc@gmail.com>
References: <20220513154151.4135905-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add c-level handler for the division by zero exception and kill the task
if it was thrown from the kernel space or send SIGFPE otherwise.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/traps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index d3e91ceb0775..7c7c4c7b33bb 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -49,6 +49,7 @@
  */
 
 static void do_illegal_instruction(struct pt_regs *regs);
+static void do_div0(struct pt_regs *regs);
 static void do_interrupt(struct pt_regs *regs);
 #if XTENSA_FAKE_NMI
 static void do_nmi(struct pt_regs *regs);
@@ -95,7 +96,7 @@ static dispatch_init_table_t __initdata dispatch_init_table[] = {
 #ifdef SUPPORT_WINDOWED
 { EXCCAUSE_ALLOCA,		USER|KRNL, fast_alloca },
 #endif
-/* EXCCAUSE_INTEGER_DIVIDE_BY_ZERO unhandled */
+{ EXCCAUSE_INTEGER_DIVIDE_BY_ZERO, 0,	   do_div0 },
 /* EXCCAUSE_PRIVILEGED unhandled */
 #if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION
 #ifdef CONFIG_XTENSA_UNALIGNED_USER
@@ -307,6 +308,11 @@ static void do_illegal_instruction(struct pt_regs *regs)
 	force_sig(SIGILL);
 }
 
+static void do_div0(struct pt_regs *regs)
+{
+	__die_if_kernel("Unhandled division by 0 in kernel", regs, SIGKILL);
+	force_sig_fault(SIGFPE, FPE_INTDIV, (void __user *)regs->pc);
+}
 
 /*
  * Handle unaligned memory accesses from user space. Kill task.
-- 
2.30.2

