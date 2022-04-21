Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE3509ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388914AbiDULlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388901AbiDULli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:41:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B1D2C124
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650541129; x=1682077129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m643EXK7yOsfDONzYaJXtxPMlW05HUDqdqLxYq7AN30=;
  b=DE70bKoUYKqTBBTcb3S6BC4hsjAdEkhvGpGfSX//Cy7ZuBQFvLiyjqaX
   bAmoil/oLG2IHriQDUazNgIgUZk0G3SITGRz3cWcaLSRUHF2q3wdIBlbj
   7no7oXDFky7frOh7Cy9pueZhhqOIne7S+XRX7MUrwhckCvQBlhdXytRx3
   YPXeEyJ8ZSLdHIsu9VUk3lgRA6P5Xyuph61Once3G/G6KzaqUfnnnfHXe
   eTe4Sm+FNmLpqtJ1XTcxbfFGfXQR0YGbRfUNLe0dlvAVkK43xuP7Y1Dtg
   bBOO9DBTRLwiimc7xkpv58w/sWgvknuiI0dLuK6rRKXO0w8xaE8hPx8Vq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264492198"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264492198"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 04:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="703047933"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 04:38:47 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 3/4] iommu/vt-d: Drop stop marker messages
Date:   Thu, 21 Apr 2022 19:35:57 +0800
Message-Id: <20220421113558.3504874-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page fault handling framework in the IOMMU core explicitly states
that it doesn't handle PCI PASID Stop Marker and the IOMMU drivers must
discard them before reporting faults. This handles Stop Marker messages
in prq_event_thread() before reporting events to the core.

The VT-d driver explicitly drains the pending page requests when a CPU
page table (represented by a mm struct) is unbound from a PASID according
to the procedures defined in the VT-d spec. The Stop Marker messages do
not need a response. Hence, it is safe to drop the Stop Marker messages
silently if any of them is found in the page request queue.

Fixes: d5b9e4bfe0d88 ("iommu/vt-d: Report prq to io-pgfault framework")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c720d1be992d..0741ec165673 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -760,6 +760,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			goto bad_req;
 		}
 
+		/* Drop Stop Marker message. No need for a response. */
+		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
+			goto prq_advance;
+
 		if (!svm || svm->pasid != req->pasid) {
 			/*
 			 * It can't go away, because the driver is not permitted
-- 
2.25.1

