Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC9E48806C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiAHBXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiAHBXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:23:24 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FBEC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 17:23:23 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id h33-20020a17090a29a400b001b20b7d48dfso5398572pjd.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 17:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JnyxWlYVU2AlBUe7cwzGCUeHOWVsf0BhT/8R3oFJGYY=;
        b=KPDnCSf6K4fxw4W/T5EQXDdbX5Bc/s5X7sSPFxz0Vb0MBx1Ww1V5Kcb0rhRtI/to91
         0BRDjcAmgTKx/09xohESsJLXBbB4ru+ZgI9a+oM7e/kmV6RyLR3uJU4o+9+nCtPPeDEb
         PpCz/RNLwUXH6i2bUdQKgv+udlLaD9qfaz6fAPHL+1tx84BtSWqK5W4qeowT+9dm/2wA
         K1ySmBgibi0e6P+cXb/onM8KjwKyiTWxjc7ww0XooxL0uQXcKcmnz5AchWVDAk21rbG8
         tt7GoPRNLMH1KSEcXMn/LKZLYKYlHuTB2nATITQD8uLWZ8yyJvrqZuGGPMkERMiD5+la
         EfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JnyxWlYVU2AlBUe7cwzGCUeHOWVsf0BhT/8R3oFJGYY=;
        b=BmL216KiWz8glKo/NaJ96GpCRg+zvqcLGfh1LnCilaNuWQ1clLoMBph0SZgFUOkAET
         eh3m2cVvfY/Ue1cN1LsTxGP8WXPDOmeN0GnipkU3YW3+/XvqP4Fuh1Qf/RPgGO4wTuYI
         AbgcycC4GoCJaMTH2FMtTbqsinM3DYUwBcRrUj1L+IyFEu5y8V9OWx4lypQTptjExIKU
         gwL0wwl+RzcWlJ8UvzLaz/Vs8ZjfbluiA0xI8nM98qn2c7wQltC9Fx0PMkeIBVEmfbxV
         nnyoiekGH0FTFIFye91Yi7aIUTU1EnJCJpBGo+iwH7uGD/LUetn7BDEmBiMIs22oMZ6w
         OM6w==
X-Gm-Message-State: AOAM533alWXp0/egdp1Fnvu4MbcPZpYBSivTM6b99pl9z+RT1voaTY5o
        Eaob7yELcmrxlm8Fcd+Gbc4FM5CvPAIbcw==
X-Google-Smtp-Source: ABdhPJzL9OQlN7pM6g1rs04KwihLJkIDCQbTgUCtcnJEyXTKwojptHsl6SK3sTchrtTFqq5aEiNo4/Ig5XnKQA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bf8a:7e90:eb70:9b2b])
 (user=dlatypov job=sendgmr) by 2002:a05:6a00:190f:b0:4bc:c640:e6f1 with SMTP
 id y15-20020a056a00190f00b004bcc640e6f1mr21025083pfi.21.1641605003412; Fri,
 07 Jan 2022 17:23:23 -0800 (PST)
Date:   Fri,  7 Jan 2022 17:22:58 -0800
Message-Id: <20220108012304.1049587-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH 0/6] kunit: refactor assertions to use less stack
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

This series also adds in an example test that uses all the KUNIT_EXPECT
macros to both advertise their existence to new users and serve as a
smoketest for all these changes here.

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

Daniel Latypov (6):
  kunit: add example test case showing off all the expect macros
  kunit: move check if assertion passed into the macros
  kunit: drop unused kunit* field in kunit_assert
  kunit: factor out kunit_base_assert_format() call into kunit_fail()
  kunit: split out part of kunit_assert into a static const
  kunit: drop unused assert_type from kunit_assert and clean up macros

 include/kunit/assert.h         | 88 +++++++++++-----------------------
 include/kunit/test.h           | 52 ++++++++++----------
 lib/kunit/assert.c             | 15 ++----
 lib/kunit/kunit-example-test.c | 46 ++++++++++++++++++
 lib/kunit/test.c               | 27 +++++------
 5 files changed, 120 insertions(+), 108 deletions(-)


base-commit: ad659ccb5412874c6a89d3588cb18857c00e9d0f
-- 
2.34.1.575.g55b058a8bb-goog

