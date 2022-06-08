Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3816B543EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiFHVkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiFHVk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:40:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18EA2B12DE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:40:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t2so18771630pld.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBKWev1Rs6wuYROdIel8IsWvzj2P6ShAsqmcV/ovcGg=;
        b=iOX8V1rvQjU+rJa/UArhmoyO8A5j582JHtbS8KEhoICNmLdqxdZ9lwUic0rhqahLe6
         p6FRaVRER5XfQ4N1BooBCevqb+WKCVUtlWu0yGaHcSS/Rqzqcyyz73NAs2HeVCgpiwl7
         qyDf/OOmsaE1wdI6CECAyRuvaRD8ZK2Qo74Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBKWev1Rs6wuYROdIel8IsWvzj2P6ShAsqmcV/ovcGg=;
        b=IqAV/svdrh8iesN5hV5keDxiB0tbgkeun5k+X8ZTLNgEnnPA+5DSGJK9kLrotvLSmc
         HL7KfnHdYXyRAv6JJFqGdZVrjM4zf6iDt3mkZr0gcmaiyh3QxfO1U8g8e0KZ8ZGa8vJb
         bstxrjDhpqHU6Of1jvooaikv7fxghEKRAc5KvB6W/sAN3rCIOUq+CL1Dkg4NCsBgB+HS
         lzAojNdfmwmpLFydutA7WgAiX3OP01OCpCn+i/hABCT5dJBNfbVRvjbEBUzJxz0h4pED
         hNPx4Fp0Da6iyuzqVYB5wUV3TDsbaFU3+DNt6gAYaILwaiLoFImIeqFL1RsCnZ28zqSY
         QF1w==
X-Gm-Message-State: AOAM530mRM0VqMmmxhNvF580u304xK5Nk+ha6+XoarxfMZUS9ExFnuoi
        HUPyxSPWPGNQQq4m0pvwh2Y55Q==
X-Google-Smtp-Source: ABdhPJwiDd12cCTBpPRK3Qx+yZmg4OYCNLukhEp72rnTZfahuBCeXEASHYbxM5Lfi1VPIE6ZI5K6PA==
X-Received: by 2002:a17:902:e34b:b0:166:342f:82c6 with SMTP id p11-20020a170902e34b00b00166342f82c6mr35312017plc.29.1654724426139;
        Wed, 08 Jun 2022 14:40:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y17-20020a1709027c9100b0016223b5d228sm15176202pll.288.2022.06.08.14.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:40:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] kasan: test: Silence GCC 12 warnings
Date:   Wed,  8 Jun 2022 14:40:24 -0700
Message-Id: <20220608214024.1068451-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3431; h=from:subject; bh=f4bWuW0f1isrySVA800mMFtNGe6OzsYc2hHoaLhCD+0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBioRdHHwaRwKKbpz1nkt1hw65Ms2PiFAooSZ7/hdvb /x/msieJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYqEXRwAKCRCJcvTf3G3AJm3yD/ wIJi5uSdbwIZpiSkKpBCwp+MzcWNoQclJTycpr4NCLKbPlepOG19bev3lzzPoAyBLUMRPvono2ZUn7 Z84NKF4HKmEHVEQpOyp3SaZ4LhWCgOeFSF5pNEngCqJNz6YJbITJf0NhsoDEpCuHeCc5kGd9XTXZpJ UU+djeG3geRtSbx2jnO6ralgR89jo02fozbjwp5ej+yVaJ2USgQ+Us1CvwufWlFSPUJbpXOcNTN21O V+Nw1zDXkv1aSORCghOHNQyREFiz466+WssNBEnq5TbsqU9TOM4VfqjRaV8Li70nxGMpXZKplxT7SD 3EXDu8JkTlX/lFQKxpdR7tBjC9+S7K988kneNgVXd1lp8hCuP1fTUNyg7KVAX+6H/Mc3iwQxsmgHMB NFC11iiiI36dIUST4xXEi+4GX2gb6FHTggQG+YIesttUPFDZH9tUbfIinkBW29tLMajecRRDA3EgPB m96Xy2mMe2qPAR1FZJxRNklTHMHZSmD2i96CJw1UsZWv9hC4NUniNGAlB7VzPkuPRK/LqLyiXvl6DU kNkrZGm1juLpUEVWVBsjMUElWb2kt0z+BHUSz/LaDv7Y3cYmXLvV9uHEDwUPKrInYZXulBc2BRwBho y4y/ZKxM8vqXVmqyAo0HoYQOzzC1qKXhumZTYLIF4SOur39wGcNJzUWy7Zcw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 12 continues to get smarter about array accesses. The KASAN tests
are expecting to explicitly test out-of-bounds conditions at run-time,
so hide the variable from GCC, to avoid warnings like:

../lib/test_kasan.c: In function 'ksize_uaf':
../lib/test_kasan.c:790:61: warning: array subscript 120 is outside array bounds of 'void[120]' [-Warray-bounds]
  790 |         KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
      |                                       ~~~~~~~~~~~~~~~~~~~~~~^~~~~~
../lib/test_kasan.c:97:9: note: in definition of macro 'KUNIT_EXPECT_KASAN_FAIL'
   97 |         expression; \
      |         ^~~~~~~~~~

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: kasan-dev@googlegroups.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_kasan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index c233b1a4e984..58c1b01ccfe2 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -131,6 +131,7 @@ static void kmalloc_oob_right(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	/*
 	 * An unaligned access past the requested kmalloc size.
 	 * Only generic KASAN can precisely detect these.
@@ -159,6 +160,7 @@ static void kmalloc_oob_left(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	KUNIT_EXPECT_KASAN_FAIL(test, *ptr = *(ptr - 1));
 	kfree(ptr);
 }
@@ -171,6 +173,7 @@ static void kmalloc_node_oob_right(struct kunit *test)
 	ptr = kmalloc_node(size, GFP_KERNEL, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = ptr[size]);
 	kfree(ptr);
 }
@@ -191,6 +194,7 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + OOB_TAG_OFF] = 0);
 
 	kfree(ptr);
@@ -271,6 +275,7 @@ static void kmalloc_large_oob_right(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 0);
 	kfree(ptr);
 }
@@ -410,6 +415,8 @@ static void kmalloc_oob_16(struct kunit *test)
 	ptr2 = kmalloc(sizeof(*ptr2), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 
+	OPTIMIZER_HIDE_VAR(ptr1);
+	OPTIMIZER_HIDE_VAR(ptr2);
 	KUNIT_EXPECT_KASAN_FAIL(test, *ptr1 = *ptr2);
 	kfree(ptr1);
 	kfree(ptr2);
@@ -756,6 +763,8 @@ static void ksize_unpoisons_memory(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 	real_size = ksize(ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
+
 	/* This access shouldn't trigger a KASAN report. */
 	ptr[size] = 'x';
 
@@ -778,6 +787,7 @@ static void ksize_uaf(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 	kfree(ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	KUNIT_EXPECT_KASAN_FAIL(test, ksize(ptr));
 	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
 	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
-- 
2.32.0

