Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B7B51CD47
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387069AbiEFABr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387048AbiEFAB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B360DB7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795067; x=1683331067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Jz5/GbztoMpO5f33w54Dy1VgumudmsMpWQzH5+E5s4I=;
  b=XlZwEYI6/M/Oti/oKGwvzBgRy98haQGOy0pNl1ocMfxAxNWuh77VXoX8
   mfn6j2B80IABNcm2f1O78T7HrFLtCiJjKHo2hMNbw33/X8Dk8y0kdMWqC
   fGxZUMJgnuGpV9lnIBA2YtHsP6CCcbNoT5mwYUJ6VnlikYVSe3tqS9whK
   m9aetlD8Dq2cnW1PFOzKRx4vf+D5jdptOJLtEXxoVv9mMX80y2xpfGVkZ
   KP7dGaAydb0qbZhBi8RzIxrREpIw/4dKxnXCCs4oaDFPX5YI5CArhld5c
   xKH4yHo0pWLiBnxXl+l//kY9iRCajNzs1b+Cc/OKRDspSQxpa1V1+6FF8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283617"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283617"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914335"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:45 -0700
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
Subject: [PATCH v6 04/29] x86/apic: Add the X86_IRQ_ALLOC_AS_NMI irq allocation flag
Date:   Thu,  5 May 2022 16:59:43 -0700
Message-Id: <20220506000008.30892-5-ricardo.neri-calderon@linux.intel.com>
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

There are cases in which it is necessary to set the delivery mode of an
interrupt as NMI. Add a new flag that callers can specify when allocating
an IRQ.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Introduced this patch.

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/include/asm/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomain.h
index 125c23b7bad3..de1cf2e80443 100644
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -10,6 +10,7 @@ enum {
 	/* Allocate contiguous CPU vectors */
 	X86_IRQ_ALLOC_CONTIGUOUS_VECTORS		= 0x1,
 	X86_IRQ_ALLOC_LEGACY				= 0x2,
+	X86_IRQ_ALLOC_AS_NMI				= 0x4,
 };
 
 extern int x86_fwspec_is_ioapic(struct irq_fwspec *fwspec);
-- 
2.17.1

