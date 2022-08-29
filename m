Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA555A53CA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiH2SKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiH2SKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:10:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBB57392D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661796641; x=1693332641;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w3FQog0TbfF6FSRjBPM0YwFMbUuW2xTLlJneCsIaVC0=;
  b=d2D+MfBbMiT6uMXXiUJE9l82pWBzQRkfQjzZrBiyo9SI5Z77aNo1c7Ot
   UQnE4ok6vFR1BNoq45YPnVgXtKIrPEjupcwG8uWvU7DPvJyX4/2QQlgtO
   wALnQZ2zjwMPivTwe2ff+nfDduVqgpHYNnuQA5PgxLuFEXWy3cyx+IUg5
   ojXuSdCdopjtrF4jSmVhPg3genP7ulm+Jf1soIAYPznCCqsk/rADmZnSn
   ZSWBrO/k8GJVWWiiP1WB/xfGlg4ksF9zm48vt1w+bewytITWPukudy00/
   LyXOsmEj+Gxrz47FGKkPzWoemi347U0NJcLS6OHjqzlG5ehwGNC/7hKZn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="296241565"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="296241565"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 11:10:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="562325638"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 11:10:36 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/microcode: Print previous version of microcode after reload
Date:   Mon, 29 Aug 2022 18:10:30 +0000
Message-Id: <20220829181030.722891-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be useful to print both old and new versions of microcode after a
reload is complete.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index ad57e0e4d674..6a41cee242f6 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -491,7 +491,7 @@ static int __reload_late(void *info)
  */
 static int microcode_reload_late(void)
 {
-	int ret;
+	int old = boot_cpu_data.microcode, ret;
 
 	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
 	pr_err("You should switch to early loading, if possible.\n");
@@ -503,7 +503,8 @@ static int microcode_reload_late(void)
 	if (ret == 0)
 		microcode_check();
 
-	pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
+	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
+		old, boot_cpu_data.microcode);
 
 	return ret;
 }
-- 
2.32.0

