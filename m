Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642364B728C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbiBOQG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:06:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiBOQGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:06:55 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C594E26C6;
        Tue, 15 Feb 2022 08:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644941204; x=1676477204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OTSVNNetfK3YGvJIPObK70O6BWaiWqju9kZhM5cFlEw=;
  b=kzn4jJfYOPQzGX+jGxDawrm+8F7cLe3zxmLE+unHY0Q7hLJStj3GOZ8r
   dS0guvXNDPEPtHvQ3a4tVNBMjJ3wIt/jYtkycoYxNkeaajP9j+XCqoBJP
   T0HaQE93VcAgcFE8CDyfMichhMI9/EleoNYCWdYKmzaxEMRUxreglWYaF
   t5q2ABsS4sU4lJLLWlterU90nv7wq7cMIBc9uCcTSC161j5PCi3K8bxYZ
   ZG05oGvh0TC1ePiVJNXnhzPQWxa2qyMan5vJw9mXlFBEBR+vrcOGqiakC
   7TiBQYs0gfgPM0cLjTqkYVz7E9vfCf80jJ2zx1LZw05jgDP2GOB+ELJGw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313657596"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="313657596"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 08:06:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="587763352"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Feb 2022 08:06:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 374FD107; Tue, 15 Feb 2022 18:06:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v1 1/1] crypto: cavium/nitrox - don't cast parameter in bit operations
Date:   Tue, 15 Feb 2022 18:06:41 +0200
Message-Id: <20220215160641.51683-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While in this particular case it would not be a (critical) issue,
the pattern itself is bad and error prone in case the location
of the parameter is changed.

Don't cast parameter to unsigned long pointer in the bit operations.
Instead copy to a local variable on stack of a proper type and use.

Fixes: cf718eaa8f9b ("crypto: cavium/nitrox - Enabled Mailbox support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/crypto/cavium/nitrox/nitrox_mbx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_mbx.c b/drivers/crypto/cavium/nitrox/nitrox_mbx.c
index 2e9c0d214363..4531476a585a 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_mbx.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_mbx.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bitmap.h>
 #include <linux/workqueue.h>
 
 #include "nitrox_csr.h"
@@ -122,6 +123,7 @@ void nitrox_pf2vf_mbox_handler(struct nitrox_device *ndev)
 {
 	struct nitrox_vfdev *vfdev;
 	struct pf2vf_work *pfwork;
+	DEFINE_BITMAP(csr, 64);
 	u64 value, reg_addr;
 	u32 i;
 	int vfno;
@@ -129,7 +131,8 @@ void nitrox_pf2vf_mbox_handler(struct nitrox_device *ndev)
 	/* loop for VF(0..63) */
 	reg_addr = NPS_PKT_MBOX_INT_LO;
 	value = nitrox_read_csr(ndev, reg_addr);
-	for_each_set_bit(i, (const unsigned long *)&value, BITS_PER_LONG) {
+	bitmap_from_u64(csr, value);
+	for_each_set_bit(i, csr, BITS_PER_TYPE(csr)) {
 		/* get the vfno from ring */
 		vfno = RING_TO_VFNO(i, ndev->iov.max_vf_queues);
 		vfdev = ndev->iov.vfdev + vfno;
@@ -151,7 +154,8 @@ void nitrox_pf2vf_mbox_handler(struct nitrox_device *ndev)
 	/* loop for VF(64..127) */
 	reg_addr = NPS_PKT_MBOX_INT_HI;
 	value = nitrox_read_csr(ndev, reg_addr);
-	for_each_set_bit(i, (const unsigned long *)&value, BITS_PER_LONG) {
+	bitmap_from_u64(csr, value);
+	for_each_set_bit(i, csr, BITS_PER_TYPE(csr)) {
 		/* get the vfno from ring */
 		vfno = RING_TO_VFNO(i + 64, ndev->iov.max_vf_queues);
 		vfdev = ndev->iov.vfdev + vfno;
-- 
2.34.1

