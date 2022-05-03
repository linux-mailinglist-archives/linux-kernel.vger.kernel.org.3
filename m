Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B8A517C32
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 05:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiECDYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 23:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiECDY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 23:24:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18AF35255
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 20:20:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso974162pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 20:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xotWSQoi2wlC3vMI8lQ8RpO96nR6JNjKt6GYA46wjrE=;
        b=j2TkGrSUFai8FQ8ertrRrE8Ty6ZPlVq1zCXtVp+22pyjlvLpM7dE7qX6I+rdhB8I32
         Z4T+adbpQ3dtQJMCuFGFf4Oig+WmhCOI//Se09Q4L4fmiTimRII7dclbz0/haNaYHlsE
         NMHlx1+8ORo0wu/APD+tMPNoVXaaAqJh+cXCSdcAOLiTAp5OoY76FJ8f4jjljHuDB/ML
         yjHJ8ZuEYlLhvaEeVwDkrWyp9TnGmcBQMOgRv1FQGGxUit7cGzXx+QsqgDAyaBHHAJ36
         Ic3ubzDoUpyX8c1mjUV13OUdwMj4jfC5Hr4ZckXWAl6kyZ0QyIsqRrUyhXGJsv2KHAiW
         1XCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xotWSQoi2wlC3vMI8lQ8RpO96nR6JNjKt6GYA46wjrE=;
        b=nL/7bp4Wd62cLEyQ9NGfjWhmxqX0jVrZa58JA6I3sxknVREOuh/Wlr45IMSXeV/jXO
         DOdTBOx8f2jUBKeOn0k/us1krZyidsfLFOFrhgTzPHWAYZ13bP+QnoOdNI7+PAbvdokt
         E8FGMHoNuLdeXWl958CGc4wKWT7bS9KLmvYlHZWsrrlxu89M59V781geVekhwehJVogt
         5NRnvxujLUlcW8xd75WwPUCsKpixEDO4L+ONGGtIT1+FNN+dRDkyM/VyfjIDXX1jMc4m
         r6fpPG7llje9ZP0dKvALSDmVfBPp0nNNzYUZT8X4slOgd2N7WjmUSfiFO9FEzNWGmxGA
         AcAA==
X-Gm-Message-State: AOAM530i1nLhNnjEQzEMI94muhVkJdiYqQPBJr/5BjmH6GlcDp6mHFkn
        /NjUawmJdthmLCfVRrirWLN/RcoFTdo=
X-Google-Smtp-Source: ABdhPJzmp6UBaLfASoGK81unwVdXeaJ+Sk4uU9HjWwtSBuFgFdJH66RGjL9tXeLPF7LkY2H8y7aMkw==
X-Received: by 2002:a17:902:f684:b0:15e:8c4a:c54b with SMTP id l4-20020a170902f68400b0015e8c4ac54bmr14463764plg.21.1651548058099;
        Mon, 02 May 2022 20:20:58 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902f60500b0015e8d4eb206sm5392698plg.80.2022.05.02.20.20.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 20:20:57 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V7 4/6] x86/entry: Move cld to the start of idtentry macro
Date:   Tue,  3 May 2022 11:21:05 +0800
Message-Id: <20220503032107.680190-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220503032107.680190-1-jiangshanlai@gmail.com>
References: <20220503032107.680190-1-jiangshanlai@gmail.com>
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

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Make it next to CLAC

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b1cef3b0a7ab..ab6ab6d3dab5 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -371,6 +371,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ENDBR
 	ASM_CLAC
+	cld
 
 	.if \has_error_code == 0
 		pushq	$-1			/* ORIG_RAX: no syscall to restart */
@@ -439,6 +440,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
+	cld
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
 
@@ -495,6 +497,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
+	cld
 
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
@@ -557,6 +560,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ENDBR
 	ASM_CLAC
+	cld
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
@@ -882,7 +886,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
@@ -1000,7 +1003,6 @@ SYM_CODE_END(paranoid_exit)
  */
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
-	cld
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1134,6 +1136,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	ASM_CLAC
+	cld
 
 	/* Use %rdx as our temp variable throughout */
 	pushq	%rdx
@@ -1153,7 +1156,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	swapgs
-	cld
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-- 
2.19.1.6.gb485710b

