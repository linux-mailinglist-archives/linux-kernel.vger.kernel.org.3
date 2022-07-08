Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A16B56C445
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbiGHVJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbiGHVI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:08:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0B119C39
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657314536; x=1688850536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MipkBwVboIvfu0j2zCoNnDzdVOGJWV6aLvl1LNNDEZ8=;
  b=Z/hI9tnaCXm5CIyH0jKG7E2ROv2AUbpg7Et3935R5k1xkgq5YV6ippmv
   gIKCAU3Vl6w/zE3lpLO0o5BSLri21Hjf4eEDi2hacKX5pIPMqs6l4pZ/E
   pVOD9WWlyjLok9MOQGaMCfXFUUuQPLJi2fDtV7R/QE9/UPArypsyXkjrL
   v02B1VywqU/dgecMuh6neWrxPN1po+OdnUsDGg/TMOq8XlE+PSAokDQYO
   JBFV3PluuE2DgTyhrXYO2Kjp65biF+UUudZ1oM9PKsLZlUGTZr/+4jha6
   2T3okkgPOVeSbIApoD/jLrra7SqLNpZhegB+pvOg7XVuXla92Q3sHXinT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="370678951"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="370678951"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 14:08:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="770903044"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2022 14:08:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A367B400; Sat,  9 Jul 2022 00:09:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com
Subject: [PATCH v2 3/4] bus: hisi_lpc: Correct error code for timeout
Date:   Sat,  9 Jul 2022 00:08:58 +0300
Message-Id: <20220708210859.6774-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220708210859.6774-1-andriy.shevchenko@linux.intel.com>
References: <20220708210859.6774-1-andriy.shevchenko@linux.intel.com>
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
Acked-by: John Garry <john.garry@huawei.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v2: added tags (John, Rafael)
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

