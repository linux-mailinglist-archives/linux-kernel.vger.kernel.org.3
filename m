Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08144CE985
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 07:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiCFGq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 01:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiCFGqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 01:46:15 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F1C55756;
        Sat,  5 Mar 2022 22:45:24 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 6so6437416pgg.0;
        Sat, 05 Mar 2022 22:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vn86MqaNE+8bzgojaUINglDz6clTYZ9LAosUzacL80A=;
        b=YwBiiZ7I+E85ORti/PYYYhjPsIDGufl9k/7Wz8fEqsppI+xugtWhet1WCcRLgV4ZSJ
         xwhiCzkwiEAQKalDcMsnBA6zZAzNaMImMCitjlGxZvgqsqIMYLL/Inu7gOyOrYvqjdgy
         zfv59kp8Ysk4c1G21uF7aPfPKTT7FNPPmBNS2kh5GP03vlcw81StSSzoAiJWl4YCUZcZ
         08XNivWE4/f2GDSiOiPtkITviGISlKed+KQMfO4CeFdiRv+sPHxqEQoFpK1oC9YlkHKe
         lvzoJTM8EtKYM7BsXKMGR6wKeIZsPhAfPpm6f4KNxsiXONss8iXJjbrB0CpyNffp0fvk
         xVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vn86MqaNE+8bzgojaUINglDz6clTYZ9LAosUzacL80A=;
        b=PWNk3p7EvXrWGCsDdj3bhASrNLZxNKpaHSIVHCzuNDQ7DJ2tNiw6NJjU3yRVUWtDA1
         OEHOhrAaMNhqceSkKVPLyAX5hVtkPkwIlKSvU2dX0UXbqycIzpLBaAldFrPiMwFjCODF
         nJTu1JtjZAtcVmIYnRb512B/8BhGt1HMDPKR16mFxuiKWX/vtNqb+jjZT5PS+eAPDLcR
         9ladK2O6UXcMQEKpANN9svZcumex1Yotaz7+Chfs9oJXoQ7n8lY3tXlEiJdshyFV4kTu
         i08sxkyXrGgH2m3cJH15W8B8t7Do0O7vIMnZ6qhIrA8qg5aDRxffaASq5tLh0ylu1Q8l
         pvoQ==
X-Gm-Message-State: AOAM532nM04wM5lG19mqfkLrnu9iYHT+Xx21p+ye11LF1yag8Te5XROj
        IyrkXSgnsZ95o3uIOvqFxKc=
X-Google-Smtp-Source: ABdhPJwlrD1njWvf7o8plAZAQF8uzPMwTsHIgRlSwPp5PehtjyHLkrtmSX+lz0vbr2eZxEKo9Lh2jQ==
X-Received: by 2002:a63:5756:0:b0:36c:67bc:7f3f with SMTP id h22-20020a635756000000b0036c67bc7f3fmr5190429pgm.389.1646549123605;
        Sat, 05 Mar 2022 22:45:23 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:dcdb:d868:b18f:a9a8])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm12229047pfw.188.2022.03.05.22.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 22:45:23 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/2] xtensa: rename PT_SIZE to PT_KERNEL_SIZE
Date:   Sat,  5 Mar 2022 22:44:34 -0800
Message-Id: <20220306064435.256328-2-jcmvbkbc@gmail.com>
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

PT_SIZE is used by the xtensa port to designate kernel exception frame
size. In preparation for struct pt_regs size change rename PT_SIZE to
PT_KERNEL_SIZE for clarity and change its definition to always cover
only the kernel exception frame.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/asm-offsets.c |  2 +-
 arch/xtensa/kernel/entry.S       | 14 +++++++-------
 arch/xtensa/kernel/vectors.S     |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/xtensa/kernel/asm-offsets.c b/arch/xtensa/kernel/asm-offsets.c
index f1fd1390d069..37278e2785fb 100644
--- a/arch/xtensa/kernel/asm-offsets.c
+++ b/arch/xtensa/kernel/asm-offsets.c
@@ -63,7 +63,7 @@ int main(void)
 	DEFINE(PT_AREG15, offsetof (struct pt_regs, areg[15]));
 	DEFINE(PT_WINDOWBASE, offsetof (struct pt_regs, windowbase));
 	DEFINE(PT_WINDOWSTART, offsetof(struct pt_regs, windowstart));
-	DEFINE(PT_SIZE, sizeof(struct pt_regs));
+	DEFINE(PT_KERNEL_SIZE, offsetof(struct pt_regs, areg[16]));
 	DEFINE(PT_AREG_END, offsetof (struct pt_regs, areg[XCHAL_NUM_AREGS]));
 	DEFINE(PT_USER_SIZE, offsetof(struct pt_regs, areg[XCHAL_NUM_AREGS]));
 	DEFINE(PT_XTREGS_OPT, offsetof(struct pt_regs, xtregs_opt));
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index a1029a5b6a1d..77a7c8da3ff5 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -341,8 +341,8 @@ KABI_W	_bbsi.l	a2, 3, 1f
 	/* Copy spill slots of a0 and a1 to imitate movsp
 	 * in order to keep exception stack continuous
 	 */
-	l32i	a3, a1, PT_SIZE
-	l32i	a0, a1, PT_SIZE + 4
+	l32i	a3, a1, PT_KERNEL_SIZE
+	l32i	a0, a1, PT_KERNEL_SIZE + 4
 	s32e	a3, a1, -16
 	s32e	a0, a1, -12
 #endif
@@ -706,12 +706,12 @@ kernel_exception_exit:
 	addi    a0, a1, -16
 	l32i    a3, a0, 0
 	l32i    a4, a0, 4
-	s32i    a3, a1, PT_SIZE+0
-	s32i    a4, a1, PT_SIZE+4
+	s32i    a3, a1, PT_KERNEL_SIZE + 0
+	s32i    a4, a1, PT_KERNEL_SIZE + 4
 	l32i    a3, a0, 8
 	l32i    a4, a0, 12
-	s32i    a3, a1, PT_SIZE+8
-	s32i    a4, a1, PT_SIZE+12
+	s32i    a3, a1, PT_KERNEL_SIZE + 8
+	s32i    a4, a1, PT_KERNEL_SIZE + 12
 
 	/* Common exception exit.
 	 * We restore the special register and the current window frame, and
@@ -821,7 +821,7 @@ ENTRY(debug_exception)
 
 	bbsi.l	a2, PS_UM_BIT, 2f	# jump if user mode
 
-	addi	a2, a1, -16-PT_SIZE	# assume kernel stack
+	addi	a2, a1, -16 - PT_KERNEL_SIZE	# assume kernel stack
 3:
 	l32i	a0, a3, DT_DEBUG_SAVE
 	s32i	a1, a2, PT_AREG1
diff --git a/arch/xtensa/kernel/vectors.S b/arch/xtensa/kernel/vectors.S
index 407ece204e7c..1073fe4a584d 100644
--- a/arch/xtensa/kernel/vectors.S
+++ b/arch/xtensa/kernel/vectors.S
@@ -88,7 +88,7 @@ ENDPROC(_UserExceptionVector)
  * Kernel exception vector. (Exceptions with PS.UM == 0, PS.EXCM == 0)
  *
  * We get this exception when we were already in kernel space.
- * We decrement the current stack pointer (kernel) by PT_SIZE and
+ * We decrement the current stack pointer (kernel) by PT_KERNEL_SIZE and
  * jump to the first-level handler associated with the exception cause.
  *
  * Note: we need to preserve space for the spill region.
@@ -100,7 +100,7 @@ ENTRY(_KernelExceptionVector)
 
 	xsr	a3, excsave1		# save a3, and get dispatch table
 	wsr	a2, depc		# save a2
-	addi	a2, a1, -16-PT_SIZE	# adjust stack pointer
+	addi	a2, a1, -16 - PT_KERNEL_SIZE	# adjust stack pointer
 	s32i	a0, a2, PT_AREG0	# save a0 to ESF
 	rsr	a0, exccause		# retrieve exception cause
 	s32i	a0, a2, PT_DEPC		# mark it as a regular exception
-- 
2.30.2

