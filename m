Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BE14B82EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiBPI2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:28:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBPI2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:28:17 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079D4258448
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645000086; x=1676536086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2+LrmiUtF0kaXsTeDT1fv1ETxMW8Mf8QVAvn6K6ovPw=;
  b=eK54omft6UfiNYUfG/2Jf4H6GgCLEnoHG0ICcYuY/jZNyyp4gh5noctO
   uy9+vRyMN3iYJ8F57612BlyKv1/JS3aq1bTp2F9wjg6bImFrNcvU6RFcY
   sWJI6gC9/Gzpwvo1cGLDvrlXz04XFqggNUWlNOkRWa4jGa1YxjLKbnOd9
   h5Lxx5+SeBlTqE3QtIWZ58AXzbuPkx2dzNpP5JpAXX4dPM35z/Bq+b8vu
   lbcMRZ9J1EJ+1Fdiqf8CMgUpxApF4GeS7ML/pMsFmFW+qzfTeNq6isAxd
   3UwGWeL6EMIoTEGALQxmAT7nfwLtc/p2xT07A7Lfqp66lUDepsOnwbd2j
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="234090491"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="234090491"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 00:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="571177621"
Received: from shbuild999.sh.intel.com ([10.239.146.189])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2022 00:28:02 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH] x86, vmlinux.lds: Add debug option to force all data sections aligned
Date:   Wed, 16 Feb 2022 16:28:02 +0800
Message-Id: <20220216082802.96054-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0day has reported many strange performance changes (regression or
improvement), in which there was no obvious relation between the culprit
commit and the benchmark at the first look, and it causes people to doubt
the test itself is wrong.

Upon further check, many of these cases are caused by the change to the
alignment of kernel text or data, as whole text/data of kernel are linked
together, change in one domain can affect alignments of other domains.

To help quickly identifying if the strange performance change is caused
by _data_ alignment, add a debug option to force the data sections from
all .o files aligned on THREAD_SIZE, so that change in one domain won't
affect other modules' data alignment.

We have used this option to check some strange kernel changes [1][2][3],
and those performance changes were gone after enabling it, which proved
they are data alignment related. Besides these publicly reported cases,
recently there are other similar cases found by 0day, and this option
has been actively used by 0Day for analyzing strange performance changes.

Similarly, there is another kernel debug option to check text alignment
related performance changes: CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B,
which forces all function's start address to be 64 bytes alinged.

This option depends on CONFIG_DYNAMIC_DEBUG==n, as '__dyndbg' subsection
of .data has a hard requirement of ALIGN(8), shown in the 'vmlinux.lds':

"
. = ALIGN(8); __start___dyndbg = .; KEEP(*(__dyndbg)) __stop___dyndbg = .;
"

It contains all pointers to 'struct _ddebug', and dynamic_debug_init()
will "pointer++" to loop accessing these pointers, which will be broken
with this option enabled.

[1]. https://lore.kernel.org/lkml/20200205123216.GO12867@shao2-debian/
[2]. https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/
[3]. https://lore.kernel.org/lkml/20201112140625.GA21612@xsang-OptiPlex-9020/

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:
  
  since RFC (https://lore.kernel.org/lkml/1627456900-42743-1-git-send-email-feng.tang@intel.com/)
  * rebase against 5.17-rc1
  * modify the changelog adding more recent info

 arch/x86/Kconfig.debug        | 13 +++++++++++++
 arch/x86/kernel/vmlinux.lds.S |  7 ++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index d3a6f74a94bd..7b8cfe9717f2 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -225,6 +225,19 @@ config PUNIT_ATOM_DEBUG
 	  The current power state can be read from
 	  /sys/kernel/debug/punit_atom/dev_power_state
 
+config DEBUG_FORCE_DATA_SECTION_ALIGNED
+	bool "Force all data sections to be THREAD_SIZE aligned"
+	depends on EXPERT && !DYNAMIC_DEBUG
+	help
+	  There are cases that a commit from one kernel domain changes
+	  data sections' alignment of other domains, as they are all
+	  linked together compactly, and cause magic performance bump
+	  (regression or improvement), which is hard to debug. Enable
+	  this option will help to verify if the bump is caused by
+	  data alignment changes.
+
+	  It is mainly for debug and performance tuning use.
+
 choice
 	prompt "Choose kernel unwinder"
 	default UNWINDER_ORC if X86_64
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 27f830345b6f..79a631476513 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -155,7 +155,12 @@ SECTIONS
 	X86_ALIGN_RODATA_END
 
 	/* Data */
-	.data : AT(ADDR(.data) - LOAD_OFFSET) {
+	.data : AT(ADDR(.data) - LOAD_OFFSET)
+#ifdef CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED
+	/* Use the biggest alignment of below sections */
+	SUBALIGN(THREAD_SIZE)
+#endif
+	{
 		/* Start of data section */
 		_sdata = .;
 
-- 
2.27.0

