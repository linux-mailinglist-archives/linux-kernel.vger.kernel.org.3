Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C4536B93
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 10:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiE1IOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 04:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiE1IOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 04:14:02 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7388B9E;
        Sat, 28 May 2022 01:14:01 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g184so5847641pgc.1;
        Sat, 28 May 2022 01:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=361V99T0mQNSQZyHOPdAMCdjPFEyiJTvNkUeBgEbOug=;
        b=UKRaDeHeiRxhtIJZR+xleOoJVibDLSIhzWwg85RhvXjxUCq3Dw9NqgNY17soShlrq1
         37pKHOx7zfTKsRVTQ9RfM1xxlCQiZhZdJ5jeWx/C2GPYlwQ1XePN0+7UKorCPBrQRSYE
         rsK7fjeIbYoys6MnHUZlrZ4G9fjlUQNur81OQXwz16c7xVThvjBZFskft1zWJCLU9xiU
         2HY7X/uebsVkYT9SSIxvybtQsuPAOtmzXv6GnfqBifUgIqyShygFw8ZbCrginsUwY9yY
         DO/XV/zI9XBSIdk9MSKtZvHScABNEsuoq4lPJ+vLXK1IDwnW8mKh4qpcnqWTijxmyXre
         6CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=361V99T0mQNSQZyHOPdAMCdjPFEyiJTvNkUeBgEbOug=;
        b=VoutrjFjWJ5vmR3CNc5q6JFXOeDJfNMtlD3OL2iw3WBYCHgVOIuxlTZgHCW0xAMoX1
         Nx7d3V99EC2UIkJ5t6DQFOxD/M3vYS9kHV5eufUq1sy/95cVCeY8zR/Gk9D93p/Bs0vk
         j61bp3BUzvvDTaYoHz/rB4YJh/txION8/xnwpYHvHCWxRfFKHV17rS0kfi1L8MY1Hv9R
         88H/wkxO1QJ/jV3U1K28FUis0lS28aTO4Su3C8yP13N2jiCyTU6bFIk0Cd0SLSBwMcSW
         OFVYbI9tP7ScoRroYLke+q3SHdwH4h7480T9q3BA070NdGNBMLOe25TAsRRcawsEU4CV
         M+Gw==
X-Gm-Message-State: AOAM5333rw/HYpqg44usQZnb2p29RbOxHAh1tDD51zbflkp3qhb2zpE7
        vc2Safm+wF4VcknkKzJoh6c=
X-Google-Smtp-Source: ABdhPJwu9nZQ0cl6DnaMRtKysOnJ+Z6A96NJ6rjSYH02icOQdn3Ohk4+EIOv67lyKxlqXtQpOg5qsQ==
X-Received: by 2002:a65:6a47:0:b0:3f5:d7a8:44ee with SMTP id o7-20020a656a47000000b003f5d7a844eemr40352490pgu.330.1653725641154;
        Sat, 28 May 2022 01:14:01 -0700 (PDT)
Received: from localhost.localdomain ([140.116.104.153])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090ad34c00b001e0c5da6a51sm2774347pjx.50.2022.05.28.01.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 01:14:00 -0700 (PDT)
From:   Yu-Jen Chang <arthurchang09@gmail.com>
To:     ak@linux.intel.com, jdike@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        linux-um@lists.infradead.org, jserv@ccns.ncku.edu.tw,
        Yu-Jen Chang <arthurchang09@gmail.com>
Subject: [PATCH 1/2] x86/lib: Optimize memchr()
Date:   Sat, 28 May 2022 16:12:35 +0800
Message-Id: <20220528081236.3020-2-arthurchang09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220528081236.3020-1-arthurchang09@gmail.com>
References: <20220528081236.3020-1-arthurchang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original assembly version of memchr() is implemented with
the byte-wise comparing technique, which does not fully
use 64-bits registers in x86_64 CPU. We use word-wide
comparing so that 8 characters can be compared at the same time
on x86_64 CPU. First we align the input and then use word-wise
comparing to find the first 64-bit word that contain the target.
Secondly, we compare every byte in the word and get the output.

We create two files to measure the performance. The first file
contains on average 10 characters ahead the target character.
The second file contains at least 1000 characters ahead the
target character. Our implementation of “memchr()” is slightly
better in the first test and nearly 4x faster than the orginal
implementation in the second test.

Signed-off-by: Yu-Jen Chang <arthurchang09@gmail.com>
Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
---
 arch/x86/include/asm/string_64.h |  3 ++
 arch/x86/lib/Makefile            |  1 +
 arch/x86/lib/string_64.c         | 78 ++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 arch/x86/lib/string_64.c

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 6e450827f..edce657e0 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -14,6 +14,9 @@
 extern void *memcpy(void *to, const void *from, size_t len);
 extern void *__memcpy(void *to, const void *from, size_t len);
 
+#define __HAVE_ARCH_MEMCHR
+extern void *memchr(const void *cs, int c, size_t length);
+
 #define __HAVE_ARCH_MEMSET
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index f76747862..4d530e559 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -69,5 +69,6 @@ else
         lib-y += clear_page_64.o copy_page_64.o
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o
+        lib-y += string_64.o
 	lib-y += cmpxchg16b_emu.o
 endif
diff --git a/arch/x86/lib/string_64.c b/arch/x86/lib/string_64.c
new file mode 100644
index 000000000..4e067d5be
--- /dev/null
+++ b/arch/x86/lib/string_64.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/string.h>
+#include <linux/export.h>
+#include <linux/align.h>
+
+/* How many bytes are loaded each iteration of the word copy loop */
+#define LBLOCKSIZE (sizeof(long))
+
+#ifdef __HAVE_ARCH_MEMCHR
+
+void *memchr(const void *cs, int c, size_t length)
+{
+	const unsigned char *src = (const unsigned char *)cs, d = c;
+
+	while (!IS_ALIGNED((long)src, sizeof(long))) {
+		if (!length--)
+			return NULL;
+		if (*src == d)
+			return (void *)src;
+		src++;
+	}
+	if (length >= LBLOCKSIZE) {
+		unsigned long mask = d << 8 | d;
+		unsigned int i = 32;
+		long xor, data;
+		const long consta = 0xFEFEFEFEFEFEFEFF,
+			   constb = 0x8080808080808080;
+
+		/*
+		 * Create a 8-bytes mask for word-wise comparing.
+		 * For example, a mask for 'a' is 0x6161616161616161.
+		 */
+
+		mask |= mask << 16;
+		for (i = 32; i < LBLOCKSIZE * 8; i <<= 1)
+			mask |= mask << i;
+		/*
+		 * We perform word-wise comparing with following operation:
+		 *	1. Perform xor on the long word @src and @mask
+		 *	   and put into @xor.
+		 *	2. Add @xor with @consta.
+		 *	3. ~@xor & @constb.
+		 *	4. Perform & with the result of step 2 and 3.
+		 *
+		 * Step 1 creates a byte which is 0 in the long word if
+		 * there is at least one target byte in it.
+		 *
+		 * Step 2 to Step 4 find if there is a byte with 0 in
+		 * the long word.
+		 */
+		asm volatile("1:\n\t"
+			     "movq (%0),%1\n\t"
+			     "xorq %6,%1\n\t"
+			     "lea (%1,%4), %2\n\t"
+			     "notq %1\n\t"
+			     "andq %5,%1\n\t"
+			     "testq %1,%2\n\t"
+			     "jne 2f\n\t"
+			     "add $8,%0\n\t"
+			     "sub $8,%3\n\t"
+			     "cmp $7,%3\n\t"
+			     "ja 1b\n\t"
+			     "2:\n\t"
+			     : "=D"(src), "=r"(xor), "=r"(data), "=r"(length)
+			     : "r"(consta), "r"(constb), "r"(mask), "0"(src),
+			       "1"(xor), "2"(data), "3"(length)
+			     : "memory", "cc");
+	}
+
+	while (length--) {
+		if (*src == d)
+			return (void *)src;
+		src++;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(memchr);
+#endif
-- 
2.25.1

