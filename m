Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E445A16E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbiHYQmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242849AbiHYQmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:42:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB4BA175
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:41:54 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661445701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sTDmikhifvT+jyCYSjHJibnGmKic2QnilMTiV7/DbU=;
        b=obMubdUd6EYGlMUE+9dZPkyrahV0KRgisk2845KsBngVKkRtiS/Msafs4/lAf5+xakKTZ/
        GF/JrVvH839LGCfDXeW7jRQH1sCUYlyLY9jRMxBcmm8Dejy2OsJQrmodMkwVQcftSEiRkW
        EEOvcB3OI/zRussbsWUnJgWhcmoAGZPbEi8kDl9CbpK3DIX4/nnk5IRaY1IEp0MA/+aRS7
        WUnCopuwdPLuK8XTQH+j2Sgxsx+MnhGCAXz4I3H8y+aEF054nxFtl/wIFeoeK8RmFMXGLI
        v0eiMX71mbgaS6WpTMLEcDqeu0mTrd2ekCrmJTPJVcX4OVj17fWIGAMkQah5kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661445701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sTDmikhifvT+jyCYSjHJibnGmKic2QnilMTiV7/DbU=;
        b=HuR+XllO9XxgzG30p0gBGiEYr0BVeZQinpJziXEn5D8nhFALUt02pQEhbjGpt6BqBFKpLY
        2uMIOQAaGXq31vDA==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 4/8] mm/debug: Provide VM_WARN_ON_IRQS_ENABLED()
Date:   Thu, 25 Aug 2022 18:41:27 +0200
Message-Id: <20220825164131.402717-5-bigeasy@linutronix.de>
In-Reply-To: <20220825164131.402717-1-bigeasy@linutronix.de>
References: <20220825164131.402717-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Some places in the VM code expect interrupts disabled, which is a valid
expectation on non-PREEMPT_RT kernels, but does not hold on RT kernels in
some places because the RT spinlock substitution does not disable
interrupts.

To avoid sprinkling CONFIG_PREEMPT_RT conditionals into those places,
provide VM_WARN_ON_IRQS_ENABLED() which is only enabled when VM_DEBUG=3Dy a=
nd
PREEMPT_RT=3Dn.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/mmdebug.h | 6 ++++++
 lib/Kconfig.debug       | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 15ae78cd28536..b8728d11c9490 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -94,6 +94,12 @@ void dump_mm(const struct mm_struct *mm);
 #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #endif
=20
+#ifdef CONFIG_DEBUG_VM_IRQSOFF
+#define VM_WARN_ON_IRQS_ENABLED() WARN_ON_ONCE(!irqs_disabled())
+#else
+#define VM_WARN_ON_IRQS_ENABLED() do { } while (0)
+#endif
+
 #ifdef CONFIG_DEBUG_VIRTUAL
 #define VIRTUAL_BUG_ON(cond) BUG_ON(cond)
 #else
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 072e4b289c13e..c96fc6820544c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -803,6 +803,9 @@ config ARCH_HAS_DEBUG_VM_PGTABLE
 	  An architecture should select this when it can successfully
 	  build and run DEBUG_VM_PGTABLE.
=20
+config DEBUG_VM_IRQSOFF
+	def_bool DEBUG_VM && !PREEMPT_RT
+
 config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
--=20
2.37.2

