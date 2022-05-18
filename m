Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D9052C093
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbiERRBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbiERRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:01:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E873EF29
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:01:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a144-20020a25ca96000000b0064d6e10dd6aso2268073ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6lIh3KMhywLkny9k1R++mLvsFHwuvhtDKbmD+YqVcZ8=;
        b=dunm2cE6PNy2TTSLOLNSO4AD1cHuF+OCPrpfroZomDCvNmwAKYDptYmMg06Y6Fkz0X
         JolBsdUjfGE1qIPtFIYyz62jpyRKKgpWcMQgZwlSGKsDuBI+7p/GPN8vQEqCvM+F3FvE
         n41SKfVjNNJgZmK6Eozxj8C6nLBxXxQ6xnlXIKALFa/6cfntrk4vp+NU637ZRN9WnKxs
         k1KEbA+tJZ8Pzx7aq5CNciXORkYezlOFvypUjix0BM8Ns2pnceHihJTFAqk3pfnh0LY0
         a7zGbzfvWI4w5PcpC4ljbjQqTqBpVjI27PMK5MqwVgnoTGh24eq1ArbWzU+Q4Pq7xzwm
         1awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6lIh3KMhywLkny9k1R++mLvsFHwuvhtDKbmD+YqVcZ8=;
        b=u0osArlQkhgfq/ZsZbfX6aLOr5mJhD7/2f6HIeB4vajad4AdDeN4lfaJ8ThIsLqVlT
         2GBjmt200+gBXuOEC7fjiQvtrutgLjLnzsKI1uGV3pdHsQUQYm2W9+SngpE5huFgwwYu
         WH7v4CUHIvfnxG7LrWmqrbtElUNUOLril7kk1XO+FPp8pgBFVMuNXUIv/DCjk9szXFWO
         i5nlhHFxz8dLZQxtYR2YgAM/8RBj0S6R/KYnRrO0AobC0/sXAEac1e/ex5RTq+MA+/w5
         dC9Q0vhDsfhrWZIr5Rd9TvIsYpweA/9vxbLR3y5eprmf2d4VhCW0ZJCb+W5namUJGoT3
         wr1w==
X-Gm-Message-State: AOAM5300sXQoby2E7jZfgqC1ulHfqq7J4JIRnxlEqbC8a4Y4jXvUXo/V
        ZGds8SYp8TTECQEOXEGsp4cY1DA6g9zG/g==
X-Google-Smtp-Source: ABdhPJwrEFFVEBqGWlNDK8Dt9dM6ayC+DCfp0VnT1Gn3IihZ1PUQIgHd3CPuKhmvkPuwjM7xeOuhebCg9vigkA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a94f:2cb3:f298:ec1b])
 (user=dlatypov job=sendgmr) by 2002:a25:c60e:0:b0:64e:a4a3:bd76 with SMTP id
 k14-20020a25c60e000000b0064ea4a3bd76mr645342ybf.372.1652893296118; Wed, 18
 May 2022 10:01:36 -0700 (PDT)
Date:   Wed, 18 May 2022 10:01:21 -0700
Message-Id: <20220518170124.2849497-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 0/3] kunit: add support in kunit.py for --qemu_args
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
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

Note: this series applies on top of
https://lore.kernel.org/linux-kselftest/20220516194730.1546328-2-dlatypov@google.com/.
That patch greatly simplified the process of adding new flags.

This flag would let users pass additional arguments to QEMU when using a
non-UML arch to run their tests.
E.g. for kcsan's tests, they require SMP and with this patch, you can do
$ ./tools/testing/kunit/kunit.py run --kconfig_add=CONFIG_SMP --qemu_args='-smp 8'

This is proposed as an alternative to users manually creating new
qemu_config python files and also to [1], where we discussed checking in
a new x86_64 variant w/ `-smp 8` hard-coded into it.

This patch also contains a fix to the example `run_kunit` bash function
since it didn't quote properly and would parse the example above as
  --qemu_args='-smp' '8'
no matter how you tried to quote your arguments.

[1] https://lore.kernel.org/linux-kselftest/20220518073232.526443-1-davidgow@google.com/

Daniel Latypov (3):
  Documentation: kunit: fix example run_kunit func to allow spaces in
    args
  kunit: tool: simplify creating LinuxSourceTreeOperations
  kunit: tool: introduce --qemu_args

 .../dev-tools/kunit/running_tips.rst          |  2 +-
 tools/testing/kunit/kunit.py                  | 14 +++++++++-
 tools/testing/kunit/kunit_kernel.py           | 26 +++++++++++--------
 tools/testing/kunit/kunit_tool_test.py        | 20 +++++++++++---
 4 files changed, 46 insertions(+), 16 deletions(-)

-- 
2.36.1.124.g0e6072fb45-goog

