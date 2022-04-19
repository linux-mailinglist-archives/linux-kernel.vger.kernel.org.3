Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0122D50763D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355870AbiDSRKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355585AbiDSRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE11AB1CC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388028; x=1681924028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WpP+vv71UOEAq4C6Qpr453ktQWY8DDevCFkTA3RJgVU=;
  b=fePB4rDFZivFM9/rkG7ueYxW+td9U/pCvLN17C4OrY0QOJIzDqLE2PIT
   kU8HYvoTysjPJXtQeRT+un92FGsVXdFXrEBrSHNKODyPcj91uPjSVMJ/b
   V3XEJLbDBnVB1PGel0QHdV28lubivgRrp8KuRtPojMlYMjESwR/br87MR
   34VXCk1Ct1jtEAwoU6yODjXgfObhox12CGdwgg8LUSwZWO9BGCyd4eNZa
   k/lLkpa5BHJuDqU4t+opjcEq82tfiTHhVfZIvEqO/ul7JyIMtWAI3WRM9
   2ZBdA37BhY2+l4zU6AkHtbamMzG+6hY1F6zT6NSGbm2ehYFt0SPrJO35+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245710065"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245710065"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="647332107"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:07 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 20/44] x86/entry: Define arch_{save|restore}_auxiliary_pt_regs()
Date:   Tue, 19 Apr 2022 10:06:25 -0700
Message-Id: <20220419170649.1022246-21-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.35.1

