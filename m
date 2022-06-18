Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE2A5503C1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 11:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiFRJDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 05:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiFRJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 05:03:32 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E27A17072
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 02:03:31 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id y2-20020a655b42000000b0040014afa54cso3292483pgr.21
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ptVKPuGcbB2+la+8ZiODjieQiW7k/oxo/Oz/EdgWumA=;
        b=UIxQ5FEc5KUGjUFI0jmR+pzVeOpPYkxsewDr7QpplKnl9i8FqbhtassrfzcyyW/VG4
         q4zTZ1jlJegFa1PmQn4JCa7rgZpA9GXdHeGc7DZThZ3KQpZ5ijja2/D22gi939kN75as
         w19ZMHfgy7cHjfLdCoqYjwhPvt3gyoPZQIRTlpXEuBVi1hRUi93DrwXHyRyr6uPntB+C
         f5qLDoDNzx+/aL9DTUn2OsNZ3Fo0QayufVMnNZ/CwjjPTMgirdUroVvDRqUjhR2FhpvJ
         nwHs/ieBLMWCoE89Zwm+PIiFZpaoTHinYCTLH2LFGLCAwEinnlsS9UG+rWKeGDt9sn12
         wlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ptVKPuGcbB2+la+8ZiODjieQiW7k/oxo/Oz/EdgWumA=;
        b=6/GNvuraV2Ok/XRPCZ0CfTGhS3SagNep5OaaIKX2eo6xo3Kgp26ju1QKkbnv+Hge+V
         ysYs/epFMeSzyhifXMaReKJ7X/VhGmYDXHspZJ3d557VNEHjJA67gqRXVX1Vvbrg4itQ
         jHlVAanULLTtXBMo2HvXsfQRxbtECbCzZVbF9sfC+FJfAtj+uGjTZHfzpxt/50bJZkL4
         7P2aYqHHyLJmHulzJH8QmEAa68w4Q8hUl+dFCmrRL5tibEa+Li7HBn0UhVQTzpnL++Ql
         0VyQs8+IMTrhRrpDsEoEKq4MhIjqZW7+jgrg6a1E5J/gzQ1GATqeus52IvxSOpf/Yr9z
         em1g==
X-Gm-Message-State: AJIora/qUiJbQVeDeednKEd/pmNmhuBmUuAqInW/MXw5GVgB1vVNKPrW
        byLkHeAziT0jk0Cf9b4834e1dzGcXOrbjw==
X-Google-Smtp-Source: AGRyM1sH2PfcGj8ViDV0lllmFpU71ukSxzCtMA3vIatOWbHB6KvOeV6QomY8XXQV6nt0d4lCuh4I6QRng8JeMg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:903:11cc:b0:168:eae:da4a with SMTP id
 q12-20020a17090311cc00b001680eaeda4amr13290211plh.21.1655543010775; Sat, 18
 Jun 2022 02:03:30 -0700 (PDT)
Date:   Sat, 18 Jun 2022 17:03:05 +0800
Message-Id: <20220618090310.1174932-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 0/5] Rework KUnit test execution in modules
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
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series makes two changes to how KUnit test suites are stored
and executed:
- The .kunit_test_suites section is now used for tests in modules (in
  lieu of a module_init funciton), as well as for built-in tests. The
  module loader will now trigger test execution. This frees up the
  module_init function for other uses.
- Instead of storing an array of arrays of suites, have the
  kunit_test_suite() and kunit_test_suites() macros append to one global
  (or per-module) list of test suites. This removes a needless layer of
  indirection.

The upshot of this is that it should now be possible to use the
kunit_test_suite() and kunit_test_suites() macros to register test
suites even from within modules which otherwise had module_init
functions. This was proving to be quite a common issue, resulting in
several modules calling into KUnit's private suite execution functions
to run their tests (often introducing incompatibilities with the KUnit
tooling).

This series also fixes the thunderbolt, nitro_enclaves, and
sdhci-of-aspeed tests to use kunit_test_suite() now that it works.

Huge thanks to Jeremy Kerr, who designed and implemented the module
loader changes, and to Daniel Latypov for pushing the simplification of
the nested arrays in .kunit_test_suites.

I've tested this series both with builtin tests, and with modules on
x86_64, but there's always the possibility that there's something subtle
and nasty on another architecture, so please test!

Cheers,
-- David

Daniel Latypov (1):
  kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites

David Gow (3):
  thunderbolt: test: Use kunit_test_suite() macro
  nitro_enclaves: test: Use kunit_test_suite() macro
  mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro

Jeremy Kerr (1):
  kunit: unify module and builtin suite definitions

 drivers/mmc/host/Kconfig                      |   5 +-
 drivers/mmc/host/sdhci-of-aspeed-test.c       |   8 +-
 drivers/mmc/host/sdhci-of-aspeed.c            |  27 ----
 drivers/thunderbolt/Kconfig                   |   5 +-
 drivers/thunderbolt/domain.c                  |   3 -
 drivers/thunderbolt/tb.h                      |   8 -
 drivers/thunderbolt/test.c                    |  12 +-
 drivers/virt/nitro_enclaves/Kconfig           |   5 +-
 drivers/virt/nitro_enclaves/ne_misc_dev.c     |  27 ----
 .../virt/nitro_enclaves/ne_misc_dev_test.c    |   5 +-
 include/kunit/test.h                          |  60 ++------
 include/linux/module.h                        |   5 +
 kernel/module/main.c                          |   6 +
 lib/kunit/executor.c                          | 117 ++++-----------
 lib/kunit/executor_test.c                     | 139 +++++-------------
 lib/kunit/test.c                              |  54 ++++++-
 16 files changed, 152 insertions(+), 334 deletions(-)

-- 
2.36.1.476.g0c4daa206d-goog

