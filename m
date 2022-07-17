Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FEB577658
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiGQNVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGQNVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:21:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5609515FC4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 06:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCCF2611CB
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7C8C3411E;
        Sun, 17 Jul 2022 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658064102;
        bh=as42x4+DrjYdzEuOO2wrut/FqprbQLpS1GUDvF1CTv4=;
        h=Date:From:To:Cc:Subject:From;
        b=AlRazowxOuAv4WfO7wtzoZjfZt3SbncnML6qlBphVT25xrANTnVUMxgUeEOqY8bq2
         GUxU4OWUOZLkgEVLzTHnnnuqC/u5donIzo31gmkNub3Nt0KOS1c1H3HemoImdkA6i4
         k6FIWgR9+mX+lxDZF/FNt3Evgw+/Kl8Wyq5UYA+A0/CsMm2YBbZ0XIGIBgiD5JRFuu
         7bplgy5cnhq1pdPqHI06F7PukemoF2tBOSL1E9NUZTHvoFfWFWbygUHvj0Utt86XFj
         2CKAibSZKpksglI+YP6MtlcJnkUilFujz7nd2ys7SiBNj3DoxdIerHWM0GAlNFM7wD
         YmFqTnJ94uPhg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 58B6D40374; Sun, 17 Jul 2022 10:21:39 -0300 (-03)
Date:   Sun, 17 Jul 2022 10:21:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tools headers cpufeatures: Sync with the kernel sources
Message-ID: <YtQM40VmiLTkPND2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used not to be copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes from:

  f43b9876e857c739 ("x86/retbleed: Add fine grained Kconfig knobs")
  a149180fbcf336e9 ("x86: Add magic AMD return-thunk")
  15e67227c49a5783 ("x86: Undo return-thunk damage")
  369ae6ffc41a3c11 ("x86/retpoline: Cleanup some #ifdefery")

This only causes these perf files to be rebuilt:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/x86/include/asm/disabled-features.h  | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 36369e76cc631ecb..33d2cd04d2544791 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -50,6 +50,25 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
+#ifdef CONFIG_RETPOLINE
+# define DISABLE_RETPOLINE	0
+#else
+# define DISABLE_RETPOLINE	((1 << (X86_FEATURE_RETPOLINE & 31)) | \
+				 (1 << (X86_FEATURE_RETPOLINE_LFENCE & 31)))
+#endif
+
+#ifdef CONFIG_RETHUNK
+# define DISABLE_RETHUNK	0
+#else
+# define DISABLE_RETHUNK	(1 << (X86_FEATURE_RETHUNK & 31))
+#endif
+
+#ifdef CONFIG_CPU_UNRET_ENTRY
+# define DISABLE_UNRET		0
+#else
+# define DISABLE_UNRET		(1 << (X86_FEATURE_UNRET & 31))
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 # define DISABLE_ENQCMD		0
 #else
@@ -82,7 +101,7 @@
 #define DISABLED_MASK8	(DISABLE_TDX_GUEST)
 #define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
-#define DISABLED_MASK11	0
+#define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET)
 #define DISABLED_MASK12	0
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
-- 
2.36.1

