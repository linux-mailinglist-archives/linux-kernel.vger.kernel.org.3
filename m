Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999324B5506
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355914AbiBNPj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:39:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiBNPjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:39:54 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515F560A94
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644853187; x=1676389187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tBq5G6DGdm8dCqFpUhhhooINLC3BMivAvyoI5veTl20=;
  b=BH9yqEHTvWt17VeBwg3DKGndK98F9TDc6drEfV49EtrY3WXOynaMFCYS
   xHn48JS2nse1ulE8XpVQL/i4Dp7OwNrY1hxiVwMbKwu2zOgwSgieSuXR+
   ufIK2vRus6HB1BzHkz62DCzQSSSM6Hcv7aYVifmRzQvA2UQbTkg+6UKbG
   D+4c+PozV1vOKSal0LUD1Qmb3LftHAukZ3wGMN5e9HJ5tol/tMbq5nyej
   7UhgE3rCMeIaXKkqV4GEeX5ZyAQdaJKD4eR7Iti9lx4Nxn4vGAG/+vHy9
   7KYCb3mH2ouPwUNjjv6Qv0zqwCjxKLZtHVNhFdI3cXb0l7jRx+Mo7LSAj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249860853"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="249860853"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 07:39:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="528241928"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 14 Feb 2022 07:39:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EE089143; Mon, 14 Feb 2022 17:39:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] misc: sgi-gru: Don't cast parameter in bit operations
Date:   Mon, 14 Feb 2022 17:39:58 +0200
Message-Id: <20220214153958.9721-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While in this particular case (*) it would not be an issue,
the pattern itself is bad and error prone in case somebody
blindly copies to their code.

Don't cast parameter to unsigned long pointer in the bit
operations. Note, new compilers might warn on this line for
potential outbound access.

*) it seems a dead code, so remove it all for good

Fixes: 13d19498b044 ("GRU Driver: driver internal header files")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/sgi-gru/grutables.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
index e4c067c61251..5efc869fe59a 100644
--- a/drivers/misc/sgi-gru/grutables.h
+++ b/drivers/misc/sgi-gru/grutables.h
@@ -530,12 +530,6 @@ struct gru_blade_state {
 		for ((i) = (k)*GRU_CBR_AU_SIZE;				\
 				(i) < ((k) + 1) * GRU_CBR_AU_SIZE; (i)++)
 
-/* Scan each DSR in a DSR bitmap. Note: multiple DSRs in an allocation unit */
-#define for_each_dsr_in_allocation_map(i, map, k)			\
-	for_each_set_bit((k), (const unsigned long *)(map), GRU_DSR_AU)	\
-		for ((i) = (k) * GRU_DSR_AU_CL;				\
-				(i) < ((k) + 1) * GRU_DSR_AU_CL; (i)++)
-
 #define gseg_physical_address(gru, ctxnum)				\
 		((gru)->gs_gru_base_paddr + ctxnum * GRU_GSEG_STRIDE)
 #define gseg_virtual_address(gru, ctxnum)				\
-- 
2.34.1

