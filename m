Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1351F4C46FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiBYN4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiBYN4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:56:13 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D477C1DD0F1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:55:40 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qx21so10981569ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+U+4OPDxdQ4KBMFnmWDVQB99CK5buLdcQOKTy3BI0c=;
        b=X5xX9chZz5jQsaB4uh3fPSOca3jrKU0s2CQnIH+pvy6/llYk0OKrGZuoPrwDsew4s7
         QJo24ds6T3VSQg+9G3r4F1hGcKnBZswGKI+EelXsDXfSL6qzr//u9M0lwvUwzgjkFt/R
         YV4J1ZfBu95hJWC72ZBhqMhie522SnbjQCV65n3FqeYZVxeUGxJN0Wq8SPnXhUbA1or+
         5kkzTz5ZVuBXcIXQE71+DrQHGngpqNTQj01HQgtMA4bBxubHMeHcFfeRjYyg0jS9gE1+
         sdMix/OAa251eur3e8BiftlPTrtOaawNAX0Q3ADH9RZs9bQqltH9bT3ySUwh9bzknZQW
         r+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6+U+4OPDxdQ4KBMFnmWDVQB99CK5buLdcQOKTy3BI0c=;
        b=Ylf5f+kXFEOOAe/I2sfJrGYePjfB1N8hWuFIfnQJszp0E58o7kEk0nFECUZdAvXkBH
         WJLigcAVDpHZPXVgD88nEYukKNf/5pdRPZrnBuc0Th8AhW1Te+FP5Q7Ye/auz1QlIdre
         q8W2l2D+/rEp6OTMIAqOREuhUzYCXoxKotvBjCNECbcOCr4KG0rVmbgUIOdPeoNzMuS3
         2RBSPyMCeCwbS3Mq9aAsQPbvPdhsgpeYeflFBGr7NwQVJbfMOgLnRXui9/WrmSDtY1E4
         +B8PKt+4IvZPqxbLIVRJMdTSY7nuqlClVNXzDVMHbMDPtsft4779O58/uyrL2+vVMjTF
         5Lkw==
X-Gm-Message-State: AOAM530VreFAwF+oDr6leK1gzE0khJ88WKJoCGwd0r9gaGh0ooOblv6O
        p9HCAyCG6BKN7m10LL1sA7G7tcvJK/CzMg==
X-Google-Smtp-Source: ABdhPJzuoV70PQn+mUWOJS4WY4lavWofefgR5qJRShxZ5kW26X0Zm7bQdCW/FsSg3tRGsAgtfMsdOg==
X-Received: by 2002:a17:906:e218:b0:6cf:7483:36c8 with SMTP id gf24-20020a170906e21800b006cf748336c8mr6103227ejb.747.1645797339174;
        Fri, 25 Feb 2022 05:55:39 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id fb18-20020a1709073a1200b006ceb0d6441dsm1049743ejc.9.2022.02.25.05.55.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Feb 2022 05:55:38 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Mahesh Bodapati <mbodapat@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/3] microblaze: Use simple memset implementation from lib/string.c
Date:   Fri, 25 Feb 2022 14:55:34 +0100
Message-Id: <4a143e7654f72ee893dcea9769946e17d3570b16.1645797329.git.michal.simek@xilinx.com>
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

On microblaze systems which are not using OPT_LIB_FUNCTION only simple
memset is used. This function is already implemented in lib/string.c that's
why it should be used instead.
This change is done in respect of issue fixed by commit 33d0f96ffd73
("lib/string.c: Use freestanding environment") where gcc-10.x moved
-ftree-loop-distribute-patterns optimization is to O2 optimization level.
This optimization causes GCC to convert the while loop in memset.c into a
call to memset. So This optimization is transforming a loop in a
memset/memcpy into a call to the function itself. This makes the memset
implementation as recursive.

Based on fix above -ffreestanding was used and it needs to be used on
Microblaze too but the patch is not adding this flag it removes simple
implementation to cause that generic implementation is used where this flag
is already setup.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Mahesh Bodapati <mbodapat@xilinx.com>
---

Changes in v2:
- missing patch in v1

 arch/microblaze/include/asm/string.h |  2 ++
 arch/microblaze/lib/memset.c         | 20 ++------------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/microblaze/include/asm/string.h b/arch/microblaze/include/asm/string.h
index 34071a848b6a..dbdb9eb4a733 100644
--- a/arch/microblaze/include/asm/string.h
+++ b/arch/microblaze/include/asm/string.h
@@ -8,7 +8,9 @@
 
 #ifdef __KERNEL__
 
+#ifdef CONFIG_OPT_LIB_FUNCTION
 #define __HAVE_ARCH_MEMSET
+#endif
 #define __HAVE_ARCH_MEMCPY
 #define __HAVE_ARCH_MEMMOVE
 
diff --git a/arch/microblaze/lib/memset.c b/arch/microblaze/lib/memset.c
index eb6c8988af02..615a2f8f53cb 100644
--- a/arch/microblaze/lib/memset.c
+++ b/arch/microblaze/lib/memset.c
@@ -30,22 +30,7 @@
 #include <linux/compiler.h>
 #include <linux/string.h>
 
-#ifdef __HAVE_ARCH_MEMSET
-#ifndef CONFIG_OPT_LIB_FUNCTION
-void *memset(void *v_src, int c, __kernel_size_t n)
-{
-	char *src = v_src;
-
-	/* Truncate c to 8 bits */
-	c = (c & 0xFF);
-
-	/* Simple, byte oriented memset or the rest of count. */
-	while (n--)
-		*src++ = c;
-
-	return v_src;
-}
-#else /* CONFIG_OPT_LIB_FUNCTION */
+#ifdef CONFIG_OPT_LIB_FUNCTION
 void *memset(void *v_src, int c, __kernel_size_t n)
 {
 	char *src = v_src;
@@ -94,6 +79,5 @@ void *memset(void *v_src, int c, __kernel_size_t n)
 
 	return v_src;
 }
-#endif /* CONFIG_OPT_LIB_FUNCTION */
 EXPORT_SYMBOL(memset);
-#endif /* __HAVE_ARCH_MEMSET */
+#endif /* CONFIG_OPT_LIB_FUNCTION */
-- 
2.35.1

