Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92C552D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346143AbiFUIye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348545AbiFUIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:54:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C5025EB9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:54:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-317765eb7ccso109026847b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DchQK2viXsxkr0f/jfzsYvXYlWuEWS/lEXqIapl6jbA=;
        b=iH+jyDe4Vr+y3lYEAw/bnOLR1n9VHEu7hiai9Lvj4kPCzaIXgG2dPc/z+Z78lsUzZt
         TzEr/nP8IS+qJ9DdfFNgy0PX0oYFvIrN5x96ek3RLzaw0ogBKctxJ/5t0xretkIwTCUZ
         GZokqzWjGel0mkIxQsPbMZXBS3Wn05igJREZrp/A3jg2uFB13A0oNmRyyJkPeWnwjUIo
         +XsNT+MwlHV4Ms/ntLIl3vkE9IPMikNCyfjtlyWM4XfitIDbXIRPdPG28IDShtU6v4Vz
         OCl1ZYSSFKfUR2XmtFHi0zp8O6OiMuOvW045qtw6r2CSxQjdrnptMG9ws91nSxp7951A
         j38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DchQK2viXsxkr0f/jfzsYvXYlWuEWS/lEXqIapl6jbA=;
        b=QxPlCSFmFeuKI8DxQxye/KVnZ1BXuVkiP+5JeDRgawUhmqZk4Ti1ZMBRP7qn4HRlbC
         0XgMrVkiDHTsCb7aXfFQnHPDbs3c5XytEHpxlttTZMYo4TprDEGaa2YxRAs64XJb9gU4
         VtsmlIY38p32C7F915jzQHVvHBFxyFHIoSJZ91FU5oK6BaaX1s4bALiTtP45xyE1pAj9
         WNfCUmH6evxwLpNqFKLR+SphqgLIdUDu36GPGxP2oCA93e3D4JfnP8xZCm8dF8qZUhIw
         EuyYeeNV6A3xN8yc0YVQuaAaUCLdCFHmmt1/HiLzFYB2rb5K9KGNYtFF9NVu6lT52Xzs
         +ywg==
X-Gm-Message-State: AJIora9vuNbTcaXDSUVV2Bx837mqc/KWLJKseuXJz6MMSV034JRK62Ne
        AIsj01yRjzewPv4cHHfvXQC2I4Ynr1XKoA==
X-Google-Smtp-Source: AGRyM1vclyw2UviD+6BJjiqGiH89PLnaDXTc8R06OQqZCeV6zUeCfyzzWCLPXdM4WJOQPfEytzN5Med0lEp1BQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:246:0:b0:668:ccd9:6087 with SMTP id
 67-20020a250246000000b00668ccd96087mr18417314ybc.290.1655801650476; Tue, 21
 Jun 2022 01:54:10 -0700 (PDT)
Date:   Tue, 21 Jun 2022 16:53:44 +0800
In-Reply-To: <20220621085345.603820-1-davidgow@google.com>
Message-Id: <20220621085345.603820-5-davidgow@google.com>
Mime-Version: 1.0
References: <20220621085345.603820-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH v2 4/5] nitro_enclaves: test: Use kunit_test_suite() macro
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>
Cc:     Paraschiv@google.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Ma=C3=ADra=20Canal?=" <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
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

The kunit_test_suite() macro previously conflicted with module_init,
making it unsuitable for use in the nitro_enclaves test. Now that it's
fixed, we can use it instead of a custom call into internal KUnit
functions to run the test.

As a side-effect, this means that the test results are properly included
with other suites when built-in. To celebrate, enable the test by
default when KUNIT_ALL_TESTS is set (and NITRO_ENCLAVES enabled).

The nitro_enclave tests can now be run via kunit_tool with:
	./tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_SMP=y \
	--kconfig_add CONFIG_HOTPLUG_CPU=y \
	--kconfig_add CONFIG_VIRT_DRIVERS=y \
	--kconfig_add CONFIG_NITRO_ENCLAVES=y \
	'ne_misc_dev_test'

(This is a pretty long command, so it may be worth adding a .kunitconfig
file at some point, instead.)

Acked-by: Paraschiv, Andra-Irina <andraprs@amazon.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220618090310.1174932-5-davidgow@google.com/
- Move the mistakenly-added thunderbolt Kconfig to the previous patch
  (Thanks Andra)
- Add Andra's Acked-by tag.

---
 drivers/virt/nitro_enclaves/Kconfig           |  5 ++--
 drivers/virt/nitro_enclaves/ne_misc_dev.c     | 27 -------------------
 .../virt/nitro_enclaves/ne_misc_dev_test.c    |  5 +---
 3 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/Kconfig b/drivers/virt/nitro_enclaves/Kconfig
index 2d3d98158121..ce91add81401 100644
--- a/drivers/virt/nitro_enclaves/Kconfig
+++ b/drivers/virt/nitro_enclaves/Kconfig
@@ -16,8 +16,9 @@ config NITRO_ENCLAVES
 	  The module will be called nitro_enclaves.
 
 config NITRO_ENCLAVES_MISC_DEV_TEST
-	bool "Tests for the misc device functionality of the Nitro Enclaves"
-	depends on NITRO_ENCLAVES && KUNIT=y
+	bool "Tests for the misc device functionality of the Nitro Enclaves" if !KUNIT_ALL_TESTS
+	depends on NITRO_ENCLAVES && KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable KUnit tests for the misc device functionality of the Nitro
 	  Enclaves. Select this option only if you will boot the kernel for
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 20c881b6a4b6..241b94f62e56 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -1759,35 +1759,10 @@ static long ne_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 #if defined(CONFIG_NITRO_ENCLAVES_MISC_DEV_TEST)
 #include "ne_misc_dev_test.c"
-
-static inline int ne_misc_dev_test_init(void)
-{
-	return __kunit_test_suites_init(ne_misc_dev_test_suites);
-}
-
-static inline void ne_misc_dev_test_exit(void)
-{
-	__kunit_test_suites_exit(ne_misc_dev_test_suites);
-}
-#else
-static inline int ne_misc_dev_test_init(void)
-{
-	return 0;
-}
-
-static inline void ne_misc_dev_test_exit(void)
-{
-}
 #endif
 
 static int __init ne_init(void)
 {
-	int rc = 0;
-
-	rc = ne_misc_dev_test_init();
-	if (rc < 0)
-		return rc;
-
 	mutex_init(&ne_cpu_pool.mutex);
 
 	return pci_register_driver(&ne_pci_driver);
@@ -1798,8 +1773,6 @@ static void __exit ne_exit(void)
 	pci_unregister_driver(&ne_pci_driver);
 
 	ne_teardown_cpu_pool();
-
-	ne_misc_dev_test_exit();
 }
 
 module_init(ne_init);
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev_test.c b/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
index 265797bed0ea..74df43b925be 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
@@ -151,7 +151,4 @@ static struct kunit_suite ne_misc_dev_test_suite = {
 	.test_cases = ne_misc_dev_test_cases,
 };
 
-static struct kunit_suite *ne_misc_dev_test_suites[] = {
-	&ne_misc_dev_test_suite,
-	NULL
-};
+kunit_test_suite(ne_misc_dev_test_suite);
-- 
2.37.0.rc0.104.g0611611a94-goog

