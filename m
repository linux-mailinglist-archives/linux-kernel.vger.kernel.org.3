Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C27B4C3BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiBYCyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbiBYCyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:54:23 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6E4278CB5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:53:52 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x194-20020a627ccb000000b004e103c5f726so2341220pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V1rQ4nquNp18jfgzfW9vZ+glyyMNehUDY2htsrduhLY=;
        b=BZmWVijfvQImtZ6KfmIcvMhyC1etJR7CWjsko9mlIe0tq5RLpWAsjNcMKR8wyzqXJR
         nYTEMgzfFeB9SJ3lQjC9u7f+7tBAVYHLsAdLY8Mb4qEJLDV0iXBhpws9Mqq5LEHWyRWb
         K6KUA5ClL5grlHnjFsu44kuWjMedffDqmxIh52krhWg2RqIL+/4wpKXmwhVFfProTrHY
         xNoJANmXL4yJ/MkDTXTCrgGhiHpwbpEwtCiCa/WlIZgRVopwIzgfPgFPacQch7tyMgLj
         S4KuD69r+6hpk4LOtKFSbzLBDV59eKDCfuVGZdmgA5maLkIfBry6mSulKZYFYN/x5NHs
         /8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V1rQ4nquNp18jfgzfW9vZ+glyyMNehUDY2htsrduhLY=;
        b=qv6ZMA6hN9IZ4JtJMS25ngbKW8WKDIMmhMFa66Ow1uEubbY5oK7z4QB/C4ELuoBXDJ
         Ned3sH3SdvGJYtOxqM2ed6JYcNA68HPIqOJ/hqr7Gd4CyW1XdB96awe+RZ7IW5eXDou/
         ZSip5DUleQBbbJBJaQ54ncRoQYSqcFqIg7In2lQhB7vtwR452TfEgc0S4VayTd5BDyHl
         j5rU+QyN9F/G24iDwHvEQxvMQpNtbU8voeSLqAU1jpsasdXePEivh0YG4yLcVB5w3LTc
         19MXy3R+iuuzhS0QfoCyETUfv0tCMrZXd2v5+T2Pl0fWTO9OwVSjBU2gA3zHxgM8vvgj
         lVtg==
X-Gm-Message-State: AOAM532u77eIzslIWJ2YSIzPxPaI5XW/Dqqi7Q2gCY4iwVgvEcBECJLo
        XTpQYPKwVDzKoVek0iTl7OlcjVM4AQ20lg==
X-Google-Smtp-Source: ABdhPJyET4zKPHUz257ncAUxuaxKKi7dMHrY4HWUqKL5zPsnxifIleo7FNHDaCAiF1dwtX2n/rX/AdH+KX3BTQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:6001:b0:1bb:83e8:1694 with SMTP
 id y1-20020a17090a600100b001bb83e81694mr1078322pji.127.1645757632007; Thu, 24
 Feb 2022 18:53:52 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:52:49 +0800
In-Reply-To: <20220225025247.1888244-1-davidgow@google.com>
Message-Id: <20220225025247.1888244-3-davidgow@google.com>
Mime-Version: 1.0
References: <20220225025247.1888244-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 3/3] list: test: Add a test for list_entry_is_head()
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

The list_entry_is_head() macro was added[1] after the list KUnit tests,
so wasn't tested. Add a new KUnit test to complete the set.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e130816164e244b692921de49771eeb28205152d

Signed-off-by: David Gow <davidgow@google.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes since v3:
https://lore.kernel.org/lkml/20220209052813.854014-3-davidgow@google.com/
- Add Reviewed-by tags.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220208040122.695258-3-davidgow@google.com/
- Use the _MSG variants of the assert macros, as suggested by Daniel
  Latypov.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220205061539.273330-3-davidgow@google.com/
- Rework the test entirely to better match the improved list_is_head()
  test.

---
 lib/list-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 3870ebfd84aa..035ef6597640 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -549,6 +549,26 @@ static void list_test_list_entry(struct kunit *test)
 				struct list_test_struct, list));
 }
 
+static void list_test_list_entry_is_head(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2, test_struct3;
+
+	INIT_LIST_HEAD(&test_struct1.list);
+	INIT_LIST_HEAD(&test_struct3.list);
+
+	list_add_tail(&test_struct2.list, &test_struct1.list);
+
+	KUNIT_EXPECT_TRUE_MSG(test,
+		list_entry_is_head((&test_struct1), &test_struct1.list, list),
+		"Head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test,
+		list_entry_is_head((&test_struct2), &test_struct1.list, list),
+		"Non-head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test,
+		list_entry_is_head((&test_struct3), &test_struct1.list, list),
+		"Head element of different list");
+}
+
 static void list_test_list_first_entry(struct kunit *test)
 {
 	struct list_test_struct test_struct1, test_struct2;
@@ -764,6 +784,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_splice_init),
 	KUNIT_CASE(list_test_list_splice_tail_init),
 	KUNIT_CASE(list_test_list_entry),
+	KUNIT_CASE(list_test_list_entry_is_head),
 	KUNIT_CASE(list_test_list_first_entry),
 	KUNIT_CASE(list_test_list_last_entry),
 	KUNIT_CASE(list_test_list_first_entry_or_null),
-- 
2.35.1.574.g5d30c73bfb-goog

