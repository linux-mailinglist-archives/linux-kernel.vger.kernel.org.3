Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82755509D51
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388194AbiDUKOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388126AbiDUKNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:13:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2294CC27
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso7320605pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Y9Xga+Vf57beXiQKhYl2BdatYUIL77DBx/0ziFkle0=;
        b=JAZkFfJ7+0JGkIeYyVaeB4LmiW1XmZaU1cmKe9i/k7EtpF4WNVWAe+hmsZtaqwDuuJ
         cQPTRZ9jeBGZs4CE9oC/1fUOZ1YmuMXCY2KuUaSwPrEK8ogBw27qVe/kMNx6Z0pU8tXE
         qp+opEdKWZu84NT+UiVddz0MQa8WRKrFDx8pguYw6eC33C64paxkTleeLgmLQpNrOOgV
         VesmXJwKStxbpeGvktVyD4k10LP2nGwzbMjQc2Z4XRUwooUIjHKQuqfYsHWykeWEdn6W
         DF2MqLmkcjuiD74Z73OaVUp2vzH/cqxv1o3eEcP5+WocHhYbQ+vR+nQ5MOrN0I8l39eJ
         NbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Y9Xga+Vf57beXiQKhYl2BdatYUIL77DBx/0ziFkle0=;
        b=472h9yx5xlju0QnXL42YU3v0KLknNtbwg09XiOe3LkM+U6QU08CfCDIl3Zj2V2SOWI
         +vk+dW0ZfvWroU4+bv1n+XbfpaRVMBkc8j/+u3FYpKgKVgQsCQWUuvoh6JW98wHCq13l
         R3a6FyZBD3765DWY+JMo+q46QYgXE8N3tUhy+B7V2TmNqPr55NR5OxXD8rzF7bTRXPe1
         B2qHOWTKP4mARMyHcRADoZ6Eu83OcRwgbaRyH/doJ32W0+Rge0sRzPjGWCmJ1wmpLtv1
         CganNAk4wy6abLv+rP/IzAHqd3kRidoh0ttahQIrD5L5FWbozNrHwtboNkk5mIrFpsMa
         Uq4g==
X-Gm-Message-State: AOAM531R7URzv2MpGZP2f/8OeXT1JiCJ2EjdZ/k0AAsWDbiIhJaF9cFN
        +4EjsMuXd6lVI55tEqbX2rE=
X-Google-Smtp-Source: ABdhPJzDlEFinDzLXl/+1GHFwxgQ1sobpE8CWAYcP+aW02BO7FA1aci6p8DesCOcdNqYD9ybZuEBJA==
X-Received: by 2002:a17:903:2302:b0:158:cef1:79b9 with SMTP id d2-20020a170903230200b00158cef179b9mr25232476plh.64.1650535861665;
        Thu, 21 Apr 2022 03:11:01 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:df13:3d47:8c92:6576])
        by smtp.gmail.com with ESMTPSA id w196-20020a6282cd000000b0050ada022940sm2407806pfd.183.2022.04.21.03.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:11:00 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 05/10] xtensa: use callx0 opcode in fast_coprocessor
Date:   Thu, 21 Apr 2022 03:10:28 -0700
Message-Id: <20220421101033.216394-6-jcmvbkbc@gmail.com>
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

Instead of emulating call0 in fast_coprocessor use that opcode directly.
Use 'ret' instead of 'jx a0'.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/coprocessor.S | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/xtensa/kernel/coprocessor.S b/arch/xtensa/kernel/coprocessor.S
index c7b9f12896f2..8bcbabbff38a 100644
--- a/arch/xtensa/kernel/coprocessor.S
+++ b/arch/xtensa/kernel/coprocessor.S
@@ -30,7 +30,7 @@
 		.align 4;						\
 	.Lsave_cp_regs_cp##x:						\
 		xchal_cp##x##_store a2 a3 a4 a5 a6;			\
-		jx	a0;						\
+		ret;							\
 	.endif
 
 #define SAVE_CP_REGS_TAB(x)						\
@@ -47,7 +47,7 @@
 		.align 4;						\
 	.Lload_cp_regs_cp##x:						\
 		xchal_cp##x##_load a2 a3 a4 a5 a6;			\
-		jx	a0;						\
+		ret;							\
 	.endif
 
 #define LOAD_CP_REGS_TAB(x)						\
@@ -163,21 +163,20 @@ ENTRY(fast_coprocessor)
 	s32i	a5, a4, THREAD_CPENABLE
 
 	/*
-	 * Get context save area and 'call' save routine. 
+	 * Get context save area and call save routine.
 	 * (a4 still holds previous owner (thread_info), a3 CP number)
 	 */
 
 	movi	a5, .Lsave_cp_regs_jump_table
-	movi	a0, 2f			# a0: 'return' address
 	addx8	a3, a3, a5		# a3: coprocessor number
 	l32i	a2, a3, 4		# a2: xtregs offset
 	l32i	a3, a3, 0		# a3: jump address
 	add	a2, a2, a4
-	jx	a3
+	callx0	a3
 
 	/* Note that only a0 and a1 were preserved. */
 
-2:	rsr	a3, exccause
+	rsr	a3, exccause
 	addi	a3, a3, -EXCCAUSE_COPROCESSOR0_DISABLED
 	movi	a0, coprocessor_owner
 	addx4	a0, a3, a0
@@ -187,19 +186,18 @@ ENTRY(fast_coprocessor)
 1:	GET_THREAD_INFO (a4, a1)
 	s32i	a4, a0, 0
 
-	/* Get context save area and 'call' load routine. */
+	/* Get context save area and call load routine. */
 
 	movi	a5, .Lload_cp_regs_jump_table
-	movi	a0, 1f
 	addx8	a3, a3, a5
 	l32i	a2, a3, 4		# a2: xtregs offset
 	l32i	a3, a3, 0		# a3: jump address
 	add	a2, a2, a4
-	jx	a3
+	callx0	a3
 
 	/* Restore all registers and return from exception handler. */
 
-1:	l32i	a6, a1, PT_AREG6
+	l32i	a6, a1, PT_AREG6
 	l32i	a5, a1, PT_AREG5
 	l32i	a4, a1, PT_AREG4
 
-- 
2.30.2

