Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5FC4D501D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbiCJRVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiCJRVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:21:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00221965E9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932834; x=1678468834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7iJMoT3l/imb1JMUcZ/zix886+gdS+rNaiSrvLlCA98=;
  b=YeEuhcid6c3Yks97dJoabTmDZp1KoWRkt99hha7EMQ+zYWltutRT46uX
   zCbsgH5UwuJbu4nifbIUnE+bX5dCnXxa+9Fs91eHy4kaCjUryokHX+3xm
   XkMqrcTDZFu06LJgxLDD9Z3/5pqvd5OkTRrx7jFba/3PU1qwZq+YxkFJO
   Xry92rMsFpBX2o2VU/KWJZHgKATCW29R5NkObnr+E5wHpsNLZVStjDYtv
   CmFQbRPIxF+tEoto4UE2jBiICQPNUlWXpPKqD//bwMHFPj0HZhsSJF1le
   Mcv9HYmTg+SP6USgESXRhA4T9byIksIWd3IiiD34nRvm6icTHtpGp8xi7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341741130"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="341741130"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="510983766"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:33 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 03/45] x86/pkeys: Clarify PKRU_AD_KEY macro
Date:   Thu, 10 Mar 2022 09:19:37 -0800
Message-Id: <20220310172019.850939-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

