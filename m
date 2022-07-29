Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FD9584C45
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbiG2HBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiG2HBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:01:38 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08272F39D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:01:35 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id AF672302C2B;
        Fri, 29 Jul 2022 09:01:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1659078092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J/enTjqwQ6ehBMZ4hE1b6W8ThYSd1GY4baEv+hNepcQ=;
        b=u21q9ipjDdR8JP3owajA06bnZHsjqv2mVp6Dj2nGJfa9uSTXFXFba4JgbABjlx/Yl25C/A
        yfoERyj1fFhOC1MSipyqV9UBWCrR/rD4mQJAXcF7jJnvM9Ll78y0lUg3BPTluWn07PceD/
        mkSFlaWLGa9cUVW3gwH+YH8uvFtFQIgNAbucBt/5WMHK2xb/fBvWdSflZ6qs+Un2VsxJhr
        sSz8YvwLuuOqxfSdiXSLHHVvauZcxDSn93cQdnipQB+2XVyznalU/6DfOU1HDB1KhoC9GQ
        69A7/x6QrwnuX3OsEg2Et4u2WUg0qgd9l7e2lOyX5mSG+wknM1VhnlGL97tWYA==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v5 0/5] cpumask: fix invalid uniprocessor assumptions
Date:   Fri, 29 Jul 2022 09:01:17 +0200
Message-Id: <cover.1659077534.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On uniprocessor builds, it is currently assumed that any cpumask will
contain the single CPU: cpu0. This assumption is used to provide
optimised implementations.

The current assumption also appears to be wrong, by ignoring the fact
that users can provide empty cpumasks. This can result in bugs as
explained in [1] - for_each_cpu() will run one iteration of the loop
even when passed an empty cpumask.

This series introduces some basic tests, and updates the optimisations
for uniprocessor builds.

The x86 patch was written after the kernel test robot [2] ran into a
failed build. I have tried to list the files potentially affected by the
changes to cpumask.h, in an attempt to find any other cases that fail on
!SMP. I've gone through some of the files manually, and ran a few cross
builds, but nothing else popped up. I (build) checked about half of the
potientally affected files, but I do not have the resources to do them
all. I hope we can fix other issues if/when they pop up later.

[1] https://lore.kernel.org/all/20220530082552.46113-1-sander@svanheule.net/
[2] https://lore.kernel.org/all/202206060858.wA0FOzRy-lkp@intel.com/

Changes since v4:
Link: https://lore.kernel.org/all/cover.1656777646.git.sander@svanheule.net/
  - Move new for_each_*_cpu() optimisations ahead, so they come before
    the fixes.
  - Update test cases for cpu_possible_mask for nr_cpu_ids < CONFIG_NR_CPUS
  - Improve KUnit style compliance on tests
  - Collect tags and add Cc: tags

Changes since v3:
Link: https://lore.kernel.org/all/cover.1654410109.git.sander@svanheule.net/
  - Guard against CPU hotplugging while testing cpu online/present masks
  - Add fix for cpu_llc_shared_map on x86

Changes since v2:
Link: https://lore.kernel.org/all/cover.1654362935.git.sander@svanheule.net/
  - Put new tests after patch fixes
  - Update for_each_* macros

Changes since v1:
Link: https://lore.kernel.org/all/cover.1654201862.git.sander@svanheule.net/
  - Place tests in lib/test_cpumask.c
  - Drop the modified UP code in favor of the generic SMP implementation
  - Update declaration of cpumask_next_wrap()

Sander Vanheule (5):
  x86/cacheinfo: move shared cache map definitions
  cpumask: add UP optimised for_each_*_cpu versions
  cpumask: fix invalid uniprocessor mask assumption
  lib/test: introduce cpumask KUnit test suite
  cpumask: update cpumask_next_wrap() signature

 arch/x86/kernel/cpu/cacheinfo.c |   6 ++
 arch/x86/kernel/smpboot.c       |   4 -
 include/linux/cpumask.h         | 108 ++++++-----------------
 lib/Kconfig.debug               |  12 +++
 lib/Makefile                    |   4 +-
 lib/cpumask.c                   |   2 +
 lib/cpumask_test.c              | 147 ++++++++++++++++++++++++++++++++
 7 files changed, 196 insertions(+), 87 deletions(-)
 create mode 100644 lib/cpumask_test.c

-- 
2.37.1

