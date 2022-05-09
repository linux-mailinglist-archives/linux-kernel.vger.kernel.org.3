Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026C25204FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbiEITL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240413AbiEITLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:11:21 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C629954F
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 12:07:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652123243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EkFD1fi2DMJyDMqe6JC23GNJMEwl8KxQZeJUIWsDFSE=;
        b=bSVeJpsxpfF/gZ6ybl32z8xoaFp8SLatMfc9aVTiKSNdm31EwIRdrOue2bVI4SXXou+HQ7
        UmtBrF8mKhroE/Ys64WNVEaw4PAtIFFNfYgl8IAty9fepkiH4yhZU0vExAKBpodLEUxidA
        jY+oLuGyRpiKmjD86P5z/6XHWt/7KC4=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 2/3] kasan: move boot parameters section in documentation
Date:   Mon,  9 May 2022 21:07:18 +0200
Message-Id: <ec9c923f35e7c5312836c4624a7f317dc1ee2c1c.1652123204.git.andreyknvl@google.com>
In-Reply-To: <5bd58ebebf066593ce0e1d265d60278b5f5a1874.1652123204.git.andreyknvl@google.com>
References: <5bd58ebebf066593ce0e1d265d60278b5f5a1874.1652123204.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Move the "Boot parameters" section in KASAN documentation next to the
section that describes KASAN build options.

No content changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 82 +++++++++++++++----------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index aca219ed1198..7f103e975ac2 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -94,6 +94,47 @@ To include alloc and free stack traces of affected slab objects into reports,
 enable ``CONFIG_STACKTRACE``. To include alloc and free stack traces of affected
 physical pages, enable ``CONFIG_PAGE_OWNER`` and boot with ``page_owner=on``.
 
+Boot parameters
+~~~~~~~~~~~~~~~
+
+KASAN is affected by the generic ``panic_on_warn`` command line parameter.
+When it is enabled, KASAN panics the kernel after printing a bug report.
+
+By default, KASAN prints a bug report only for the first invalid memory access.
+With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
+effectively disables ``panic_on_warn`` for KASAN reports.
+
+Alternatively, independent of ``panic_on_warn``, the ``kasan.fault=`` boot
+parameter can be used to control panic and reporting behaviour:
+
+- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
+  report or also panic the kernel (default: ``report``). The panic happens even
+  if ``kasan_multi_shot`` is enabled.
+
+Hardware Tag-Based KASAN mode (see the section about various modes below) is
+intended for use in production as a security mitigation. Therefore, it supports
+additional boot parameters that allow disabling KASAN or controlling features:
+
+- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
+
+- ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
+  is configured in synchronous, asynchronous or asymmetric mode of
+  execution (default: ``sync``).
+  Synchronous mode: a bad access is detected immediately when a tag
+  check fault occurs.
+  Asynchronous mode: a bad access detection is delayed. When a tag check
+  fault occurs, the information is stored in hardware (in the TFSR_EL1
+  register for arm64). The kernel periodically checks the hardware and
+  only reports tag faults during these checks.
+  Asymmetric mode: a bad access is detected synchronously on reads and
+  asynchronously on writes.
+
+- ``kasan.vmalloc=off`` or ``=on`` disables or enables tagging of vmalloc
+  allocations (default: ``on``).
+
+- ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
+  traces collection (default: ``on``).
+
 Error reports
 ~~~~~~~~~~~~~
 
@@ -208,47 +249,6 @@ traces point to places in code that interacted with the object but that are not
 directly present in the bad access stack trace. Currently, this includes
 call_rcu() and workqueue queuing.
 
-Boot parameters
-~~~~~~~~~~~~~~~
-
-KASAN is affected by the generic ``panic_on_warn`` command line parameter.
-When it is enabled, KASAN panics the kernel after printing a bug report.
-
-By default, KASAN prints a bug report only for the first invalid memory access.
-With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
-effectively disables ``panic_on_warn`` for KASAN reports.
-
-Alternatively, independent of ``panic_on_warn``, the ``kasan.fault=`` boot
-parameter can be used to control panic and reporting behaviour:
-
-- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
-  report or also panic the kernel (default: ``report``). The panic happens even
-  if ``kasan_multi_shot`` is enabled.
-
-Hardware Tag-Based KASAN mode (see the section about various modes below) is
-intended for use in production as a security mitigation. Therefore, it supports
-additional boot parameters that allow disabling KASAN or controlling features:
-
-- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
-
-- ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
-  is configured in synchronous, asynchronous or asymmetric mode of
-  execution (default: ``sync``).
-  Synchronous mode: a bad access is detected immediately when a tag
-  check fault occurs.
-  Asynchronous mode: a bad access detection is delayed. When a tag check
-  fault occurs, the information is stored in hardware (in the TFSR_EL1
-  register for arm64). The kernel periodically checks the hardware and
-  only reports tag faults during these checks.
-  Asymmetric mode: a bad access is detected synchronously on reads and
-  asynchronously on writes.
-
-- ``kasan.vmalloc=off`` or ``=on`` disables or enables tagging of vmalloc
-  allocations (default: ``on``).
-
-- ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
-  traces collection (default: ``on``).
-
 Implementation details
 ----------------------
 
-- 
2.25.1

