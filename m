Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CAA509D50
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388211AbiDUKOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388131AbiDUKNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:13:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A0E1A5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so4750591pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VxZux9BdzX/r+vazMsFAOpjkFd5uZiNaQDWJenis350=;
        b=LDIF1fzxOKHhl/FoV+IMx/1IhqC/0rv6y6Nhi+tB1GwQUno4ZTj6+fhoWrL2J+EPeR
         OA11O1oQ1oaSAGBvuVIAvPhIs3Tu3RtWSYp2JkWSvmgEPu6EVD7oMEgl4m9/njZmGI11
         syQrMN/zklIA85R/DIQkdbfNprv3/VLNoIR/7ZX0VM/3o+czMt3d99Iqw/7q6OcQV0Sd
         xnYb994yx5FfsBdtDiXIFaGdjhE9dWbcinTS4eIaB8BTfv8wcS7Bwho7csNkc0GZAO4k
         HrrnVnciqUaAdPZFO2AeshzxOYpYFsjbFm66gAay2RFuJnL6GdGHV5Wk+uzOjkyUfV7X
         DZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VxZux9BdzX/r+vazMsFAOpjkFd5uZiNaQDWJenis350=;
        b=N1r7ozAZi68/gOHemi/KOiV29j07YiBknjzk0mtG6uT64XBiPiQ6ER8au8611fyuJ+
         AbfNgcCMhr4eO+1kCDcN7p0Mq6lZtqVBeFxnQuE3zh+OJdmfmpaJ5mJ78zeePeaKcntL
         jwrC8cZ23gtbZAxoQCrKtqDrcdwpjDH+WQeeICnluQUPD/sSJI0j+9eUXZO5H5ktql+M
         vkD17TCNLWBjwfendDuH7zk2k9C9H5g5Cicnox8Cin1QzOmtUxQj49lChbuiM/L0cqoJ
         vt0OMlGuVrL8X9bxBtHbARt0K/R/SnHUM60Bm4qn4mZ60LDoeIXxLLlVTVMNoIaIaMiI
         Le1w==
X-Gm-Message-State: AOAM532Hr/xw5+7MuBHjEO9381MdTBs1L9dqb+R4XTropAsYYlq0+yMu
        pwHD6dOtVeBRqf4ssE+NoLtEyPdWgABM0YEI
X-Google-Smtp-Source: ABdhPJy7UPcmP1vlczwNIWMgrOXHcllTCABZ2O7TEblNpI50IuDBUx/aqKMbKmcOPPao4NPvdF6W9w==
X-Received: by 2002:a17:902:8487:b0:158:f82d:e39e with SMTP id c7-20020a170902848700b00158f82de39emr20126943plo.52.1650535866191;
        Thu, 21 Apr 2022 03:11:06 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:df13:3d47:8c92:6576])
        by smtp.gmail.com with ESMTPSA id w196-20020a6282cd000000b0050ada022940sm2407806pfd.183.2022.04.21.03.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:11:05 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 08/10] xtensa: merge SAVE_CP_REGS_TAB and LOAD_CP_REGS_TAB
Date:   Thu, 21 Apr 2022 03:10:31 -0700
Message-Id: <20220421101033.216394-9-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421101033.216394-1-jcmvbkbc@gmail.com>
References: <20220421101033.216394-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both tables share the same offset field but the different function
pointers. Merge them into single table with 3-element entries to reduce
code and data duplication.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:

- new patch

 arch/xtensa/kernel/coprocessor.S | 85 ++++++++++++++------------------
 1 file changed, 37 insertions(+), 48 deletions(-)

diff --git a/arch/xtensa/kernel/coprocessor.S b/arch/xtensa/kernel/coprocessor.S
index 8bcbabbff38a..af11ddaa8c5f 100644
--- a/arch/xtensa/kernel/coprocessor.S
+++ b/arch/xtensa/kernel/coprocessor.S
@@ -33,15 +33,6 @@
 		ret;							\
 	.endif
 
-#define SAVE_CP_REGS_TAB(x)						\
-	.if XTENSA_HAVE_COPROCESSOR(x);					\
-		.long .Lsave_cp_regs_cp##x;				\
-	.else;								\
-		.long 0;						\
-	.endif;								\
-	.long THREAD_XTREGS_CP##x
-
-
 #define LOAD_CP_REGS(x)							\
 	.if XTENSA_HAVE_COPROCESSOR(x);					\
 		.align 4;						\
@@ -50,14 +41,19 @@
 		ret;							\
 	.endif
 
-#define LOAD_CP_REGS_TAB(x)						\
+#define CP_REGS_TAB(x)							\
 	.if XTENSA_HAVE_COPROCESSOR(x);					\
+		.long .Lsave_cp_regs_cp##x;				\
 		.long .Lload_cp_regs_cp##x;				\
 	.else;								\
-		.long 0;						\
+		.long 0, 0;						\
 	.endif;								\
 	.long THREAD_XTREGS_CP##x
 
+#define CP_REGS_TAB_SAVE 0
+#define CP_REGS_TAB_LOAD 4
+#define CP_REGS_TAB_OFFSET 8
+
 	__XTENSA_HANDLER
 
 	SAVE_CP_REGS(0)
@@ -79,25 +75,15 @@
 	LOAD_CP_REGS(7)
 
 	.align 4
-.Lsave_cp_regs_jump_table:
-	SAVE_CP_REGS_TAB(0)
-	SAVE_CP_REGS_TAB(1)
-	SAVE_CP_REGS_TAB(2)
-	SAVE_CP_REGS_TAB(3)
-	SAVE_CP_REGS_TAB(4)
-	SAVE_CP_REGS_TAB(5)
-	SAVE_CP_REGS_TAB(6)
-	SAVE_CP_REGS_TAB(7)
-
-.Lload_cp_regs_jump_table:
-	LOAD_CP_REGS_TAB(0)
-	LOAD_CP_REGS_TAB(1)
-	LOAD_CP_REGS_TAB(2)
-	LOAD_CP_REGS_TAB(3)
-	LOAD_CP_REGS_TAB(4)
-	LOAD_CP_REGS_TAB(5)
-	LOAD_CP_REGS_TAB(6)
-	LOAD_CP_REGS_TAB(7)
+.Lcp_regs_jump_table:
+	CP_REGS_TAB(0)
+	CP_REGS_TAB(1)
+	CP_REGS_TAB(2)
+	CP_REGS_TAB(3)
+	CP_REGS_TAB(4)
+	CP_REGS_TAB(5)
+	CP_REGS_TAB(6)
+	CP_REGS_TAB(7)
 
 /*
  * Entry condition:
@@ -125,13 +111,12 @@ ENTRY(fast_coprocessor)
 	rsr	a2, depc
 	s32i	a2, a1, PT_AREG2
 
-	/*
-	 * The hal macros require up to 4 temporary registers. We use a3..a6.
-	 */
+	/* The hal macros require up to 4 temporary registers. We use a3..a6. */
 
 	s32i	a4, a1, PT_AREG4
 	s32i	a5, a1, PT_AREG5
 	s32i	a6, a1, PT_AREG6
+	s32i	a7, a1, PT_AREG7
 
 	/* Find coprocessor number. Subtract first CP EXCCAUSE from EXCCAUSE */
 
@@ -148,6 +133,12 @@ ENTRY(fast_coprocessor)
 	wsr	a0, cpenable
 	rsync
 
+	/* Get coprocessor save/load table entry (a7). */
+
+	movi	a7, .Lcp_regs_jump_table
+	addx8	a7, a3, a7
+	addx4	a7, a3, a7
+
 	/* Retrieve previous owner. (a3 still holds CP number) */
 
 	movi	a0, coprocessor_owner	# list of owners
@@ -167,10 +158,8 @@ ENTRY(fast_coprocessor)
 	 * (a4 still holds previous owner (thread_info), a3 CP number)
 	 */
 
-	movi	a5, .Lsave_cp_regs_jump_table
-	addx8	a3, a3, a5		# a3: coprocessor number
-	l32i	a2, a3, 4		# a2: xtregs offset
-	l32i	a3, a3, 0		# a3: jump address
+	l32i	a2, a7, CP_REGS_TAB_OFFSET
+	l32i	a3, a7, CP_REGS_TAB_SAVE
 	add	a2, a2, a4
 	callx0	a3
 
@@ -188,15 +177,14 @@ ENTRY(fast_coprocessor)
 
 	/* Get context save area and call load routine. */
 
-	movi	a5, .Lload_cp_regs_jump_table
-	addx8	a3, a3, a5
-	l32i	a2, a3, 4		# a2: xtregs offset
-	l32i	a3, a3, 0		# a3: jump address
+	l32i	a2, a7, CP_REGS_TAB_OFFSET
+	l32i	a3, a7, CP_REGS_TAB_LOAD
 	add	a2, a2, a4
 	callx0	a3
 
 	/* Restore all registers and return from exception handler. */
 
+	l32i	a7, a1, PT_AREG7
 	l32i	a6, a1, PT_AREG6
 	l32i	a5, a1, PT_AREG5
 	l32i	a4, a1, PT_AREG4
@@ -232,13 +220,14 @@ ENTRY(coprocessor_flush)
 	abi_entry(4)
 
 	s32i	a0, a1, 0
-	movi	a0, .Lsave_cp_regs_jump_table
-	addx8	a3, a3, a0
-	l32i	a4, a3, 4
-	l32i	a3, a3, 0
-	add	a2, a2, a4
-	beqz	a3, 1f
-	callx0	a3
+	movi	a4, .Lcp_regs_jump_table
+	addx8	a4, a3, a4
+	addx4	a3, a3, a4
+	l32i	a4, a3, CP_REGS_TAB_SAVE
+	beqz	a4, 1f
+	l32i	a3, a3, CP_REGS_TAB_OFFSET
+	add	a2, a2, a3
+	callx0	a4
 1:	l32i	a0, a1, 0
 
 	abi_ret(4)
-- 
2.30.2

