Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92784AE95B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiBIFfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:35:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240118AbiBIF2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:28:21 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3B1C03324A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:28:25 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id md16-20020a17090b23d000b001b8bd5e35e2so1052403pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 21:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=36z3XIrw+2wjLy8oTFViegQpDWukcoi9C46U/6NGCkg=;
        b=q8HJ+Nks3S0Qn0OnlSvLpHmRkTK4vcod4NMS/us3rncsxEupbJ2LDkaLJ04V4sKgsx
         4Gs3NNNAd88WMVaGtUvfR24FoGsThPIfkxJV4fO9lwlfRyl8OcycT5kcfZ9DBk4RtMJ4
         fqKkRybLiBmsuV/zGjhmUxrIkNYIdRnB/RTZdZaitzKCrDRPVZntRU9pvD8Kr0HA2AfE
         mD1GfNB1xaugiHhyJiHYlWDjgCQH8j+Bla89yvKfQy0+UXeqDy5lw/2Z0An3iBESC04m
         dpmzpbx6WYykORa7+6HF9N78+sjrdszJ385TqeKY7t+u4HPzi/8FPkWJiV4UEiu6vkLm
         SM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=36z3XIrw+2wjLy8oTFViegQpDWukcoi9C46U/6NGCkg=;
        b=ukd1g0v0He7OYw8kTsO/1ycuY0ryZS24ejA5TfnSK+wzaFqLPtdkPR6N10TtfT1mGg
         VGjkIi2RWF/zD5GqgWhNPeaqpN7qiEWt9MYrxYbrpkUO81fbOQlSbutmXMBo3gfYjoZC
         5jZeiuP8M7Akli0UKQ0JVc/xqNHO4h/DtjzHmrTA+jJVeklLzkLT9GN2bydNqUmzfwdx
         4HrJjUfFk/k+esDoPdHK4G+Evixjmkt3cqbn1SYKAOtb2aul3Y15acImru77WCK+oy4j
         fydaAfE6NhtBCu60+Lv7NfNZ9oDf3+/BoIfZUvRD77oGdzMXir8WYHXnC1aoENPpTYgS
         feLA==
X-Gm-Message-State: AOAM5300XAj6udAFHVq4PmFs00HTDh6PiYplLwVk9xVve3iwWcZkZaQV
        e8BH1XU6ZlXJncgxrmsm0QwLrJv/VI0/mw==
X-Google-Smtp-Source: ABdhPJwEgPgaGJ6lZHG3y/lAPWiYglNFr0d4i21HEm2YLa/giqpI4sGooKqWKwbxwW8/GpORGagMe5afVCXDVg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:985:: with SMTP id
 5mr702735pjo.217.1644384505266; Tue, 08 Feb 2022 21:28:25 -0800 (PST)
Date:   Wed,  9 Feb 2022 13:28:12 +0800
In-Reply-To: <20220209052813.854014-1-davidgow@google.com>
Message-Id: <20220209052813.854014-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220209052813.854014-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v3 2/3] list: test: Add a test for list_is_head()
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

list_is_head() was added recently[1], and didn't have a KUnit test. The
implementation is trivial, so it's not a particularly exciting test, but
it'd be nice to get back to full coverage of the list functions.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/list.h?id=0425473037db40d9e322631f2d4dc6ef51f97e88

Signed-off-by: David Gow <davidgow@google.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
---

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220208040122.695258-2-davidgow@google.com/
- Use the _MSG variants of the assert macros, as suggested by Daniel
  Latypov.
Changes since v1:
https://lore.kernel.org/linux-kselftest/20220205061539.273330-2-davidgow@google.com/
- Test both non-head elements of the same list and head elements of
  different lists.

---
 lib/list-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index f82a3c7788b8..19f13059439b 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -253,6 +253,24 @@ static void list_test_list_bulk_move_tail(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, i, 2);
 }
 
+static void list_test_list_is_head(struct kunit *test)
+{
+	struct list_head a, b, c;
+
+	/* Two lists: [a] -> b, [c] */
+	INIT_LIST_HEAD(&a);
+	INIT_LIST_HEAD(&c);
+	list_add_tail(&b, &a);
+
+	KUNIT_EXPECT_TRUE_MSG(test, list_is_head(&a, &a),
+		"Head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test, list_is_head(&a, &b),
+		"Non-head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test, list_is_head(&a, &c),
+		"Head element of different list");
+}
+
+
 static void list_test_list_is_first(struct kunit *test)
 {
 	struct list_head a, b;
@@ -730,6 +748,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_move),
 	KUNIT_CASE(list_test_list_move_tail),
 	KUNIT_CASE(list_test_list_bulk_move_tail),
+	KUNIT_CASE(list_test_list_is_head),
 	KUNIT_CASE(list_test_list_is_first),
 	KUNIT_CASE(list_test_list_is_last),
 	KUNIT_CASE(list_test_list_empty),
-- 
2.35.0.263.gb82422642f-goog

