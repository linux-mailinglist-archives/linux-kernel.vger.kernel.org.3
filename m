Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3064C9535
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbiCAT4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiCAT4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:56:35 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760B76CA59;
        Tue,  1 Mar 2022 11:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646164554; x=1677700554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1grK952Uv/mTeG41VPRB/n4tgViBRWh0iu2ugzI+fQ4=;
  b=SB2H0qP1XFWL2Jfjs+LumAP3fa1rqTIguPeyx9PQtdf9RPKH4PMy1elI
   jbLnyvTcS+qROcRzF1WVAKxHWlDvNFN4hrj/9GjNbKTaOo42xgQB+R5Mf
   Jg0glAF1blQ6H+jY3uBe+8KcYvwdEo7EM7YwxaNzFae6eNqDG4V3GgZ4/
   x74MxCmWgF9JSv6c6jqYleCU1OSSgGa/SWGAoKHrIJUWtBFRhN3zms7Gr
   SvVx65L6/NViuCa0xOb/4pTOm+yoVw0p9R+ahrJzlcQMIIELx+aM+RXUE
   S89MI+ocvoJdifJ5HJuvnDlg9oi/xSBhZKWKbo+5bDx72U/xbBsDbsoz4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233194891"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233194891"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:53 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630133158"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:53 -0800
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
Subject: [RFC 02/10] Documentation: In-Field Scan
Date:   Tue,  1 Mar 2022 11:54:49 -0800
Message-Id: <20220301195457.21152-3-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220301195457.21152-1-jithu.joseph@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Add documentation for In-Field Scan (IFS). This documentation
describes the basics of IFS, the loading IFS image, chunk
authentication, running scan and how to check result via sysfs
as well as tunable parameters.

The CORE_CAPABILITIES MSR enumerates whether IFS is supported.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 Documentation/x86/ifs.rst   | 108 ++++++++++++++++++++++++++++++++++++
 Documentation/x86/index.rst |   1 +
 2 files changed, 109 insertions(+)
 create mode 100644 Documentation/x86/ifs.rst

diff --git a/Documentation/x86/ifs.rst b/Documentation/x86/ifs.rst
new file mode 100644
index 000000000000..fa77639f52dd
--- /dev/null
+++ b/Documentation/x86/ifs.rst
@@ -0,0 +1,108 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+In-Field Scan
+=============
+
+Introduction
+------------
+
+In Field Scan (IFS) is a hardware feature to run circuit level tests on
+a CPU core to detect problems that are not caught by parity or ECC checks.
+
+IFS Image
+---------
+
+Intel will provide a firmware file containing the scan tests via
+github [#f1]_.  Similar to microcode there is a separate file for each
+family-model-stepping. The tests in the file are divided into some number
+of "chunks" that can be run individually.
+
+IFS Image Loading
+-----------------
+
+The driver loads the tests into memory reserved BIOS local to each CPU
+socket in a two step process using writes to MSRs to first load the
+SHA hashes for the test. Then the tests themselves. Status MSRs provide
+feedback on the success/failure of these steps. When a new test file
+is installed it can be loaded with::
+
+  # echo 1 > /sys/devices/system/cpu/ifs/reload
+
+Triggering tests
+----------------
+
+Tests are run by synchronizing execution of all threads on a core and then
+writing to the ACTIVATE_SCAN MSR on all threads. Instruction execution
+continues when:
+
+1) All tests have completed.
+2) Execution was interrupted.
+3) A test detected a problem.
+
+In all cases reading the SCAN_STATUS MSR provides details on what
+happened. Interrupted tests may be restarted.
+
+The IFS driver provides interfaces from /sys to control execution:
+
+Run tests on all cores::
+
+  # echo 1 > /sys/devices/system/cpu/ifs/run_test
+
+Scans run on each core sequentially by logical CPU number (when HT is
+enabled this only runs the tests once for each core).
+
+Test a single core::
+
+  # echo 1 > /sys/devices/system/cpu/cpu#/ifs/run_test
+
+Results of the tests are also provided in /sys::
+
+  $ cat /sys/devices/system/cpu/ifs/status
+  pass
+
+global status. Shows the most serious status across
+all cores (fail > untested > pass)
+
+There are files showing which CPUs are in each of the
+pass/untested/fail states::
+
+  $ cat /sys/devices/system/cpu/ifs/cpu_fail_list
+  $ cat /sys/devices/system/cpu/ifs/cpu_untested_list
+  $ cat /sys/devices/system/cpu/ifs/cpu_pass_list
+  0-127
+
+Also files in the per-CPU directories showing the status
+of the most recent test on that core::
+
+  $ cat /sys/devices/system/cpu/cpu#/ifs/status
+  pass
+  $ cat /sys/devices/system/cpu/cpu#/ifs/details
+  8081
+
+The details file reports the hex value of the SCAN_STATUS MSR.  Note that
+the error_code field may contain driver defined software code not defined
+in the Intel SDM.
+
+Current driver limitations
+--------------------------
+
+1) The ACTIVATE_SCAN MSR allows for running any consecutive subrange or
+available tests. But the driver always tries to run all tests and only
+uses the subrange feature to restart an interrupted test.
+
+2) Hardware allows for some number of cores to be tested in parallel.
+The driver does not make use of this, it only tests one core at a time.
+
+Tunable Parameters
+------------------
+
+This module accepts two tunable parameters. These could be provided at
+load time or can be modified at runtime through module parameter.
+(/sys/module/ifs/parameters/<parameter_name>). The parameters are as
+described below.
+
+1. noint: When set, system interrupts are not allowed to interrupt an ifs.
+2. retry: Maximum retry counter when the test is not executed due to an event such as interrupt.
+
+.. [#f1] https://github.com/intel
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index f498f1d36cd3..be58b7638d9e 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -33,6 +33,7 @@ x86-specific Documentation
    usb-legacy-support
    i386/index
    x86_64/index
+   ifs
    sva
    sgx
    features
-- 
2.17.1

