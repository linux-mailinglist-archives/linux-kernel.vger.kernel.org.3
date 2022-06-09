Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0B054550E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344651AbiFITfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344602AbiFITff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:35:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BD23B3ED
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654803334; x=1686339334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k+fIbB66CJnyjxes5EdlBMc7mAX5asOCRo8Kz2dxX8Y=;
  b=nH3QJWFr6wRQBmT1uNLsFAghsahEye8gN6jNndz6dhr5hXt98OPIbMG1
   onh9NwaBdmliNzFMLvxyKwc3FXhszAwGToOtFaGG+aeLHRHFEgE4Astws
   3zQyyXyDDDia04+8u8/EowtmvdE2uWfw9HpuF5+rKYx6/4B1+8LxgLRiz
   Y/+saZYD55VGC48rDt3cu2nPlghz9nBidudqwiKKn+L5N1HfEdGEeylEB
   oanDCr5fRUYhUPcC8MUD8TZYTre/gtzhJqlPYpzWqbvxIQCcjI7Ojajvi
   EaJ+Y0lvC1JUPVXoD9BoXPOCy57cNOQt1PdI5thF0fVsS4M5HrhDJIRHK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="266169677"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="266169677"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 12:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585766008"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2022 12:35:33 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>
Cc:     "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] x86/split_lock: Enable the split lock feature on Raptor Lake P
Date:   Thu,  9 Jun 2022 12:35:49 -0700
Message-Id: <20220609193549.2725612-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raptor Lake P supports the split lock detection feature. Add it to
the split_lock_cpu_ids[] array.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fd5dead8371c..8ea7c317abe4 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1290,6 +1290,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		1),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		1),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		1),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	1),
 	{}
 };
 
-- 
2.32.0

