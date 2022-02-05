Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820D34AA714
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 07:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359159AbiBEGQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 01:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbiBEGQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 01:16:24 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD77C061346
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 22:16:06 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id y14-20020a17090ad70e00b001b4fc2943b3so10025594pju.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 22:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vV1A3NKa8ohktKkIEGZo1VCH/ZlIgtA2YFnmP/ZP+iE=;
        b=l6dtqMZg2rtStETNCrBqau9WjMDhnM2XTGBgVwNv/XeiFQRQHDE7ovqTiPuzEtjHMj
         //gBIsUAXp+8CJQzrip2BLwNWg+dxcvGmHqADds+7h3+2s+Hm/TtoD+gDdk30KWC4+cv
         u30e1ul6b6ea5RjS1/R+ccQKRsiYz/0hBG6s+BTwjS6jtNvj5CWffFTtT7KlBnRRbrFd
         uXyv1K4hS6Ij9SFk7m+fPO4DM280BQSQx2EBcsAR2FBFw2dcbX2/aKcsuMDS1NLqvmX8
         LTcH8BQBDCUSG+Nlp+/CVo27prma3RF+Vp9hIrBEshuLAhb50zi5d9g5F7XiDm4pSeLv
         Ndig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vV1A3NKa8ohktKkIEGZo1VCH/ZlIgtA2YFnmP/ZP+iE=;
        b=6l8ip4TtDXRFTV42pGAyVHUMk12Di3IzODU4Yv9w9AXGiRPciwmFyNil6AMBsA7Fq8
         k/SQ9FSDaOYnc5JO0ir0/xxDxNU0DuP8YFu3nVNn0xlYffYdEQuPbw15uB4UO34KG4wt
         ZCBzC9ZCOqIk7I1+oK+QN8bTVxrzUIRINbHiYAdWIOwy5ZAx63KOOtXj8KPfwCCX/7jy
         K1IdbcP7bnOnuBjWch6RIyZd+UVzMBP7ntATdnfltnLle/LBiyDyCLLQ5uD11WsKMtl3
         RwG/muOVC7tQ4pxoKtPu4k2rzfJ7tmGW0ZZZyOCxSjWeHPqmRCOoSdPDowhjIbzVoODp
         6cHw==
X-Gm-Message-State: AOAM531nKH32hmVPFl/pzNyvX1fhQc8zjDgCA0ZvRXiPQNoVWaMH9j90
        Ih7ebvqSmtUY/MrqjRlFHCQ9zuc2G7orlA==
X-Google-Smtp-Source: ABdhPJyZdn33EiW+IAbpGPjVLz9f0aWxmwA0TrAs0tV5/qpiJgyy9Ff42kGHtC/0zn55iAJaLT/ThnAhz7On1w==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a63:1315:: with SMTP id
 i21mr2004840pgl.10.1644041766044; Fri, 04 Feb 2022 22:16:06 -0800 (PST)
Date:   Sat,  5 Feb 2022 14:15:36 +0800
Message-Id: <20220205061539.273330-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 1/3] list: test: Add test for list_del_init_careful()
From:   David Gow <davidgow@google.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list_del_init_careful() function was added[1] after the list KUnit
test. Add a very basic test to cover it.

Note that this test only covers the single-threaded behaviour (which
matches list_del_init()), as is already the case with the test for
list_empty_careful().

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6fe44d96fc1536af5b11cd859686453d1b7bfd1

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/list-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index ee09505df16f..976e9ae1f3c5 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -161,6 +161,24 @@ static void list_test_list_del_init(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
 }
 
+static void list_test_list_del_init_careful(struct kunit *test)
+{
+	/* This test doesn't check correctness under concurrent access */
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a -> b */
+	list_del_init(&a);
+	/* after: [list] -> b, a initialised */
+
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
+}
+
 static void list_test_list_move(struct kunit *test)
 {
 	struct list_head a, b;
@@ -707,6 +725,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_replace_init),
 	KUNIT_CASE(list_test_list_swap),
 	KUNIT_CASE(list_test_list_del_init),
+	KUNIT_CASE(list_test_list_del_init_careful),
 	KUNIT_CASE(list_test_list_move),
 	KUNIT_CASE(list_test_list_move_tail),
 	KUNIT_CASE(list_test_list_bulk_move_tail),
-- 
2.35.0.263.gb82422642f-goog

