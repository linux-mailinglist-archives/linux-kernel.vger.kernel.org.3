Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621D85843DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiG1QMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiG1QMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:12:24 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD46E2DE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:12:23 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id i4so1726578qvv.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLzhPJuLV78wBr0Tv6Z8LxwLkcgZW3FnmQ38kfC7t60=;
        b=jPIh/kiGOQp6NfTNaB9ktuEuEwoiIsvSqCjmCsUsq350WFK/FHOEYwDXqBO1/wg1cl
         OaF9nNK4YurhE/6oZrSO2n1o+h1gq/U6VmXNIIpasAEdkAxFzVXeaBt9O7W0hnXyD5EJ
         NOrOqxdUN/0BbL3Az/xhiOHIlVqxZJMZcMtqIWJQ4FbcWE0cQBL9L0XbCfJfuYRA6I84
         7tOoKY9k9CdO3BgObsEef7SqHb2s5Tt+EwX8fa7ywXLUWzJz/Zp/GjeSpe9IOIfwVwnA
         jrThVA3joG7iv6LcR/e2jjbkY+Se8JZZ1ZnGhDcPWVmwSFzQEHGV7LaoqiJHwMAwmfLb
         e9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLzhPJuLV78wBr0Tv6Z8LxwLkcgZW3FnmQ38kfC7t60=;
        b=pdkfOSjnpviMXdw+Dy9xgYhQ+RIIDJJXBd7J65Ut5xu5wR6SveWYxySwLH9j7Jl3SK
         aP0I6H9aqApGxrYO0T65O4Haid+hPsR8EQKMOQ3DVbo4VJNRf0Ps+duqD5vs4NSzPkgu
         bYUsd3hkXd5rsjxsj3VY5AclzRi3dZR0ieqqDZStdF7ttE38/0ELa/5gMUYskS0Tc6Xq
         +psM+JrZjmmYTtcG9R5kQbxPzXBpt/OP5O5Lbc5EunlDrmnx3p2jE5LnIoPPwSkT3EQY
         o5peq4zvBmcPo2G8PiDRtmgsGMdSn4Kg9eVVq9CdOcG4N+AF4XLb0ku4WZapdVE61tzR
         t6sw==
X-Gm-Message-State: AJIora9Wd2JlTPfcXsNIoQFK6+yaE3T6zvDy+ZabOYWNJ9w7eX539Y8+
        5bK1DIcq0fmBfQ9bkjKE6U4=
X-Google-Smtp-Source: AGRyM1uJvC3TwxbK73EwdvMezs9OEmGdKB4Mvh2YmymBonKjWnC6fwAUfDn5f1qUF7Kj8l4456qj/w==
X-Received: by 2002:a0c:e50d:0:b0:474:6b1e:ff39 with SMTP id l13-20020a0ce50d000000b004746b1eff39mr11370789qvm.2.1659024742656;
        Thu, 28 Jul 2022 09:12:22 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:b984:ba52:c3cf:cb5e])
        by smtp.gmail.com with ESMTPSA id g1-20020a05620a40c100b006b55036fd3fsm775859qko.70.2022.07.28.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:12:22 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 4/5] lib/find_bit: create find_first_zero_bit_le()
Date:   Thu, 28 Jul 2022 09:12:07 -0700
Message-Id: <20220728161208.865420-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220728161208.865420-1-yury.norov@gmail.com>
References: <20220728161208.865420-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_first_zero_bit_le() is an alias to find_next_zero_bit_le(); 
despite that 'next' is known to be slower than 'first' version.

Now that we have common __find_first_bit(), it's trivial to implement
find_first_zero_bit_le() as a real function.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h | 20 +++++++++++++++-----
 lib/find_bit.c       | 11 +++++++++++
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 3ace995d7079..8d326d1518f4 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -19,6 +19,7 @@ unsigned long _find_next_zero_bit_le(const void *addr, unsigned
 					long size, unsigned long offset);
 unsigned long _find_next_bit_le(const void *addr, unsigned
 				long size, unsigned long offset);
+unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size);
 #endif
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
@@ -260,6 +261,20 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 }
 #endif
 
+#ifndef find_first_zero_bit_le
+static inline
+unsigned long find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = swab(*addr) | ~GENMASK(size - 1, 0);
+
+		return val == ~0UL ? size : ffz(val);
+	}
+
+	return _find_first_zero_bit_le(addr, size);
+}
+#endif
+
 #ifndef find_next_bit_le
 static inline
 unsigned long find_next_bit_le(const void *addr, unsigned
@@ -279,11 +294,6 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 }
 #endif
 
-#ifndef find_first_zero_bit_le
-#define find_first_zero_bit_le(addr, size) \
-	find_next_zero_bit_le((addr), (size), 0)
-#endif
-
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
diff --git a/lib/find_bit.c b/lib/find_bit.c
index d207d1699834..a56872611a59 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -119,6 +119,17 @@ EXPORT_SYMBOL(_find_next_zero_bit);
 #endif
 
 #ifdef __BIG_ENDIAN
+#ifndef find_first_zero_bit_le
+/*
+ * Find the first cleared bit in an LE memory region.
+ */
+unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
+{
+	return __find_first_bit(addr, NULL, size, ~0UL, true);
+}
+EXPORT_SYMBOL(_find_first_zero_bit_le);
+#endif
+
 #ifndef find_next_zero_bit_le
 unsigned long _find_next_zero_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
-- 
2.34.1

