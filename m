Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B0D5A53EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiH2S0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiH2S0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:26:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649C9659C7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661797563; x=1693333563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jwZwdHGBL0zKpeLfz3GxH+9XeciMnMQGoicnw+r09tI=;
  b=dIpyGe0b+Lb57rOLuuck4ae8Mf/wnWfF4FN2RDXJEGXNmirWSI2J5Cna
   tAY7aJgMJ6w+aSZl3VreXQ3B9hXmiM5JZwq9JuDoEzdpFo2kLzUtmsOlP
   air30dnuJedjvvHcbkrHDmozRomrGCi5RcGPQn8lBGuSV2hnZiar7urmo
   bQAasUuYYtZGcR3jkklifsMqK8pBYPCr0OK8GbE6ER/z1cUVcxniB0AGM
   bFlQiWFcVvK6cRnteu5yvEA9MsJY9G7c/F8xhji6xXl+Y/xvmBWaxedK5
   eGNMNMaTrddyPeQA25zoYqs6zPJLYcjFri5AZ2e5ADbXeq2i7FdhkizwF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="296244762"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="296244762"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 11:26:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="672485557"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 11:26:02 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Ashok Raj" <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/microcode/intel: Drop wbinvd(), no longer required
Date:   Mon, 29 Aug 2022 18:25:57 +0000
Message-Id: <20220829182557.729300-1-ashok.raj@intel.com>
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

Some older processors had a bad interaction when updating microcode if the
caches were dirty causing machine checks. The wbinvd() was added to
mitigate that before doing microcode updates. Now that Linux checks for the
minimum version before performing an update, those old microcode versions
can't be loaded.  Remove calls to wbinvd().

Depends on Link below:

Link: https://lore.kernel.org/lkml/20220829180436.716672-1-ashok.raj@intel.com/T/#u
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 332ba19e0147..ae3c7ed15e79 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -536,12 +536,6 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 		return UCODE_OK;
 	}
 
-	/*
-	 * Writeback and invalidate caches before updating microcode to avoid
-	 * internal issues depending on what the microcode is updating.
-	 */
-	native_wbinvd();
-
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -758,12 +752,6 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		goto out;
 	}
 
-	/*
-	 * Writeback and invalidate caches before updating microcode to avoid
-	 * internal issues depending on what the microcode is updating.
-	 */
-	native_wbinvd();
-
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
-- 
2.32.0

