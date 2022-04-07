Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBA94F87D6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbiDGTQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiDGTQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:16:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A134923EC46;
        Thu,  7 Apr 2022 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649358864; x=1680894864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gdB7mmdg0+r+RjAud4x1g52iXULZa8HpVX5ut6yH8ww=;
  b=Fg2qw+4flxACT4llwuwR+7TqgqWolROXCgpsgJE5F6Q19LyeYJde4wBO
   +AXLNYXxLNeE08df+UwEpOCWkBKwe8G+YJxneoqtpPXi6MWAvwkEHJphI
   D5T44//ikQveHtbxJ487NsWFzTprcpxBldgmoKV7KKsMkt9irWsmX+OFa
   ve0MzOkjUbASRNRzKwcwc+dqLUQX1JuyMAjXp/u78/9j9M9eINHyt3ktn
   akdZTEac2SidFf3kUv500Xp0SEveihoThP3XaV8B55JLMNtsR6AUjDuJn
   i/FaxhiSBYuhp6otWapg657ce24UXBt+rkaeMm1yZDUjAhLqSMOKasIh1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260255377"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="260255377"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571193706"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:16 -0700
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
Subject: [PATCH v2 02/10] Documentation: In-Field Scan
Date:   Thu,  7 Apr 2022 12:13:39 -0700
Message-Id: <20220407191347.9681-3-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220407191347.9681-1-jithu.joseph@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

The full  github location for distributing the IFS images is
still being decided. So just a placeholder included for now
in the documentation.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 Documentation/x86/ifs.rst   | 114 ++++++++++++++++++++++++++++++++++++
 Documentation/x86/index.rst |   1 +
 2 files changed, 115 insertions(+)
 create mode 100644 Documentation/x86/ifs.rst

diff --git a/Documentation/x86/ifs.rst b/Documentation/x86/ifs.rst
new file mode 100644
index 000000000000..f8a1b1f57de8
--- /dev/null
+++ b/Documentation/x86/ifs.rst
@@ -0,0 +1,114 @@
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
+Intel provides a firmware file containing the scan tests via
+github [#f1]_.  Similar to microcode there is a separate file for each
+family-model-stepping.
+
+IFS Image Loading
+-----------------
+
+The driver loads the tests into memory reserved BIOS local to each CPU
+socket in a two step process using writes to MSRs to first load the
+SHA hashes for the test. Then the tests themselves. Status MSRs provide
+feedback on the success/failure of these steps. When a new test file
+is installed it can be loaded by triggering a driver bind as below::
+
+  # echo "intel_ifs" > /sys/bus/platform/drivers/intel_ifs/unbind
+  # echo "intel_ifs" > /sys/bus/platform/drivers/intel_ifs/bind
+
+Similar to microcode, the current version of the scan tests is stored
+in a fixed location: /lib/firmware/intel/ifs/family-model-stepping.scan
+
+Triggering tests
+----------------
+
+Tests are run by the driver synchronizing execution of all threads on a
+core and then writing to the ACTIVATE_SCAN MSR on all threads. Instruction
+execution continues when:
+
+1) All tests have completed.
+2) Execution was interrupted.
+3) A test detected a problem.
+
+In all cases reading the SCAN_STATUS MSR provides details on what
+happened. The driver makes the value of this MSR visible to applications
+via the "details" file (see below). Interrupted tests may be restarted.
+
+The IFS driver provides sysfs interfaces via /sys/devices/platform/intel_ifs/
+to control execution:
+
+Test a specific core::
+
+  # echo <cpu#> > /sys/devices/platform/intel_ifs/run_test
+
+when HT is enabled any of the sibling cpu# can be specified to test its
+corresponding physical core. Since the tests are per physical core, the
+result of testing any thread is same. It is only necessary to test one
+thread.
+
+For e.g. to test core corresponding to cpu5
+
+  # echo 5 > /sys/devices/platform/intel_ifs/run_test
+
+Results of the last test is provided in /sys::
+
+  $ cat /sys/devices/platform/intel_ifs/status
+  pass
+
+Status can be one of pass, fail, untested
+
+Additional details of the last test is provided by the details file::
+
+  $ cat /sys/devices/platform/intel_ifs/details
+  0x8081
+
+The details file reports the hex value of the SCAN_STATUS MSR.
+Hardware defined error codes are documented in volume 4 of the Intel
+Software Developer's Manual but the error_code field may contain one of
+the following driver defined software codes:
+
++------+--------------------+
+| 0xFD | Software timeout   |
++------+--------------------+
+| 0xFE | Partial completion |
++------+--------------------+
+
+Driver design choices
+---------------------
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
+1. noirq: When set (default), system interrupts are not allowed to interrupt an ifs scan.
+Unsetting this might be helpful to improve the irq latency during the test.
+
+2. retry: Maximum retry counter when the test chunk is not executed due to an event such as
+interrupt. The default value for this parameter is 5, it accepts a value between 1 and 20.
+If test status continuously reports as "untested", increasing the value might help.
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

