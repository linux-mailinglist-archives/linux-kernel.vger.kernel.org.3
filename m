Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F174F2C78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346023AbiDEKmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241197AbiDEIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358C917A86;
        Tue,  5 Apr 2022 01:29:24 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=weL/Y/0bLbSr89Udbwco2BymGNu3H+Z73Jcjq6NeTuI=;
        b=PPDV1NnBtSFLvt+bcYKiG4rGphZi2oyC3AxUFgeFR9azd2m3bY5YILSwXRH9zUEYevKbSf
        6TgHUz7gPyC36Cul2Lh5ecKuM5r5ro/ZQdDhljRgq9DFCZzp4G9O0ZtvACwMc3D68gyiz8
        h7XSSH5vUz69vCQP90l9SjYJu2ZntIk/exYEPgyxhE0EFT3tGlfcGtBWovfZ68oqhoC9sN
        JZmu52rUUAzhG/CzCo6u7t9Am9nNhfynUJHeG1wCDLmzQZUhig/dncBKOaGJmS2ExxdcY3
        Oxa6g5ZnL0jwIHJmCgXwttzUvo8aSzXjrGEd8ZeRxFI7S+Bs+TgntsMNBwzpJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=weL/Y/0bLbSr89Udbwco2BymGNu3H+Z73Jcjq6NeTuI=;
        b=f3PzWIp1F/sCFHuDCAPpTCS7V1P+VizleOlgVky2nSdFgu4dQLNEi8ZWjVFAk0V9bgVqmO
        ElUnO1IoQ+aBq1AQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] preempt/dynamic: Introduce preemption model accessors
Cc:     Marco Elver <elver@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211112185203.280040-3-valentin.schneider@arm.com>
References: <20211112185203.280040-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <164914736184.389.17168803226310097171.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cfe43f478b79ba45573ca22d52d0d8823be068fa
Gitweb:        https://git.kernel.org/tip/cfe43f478b79ba45573ca22d52d0d8823be068fa
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Fri, 12 Nov 2021 18:52:01 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:42 +02:00

preempt/dynamic: Introduce preemption model accessors

CONFIG_PREEMPT{_NONE, _VOLUNTARY} designate either:
o The build-time preemption model when !PREEMPT_DYNAMIC
o The default boot-time preemption model when PREEMPT_DYNAMIC

IOW, using those on PREEMPT_DYNAMIC kernels is meaningless - the actual
model could have been set to something else by the "preempt=foo" cmdline
parameter. Same problem applies to CONFIG_PREEMPTION.

Introduce a set of helpers to determine the actual preemption model used by
the live kernel.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Marco Elver <elver@google.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20211112185203.280040-3-valentin.schneider@arm.com
---
 include/linux/sched.h | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c   | 12 ++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d5e3c00..67f06f7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2117,6 +2117,47 @@ static inline void cond_resched_rcu(void)
 #endif
 }
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+extern bool preempt_model_none(void);
+extern bool preempt_model_voluntary(void);
+extern bool preempt_model_full(void);
+
+#else
+
+static inline bool preempt_model_none(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_NONE);
+}
+static inline bool preempt_model_voluntary(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
+}
+static inline bool preempt_model_full(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT);
+}
+
+#endif
+
+static inline bool preempt_model_rt(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_RT);
+}
+
+/*
+ * Does the preemption model allow non-cooperative preemption?
+ *
+ * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
+ * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
+ * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
+ * PREEMPT_NONE model.
+ */
+static inline bool preempt_model_preemptible(void)
+{
+	return preempt_model_full() || preempt_model_rt();
+}
+
 /*
  * Does a critical section need to be broken due to another
  * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d575b49..068c088 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8409,6 +8409,18 @@ static void __init preempt_dynamic_init(void)
 	}
 }
 
+#define PREEMPT_MODEL_ACCESSOR(mode) \
+	bool preempt_model_##mode(void)						 \
+	{									 \
+		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
+		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
+	}									 \
+	EXPORT_SYMBOL_GPL(preempt_model_##mode)
+
+PREEMPT_MODEL_ACCESSOR(none);
+PREEMPT_MODEL_ACCESSOR(voluntary);
+PREEMPT_MODEL_ACCESSOR(full);
+
 #else /* !CONFIG_PREEMPT_DYNAMIC */
 
 static inline void preempt_dynamic_init(void) { }
