Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E621F4739ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244618AbhLNA7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:59:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:21411 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244571AbhLNA7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639443580; x=1670979580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IzmmcNwPyrly7VAToU85hx2yPsdSXI9+7O903lBKZz8=;
  b=kkF158Gw7e7fSw6gjQEZEWibEY3B7FZY3rKHOt/COyHaExFE8Cxppi0Q
   9EzEH1TSSnGztJXe14K9gX1W0u8dsGHdJ7DST3X1V6bRztX8rpIVkjy5c
   yeDqtnkkLdWdszimFJo5RCAiPK9oFVFSV4t/rGPnU3PJufv6161sLmBIb
   M+9coupZ2vtp8eahZNX2KdvIsasBv5CFiUUkTklI65f4xDsOzqEF+bjbc
   +brUTFwUaERZIhL0mhS6o2N3jHoIRsSOJmT+onUGJsPLc2ZWKZsFtIx3D
   rMFHVvVuP2CAB0A5knTCUEcq15gRQeRb8kqZlox4/fJVXKAb1QuzGod1P
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325139622"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="325139622"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 16:59:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505148581"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 16:59:39 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH v4 05/13] x86/msr-index: Add MSRs for Key Locker internal wrapping key
Date:   Mon, 13 Dec 2021 16:52:04 -0800
Message-Id: <20211214005212.20588-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214005212.20588-1-chang.seok.bae@intel.com>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
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

