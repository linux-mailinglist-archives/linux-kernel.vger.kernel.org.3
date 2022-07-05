Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD83F566A0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiGELn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiGELnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:43:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032111705E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657021398; x=1688557398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A/iVWU6pxDoT5uMIDcQutlmc65XpReRATcZ1jxgCGx8=;
  b=m/eum3m9bYuwV/lDPfJ/tsEss0A+ZbqCaHxL3LUHybtpo2mYVkrsXxxX
   BoSkReuwhql1pZCTrLobp2SMbVgVbcChUnESrdinrxikVH1Esf++ncSYM
   cGCU84UgDXaXzffTH0+INhl7TfBE+HidC6LsfPd/HHKbhe5CJbPNcFSms
   bJZyll+W/MIfAIrelQOWO9uNLRIGY0dxKZA4ytJa75e3WWOsEfno2vgCv
   soT33L8SNjjr6SpBujBYlpO4k6k07a6NSSTwRS69tHfsgatSpERek9QxH
   pla8/EgiNFnp76PRaMVuRS+4dh2RDLtIY4CL86Agwl4zkp0QREN1LFK71
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="345011145"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="345011145"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 04:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="650100635"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2022 04:43:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A25A1400; Tue,  5 Jul 2022 14:43:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] bus: hisi_lpc: Correct error code for timeout
Date:   Tue,  5 Jul 2022 14:43:11 +0300
Message-Id: <20220705114312.86164-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usual error code is -ETIMEDOUT, the currently used -ETIME is specific
for timers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bus/hisi_lpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 03d4d96ff794..a6513a571d7b 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -85,7 +85,7 @@ static int wait_lpc_idle(void __iomem *mbase, unsigned int waitcnt)
 		ndelay(LPC_NSEC_PERWAIT);
 	} while (--waitcnt);
 
-	return -ETIME;
+	return -ETIMEDOUT;
 }
 
 /*
-- 
2.35.1

