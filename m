Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40094B3CDE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbiBMScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:32:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiBMScl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:32:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23BC575FD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:32:35 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id x3so8882183pll.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GbN1m5GjdzaYtEly7rnCE3vNXf0FkYK/naaa45R/epk=;
        b=GAsZqZDapq/V16jBy3rZ7Dnbf9uE83eqvg/Sh35MKq+OMPn7yycsm+4V6P4/Elf3Nm
         QY2R0tMqPm5yGDgQQ2iDpVoGdgDrkHrfNkpwU6Ud9o04G1wlcU90nbKq5QbBruKBM4cK
         +q8n/wCTyCrqdUJE/dHrj8+Snhe+MkcMMRduE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GbN1m5GjdzaYtEly7rnCE3vNXf0FkYK/naaa45R/epk=;
        b=H8mh7TDIwlxY7MSUmmHkctQ0bca8gNNhZZHRPzeH25yB2NRaHajcY0xMk9FIOc7EyM
         ig+l6iGkqYweyr2+jD2e0mnh9/2M0jNmE05HkDZS9NXPpe+68PbXGTX9EoUn14+3vFDh
         0mwG2KZoIR4T7CIdTzSBvEaOE4Dt1auVH7qRN5d04PkRuHLwfRfAO/zvZ4cnyHfqtnG4
         aHVah5P8BrYc1P99lFRWg07Sc7Zw4gIW3KscP0dju+YIUKPoHJpnHqj/oTo5O1Y0tVt7
         bOkoWZuhBJXzK1rm88ufYMAxVwAaWf6Wt/iVyjZoF4WvbOdT48fDo0jWtMGDGSadmxIZ
         vfaQ==
X-Gm-Message-State: AOAM531W/G7+1KsEWVISDa4V4lSH8Jcu7HdLNKlkdfjR3BOgPAifYfBp
        m6a5GXnR1K53mJz2KCCmxXgWSg==
X-Google-Smtp-Source: ABdhPJxIvU8YshqC540BFqX03wOgnip+o/Ur/2WzPZDFcquGanRGjudN8XpUTW0jzKbr+1o0UP8xdw==
X-Received: by 2002:a17:90a:c7cf:: with SMTP id gf15mr10802631pjb.83.1644777155479;
        Sun, 13 Feb 2022 10:32:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j2sm33728429pfc.209.2022.02.13.10.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 10:32:35 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] kasan: test: Silence allocation warnings from GCC 12
Date:   Sun, 13 Feb 2022 10:32:32 -0800
Message-Id: <20220213183232.4038718-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2824; h=from:subject; bh=9u7Cd7ajn+8VmlBggVW9I93wUx5ifwsTV6OZFwgwhrM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiCU6/gcktGKuswV/wNYH+QUBfdaSH8kMaFAvY83FQ ph5DlX+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYglOvwAKCRCJcvTf3G3AJv+tD/ 0f4VQg7uhKWf8BVJWIrY90fqUSCg1jxlya8ImO4GTv7SnS2huBhD3gvcwvxMtKTBTaR66ijo2duyI7 6i/R4ysAKYnFzcVGZVlIwztISpnXG2aCDszH6/9vxsKZT0WArlKqRIqbQjeykzbCCaR8bxpEBAFin2 htLRBbiZeIK/7ITXcNa2EBwmcB3UjN+XLGKaARJgehBunT+W6VFR2H5xM0R3mLvM6vCCQtJ6VFienm PPMNaXG8ai3zXd5d4rN9qbWH9ie3xPjVRze8vKTKPzk16+A5EHP2to7DOWORwlSLLUi/SOcRDknkSw tQxGILWKjx7bLbEwtignkRLipkgt0twRlTP7p73Ss7JM55Kw08KlQRjE+S4aQyc/9tgwBwU5aYuExW 2At+7hE9R/6vEZ/gi1tKolhnItAeh/yHgR/vvCPmSfeaUjKrtDSQ6tkzpjEUPvwXWFIKA42c6xlQSL brzc35QiULxWnwydILbzuOvAUvNR1a4kqISFIADBcXJYELaLqe32E/Be3zIfR5DfTy9aQXQNJvIuR9 x1DBYfSET2fDsWASvaZqIfGYI5m7BqKiYDP9Y9E8r4O86SOvtvkfp81wVCamYcKvyx40Kp6SYdiLCd IWUuwzekAYY0r1WDsvsd3cBgfsOm+QaXU9FsSlbr7ofiVKO7H5ShRQwDBdOQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 12 is able to see more problems with allocation sizes at compile
time, so these must be silenced so the runtime checks will still be
available. Use OPTIMIZER_HIDE_VAR() to silence the new warnings:

lib/test_kasan.c: In function 'ksize_uaf':
lib/test_kasan.c:781:61: warning: array subscript 120 is outside array bounds of 'void[120]' [-Warray-bounds]
  781 |         KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
      |                                       ~~~~~~~~~~~~~~~~~~~~~~^~~~~~
lib/test_kasan.c:96:9: note: in definition of macro 'KUNIT_EXPECT_KASAN_FAIL'
   96 |         expression;                                                     \
      |         ^~~~~~~~~~
In function 'kmalloc',
    inlined from 'ksize_uaf' at lib/test_kasan.c:775:8:
./include/linux/slab.h:581:24: note: at offset 120 into object of size 120 allocated by 'kmem_cache_alloc_trace'
  581 |                 return kmem_cache_alloc_trace(
      |                        ^~~~~~~~~~~~~~~~~~~~~~~
  582 |                                 kmalloc_caches[kmalloc_type(flags)][index],
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  583 |                                 flags, size);
      |                                 ~~~~~~~~~~~~

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_kasan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 26a5c9007653..a19b3d608e3e 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -124,6 +124,7 @@ static void kmalloc_oob_right(struct kunit *test)
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);
 
 	/*
 	 * An unaligned access past the requested kmalloc size.
@@ -185,6 +186,7 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + OOB_TAG_OFF] = 0);
 
 	kfree(ptr);
@@ -265,6 +267,7 @@ static void kmalloc_large_oob_right(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 0);
 	kfree(ptr);
 }
@@ -748,6 +751,7 @@ static void ksize_unpoisons_memory(struct kunit *test)
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);
 	real_size = ksize(ptr);
 
 	/* This access shouldn't trigger a KASAN report. */
-- 
2.30.2

