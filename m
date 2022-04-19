Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6755507340
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354780AbiDSQl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354747AbiDSQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BB41583C;
        Tue, 19 Apr 2022 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650386346; x=1681922346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9vli4iYZWjS13tNYw2fyNdEXM3eToMaMHVWZqh/R3S4=;
  b=gYWvzDBWgbUtwNXKXYcjRWXTKBjVLEXlix5zdsr5hHwXmxbQp6qY0CiO
   lJbC6QApb8ijybk0493wcgOhhLqXFsNkDmyQLZzlVvPr4DnyT3I9JID3J
   CAIgveyvmIHM4BOJae+GgsE69RSUU2BSjWkMGwzzNwJQuyiQ3NNGBwyWX
   iLJQGxgTZITbz3U7/n15tV77XSD11T4ko3QawB9j6IIwO4YhRsGB+iEiO
   EtyEL9WXger/8qZm4nwMQEC0jkIvgnSKe7GTf8QMcZMHD8BoLeaVxJCcD
   VNzTfkLX+RGUrkEWX9A5CkQE9V1zHjG0cWC58dwW80mIddUpyfhjNaXtD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245702516"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245702516"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554802124"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:05 -0700
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
Subject: [PATCH v3 00/11] Introduce In Field Scan driver
Date:   Tue, 19 Apr 2022 09:38:48 -0700
Message-Id: <20220419163859.2228874-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407191347.9681-1-jithu.joseph@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
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

Longer description of what this does, and why it is useful in the v2 cover
letter here:
  https://lore.kernel.org/all/20220407191347.9681-1-jithu.joseph@intel.com/

But the TL;DR version is this driver loads scan test files that can
check whether silicon in a CPU core is still running correctly. It
is expected that these tests would be run several times per day to
catch problems as silicon ages.

I'm posting this update because I missed many major issues when I added
my review tag. So I have a moral obligation to fix up the things that
I missed.

Changes since V2:

Dan Williams (offline):
----------------------
1) Provided the clue to split into a tiny driver that enumerates and
   registers the device. Then the IFS driver can attach to that an behave
   much more like a normal driver (original idea from Andy Lutomirski,
   used for pmem/nvdimms)

2 .. many) Lots more pointers, tips, and general good guidance to make both
   the code and commit comments better and easier to understand.

Boris:
-----
1) Add "intel_" prefixes to the two functions moving to wider scope.

Done.

2) Move the declarations from <asm/microcode_intel.h> to <asm/cpu.h>

Done.

3) intel_cpu_signatures_match() is small enough to be "inline".

Done.

Greg:
----
1) Is the firmware already submitted to the linux-firmware project for
   inclusion there?
   If not, where should a user get it from?

The scan files will be distributed by Intel on Github in much the
same way that microcode is distributed today.

2) > +struct ifs_binary ifs_binary;

   Please no static memory.  Use the driver model properly which does not
   want you to do this at all.

   You should not need this at all.  If you do, something is wrong as you
   are tying the lifecycle of the memory to the code, not to the device.

Moved this (and ifs_test) to dynamic allocation using devm_kzalloc()
and attaching the resulting pointer to the device with dev_set_drvdata().

3) > +static ssize_t details_show(struct device *dev,
   > +			    struct device_attribute *attr,
   > +			    char *buf)
   > +{
   > +	int ret;
   > +
   > +	if (down_trylock(&ifs_sem))
   > +		return -EBUSY;

   Why do you care about locking here at all?

   > +
   > +	ret = sysfs_emit(buf, "%#llx\n", ifs_test.scan_details);
   > +	up(&ifs_sem);

   What are you protecting?  The value can change right after the lock is
   released, so who cares?

Removed locking from status and details show() functions. Running a test
is synchronous. So:
  # echo 3 > run_test
  # cat status
  # cat details
will give the results of the core 3 test as expected. It is up to the user
to not do dumb things like reading status/details from another process in
parallel with running tests.

4) > +	if (!ifs_binary.loaded) {
   > +		dev_info(&ifs_pdev->dev, "Load scan binary using driver bind interface\n");

   Do not allow userspace to spam kernel logs for no reason :(

   sysfs files are not "help files" in the kernel.

Spam removed.

5) > +void ifs_sysfs_add(void)
   > +{
   > +	ifs_pdev->dev.groups = plat_ifs_groups;

   Why do you have a single global structure?

All instances of the driver for different tests can use the same files
and functions. They use "struct ifs_data *ifsd = dev_get_drvdata(dev);"
to operate on the correct driver instance.

6) > +KernelVersion:	5.19.0

   No need for ".0"

Removed.

7) > +		For e.g to test cpu5 do echo 5 > /sys/devices/platform/intel_ifs/run_test

   So core numbers are different than cpu numbers here?  How are users
   going to map them?

Added some extra text here to say that tests are per core, but any thread
on the core can be used to run the test. Should I also point people at
/sys/devices/system/cpu/cpu#/topology/thread_siblings_list? It seems
easy for users to get a list of cores with a script like:
$ cores=$(cat /sys/devices/system/cpu/cpu*/topology/thread_siblings_list | sed -e 's/,.*//' | sort -n | uniq)

8) > +Description:	Version of loaded IFS binary image.

   In what format?

Added "(hexadecimal)". Also added code (and Docs) to print "none" if the load
of the scan file failed.

9) > +Description:	echo "intel_ifs" to reload IFS image.

   Huh?  Why are you using a common sysfs file for this type of attribute?
   Please do not do so, make it "reload" or something like that.

Ok. Added a "reload" file like microcode. (Though using driver bind/unbind
also works).

10) > +Description:	IFS tunable parameter that user can modify before
   > +		the scan run if they wish to override default value.

   And where are those parameters documented?  What are valid values here?

Dropped both the "noirq" and "retry" parameters. I think they now have sane
defaults. If Jithu/Ashok have a good use case, they can send a patch to add
them back.

-Tony


Jithu Joseph (7):
  x86/microcode/intel: Expose collect_cpu_info_early() for IFS
  platform/x86/intel/ifs: Read IFS firmware image
  platform/x86/intel/ifs: Check IFS Image sanity
  platform/x86/intel/ifs: Authenticate and copy to secured memory
  platform/x86/intel/ifs: Add scan test support
  platform/x86/intel/ifs: Add IFS sysfs interface
  platform/x86/intel/ifs: add ABI documentation for IFS

Tony Luck (4):
  Documentation: In-Field Scan
  platform/x86/intel/ifs: Create device for Intel IFS (In Field Scan)
  platform/x86/intel/ifs: Add stub driver for In-Field Scan
  trace: platform/x86/intel/ifs: Add trace point to track Intel IFS
    operations

 .../ABI/testing/sysfs-platform-intel-ifs      |  39 ++
 Documentation/x86/ifs.rst                     | 101 ++++++
 Documentation/x86/index.rst                   |   1 +
 MAINTAINERS                                   |   8 +
 arch/x86/include/asm/cpu.h                    |  18 +
 arch/x86/kernel/cpu/intel.c                   |  32 ++
 arch/x86/kernel/cpu/microcode/intel.c         |  59 +---
 drivers/platform/x86/intel/Kconfig            |   1 +
 drivers/platform/x86/intel/Makefile           |   1 +
 drivers/platform/x86/intel/ifs/Kconfig        |  16 +
 drivers/platform/x86/intel/ifs/Makefile       |   5 +
 drivers/platform/x86/intel/ifs/core.c         |  74 ++++
 drivers/platform/x86/intel/ifs/ifs.h          | 103 ++++++
 .../platform/x86/intel/ifs/intel_ifs_device.c |  50 +++
 drivers/platform/x86/intel/ifs/load.c         | 265 ++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c      | 333 ++++++++++++++++++
 drivers/platform/x86/intel/ifs/sysfs.c        | 151 ++++++++
 include/trace/events/intel_ifs.h              |  38 ++
 18 files changed, 1243 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-ifs
 create mode 100644 Documentation/x86/ifs.rst
 create mode 100644 drivers/platform/x86/intel/ifs/Kconfig
 create mode 100644 drivers/platform/x86/intel/ifs/Makefile
 create mode 100644 drivers/platform/x86/intel/ifs/core.c
 create mode 100644 drivers/platform/x86/intel/ifs/ifs.h
 create mode 100644 drivers/platform/x86/intel/ifs/intel_ifs_device.c
 create mode 100644 drivers/platform/x86/intel/ifs/load.c
 create mode 100644 drivers/platform/x86/intel/ifs/runtest.c
 create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c
 create mode 100644 include/trace/events/intel_ifs.h


base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.35.1

