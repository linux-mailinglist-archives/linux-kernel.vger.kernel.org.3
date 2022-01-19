Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40484493B77
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350928AbiASNwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:52:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:59410 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235698AbiASNwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642600330; x=1674136330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V6xj/70rR9995gOWyZ2fhDWt5YCJUunhJStJfwvw0ds=;
  b=Qr82z7QNjzR3qw3ritHdY4J04BfnBHWNhuIOzIdVxZmeonYFDNAj164X
   BQpfpTTgBFz0DxuUnHqYksUXP/NArafEcdN5Kk+6TUPPiwpYEY1pRHIVP
   gEoK7vvZ5LpGbOy+murd+TwbXOBVUNIdvw94w6Br7pbBxMDMd32WFwWAP
   fJKSfN1PPQJYTcI3Eohip+vXKeN+voOaqLzTfel2PEnfVax70Cf+l018K
   /++acZg5REwaEXC8VA6Xi1GcScDf9UWa/jLhgQZ9tModuCxQxK0eiY6RD
   tpfXH1BWDwjYhG328HwlUnbThszOHYy582jt1bXzw3QWU5UPf2CudRSct
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="331419653"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="331419653"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 05:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="477379673"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2022 05:52:07 -0800
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH] Makefile: Fix build with scan-build
Date:   Wed, 19 Jan 2022 14:51:47 +0100
Message-Id: <20220119135147.1859982-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building kernel with scan-build for analysis:
$ scan-build make defconfig
$ scan-build make menuconfig # disable RETPOLINE
$ scan-build make -j16 bindeb-pkg
since commit 7d73c3e9c514 ("Makefile: remove stale cc-option checks")
it fails with:
  CC      scripts/mod/empty.o
could not find clang line
make[4]: *** [scripts/Makefile.build:287: scripts/mod/empty.o] Error 1

Seems like changes to how -fconserve-stack support was detected broke
build with scan-build. Revert part of mentioned commit which changed
that.

Fixes: 7d73c3e9c514 ("Makefile: remove stale cc-option checks")
CC: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 765115c99655..1174ccd182f5 100644
--- a/Makefile
+++ b/Makefile
@@ -991,9 +991,7 @@ KBUILD_CFLAGS	+= -fno-strict-overflow
 KBUILD_CFLAGS  += -fno-stack-check
 
 # conserve stack if available
-ifdef CONFIG_CC_IS_GCC
-KBUILD_CFLAGS   += -fconserve-stack
-endif
+KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
 
 # Prohibit date/time macros, which would make the build non-deterministic
 KBUILD_CFLAGS   += -Werror=date-time
-- 
2.25.1

