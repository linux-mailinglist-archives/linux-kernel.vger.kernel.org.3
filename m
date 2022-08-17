Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAB159742D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbiHQQ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241004AbiHQQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:27:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1B4A033D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:27:40 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660753658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9l7y3m8zkOiNy05wS2hSJk+waPS7nO5NnqSs6GtD6Q=;
        b=ahVLd9nL3dCq1i5nadi2s73phgxk46U/cAa/JGm1oBcNYwokEpPrfwAB5Lp8ZJORaH1smt
        ZYwfZrkBmj22GkgDrGdyC/aHgVNIEZEDpcUaMSwto7T7OLlZal2MdwREue2Bz+8KTPCyFp
        /TRn6vY7nem5QbWT6tHzSw15B66Y7md6oGuMmI+7/KLDsGZ14FFiC3QTUecsGOB9A7hLCU
        8sPjta8aon+QUj27nhHmP1S8g9DL0Yr8+ZZ/wn5InvTm/9e5GFQX3Pj3Uc+qQqGdEAvHqm
        dHT6Yf1fco8y91x+kaPu74FobZPLuro1Fyd6S4pQgt0ee3pTDes3A1zJL3L8+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660753658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9l7y3m8zkOiNy05wS2hSJk+waPS7nO5NnqSs6GtD6Q=;
        b=KHC1BnhWzRoSCVIlYh78XhedbXu636S/1THUCnmQGK5a+5dok80bN92jiqq/g3b6OU1xoA
        htdYRwUhK/B08uDg==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>, linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 7/9] mm/compaction: Get rid of RT ifdeffery
Date:   Wed, 17 Aug 2022 18:27:01 +0200
Message-Id: <20220817162703.728679-8-bigeasy@linutronix.de>
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

Move the RT dependency for the initial value of
sysctl_compact_unevictable_allowed into Kconfig.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Terrell <terrelln@fb.com>
Cc: linux-mm@kvack.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/Kconfig      | 5 +++++
 mm/compaction.c | 6 +-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 0331f1461f81c..a0506a54a4f3f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -579,6 +579,11 @@ config COMPACTION
 	  it and then we would be really interested to hear about that at
 	  linux-mm@kvack.org.
=20
+config COMPACT_UNEVICTABLE_DEFAULT
+	int
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

