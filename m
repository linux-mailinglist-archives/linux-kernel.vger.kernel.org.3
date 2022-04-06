Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569904F6B08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiDFUOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbiDFUNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:13:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8DC506EE;
        Wed,  6 Apr 2022 11:01:09 -0700 (PDT)
Date:   Wed, 06 Apr 2022 18:01:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649268067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IndriNrjjKue7jTMRIVbOa6aEXgiAJs1mmKTKQU5o2k=;
        b=n8LIvLG63fRvoYpG/xxua2e9y5DhIF/6fPG3gYpNwAP3J30WSQNKx0LECysc40M3oYfRzY
        yEG//fH5BZvVv5CoKBiBpkPnmSmOzBmVPBK8RHhtwCySoserHElFnHn5CWvB1/ZSLrAVr4
        qRE+voPF6nE/O8QTOLnAyCrhN3WQu0SmzscV8GcASLBlVVDDUclGR1FZLI0yO1fdaNQs+1
        SrvNBfLqJtCcdxabccSWCqR6ihf/PkwizDvdhZBRFHu8wSJ3El4byEKRBe5MJdRkpiNRSm
        xLmyZFG0ybEchdjl3DwVyByWcjHpqDut7ih453x4aol9yktuhNHtztU1NK8Tfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649268067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IndriNrjjKue7jTMRIVbOa6aEXgiAJs1mmKTKQU5o2k=;
        b=ZAxYhEcigm5Sz65+61+nzBTrSsIfhWcIqJ6/Dhi7BNkxlk1HGqTkHyT9Js9Y1Cco8pnktV
        svPF6NIKoT0lPhDA==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/configs: Add x86 debugging Kconfig fragment plus docs
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220331175728.299103A0@davehans-spike.ostc.intel.com>
References: <20220331175728.299103A0@davehans-spike.ostc.intel.com>
MIME-Version: 1.0
Message-ID: <164926806495.389.2039548073927168895.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     9b5a7f4a2a8dcda461f9c7a6671150f4a8a902e8
Gitweb:        https://git.kernel.org/tip/9b5a7f4a2a8dcda461f9c7a6671150f4a8a902e8
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Thu, 31 Mar 2022 10:57:28 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 19:56:29 +02:00

x86/configs: Add x86 debugging Kconfig fragment plus docs

The kernel has a wide variety of debugging options to help catch
and squash bugs.  However, new debugging is added all the time and
the existing options can be hard to find.

Add a Kconfig fragment with the debugging options which tip
maintainers expect to be used to test contributions.

This should make it easier for contributors to test their code and
find issues before submission.

  [ bp: Add to "make help" output, fix DEBUG_INFO selection as pointed
        out by Nathan Chancellor <nathan@kernel.org>. ]

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220331175728.299103A0@davehans-spike.ostc.intel.com
---
 Documentation/process/maintainer-tip.rst | 14 ++++++++++++++
 arch/x86/Makefile                        |  1 +
 kernel/configs/x86_debug.config          | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 kernel/configs/x86_debug.config

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index c74f4a8..572a328 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -437,6 +437,20 @@ in a private repository which allows interested people to easily pull the
 series for testing. The usual way to offer this is a git URL in the cover
 letter of the patch series.
 
+Testing
+^^^^^^^
+
+Code should be tested before submitting to the tip maintainers.  Anything
+other than minor changes should be built, booted and tested with
+comprehensive (and heavyweight) kernel debugging options enabled.
+
+These debugging options can be found in kernel/configs/x86_debug.config
+and can be added to an existing kernel config by running:
+
+	make x86_debug.config
+
+Some of these options are x86-specific and can be left out when testing
+on other architectures.
 
 Coding style notes
 ------------------
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 63d50f6..1abd7cc 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -313,5 +313,6 @@ define archhelp
   echo  ''
   echo  '  kvm_guest.config	- Enable Kconfig items for running this kernel as a KVM guest'
   echo  '  xen.config		- Enable Kconfig items for running this kernel as a Xen guest'
+  echo  '  x86_debug.config	- Enable tip tree debugging options for testing'
 
 endef
diff --git a/kernel/configs/x86_debug.config b/kernel/configs/x86_debug.config
new file mode 100644
index 0000000..dcd86f3
--- /dev/null
+++ b/kernel/configs/x86_debug.config
@@ -0,0 +1,18 @@
+CONFIG_X86_DEBUG_FPU=y
+CONFIG_LOCK_STAT=y
+CONFIG_DEBUG_VM=y
+CONFIG_DEBUG_VM_VMACACHE=y
+CONFIG_DEBUG_VM_RB=y
+CONFIG_DEBUG_SLAB=y
+CONFIG_DEBUG_KMEMLEAK=y
+CONFIG_DEBUG_PAGEALLOC=y
+CONFIG_SLUB_DEBUG_ON=y
+CONFIG_KMEMCHECK=y
+CONFIG_DEBUG_OBJECTS=y
+CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
+CONFIG_GCOV_KERNEL=y
+CONFIG_LOCKDEP=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_SCHEDSTATS=y
+CONFIG_VMLINUX_VALIDATION=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
