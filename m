Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB434E69EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353593AbiCXUpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353771AbiCXUpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:45:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229B1B0A77
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD96760FEF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA71C36AE5;
        Thu, 24 Mar 2022 20:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648154618;
        bh=agzHSmhKaTtxEz70aaAyERz16CAhhV+36cEDKb+rmq4=;
        h=Date:From:To:Cc:Subject:From;
        b=fn+QDdN5kXTE9UK9TqigX1TG3LrV1EHTgSnUbToAcqiSTZQatyStgjJmpDmoLMkQ1
         9jgYBD7EmrHOXP37R3tZnUs37Ht+o7lo/eATPuhLWubl3wvXMKXSBDDJqsMONwZFlR
         3EK3+5MgZ6c/dxgoZcU04DHMGhKrlRsJwrVtWhzVkZXkmpgbgnPYc2haKQwvEvN39l
         3TuRs+jxOUTgrE0gdV+wC116T6H6Vrge61MQBv4wZoFhX5RXLm6gNACn33bqbCd/L5
         rf1Ckph32pO1FpjU+rhiZFTfL8R7zJGJrhKmB8Wdx6n5hZUz5Z8eSN494yE8DkJ+HD
         kRt8fWD9ZWlnA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 362C640407; Thu, 24 Mar 2022 17:43:36 -0300 (-03)
Date:   Thu, 24 Mar 2022 17:43:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@suse.de>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] tools headers cpufeatures: Sync with the kernel sources
Message-ID: <YjzX+PknzGoKaGMX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I'm carrying this on the perf tools tree:

---

To pick the changes in:

  7c1ef59145f1c8bf ("x86/cpufeatures: Re-enable ENQCMD")

That causes only these 'perf bench' objects to rebuild:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses these perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
  diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h

Cc: Borislav Petkov <bp@suse.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/disabled-features.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 8f28fafa98b32e6f..1231d63f836d8138 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -56,8 +56,11 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
-/* Force disable because it's broken beyond repair */
-#define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
+#ifdef CONFIG_INTEL_IOMMU_SVM
+# define DISABLE_ENQCMD		0
+#else
+# define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
+#endif
 
 #ifdef CONFIG_X86_SGX
 # define DISABLE_SGX	0
-- 
2.35.1

