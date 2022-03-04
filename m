Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D906D4CDF92
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiCDVDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiCDVDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:03:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4D46D4C3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646427778; x=1677963778;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=84rzB7EGCaXOZL1cBO3nEdZINVTxlpedFJz4fEGxUic=;
  b=HGW00jORUgLSWp8CiOzpAhHiHcKA/4a2HCXJzSuz/PwN8wlBt9eK9pfW
   IlzhKomc5SoQJQLlhRHgBg5anqx33N/p9CIalN/Os72ds+NWHxvkk1wnH
   XbIOov/kd7O2yDw/rwwKhklPFOIuTX5hJjElcjbNL1B9tSvDQZ9NZAzN3
   GqMYuxBK+YqyDuDSKYLyezgkD5lgHSHeclnENu3DqmLVAeT7r2cN9YXq/
   c8bSxdR294uzmcZaQkEB/C/H5NBYAK54vq3U2LPMIJOP6NDd11Qo9TZ2C
   aIcbyvxZslk5ldjksDVmWBDCbV6F2aT0Ke0q4rb3NHBHEBekQng0ccxHl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="340493361"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="340493361"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 13:02:58 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="810883039"
Received: from fushengl-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.64.239])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 13:02:58 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/pkeys: Remove __arch_set_user_pkey_access() declaration
Date:   Fri,  4 Mar 2022 13:02:48 -0800
Message-Id: <20220304210248.3490549-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In the x86 code __arch_set_user_pkey_access() is not used and is not
defined.

Remove the dead declaration.

To: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/include/asm/pkeys.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 1d5f14aff5f6..5292e6dfe2a7 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -41,9 +41,6 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 	return __arch_override_mprotect_pkey(vma, prot, pkey);
 }
 
-extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
-
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | VM_PKEY_BIT3)
 
 #define mm_pkey_allocation_map(mm)	(mm->context.pkey_allocation_map)
@@ -120,8 +117,6 @@ int mm_pkey_free(struct mm_struct *mm, int pkey)
 
 extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
-extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
 
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
-- 
2.35.1

