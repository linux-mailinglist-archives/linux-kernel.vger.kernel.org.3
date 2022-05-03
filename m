Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40D7518CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241677AbiECTEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiECTEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:04:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9E2B266;
        Tue,  3 May 2022 12:01:06 -0700 (PDT)
Date:   Tue, 03 May 2022 19:01:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651604464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/O9baVx9hBXwJAw0Kwgt2xiQjzil3SDZg0pfPZZRWU4=;
        b=S7UkiSEnnNGFBcPRgd4SnJSpa+7QL/Q7m9XRIcqnKFc35Q2F8fgvboG6pq6vCNbzn8D5Zl
        ZXYR2ZVxWUMfEiQFGqEs124X51fah3OCTBUOhPJFef7GGDSildf08NZlHtWrX3kM2VBAbw
        IHwIYPQEDyn4D5BJLqtNykeGuGX6JAreT6sRo64wkLLngG6OLinJqxcjevjVkteomWP0VX
        D6IPjMK6/uX6pXEYc/ZcAIaIdXtDx3AwC+fUBLb5z1JlfOP5cJS3f6B70N4Qpvnyc1znKN
        6y5iKqYQH9IhaiP55JowFm1uvRzRQixFLFkYKKJ5Qqos8GLjM4bA3WwryeVm7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651604464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/O9baVx9hBXwJAw0Kwgt2xiQjzil3SDZg0pfPZZRWU4=;
        b=iLv00M/j4sh5RcXpmVZrJBNrH862IiOgy3E1WogLLgWQu0Y7pJdcX3ByVbB3AKhL1qspHD
        TrizeCekP5m3jRDA==
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Don't call error_entry() for XENPV
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Borislav Petkov <bp@suse.de>, Juergen Gross <jgross@suse.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220503032107.680190-6-jiangshanlai@gmail.com>
References: <20220503032107.680190-6-jiangshanlai@gmail.com>
MIME-Version: 1.0
Message-ID: <165160446318.4207.9852653161107393222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     64cbd0acb58203fb769ed2f4eab526d43e243847
Gitweb:        https://git.kernel.org/tip/64cbd0acb58203fb769ed2f4eab526d43e243847
Author:        Lai Jiangshan <jiangshan.ljs@antgroup.com>
AuthorDate:    Tue, 03 May 2022 11:21:06 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 03 May 2022 12:21:35 +02:00

x86/entry: Don't call error_entry() for XENPV

XENPV guests enter already on the task stack and they can't fault for
native_iret() nor native_load_gs_index() since they use their own pvop
for IRET and load_gs_index(). A CR3 switch is not needed either.

So there is no reason to call error_entry() in XENPV.

  [ bp: Massage commit message. ]

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20220503032107.680190-6-jiangshanlai@gmail.com
---
 arch/x86/entry/entry_64.S | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ab6ab6d..062aa9d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -336,8 +336,17 @@ SYM_CODE_END(push_and_clear_regs)
 	call push_and_clear_regs
 	UNWIND_HINT_REGS
 
-	call	error_entry
-	movq	%rax, %rsp			/* switch to the task stack if from userspace */
+	/*
+	 * Call error_entry() and switch to the task stack if from userspace.
+	 *
+	 * When in XENPV, it is already in the task stack, and it can't fault
+	 * for native_iret() nor native_load_gs_index() since XENPV uses its
+	 * own pvops for IRET and load_gs_index().  And it doesn't need to
+	 * switch the CR3.  So it can skip invoking error_entry().
+	 */
+	ALTERNATIVE "call error_entry; movq %rax, %rsp", \
+		"", X86_FEATURE_XENPV
+
 	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
