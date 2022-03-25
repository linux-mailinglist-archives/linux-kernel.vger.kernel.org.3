Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13554E7402
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbiCYNPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346155AbiCYNP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:15:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A53238BEB;
        Fri, 25 Mar 2022 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648214035; x=1679750035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dRmFfYYTeIjxBBGGtHWDoBRdcjE/yT3gWJgXD5nNxYo=;
  b=GuIvC4yE8sQ9raQOkyeDwBgWogOYC+IVe5iCM/pDMllXYMFiK2lp6LPw
   KL0ucMq66297u1XqwFcT/ALRa0DzSFjhexryk/fpaol5uR0XfMJw6qR5r
   OiBmwqNBeDBVI2DrJqAoj6ykqzMtl4u0xTOuja0aLGpb5dDBSkZREp51i
   xi+mmOL9fZFC6yz83wQMmvD8n+6zoDylqjogTbFSUi2EDQSX682O/H1xE
   lrCxiTw9p35/2kTO4zjySqkkybYKyBd8036sHo9MErnqRIQc+OhCrdakd
   cNklUB3soY2HYOzmBF9mf1AFrCw48ii8GxeJffid1WF9k5jKTwWPtg9LK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="239233554"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="239233554"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 06:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="602048561"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2022 06:13:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DE05A11E; Fri, 25 Mar 2022 15:13:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v1 1/1] Makefile.extrawarn: Turn off -Werror when extra warnings are enabled
Date:   Fri, 25 Mar 2022 15:13:48 +0200
Message-Id: <20220325131348.3995-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When `make W=1 ...` is executed the level 1 warnings become errors,
due to recent change in some of the defconfigs, and fail the build.
Since there are a lot of warnings on the level 1 are still present
in the defconfigs at least for x86, let disable -Werror in such case.

Fixes: b9080ba4a6ec ("x86/defconfig: Enable WERROR")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 scripts/Makefile.extrawarn | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 650d0b8ceec3..c81d74ef6c90 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -94,3 +94,10 @@ KBUILD_CFLAGS += $(call cc-option, -Wpacked-bitfield-compat)
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN3
 
 endif
+
+#
+# Turn off -Werror when extra warnings are enabled
+#
+ifneq ($(KBUILD_EXTRA_WARN),)
+	KBUILD_CFLAGS += -Wno-error
+endif
-- 
2.35.1

