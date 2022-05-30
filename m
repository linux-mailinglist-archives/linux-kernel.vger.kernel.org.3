Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878BF537934
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiE3Ki7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiE3Kiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:38:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90BC6B024;
        Mon, 30 May 2022 03:38:50 -0700 (PDT)
Date:   Mon, 30 May 2022 10:38:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653907128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufDnFMnnXBqzc5K3MvijCT7r3uQmHklKS0W/nXF0apA=;
        b=eKCsbOTSBFO3tNIIUqGu0TgSqb16bl9Azav5AsnQpcV7M++y7nL8f7AWmUICSC+H7wWZqX
        jbxlnKCu6Pw6ySZnwRvmRyGqXm2tq0cZHTom/JsiZ0LABexsF+P2b1VEvKSgPnd88oTe5e
        9Lg4sAxQpl1Vrj/H4d2zr5l0AlYGSWvrw+7kygr6eBerv/9I5WQPypPhDt1+i48EGpHarX
        HxsEeuO0uBQDEz1tTHmMMvumLnDOhpTA0EP2JW21tp6qALS0E7HkbuAwG4m6J+QfHA+Pnu
        SON8/pqexro1A+Uw+kNOxTqDl/Gt0cYMkWTf0gXRE8kRqvZaUTNxewRAqf/36g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653907128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufDnFMnnXBqzc5K3MvijCT7r3uQmHklKS0W/nXF0apA=;
        b=XMJDFjPTforWFbcukIdOfeoLkQe405AmjyghiTNjVDb2HHjqlx9Sy2vyzFyas7J8lzV7PN
        pR/t0LzEHQAwPmCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] context_tracking: Always inline empty stubs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220526105958.134113388@infradead.org>
References: <20220526105958.134113388@infradead.org>
MIME-Version: 1.0
Message-ID: <165390712760.4207.5469965396434048789.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     620f8d3bd3d5e82dff8cc591c831827d4beeae2e
Gitweb:        https://git.kernel.org/tip/620f8d3bd3d5e82dff8cc591c831827d4beeae2e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 07 May 2022 13:35:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 May 2022 12:34:44 +02:00

context_tracking: Always inline empty stubs

Because GCC is seriously challenged..

vmlinux.o: warning: objtool: enter_from_user_mode+0x85: call to context_tracking_enabled() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x8f: call to context_tracking_enabled() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x85: call to context_tracking_enabled() leaves .noinstr.text section
vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x85: call to context_tracking_enabled() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lkml.kernel.org/r/20220526105958.134113388@infradead.org
---
 include/linux/context_tracking_state.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 65a60d3..ae1e63e 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -46,10 +46,10 @@ static __always_inline bool context_tracking_in_user(void)
 	return __this_cpu_read(context_tracking.state) == CONTEXT_USER;
 }
 #else
-static inline bool context_tracking_in_user(void) { return false; }
-static inline bool context_tracking_enabled(void) { return false; }
-static inline bool context_tracking_enabled_cpu(int cpu) { return false; }
-static inline bool context_tracking_enabled_this_cpu(void) { return false; }
+static __always_inline bool context_tracking_in_user(void) { return false; }
+static __always_inline bool context_tracking_enabled(void) { return false; }
+static __always_inline bool context_tracking_enabled_cpu(int cpu) { return false; }
+static __always_inline bool context_tracking_enabled_this_cpu(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
 
 #endif
