Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32D250D1AC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiDXM2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 08:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDXM2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 08:28:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5FE2B7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 05:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650803138; x=1682339138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UmElUJ+BKm1YaATX1Kmus4FcQdsEU/nldWIYNdXBHFQ=;
  b=dWrIdKKw8ICiP8fgfLK/WPva5UQIOaZDzHSPA3HXpXoPHXjVF9YLeDoU
   URHNjydwRkmeVnzuyWNtJ8+jbH/bU5Lt0odUUF06vD+HlFesl0PaDqzws
   utiLFwFBx6HYn1Ou/dMeBEa275AZG+JMfIOOvllUG1ayLMYqk/9wt3/vi
   6/fT4oGWHbgi9AeEt8qO312vtjRqmKmaavzdwx4Nj/IQ/EfMrR4TgaBeN
   VRg0F+gK9njuj68lr683LR4nb/hIk2pM0PgN1O+OGi5nrQBNiV9K3MQhy
   lPvKtEQm2qJpNdhWVx2ifGzTx+FkJVYHieB/EjmiMLcmQXuwVf09xjBgO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="263886909"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="263886909"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 05:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="659759076"
Received: from shbuild999.sh.intel.com ([10.239.146.138])
  by fmsmga002.fm.intel.com with ESMTP; 24 Apr 2022 05:25:34 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2] x86, vmlinux.lds: Add debug option to force all data sections aligned
Date:   Sun, 24 Apr 2022 20:25:33 +0800
Message-Id: <20220424122533.27590-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
has been actively used by 0Day for analyzing strange performance changes,
and filter some from reporting out.

With the debug option on, the vmlinux is around 0.73% larger:

#ls -l vmlinux*
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
index 7fda7f27e762..6add703de45f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -155,7 +155,17 @@ SECTIONS
 	X86_ALIGN_RODATA_END

 	/* Data */
-	.data : AT(ADDR(.data) - LOAD_OFFSET) {
+	.data : AT(ADDR(.data) - LOAD_OFFSET)
+#ifdef CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED
+	/*
+	 * In theroy, THREAD_SIZE as the biggest alignment of below sections
+	 * should be picked, but since upper 'X86_ALIGN_RODATA_END' can
+	 * ganrantees the alignment of 'INIT_TASK_DATA', PAGE_SIZE is picked
+	 * instead to reduce size of kernel binary
+	 */
+	SUBALIGN(PAGE_SIZE)
+#endif
+	{
 		/* Start of data section */
 		_sdata = .;

--
2.27.0

