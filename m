Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ED449BD92
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiAYVA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiAYVAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:00:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E0CC06174E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:00:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so43940562ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lhZFy11ryScz7wsYxziWawYb+Qi1p9jcBVxhBaeOFbM=;
        b=iTtZyr75FthgBMy7b0cykaOf/77pXGF17YdKySDjAZDbp2pPSqJEHOW0gDiV36yShP
         d6Lv5enklnIq5YpCbz+3oN36PqQJxvIJeFt+gNn6FyOUEns3/uWg8BVLoS1pZLufF9BM
         n5b+b7WPvPIhiGcMZ8Czap3gk91Hs4jmzjNjRPLzAchaIeVPXPoc2ylrPBB5CkPmTb5P
         sxpM6ZBnOpXSPUrLbwshVy8Y4VR07EorHldESNhBOWnPdtQUQEujMLulesXIrHlRhPoX
         1QIDOEGVWfPtSLtfNqwe4+9ddl7QZ2HuFsbWjskkbTShrPUWn7Cs5a8jypOEyHM4UZZF
         A3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lhZFy11ryScz7wsYxziWawYb+Qi1p9jcBVxhBaeOFbM=;
        b=g+bimo8XPdz0DW5sTiDyNH5pKyI7ES4v3sjETmpBluwZPqSaXUAX2bmMPaLwyI2Qei
         1GyEqpfFqysY5GLbKlh9Xq8ZEYgSgB6/Yy0wHfi6ngsaqLZEoHmGt9yBE9J21522K0Aa
         sCDijSDWlL41VvMye9kSZG9XDeURiLaPheJJMxMh9l9f6LbtE8q6aajcET/FN6aLfU3w
         333BQ+bpGGGnjnCmngN1KXJd01vHZ9V7jPXaop5XBdzvSclhEVwZmDP1gDvyYLRwJQDL
         Se/R6NBZVGbVng5WcgQzPH3DJjhpfLWvyMoW3yU0D4cf+azdjF/RFhSK7HgzKe4QvPUo
         KpJA==
X-Gm-Message-State: AOAM531/Ean2VVe2vV5jiNujA4rfvhtu8wU8EN0fVEcVfO1/II3Rccqj
        2q4WaAchvociVovd5NYgjMPaqNX9dDvndQ==
X-Google-Smtp-Source: ABdhPJxiZtgGgjhVY9T63xK9Vmx3lK5DTSaADtW6QL7LVDHDHG6S8D/3jQurMJ7ND76hgXfXl7OHV9skVu5UUQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:ec63:7812:5e4a:c688])
 (user=dlatypov job=sendgmr) by 2002:a81:36d7:0:b0:2ca:287c:6c18 with SMTP id
 00721157ae682-2ca287c6e66mr6946437b3.189.1643144424445; Tue, 25 Jan 2022
 13:00:24 -0800 (PST)
Date:   Tue, 25 Jan 2022 13:00:08 -0800
Message-Id: <20220125210011.3817742-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH 0/3] kunit: further reduce stack usage of asserts
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the compiler doesn't optimize them away, each kunit assertion (use of
KUNIT_EXPECT_EQ, etc.) can use 88 bytes of stack space in the worst and
most common case. This has led to compiler warnings for certain configs
+ arches [1].

This series builds upon [2] which cut down kunit_assert from 48 => 24
bytes, but only reduced kunit_binary_assert (the most common one) from
88 => 48.

Now we have kunit_assert = 8 and kunit_binary_assert = 32.
The cost is we need to pass around another parameter to some functions
(struct va_format *), and we introduce a new type
(sturct kunit_binary_assert_text) for holding the textual representation
of the KUNIT_EXPECT_EQ arguments.

Note: it's possible to get kunit_assert = 0 and kunit_binary_assert =
24 by removing the `format` function pointer field from kunit_assert.
I think it's an improvement, but others might think that readability
suffers from doing so, so I'm leaving that off from this series.

Meta: this series applies on top of 5.17-rc1 + [2] and [3].
That should be available at in Shuah's kunit branch [4], but my version
of git is constantly segfaulting, so I can't try and rebase to verify.

[1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
[2] https://lore.kernel.org/linux-kselftest/20220113165931.451305-6-dlatypov@google.com/
[3] https://lore.kernel.org/linux-kselftest/20220118223506.1701553-1-dlatypov@google.com/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kunit 

Daniel Latypov (3):
  kunit: remove va_format from kunit_assert
  kunit: consolidate KUNIT_INIT_BINARY_ASSERT_STRUCT macros
  kunit: factor out str constants from binary assertion structs

 include/kunit/assert.h | 152 ++++++++++++-----------------------------
 include/kunit/test.h   |  32 +++++----
 lib/kunit/assert.c     |  65 ++++++++++--------
 lib/kunit/test.c       |  12 ++--
 4 files changed, 104 insertions(+), 157 deletions(-)

-- 
2.35.0.rc2.247.g8bbb082509-goog

