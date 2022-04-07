Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991D84F87CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347113AbiDGTQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiDGTQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:16:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D064523EC55;
        Thu,  7 Apr 2022 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649358862; x=1680894862;
  h=from:to:cc:subject:date:message-id;
  bh=Nh2EfB8DTwSlal0AZxLBzMYGFtwXC55JTovhfbgkI7g=;
  b=AdaFAx/8eFDJlct+hkDBzwr0SX2jgiq2wUPQ+mippZDYU4Lk7KuhTrCN
   e703lMcFlkgds/IjVqVMDAy6NgMWTMkBzkD/nbIhz8Wf/JN1vree0F8y3
   7zXcH8QaHeYeeDYgNrRpkl1TjDgsmi87Mh+Pj7HUc8r2whSMIWBvTrkYg
   dld6ZKujdxpnTs5fvZsW1xZH1cCQ0Lv1SJyPQtAE7mi+keYEl+cwYefcH
   M35uEu0b3UUGibkH5t/kh/XapZ0Vj5C7TfzMez3IPd2KcmRzGnAbdvm+I
   diUJ1okklM4+hYrfvSP51KVAc8Pcna1Usx1TAJhXYGpNx2Pdw1R+D4lkd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260255375"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="260255375"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571193697"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:15 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v2 00/10] Introduce In Field Scan driver
Date:   Thu,  7 Apr 2022 12:13:37 -0700
Message-Id: <20220407191347.9681-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note to Maintainers:
Requesting x86 Maintainers to take a look at patch1 as it
touches arch/x86 portion of the kernel.

Patch 2/10 - Adds Documentation. Requesting Documentation maintainer to review it.

Requesting Greg KH to review the sysfs changes added by patch8 (note that in
this revision we no longer touch /sys/devices/system/cpu as in previous version
and limit ourselves to only /sys/devices/platform/intel_ifs)

Patch10 - adds tracing support, requesting Steven Rostedt to review that.

Rest of the patches adds the IFS platform driver, requesting Platform driver maintainers
to review them.

This is the v2 version incorporating the review feedback from the RFC version [1]

In Field Scan (IFS) is a hardware feature to run circuit level tests on
a CPU core to detect problems that are not caught by parity or ECC checks.
See References section to understand more about CPU core errors and how
and when they are encountered.

Intel will provide a firmware file containing the scan tests.  Similar to
microcode there is a separate file for each family-model-stepping. The
tests in the file are divided into some number of "chunks" that can be
run individually.

The driver loads the tests into memory reserved BIOS local to each CPU
socket in a two step process using writes to MSRs to first load the
SHA hashes for the test. Then the tests themselves. Status MSRs provide
feedback on the success/failure of these steps.

Tests are run by synchronizing execution of all threads on a core and
then writing to the ACTIVATE_SCAN MSR on all threads. Instruction
execution continues when:

1) all tests have completed
2) execution was interrupted
3) a test detected a problem

In all cases reading the SCAN_STATUS MSR provides details on what
happened. Interrupted tests may be restarted.

The IFS driver provides interfaces from /sys to control execution:

/sys/devices/platform/intel_ifs/run_test
  Writing <cpu#> to this file will trigger a scan on that core
  e.g echo 5 > sys/devices/platform/intel_ifs/run_test will trigger
  scan on the core containing cpu5

Results of the tests are also provided in /sys:

/sys/devices/platform/intel_ifs/status
  Status (pass/fail/untested) for the last test

/sys/devices/platform/intel_ifs/details
  Hex value of the SCAN_STATUS MSR for the most recent test.
  Note that the error_code field may contain driver
  defined software code not defined in the Intel SDM.

Driver design choices:

1) The ACTIVATE_SCAN MSR allows for running any consecutive subrange or
available tests. But the driver always tries to run all tests and only
uses the subrange feature to restart an interrupted test.

2) Hardware allows for some number of cores to be tested in parallel.
The driver does not make use of this, it only tests one core at a time.

References
Links to a few articles, papers, presentation  [2] [3] [4] [5] which
talk about cpu core errors encountered in the wild which could be
relevant to this work.

[1] https://lore.kernel.org/lkml/20220301195457.21152-1-jithu.joseph@intel.com/
[2] https://sigops.org/s/conferences/hotos/2021/papers/hotos21-s01-hochschild.pdf
[3] https://www.youtube.com/watch?v=QMF3rqhjYuM
[4] https://engineering.fb.com/2021/02/23/data-infrastructure/silent-data-corruption/
[5] https://www.theregister.com/2021/06/04/google_chip_flaws/

Changes since RFC:
 - Renamed collect_cpu_info_early() - >cpu_collect_info_early() (Patch 1; GregKH)
 - Refactored collect_cpu_info_early(), cpu_signatures_match() from
    microcode specific file to intel-generic file (Patch 1; Borislav Petkov)
 - Keep the same platform driver object through-out the life-time of
   the driver (patch 4; Dan Wiliiams)
 - Replace platform_device_register_simple() with platform_device_alloc/add()
   so that sysfs files are available instantateously (patch 4;  Dan Wiliiams)
 - Move IFS binary loading to driver_probe context from module_init
   context (patch4;  Dan Wiliiams)
 - Remove the version check during scan image load so as to allow user
   to move to any IFS binary (Patch 4)
 - Replace pr_* macros with dev_* macros (Patches 3-9;  Dan Wiliiams)
 - Replace percpu kthreads with work_queue worker threads  (Patch 7; Dan Wiliiams)
 - Remove hotplug callbacks which are no longer required due to above
   change (Patch 7;  Dan Wiliiams)
 - Remove percpu ifs_state data structure as it is no longer needed (Patch 7)
 - Refactored test logic into a separate runtest.c file (Patch 7, Tony Luck)
 - Moved sysfs interface from /sys/devices/system/cpu/ifs and
   /sys/devices/system/cpu/cpu#/ifs to /sys/devices/platform/intel_ifs
 - Done away with global/percpu testing interfaces. To trigger a test,
   there is a single run_test file which takes cpu_number as input.
   This hugely reduces the number of sysfs file needed. Userspace can iterate
   over all the cpus to achevie global testing (Patch8;  Dan Wiliiams)
 - Remove the reload sysfs interface for IFS binary loading. Since binary loading
   is done from the probe context, reloading can be acheieved using driver
   bind sysfs interface (Patch 8; Dan Williams)
 - Updated the Documentation/ ABI files to reflect the sysfs changes
 - Change trace event structure field ordering (patch 10; Steven Rostedt)
 - misc changes
     - adding enum type for ifs_status_err_code
     - replace sprintf with sysfs_emit in sysfs.c

Jithu Joseph (8):
  x86/microcode/intel: expose collect_cpu_info_early() for IFS
  platform/x86/intel/ifs: Add driver for In-Field Scan
  platform/x86/intel/ifs: Load IFS Image
  platform/x86/intel/ifs: Check IFS Image sanity
  platform/x86/intel/ifs: Authenticate and copy to secured memory
  platform/x86/intel/ifs: Add scan test support
  platform/x86/intel/ifs: Add IFS sysfs interface
  platform/x86/intel/ifs: add ABI documentation for IFS

Tony Luck (2):
  Documentation: In-Field Scan
  trace: platform/x86/intel/ifs: Add trace point to track Intel IFS
    operations

 .../ABI/testing/sysfs-platform-intel-ifs      |  54 ++++
 Documentation/x86/ifs.rst                     | 114 +++++++
 Documentation/x86/index.rst                   |   1 +
 MAINTAINERS                                   |   7 +
 arch/x86/include/asm/microcode_intel.h        |   4 +
 arch/x86/kernel/cpu/intel.c                   |  47 +++
 arch/x86/kernel/cpu/microcode/intel.c         |  55 +---
 drivers/platform/x86/intel/Kconfig            |   1 +
 drivers/platform/x86/intel/Makefile           |   1 +
 drivers/platform/x86/intel/ifs/Kconfig        |   9 +
 drivers/platform/x86/intel/ifs/Makefile       |   3 +
 drivers/platform/x86/intel/ifs/core.c         | 121 +++++++
 drivers/platform/x86/intel/ifs/ifs.h          | 137 ++++++++
 drivers/platform/x86/intel/ifs/load.c         | 285 +++++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c      | 300 ++++++++++++++++++
 drivers/platform/x86/intel/ifs/sysfs.c        | 139 ++++++++
 include/trace/events/intel_ifs.h              |  38 +++
 17 files changed, 1266 insertions(+), 50 deletions(-)
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

-- 
2.17.1

