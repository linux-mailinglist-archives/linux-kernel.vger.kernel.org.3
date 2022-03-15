Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589284DA391
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351557AbiCOT4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351517AbiCOT4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F64455BFB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647374130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R7dp/CibjIaAvZCxnKDUcVUV0m7U/x5ooS86iBO8Et0=;
        b=QgY7LUG+r5YajyCceqBXClWcLburJZHiyWhp7yhDlV46f3BYoe9kB56JNZSUH4tekyOqvU
        XlKxz6bbWCrdlUNtkO6OZqO6OwW992MkiZZ8HJVv+ur8HLjjCEGGth/LPL8CpfJBR4jXAT
        D2hTZIl/6lsAxWdmjUai7nmoUb7oLxc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-hnzuO5baPFGyuB4m5lmc6A-1; Tue, 15 Mar 2022 15:55:27 -0400
X-MC-Unique: hnzuO5baPFGyuB4m5lmc6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82624803D64;
        Tue, 15 Mar 2022 19:55:26 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7872C4C7A1;
        Tue, 15 Mar 2022 19:55:25 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B5CE5416D5DC; Tue, 15 Mar 2022 12:33:58 -0300 (-03)
Message-ID: <20220315153313.908516477@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 12:31:36 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v12 04/13] add prctl task isolation prctl docs and samples
References: <20220315153132.717153751@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation and userspace sample code for prctl
task isolation interface.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v8:
- Document the possibility for ISOL_F_QUIESCE_ONE, to configure
individual features                                              (Frederic Weisbecker).
- Fix PR_ISOL_CFG_GET typo in documentation                      (Frederic Weisbecker).
- Rebased against linux-2.6.git.

v7:
-  No changes
v6:
 - Update docs and samples regarding oneshot mode (Frederic Weisbecker).
 - Update docs and samples regarding more extensibility of
   CFG_SET of ISOL_F_QUIESCE                   (Frederic Weisbecker).

v5:
 - Fix documentation typos		      (Frederic Weisbecker).
 - Fix oneshot example comment

v4:
 - Switch to structures for parameters when possible
   (which are more extensible).
 - Switch to CFG_{S,G}ET naming and use drop
   "internal configuration" prctls            (Frederic Weisbecker).
 - Add summary of terms to documentation      (Frederic Weisbecker).
 - Examples for compute and one-shot modes    (Thomas G/Christoph L).

v3:
 - Split in smaller patches              (Nitesh Lal).
 - Misc cleanups                         (Nitesh Lal).
 - Clarify nohz_full is not a dependency (Nicolas Saenz).
 - Incorrect values for prctl definitions (kernel robot).
 - Save configured state, so applications
   can activate externally configured
   task isolation parameters.
-  Remove "system default" notion (chisol should
   make it obsolete).
 - Update documentation: add new section with explanation
   about configuration/activation and code example.
 - Update samples.

v2:

- Finer-grained control of quiescing (Frederic Weisbecker / Nicolas Saenz).
- Avoid potential regressions by allowing applications
  to use ISOL_F_QUIESCE_DEFMASK (whose default value
  is configurable in /sys/).         (Nitesh Lal / Nicolas Saenz).

 Documentation/userspace-api/task_isolation.rst |  370 +++++++++++++++++++++++++
 samples/Kconfig                                |    7 
 samples/Makefile                               |    1 
 samples/task_isolation/Makefile                |   11 
 samples/task_isolation/task_isol.c             |   92 ++++++
 samples/task_isolation/task_isol.h             |    9 
 samples/task_isolation/task_isol_computation.c |   89 ++++++
 samples/task_isolation/task_isol_oneshot.c     |  104 +++++++
 samples/task_isolation/task_isol_userloop.c    |   54 +++
 9 files changed, 737 insertions(+)

Index: linux-2.6/Documentation/userspace-api/task_isolation.rst
===================================================================
--- /dev/null
+++ linux-2.6/Documentation/userspace-api/task_isolation.rst
@@ -0,0 +1,379 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+Task isolation prctl interface
+===============================
+
+Certain types of applications benefit from running uninterrupted by
+background OS activities. Realtime systems and high-bandwidth networking
+applications with user-space drivers can fall into the category.
+
+To create an OS noise free environment for the application, this
+interface allows userspace to inform the kernel the start and
+end of the latency sensitive application section (with configurable
+system behaviour for that section).
+
+Note: the prctl interface is independent of nohz_full=.
+
+The prctl options are:
+
+
+        - PR_ISOL_FEAT_GET: Retrieve supported features.
+        - PR_ISOL_CFG_GET: Retrieve task isolation configuration.
+        - PR_ISOL_CFG_SET: Set task isolation configuration.
+        - PR_ISOL_ACTIVATE_GET: Retrieve task isolation activation state.
+        - PR_ISOL_ACTIVATE_SET: Set task isolation activation state.
+
+Summary of terms:
+
+
+- feature:
+
+        A distinct attribute or aspect of task isolation. Examples of
+        features could be logging, new operating modes (eg: syscalls disallowed),
+        userspace notifications, etc. The only feature currently available is quiescing.
+
+- configuration:
+
+        A specific choice from a given set
+        of possible choices that dictate how the particular feature
+        in question should behave.
+
+- activation state:
+
+        The activation state (whether active/inactive) of the task
+        isolation features (features must be configured before
+        being activated).
+
+Inheritance of the isolation parameters and state, across
+fork(2) and clone(2), can be changed via
+PR_ISOL_CFG_GET/PR_ISOL_CFG_SET.
+
+
+At a high-level, task isolation is divided in two steps:
+
+1. Configuration.
+2. Activation.
+
+Section "Userspace support" describes how to use
+task isolation.
+
+In terms of the interface, the sequence of steps to activate
+task isolation are:
+
+1. Retrieve supported task isolation features (PR_ISOL_FEAT_GET).
+2. Configure task isolation features (PR_ISOL_CFG_GET/PR_ISOL_CFG_SET).
+3. Activate or deactivate task isolation features (PR_ISOL_ACTIVATE_GET/PR_ISOL_ACTIVATE_SET).
+
+This interface is based on ideas and code from the
+task isolation patchset from Alex Belits:
+https://lwn.net/Articles/816298/
+
+Note: if the need arises to configure an individual quiesce feature
+with its own extensible structure, please add ISOL_F_QUIESCE_ONE
+to PR_ISOL_CFG_GET/PR_ISOL_CFG_SET (ISOL_F_QUIESCE operates on
+multiple features per syscall currently).
+
+--------------------
+Feature description
+--------------------
+
+        - ``ISOL_F_QUIESCE``
+
+        This feature allows quiescing selected kernel activities on
+        return from system calls.
+
+---------------------
+Interface description
+---------------------
+
+**PR_ISOL_FEAT**:
+
+        Returns the supported features and feature
+        capabilities, as a bitmask::
+
+                prctl(PR_ISOL_FEAT, feat, arg3, arg4, arg5);
+
+        The 'feat' argument specifies whether to return
+        supported features (if zero), or feature capabilities
+        (if not zero). Possible values for 'feat' are:
+
+
+        - ``0``:
+               Return the bitmask of supported features, in the location
+               pointed  to  by  ``(int *)arg3``. The buffer should allow space
+               for 8 bytes.
+
+        - ``ISOL_F_QUIESCE``:
+
+               Return a structure containing which kernel
+               activities are supported for quiescing, in the location
+               pointed to by ``(int *)arg3``::
+
+                        struct task_isol_quiesce_extensions {
+                                __u64 flags;
+                                __u64 supported_quiesce_bits;
+                                __u64 pad[6];
+                        };
+
+               Where:
+
+               *flags*: Additional flags (should be zero).
+
+               *supported_quiesce_bits*: Bitmask indicating
+                which features are supported for quiescing.
+
+               *pad*: Additional space for future enhancements.
+
+
+        Features and its capabilities are defined at
+        include/uapi/linux/task_isolation.h.
+
+**PR_ISOL_CFG_GET**:
+
+        Retrieve task isolation configuration.
+        The general format is::
+
+                prctl(PR_ISOL_CFG_GET, what, arg3, arg4, arg5);
+
+        The 'what' argument specifies what to configure. Possible values are:
+
+        - ``I_CFG_FEAT``:
+
+                Return configuration of task isolation features. The 'arg3' argument specifies
+                whether to return configured features (if zero), or individual
+                feature configuration (if not zero), as follows.
+
+                - ``0``:
+
+                        Return the bitmask of configured features, in the location
+                        pointed  to  by  ``(int *)arg4``. The buffer should allow space
+                        for 8 bytes.
+
+                - ``ISOL_F_QUIESCE``:
+
+                        If arg4 is QUIESCE_CONTROL, return the control structure for
+                        quiescing of background kernel activities, in the location
+                        pointed to by ``(int *)arg5``::
+
+                         struct task_isol_quiesce_control {
+                                __u64 flags;
+                                __u64 quiesce_mask;
+                                __u64 quiesce_oneshot_mask;
+                                __u64 pad[5];
+                         };
+
+                        See PR_ISOL_CFG_SET description for meaning of fields.
+
+        - ``I_CFG_INHERIT``:
+
+                Retrieve inheritance configuration across fork/clone.
+
+                Return the structure which configures inheritance
+                across fork/clone, in the location pointed to
+                by ``(int *)arg4``::
+
+                        struct task_isol_inherit_control {
+                                __u8    inherit_mask;
+                                __u8    pad[7];
+                        };
+
+                See PR_ISOL_CFG_SET description for meaning of fields.
+
+**PR_ISOL_CFG_SET**:
+
+        Set task isolation configuration.
+        The general format is::
+
+                prctl(PR_ISOL_CFG_SET, what, arg3, arg4, arg5);
+
+        The 'what' argument specifies what to configure. Possible values are:
+
+        - ``I_CFG_FEAT``:
+
+                Set configuration of task isolation features. 'arg3' specifies
+                the feature. Possible values are:
+
+                - ``ISOL_F_QUIESCE``:
+
+                        If arg4 is QUIESCE_CONTROL, set the control structure
+                        for quiescing of background kernel activities, from
+                        the location pointed to by ``(int *)arg5``::
+
+                         struct task_isol_quiesce_control {
+                                __u64 flags;
+                                __u64 quiesce_mask;
+                                __u64 quiesce_oneshot_mask;
+                                __u64 pad[5];
+                         };
+
+                        Where:
+
+                        *flags*: Additional flags (should be zero).
+
+                        *quiesce_mask*: A bitmask containing which kernel
+                        activities to quiesce.
+
+                        *quiesce_oneshot_mask*: A bitmask indicating which kernel
+                        activities should behave in oneshot mode, that is, quiescing
+                        will happen on return from prctl(PR_ISOL_ACTIVATE_SET), but not
+                        on return of subsequent system calls. The corresponding bit(s)
+                        must also be set at quiesce_mask.
+
+                        *pad*: Additional space for future enhancements.
+
+                        For quiesce_mask (and quiesce_oneshot_mask), possible bit sets are:
+
+                        - ``ISOL_F_QUIESCE_VMSTATS``
+
+                        VM statistics are maintained in per-CPU counters to
+                        improve performance. When a CPU modifies a VM statistic,
+                        this modification is kept in the per-CPU counter.
+                        Certain activities require a global count, which
+                        involves requesting each CPU to flush its local counters
+                        to the global VM counters.
+
+                        This flush is implemented via a workqueue item, which
+                        might schedule a workqueue on isolated CPUs.
+
+                        To avoid this interruption, task isolation can be
+                        configured to, upon return from system calls, synchronize
+                        the per-CPU counters to global counters, thus avoiding
+                        the interruption.
+
+        - ``I_CFG_INHERIT``:
+                Set inheritance configuration when a new task
+                is created via fork and clone.
+
+                The ``(int *)arg4`` argument is a pointer to::
+
+                        struct task_isol_inherit_control {
+                                __u8    inherit_mask;
+                                __u8    pad[7];
+                        };
+
+                inherit_mask is a bitmask that specifies which part
+                of task isolation should be inherited:
+
+                - Bit ISOL_INHERIT_CONF: Inherit task isolation configuration.
+                  This is the state written via prctl(PR_ISOL_CFG_SET, ...).
+
+                - Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
+                  (requires ISOL_INHERIT_CONF to be set). The new task
+                  should behave, after fork/clone, in the same manner
+                  as the parent task after it executed:
+
+                        prctl(PR_ISOL_ACTIVATE_SET, &mask, ...);
+
+                Note: the inheritance propagates to all the descendants and not
+                just the immediate children, unless the inheritance is explicitly
+                reconfigured by some children.
+
+**PR_ISOL_ACTIVATE_GET**:
+
+        Retrieve task isolation activation state.
+
+        The general format is::
+
+                prctl(PR_ISOL_ACTIVATE_GET, pmask, arg3, arg4, arg5);
+
+        'pmask' specifies the location of a feature mask, where
+        the current active mask will be copied. See PR_ISOL_ACTIVATE_SET
+        for description of individual bits.
+
+
+**PR_ISOL_ACTIVATE_SET**:
+
+        Set task isolation activation state (activates/deactivates
+        task isolation).
+
+        The general format is::
+
+                prctl(PR_ISOL_ACTIVATE_SET, pmask, arg3, arg4, arg5);
+
+
+        The 'pmask' argument specifies the location of an 8 byte mask
+        containing which features should be activated. Features whose
+        bits are cleared will be deactivated. The possible
+        bits for this mask are:
+
+                - ``ISOL_F_QUIESCE``:
+
+                Activate quiescing of background kernel activities.
+                Quiescing happens on return to userspace from this
+                system call, and on return from subsequent
+                system calls (unless quiesce_oneshot_mask has been set at
+                PR_ISOL_CFG_SET time).
+
+        Quiescing can be adjusted (while active) by
+        prctl(PR_ISOL_ACTIVATE_SET, &new_mask, ...).
+
+
+==================
+Userspace support
+==================
+
+Task isolation is divided in two main steps: configuration and activation.
+
+Each step can be performed by an external tool or the latency sensitive
+application itself. util-linux contains the "chisol" tool for this
+purpose.
+
+This results in three combinations:
+
+1. Both configuration and activation performed by the
+latency sensitive application.
+Allows fine grained control of what task isolation
+features are enabled and when (see samples section below).
+
+2. Only activation can be performed by the latency sensitive app
+(and configuration performed by chisol).
+This allows the admin/user to control task isolation parameters,
+and applications have to be modified only once.
+
+3. Configuration and activation performed by an external tool.
+This allows unmodified applications to take advantage of
+task isolation. Activation is performed by the "-a" option
+of chisol.
+
+========
+Examples
+========
+
+The ``samples/task_isolation/`` directory contains 3 examples:
+
+* task_isol_userloop.c:
+
+        Example of program with a loop on userspace scenario.
+
+* task_isol_computation.c:
+
+        Example of program that enters task isolated mode,
+        performs an amount of computation, exits task
+        isolated mode, and writes the computation to disk.
+
+* task_isol_oneshot.c:
+
+        Example of program that enables one-shot
+        mode for quiescing, enters a processing loop, then upon an external
+        event performs a number of syscalls to handle that event.
+
+This is a snippet of code to activate task isolation if
+it has been previously configured (by chisol for example)::
+
+        #include <sys/prctl.h>
+        #include <linux/types.h>
+
+        #ifdef PR_ISOL_CFG_GET
+        unsigned long long fmask;
+
+        ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &fmask, 0);
+        if (ret != -1 && fmask != 0) {
+                ret = prctl(PR_ISOL_ACTIVATE_SET, &fmask, 0, 0, 0);
+                if (ret == -1) {
+                        perror("prctl PR_ISOL_ACTIVATE_SET");
+                        return ret;
+                }
+        }
+        #endif
+
Index: linux-2.6/samples/task_isolation/task_isol.c
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isol.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include <linux/prctl.h>
+#include <errno.h>
+#include "task_isol.h"
+
+#ifdef PR_ISOL_FEAT_GET
+int task_isol_setup(int oneshot)
+{
+	int ret;
+	int errnosv;
+	unsigned long long fmask;
+	struct task_isol_quiesce_extensions qext;
+	struct task_isol_quiesce_control qctrl;
+
+	/* Retrieve supported task isolation features */
+	ret = prctl(PR_ISOL_FEAT_GET, 0, &fmask, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_FEAT");
+		return ret;
+	}
+	printf("supported features bitmask: 0x%llx\n", fmask);
+
+	/* Retrieve supported ISOL_F_QUIESCE bits */
+	ret = prctl(PR_ISOL_FEAT_GET, ISOL_F_QUIESCE, &qext, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_FEAT (ISOL_F_QUIESCE)");
+		return ret;
+	}
+	printf("supported ISOL_F_QUIESCE bits: 0x%llx\n",
+		qext.supported_quiesce_bits);
+
+	fmask = 0;
+	ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &fmask, 0);
+	errnosv = errno;
+	if (ret != -1 && fmask != 0) {
+		printf("Task isolation parameters already configured!\n");
+		return ret;
+	}
+	if (ret == -1 && errnosv != ENODATA) {
+		perror("prctl PR_ISOL_GET");
+		return ret;
+	}
+	memset(&qctrl, 0, sizeof(struct task_isol_quiesce_control));
+	qctrl.quiesce_mask = ISOL_F_QUIESCE_VMSTATS;
+	if (oneshot)
+		qctrl.quiesce_oneshot_mask = ISOL_F_QUIESCE_VMSTATS;
+
+	ret = prctl(PR_ISOL_CFG_SET, I_CFG_FEAT, ISOL_F_QUIESCE,
+		    QUIESCE_CONTROL, &qctrl);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_CFG_SET");
+		return ret;
+	}
+	return ISOL_F_QUIESCE;
+}
+
+int task_isol_activate_set(unsigned long long mask)
+{
+	int ret;
+
+	ret = prctl(PR_ISOL_ACTIVATE_SET, &mask, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_ACTIVATE_SET");
+		return -1;
+	}
+
+	return 0;
+}
+
+#else
+
+int task_isol_setup(void)
+{
+	return 0;
+}
+
+int task_isol_activate_set(unsigned long long mask)
+{
+	return 0;
+}
+#endif
+
+
Index: linux-2.6/samples/task_isolation/task_isol.h
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isol.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TASK_ISOL_H
+#define __TASK_ISOL_H
+
+int task_isol_setup(int oneshot);
+
+int task_isol_activate_set(unsigned long long mask);
+
+#endif /* __TASK_ISOL_H */
Index: linux-2.6/samples/task_isolation/task_isol_userloop.c
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isol_userloop.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include <linux/prctl.h>
+#include "task_isol.h"
+
+int main(void)
+{
+	int ret;
+	void *buf = malloc(4096);
+	unsigned long mask;
+
+	memset(buf, 1, 4096);
+	ret = mlock(buf, 4096);
+	if (ret) {
+		perror("mlock");
+		return EXIT_FAILURE;
+	}
+
+	ret = task_isol_setup(0);
+	if (ret == -1)
+		return EXIT_FAILURE;
+
+	mask = ret;
+	/* enable quiescing on system call return, oneshot */
+	ret = task_isol_activate_set(mask);
+	if (ret)
+		return EXIT_FAILURE;
+
+#define NR_LOOPS 999999999
+#define NR_PRINT 100000000
+	/* busy loop */
+	while (ret < NR_LOOPS)  {
+		memset(buf, 0, 4096);
+		ret = ret+1;
+		if (!(ret % NR_PRINT))
+			printf("loops=%d of %d\n", ret, NR_LOOPS);
+	}
+
+
+	ret = task_isol_activate_set(mask & ~ISOL_F_QUIESCE);
+	if (ret)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
Index: linux-2.6/samples/Kconfig
===================================================================
--- linux-2.6.orig/samples/Kconfig
+++ linux-2.6/samples/Kconfig
@@ -250,6 +250,13 @@ config SAMPLE_CORESIGHT_SYSCFG
 	  This demonstrates how a user may create their own CoreSight
 	  configurations and easily load them into the system at runtime.
 
+config SAMPLE_TASK_ISOLATION
+	bool "task isolation sample"
+	depends on CC_CAN_LINK && HEADERS_INSTALL
+	help
+	  Build example userspace program to use prctl task isolation
+	  interface.
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
Index: linux-2.6/samples/Makefile
===================================================================
--- linux-2.6.orig/samples/Makefile
+++ linux-2.6/samples/Makefile
@@ -33,3 +33,4 @@ subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watc
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
+subdir-$(CONFIG_SAMPLE_TASK_ISOLATION)	+= task_isolation
Index: linux-2.6/samples/task_isolation/Makefile
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+userprogs-always-y += task_isol_userloop task_isol_computation task_isol_oneshot
+task_isol_userloop-objs := task_isol.o task_isol_userloop.o
+task_isol_computation-objs := task_isol.o task_isol_computation.o
+task_isol_oneshot-objs := task_isol.o task_isol_oneshot.o
+
+userccflags += -I usr/include
+
+
+#$(CC) $^ -o $@
Index: linux-2.6/samples/task_isolation/task_isol_computation.c
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isol_computation.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Example of task isolation prctl interface with a loop:
+ *
+ *	do {
+ *		enable quiescing of kernel activities
+ *		perform computation
+ *		disable quiescing of kernel activities
+ *		write computation results to disk
+ *	} while (condition);
+ *
+ */
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include <linux/prctl.h>
+#include "task_isol.h"
+
+int main(void)
+{
+	int ret, fd, write_loops;
+	void *buf = malloc(4096);
+	unsigned long mask;
+
+	fd = open("/tmp/comp_output.data", O_RDWR|O_CREAT);
+	if (fd == -1) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	memset(buf, 1, 4096);
+	ret = mlock(buf, 4096);
+	if (ret) {
+		perror("mlock");
+		return EXIT_FAILURE;
+	}
+
+	ret = task_isol_setup(0);
+	if (ret == -1)
+		return EXIT_FAILURE;
+
+	mask = ret;
+
+	write_loops = 0;
+	do {
+#define NR_LOOPS 999999999
+#define NR_PRINT 100000000
+		/* enable quiescing on system call return */
+		ret = task_isol_activate_set(mask);
+		if (ret)
+			return EXIT_FAILURE;
+
+		/* busy loop */
+		while (ret < NR_LOOPS)  {
+			memset(buf, 0xf, 4096);
+			ret = ret+1;
+			if (!(ret % NR_PRINT))
+				printf("wloop=%d loops=%d of %d\n", write_loops,
+					ret, NR_LOOPS);
+		}
+		/* disable quiescing on system call return */
+		ret = task_isol_activate_set(mask & ~ISOL_F_QUIESCE);
+		if (ret)
+			return EXIT_FAILURE;
+
+		/*
+		 * write computed data to disk, this would be
+		 * multiple writes on a real application, so
+		 * disabling quiescing is advantageous
+		 */
+		ret = write(fd, buf, 4096);
+		if (ret == -1) {
+			perror("write");
+			return EXIT_FAILURE;
+		}
+
+		write_loops += 1;
+	} while (write_loops < 5);
+
+
+	return EXIT_SUCCESS;
+}
+
Index: linux-2.6/samples/task_isolation/task_isol_oneshot.c
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isol_oneshot.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Example of task isolation prctl interface using
+ * oneshot mode for quiescing.
+ *
+ *
+ *      enable oneshot quiescing of kernel activities
+ *	do {
+ *		process data (no system calls)
+ *		if (event) {
+ *			process event with syscalls
+ *			enable oneshot quiescing of kernel activities
+ *		}
+ *	} while (!exit_condition);
+ *
+ */
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include <linux/prctl.h>
+#include "task_isol.h"
+
+int main(void)
+{
+	int ret, fd, cnt;
+	void *buf = malloc(4096);
+	unsigned long mask;
+
+	fd = open("/dev/zero", O_RDONLY);
+	if (fd == -1) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	memset(buf, 1, 4096);
+	ret = mlock(buf, 4096);
+	if (ret) {
+		perror("mlock");
+		return EXIT_FAILURE;
+	}
+
+	ret = task_isol_setup(1);
+	if (ret == -1)
+		return EXIT_FAILURE;
+
+	mask = ret;
+
+#define NR_LOOPS 999999999
+#define NR_PRINT 100000000
+
+	/* enable quiescing on system call return, oneshot */
+	ret = task_isol_activate_set(mask);
+	if (ret)
+		return EXIT_FAILURE;
+	/* busy loop */
+	cnt = 0;
+	while (cnt < NR_LOOPS)  {
+		memset(buf, 0xf, 4096);
+		cnt = cnt+1;
+		if (!(cnt % NR_PRINT)) {
+			int i, r;
+
+			/* this could be considered handling an external
+			 * event: with one-shot mode, system calls
+			 * after prctl(PR_SET_ACTIVATE) will not incur
+			 * the penalty of quiescing
+			 */
+			printf("loops=%d of %d\n", cnt, NR_LOOPS);
+			for (i = 0; i < 100; i++) {
+				r = read(fd, buf, 4096);
+				if (r == -1) {
+					perror("read");
+					return EXIT_FAILURE;
+				}
+			}
+
+			ret = munlock(buf, 4096);
+			if (ret) {
+				perror("munlock");
+				return EXIT_FAILURE;
+			}
+
+			ret = mlock(buf, 4096);
+			if (ret) {
+				perror("mlock");
+				return EXIT_FAILURE;
+			}
+
+			/* enable quiescing on system call return */
+			ret = task_isol_activate_set(mask);
+			if (ret)
+				return EXIT_FAILURE;
+		}
+	}
+
+	return EXIT_SUCCESS;
+}
+


