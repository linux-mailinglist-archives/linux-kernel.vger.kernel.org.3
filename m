Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045094C01C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiBVS6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiBVS60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:58:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E876ADE2E9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645556280; x=1677092280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mnfE3Ie1oXRHjkG/pTiqBvf/XO47rcs2La5n3K55+Bg=;
  b=TvHcIwRQD0aJh9IfvQHN1kzKAoS8b3J3di+5sZS9XSRqmbb5lNPW1Hzt
   knvx5/UWK+aAwC7tB5PTyNfBf9cUAg8wjIk93Bxr25sLbkyuo+OGrqZsu
   ST2OxRHNNZJGDPNfRKmvYguwE+Re6CJxFMheOLq7o7CqbgK/TCyNpPUHv
   XWUdjyd5KL542MXazm6ugCM28JyXmPQ/FYih2+SSzkNdrG5PLQmmX7ZEK
   HZLDH9aONnavRKb2FXsfkGfYlDnL0hZqegPVfYdQGgZhKaSS2apN78VoE
   +XMJxI6b6ZMHOQqwLxjWYikXXSVSDNIkXKD9xWhzR5NL41UW84XEK8Hzc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="315013545"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="315013545"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:57:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="639012249"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 22 Feb 2022 10:57:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 42A5142; Tue, 22 Feb 2022 20:57:51 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: [PATCH 1/4] x86/hyperv: Add missing ARCH_HAS_CC_PLATFORM dependency
Date:   Tue, 22 Feb 2022 21:57:37 +0300
Message-Id: <20220222185740.26228-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
References: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86, cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) supposes to return
true for HyperV if isolation is supported. But it only does it if the
kernel is compiled with AMD_MEM_ENCRYPT enabled.

It happens due to missed ARCH_HAS_CC_PLATFORM dependency. Without
ARCH_HAS_CC_PLATFORM enabled, cc_platform_has() always returns false.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 0747a8f1fcee..424d3f0751dc 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -8,6 +8,7 @@ config HYPERV
 		|| (ARM64 && !CPU_BIG_ENDIAN))
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
+	select ARCH_HAS_CC_PLATFORM if x86
 	select VMAP_PFN
 	help
 	  Select this option to run Linux as a Hyper-V client operating
-- 
2.34.1

