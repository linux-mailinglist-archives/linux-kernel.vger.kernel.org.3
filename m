Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9804D50C374
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiDVWLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiDVWIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:08:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986172D8233;
        Fri, 22 Apr 2022 13:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650660984; x=1682196984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=66e0gas27WRp3ksBUhkcYZ1nbpEm7fWfloenmE7L+68=;
  b=LMKDHn56W5K8CLLS6Zff5bGIBoehGgIEGh3c0nGku6wu2T1PRgwDR8UX
   2cn/oEbRFYAWAUKUAj0e95bzSj/yhh13LIsqoIlVJDtcRd7vzk2I/ZXUY
   OhG/gJU2uHgOLUSFalQgMPEpQayqsQgfH5todljgnbqQ+lHW0BrNoELpC
   vpf3u8qcu2RauwnqwmPFFgimvCrJD+qUxd90HXL8nsU79cBtp9E7Vjkw6
   0YAxXwVoOzSexaWZRLuXQ/hhTJDa4aJ7GkJOfxel7YawZLAp0tHCmXsUt
   7fHlWnDnixPy9SrHTiH6RF9AniDm9i7orgqD1f30XPp/OkvYNUIeez5jI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289897434"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="289897434"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:02:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="511719312"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:02:25 -0700
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
Subject: [PATCH v4 00/10] Introduce In Field Scan driver
Date:   Fri, 22 Apr 2022 13:02:09 -0700
Message-Id: <20220422200219.2843823-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419163859.2228874-1-tony.luck@intel.com>
References: <20220419163859.2228874-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TL;DR this driver loads scan test files that can check whether silicon
in a CPU core is still running correctly. It is expected that these tests
would be run several times per day to catch problems as silicon ages.

Changes since v3:

Thomas Gleixner:
----------------
1) intel_collect_cpu_info_early() ... function name doesn't make sense
   in context of this driver

   True: Dropped the "_early" suffix from the name.

Greg Kroah-Hartman:
-------------------
1) "Ick, why?" and "pmem.c should not be used as a good example of anything"
   and "Why not just use a misc device?"

   Now using a misc device.

2) "So even if everything fails, you succeed?"

   This was w.r.t. the "pmem"-like driver, which is completely gone in
   v4. New driver succeeds if any of the test-types enumerate as present
   on the system. Fails with -ENODEV if no test types found.

3) "sysfs documentation belongs in Documentation/ABI/"

   See patch 10 of this series.

4) "And why not just include this whole thing in the driver itself and suck
   the documentation out of that?  No need to have a separate file."

   Dropped Documentation/x86/ifs.rst from v4. People should be able to
   figure out how to use it from the ABI docs for the sysfs files. If
   that turns out to be wrong, we can revisit.

5) "int load_ifs_binary(struct device *dev)
    Shouldn't all of your global symbols start with "ifs_"?  Your other ones
    seem to, what went wrong here?
    Also, how about "ifs_load_firmware()" makes more sense."

    Changed name to ifs_load_firmware()

6) "static bool ifs_image_sanity_check(struct device *dev, void *data)
    u8 *data?"  and
   "if (!ifs_image_sanity_check(dev, (void *)fw->data)) {
    It's not a void pointer, it's a pointer to u8.  Why cast it away?"

   Changed the top of that call stack to cast to "(struct microcode_header_intel *)
   which is what the lower level functions all want.

7) "if (!sysfs_streq(buf, "1"))
   kstrtobool()?

   Changed from sysfs_streq() to kstrtobool()

8) "ATTRIBUTE_GROUPS()?"

   Now using this macro.

Steven Rostedt:
---------------
1) "TP_PROTO(union ifs_scan activate, union ifs_status status),

   Really, you want to pass the structure in by value, so that we have two
   copies? One to get to this function and then one to write to the ring
   buffer?"

   Discussion on list resolved because these "pass by value" objects are
   just wrappers around a u64. Passing pointers wouldn't make any real
   difference. No code change.

Jithu Joseph (7):
  x86/microcode/intel: Expose collect_cpu_info_early() for IFS
  platform/x86/intel/ifs: Read IFS firmware image
  platform/x86/intel/ifs: Check IFS Image sanity
  platform/x86/intel/ifs: Authenticate and copy to secured memory
  platform/x86/intel/ifs: Add scan test support
  platform/x86/intel/ifs: Add IFS sysfs interface
  platform/x86/intel/ifs: add ABI documentation for IFS

Tony Luck (3):
  x86/msr-index: Define INTEGRITY_CAPABILITIES MSR
  platform/x86/intel/ifs: Add stub driver for In-Field Scan
  trace: platform/x86/intel/ifs: Add trace point to track Intel IFS
    operations

 .../ABI/testing/sysfs-platform-intel-ifs      |  39 ++
 MAINTAINERS                                   |   8 +
 arch/x86/include/asm/cpu.h                    |  18 +
 arch/x86/include/asm/msr-index.h              |   7 +
 arch/x86/kernel/cpu/intel.c                   |  32 ++
 arch/x86/kernel/cpu/microcode/intel.c         |  59 +---
 drivers/platform/x86/intel/Kconfig            |   1 +
 drivers/platform/x86/intel/Makefile           |   1 +
 drivers/platform/x86/intel/ifs/Kconfig        |  13 +
 drivers/platform/x86/intel/ifs/Makefile       |   3 +
 drivers/platform/x86/intel/ifs/core.c         |  97 +++++
 drivers/platform/x86/intel/ifs/ifs.h          | 123 +++++++
 drivers/platform/x86/intel/ifs/load.c         | 262 ++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c      | 332 ++++++++++++++++++
 drivers/platform/x86/intel/ifs/sysfs.c        | 147 ++++++++
 include/trace/events/intel_ifs.h              |  38 ++
 16 files changed, 1128 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-ifs
 create mode 100644 drivers/platform/x86/intel/ifs/Kconfig
 create mode 100644 drivers/platform/x86/intel/ifs/Makefile
 create mode 100644 drivers/platform/x86/intel/ifs/core.c
 create mode 100644 drivers/platform/x86/intel/ifs/ifs.h
 create mode 100644 drivers/platform/x86/intel/ifs/load.c
 create mode 100644 drivers/platform/x86/intel/ifs/runtest.c
 create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c
 create mode 100644 include/trace/events/intel_ifs.h


base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.35.1

