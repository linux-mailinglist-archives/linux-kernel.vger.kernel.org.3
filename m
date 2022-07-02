Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DA2564145
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 18:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiGBQIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 12:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiGBQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 12:08:38 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699A4E09F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 09:08:35 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id DD6A42F29D8;
        Sat,  2 Jul 2022 18:08:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1656778113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0NSjE24cwDwpcjmOlgtK2wImoG/eC1FOZtbmxQjPBj0=;
        b=B/25Dg7VzGoSeprNq4hnAvyFQlp+MyafaWPMZYeUlOwHgMhmoALv9MXd6v/TTNC/72GF2n
        vdoMfB1cnNXmXF75MyS/V8nNeY6C1JvAyr3MI7mt9kquSedc54aGzUN0lbNjhXIPQaSV7n
        GnE+PwVEDt4SffPsoVzLMsFdeyC8V/aKlZyeUri+HnOo+Qx9Wwk9QbK9BSqFVGOPwEp0LD
        iyaSBCmT1uJ1hcMk3D0IHAPAwrwWRvTvcm0jmRnvOq/HiCBSQ1LeK9q/XoZvik9foa/Cti
        ztxZkW0nz7JJ+RXuCFKKv615TSp3/JicN1YrUArV+yAfCY8O6VZohw2WBE1Ljw==
From:   Sander Vanheule <sander@svanheule.net>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v4 0/5] cpumask: Fix invalid uniprocessor assumptions
Date:   Sat,  2 Jul 2022 18:08:23 +0200
Message-Id: <cover.1656777646.git.sander@svanheule.net>
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

The x86 patch was written after the kernel test robot [2] ran into a
failed build. I have tried to list the files potentially affected by the
changes to cpumask.h, in an attempt to find any other cases that fail on
!SMP. I've gone through some of the files manually, and ran a few cross
builds, but nothing else popped up. I (build) checked about half of the
potientally affected files, but I do not have the resources to do them
all. I hope we can fix other issues if/when they pop up later.

[1] https://lore.kernel.org/all/20220530082552.46113-1-sander@svanheule.net/
[2] https://lore.kernel.org/all/202206060858.wA0FOzRy-lkp@intel.com/

Changes since v3:
Link: https://lore.kernel.org/all/cover.1654410109.git.sander@svanheule.net/
  - Guard againts CPU hotpluggin while testing cpu online/present masks
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
  cpumask: Fix invalid uniprocessor mask assumption
  lib/test: Introduce cpumask KUnit test suite
  cpumask: Add UP optimised for_each_*_cpu versions
  cpumask: Update cpumask_next_wrap() signature

 arch/x86/kernel/cpu/cacheinfo.c |   6 ++
 arch/x86/kernel/smpboot.c       |   4 -
 include/linux/cpumask.h         | 108 +++++++------------------
 lib/Kconfig.debug               |   9 +++
 lib/Makefile                    |   4 +-
 lib/cpumask.c                   |   2 +
 lib/test_cpumask.c              | 138 ++++++++++++++++++++++++++++++++
 7 files changed, 184 insertions(+), 87 deletions(-)
 create mode 100644 lib/test_cpumask.c

-- 
2.36.1

