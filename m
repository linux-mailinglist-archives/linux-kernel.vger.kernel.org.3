Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361CB4AE95C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiBIFfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:35:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240128AbiBIF21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:28:27 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAB7C035418
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:28:30 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id w3-20020a170902a70300b0014cced44ad7so1030548plq.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 21:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HnCcKGZHmANVeTKSqjJ8fr7e3oS/Q8scdOC+KonXnFM=;
        b=p7SepyAYaSxapPXJoJyxkPrvHpAKiJ50CdTEXTRhsjMOCggG/qbZWXbSYEcjHJwJSm
         NUpKEP8rmA34ubXBsZEdkxYguJ0pceqIUmM/vZb9BBc9+5JlxoRQIIR88CWE0LlDKvbk
         9BtotfJ3dIAoquSf3xA1fK2vjDn1QL+oQzojovHEnMF7253yQFApGMi8C5lfCfG2Z/xc
         GeQunm2jEmxrQon1vvh5Cft+AuEi+ydkyYErWk01UqwyGDbe6wX7uosqcjS5oavD5cAi
         PtBFXfH8pjn0xzwkQdUZZQ8OLuKaSPCRTsoVRqU970ssWPCqucVE7DTER984auzhxcNn
         obYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HnCcKGZHmANVeTKSqjJ8fr7e3oS/Q8scdOC+KonXnFM=;
        b=aGAFdHUHKbUB9ymQsMliN0bHVZYOb0/0SGcfNWgdVhWFxIYS0CZtV7j8IVroczMhqJ
         2ySctLl/IcuEku9vrNcA1OqZ5L11KwPx7qySNRG+HFj6G3Z55fn3M2ko3UR7jsgO/wqp
         csalxTdPx59ou4DeI56W1p3k0oDC+Tu1xJQrCWDsd1M4m5zbWJ8IfCMtE0uM/OVh3FXK
         xuVmky3M9MG7SKvzwJt1fWIgG37lAsd7rdu8YN34JpSKqLKW35tpxW5LTHvmD7+65psY
         DSaHdVwGrKOTWMT2v6xsy5hbD/0G/slA2MFIzXumck8EKBBfqAyaX4c3JH+6O+7osaht
         WKLQ==
X-Gm-Message-State: AOAM533XBuJWcHmftb1alLTOEGwwn/xDqpcqEuHaxWPG6Njn0UYjzn5n
        uKkG/iMhX77a/nyQHBO+XySZuNkxmL7BmA==
X-Google-Smtp-Source: ABdhPJzECr248U9TepR8lY3SYNo34GWVugZSFlCvDHeAmMP8L+MucgM9IaNdruspg2yOuPa6IUhaWa5JLvzXhA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:5d01:: with SMTP id
 s1mr739055pji.154.1644384509868; Tue, 08 Feb 2022 21:28:29 -0800 (PST)
Date:   Wed,  9 Feb 2022 13:28:13 +0800
In-Reply-To: <20220209052813.854014-1-davidgow@google.com>
Message-Id: <20220209052813.854014-3-davidgow@google.com>
Mime-Version: 1.0
References: <20220209052813.854014-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v3 3/3] list: test: Add a test for list_entry_is_head()
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
---

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
index 19f13059439b..869caae14b10 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -548,6 +548,26 @@ static void list_test_list_entry(struct kunit *test)
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
@@ -763,6 +783,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_splice_init),
 	KUNIT_CASE(list_test_list_splice_tail_init),
 	KUNIT_CASE(list_test_list_entry),
+	KUNIT_CASE(list_test_list_entry_is_head),
 	KUNIT_CASE(list_test_list_first_entry),
 	KUNIT_CASE(list_test_list_last_entry),
 	KUNIT_CASE(list_test_list_first_entry_or_null),
-- 
2.35.0.263.gb82422642f-goog

