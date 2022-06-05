Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C520753DA6B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 08:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349253AbiFEGWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 02:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiFEGWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 02:22:52 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A6013D56
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 23:22:49 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 8C53A2E2DA1;
        Sun,  5 Jun 2022 08:22:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654410166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3e8JObibZ7sZMHKEhLJjFgEiHdbc/1Vf54b/PRl3NHE=;
        b=eYgxVOlXJdz/3eRW/Yqfr5I3U7xULEh1fG3tiXymOG+dlZmz6S9ecsqQpxV+J0e/Gr/8fU
        8Qt4UzcOtI7a5dM5rKUyM6eYMb2o6G5CLHZl3f9iAmaSY6k+unXd6fOcYVc45UrYM7naKl
        jN+6IxibQSFJMOSDU2lrMLr+ZzkzNCM28xrzQiKbwz8MzM648a7KNgq7ryz+nSHAK5xVDD
        XTsvf4N/DJCSog44kDHtVcUmDXPd+wPbB58PkmULKUSdS/oTn9BDiIRcERX1MfZlOJbqbG
        BjRSP/Wf77onappYvJe9hwh/f7UeUcheJWCZ1av3QAj7zjhP1hCbvGs9QJK7Xw==
From:   Sander Vanheule <sander@svanheule.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v3 0/4] cpumask: Fix invalid uniprocessor assumptions
Date:   Sun,  5 Jun 2022 08:22:37 +0200
Message-Id: <cover.1654410109.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On uniprocessor builds, it is currently assumed that any cpumask will
contain the single CPU: cpu0. This assumption is used to provide
optimised implementations.

The current assumption also appears to be wrong, by ignoring the fact
that users can provide empty cpumask-s. This can result in bugs as
explained in [1].

This series introduces some basic tests, and updates the optimisations
for uniprocessor builds.

[1] https://lore.kernel.org/all/20220530082552.46113-1-sander@svanheule.net/

Changes since v2:
Link: https://lore.kernel.org/all/cover.1654362935.git.sander@svanheule.net/
  - Put new tests after patch fixes
  - Update for_each_* macros

Changes since v1:
Link: https://lore.kernel.org/all/cover.1654201862.git.sander@svanheule.net/
  - Place tests in lib/test_cpumask.c
  - Drop the modified UP code in favor of the generic SMP implementation
  - Update declaration of cpumask_next_wrap()

Sander Vanheule (4):
  cpumask: Fix invalid uniprocessor mask assumption
  lib/test: Introduce cpumask KUnit test suite
  cpumask: Add UP optimised for_each_*_cpu versions
  cpumask: Update cpumask_next_wrap() signature

 include/linux/cpumask.h |  89 +++------------------------
 lib/Kconfig.debug       |   9 +++
 lib/Makefile            |   4 +-
 lib/test_cpumask.c      | 132 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+), 83 deletions(-)
 create mode 100644 lib/test_cpumask.c

-- 
2.36.1

