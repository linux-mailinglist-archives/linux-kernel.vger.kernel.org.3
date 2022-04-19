Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96746507359
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354822AbiDSQmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbiDSQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913A515A32;
        Tue, 19 Apr 2022 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650386347; x=1681922347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NA8+CwAZOe9pALoUtEw8c4AIdJ41F1kIfFTTUm8pZhM=;
  b=D+O6O90wdAnGlU44CS8mPwiTzu8dymRX+cv8WTTaFW4TQjMvT6SCiBBq
   bl/RmqpcSl6Id09H9Ys1UpWj1wr4Ic2fQwBkwcv4CSFh1DViBzR4QnJFu
   89GCNjt05YK9tWyPvCg4zXtOQvkuPcsblkMYNPYvMUK1C5seXcVNYuPYL
   4dPRHbPGED0+hCYdy7nPE3OCY3OEcD+w2uukwaYc2tH0Vx+PWWorcQhl9
   lkyLPT7z8G+rdX0GAMvgMpXm+26wjHiX/DDigJ6A/MsFla6qwAaaEAyUg
   WJrsBXDE9MaSGjrj4Y3QFy1bSonf41HszjuLV4nfG2bNGMmyMfuca5HGk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245702522"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245702522"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554802133"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:06 -0700
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
Subject: [PATCH v3 02/11] Documentation: In-Field Scan
Date:   Tue, 19 Apr 2022 09:38:50 -0700
Message-Id: <20220419163859.2228874-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419163859.2228874-1-tony.luck@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for In-Field Scan (IFS). This documentation
describes the basics of IFS, the loading IFS image, chunk
authentication, running scan and how to check result via sysfs
as well as tunable parameters.

The CORE_CAPABILITIES MSR enumerates whether IFS is supported.

The full  github location for distributing the IFS images is
still being decided. So just a placeholder included for now
in the documentation.

Future CPUs will support more than one type of test. Plan for
that now by using a ".0" suffix on the ABI directory names.
Additional test types will use ".1", etc.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/x86/ifs.rst   | 101 ++++++++++++++++++++++++++++++++++++
 Documentation/x86/index.rst |   1 +
 2 files changed, 102 insertions(+)
 create mode 100644 Documentation/x86/ifs.rst

diff --git a/Documentation/x86/ifs.rst b/Documentation/x86/ifs.rst
new file mode 100644
index 000000000000..62f3c07d433a
--- /dev/null
+++ b/Documentation/x86/ifs.rst
@@ -0,0 +1,101 @@
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
+Future CPUs will support more than one type of test which will show up
+with a new platform-device instance-id, for now only .0 is exposed.
+
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
+is installed it can be loaded by writing to the driver reload file::
+
+  # echo 1 > /sys/bus/platform/drivers/intel_ifs.0/reload
+
+Similar to microcode, the current version of the scan tests is stored
+in a fixed location: /lib/firmware/intel/ifs.0/family-model-stepping.scan
+
+Running tests
+-------------
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
+The IFS driver provides sysfs interfaces via /sys/devices/platform/intel_ifs.0/
+to control execution:
+
+Test a specific core::
+
+  # echo <cpu#> > /sys/devices/platform/intel_ifs.0/run_test
+
+when HT is enabled any of the sibling cpu# can be specified to test its
+corresponding physical core. Since the tests are per physical core, the
+result of testing any thread is same. It is only necessary to test one
+thread.
+
+For e.g. to test core corresponding to cpu5
+
+  # echo 5 > /sys/devices/platform/intel_ifs.0/run_test
+
+Results of the last test is provided in /sys::
+
+  $ cat /sys/devices/platform/intel_ifs.0/status
+  pass
+
+Status can be one of pass, fail, untested
+
+Additional details of the last test is provided by the details file::
+
+  $ cat /sys/devices/platform/intel_ifs.0/details
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
+1) The ACTIVATE_SCAN MSR allows for running any consecutive subrange of
+available tests. But the driver always tries to run all tests and only
+uses the subrange feature to restart an interrupted test.
+
+2) Hardware allows for some number of cores to be tested in parallel.
+The driver does not make use of this, it only tests one core at a time.
+
+.. [#f1] https://github.com/intel/TBD
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 91b2fa456618..9d8e8a73d57b 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -35,6 +35,7 @@ x86-specific Documentation
    usb-legacy-support
    i386/index
    x86_64/index
+   ifs
    sva
    sgx
    features
-- 
2.35.1

