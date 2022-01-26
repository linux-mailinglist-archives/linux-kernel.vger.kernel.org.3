Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497AD49D076
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbiAZRNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbiAZRNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:13:04 -0500
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CFCC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:13:04 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id d14-20020a196b0e000000b0043a9be72315so13153lfa.22
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pbBLINmGHzM6V42XBweXNxOpKFgkK8jWD+m3tGBDCwM=;
        b=PckkjWov+GONxQRSta3gcImVIQuyXgOD+nBDZhVM54Xja/BYGSjGS1IozDACEdOCNp
         sEnEVmyFbYIrlliZxHkzOmVvE3FFM9fAjufGozGOb2aIYarCGrp7YbeYCanzN1n6e0tl
         0KYSe4J/3KX9x7/cQkdLqHZkT3ZzRWSyrRWkgcpBm84uvulk34Nd14+W54FBw9P5qu32
         oQa9yay1tvSQTdOXlfrBB2BnEpb94hZtZe2AZJLDXp3qifwPRafiaZVRmKeZKhifnux4
         yErt2Kfj0SvO4LFV8lKZebmh/etEvFbo9qQXfqCPFiqeI7urWWX3QpyEnTPM7uq7NCsJ
         3C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pbBLINmGHzM6V42XBweXNxOpKFgkK8jWD+m3tGBDCwM=;
        b=E1u10jplI6RDyIQSEYe6ZOoToo+IshJAUFa3P0PUpmJRu6kawZg5ARXFVxKjZiRU97
         OdBnx/flAGVqjQOB1tUcdRgaNGNr18TFIf21h9p354qU7n99xu0NYA5GUUXhusSQA/Hj
         2TiahP35Li8UUxhUqtjYXhCKOutQ25yS9X+T2PX6CXNdrKaC/jLXuaKO44BrbznKR6Xv
         v7MYhe9nQpcvdZEaFmH79ZgQRSfNPKVSVBmswBf5aiuwkYu7qspHvmPkuLQWZmiMdY0Q
         4X3ePIaSfPOt9KYvdKgIH2f8qlGpFzfSgcZsv09NQGBChZX4X4tXuve7dQBOvGxu1u06
         R3ug==
X-Gm-Message-State: AOAM532qRXfDn+G4MQX14uAA53ZhT4V6+HDrrzosCwRxP7t8LGZ4k2tf
        bPEDgvCkwew4ripMkwokliI/8I2eKw==
X-Google-Smtp-Source: ABdhPJxtrW12j9LiTaZif+Ya2Fslvy8R9PaaQLSbeG7bct9LwCnyjhVkg0eKaYb8ZGcoeG0uslG4H8CcWw==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:9d:4:e695:855e:ae74:d6f])
 (user=jannh job=sendgmr) by 2002:ac2:5fad:: with SMTP id s13mr19320668lfe.41.1643217182081;
 Wed, 26 Jan 2022 09:13:02 -0800 (PST)
Date:   Wed, 26 Jan 2022 18:12:32 +0100
Message-Id: <20220126171232.2599547-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] x86/csum: Add KASAN/KCSAN instrumentation
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the optimized X86 version of the copy-with-checksum helpers, use
instrument_*() before accessing buffers from assembly code so that KASAN
and KCSAN don't have blind spots there.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/lib/csum-partial_64.c  | 3 +++
 arch/x86/lib/csum-wrappers_64.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 1f8a8f895173..8b0c353cd212 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -8,6 +8,7 @@
  
 #include <linux/compiler.h>
 #include <linux/export.h>
+#include <linux/instrumented.h>
 #include <asm/checksum.h>
 #include <asm/word-at-a-time.h>
 
@@ -37,6 +38,8 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 	u64 temp64 = (__force u64)sum;
 	unsigned odd, result;
 
+	instrument_read(buff, len);
+
 	odd = 1 & (unsigned long) buff;
 	if (unlikely(odd)) {
 		if (unlikely(len == 0))
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index 189344924a2b..087f3c4cb89f 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -6,6 +6,8 @@
  */
 #include <asm/checksum.h>
 #include <linux/export.h>
+#include <linux/in6.h>
+#include <linux/instrumented.h>
 #include <linux/uaccess.h>
 #include <asm/smap.h>
 
@@ -26,6 +28,7 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
 	__wsum sum;
 
 	might_sleep();
+	instrument_write(dst, len);
 	if (!user_access_begin(src, len))
 		return 0;
 	sum = csum_partial_copy_generic((__force const void *)src, dst, len);
@@ -51,6 +54,7 @@ csum_and_copy_to_user(const void *src, void __user *dst, int len)
 	__wsum sum;
 
 	might_sleep();
+	instrument_read(src, len);
 	if (!user_access_begin(dst, len))
 		return 0;
 	sum = csum_partial_copy_generic(src, (void __force *)dst, len);
@@ -71,6 +75,8 @@ EXPORT_SYMBOL(csum_and_copy_to_user);
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
+	instrument_write(dst, len);
+	instrument_read(src, len);
 	return csum_partial_copy_generic(src, dst, len);
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
@@ -81,6 +87,9 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 {
 	__u64 rest, sum64;
 
+	instrument_read(saddr, sizeof(*saddr));
+	instrument_read(daddr, sizeof(*daddr));
+
 	rest = (__force __u64)htonl(len) + (__force __u64)htons(proto) +
 		(__force __u64)sum;
 

base-commit: 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
-- 
2.35.0.rc0.227.g00780c9af4-goog

