Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDB451CE90
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387999AbiEFBo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387983AbiEFBo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:44:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1D457131;
        Thu,  5 May 2022 18:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651801244; x=1683337244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLvHL8anf2YkJtlMQuHsQJoDiZbnI5hToTtaX6fMmgM=;
  b=hRJlILKZJueGB3gryV2JQByW7DQRT/DePilbnfjHBejW7C8/uxxoB+ax
   TnziYG7bUO8Z2sAqttN9V9bSHsXUs2jdkFHCU7//Egppfech6ERX4CBF6
   VdcWqVzeUF3O8W+MnaF8gBU0qCcueQoi6I/qK4+0THxUsVs6HrfMaCLGd
   QmZ0vmMFw6HLspKnI4oXouGbLZt3ouOLPVA/L8YptMIkesDW+RKZqkLEk
   t2kVItYtGbLnHwgBnUe63/5I5tRt2OX8V9SIZE6MjhQG2H5ZbFjdMsB06
   OHqO0zPpdeEauTVgMrrop55+L804bsDdqxFH8wyc+VsRVcokt9yd4Ckg+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293519422"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="293519422"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:40:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537645006"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:40:43 -0700
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
Subject: [PATCH v6 00/11] Introduce In Field Scan driver
Date:   Thu,  5 May 2022 18:40:24 -0700
Message-Id: <20220506014035.1173578-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428153849.295779-1-tony.luck@intel.com>
References: <20220428153849.295779-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Changes since v5:

Added various Reviewed tags. If anyone wants to take one or more
back in the light of changes listed below, please speak up.

Thomas Gleixner
---------------
03 "So checking for Intel Fam6 ANYMODEL and X86_FEATURE_CORE_CAPABILITIES is
 sufficient, no?"

Longer explanation in earlier e-mail ... but the family/model/stepping
check is needed. No change.

04 "Why is ifs_load_firmware() not returning an error to the caller?"

In most cases the return isn't useful. But this did prompt a change
to make sure "echo 1 > reload" does give an error if the load fails.

05 "The above struct is nicely tabular. Can we have that here too please?"

Added <TAB>s to ifs_data structure to make it equally pretty.

06 "Setting the authenticated indicator _before_ actually doing the
authentication is just wrong. It does not matter in this case, but it's
still making my eyes bleed."

Moved indicator to after success has been checked.

06 "Why has this to be a smp function call? Just because it's conveniant?
This is nothing urgent and no hotpath, so this really can use
queue_work_on()."

Even simpler is schedule_work_on() [since other changes mean that
the driver no longer allocates a work queue.


07 "Waiting for a second with preemption disabled? Seriously?"
   "Plus another half a second with preemption disabled. That's just insane."
   "That local_irq_disable() solves what?"
   "Why cpu_hotplug_disable()? Why is cpus_read_lock() not sufficient here?"
   "Why does this need GFP_NOWAIT?"
   "I put that into the wishful thinking realm"
   "The real question is why you try to rendevouz CPUs via work queues."
   "pseudo-code to use stomp_machine()"

PeterZ contributed a neatly tailored for this usage "stop_core_cpuslocked()"
function that works beautifully. See part 0003 of this new series. That
meant all of the code that triggered the above comments has gone.

Tony Luck
---------
Noticed unnecessary casts from u8 to u32 in the checksum calculation
in load.c. Fixed.

Changed the tracepoint to include the CPU number of the core being
tested (the tracepoint otherwise just tells you which CPU is executing
the driver code and executing "stop_core_cpuslocked()" to do the actual
work on the target CPUs.

Dropped the msec_to_tsc() function that was used to initialize
activate.delay. Just use a #define of 100000 cycles (two orders
of magnitude bigger than I saw for the slew between the two threads
executing the "stop_core_cpuslocked()" target function ... but not
too insane so if the threads do not sync, we give up quickly).



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

Tony Luck (3):
  x86/msr-index: Define INTEGRITY_CAPABILITIES MSR
  platform/x86/intel/ifs: Add stub driver for In-Field Scan
  trace: platform/x86/intel/ifs: Add trace point to track Intel IFS
    operations

 .../ABI/testing/sysfs-platform-intel-ifs      |  39 +++
 MAINTAINERS                                   |   8 +
 arch/x86/include/asm/cpu.h                    |  18 ++
 arch/x86/include/asm/msr-index.h              |   7 +
 arch/x86/kernel/cpu/intel.c                   |  32 +++
 arch/x86/kernel/cpu/microcode/intel.c         |  59 +---
 drivers/platform/x86/intel/Kconfig            |   1 +
 drivers/platform/x86/intel/Makefile           |   1 +
 drivers/platform/x86/intel/ifs/Kconfig        |  13 +
 drivers/platform/x86/intel/ifs/Makefile       |   3 +
 drivers/platform/x86/intel/ifs/core.c         |  74 +++++
 drivers/platform/x86/intel/ifs/ifs.h          | 124 ++++++++
 drivers/platform/x86/intel/ifs/load.c         | 266 ++++++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c      | 255 +++++++++++++++++
 drivers/platform/x86/intel/ifs/sysfs.c        | 149 ++++++++++
 include/linux/stop_machine.h                  |  16 ++
 include/trace/events/intel_ifs.h              |  41 +++
 kernel/stop_machine.c                         |  19 ++
 18 files changed, 1073 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-ifs
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

