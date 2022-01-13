Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7667A48DC53
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbiAMQ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbiAMQ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:59:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA1CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:59:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p8-20020a25bd48000000b00611be5dd7eeso4539271ybm.19
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=51TwYWlCVjLtcnMxIRndP7HWHkEk31I1oVO6dm0XZOE=;
        b=sGkR6Hq5k59lCpoXjiW7ECByvuOuR1ZO2HO05yjfVR+1zvjs8WyihN6kJ88uuitVdL
         vI7ZeFY7yH8ZrU8HEk95oHQY9DGxczR5eO1hw/et23GaztVqpsS4vshc79dDi5xwbYh8
         fTY8paG/sgYOsCh/QRkkbEZwxDW+7VIkFGEqnnbJ+lRpurzKPXrPmHL+qY6wd0ERuZWQ
         Cys7Iy0i5aeCseivOQUdLVvwDaS/1Pf1LFHl7sMI0mpt04EcbmOqazYUxxiAZJQb4M7N
         p687MJ0iAkyC39kbA1zsmxFUFRMxgdnaT20U5CksXfYOaIseUiqNXrCWirIll0Th1gkf
         88NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=51TwYWlCVjLtcnMxIRndP7HWHkEk31I1oVO6dm0XZOE=;
        b=a+N7aDgRoAkEFuQSKOVM6xVncuntZw+iJPxSa/VYUyWaVyrWoCNIwPjgX+EfNkDj6O
         2chFFdtV+MmloRf6B7eNGNm/Isx/O08czwhXUrbuyGtCR5FJG017pc/ax4Ns/bhdaFOq
         IX6r68arnxlXDgTqDqaigaVS5mJqoK11Z0dnVjj1kvi85bndMssThXBKs0l0woi3jeRq
         unNOBppcbQBOEBfo5pJEjv+nGDirKq1xZ9rzl3XyC69VCsOqvigcy13fXg5NabCVLEG0
         nEUXu8bsCteqjibSD3O5mny2UDCD1i+fv/omu21RyURvD80tSWERai+P3HAY4i/9eIvw
         gIzA==
X-Gm-Message-State: AOAM532ZkQm8Oj9f9zpzqgT4fYSvN3J/1T0VPBjzBu5AJFJaLtc224Oq
        eWxQ818CDVM+6eJ5HKYIZFAtmpitCVvH+g==
X-Google-Smtp-Source: ABdhPJzRXQ1iNJrgYqJexjpuxTUBATG9/34Qa3zExxynTs7O+SWx69X9yBP5abVGsnuQ9WWC8jCDk4qH2C3jxg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1a70:cede:4191:24bc])
 (user=dlatypov job=sendgmr) by 2002:a25:3fc6:: with SMTP id
 m189mr7438582yba.101.1642093180531; Thu, 13 Jan 2022 08:59:40 -0800 (PST)
Date:   Thu, 13 Jan 2022 08:59:25 -0800
Message-Id: <20220113165931.451305-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v3 0/6] kunit: refactor assertions to use less stack
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***
Every KUNIT_ASSERT/EXPECT() invocation puts a `kunit_assert` object onto
the stack. The most common one is `kunit_binary_assert` which is 88
bytes on UML. So in the cases where the compiler doesn't optimize this
away, we can very quickly blow up the stack size.

This series implements Linus' suggestion in [1].
Namely, we split out the file, line number, and assert_type
(EXPECT/ASSERT) out of kunit_assert.

We can also drop the entirely unused `struct kunit *test` field, saving
a bit more space as well.

All together, sizeof(struct kunit_assert) went from 48 to 24 on UML.
Note: the other assert types are bigger, see [2].

This series also adds in an example test that uses all the base
KUNIT_EXPECT macros to both advertise their existence to new users and
serve as a smoketest for all these changes here.

[1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
[2] e.g. consider the most commonly used assert (also the biggest)
  struct kunit_binary_assert {
          struct kunit_assert assert;
          const char *operation;
          const char *left_text;
          long long left_value;
          const char *right_text;
          long long right_value;
  };
So sizeof(struct kunit_binary_assert) = went from 88 to 64.
I.e. only a 27% reduction instead of 50% in the most common case.

All 3 of the `const char*` could be split out into a `static` var as well,
but that's a bit trickier to do with how all the macros are written.

=== Changelog ===
v1 -> v2:
* made the new example test more focused on documenting the macros
rather than using them all as a smoketest
* s/kunit_failed_assertion()/kunit_do_failed_assertion()
* added `unlikely()` to `if(!(pass))` check in KUNIT_ASSERTION()

v2 -> v3:
* elaborate on intermediate TODO in patch 5 (deleted in patch 6)
* update with more Reviewed-by's


Daniel Latypov (6):
  kunit: add example test case showing off all the expect macros
  kunit: move check if assertion passed into the macros
  kunit: drop unused kunit* field in kunit_assert
  kunit: factor out kunit_base_assert_format() call into kunit_fail()
  kunit: split out part of kunit_assert into a static const
  kunit: drop unused assert_type from kunit_assert and clean up macros

 include/kunit/assert.h         | 88 +++++++++++-----------------------
 include/kunit/test.h           | 53 ++++++++++----------
 lib/kunit/assert.c             | 15 ++----
 lib/kunit/kunit-example-test.c | 42 ++++++++++++++++
 lib/kunit/test.c               | 27 +++++------
 5 files changed, 117 insertions(+), 108 deletions(-)


base-commit: ad659ccb5412874c6a89d3588cb18857c00e9d0f
-- 
2.34.1.703.g22d0c6ccf7-goog

