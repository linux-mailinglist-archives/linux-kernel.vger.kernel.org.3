Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815D44C18E0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbiBWQjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242969AbiBWQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:38:54 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB00C7E9C;
        Wed, 23 Feb 2022 08:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645634297; x=1677170297;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z+NrxgTDITMoT3Rx2AO5jzVTn98+WKENiTVzqhfsXOE=;
  b=jQ9ZMLm9WSLdJa5fLHuebMD088v0uK6zlKQQ+m5f0ES4Nhe3kQlYPlkB
   hhLfRvcTNb/wsUNlBxN7vtMJw6tnk5HcNEbu4xLUXt2llrm4nIzuR//nI
   Zkq8JSZTbuZ4z3PyGNP2xfczSlNppiObRQ96a7Jp15zPttFH1i5xD5FGS
   vGwfR5/VOLGwvHcfKeCtzhHlsyMOYZPC1KvyuFvIGSD1TFs/4TxyiITB5
   Js6zdfco94PeaE56hIwgFGuV9lKlnrnPtm3kj+B7LPLBcVInq6gyymy7t
   q/fHjRvV7sul0o7gLFcjt1xma70l1gctYh/3hguLmv+20V18sPHOh7r50
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312730696"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="312730696"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 08:26:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="607109146"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 23 Feb 2022 08:26:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9BD343BC; Wed, 23 Feb 2022 18:26:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 1/1] crypto: cavium/nitrox - don't cast parameter in bit operations
Date:   Wed, 23 Feb 2022 18:26:20 +0200
Message-Id: <20220223162620.44307-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v2: fixed typo (LKP, Herbert)
 drivers/crypto/cavium/nitrox/nitrox_mbx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_mbx.c b/drivers/crypto/cavium/nitrox/nitrox_mbx.c
index 2e9c0d214363..9e7308e39b30 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_mbx.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_mbx.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bitmap.h>
 #include <linux/workqueue.h>
 
 #include "nitrox_csr.h"
@@ -120,6 +121,7 @@ static void pf2vf_resp_handler(struct work_struct *work)
 
 void nitrox_pf2vf_mbox_handler(struct nitrox_device *ndev)
 {
+	DECLARE_BITMAP(csr, BITS_PER_TYPE(u64));
 	struct nitrox_vfdev *vfdev;
 	struct pf2vf_work *pfwork;
 	u64 value, reg_addr;
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

