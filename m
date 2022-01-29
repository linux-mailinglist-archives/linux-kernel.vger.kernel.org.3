Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBDA4A3111
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351943AbiA2Roh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:44:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:54626 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245682AbiA2Roe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643478274; x=1675014274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hG8h2J7gfBwIVc5hOnYbEWs6O2Ve57mhwXoORMsooLA=;
  b=ZuIyL5rOZkypLaPOq6RXdPsCxhCFYowbN+jzzHVcYAJWgySLXBZdhfvE
   djEdpj6RbTTBdBJu/r4TA7MwjCKCR4BBOrR8iIKIUnJsDhpjAYbBEWMyj
   H5w2uMe/edcLFD9u14fOFweaie1LyvMr4gqbfV+R4tXKs3jzSInt1eQRJ
   K5ZvaVZ+d0V/NLob17EejBvqBa4SO73NeQLAo7w8w1zAQ7xh0P8Gd9pcI
   vrflYzcT9OiFBHKbsELwIK6g4x7hCXQG99tAImvI+Pk56EQyVgy2tst0z
   UlVxfjrSGCEuKAXOdl5Wy+LGwSbA8XZ2pqUHo6T6UBv1aUiEApWRI2utU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="308016820"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="308016820"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 09:44:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="675370401"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2022 09:44:33 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com
Cc:     yang.zhong@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH v4 1/2] x86/arch_prctl: Fix the ARCH_REQ_XCOMP_PERM implementation
Date:   Sat, 29 Jan 2022 09:36:46 -0800
Message-Id: <20220129173647.27981-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220129173647.27981-1-chang.seok.bae@intel.com>
References: <20220129173647.27981-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Zhong <yang.zhong@intel.com>

ARCH_REQ_XCOMP_PERM is supposed to add the requested feature to the
permission bitmap of thread_group_leader()->fpu. But the code overwrites
the bitmap with the requested feature bit only rather than adding it.

Fix the code to add the request feature bit to the master bitmask.

Fixes: db8268df0983 ("x86/arch_prctl: Add controls for dynamic XSTATE components")
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v3:
* Adjust the change to the mainline (v5.17-rc).

Changes from v2:
 * Fix the authorship.

Changes from v1:
 * Change the mask value only and trim the changelog.
---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 02b3ddaf4f75..2d4363e32517 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1636,7 +1636,7 @@ static int __xstate_request_perm(u64 permitted, u64 requested, bool guest)
 
 	perm = guest ? &fpu->guest_perm : &fpu->perm;
 	/* Pairs with the READ_ONCE() in xstate_get_group_perm() */
-	WRITE_ONCE(perm->__state_perm, requested);
+	WRITE_ONCE(perm->__state_perm, mask);
 	/* Protected by sighand lock */
 	perm->__state_size = ksize;
 	perm->__user_state_size = usize;
-- 
2.17.1

