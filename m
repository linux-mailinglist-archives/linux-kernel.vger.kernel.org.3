Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E220C5A16E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243208AbiHYQmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHYQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:42:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3752BB026
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:42:00 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661445702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vNtMvikVP3A7JqyI64O+1a12M8t0vOpcITdU5U0TGnE=;
        b=1tbpx1sbmfdpwCzS9EIDtkWSVCGguf5I2hLDQGB3gqxy3NXTtgqxr/OyUHEVyLoWq3g+P+
        uLfKJpOAWO7ON0OCmzt/gOS53iP8p88HEzAMeM0nfm02bLRVp3g1wSqC6DGK639HTZVca/
        JgYApAw08cAzR11s+MES0bwsTZ0DDw6Tms9QX2ubEloCEvIkqQzXebuMe6ZSiYIsWJTwrK
        BoWu325TadyR5PkTVpwGarSfJURzf76C+VqcMoVVxUWCcgTKt3xE1cz/0uwZTvgUPYY7nT
        syGRgrGaTPLKYVFR1zfTNxCgXFsCiV0tf1g+P2nyTtUlEOHbZajGvExAn9TcFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661445702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vNtMvikVP3A7JqyI64O+1a12M8t0vOpcITdU5U0TGnE=;
        b=05zUufWP4OOvhby/9h51rilXjm5mAeXZOKAZ+CURv0RQdj2qbxL8qBxvKw0Kr/LwMwpHpa
        6RN8dg8XyVjM5qCg==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>, linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 6/8] mm/compaction: Get rid of RT ifdeffery
Date:   Thu, 25 Aug 2022 18:41:29 +0200
Message-Id: <20220825164131.402717-7-bigeasy@linutronix.de>
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

Move the RT dependency for the initial value of
sysctl_compact_unevictable_allowed into Kconfig.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Terrell <terrelln@fb.com>
Cc: linux-mm@kvack.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/Kconfig      | 6 ++++++
 mm/compaction.c | 6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 0331f1461f81c..3897e924e40f2 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -579,6 +579,12 @@ config COMPACTION
 	  it and then we would be really interested to hear about that at
 	  linux-mm@kvack.org.
=20
+config COMPACT_UNEVICTABLE_DEFAULT
+	int
+	depends on COMPACTION
+	default 0 if PREEMPT_RT
+	default 1
+
 #
 # support for free page reporting
 config PAGE_REPORTING
diff --git a/mm/compaction.c b/mm/compaction.c
index 640fa76228dd9..10561cb1aaad9 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1727,11 +1727,7 @@ typedef enum {
  * Allow userspace to control policy on scanning the unevictable LRU for
  * compactable pages.
  */
-#ifdef CONFIG_PREEMPT_RT
-int sysctl_compact_unevictable_allowed __read_mostly =3D 0;
-#else
-int sysctl_compact_unevictable_allowed __read_mostly =3D 1;
-#endif
+int sysctl_compact_unevictable_allowed __read_mostly =3D CONFIG_COMPACT_UN=
EVICTABLE_DEFAULT;
=20
 static inline void
 update_fast_start_pfn(struct compact_control *cc, unsigned long pfn)
--=20
2.37.2

