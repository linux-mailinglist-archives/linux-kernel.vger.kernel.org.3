Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0E04C9524
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbiCAT4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiCAT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:56:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417A16CA59;
        Tue,  1 Mar 2022 11:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646164553; x=1677700553;
  h=from:to:cc:subject:date:message-id;
  bh=ZsRSSF2FTp0Mg8lz0zBKDVOKeH3y/9833OAKFTTqWnc=;
  b=euBdMoZS2I6c6ORhWD3rWrs/+mbO8ad7xCHUvN9bbHUeqZ3oYgoRz4wG
   mEuRonc01nYE8U+yyEi80wyDX2VbBU2D7Ge55iqGZ1gtO4mDo2Y7d9w3q
   nBgMNYap8VvAGYYDRppIfsa0La2/7zopxLG6na2mf00tRlmUIPRV79QBJ
   3PBd3tJdmQnUef7cTHl212R2N4pVQT+XwAuZ2sJ0KHvswUqbi1V2TJJAr
   7lQso22KKKTpBbBzCy/CsLxKrQkb9uxLHoMyQa1yzaYioBJ9goUQhIkQV
   lQNXPrmJxZ+8z3HMRPpcojFhCgfJjL9pmkg9npP/yfEajOqVPYhtcPJTe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233194887"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233194887"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:53 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630133152"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:52 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: [RFC 00/10] Introduce In Field Scan driver
Date:   Tue,  1 Mar 2022 11:54:47 -0800
Message-Id: <20220301195457.21152-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note to Maintainers:
Requesting x86 Maintainers to take a look at patch01 as it
touches arch/x86 portion of the kernel. Also would like to guide them
to patch07 which sets up hotplug notifiers and creates kthreads.

Patch 2/10 - Adds Documentation. Requesting Documentation maintainer to review it.

Requesting Greg KH to review the sysfs changes added by patch08.

Patch10 adds tracing support, requesting Steven Rostedt to review that.

Rest of the patches adds the IFS platform driver, requesting Platform driver maintainers
to review them.


In Field Scan (IFS) is a hardware feature to run circuit level tests on
a CPU core to detect problems that are not caught by parity or ECC checks.

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

The IFS driver provides interfaces from /sys to reload tests and to
control execution:

/sys/devices/system/cpu/ifs/reload
  Writing "1" to this file will reload the tests from
  /lib/firmware/intel/ifs/{ff-mm-ss}.scan

/sys/devices/system/cpu/ifs/run_test
  Writing "1" to this file will trigger a scan on each core
  sequentially by logical CPU number (when HT is enabled this only
  runs the tests once for each core)

/sys/devices/system/cpu/cpu#/ifs/run_test
  Writing "1" to one of these files will trigger a scan on just
  that core.

Results of the tests are also provided in /sys:

/sys/devices/system/cpu/ifs/status
  Global status. Will show the most serious status across
  all cores (fail > untested > pass)

/sys/devices/system/cpu/ifs/cpu_fail_list
/sys/devices/system/cpu/ifs/cpu_pass_list
/sys/devices/system/cpu/ifs/cpu_untested_list
  CPU lists showing which CPUs have which test status

/sys/devices/system/cpu/cpu#/ifs/status
  Status (pass/fail/untested) of each core

/sys/devices/system/cpu/cpu#/ifs/details
  Hex value of the SCAN_STATUS MSR for the most recent test on
  this core. Note that the error_code field may contain driver
  defined software code not defined in the Intel SDM.

Current driver limitations:

1) The ACTIVATE_SCAN MSR allows for running any consecutive subrange or
available tests. But the driver always tries to run all tests and only
uses the subrange feature to restart an interrupted test.

2) Hardware allows for some number of cores to be tested in parallel.
The driver does not make use of this, it only tests one core at a time.


Jithu Joseph (8):
  x86/microcode/intel: expose collect_cpu_info_early() for IFS
  platform/x86/intel/ifs: Add driver for In-Field Scan
  platform/x86/intel/ifs: Load IFS Image
  platform/x86/intel/ifs: Check IFS Image sanity
  platform/x86/intel/ifs: Authenticate and copy to secured memory
  platform/x86/intel/ifs: Create kthreads for online cpus for scan test
  platform/x86/intel/ifs: Add IFS sysfs interface
  platform/x86/intel/ifs: add ABI documentation for IFS

Tony Luck (2):
  Documentation: In-Field Scan
  trace: platform/x86/intel/ifs: Add trace point to track Intel IFS
    operations

 Documentation/ABI/stable/sysfs-driver-ifs |  85 +++++
 Documentation/x86/ifs.rst                 | 108 ++++++
 Documentation/x86/index.rst               |   1 +
 MAINTAINERS                               |   7 +
 arch/x86/include/asm/microcode_intel.h    |   6 +
 arch/x86/kernel/cpu/microcode/intel.c     |   8 +-
 drivers/platform/x86/intel/Kconfig        |   1 +
 drivers/platform/x86/intel/Makefile       |   1 +
 drivers/platform/x86/intel/ifs/Kconfig    |   9 +
 drivers/platform/x86/intel/ifs/Makefile   |   7 +
 drivers/platform/x86/intel/ifs/core.c     | 387 +++++++++++++++++++++
 drivers/platform/x86/intel/ifs/ifs.h      | 155 +++++++++
 drivers/platform/x86/intel/ifs/load.c     | 299 ++++++++++++++++
 drivers/platform/x86/intel/ifs/sysfs.c    | 394 ++++++++++++++++++++++
 include/trace/events/ifs.h                |  38 +++
 15 files changed, 1503 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-ifs
 create mode 100644 Documentation/x86/ifs.rst
 create mode 100644 drivers/platform/x86/intel/ifs/Kconfig
 create mode 100644 drivers/platform/x86/intel/ifs/Makefile
 create mode 100644 drivers/platform/x86/intel/ifs/core.c
 create mode 100644 drivers/platform/x86/intel/ifs/ifs.h
 create mode 100644 drivers/platform/x86/intel/ifs/load.c
 create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c
 create mode 100644 include/trace/events/ifs.h

-- 
2.17.1

