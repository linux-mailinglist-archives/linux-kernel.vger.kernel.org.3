Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B42466250
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357323AbhLBLbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:31:02 -0500
Received: from foss.arm.com ([217.140.110.172]:33842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357257AbhLBLbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:31:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 986851477;
        Thu,  2 Dec 2021 03:27:38 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DED23F7D7;
        Thu,  2 Dec 2021 03:27:37 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     andreyknvl@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, ryabinin.a.a@gmail.com, will@kernel.org
Subject: [PATCH 1/3] kasan: move kasan_shadow_to_mem() to shared header
Date:   Thu,  2 Dec 2021 11:27:29 +0000
Message-Id: <20211202112731.3346975-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211202112731.3346975-1-mark.rutland@arm.com>
References: <20211202112731.3346975-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some arch code would like to convert a shadow address to a corresponding
memory address, e.g. for better reporting when a fault is taken on a
shadow access.

We already provide architectures with kasan_mem_to_shadow() and all the
underlying constants, so we may as well allow them to use
kasan_shadow_to_mem() rather than having to open-code this.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 include/linux/kasan.h | 6 ++++++
 mm/kasan/kasan.h      | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index d8783b682669..9059533e19c3 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -56,6 +56,12 @@ static inline void *kasan_mem_to_shadow(const void *addr)
 		+ KASAN_SHADOW_OFFSET;
 }
 
+static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
+{
+	return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
+		<< KASAN_SHADOW_SCALE_SHIFT);
+}
+
 int kasan_add_zero_shadow(void *start, unsigned long size);
 void kasan_remove_zero_shadow(void *start, unsigned long size);
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index aebd8df86a1f..9ec09154ceb1 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -213,12 +213,6 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
-static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
-{
-	return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
-		<< KASAN_SHADOW_SCALE_SHIFT);
-}
-
 static inline bool addr_has_metadata(const void *addr)
 {
 	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
-- 
2.30.2

