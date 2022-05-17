Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B8552ADA8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiEQVsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiEQVsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:48:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE052B28
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:48:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i1so22468plg.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B0Z8qje4K0QTzYUpRNMwBOVtmOTsji77xZBv0BluXhQ=;
        b=WnAkLjd1rQkNEoxZ4eEbkLGqsHE1zlXRmuLo6CigBq+Exs81iTZNdgq1vp2esdTT73
         ++NJDD6ds7gRUeyf86VZC/nyvxR/IriYVDbAp7uEuvp+dvIZpg/8eeuDrqWXNnrTPIM8
         Jn/CU8fuW3nVAzQBbts1YUu8/lMcDXdHqgaLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B0Z8qje4K0QTzYUpRNMwBOVtmOTsji77xZBv0BluXhQ=;
        b=pow8pGOWy26dwrkdrnuXSzuO+gHcs330QB6yG5YR0o1wkzb+jSaQUhMnggKxbgqfWx
         OFpjQbpe/AwzObMJ//uO8d+GoRygk86FjjHvKK2ijuoeprMQvx5qa99nanbLK24UD4Vp
         Tu26YH4W3k13CI5LUrE5EB7JbvubTmOeJ+y+eA554OwRj76oUQGGN8/fnIJq4hcxRGMG
         RpV1TdltTdKv3bBa+pFxbWYZJGADG/vkrlKT4f5nl6F1Vxkr38daycBe4ki7QelTsO2B
         gqWBlQa6uK/D4n3kKNnvxsCMwv6TAlVIklWBEcLsb9LoWRP4S82zlinQ4uzmKjsDcKQ7
         vGvw==
X-Gm-Message-State: AOAM533CMSsFTtrnHB6A5dShuqEBo7hhy1mRW4usFskAsPoeyH1x/x7v
        yYHNTsG1+9F4kL4/TsMqHz5Weg==
X-Google-Smtp-Source: ABdhPJzTuE9TAjQU08ieN1Dl6s3PAFg07MAbn45QB1uCfx5RYCe93gt7m9EFwFWROLd0kSiun21p5g==
X-Received: by 2002:a17:902:b588:b0:161:64fe:af8c with SMTP id a8-20020a170902b58800b0016164feaf8cmr14552040pls.26.1652824120653;
        Tue, 17 May 2022 14:48:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ik19-20020a170902ab1300b0015e8d4eb2ccsm73762plb.278.2022.05.17.14.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:48:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm/usercopy: Rename "heap" to "slab"
Date:   Tue, 17 May 2022 14:48:38 -0700
Message-Id: <20220517214838.878058-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3666; h=from:subject; bh=LN8v26DnF+tRW/V4fGkZeqbtRtGnjHihliWqv+vZkmg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihBg2VvyA5Kov1gcLauuPlWqWVcXe7VVhoOP+c1Pk zd02JqqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoQYNgAKCRCJcvTf3G3AJrr4D/ 40cSDPakluAzCs5V7tDR+Vv5V32E27wyAUs+mDWx6vJjrcvRge1cgmpD/HYZK1J4sbtwkv8OmdcAkW YyCC+4I9F7cXneSSD4qydoB3+AdNQYC/LbxyG3b+06x6SESxizVg2AXUKe7EGqNufEYwvKPrb0W8fi GoxjrwXDBkF50IoMg1+hJathXKt4k8xuzSHSUXeMpamy7tObBaFFOiu8C+VIvD0nU27f/u21oNC2Ot STmYNHhs87c5mc/CJce0aj7Y/Wo4SVppp7yX2I/Eb1+SxGTcy8/7eDZTMe8jJATyF738pZzbNpM3JC flTERWJRugf47m6J30pXfweRK25BqCJPjDeD8fkIBQbppCdW0wPvEwYKVLwRKjWj7T3QKw6+kfPsc6 DrCC17oLKygwH8lKVRDBNPdk1z7+pfv5Umb91PnSFDojTVZfMtIZrd2bwnq4GHQoIthKGmE/xzdecr zp9S6l2eOjOUagcomzse0DYzFet6bw7UciAI+OcWeH5i7Ot4fbG1fht9TuYdHB9atWxTuJtUkZ88sw vXZOeyuPrvnZTs0fFbCawHaaTghkso0404HfxxcKGKcjH/Av0zeBypZYRvB4QZZTSXc75EsBonzzVr +cry1uprKVwuezRNqLNQGUZnintUlXJ6X9JZ9sN/Xm0N4sK/wnbiQo/c08eA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To more clearly distinguish between the various heap types, rename the
slab tests to "slab".

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/usercopy.c           | 30 ++++++++++++-------------
 tools/testing/selftests/lkdtm/tests.txt |  8 +++----
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 7852b9fc7c47..945806db2a13 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -130,7 +130,7 @@ static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
  * This checks for whole-object size validation with hardened usercopy,
  * with or without usercopy whitelisting.
  */
-static void do_usercopy_heap_size(bool to_user)
+static void do_usercopy_slab_size(bool to_user)
 {
 	unsigned long user_addr;
 	unsigned char *one, *two;
@@ -196,9 +196,9 @@ static void do_usercopy_heap_size(bool to_user)
 
 /*
  * This checks for the specific whitelist window within an object. If this
- * test passes, then do_usercopy_heap_size() tests will pass too.
+ * test passes, then do_usercopy_slab_size() tests will pass too.
  */
-static void do_usercopy_heap_whitelist(bool to_user)
+static void do_usercopy_slab_whitelist(bool to_user)
 {
 	unsigned long user_alloc;
 	unsigned char *buf = NULL;
@@ -272,24 +272,24 @@ static void do_usercopy_heap_whitelist(bool to_user)
 }
 
 /* Callable tests. */
-static void lkdtm_USERCOPY_HEAP_SIZE_TO(void)
+static void lkdtm_USERCOPY_SLAB_SIZE_TO(void)
 {
-	do_usercopy_heap_size(true);
+	do_usercopy_slab_size(true);
 }
 
-static void lkdtm_USERCOPY_HEAP_SIZE_FROM(void)
+static void lkdtm_USERCOPY_SLAB_SIZE_FROM(void)
 {
-	do_usercopy_heap_size(false);
+	do_usercopy_slab_size(false);
 }
 
-static void lkdtm_USERCOPY_HEAP_WHITELIST_TO(void)
+static void lkdtm_USERCOPY_SLAB_WHITELIST_TO(void)
 {
-	do_usercopy_heap_whitelist(true);
+	do_usercopy_slab_whitelist(true);
 }
 
-static void lkdtm_USERCOPY_HEAP_WHITELIST_FROM(void)
+static void lkdtm_USERCOPY_SLAB_WHITELIST_FROM(void)
 {
-	do_usercopy_heap_whitelist(false);
+	do_usercopy_slab_whitelist(false);
 }
 
 static void lkdtm_USERCOPY_STACK_FRAME_TO(void)
@@ -358,10 +358,10 @@ void __exit lkdtm_usercopy_exit(void)
 }
 
 static struct crashtype crashtypes[] = {
-	CRASHTYPE(USERCOPY_HEAP_SIZE_TO),
-	CRASHTYPE(USERCOPY_HEAP_SIZE_FROM),
-	CRASHTYPE(USERCOPY_HEAP_WHITELIST_TO),
-	CRASHTYPE(USERCOPY_HEAP_WHITELIST_FROM),
+	CRASHTYPE(USERCOPY_SLAB_SIZE_TO),
+	CRASHTYPE(USERCOPY_SLAB_SIZE_FROM),
+	CRASHTYPE(USERCOPY_SLAB_WHITELIST_TO),
+	CRASHTYPE(USERCOPY_SLAB_WHITELIST_FROM),
 	CRASHTYPE(USERCOPY_STACK_FRAME_TO),
 	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
 	CRASHTYPE(USERCOPY_STACK_BEYOND),
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 9dace01dbf15..65e53eb0840b 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -64,10 +64,10 @@ REFCOUNT_DEC_AND_TEST_SATURATED Saturation detected: still saturated
 REFCOUNT_SUB_AND_TEST_SATURATED Saturation detected: still saturated
 #REFCOUNT_TIMING timing only
 #ATOMIC_TIMING timing only
-USERCOPY_HEAP_SIZE_TO
-USERCOPY_HEAP_SIZE_FROM
-USERCOPY_HEAP_WHITELIST_TO
-USERCOPY_HEAP_WHITELIST_FROM
+USERCOPY_SLAB_SIZE_TO
+USERCOPY_SLAB_SIZE_FROM
+USERCOPY_SLAB_WHITELIST_TO
+USERCOPY_SLAB_WHITELIST_FROM
 USERCOPY_STACK_FRAME_TO
 USERCOPY_STACK_FRAME_FROM
 USERCOPY_STACK_BEYOND
-- 
2.32.0

