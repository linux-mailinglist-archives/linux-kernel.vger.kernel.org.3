Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2489A4CB89B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiCCIVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiCCIVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:21:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A6B171857;
        Thu,  3 Mar 2022 00:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646295652; x=1677831652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sk6+O6+y+LcuLAi9FL2+v3ef2pvnDvKpS+B2HESK5P4=;
  b=NNpa00Mt2Bqd9ff1xrzUpPxrJG0H0P0osYrX/z/paXC0B+pcayFEE1Tr
   CbdqWKLG27mD8z2+MVLl0CRxC0KfeCnXpCYY32vb6GjIwi1N1D6XV/tig
   lu+kv8QPh9+3jHrEFPh/iimCf1VsduNxXaxg+ZcBnNshC9EdeZzyM1tpY
   Fvg0wvlN3L/kpmhH2B73vBMJa4db/dQwvA/YkDyfmxqnITghm3KmzT4XA
   G3p8vDlwKpi5LuE9l03ecQIz578biG9QT1XWRhwHBkHo4zvn4hSFHgljM
   KQr5NA4zF3F24hHf9+vL7LzOYj0azZ4dD7nqlHgH9tWd73KiGVDvBlnQH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253802431"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="253802431"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 00:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="535732673"
Received: from shbuild999.sh.intel.com ([10.239.146.189])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2022 00:20:49 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH] lib/Kconfig.debug: add ARCH dependency for FUNCTION_ALIGN option
Date:   Thu,  3 Mar 2022 16:20:48 +0800
Message-Id: <20220303082048.16558-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0Day robots reported there is compiling issue for 'csky' ARCH
when CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED is enabled [1]:

"
All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:2277: Error: pcrel offset for branch to .LS000B too far (0x3c)
"

Which has been discussed in [2]. And as there is no solution for csky
yet, add some dependency for this config to limit it to several ARCHs
which have no compiling issue so far.

[1]. https://lore.kernel.org/lkml/202202271612.W32UJAj2-lkp@intel.com/
[2]. https://www.spinics.net/lists/linux-kbuild/msg30298.html

Reported-by: kernel test robot <lkp@intel.com>
Cc: Guo Ren <guoren@kernel.org>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d6b5c94df099..a270a64e4429 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -401,8 +401,8 @@ config SECTION_MISMATCH_WARN_ONLY
 	  If unsure, say Y.
 
 config DEBUG_FORCE_FUNCTION_ALIGN_64B
-	bool "Force all function address 64B aligned" if EXPERT
-	depends on PPC || ARM || X86
+	bool "Force all function address 64B aligned"
+	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC)
 	help
 	  There are cases that a commit from one domain changes the function
 	  address alignment of other domains, and cause magic performance
-- 
2.27.0

