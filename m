Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC204D957D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345564AbiCOHlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345595AbiCOHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:41:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899874B436
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:39:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s8so18262617pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F47NijhW68SKqc1BYAUjtn551pZ33aNYyOQgE9AVSDc=;
        b=fqKS6i+KlVpg6+nqo4tBqUZmUTLYnarlbnbmEjnoWzXn9GwJstTgZCknaGOx0PdjEf
         jAOWt58SOCSf/dlNN+cNPCdi3/TUlf1dG5l3j4Tq0Ja67LcW63n3+LvdwiOrbaRu5Go6
         RlqrmRY1QmqEwJNxk3yORt44s5yulSzTXPS5O7MZOLkG5lh3p+k7gdcy7e976Xw9GbZ1
         JfaYFiT3S1Qw3j3CJeORhWvy7UMzBlDir1ONT7MshL87BlqPSEE7qMVq+mBohBs65avh
         yWokbe4qjXxzhv8FDIER5vrn/3ge7Lt/bqkfFsILk3qRwXcrl550gp3dgrvVZ+VYxWwu
         ZaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F47NijhW68SKqc1BYAUjtn551pZ33aNYyOQgE9AVSDc=;
        b=DiC9N8Qxr3T5kT5SP8S8K++mz6FK0D1ZGTysGusBIHPfnDrpoeyMiE7U+BGP+6ZkGG
         8IA0Wt4HJyA6pwlxEKnkwYgFrJb/Y6VjsMN+fFZ0gKrYeiiMN6h19ns2d/ddoODrQ7MA
         O3e7WGVp66RFaxqUuyXzn+RpJPHujzaq3bQyODtgVfKBM2YvKN+QxZCeOmDTVi+tIVgy
         FpiO85JYTZ2tRZmL2D6cvnBU2f0p/w5Q+rljRW7SEPf8EoPMPLL78GXwlPJBpQdjtV9U
         XzTiU0a0N+5zdHUb16UH4Wi7/Hnv6Vs6H61zoq2VabyUpaAtxZUTbDhThQUEbaYDZLpl
         jJoQ==
X-Gm-Message-State: AOAM532xWDek2cBDbkygJhmqXpByWIrBUbVILU32WHrl0wfNIu1BOKq3
        5nvrDYJ1bOb9MiP2CBLSt9Xh7roq/bE=
X-Google-Smtp-Source: ABdhPJwaLUUAyeBa1DbtwyyQJmWkAUxohn03gbxPjCJO9/soJ6AfgeEnYpzW2l0yw0aBE5ap2madoQ==
X-Received: by 2002:a65:6794:0:b0:36c:460e:858d with SMTP id e20-20020a656794000000b0036c460e858dmr22949141pgr.418.1647329992887;
        Tue, 15 Mar 2022 00:39:52 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id k14-20020a056a00134e00b004f83f05608esm4044796pfu.31.2022.03.15.00.39.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2022 00:39:52 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 6/7] x86/entry: Don't call error_entry for XENPV
Date:   Tue, 15 Mar 2022 15:39:48 +0800
Message-Id: <20220315073949.7541-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220315073949.7541-1-jiangshanlai@gmail.com>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
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

When in XENPV, it is already in the task stack, and it can't fault
for native_iret() nor native_load_gs_index() since XENPV uses its own
pvops for iret and load_gs_index().  And it doesn't need to switch CR3.
So there is no reason to call error_entry() in XENPV.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e4a07276fd1c..ec885c2107de 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -328,8 +328,17 @@ SYM_CODE_END(ret_from_fork)
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
-	call	error_entry
-	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
+	/*
+	 * Call error_entry and switch stack settled by sync_regs().
+	 *
+	 * When in XENPV, it is already in the task stack, and it can't fault
+	 * for native_iret() nor native_load_gs_index() since XENPV uses its
+	 * own pvops for iret and load_gs_index().  And it doesn't need to
+	 * switch CR3.  So it can skip invoking error_entry().
+	 */
+	ALTERNATIVE "call error_entry; movq %rax, %rsp", \
+		"", X86_FEATURE_XENPV
+
 	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
-- 
2.19.1.6.gb485710b

