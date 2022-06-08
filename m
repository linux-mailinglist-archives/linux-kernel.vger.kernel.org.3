Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B085A543EF6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiFHWBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbiFHWBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:01:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4405DA1D;
        Wed,  8 Jun 2022 15:01:05 -0700 (PDT)
Date:   Wed, 08 Jun 2022 22:01:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654725664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cV7/MEgbNdmv3L9TaoMDRtxO0MmFQo38WWCZ06yj7RA=;
        b=QJo9s4elrnxQIxyc7X9W0nTbQlcI/m8hSb6hgJqk7qGErTMcqbYcGgt4Pci/6fWNQRjQ3V
        v3rYKzgalxRSvEEqlIsGPuRq5/fACn3BgPtzZu32NoQtNflP7o0qLz/AaiYokSGspXPVkd
        gLL+jhgOe3fE04jmeWb+DxLlLAOBiMjsx8b2RiegEYlxJj1B0L78fMEI7yZEfMwWHgHHh5
        bSJ1A4t/zvn3KR+o6k+/YRz87ohwAlgczaFOZIKwgWTWLEnNZHNkeYONz050wKZXZPBJ0K
        A8PGVQISRxOIO3ewwCQGuwdxxBtoenNROvhdHVnNoMEJJxT81CPMxKdf8CFGIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654725664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cV7/MEgbNdmv3L9TaoMDRtxO0MmFQo38WWCZ06yj7RA=;
        b=9xDIUSDE60AXjsXGfpVUwoPlpeO99qQEtwWtfcW3VUymdtemUNr58i+3bfDwd/C6wOkN/D
        agaK3ZJxjZ99vmCw==
From:   "tip-bot2 for Wyes Karny" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86: Handle idle=nomwait cmdline properly for x86_idle
Cc:     Wyes Karny <wyes.karny@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cfdc2dc2d0a1bc21c2f53d989ea2d2ee3ccbc0dbe=2E16545?=
 =?utf-8?q?38381=2Egit-series=2Ewyes=2Ekarny=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cfdc2dc2d0a1bc21c2f53d989ea2d2ee3ccbc0dbe=2E165453?=
 =?utf-8?q?8381=2Egit-series=2Ewyes=2Ekarny=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165472566300.4207.10310756827106084828.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8bcedb4ce04750e1ccc9a6b6433387f6a9166a56
Gitweb:        https://git.kernel.org/tip/8bcedb4ce04750e1ccc9a6b6433387f6a9166a56
Author:        Wyes Karny <wyes.karny@amd.com>
AuthorDate:    Mon, 06 Jun 2022 23:33:34 +05:30
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 08 Jun 2022 12:58:58 -07:00

x86: Handle idle=nomwait cmdline properly for x86_idle

When kernel is booted with idle=nomwait do not use MWAIT as the
default idle state.

If the user boots the kernel with idle=nomwait, it is a clear
direction to not use mwait as the default idle state.
However, the current code does not take this into consideration
while selecting the default idle state on x86.

Fix it by checking for the idle=nomwait boot option in
prefer_mwait_c1_over_halt().

Also update the documentation around idle=nomwait appropriately.

[ dhansen: tweak commit message ]

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lkml.kernel.org/r/fdc2dc2d0a1bc21c2f53d989ea2d2ee3ccbc0dbe.1654538381.git-series.wyes.karny@amd.com
---
 Documentation/admin-guide/pm/cpuidle.rst | 15 +++++++++------
 arch/x86/kernel/process.c                |  9 ++++++---
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index aec2cd2..19754be 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -612,8 +612,8 @@ the ``menu`` governor to be used on the systems that use the ``ladder`` governor
 by default this way, for example.
 
 The other kernel command line parameters controlling CPU idle time management
-described below are only relevant for the *x86* architecture and some of
-them affect Intel processors only.
+described below are only relevant for the *x86* architecture and references
+to ``intel_idle`` affect Intel processors only.
 
 The *x86* architecture support code recognizes three kernel command line
 options related to CPU idle time management: ``idle=poll``, ``idle=halt``,
@@ -635,10 +635,13 @@ idle, so it very well may hurt single-thread computations performance as well as
 energy-efficiency.  Thus using it for performance reasons may not be a good idea
 at all.]
 
-The ``idle=nomwait`` option disables the ``intel_idle`` driver and causes
-``acpi_idle`` to be used (as long as all of the information needed by it is
-there in the system's ACPI tables), but it is not allowed to use the
-``MWAIT`` instruction of the CPUs to ask the hardware to enter idle states.
+The ``idle=nomwait`` option prevents the use of ``MWAIT`` instruction of
+the CPU to enter idle states. When this option is used, the ``acpi_idle``
+driver will use the ``HLT`` instruction instead of ``MWAIT``. On systems
+running Intel processors, this option disables the ``intel_idle`` driver
+and forces the use of the ``acpi_idle`` driver instead. Note that in either
+case, ``acpi_idle`` driver will function only if all the information needed
+by it is in the system's ACPI tables.
 
 In addition to the architecture-level kernel command line options affecting CPU
 idle time management, there are parameters affecting individual ``CPUIdle``
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b370767..dca2e5e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -824,6 +824,10 @@ static void amd_e400_idle(void)
  */
 static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 {
+	/* User has disallowed the use of MWAIT. Fallback to HALT */
+	if (boot_option_idle_override == IDLE_NOMWAIT)
+		return 0;
+
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
@@ -932,9 +936,8 @@ static int __init idle_setup(char *str)
 	} else if (!strcmp(str, "nomwait")) {
 		/*
 		 * If the boot option of "idle=nomwait" is added,
-		 * it means that mwait will be disabled for CPU C2/C3
-		 * states. In such case it won't touch the variable
-		 * of boot_option_idle_override.
+		 * it means that mwait will be disabled for CPU C1/C2/C3
+		 * states.
 		 */
 		boot_option_idle_override = IDLE_NOMWAIT;
 	} else
