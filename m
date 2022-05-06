Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEFC51E1F2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444545AbiEFW6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355654AbiEFW6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:58:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19286D383;
        Fri,  6 May 2022 15:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651877657; x=1683413657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K49HW2lGdqLpqgHUeIlMgvOoThkBm11e0LDnwNiLuac=;
  b=StUKBB1rIOLrM5GpEjH0RPSHuDghlii/27ProeW/c0ZR2Ye1Xekp6akq
   syqs6w0BwNv4ZuPTu+fzs1vEz7NJD7r+m30y+HCCGNEgKgngzoocQGM4R
   qh17HZbM7EsyxO16esH6Sh/leOa0QG3T6lMnFQEmLSjXuzAdoJjm9o3CR
   G3YNvZOQJQEXMTV5mNKccJ3JeKnyep2LqASTb0Ef/zrPrI/ZvEbUuhCk/
   pJsAZ7bECa2ZevyvCbtosUZ1qVU2v9SzE8lgkzzg5YbPE/wi/X50djVH/
   2RSxB3+qk4jQTSkAyriaQFrNgpdK39R324fkoDuL7+jTdUusFn7Ukk9fo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="256080777"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="256080777"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 15:54:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="695383613"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 15:54:16 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v7 00/12] Introduce In Field Scan driver
Date:   Fri,  6 May 2022 15:53:58 -0700
Message-Id: <20220506225410.1652287-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506014035.1173578-1-tony.luck@intel.com>
References: <20220506014035.1173578-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TL;DR this driver loads scan test files that can check whether silicon
in a CPU core is still running correctly. It is expected that these tests
would be run several times per day to catch problems as silicon ages.

Changes since v6

Thomas Gleixner
---------------
"struct workqueue_struct *ifs_wq; Seems to be unused."

True. Deleted.

"static bool oscan_enabled = true; What changes this?"

Code that cleared it deleted. Drop this too.

"Please add curly brackets as these are not one-line statements"

Added

cpumask_first(topology_sibling_cpumask(cpu)); Shouldn't that be cpu_smt_mask()?"

Changed (and several other places)

"take up to 200 milliseconds before it retires.  200ms per test chunk?"

Updated comment to note that 200ms is for all chunks.

"Documentation lost in the intertubes"

Dredged up the version from v3 series and changed:
1) Fixed pathnames now this is a virtual misc device instead of platform
device
2) Put all the text into a "/** DOC:" comment section in ifs.h with just
a "kernel-doc:: drivers/platform/x86/intel/ifs/ifs.h" in the ifs.rst
file under Documentation/x86.
3) Added a "big fat warning" (in all CAPS) pointing out that a core test
can take up to 200 milliseconds. So admins must take extra steps if they
are running latency sensitive workloads.
4) Added note that all HT threads of a core must be online to run a
test.

Tony Luck
---------
Off-by-one on retries check (#define set to 5, but tried 6 times). Fixed
Fixed kerneldoc description of "integrity_cap_bit" (was missing a ":")

Jithu Joseph (7):
  x86/microcode/intel: Expose collect_cpu_info_early() for IFS
  platform/x86/intel/ifs: Read IFS firmware image
  platform/x86/intel/ifs: Check IFS Image sanity
  platform/x86/intel/ifs: Authenticate and copy to secured memory
  platform/x86/intel/ifs: Add scan test support
  platform/x86/intel/ifs: Add IFS sysfs interface
  platform/x86/intel/ifs: add ABI documentation for IFS

Peter Zijlstra (1):
  stop_machine: Add stop_core_cpuslocked() for per-core operations

Tony Luck (4):
  x86/msr-index: Define INTEGRITY_CAPABILITIES MSR
  platform/x86/intel/ifs: Add stub driver for In-Field Scan
  trace: platform/x86/intel/ifs: Add trace point to track Intel IFS
    operations
  Documentation: In-Field Scan

 .../ABI/testing/sysfs-platform-intel-ifs      |  39 +++
 Documentation/x86/ifs.rst                     |   2 +
 Documentation/x86/index.rst                   |   1 +
 MAINTAINERS                                   |   8 +
 arch/x86/include/asm/cpu.h                    |  18 ++
 arch/x86/include/asm/msr-index.h              |   7 +
 arch/x86/kernel/cpu/intel.c                   |  32 +++
 arch/x86/kernel/cpu/microcode/intel.c         |  59 +---
 drivers/platform/x86/intel/Kconfig            |   1 +
 drivers/platform/x86/intel/Makefile           |   1 +
 drivers/platform/x86/intel/ifs/Kconfig        |  13 +
 drivers/platform/x86/intel/ifs/Makefile       |   3 +
 drivers/platform/x86/intel/ifs/core.c         |  73 +++++
 drivers/platform/x86/intel/ifs/ifs.h          | 234 +++++++++++++++
 drivers/platform/x86/intel/ifs/load.c         | 266 ++++++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c      | 252 +++++++++++++++++
 drivers/platform/x86/intel/ifs/sysfs.c        | 149 ++++++++++
 include/linux/stop_machine.h                  |  16 ++
 include/trace/events/intel_ifs.h              |  41 +++
 kernel/stop_machine.c                         |  19 ++
 20 files changed, 1182 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-ifs
 create mode 100644 Documentation/x86/ifs.rst
 create mode 100644 drivers/platform/x86/intel/ifs/Kconfig
 create mode 100644 drivers/platform/x86/intel/ifs/Makefile
 create mode 100644 drivers/platform/x86/intel/ifs/core.c
 create mode 100644 drivers/platform/x86/intel/ifs/ifs.h
 create mode 100644 drivers/platform/x86/intel/ifs/load.c
 create mode 100644 drivers/platform/x86/intel/ifs/runtest.c
 create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c
 create mode 100644 include/trace/events/intel_ifs.h


base-commit: 672c0c5173427e6b3e2a9bbb7be51ceeec78093a
-- 
2.35.1

