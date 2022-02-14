Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B58C4B5A12
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiBNSla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:41:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiBNSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:41:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE63C6660D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:41:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t8-20020a259ac8000000b00619a3b5977fso35689258ybo.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=E45zQdBr6ruTkHcurHw8uDayMscfawE8DFtULZi8yRk=;
        b=gZbjmGVm8EuQ8SomnRmsmkxtfLLgZyQ7xWTM+SX/+3zcvXM81s+VNJxWA2JW2hEBuY
         JE+viXW20aaBu6y1sb15LLAhkVv6BJCDdQiI2KezUt1NaVHSIEC1MmjrP7Bl97fox/TB
         ip4uCcyerutLejtb2QA7abs1XupJwJZDncVgueBWTKBLv/hvxBvGydehRgL6nRZ7WKDy
         PeXAx/BdhsN0mpRfllEeobwFP7GODRdYiXvA3ibRIqldNZzMMjYUzU8Ks22XMnFyWbga
         UIcCNjIVQHhbjYZJWEuAkowcBonRvFoxo4iUrM0mXQ7LbI+Rk67dWPxv2e6fHnvUMOam
         5a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=E45zQdBr6ruTkHcurHw8uDayMscfawE8DFtULZi8yRk=;
        b=g2ntCvhXw+F6uTDDXbPw+u0qC4DfM0Lae2Y5n10U1uUehwyl27rhkSSIYiyUESfze+
         T6R2puwD74Al2kQ8dn0Q4Wo8pJmBbvY2UwhFnixhVAE6e6nALFDm9qegWqlBiwWhrN7I
         8tB0RFUBNGAc+DgcIu/o/+StSaPNBcdbH/7VVcFRgD/sbYCT1FdwRAwDpR2Kc02gtDPs
         uquZvgGy4ZL4gSnmdcDqo/k7QjQpRoM11t0UakinuJSDIAtRaaeCZhG8oSW7vjMjApTh
         FlHVussklVNfKyF3P7t90gnaG9wLcxUdjN6CJVhldqVDThMrL4e06hB1bCmSmFjwkiyo
         mOJQ==
X-Gm-Message-State: AOAM5338+4WjOAW76NWwA2kU9qBUIUgVJWrbTSsW1Dj3oYyStaHwMC6h
        +8fKklH9hyvXnYMzrHQJ9ZwWN2fGd4IG7Q==
X-Google-Smtp-Source: ABdhPJzKFWSRk14MngihAAnQtbORLt/Ao2wF5HvVoHEIqs9ChhrlhtlbhelcPLHm4KOwzZCf2kDpcABwhgOtPA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:c25b:4e93:9d4c:bbf6])
 (user=dlatypov job=sendgmr) by 2002:a25:d88e:: with SMTP id
 p136mr391659ybg.716.1644864076043; Mon, 14 Feb 2022 10:41:16 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:41:04 -0800
Message-Id: <20220214184104.1710107-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH] thunderbolt: test: get running under UML, add kunitconfig
From:   Daniel Latypov <dlatypov@google.com>
To:     mika.westerberg@linux.intel.com
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-usb@vger.kernel.org, Daniel Latypov <dlatypov@google.com>
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

These tests didn't work under the normal `kunit.py run` command since
they require CONFIG_PCI=y, which could not be set on ARCH=um.

Commit 68f5d3f3b654 ("um: add PCI over virtio emulation driver") lets us
do so. To make it so people don't have to figure out how to do so, we
add a drivers/thunderbolt/.kunitconfig.

Can now run these tests using
$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/thunderbolt

Potentially controversial bits:
1. this .kunitconfig is UML-specific, can't do this for example
$ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kunitconfig=drivers/thunderbolt
2. this removes the manual call to __kunit_test_suites_init(), which
   allowed us to control exactly when the tests got run.

The main motivation for both is convenience.

For #1, we could drop the UML specific options, but then users would
always have to set --arch. Since UML is a bit faster and there's less to
type when running it with kunit.py, let's make it work by default.
Users can manually edit the .kunitconfig to run under x86_64.

For #2, running our suite separately prevents kunit.py from picking up
results properly as it only parses one set of KUnit results. I.e.
there's an assumption that __kunit_test_suites_init() only gets called
once. Since the tests seem to run fine when kunit runs them, giving up
this control seems fine.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 drivers/thunderbolt/.kunitconfig |  7 +++++++
 drivers/thunderbolt/domain.c     |  3 ---
 drivers/thunderbolt/tb.h         |  8 --------
 drivers/thunderbolt/test.c       | 12 +-----------
 4 files changed, 8 insertions(+), 22 deletions(-)
 create mode 100644 drivers/thunderbolt/.kunitconfig

diff --git a/drivers/thunderbolt/.kunitconfig b/drivers/thunderbolt/.kunitconfig
new file mode 100644
index 000000000000..c8c9467bc144
--- /dev/null
+++ b/drivers/thunderbolt/.kunitconfig
@@ -0,0 +1,7 @@
+CONFIG_PCI=y
+CONFIG_VIRTIO_UML=y
+CONFIG_UML_PCI_OVER_VIRTIO=y
+
+CONFIG_KUNIT=y
+CONFIG_USB4=y
+CONFIG_USB4_KUNIT_TEST=y
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 7018d959f775..dedc2866f51b 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -878,7 +878,6 @@ int tb_domain_init(void)
 {
 	int ret;
 
-	tb_test_init();
 	tb_debugfs_init();
 	tb_acpi_init();
 
@@ -896,7 +895,6 @@ int tb_domain_init(void)
 err_acpi:
 	tb_acpi_exit();
 	tb_debugfs_exit();
-	tb_test_exit();
 
 	return ret;
 }
@@ -909,5 +907,4 @@ void tb_domain_exit(void)
 	tb_xdomain_exit();
 	tb_acpi_exit();
 	tb_debugfs_exit();
-	tb_test_exit();
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 74d3b14f004e..db54f8a27ba8 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1261,12 +1261,4 @@ static inline void tb_service_debugfs_init(struct tb_service *svc) { }
 static inline void tb_service_debugfs_remove(struct tb_service *svc) { }
 #endif
 
-#ifdef CONFIG_USB4_KUNIT_TEST
-int tb_test_init(void);
-void tb_test_exit(void);
-#else
-static inline int tb_test_init(void) { return 0; }
-static inline void tb_test_exit(void) { }
-#endif
-
 #endif
diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index 1f69bab236ee..601c04aaa7d9 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -2725,14 +2725,4 @@ static struct kunit_suite tb_test_suite = {
 	.test_cases = tb_test_cases,
 };
 
-static struct kunit_suite *tb_test_suites[] = { &tb_test_suite, NULL };
-
-int tb_test_init(void)
-{
-	return __kunit_test_suites_init(tb_test_suites);
-}
-
-void tb_test_exit(void)
-{
-	return __kunit_test_suites_exit(tb_test_suites);
-}
+kunit_test_suites(&tb_test_suite);

base-commit: 754e0b0e35608ed5206d6a67a791563c631cec07
-- 
2.35.1.265.g69c8d7142f-goog

