Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CBE52B397
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiERHc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiERHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:32:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E48867D2B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:32:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fed274f3fbso13019407b3.17
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GtAQDy8qrMQs7mWCa7GmbHUrKXDNUra1mtOtVoTKAPY=;
        b=PitbkuosP0m9OyM6dQN2cmaA2R4TV0wtkHCCHVa73WeHclEwLHKbiFoC0Sb0UXjF4/
         phkuGrGZytvuuRY+NZdRDOmesIvzLbcZ/cfcX11EoBRhBb0u62TqSAr7vPJm21/PA+sS
         ZeyHbua9VjgwrD5RRuvaXPuVYLix0CHBKzifC9EdkHgrl/nrCi1QiyYqvBTFw0zRZ07f
         4N2tYOIDqeuFdnOciG0tqWMXLMLyXn9tT1cAk+45NpWRYOYnG2nND4vMX6jub467EYCk
         d3B6+0c9r80jbXS2tDHiWUp8XG/F/7fJjy9fyOeETn0N1mDCSLTjS1C4oauut4E2o9zJ
         03mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GtAQDy8qrMQs7mWCa7GmbHUrKXDNUra1mtOtVoTKAPY=;
        b=KtFvDu0jaFcxzv94nd8xzNC+7Lam4N9U3i5YiZTFnfg41sPYM/l48AFMYZVFGiYihj
         Vtw3tV87oZgzbKHhG7a0kJmI8g90Gyo0h90hooG9qjqDv+rr+O0gRp0BhzyVmbzwHX9u
         Q03F4nEo8vRJagPs8XrXlK7Sw3oGYVjo4DLQViYRG8F6/WgHbz/0EkeF6lruwWbtpiT/
         c6NtUiHYFlZyUZR4NAq6bfdTuFE+I01ATQRFkRr2Jkso8Hqh2fZvPTDzbLDj/tu0WwDH
         HLmxdr4I7vpD+DFMf1sEXQ/qbD8sjwYVXgP11K+LkSnR/g9BGbchOSCeZL6AVkTtyrx6
         CZtA==
X-Gm-Message-State: AOAM531uPCtgnDJch6/elVJ97BeCGu7I+SKG09JafHnq2coUOLKzIKcb
        z7IF7B5A22pr3oZlV8+jgFjiVAWK37EEAQ==
X-Google-Smtp-Source: ABdhPJypIjypMVBz81HOJFDpHJ7rpL5x8W5jV1aqxXIeXWi9VdXO2Rh5JREbuHPp6e6Kke8tghRgheFxC3ijYA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:2643:0:b0:2f4:c975:b7ca with SMTP id
 m64-20020a812643000000b002f4c975b7camr28529608ywm.494.1652859174736; Wed, 18
 May 2022 00:32:54 -0700 (PDT)
Date:   Wed, 18 May 2022 15:32:32 +0800
In-Reply-To: <20220518073232.526443-1-davidgow@google.com>
Message-Id: <20220518073232.526443-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 2/2] kcsan: test: Add a .kunitconfig to run KCSAN tests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
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
to run under kunit_tool, the x86_64-smp qemu-based setup should be used:
./tools/testing/kunit/kunit.py run --arch=x86_64-smp --kunitconfig=kernel/kcsan

Signed-off-by: David Gow <davidgow@google.com>
---
 kernel/kcsan/.kunitconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 kernel/kcsan/.kunitconfig

diff --git a/kernel/kcsan/.kunitconfig b/kernel/kcsan/.kunitconfig
new file mode 100644
index 000000000000..a8a815b1eb73
--- /dev/null
+++ b/kernel/kcsan/.kunitconfig
@@ -0,0 +1,20 @@
+# Note that the KCSAN tests need to run on an SMP setup.
+# Under kunit_tool, this can be done by using the x86_64-smp
+# qemu-based architecture:
+# ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan --arch=x86_64-smp
+
+CONFIG_KUNIT=y
+
+CONFIG_DEBUG_KERNEL=y
+
+CONFIG_KCSAN=y
+CONFIG_KCSAN_KUNIT_TEST=y
+
+# Needed for test_barrier_nothreads
+CONFIG_KCSAN_STRICT=y
+CONFIG_KCSAN_WEAK_MEMORY=y
+
+# This prevents the test from timing out on many setups. Feel free to remove
+# (or alter) this, in conjunction with setting a different test timeout with,
+# for example, the --timeout kunit_tool option.
+CONFIG_KCSAN_REPORT_ONCE_IN_MS=100
-- 
2.36.0.550.gb090851708-goog

