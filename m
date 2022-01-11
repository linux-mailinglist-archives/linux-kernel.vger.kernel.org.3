Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0791D48B77F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiAKTmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbiAKTmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:42:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E932C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:42:39 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t44-20020a25aaaf000000b006118ed6d30cso2891283ybi.15
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KByT3s7+rqYaPqSOzdpMpTtZAxXm98TA4n1vo2El3YY=;
        b=QlzloFUsWMVoAz+5ZNiJl+wy7iVzrS0T1ENaJvrB9fhlE81okh8HW7D8KjB4ugiSY3
         ofKMkYvrZ7Cq3XAMci3IG+osroooYZflp3B7GD2bljrUDWh2PMIw5A+tQOO2qpzLSSs9
         8Z5niMuODEdg9jePx+qMahczzz2/kq3HDN32weDrPIkCp79k/1ADJ/lQw3i7rbB4ht38
         bfQ08CHv3VZrfOSwo97E0nNxUPVRCOZRGKg1ah0DcgbImNCy9xbOvS+Pc3ePotqDl29A
         AG+IQ23YRt84UEO06R6/D5oK80lHdHPHI5nS/HvMsxaJWPcy5n/OX3dA9tptCnrK/qro
         a4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KByT3s7+rqYaPqSOzdpMpTtZAxXm98TA4n1vo2El3YY=;
        b=P/21VlYXj9Riq5rJS8U7+R/yl9N/4eD4+8PmKvFpp0NjEbsammc4T484o+4103ZMHG
         COaVQudshDBLVu7htEykLlEl+QCHBeMTB09x5zSVmgmBrZTQCrKrFK/0zbPzwGRRjcPE
         C04/T+Soory0IJ6/NA3GTkzSmifuBhi6c5A+4xK5+K6ZS8VhgP/1c/9y9zu5UvR4HnIx
         C6/MPOegyRxZdzgZomX2bSfJfwbbOPZcrseKOw28ty3Wr2wvpWkm2EF6txEtHnHRGSft
         7je8q+0+to3GE89AotQf+6KcGz/9et1Vz3BK2tUh8xMp1YgFmtoASiQONpViHf7WvNb6
         JsOw==
X-Gm-Message-State: AOAM530Jqw9MMIkJ9rtSw+UGCBj5dZ5KvRnsNqjqcrtzWhSjKTIXySZL
        N1HNcP0ylQMvsqrqoe/NFUGZIoXo2lvhqg==
X-Google-Smtp-Source: ABdhPJwihQ2H0DOoCrPTCK2O34S3YyCkMHNdalNcpefpOCESk3e/pWInRcX/lN622zOLe3ySlHeIzrudH10MPQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8c76:9de0:1a30:7de8])
 (user=dlatypov job=sendgmr) by 2002:a5b:845:: with SMTP id
 v5mr8304993ybq.84.1641930158257; Tue, 11 Jan 2022 11:42:38 -0800 (PST)
Date:   Tue, 11 Jan 2022 11:42:25 -0800
Message-Id: <20220111194231.1797841-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH v2 0/6] kunit: refactor assertions to use less stack
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
2.34.1.575.g55b058a8bb-goog

