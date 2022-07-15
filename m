Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC77575BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiGOGmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiGOGmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:42:01 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9420D281
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:41:02 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id f9-20020a636a09000000b00401b6bc63beso2369061pgc.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q8Lc0RHx8l1tneFtOMp4vYatrYpRnfAN4z26Z90CGPY=;
        b=I3+mcTQjza1bx8oAMCZzMGdjVEMxpYxRzUPAB6JhVCT94InSWSpJquuiCY8UjNzWrC
         lZzxp8Y5pgEpkHKSV3a7ESL+QAb+h1xQy9YDqOR1kj7SH7xHga4BXC2hiXNZC/LyDEcB
         /tfcVpdj9dbgWDGS1/4dALG9qMwPlqTtPiGIdSLoGUF0n7Beak2RNv1DB8yg4anAHMRh
         YojIBSQ8maVsM6YU3/s4l7xA+S9RvwxyEYnX119dAJujdA/V1xSTc6+8uCDiWbatN40S
         LrLTMmBLkXLg0pmE571T79MAMy6wxrC3YBfvlfCkLsJOwcs/glUvxOBWRtaJNau7XTPK
         nDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q8Lc0RHx8l1tneFtOMp4vYatrYpRnfAN4z26Z90CGPY=;
        b=W9JjrFb3VWGqTYPDqE5p/MwGPobDzx2Cx6ykm3MRqNIvaHOt+vywHd/pa/0UyvylRr
         k1ymhr8J+CagguURq3JWSek8IXIyv195qZwwysGVvw7LkitILrJ0DMHJggzGbmzzrP8T
         l1kzvpHMwYWYBffQVR4SfRCRnrQNqfALJqIUkpy/8od9yjhHN4zmJo2aMUC/7+/4GJrk
         DWC1a5MFoQCALjrdgy80PITBmtEJ7ygeLglMnu6ytmfaLWcINfMCrKo1gOHRIh4BRZz3
         ACGH2DmQY32XnUz+AoDVOhSznvIicTxgKriKWAlYVnDt66JddL7NiPs4KHEHfRa3CE6J
         KjTw==
X-Gm-Message-State: AJIora9UXVgddNGvUZ4/tUzeuOt2+dVDAWWJ6ELmWjSRVzaVMdLcqwgt
        DX0SlbjX+haKFBbPQno9aH1UwarJZktL5Q==
X-Google-Smtp-Source: AGRyM1tOj6AgJlSuNGJEistybCR0Q1SsJhJC49AkehoUVZDd4/hpfDG3DDf4ThSx/gaSgAjzvEt5OSqAyBpl1g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:f606:b0:168:ecca:44e with SMTP id
 n6-20020a170902f60600b00168ecca044emr11864579plg.144.1657867261813; Thu, 14
 Jul 2022 23:41:01 -0700 (PDT)
Date:   Fri, 15 Jul 2022 14:40:52 +0800
Message-Id: <20220715064052.2673958-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v2] kcsan: test: Add a .kunitconfig to run KCSAN tests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

Add a .kunitconfig file, which provides a default, working config for
running the KCSAN tests. Note that it needs to run on an SMP machine, so
to run under kunit_tool, the --qemu_args option should be used (on a
supported architecture, like x86_64). For example:
./tools/testing/kunit/kunit.py run --arch=x86_64 --qemu_args='-smp 8'
					--kunitconfig=kernel/kcsan

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
---
 kernel/kcsan/.kunitconfig | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 kernel/kcsan/.kunitconfig

diff --git a/kernel/kcsan/.kunitconfig b/kernel/kcsan/.kunitconfig
new file mode 100644
index 000000000000..e82f0f52ab0a
--- /dev/null
+++ b/kernel/kcsan/.kunitconfig
@@ -0,0 +1,24 @@
+# Note that the KCSAN tests need to run on an SMP setup.
+# Under kunit_tool, this can be done by using the --qemu_args
+# option to configure a machine with several cores. For example:
+# ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan \
+# 				 --arch=x86_64 --qemu_args="-smp 8"
+
+CONFIG_KUNIT=y
+
+CONFIG_DEBUG_KERNEL=y
+
+# Need some level of concurrency to test a concurrency sanitizer.
+CONFIG_SMP=y
+
+CONFIG_KCSAN=y
+CONFIG_KCSAN_KUNIT_TEST=y
+
+# Set these if you want to run test_barrier_nothreads
+#CONFIG_KCSAN_STRICT=y
+#CONFIG_KCSAN_WEAK_MEMORY=y
+
+# This prevents the test from timing out on many setups. Feel free to remove
+# (or alter) this, in conjunction with setting a different test timeout with,
+# for example, the --timeout kunit_tool option.
+CONFIG_KCSAN_REPORT_ONCE_IN_MS=100
-- 
2.37.0.170.g444d1eabd0-goog

