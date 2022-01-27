Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A3549E96D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245000AbiA0R4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:19413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244847AbiA0RzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306125; x=1674842125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3l7R2+hjC6dyevgRc9pgdsZzcbxeEl2tX9Je9seBHP0=;
  b=OjJk6Z103+zCRdGAJyTS1O3t6DxE2mhG6n+PtRc7DY8NuTqQ5ZCxByx9
   oZhh8ckra1z6qODca4IUqJVh7Z7tnnBipRFU1+7wjMl3PuOlo3I9xmjLL
   tV25viKz03V+wIKCyyrKUZCxSr1Kf19b0vEEDnXtl90g95x+clofK299U
   FZocbDsUOXAyLtAvVE8Pyc0RRaDKzOjHMnObGjyqEitiAdWq/pq3Cku+l
   cCF6hKCdFPGYrjEG8KeiKAyPw/lFQzs76tH2uzhu/+u5uDRp4KXLI+F5B
   oat2DGWYONJcyP+MTgKluz8TQdfF1On69B5DwUn9scdG9k9sG616B0xkm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302437"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302437"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796134"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:11 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 24/44] x86/entry: Define arch_{save|restore}_auxiliary_pt_regs()
Date:   Thu, 27 Jan 2022 09:54:45 -0800
Message-Id: <20220127175505.851391-25-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The x86 architecture supports the new auxiliary pt_regs space if
ARCH_HAS_PTREGS_AUXILIARY is enabled.

Define the callbacks within the x86 code required by the core entry code
when this support is enabled.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	New patch
---
 arch/x86/include/asm/entry-common.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 43184640b579..5fa5dd2d539c 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -95,4 +95,16 @@ static __always_inline void arch_exit_to_user_mode(void)
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
+#ifdef CONFIG_ARCH_HAS_PTREGS_AUXILIARY
+
+static inline void arch_save_aux_pt_regs(struct pt_regs *regs)
+{
+}
+
+static inline void arch_restore_aux_pt_regs(struct pt_regs *regs)
+{
+}
+
+#endif
+
 #endif
-- 
2.31.1

