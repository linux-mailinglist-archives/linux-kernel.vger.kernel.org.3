Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF79C597433
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbiHQQ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbiHQQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:27:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E0CA0326
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:27:40 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660753657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKc+6HUSNpaxlBjXSX1XTp4QrP/t25TRKhHhhX/hF54=;
        b=FpU5qd203NglSjouxtHxwHoFNL1T2ZLmljndcWC4FtmBFWjgUqwHAjv7zQvsovs6hCxhlX
        JoHA0FMFOkBHqqoKdp7EjJdeRWc5Rn4pgzL62l1FMpBxxWCZ+0csVl9GHyvibFAee9cf9n
        OSA1Tb0ugOTGnMu1nFM4VKdTkKVezo30Ta4GQ3squD4pDt0OHMXmNMcw+ygtvY66XPLoMK
        vg5p1TnDFQA7yOOLOnrjP/QULpMws95kTgxqnbYqy2ioH17zW3J3ui+pCgV/JZX9xHJe5+
        ZLk6Mz/fYw8wN5r5rvTm83XCKdbXLKNlarnAneLdFP+vrPc4BYaxzimqyBEPDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660753657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKc+6HUSNpaxlBjXSX1XTp4QrP/t25TRKhHhhX/hF54=;
        b=VeiXr1hZu9YMVGXyrDrMs79lKviokSPPt/kOD1hYDXn1qxwRf9t8Nj70PwNgMW7CRyMxjK
        iYibp+Y7KobngcAQ==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/9] mm/debug: Provide VM_WARN_ON_IRQS_ENABLED()
Date:   Wed, 17 Aug 2022 18:26:59 +0200
Message-Id: <20220817162703.728679-6-bigeasy@linutronix.de>
In-Reply-To: <20220817162703.728679-1-bigeasy@linutronix.de>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
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

