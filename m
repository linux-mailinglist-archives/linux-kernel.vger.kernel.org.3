Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11E14D5C51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbiCKHaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344568AbiCKHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:30:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A721B6E26
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:29:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h16-20020a056902009000b00628a70584b2so6695912ybs.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=e1nLgX5logjeFyMYEkbC1aYDUofzxBmSlcZWRpPxl7A=;
        b=b0spp3EZvveQ+nqs3kX6yx7yQ498jn1euKH6mnZj6P1rGAhbDNq2fIrco90JJi8VvA
         EZF5b59PzsA6CXMm9LyjT2O5V7S9bQG2ehyOUCNL7IBgpQzf/3kNl3K1AdEoYq4tEmO8
         kLNUDR6IRuDAxQiecB3s/YD7cSAINIv7wplEdyytq5aS07SvgTuxAb4hf2ZcXzxfkJCn
         Xy2VHBFdKgKnD3d0s9cDScSVk1H/Z446ubK+XDhWGEFbKgVk9FFahft/W4b4xwa7Undm
         xmXCnyrRZuEideBChlDIU3uYrzQr3bKTAPP08UzLbJ/hseOLNrX7C6YLTo5ih3JhtfC6
         a2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=e1nLgX5logjeFyMYEkbC1aYDUofzxBmSlcZWRpPxl7A=;
        b=gecJGAU9Ay/N3ImWKwhYT4LBR7nzfI64P+YoURI9IqH8iFeskD5myGN33pLfl6TALt
         x+U2iFE+LZrXgzbPny9581d+SYi2F0sqS0HuieDcqhlpi2ybswzx/ugaCA6YOEdL1Qf7
         04VV62vOqKp91x65cmhiCblPPNz1+pJuz7SxWhYM5KHY0mbyah0xSvcN/nYdcEKZmqph
         niQAsSuNIiVWOfPO8zM37UrPW+ScpPxbGNSou3+GBVjALWyYZ7tbDmQtE4AS/IvIp3HZ
         xFGWeKgtBaptI3TvpBEg2btN+a06jX5bLW1/QZxeqUoSG8eXJpkj4KQrCZEJ6fj6qRs9
         +INA==
X-Gm-Message-State: AOAM5326OR/nfRaEZHhhy6bOU87t18vAxH3b0OKEb40DbEXCJZ6pWzTH
        /VZz23fiRRRC+FqdB/jpAZL9U2ztm5WJljiwHTI/hw==
X-Google-Smtp-Source: ABdhPJxIgcqfcPQNV2Mf0S1CuBduUoePyIvJ/y7UAVwe1Nn9kDnrjeC7z2iGti7ZlrqPZa6ZWtExnARyVP3hTHpzWrxZ7w==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:7ca5:48f0:ef38:d556])
 (user=brendanhiggins job=sendgmr) by 2002:a05:6902:104:b0:628:bc80:748f with
 SMTP id o4-20020a056902010400b00628bc80748fmr7059512ybh.575.1646983744795;
 Thu, 10 Mar 2022 23:29:04 -0800 (PST)
Date:   Thu, 10 Mar 2022 23:28:59 -0800
Message-Id: <20220311072859.2174624-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v1] kunit: add support for kunit_suites that reference init code
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        martin.fernandez@eclypsium.com, daniel.gutson@eclypsium.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        jk@codeconstruct.com.au,
        Brendan Higgins <brendanhiggins@google.com>
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

Add support for a new kind of kunit_suite registration macro called
kunit_test_init_suite(); this new registration macro allows the
registration of kunit_suites that reference functions marked __init and
data marked __initdata.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Martin Fernandez <martin.fernandez@eclypsium.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
---

This is a follow-up to the RFC here[1].

This patch is in response to a KUnit user issue[2] in which the user was
attempting to test some init functions; although this is a functional
solution as long as KUnit tests only run during the init phase, we will
need to do more work if we ever allow tests to run after the init phase
is over; it is for this reason that this patch adds a new registration
macro rather than simply modifying the existing macros.

Changes since last version:
 - I added more to the kunit_test_init_suites() kernel-doc comment
   detailing "how" the modpost warnings are suppressed in addition to
   the existing information regarding "why" it is OK for the modpost
   warnings to be suppressed.

[1] https://lore.kernel.org/linux-kselftest/20220310210210.2124637-1-brendanhiggins@google.com/
[2] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABgAJ

---
 include/kunit/test.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index b26400731c02..7f303a06bc97 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -379,6 +379,32 @@ static inline int kunit_run_all_tests(void)
 
 #define kunit_test_suite(suite)	kunit_test_suites(&suite)
 
+/**
+ * kunit_test_init_suites() - used to register one or more &struct kunit_suite
+ *			      containing init functions or init data.
+ *
+ * @__suites: a statically allocated list of &struct kunit_suite.
+ *
+ * This functions identically as &kunit_test_suites() except that it suppresses
+ * modpost warnings for referencing functions marked __init or data marked
+ * __initdata; this is OK because currently KUnit only runs tests upon boot
+ * during the init phase or upon loading a module during the init phase.
+ *
+ * NOTE TO KUNIT DEVS: If we ever allow KUnit tests to be run after boot, these
+ * tests must be excluded.
+ *
+ * The only thing this macro does that's different from kunit_test_suites is
+ * that it suffixes the array and suite declarations it makes with _probe;
+ * modpost suppresses warnings about referencing init data for symbols named in
+ * this manner.
+ */
+#define kunit_test_init_suites(__suites...)				\
+	__kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),	\
+			    CONCATENATE(__UNIQUE_ID(suites), _probe),	\
+			    ##__suites)
+
+#define kunit_test_init_suite(suite)	kunit_test_init_suites(&suite)
+
 #define kunit_suite_for_each_test_case(suite, test_case)		\
 	for (test_case = suite->test_cases; test_case->run_case; test_case++)
 

base-commit: 330f4c53d3c2d8b11d86ec03a964b86dc81452f5
-- 
2.35.1.723.g4982287a31-goog

