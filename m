Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4947D51CD44
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245703AbiEFADN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385624AbiEFACO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:02:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B61D612BD
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795076; x=1683331076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=L3Ao7/ADM/27W4au5Ct5JCZDRw2G77dHHek57JRUTvg=;
  b=E2NtPqViFWrn2atGGZYkTXkyMPghh01m6m/aaUYnjDRPlyrpGbPSNngE
   UROZnMTxsZlxcj7P/G7WP/mXQ10bKYo30mllB8ulfdqkHLjhX83LgEufs
   cYp96O3Pdsfq+TMstygsrenDXUP9CCJWAvpzyPjOeG563AXruixSxvQw4
   NhrbxMk0w93hYcc3t95G3vFREDWZplKDti8NYIp2uO4H2QqwxqpQ9Cs4z
   Wgbb8RiovDg1QIvouwOL74ff5B9ZVvMHxtVmWIanP5RZXqXX8lbG7tqnY
   FgsBUd101imyK2fRhEvDcFrX3O2R+qP8BKDqnHHt+uUBw9FVFVZvrSVnW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283651"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283651"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914422"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:53 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v6 21/29] x86/nmi: Add an NMI_WATCHDOG NMI handler category
Date:   Thu,  5 May 2022 17:00:00 -0700
Message-Id: <20220506000008.30892-22-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a NMI_WATCHDOG as a new category of NMI handler. This new category
is to be used with the HPET-based hardlockup detector. This detector
does not have a direct way of checking if the HPET timer is the source of
the NMI. Instead, it indirectly estimates it using the time-stamp counter.

Therefore, we may have false-positives in case another NMI occurs within
the estimated time window. For this reason, we want the handler of the
detector to be called after all the NMI_LOCAL handlers. A simple way
of achieving this with a new NMI handler category.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Updated to call instrumentation_end() as per f051f6979550 ("x86/nmi:
   Protect NMI entry against instrumentation")

Changes since v4:
 * None

Changes since v3:
 * None

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 arch/x86/include/asm/nmi.h |  1 +
 arch/x86/kernel/nmi.c      | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 1cb9c17a4cb4..4a0d5b562c91 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -28,6 +28,7 @@ enum {
 	NMI_UNKNOWN,
 	NMI_SERR,
 	NMI_IO_CHECK,
+	NMI_WATCHDOG,
 	NMI_MAX
 };
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index e73f7df362f5..fde387e0812a 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -61,6 +61,10 @@ static struct nmi_desc nmi_desc[NMI_MAX] =
 		.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[3].lock),
 		.head = LIST_HEAD_INIT(nmi_desc[3].head),
 	},
+	{
+		.lock = __RAW_SPIN_LOCK_UNLOCKED(&nmi_desc[4].lock),
+		.head = LIST_HEAD_INIT(nmi_desc[4].head),
+	},
 
 };
 
@@ -168,6 +172,8 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 	 */
 	WARN_ON_ONCE(type == NMI_SERR && !list_empty(&desc->head));
 	WARN_ON_ONCE(type == NMI_IO_CHECK && !list_empty(&desc->head));
+	WARN_ON_ONCE(type == NMI_WATCHDOG && !list_empty(&desc->head));
+
 
 	/*
 	 * some handlers need to be executed first otherwise a fake
@@ -379,6 +385,10 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 	}
 	raw_spin_unlock(&nmi_reason_lock);
 
+	handled = nmi_handle(NMI_WATCHDOG, regs);
+	if (handled == NMI_HANDLED)
+		goto out;
+
 	/*
 	 * Only one NMI can be latched at a time.  To handle
 	 * this we may process multiple nmi handlers at once to
-- 
2.17.1

