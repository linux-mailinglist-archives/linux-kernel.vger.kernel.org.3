Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F10A4CE987
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 07:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiCFGqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 01:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiCFGqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 01:46:17 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639ED5520E;
        Sat,  5 Mar 2022 22:45:25 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o23so10954082pgk.13;
        Sat, 05 Mar 2022 22:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zp9QIUhBG8OJ8x8CE4qO1HhBpaKE+3Che/Qmp0Ai6ko=;
        b=REQkqHxdITNVnOCWzGsTiQNSXvvXNkJTV+EUOygAERP4xNm1Ql4y05mDbvLKWL4f/U
         2SpXin/D0WaC2/ICGpZ9OWkBlKetshYPUVLqif0LpxfFlTBtk/49ad9oLsP28wnVSWQO
         /wPQP2yCgL7Y/ieNuD9ElbG6cPlglxiHFVj+3pGP1Lq41e0P3rqZ9qHspxLY0TcMYnQC
         R1Wyd4pks3og8iFbkPXlVkZcGd72wkHRmcS6CfnBnJuMguag6Amvl9S8HqLqHLPVeQdV
         U0ZyU8NESW5uq9Ly+kICiIqnDyqxAEShjaI1h8sKl7U3NEpS6s6idP90AHG7wli3I3St
         e5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zp9QIUhBG8OJ8x8CE4qO1HhBpaKE+3Che/Qmp0Ai6ko=;
        b=5hzI9xqbVp7CHytFajA7L58YIYdKfRF6qoeweYWVbP/YK44UII6gyYdLPKAHIaBM7w
         RYWZwwIxAvCu+zh3SPbqWI2x3fXRTmlK7CbmISqDZePlu0Nk2J1XymAVDN5jcoOxVmEu
         cbilmdZzu1l7/BlwIB+bDD2pCWMQoZKjBhKnYoGLYAZ/t1sCe9zayZpzFOKkXyp3wQpq
         9LM8C53uHzZbb98rquAk42QtUng0GrHSz5Ga5VFobwZcqEqPc+tuD75SqHeBemtQtLBU
         99MqJBlHApPQ8nAH8ZNcdZSIXN7nGj7n9ZWQMLGFmAXxc0TPlzN/hlOkQHElrxqkaOJV
         agJQ==
X-Gm-Message-State: AOAM531RU6TxmKaicyKPAjVgF4bOlqLecf0EipkjlgEa0qjjZUs3E3WT
        IO4x3L32/JtZSlHPiL2vBSc=
X-Google-Smtp-Source: ABdhPJzoLTMh64KfZAjnVf2ShWlrVil6iQL0UvGQlmJEk2oq/DSbszs2UzjmQkZzm/tRE4Hi8M1iJQ==
X-Received: by 2002:a05:6a00:1687:b0:4e1:45d:3ded with SMTP id k7-20020a056a00168700b004e1045d3dedmr7211330pfc.0.1646549124892;
        Sat, 05 Mar 2022 22:45:24 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:dcdb:d868:b18f:a9a8])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm12229047pfw.188.2022.03.05.22.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 22:45:24 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/2] xtensa: use XCHAL_NUM_AREGS as pt_regs::areg size
Date:   Sat,  5 Mar 2022 22:44:35 -0800
Message-Id: <20220306064435.256328-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220306064435.256328-1-jcmvbkbc@gmail.com>
References: <20220306064435.256328-1-jcmvbkbc@gmail.com>
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

struct pt_regs is used to access both kernel and user exception frames.
User exception frames may contain up to XCHAL_NUM_AREG registers that
task creation and signal delivery code may access, but pt_regs::areg
array has only 16 entries that cover only the kernel exception frame.
This results in the following build error:

arch/xtensa/kernel/process.c: In function 'copy_thread':
arch/xtensa/kernel/process.c:262:52: error: array subscript 53 is above
           array bounds of 'long unsigned int[16]' [-Werror=array-bounds]
  262 |                                 put_user(regs->areg[caller_ars+1],

Change struct pt_regs::areg size to XCHAL_NUM_AREGS so that it covers
the whole user exception frame. Adjust task_pt_regs and drop additional
register copying code from copy_thread now that the whole user exception
stack frame is copied.

Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/ptrace.h |  7 +++----
 arch/xtensa/kernel/process.c     | 10 ----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/ptrace.h
index b109416dc07e..308f209a4740 100644
--- a/arch/xtensa/include/asm/ptrace.h
+++ b/arch/xtensa/include/asm/ptrace.h
@@ -44,6 +44,7 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/coprocessor.h>
+#include <asm/core.h>
 
 /*
  * This struct defines the way the registers are stored on the
@@ -77,14 +78,12 @@ struct pt_regs {
 	/* current register frame.
 	 * Note: The ESF for kernel exceptions ends after 16 registers!
 	 */
-	unsigned long areg[16];
+	unsigned long areg[XCHAL_NUM_AREGS];
 };
 
-#include <asm/core.h>
-
 # define arch_has_single_step()	(1)
 # define task_pt_regs(tsk) ((struct pt_regs*) \
-	(task_stack_page(tsk) + KERNEL_STACK_SIZE - (XCHAL_NUM_AREGS-16)*4) - 1)
+	(task_stack_page(tsk) + KERNEL_STACK_SIZE) - 1)
 # define user_mode(regs) (((regs)->ps & 0x00000020)!=0)
 # define instruction_pointer(regs) ((regs)->pc)
 # define return_pointer(regs) (MAKE_PC_FROM_RA((regs)->areg[0], \
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index bd80df890b1e..e8bfbca5f001 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -232,10 +232,6 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 		p->thread.ra = MAKE_RA_FOR_CALL(
 				(unsigned long)ret_from_fork, 0x1);
 
-		/* This does not copy all the regs.
-		 * In a bout of brilliance or madness,
-		 * ARs beyond a0-a15 exist past the end of the struct.
-		 */
 		*childregs = *regs;
 		childregs->areg[1] = usp;
 		childregs->areg[2] = 0;
@@ -265,14 +261,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 			childregs->wmask = 1;
 			childregs->windowstart = 1;
 			childregs->windowbase = 0;
-		} else {
-			int len = childregs->wmask & ~0xf;
-			memcpy(&childregs->areg[XCHAL_NUM_AREGS - len/4],
-			       &regs->areg[XCHAL_NUM_AREGS - len/4], len);
 		}
 
-		childregs->syscall = regs->syscall;
-
 		if (clone_flags & CLONE_SETTLS)
 			childregs->threadptr = tls;
 	} else {
-- 
2.30.2

