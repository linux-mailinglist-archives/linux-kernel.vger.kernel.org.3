Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36C64A310F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351193AbiA2Rof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:44:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:54626 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243991AbiA2Rod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643478273; x=1675014273;
  h=from:to:cc:subject:date:message-id;
  bh=2wWplLq1RV7SAfSe6hbCZJmVoZzG7Tnpl3tf9z4L0m0=;
  b=bSna36simwKOHFNdB1Ezj3QmzFOcvaGq0e8VrZcJLkuW5aYQauBqO7pl
   wCtICJ+plmreDpGSTFaSUekbhNpeKLGfWGB14Idu41CCIySGcoxEate4a
   IPhoR+h4I8yBTKNidDPT3RHXS43nuivtgyFvGlnI9fTc/EADiGVf3p3ZU
   ExSlnVajwyE6jsXtkUkod0P4fIMnOIyEC0IvfVS92seYkQBTlcrV/B+WH
   Lzczw862rvUl5TibNskqO2uX9cP5I6qYvRBdyhJRewVP8arm2QAvcoF/9
   c0IGAzgfLEwXg47wJorPVpshWZ6zPjhwFUUuEfyYRAJiMh968VkIisYsy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="308016819"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="308016819"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 09:44:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="675370398"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2022 09:44:32 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com
Cc:     yang.zhong@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH v4 0/2] x86: Fix ARCH_REQ_XCOMP_PERM and update the test
Date:   Sat, 29 Jan 2022 09:36:45 -0800
Message-Id: <20220129173647.27981-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from V3:
* Rebased onto 5.17-rc1.

V3: https://lore.kernel.org/lkml/20211110003209.21666-1-chang.seok.bae@intel.com/

---

The recent x86 dynamic state support incorporates the arch_prctl option to
request permission before using a dynamic state.

It was designed to add the requested feature in the group leader's
permission bitmask so that every thread can reference this master bitmask.
The group leader is assumed to be unchanged here. The mainline is the case
as a group leader is identified at fork() or exec() time only.

This master bitmask should include non-dynamic features always, as they
are permitted by default. Users may check them via ARCH_GET_XCOMP_PERM.

But, in hindsight, the implementation does overwrite the bitmask with the
requested bit only, instead of adding the bit to the existing one. This
overwrite effectively revokes the permission that is granted already.

Fix the code and also update the selftest to disclose the issue if there
is.

Chang S. Bae (1):
  selftests/x86/amx: Update the ARCH_REQ_XCOMP_PERM test

Yang Zhong (1):
  x86/arch_prctl: Fix the ARCH_REQ_XCOMP_PERM implementation

 arch/x86/kernel/fpu/xstate.c      |  2 +-
 tools/testing/selftests/x86/amx.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.17.1

