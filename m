Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA8050F1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343750AbiDZHSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiDZHSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:18:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD35275239
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650957342; x=1682493342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ItNzdlfCk7S+sJYmdgTzS0c+88ZBqChdC+Q/hQ4C5/E=;
  b=bh+DSOsrgiog4m2fgMRa28JHkwqZ0v+i2ROuigS1vC/S5J5PgWBVOrGz
   zJGzN5gbBqgxdRBtbWLjTBgqY9i4IPId1odHAg63bY8p+XR9hUCrPjyiQ
   OWApkCU5ic9WliOnkXWNJKEu/ihSwipgkLIXFsVCgmyhLwTx0H4QFPDoT
   CXuWZwH5JxtZ/XjFPz4eBrUx42M7cSuHaBLvZ1KjXXzyEmCilveIkLm4s
   ZZxo52eUvmCVRUIKBWKUbt1oIcN2beENwe0X0GYE/LAdtZVOgDOIYEo91
   hS5k6atOcciUenFONqbPxiBCveuxoZ3fQiSjjnyLLsmxMsbKzgnyGYk0K
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="328422424"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="328422424"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:15:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="678274663"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by orsmga004.jf.intel.com with ESMTP; 26 Apr 2022 00:15:23 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Denys Vlasenko <dvlasenk@redhat.com>, lkp@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3] x86, vmlinux.lds: Add debug option to force all data sections aligned
Date:   Tue, 26 Apr 2022 15:15:23 +0800
Message-Id: <20220426071523.71923-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0Day has reported many strange performance changes (regression or
improvement), in which there was no obvious relation between the culprit
commit and the benchmark at the first look, and it causes people to doubt
the test itself is wrong.

Upon further check, many of these cases are caused by the change to the
alignment of kernel text or data, as whole text/data of kernel are linked
together compactly, change in one domain can affect alignments of other
domains linked after it.

To help quickly identifying if the strange performance change is caused
by _data_ alignment, add a debug option to force the data sections from
all .o files aligned on PAGE_SIZE, so that change in one domain won't
affect other modules' data alignment.

We have used this option to check some strange kernel changes [1][2][3],
and those performance changes were gone after enabling it, which proved
they are data alignment related. Besides these publicly reported cases,
recently there are other similar cases found by 0Day, and this option
has been actively used by 0Day for analyzing strange performance changes,
and filter some from reporting out.

With the debug option on, the vmlinux is around 0.73% larger:

$ls -l vmlinux*
  805891208 Apr 24 19:31 vmlinux.data-4k-align
  799599752 Apr 24 19:28 vmlinux.raw

$size vmlinux*
  text    data     bss     dec     hex filename
  17849671        22654886        4702208 45206765        2b1cced vmlinux.data-4k-align
  17849671        14784294        6275072 38909037        251b46d vmlinux.raw

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
  
  sicne v2
    * correct some typos about THRED_SIZE/PAGE_SIZE, as pointed out
      by Peter Zijlstra
    
  since v1
    * reduce the alignment from THREAD_SIZE to PAGE_SIZE
    * refine the commit log with size change data, and code comments

  since RFC (https://lore.kernel.org/lkml/1627456900-42743-1-git-send-email-feng.tang@intel.com/)
    * rebase against 5.17-rc1
    * modify the changelog adding more recent info

 arch/x86/Kconfig.debug        | 13 +++++++++++++
 arch/x86/kernel/vmlinux.lds.S | 12 +++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index d3a6f74a94bd..d8edf546f372 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -225,6 +225,19 @@ config PUNIT_ATOM_DEBUG
 	  The current power state can be read from
 	  /sys/kernel/debug/punit_atom/dev_power_state
 
+config DEBUG_FORCE_DATA_SECTION_ALIGNED
+	bool "Force all data sections to be PAGE_SIZE aligned"
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
index 7fda7f27e762..0919872602f1 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -155,7 +155,17 @@ SECTIONS
 	X86_ALIGN_RODATA_END
 
 	/* Data */
-	.data : AT(ADDR(.data) - LOAD_OFFSET) {
+	.data : AT(ADDR(.data) - LOAD_OFFSET)
+#ifdef CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED
+	/*
+	 * In theory, THREAD_SIZE as the biggest alignment of below sections
+	 * should be picked, but since upper 'X86_ALIGN_RODATA_END' can
+	 * guarantee the alignment of 'INIT_TASK_DATA', PAGE_SIZE is picked
+	 * instead to reduce size of kernel binary
+	 */
+	SUBALIGN(PAGE_SIZE)
+#endif
+	{
 		/* Start of data section */
 		_sdata = .;
 
-- 
2.27.0

