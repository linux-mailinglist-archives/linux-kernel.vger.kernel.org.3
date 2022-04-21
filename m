Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0474509ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388918AbiDULlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388912AbiDULlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:41:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7232C111
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650541131; x=1682077131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TlJ1+MVmh4jBiR+OUjOQpWZePfw1j7kEuRwY1xJFAsk=;
  b=Jtf4JQyjLKDURaBJyxF1trWLqhaSkS8nWANhkEZygxiWJEcqlU3DnNOu
   wj8sgILxScmm43BnNUexyWxx4ARtXw2FE2PVSGH6SMcOyCplJtgrg8vfp
   C3m4LtSwqaLvop8RTxurTBjATrnEsbYsSbptdnUc83sW4lkWUjyugBQKU
   tk1Rw+wpJYYEL8Pd/q7frzsU0tQ5hf0FbsJp0eg9z7q4ulcZjdoYKjyXl
   +6JlIoVTqUgO9C5sYNS21X7dquuoQyiMMwDKs11Uk+YomvGwjXFjdPCbl
   9hEXQpwAUzbTpchsDQvtupaaEHg6AleY7GDqkeUo2UaUthFrg2+TsYL8v
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264492206"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264492206"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 04:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="703047964"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 04:38:49 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 4/4] iommu/vt-d: Size Page Request Queue to avoid overflow condition
Date:   Thu, 21 Apr 2022 19:35:58 +0800
Message-Id: <20220421113558.3504874-5-baolu.lu@linux.intel.com>
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

PRQ overflow may cause I/O throughput congestion, resulting in unnecessary
degradation of I/O performance. Appropriately increasing the length of PRQ
can greatly reduce the occurrence of PRQ overflow. The count of maximum
page requests that can be generated in parallel by a PCIe device is
statically defined in the Outstanding Page Request Capacity field of the
PCIe ATS configure space.

The new length of PRQ is calculated by summing up the value of Outstanding
Page Request Capacity register across all devices where Page Requests are
supported on the real PR-capable platform (Intel Sapphire Rapids). The
result is round to the nearest higher power of 2.

The PRQ length is also double sized as the VT-d IOMMU driver only updates
the Page Request Queue Head Register (PQH_REG) after processing the entire
queue.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-svm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index b3b125b332aa..207ef06ba3e1 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -9,7 +9,7 @@
 #define __INTEL_SVM_H__
 
 /* Page Request Queue depth */
-#define PRQ_ORDER	2
+#define PRQ_ORDER	4
 #define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 #define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
 
-- 
2.25.1

