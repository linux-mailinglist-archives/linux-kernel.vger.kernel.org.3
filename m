Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273384C3BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiBYCxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiBYCxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:53:46 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7B1278CB1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:53:15 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id h128-20020a625386000000b004f10a219a98so2363843pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2puWIl3IcpbmEtDoBGd8mpwWXz/flgK5gtzvJt22Ibg=;
        b=V7A8Rb2FXvpOWQfWfzts5uMpUAXDUD+M3X+h/q51ZiFHnsqw6bhHOmPnaoE/ZY5iOQ
         C8orkMrqUIiLMxOLijz28b1G+810z04aGpYpY4X0pI3wqm7P/t7sWYKk1aXduo9gdbhw
         1RyDvYEIhp+V2Sa8MxaG/5Ur286JFCurw2fjxoe8oAj4IeSjVCCKYjadlmyL25pI9aNo
         SApjixcEDESi3VEHQZ6r++HehdafCfN2K3xj1eXCQ1+cM6e3EgyVe5mecBCKCOaQi8ut
         d8F+eBLvh2qcv4lPsWt+D65gG3/e8tGPx77ArCe2k0ONFiJ65/xXlcROmNm4FaBDWBfy
         Qtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2puWIl3IcpbmEtDoBGd8mpwWXz/flgK5gtzvJt22Ibg=;
        b=BIemKRAFOQYdthb/nb9zKkcwLUQdOa9xQgOr4GBJqXHtI5WawGBJCc+riA9USuILUe
         PUBCH9e8t2jSwU/nCX/2dSoS8VByAUXoj3bD8Lnl1x+DBE2e8/5o3c130+S2OGLvVoeD
         q71mhMaX2/elhmWN9VYqzhWcdyjBRqlVrvQh/IsAlPX1bikwlq4xDZXF4mtzNUUjfwwy
         zmb1YN9NUDKdpQJ18nJSzew1TJPZSLMSlBA0KCcAhbAlprNUDF6K78S0FbB1jj0eLeLt
         5+JRDw43gPhv/XohwXx+u87v/32G2Wnx70Aszm3fNac8Icy2g/gYh8K48/KaVXKXv1hy
         0p6Q==
X-Gm-Message-State: AOAM530cX3RYjMAgtwk0cOrP7uv6iEvIVnTQboKct1qwyNC3MBG8pKRg
        7VifhWyONXertYhE+6Bq/rWnDIG7ae2gYg==
X-Google-Smtp-Source: ABdhPJyAVL+KVNuKKmj4OCwnf0mb2V2caveapLa1ZAGZW4xhwAdHDu2wqfAIMOl8UrftyjkEAcI9bMuubXYhJw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:4b52:b0:1bc:b208:dc5c with SMTP
 id mi18-20020a17090b4b5200b001bcb208dc5cmr139771pjb.1.1645757594543; Thu, 24
 Feb 2022 18:53:14 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:52:46 +0800
Message-Id: <20220225025247.1888244-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 1/3] list: test: Add test for list_del_init_careful()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes since v3:
https://lore.kernel.org/lkml/20220209052813.854014-1-davidgow@google.com/
- Fix a comment style issue.
- Add Reviewed-by tags.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220208040122.695258-1-davidgow@google.com/
- Fix the test calling list_del_init() instead of
  list_del_init_careful()
- Improve the comment noting we only test single-threaded behaviour.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220205061539.273330-1-davidgow@google.com/
- Patch 1/3 unchanged
---
 lib/list-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index ee09505df16f..302b7382bff4 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -161,6 +161,26 @@ static void list_test_list_del_init(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
 }
 
+static void list_test_list_del_init_careful(struct kunit *test)
+{
+	/* NOTE: This test only checks the behaviour of this function in
+	 * isolation. It does not verify memory model guarantees.
+	 */
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a -> b */
+	list_del_init_careful(&a);
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
@@ -707,6 +727,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_replace_init),
 	KUNIT_CASE(list_test_list_swap),
 	KUNIT_CASE(list_test_list_del_init),
+	KUNIT_CASE(list_test_list_del_init_careful),
 	KUNIT_CASE(list_test_list_move),
 	KUNIT_CASE(list_test_list_move_tail),
 	KUNIT_CASE(list_test_list_bulk_move_tail),
-- 
2.35.1.574.g5d30c73bfb-goog

