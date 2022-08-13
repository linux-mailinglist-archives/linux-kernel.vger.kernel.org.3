Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587F6591D08
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 00:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbiHMWjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 18:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiHMWix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 18:38:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB52C6CD11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 15:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660430331; x=1691966331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O38mwLkr/xGj2TuCsbHRlP99zod9IRJU32RP0Fml5/Q=;
  b=Y++h1C766ffQYLZdBrUnk8kSsgnbQLDYFcgr1kkAZKlG2apfVJp5lhQH
   UbyRRZEU3MzkoEhCXFHSfZR7CwopeqthkxecW9tX8Iuu1Lium+INzxwkJ
   W0Eng4bc3lQTR12fz/qQ+MGXorEcUIHau0h30bq4QC5QN/23hoyM2s5pj
   IqTlysq1gOEF/d/ZXv+5MveX5uJ3NQFBOVUFirsJSiSNDYVhTslE8P5hX
   r05czPW47DjSDM+hIPepvEFd4Hyo+/upioNfAZmK/zPaZaPn/rmFt4dmI
   dRvphPPIs+W3/FrxlCrcU4d7SswDcMu8GEWOMTvv/QpMThcydCEPXbGGm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353523719"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="353523719"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 15:38:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="556890226"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 15:38:49 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 1/5] x86/microcode: Add missing documentation that late-load will taint kernel
Date:   Sat, 13 Aug 2022 22:38:21 +0000
Message-Id: <20220813223825.3164861-2-ashok.raj@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220813223825.3164861-1-ashok.raj@intel.com>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d23d33ea0fcd made late-load taint the kernel. Documentation for
tainted kernels was missed.

There is some history behind why x86 microcode started doing the late_load
stop_machine() rendezvous. It was suggested that it would be good
background to document.

No other functional change.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 Documentation/admin-guide/tainted-kernels.rst |  8 +-
 Documentation/x86/microcode.rst               | 95 ++++++++++++++++++-
 2 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index ceeed7b0798d..3513182b5dec 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -133,7 +133,13 @@ More detailed explanation for tainting
        scsi/snic on something else than x86_64, scsi/ips on non
        x86/x86_64/itanium, have broken firmware settings for the
        irqchip/irq-gic on arm64 ...).
-
+     - x86/x86_64: kernel "late-loads" of a microcode update
+       is dangerous and will result in tainting the kernel. Late loading
+       requires rendezvous to make sure we update when the system is
+       quiesce and not executing anything else. But the presence of
+       MCE/SMI/NMI can cause control flow away from the rendezvous
+       that can't be controlled
+e
  3)  ``R`` if a module was force unloaded by ``rmmod -f``, ``' '`` if all
      modules were unloaded normally.
 
diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index a320d37982ed..941c48c26d84 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -6,6 +6,7 @@ The Linux Microcode Loader
 
 :Authors: - Fenghua Yu <fenghua.yu@intel.com>
           - Borislav Petkov <bp@suse.de>
+	  - Ashok Raj <ashok.raj@intel.com>
 
 The kernel has a x86 microcode loading facility which is supposed to
 provide microcode loading methods in the OS. Potential use cases are
@@ -92,12 +93,10 @@ vendor's site.
 Late loading
 ============
 
-There are two legacy user space interfaces to load microcode, either through
-/dev/cpu/microcode or through /sys/devices/system/cpu/microcode/reload file
+Loading microcode is through /sys/devices/system/cpu/microcode/reload file
 in sysfs.
 
-The /dev/cpu/microcode method is deprecated because it needs a special
-userspace tool for that.
+The /dev/cpu/microcode method is deprecated and removed since 5.19.
 
 The easier method is simply installing the microcode packages your distro
 supplies and running::
@@ -110,6 +109,92 @@ The loading mechanism looks for microcode blobs in
 /lib/firmware/{intel-ucode,amd-ucode}. The default distro installation
 packages already put them there.
 
+Why is late loading dangerous?
+==============================
+Starting 5.19, kernel configuration was changed to not compile
+late-loading by default.  Even if one were to enable the CONFIG, it
+will end up tainting the kernel.  Some of the reasons are explained
+below.
+
+Rendezvous all CPUs
+-------------------
+Microcode is a core resource, hence both threads of HT share the same
+microcode resource.  Updating on one thread of the core, the sibling
+automatically gets the update. There are some MSR's that are flow control
+(virtual) MSR's.  While the microcode update is in progress, these MSR's
+cease to exist.  This can result in unpredictable results, if the second
+sibling thread happens to be in the middle of an access to an MSR that
+is being patched at the same time. MSR's are just one common issue we
+trip over, but any other instruction that's being patched, can also result 
+in similar behavior.
+
+To eliminate this case, we introduced stop_machine() as a way to guarantee
+that the thread sibling will not execute any code  and just waits in a spin
+loop polling an atomic variable.
+
+While this took care of device or external interrupts, IPI's include LVT ones,
+such as CMCI etc, there are other special interrupts that can't be shut off.
+Those are Machine Checks (#MC), Systems Management Interrupt (#SMI) and
+Non-Maskable interrupts (#NMI).
+
+Machine Checks
+--------------
+Machine Checks (#MC) are non-maskable. There are two kinds of MCEs. Fatal
+un-recoverable MCEs and recoverable MCEs. While un-recoverable errors
+are fatal in behavior, recoverable errors can also happen in kernel context
+are also treated as fatal by the kernel.
+
+#MCE's are also broadcast to all threads in a system. If one thread is in
+the middle of wrmsr() MCE will be taken at the end of the flow. Either they will
+wait for this thread performing the wrmsr(0x79) to rendezvous in MCE handler
+and shutdown eventually if any of the threads in the system fail to checkin
+to the MCE rendezvous.
+
+To be paranoid and get predictable behavior, OS can choose to set
+MCG_STATUS.MCIP. Since MCE's can be at most one in a system, 
+if an MCE was signaled, the above condition will promote to a system reset
+automatically. OS can turn off MCIP at the end of the update for that core.
+
+System Management Interrupt
+---------------------------
+#SMI's are also broadcast via HW to all CPUs in the platform. Microcode
+updates requests exclusive access to the core before a wrmsr 0x79. So if it
+does happen such that, one thread is in wrmsr flow, and the 2nd got an SMI,
+that thread will be stopped in the first instruction in SMI handler.
+
+Since the secondary thread is stopped in the first instruction in SMI,
+there is very little chance that it would be in the middle of executing an
+instruction being patched. Plus OS has no way to stop SMI's from happening.
+
+Since there seems some reasonable behavior micro-architecturally (for
+Intel CPUs), it seems benign.
+
+Non-Maskable Interrupts
+-----------------------
+When thread0 of a core is doing the microcode update, if thread1 is pulled
+into NMI, that can cause unpredictable behavior due to reasons sighted
+above.
+
+OS can choose a variety of methods to avoid running into this situation.
+
+Is the microcode suitable for late loading?
+-------------------------------------------
+Late loading is done when system is fully operational and running real
+workloads. Late-loads behavior depends on what the base patch on the CPU is
+before upgrading to the new patch.
+
+This is true for Intel CPUs.
+
+For e.g. Consider CPU is on patch1 and we are updating to patch3.
+Between patch1 and patch3, patch2 might have deprecated a user visible
+feature. This can cause unexpected behavior in the kernel if the kernel
+happened to be using those features. For instance say MSR_X is no longer
+available after an update, accessing that MSR can cause #GP fault.
+
+Basically there is no way to declare a new microcode update suitable for
+late-loading. This is another one of the problems that caused late-loads to
+be disabled from being default enabled.
+
 Builtin microcode
 =================
 
@@ -134,7 +219,7 @@ This basically means, you have the following tree structure locally::
   |   |-- 06-3a-09
   ...
 
-so that the build system can find those files and integrate them into
+So that the build system can find those files and integrate them into
 the final kernel image. The early loader finds them and applies them.
 
 Needless to say, this method is not the most flexible one because it
-- 
2.32.0

