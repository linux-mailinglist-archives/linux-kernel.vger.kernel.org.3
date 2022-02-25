Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6224C46FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiBYN4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiBYN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:56:16 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB52920E7AE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:55:43 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hw13so10994349ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pSHD0SU+ptLFBEbz9zBf3mjkmvjW9rQOpevS0uGYMs=;
        b=ieyGbzplsa1pz/EICKUrS5akdyGa0zZvAQf2uRCF/0E8R+BsszAqqJd+XSJ3nLXOcs
         kuqle1nha6PUFpCamPySnhzxeO/l6jVSI0wIyk+LSRX8eBwwUx2nXC51Vp/Jk+TKLoLz
         A9gp6xzqpVLmB8iBX9VAYclNM8Nj3mnGU3agyh8c05YI+MyDuHj4BXbbLoDi+inRciKH
         zKPy0ezKjlkoc9PdGRP+pRBYjZB04tURU+UyRpNgRUCRTDQ0NGasmEbuNmAtqyM/KV7u
         V13gA2IlaX0onlta7BeiUy9RALBnka8/4iq2HA8weEKW36d6bdeZ5Ik3VQYGI+gdAulY
         DxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5pSHD0SU+ptLFBEbz9zBf3mjkmvjW9rQOpevS0uGYMs=;
        b=XAEDD1yOBbe/S1vVn1CD+YX2gDf+6iYopOUJ0J1vaTVOoEXJ6CFz6HsFrVOXCWEdiL
         zC/YYY0E/usiL8iCykXtQZBOjg9Du9DUUNRc6oiPniFUEfTv5BxR4o3236pX7PRlMa8i
         jO8LLYIxMMXMY1u+SKOEcwJRqrrEASqHHIPk8itG07SHKV/r6KtgoJASQNrfymKwAJdY
         hG/ceFHRwJARltDgJjn7qXc2JrpC+4yMj1mAeNNnIFo7n2R1dD8BEoMT1UXa8N0gHhQF
         vWKrtGLVrq6XdbAxc1wAWOPzphVXlvEzhPtQixNm21ImisWk1vtFvXkQZ/qLUjJnL3Ju
         JpOg==
X-Gm-Message-State: AOAM5323hcFxycyRts4SZoBAasq2dUMGOX294Cn5flNCj2R+HpQKmGoX
        A7T7cGDx/8s0/hNl0FWSbBPcncQfodJPVw==
X-Google-Smtp-Source: ABdhPJwru0Ch3HnIaFXkHJ7a6WHcw/O/04wTW1z5PapPKsw4ZzYUUCNV0xGbIj8Q4xJZZQcxqwyuWw==
X-Received: by 2002:a17:906:4d51:b0:6b8:78e0:565a with SMTP id b17-20020a1709064d5100b006b878e0565amr6152491ejv.587.1645797342213;
        Fri, 25 Feb 2022 05:55:42 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906304800b006cdf8a1e146sm1027809ejd.217.2022.02.25.05.55.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Feb 2022 05:55:41 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Mahesh Bodapati <mbodapat@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 3/3] microblaze: Use simple memmove/memcpy implementation from lib/string.c
Date:   Fri, 25 Feb 2022 14:55:36 +0100
Message-Id: <1f5cfc026a8a458f3e3134ab80f65bd4ac7e3e8e.1645797329.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645797329.git.michal.simek@xilinx.com>
References: <cover.1645797329.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on previous commit ("microblaze: Use simple memset
implementation from lib/string.c") where generic memset implementation is
used when OPT_LIB_FUNCTION is not defined. The same change can be done for
memset/memcpy implementation where doesn't make sense to have generic
implementation in architecture code.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

(no changes since v1)

 arch/microblaze/include/asm/string.h |  2 +-
 arch/microblaze/lib/memcpy.c         | 18 ++---------------
 arch/microblaze/lib/memmove.c        | 29 ++--------------------------
 3 files changed, 5 insertions(+), 44 deletions(-)

diff --git a/arch/microblaze/include/asm/string.h b/arch/microblaze/include/asm/string.h
index dbdb9eb4a733..8798ad2c132a 100644
--- a/arch/microblaze/include/asm/string.h
+++ b/arch/microblaze/include/asm/string.h
@@ -10,13 +10,13 @@
 
 #ifdef CONFIG_OPT_LIB_FUNCTION
 #define __HAVE_ARCH_MEMSET
-#endif
 #define __HAVE_ARCH_MEMCPY
 #define __HAVE_ARCH_MEMMOVE
 
 extern void *memset(void *, int, __kernel_size_t);
 extern void *memcpy(void *, const void *, __kernel_size_t);
 extern void *memmove(void *, const void *, __kernel_size_t);
+#endif
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/microblaze/lib/memcpy.c b/arch/microblaze/lib/memcpy.c
index 63041fdf916d..9966dce55619 100644
--- a/arch/microblaze/lib/memcpy.c
+++ b/arch/microblaze/lib/memcpy.c
@@ -31,20 +31,7 @@
 
 #include <linux/string.h>
 
-#ifdef __HAVE_ARCH_MEMCPY
-#ifndef CONFIG_OPT_LIB_FUNCTION
-void *memcpy(void *v_dst, const void *v_src, __kernel_size_t c)
-{
-	const char *src = v_src;
-	char *dst = v_dst;
-
-	/* Simple, byte oriented memcpy. */
-	while (c--)
-		*dst++ = *src++;
-
-	return v_dst;
-}
-#else /* CONFIG_OPT_LIB_FUNCTION */
+#ifdef CONFIG_OPT_LIB_FUNCTION
 void *memcpy(void *v_dst, const void *v_src, __kernel_size_t c)
 {
 	const char *src = v_src;
@@ -188,6 +175,5 @@ void *memcpy(void *v_dst, const void *v_src, __kernel_size_t c)
 
 	return v_dst;
 }
-#endif /* CONFIG_OPT_LIB_FUNCTION */
 EXPORT_SYMBOL(memcpy);
-#endif /* __HAVE_ARCH_MEMCPY */
+#endif /* CONFIG_OPT_LIB_FUNCTION */
diff --git a/arch/microblaze/lib/memmove.c b/arch/microblaze/lib/memmove.c
index 9862f6b1e59d..2e49d0ef1e07 100644
--- a/arch/microblaze/lib/memmove.c
+++ b/arch/microblaze/lib/memmove.c
@@ -30,31 +30,7 @@
 #include <linux/compiler.h>
 #include <linux/string.h>
 
-#ifdef __HAVE_ARCH_MEMMOVE
-#ifndef CONFIG_OPT_LIB_FUNCTION
-void *memmove(void *v_dst, const void *v_src, __kernel_size_t c)
-{
-	const char *src = v_src;
-	char *dst = v_dst;
-
-	if (!c)
-		return v_dst;
-
-	/* Use memcpy when source is higher than dest */
-	if (v_dst <= v_src)
-		return memcpy(v_dst, v_src, c);
-
-	/* copy backwards, from end to beginning */
-	src += c;
-	dst += c;
-
-	/* Simple, byte oriented memmove. */
-	while (c--)
-		*--dst = *--src;
-
-	return v_dst;
-}
-#else /* CONFIG_OPT_LIB_FUNCTION */
+#ifdef CONFIG_OPT_LIB_FUNCTION
 void *memmove(void *v_dst, const void *v_src, __kernel_size_t c)
 {
 	const char *src = v_src;
@@ -215,6 +191,5 @@ void *memmove(void *v_dst, const void *v_src, __kernel_size_t c)
 	}
 	return v_dst;
 }
-#endif /* CONFIG_OPT_LIB_FUNCTION */
 EXPORT_SYMBOL(memmove);
-#endif /* __HAVE_ARCH_MEMMOVE */
+#endif /* CONFIG_OPT_LIB_FUNCTION */
-- 
2.35.1

