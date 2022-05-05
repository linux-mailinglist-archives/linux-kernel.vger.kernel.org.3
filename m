Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E4951CD39
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387184AbiEFADG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387141AbiEFABt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622EC612BB
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795076; x=1683331076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Nult8sm5xsB/xmikf6OohjRwLwTEdiOtEi3jvHsqyXk=;
  b=XbU5pEJw2XhDEePLdjTKFhY54/ePm8S6yhvSvV2w1yv07NbMSgkP0mp6
   XJXptj2uC3YuSn9J4SeCqdApp8HAOQwfYyhdr9or+/JJk+r3ovVSHqsxh
   52bM9VzCSnO+0HJh1EcferownI9pXDMxq3xJHPv9c1RpakZ/iHeZSTtCx
   DMb+MxA07d1tLgT6zG9UN435RXF/PNdJPPOtYlgnAA3YavdRHE9kSeQJ5
   /tViV01w5OY48FyUKPGXzmHGjsUCJGx6nytbb3W8bIMW7u03YBxdSxuJq
   2ImK/5xa+r3YvdkD7L6EUSwOCGoRsH9JgXfw0Aj2PChK7mJXCZjNLtE68
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250283648"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250283648"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694914415"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 16:57:52 -0700
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
Subject: [PATCH v6 20/29] init/main: Delay initialization of the lockup detector after smp_init()
Date:   Thu,  5 May 2022 16:59:59 -0700
Message-Id: <20220506000008.30892-21-ricardo.neri-calderon@linux.intel.com>
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

Certain implementations of the hardlockup detector require support for
Inter-Processor Interrupt shorthands. On x86, support for these can only
be determined after all the possible CPUs have booted once (in
smp_init()). Other architectures may not need such check.

lockup_detector_init() only performs the initializations of data
structures of the lockup detector. Hence, there are no dependencies on
smp_init().

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 * Introduced this patch

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 init/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 98182c3c2c4b..62c52c9e4c2b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1600,9 +1600,11 @@ static noinline void __init kernel_init_freeable(void)
 
 	rcu_init_tasks_generic();
 	do_pre_smp_initcalls();
-	lockup_detector_init();
 
 	smp_init();
+
+	lockup_detector_init();
+
 	sched_init_smp();
 
 	padata_init();
-- 
2.17.1

