Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC756507614
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355562AbiDSRJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355332AbiDSRJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45455EA5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388013; x=1681924013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7iJMoT3l/imb1JMUcZ/zix886+gdS+rNaiSrvLlCA98=;
  b=WcJSc6Uv8hwyoFDeHe3cpakktDhSLWIobFotX3NLVc+9dRTNFy3AVwMU
   MygP48zpoMDorrUtPpNUX4y3npGT160xdxYfJDMY0sgCdnul3tf/mLfdi
   elXS01RSTi7uPGzCjkZXGPziUirGDVQ6xkvbBl3AaksZcGRaUiCIjaeYr
   gsmPYW0Jl8sv5SQfIV03QRKC8zYiSFnWoI8mEJBOazE3kuMj5c0ooffpj
   t0d+7quoUF7i8pOGpZlGt+fIzL7l2qtsX+ciX/FSiDKn7NmqAQuC9Z8eN
   x+/fOkJ8/NUUGe7hnrUNcLjXuwXPFtkR/mtvn3TiL6x9Mv2NLsngqy1dM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="262676976"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="262676976"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="529397120"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:52 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 02/44] x86/pkeys: Clarify PKRU_AD_KEY macro
Date:   Tue, 19 Apr 2022 10:06:07 -0700
Message-Id: <20220419170649.1022246-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

When changing the PKRU_AD_KEY macro to be used for PKS the name came
into question.[1]

The intent of PKRU_AD_KEY is to set an initial value for the PKRU
register but that is just a mask value.

Clarify this by changing the name to PKRU_AD_MASK().

NOTE the checkpatch errors are ignored for the init_pkru_value to align
the values in the code.

[1] https://lore.kernel.org/lkml/eff862e2-bfaa-9e12-42b5-a12467d72a22@intel.com/

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	New Patch
---
 arch/x86/mm/pkeys.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index e44e938885b7..7418c367e328 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -110,7 +110,7 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey
 	return vma_pkey(vma);
 }
 
-#define PKRU_AD_KEY(pkey)	(PKRU_AD_BIT << ((pkey) * PKRU_BITS_PER_PKEY))
+#define PKRU_AD_MASK(pkey)	(PKRU_AD_BIT << ((pkey) * PKRU_BITS_PER_PKEY))
 
 /*
  * Make the default PKRU value (at execve() time) as restrictive
@@ -118,11 +118,14 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey
  * in the process's lifetime will not accidentally get access
  * to data which is pkey-protected later on.
  */
-u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
-		      PKRU_AD_KEY( 4) | PKRU_AD_KEY( 5) | PKRU_AD_KEY( 6) |
-		      PKRU_AD_KEY( 7) | PKRU_AD_KEY( 8) | PKRU_AD_KEY( 9) |
-		      PKRU_AD_KEY(10) | PKRU_AD_KEY(11) | PKRU_AD_KEY(12) |
-		      PKRU_AD_KEY(13) | PKRU_AD_KEY(14) | PKRU_AD_KEY(15);
+u32 init_pkru_value = PKRU_AD_MASK( 1) | PKRU_AD_MASK( 2) |
+		      PKRU_AD_MASK( 3) | PKRU_AD_MASK( 4) |
+		      PKRU_AD_MASK( 5) | PKRU_AD_MASK( 6) |
+		      PKRU_AD_MASK( 7) | PKRU_AD_MASK( 8) |
+		      PKRU_AD_MASK( 9) | PKRU_AD_MASK(10) |
+		      PKRU_AD_MASK(11) | PKRU_AD_MASK(12) |
+		      PKRU_AD_MASK(13) | PKRU_AD_MASK(14) |
+		      PKRU_AD_MASK(15);
 
 static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
-- 
2.35.1

