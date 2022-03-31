Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233564EDFF6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiCaR7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiCaR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:59:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5CE2220D5;
        Thu, 31 Mar 2022 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648749449; x=1680285449;
  h=subject:to:cc:from:date:message-id;
  bh=Tni5TvFdZxJ9Gt3pi48UQ12BLf0D4PuKmQOSgUQxUec=;
  b=MU+RCm7TwQoxw7w8q1UdRlnqNbZ0WzDkC/7GJCouMkQ5O3lSd04woxiy
   0QAYVuEryP50PZuBh+TkHztONN95220Oxgg3htp60SPkzTnI3pdiKwaZO
   f/HOFT2tdlrSMDjD6XK4s0511kFk903zsavkkRVcP+T64GAfuA3XscgEB
   +JSYSESjk8YQsY67Sgr6rqQAPkizLIqfUbLHZx4Aav2DnvZ+wxM8ZGqsB
   1KwUa9g9gIxZaYV0YvJJ/5Hluwk6FNQ96NZ8qlSQj9hftpmvhmj74JsF6
   WFSqximRjOC7Na2GCgPzb/8C36+artfcm5UNxrKKwRLFf5v0TsPmGEs1u
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="258742366"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="258742366"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 10:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="840872318"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmsmga005.fm.intel.com with ESMTP; 31 Mar 2022 10:57:28 -0700
Subject: [PATCH] [v2] x86/configs: Add x86 debugging Kconfig fragment plus docs
To:     linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>,
        corbet@lwn.net, bp@suse.de, tglx@linutronix.de, x86@kernel.org,
        linux-doc@vger.kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 31 Mar 2022 10:57:28 -0700
Message-Id: <20220331175728.299103A0@davehans-spike.ostc.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changes from v1:

 * Add actual .config fragment instead of just documenting it
 * Note that these partially x86-specific, but the rest can be
   used to test all tip contributions.

--

From: Dave Hansen <dave.hansen@linux.intel.com>

The kernel has a wide variety of debugging options to help catch
and squash bugs.  However, new debugging is added all the time and
the existing options can be hard to find.

Add a Kconfig fragment with the debugging options which tip
maintainers expect to be used to test contributions.

This should make it easier for contributors to test their code and
find issues before submission.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
---

 b/Documentation/process/maintainer-tip.rst |   14 ++++++++++++++
 b/kernel/configs/x86_debug.config          |   17 +++++++++++++++++
 2 files changed, 31 insertions(+)

diff -puN Documentation/process/maintainer-tip.rst~0001-RFC-Documentation-process-Add-testing-section-to-tip Documentation/process/maintainer-tip.rst
--- a/Documentation/process/maintainer-tip.rst~0001-RFC-Documentation-process-Add-testing-section-to-tip	2022-03-31 10:52:55.718665861 -0700
+++ b/Documentation/process/maintainer-tip.rst	2022-03-31 10:52:55.722665862 -0700
@@ -437,6 +437,20 @@ in a private repository which allows int
 series for testing. The usual way to offer this is a git URL in the cover
 letter of the patch series.
 
+Testing
+^^^^^^^
+
+Code should be tested before submitting to the tip maintainers.  Anything
+other than minor changes should be built, booted and tested with
+comprehensive (and heavyweight) kernel debugging options enabled.
+
+These debugging options can be found in kernel/configs/x86_debug.config
+and can be added to an existing kernel config by running:
+
+	make x86_debug.config
+
+Some of these options are x86-specific and can be left out when testing
+on other architectures.
 
 Coding style notes
 ------------------
diff -puN /dev/null kernel/configs/x86_debug.config
--- /dev/null	2022-03-26 18:22:40.487999538 -0700
+++ b/kernel/configs/x86_debug.config	2022-03-31 10:53:10.318671042 -0700
@@ -0,0 +1,17 @@
+CONFIG_X86_DEBUG_FPU=y
+CONFIG_LOCK_STAT=y
+CONFIG_DEBUG_VM=y
+CONFIG_DEBUG_VM_VMACACHE=y
+CONFIG_DEBUG_VM_RB=y
+CONFIG_DEBUG_SLAB=y
+CONFIG_DEBUG_KMEMLEAK=y
+CONFIG_DEBUG_PAGEALLOC=y
+CONFIG_SLUB_DEBUG_ON=y
+CONFIG_KMEMCHECK=y
+CONFIG_DEBUG_OBJECTS=y
+CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
+CONFIG_GCOV_KERNEL=y
+CONFIG_LOCKDEP=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_SCHEDSTATS=y
+CONFIG_VMLINUX_VALIDATION=y
_
