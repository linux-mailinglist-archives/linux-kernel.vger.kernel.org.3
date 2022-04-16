Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1D50369E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 14:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiDPMgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiDPMgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 08:36:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A27FFE427
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650112415; x=1681648415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s/nEvl/+FxcEwkLWfzrwaMLflIe37RdxIWhxas3awd4=;
  b=gMgABO3sWFlcsHehJ2wVh301+E2HKhX5Q9PDOKPOVQwS6x9YN4Omc5JU
   DTjvX/gf8UjUMW5mM7w93Z/SuIj7uy3QQJBmX520m0ERyuEO3Wz03fbLy
   eXlVzdbDJbplwgyCFmE1ZBTixf23hitqtkmefCs3DrDfUosq2sTCKJvsz
   zKPe6rLzuzgSAq8GlBv/mol2D4hA2Yx7XRH51309sv+RsvneV0WUdOvmF
   RSqWiMkQAYl321tCkaqGu3QNihzY7q/k36sQTt/YnlnBBPPDaEkGq2+FE
   etM0qF3VM/iO6H99Adcr2JAcuEyOuUj199QdWj60v5ob69XB/zfGmyyHI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243221102"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="243221102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 05:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="701332474"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 05:33:33 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/3] iommu/vt-d: Drop stop marker messages
Date:   Sat, 16 Apr 2022 20:30:48 +0800
Message-Id: <20220416123049.879969-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416123049.879969-1-baolu.lu@linux.intel.com>
References: <20220416123049.879969-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VT-d driver explicitly drains the pending page requests when a CPU
page table (represented by a mm struct) is unbound from a PASID according
to the procedures defined in the VT-d spec. Hence, there's no need to
report the stop-marker message in prq_event_thread(). The stop marker
messages do not need a response. This drops stop marker messages silently
if any of them is found in the page request queue.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d88af37c20ef..d1c42dfae6ca 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -758,6 +758,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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

