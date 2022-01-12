Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42F848CDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiALVVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:21:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:1423 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbiALVUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642022441; x=1673558441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IzmmcNwPyrly7VAToU85hx2yPsdSXI9+7O903lBKZz8=;
  b=ApRkySPB5AzOVipKEHAksVvhK+SMn9GZkznKFAkSdjD07b47jUmzchAD
   pWgzsxgrgpo9v1ObfCF6tVfaLuR+0tiLiU9Gubua2v4iJ3fxCy6CP6tXd
   tTfgzwlsF7DwXebNzXRN8KQwTOPS8nTYfv0K/bja0m44gN9VLjgCsq1RK
   hYTxjv4RwbESHnyWZF4aq86/psb2xqEO2xRapGOwL2She277xvEMN/cfb
   ZZLBhisDqmWbyOYSh8EJQCRAPOAZHjH9hiGikFVA06X3dSpvDn8RcCRSY
   nTV9WYCfpZNKaX5wtgo6HFNoOCsO6ijsTIET160r+uHoOo5a1deSfRuls
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243810789"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="243810789"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 13:20:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529378246"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2022 13:20:39 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        herbert@gondor.apana.org.au, ebiggers@kernel.org, ardb@kernel.org,
        x86@kernel.org, luto@kernel.org, tglx@linutronix.de, bp@suse.de,
        dave.hansen@linux.intel.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v5 05/12] x86/msr-index: Add MSRs for Key Locker internal wrapping key
Date:   Wed, 12 Jan 2022 13:12:51 -0800
Message-Id: <20220112211258.21115-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112211258.21115-1-chang.seok.bae@intel.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU state that contains the internal wrapping key is in the same power
domain as the cache. So any sleep state that would invalidate the cache
(like S3) also invalidates the state of the wrapping key.

But, since the state is inaccessible to software, it needs a special
mechanism to save and restore the key during deep sleep.

A set of new MSRs are provided as an abstract interface to save and restore
the wrapping key, and to check the key status.

The wrapping key is saved in a platform-scoped state of non-volatile media.
The backup itself and its path from the CPU are encrypted and integrity
protected.

But this storage's non-volatility is not architecturally guaranteed across
off states, such as S5 and G3.

The MSRs will be used to back up the key for S3/4 sleep states. Then the
kernel code writes one of them to restore the key in each CPU state.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from RFC v2:
* Update the changelog. (Dan Williams)
* Rename the MSRs. (Dan Williams)
---
 arch/x86/include/asm/msr-index.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 01e2650b9585..7f11a3b3a75b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -941,4 +941,10 @@
 #define MSR_VM_IGNNE                    0xc0010115
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
+/* MSRs for managing an internal wrapping key for Key Locker. */
+#define MSR_IA32_IWKEY_COPY_STATUS		0x00000990
+#define MSR_IA32_IWKEY_BACKUP_STATUS		0x00000991
+#define MSR_IA32_BACKUP_IWKEY_TO_PLATFORM	0x00000d91
+#define MSR_IA32_COPY_IWKEY_TO_LOCAL		0x00000d92
+
 #endif /* _ASM_X86_MSR_INDEX_H */
-- 
2.17.1

