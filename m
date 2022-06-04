Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A732C53D800
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 19:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbiFDRQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbiFDRQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 13:16:14 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B95D286D1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 10:16:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id F29182E2935;
        Sat,  4 Jun 2022 19:16:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654362969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xpSXDmInLinAfk9K5YQ3mAUQJFvHLC+GdWbrKMp9jKI=;
        b=RyimUQDQmMS9pkId9hVXTtUB0evKcoX1cLwBYEya80tIFjiewYjJ5dzy7Yi5Na2nn6HB2e
        mM/MICs8qrTmIgcwwO9cAARbn04W+76S+LZLWbeamvY2slKRzC+8O8ZbSVG4b8dXH/1boP
        y3t6TZ9FhUnHI2ydHcd6iR2e2Acl7GB4FDlwqc8o+RrP4CvZipH40xMlnjV845c7TWax1O
        KzeOcTUe8zljvMxMlxWqZg3O3Za7DNGQEyOkLM2WuVNPppheTYUpjQQic34khrT+86zsO4
        3CzGAdVmNj70gMbyxAqCZjntB/NGeswFJbHs/U/2fkru9+yf/GI8K49NCM/NKg==
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
Subject: [PATCH v2 0/4] cpumask: Fix invalid uniprocessor assumptions
Date:   Sat,  4 Jun 2022 19:15:55 +0200
Message-Id: <cover.1654362935.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
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

Changes since v1:
Link: https://lore.kernel.org/all/cover.1654201862.git.sander@svanheule.net/
  - Place tests in lib/test_cpumask.c
  - Drop the modified UP code in favor of the generic SMP implementation
  - Update declaration of cpumask_next_wrap()

Sander Vanheule (4):
  lib/test: Introduce cpumask KUnit test suite
  cpumask: Fix invalid uniprocessor mask assumption
  cpumask: Add UP optimised for_each_*_cpu versions
  cpumask: Update cpumask_next_wrap() signature

 include/linux/cpumask.h |  89 +++----------------------------
 lib/Kconfig.debug       |   9 ++++
 lib/Makefile            |   4 +-
 lib/test_cpumask.c      | 115 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 83 deletions(-)
 create mode 100644 lib/test_cpumask.c

-- 
2.36.1

