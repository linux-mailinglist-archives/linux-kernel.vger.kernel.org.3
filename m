Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820D859563C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiHPJ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiHPJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:28:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CCC32BA9;
        Tue, 16 Aug 2022 00:46:59 -0700 (PDT)
Date:   Tue, 16 Aug 2022 07:46:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660636016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uE0ctiRvwSAPDmXFIQiPQ6ExYkHKJOcuiBLOysW1J9g=;
        b=QkcxL5NnkQqOtM3XfcfwMajXdHJJNMrFvQSDC58ZWcQDJz+0JlrPJrXz1s2k/O7DmRPBWB
        vT2vKrINkqyIP6EWaljULF0RShoJfi7mCGig7BshiSbKl7Xq3o08gKociCj3Ux2yEMXhG0
        A3r2dfW7hxw9M/UCMAYLsFs6iZFWKdXrmQT1GyuAbQDfzabk27Dw1PrJaWQ0RJYHw9sN0Q
        xHIjNfBGtBPpR/0PF7Clcj1TcUmCrX4xSLoP1olIllF4LW6oZSQMxqQnQlNjvkQ5P0DoaG
        Puwn71rEDs9BlL9unZNey+DRgi0Ok1syIAGwpNEK27ucJofgK93tsgS834Is+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660636016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uE0ctiRvwSAPDmXFIQiPQ6ExYkHKJOcuiBLOysW1J9g=;
        b=G5WT06f9ujVNbBk9bRN6bOcyBEn6eJkyN95xblhhtm3QXnjX3+L0glLmoP/TPCXTafjxj0
        9vTncC7QM0wdqmBA==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Document the whole late loading problem
Cc:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220813223825.3164861-2-ashok.raj@intel.com>
References: <20220813223825.3164861-2-ashok.raj@intel.com>
MIME-Version: 1.0
Message-ID: <166063601497.401.9527776956724011207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     764fc2a82fed0a4f0ce7444c34a3683bad06e403
Gitweb:        https://git.kernel.org/tip/764fc2a82fed0a4f0ce7444c34a3683bad06e403
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Sat, 13 Aug 2022 22:38:21 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 16 Aug 2022 09:37:24 +02:00

x86/microcode: Document the whole late loading problem

Commit

  d23d33ea0fcd ("x86/microcode: Taint and warn on late loading")

started tainting the kernel after microcode late loading.

There is some history behind why x86 microcode started doing the late
loading stop_machine() rendezvous. Document the whole situation.

No functional changes.

  [ bp: Fix typos, heavily massage. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220813223825.3164861-2-ashok.raj@intel.com
---
 Documentation/admin-guide/tainted-kernels.rst |   6 +-
 Documentation/x86/microcode.rst               | 116 +++++++++++++++--
 2 files changed, 113 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 7d80e8c..92a8a07 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -134,6 +134,12 @@ More detailed explanation for tainting
        scsi/snic on something else than x86_64, scsi/ips on non
        x86/x86_64/itanium, have broken firmware settings for the
        irqchip/irq-gic on arm64 ...).
+     - x86/x86_64: Microcode late loading is dangerous and will result in
+       tainting the kernel. It requires that all CPUs rendezvous to make sure
+       the update happens when the system is as quiescent as possible. However,
+       a higher priority MCE/SMI/NMI can move control flow away from that
+       rendezvous and interrupt the update, which can be detrimental to the
+       machine.
 
  3)  ``R`` if a module was force unloaded by ``rmmod -f``, ``' '`` if all
      modules were unloaded normally.
diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index a320d37..b627c6f 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -6,6 +6,7 @@ The Linux Microcode Loader
 
 :Authors: - Fenghua Yu <fenghua.yu@intel.com>
           - Borislav Petkov <bp@suse.de>
+	  - Ashok Raj <ashok.raj@intel.com>
 
 The kernel has a x86 microcode loading facility which is supposed to
 provide microcode loading methods in the OS. Potential use cases are
@@ -92,15 +93,8 @@ vendor's site.
 Late loading
 ============
 
-There are two legacy user space interfaces to load microcode, either through
-/dev/cpu/microcode or through /sys/devices/system/cpu/microcode/reload file
-in sysfs.
-
-The /dev/cpu/microcode method is deprecated because it needs a special
-userspace tool for that.
-
-The easier method is simply installing the microcode packages your distro
-supplies and running::
+You simply install the microcode packages your distro supplies and
+run::
 
   # echo 1 > /sys/devices/system/cpu/microcode/reload
 
@@ -110,6 +104,110 @@ The loading mechanism looks for microcode blobs in
 /lib/firmware/{intel-ucode,amd-ucode}. The default distro installation
 packages already put them there.
 
+Since kernel 5.19, late loading is not enabled by default.
+
+The /dev/cpu/microcode method has been removed in 5.19.
+
+Why is late loading dangerous?
+==============================
+
+Synchronizing all CPUs
+----------------------
+
+The microcode engine which receives the microcode update is shared
+between the two logical threads in a SMT system. Therefore, when
+the update is executed on one SMT thread of the core, the sibling
+"automatically" gets the update.
+
+Since the microcode can "simulate" MSRs too, while the microcode update
+is in progress, those simulated MSRs transiently cease to exist. This
+can result in unpredictable results if the SMT sibling thread happens to
+be in the middle of an access to such an MSR. The usual observation is
+that such MSR accesses cause #GPs to be raised to signal that former are
+not present.
+
+The disappearing MSRs are just one common issue which is being observed.
+Any other instruction that's being patched and gets concurrently
+executed by the other SMT sibling, can also result in similar,
+unpredictable behavior.
+
+To eliminate this case, a stop_machine()-based CPU synchronization was
+introduced as a way to guarantee that all logical CPUs will not execute
+any code but just wait in a spin loop, polling an atomic variable.
+
+While this took care of device or external interrupts, IPIs including
+LVT ones, such as CMCI etc, it cannot address other special interrupts
+that can't be shut off. Those are Machine Check (#MC), System Management
+(#SMI) and Non-Maskable interrupts (#NMI).
+
+Machine Checks
+--------------
+
+Machine Checks (#MC) are non-maskable. There are two kinds of MCEs.
+Fatal un-recoverable MCEs and recoverable MCEs. While un-recoverable
+errors are fatal, recoverable errors can also happen in kernel context
+are also treated as fatal by the kernel.
+
+On certain Intel machines, MCEs are also broadcast to all threads in a
+system. If one thread is in the middle of executing WRMSR, a MCE will be
+taken at the end of the flow. Either way, they will wait for the thread
+performing the wrmsr(0x79) to rendezvous in the MCE handler and shutdown
+eventually if any of the threads in the system fail to check in to the
+MCE rendezvous.
+
+To be paranoid and get predictable behavior, the OS can choose to set
+MCG_STATUS.MCIP. Since MCEs can be at most one in a system, if an
+MCE was signaled, the above condition will promote to a system reset
+automatically. OS can turn off MCIP at the end of the update for that
+core.
+
+System Management Interrupt
+---------------------------
+
+SMIs are also broadcast to all CPUs in the platform. Microcode update
+requests exclusive access to the core before writing to MSR 0x79. So if
+it does happen such that, one thread is in WRMSR flow, and the 2nd got
+an SMI, that thread will be stopped in the first instruction in the SMI
+handler.
+
+Since the secondary thread is stopped in the first instruction in SMI,
+there is very little chance that it would be in the middle of executing
+an instruction being patched. Plus OS has no way to stop SMIs from
+happening.
+
+Non-Maskable Interrupts
+-----------------------
+
+When thread0 of a core is doing the microcode update, if thread1 is
+pulled into NMI, that can cause unpredictable behavior due to the
+reasons above.
+
+OS can choose a variety of methods to avoid running into this situation.
+
+
+Is the microcode suitable for late loading?
+-------------------------------------------
+
+Late loading is done when the system is fully operational and running
+real workloads. Late loading behavior depends on what the base patch on
+the CPU is before upgrading to the new patch.
+
+This is true for Intel CPUs.
+
+Consider, for example, a CPU has patch level 1 and the update is to
+patch level 3.
+
+Between patch1 and patch3, patch2 might have deprecated a software-visible
+feature.
+
+This is unacceptable if software is even potentially using that feature.
+For instance, say MSR_X is no longer available after an update,
+accessing that MSR will cause a #GP fault.
+
+Basically there is no way to declare a new microcode update suitable
+for late-loading. This is another one of the problems that caused late
+loading to be not enabled by default.
+
 Builtin microcode
 =================
 
