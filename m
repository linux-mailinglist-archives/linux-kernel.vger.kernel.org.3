Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01054507AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357618AbiDSUMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357205AbiDSUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56E63CFC9;
        Tue, 19 Apr 2022 13:08:44 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mo1rBP3UZcSdUGWNRgAT7Y5jTBTHjhkOlUTq2ehNa8U=;
        b=wM6lWXxHlBH/idc+Js5mAMlOveMM6v4YnIdg9Vts53LuKqEEOlFLnmdp0pd6SdDt1IoR7n
        3S5BBI3A1MzCvjmurMoSwQNH2PaNOONqVsiikAiK+atTiN2wmumWREk3gYK2CKXXaaBSBw
        PzrcaK8l9kqNDr8D7AAd6m0CFQNc2DD8GDwpjEd30EaA6r5BmigsJYV75IJfmWMeMBIs+B
        HnL1HfrjIVnFjL8bN1e25nLFOEe73F8Kf41eo0K32zaVoIW0PvhmzzGFnN2Dmi3kTa1n5f
        wUyZ3GOqxFSo8OsNGLRVpfvydr0dcPEHfgNuDghn9YbdMWw6sGhlKv7myOCUbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mo1rBP3UZcSdUGWNRgAT7Y5jTBTHjhkOlUTq2ehNa8U=;
        b=9Axo+abZJ2iTImqMaGil8McDcTNqy1+i7S3vh+I7Y8WyE5aDmLkf4WwmIubnSt2AqeWWEl
        XsLPAuSWQrjWzqDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86,objtool: Mark cpu_startup_entry() __noreturn
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220408094718.383658532@infradead.org>
References: <20220408094718.383658532@infradead.org>
MIME-Version: 1.0
Message-ID: <165039892227.4207.12342259491044823487.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d4e5268a08b211b536fed29beb24271ecd85187e
Gitweb:        https://git.kernel.org/tip/d4e5268a08b211b536fed29beb24271ecd85187e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Apr 2022 11:45:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:48 +02:00

x86,objtool: Mark cpu_startup_entry() __noreturn

GCC-8 isn't clever enough to figure out that cpu_start_entry() is a
noreturn while objtool is. This results in code after the call in
start_secondary(). Give GCC a hand so that they all agree on things.

  vmlinux.o: warning: objtool: start_secondary()+0x10e: unreachable

Reported-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220408094718.383658532@infradead.org
---
 include/linux/cpu.h   | 2 +-
 tools/objtool/check.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 9cf51e4..54dc2f9 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -167,7 +167,7 @@ static inline int suspend_disable_secondary_cpus(void) { return 0; }
 static inline void suspend_enable_secondary_cpus(void) { }
 #endif /* !CONFIG_PM_SLEEP_SMP */
 
-void cpu_startup_entry(enum cpuhp_state state);
+void __noreturn cpu_startup_entry(enum cpuhp_state state);
 
 void cpu_idle_poll_ctrl(bool enable);
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bd0c2c8..e3a675d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -184,6 +184,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"do_group_exit",
 		"stop_this_cpu",
 		"__invalid_creds",
+               "cpu_startup_entry",
 	};
 
 	if (!func)
