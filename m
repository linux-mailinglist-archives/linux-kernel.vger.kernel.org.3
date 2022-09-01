Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822F95A9599
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiIALVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiIALVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:21:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9841E125B99
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:21:11 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJJW64sQcz67nFV;
        Thu,  1 Sep 2022 19:20:34 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 13:21:09 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 12:21:05 +0100
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>,
        <rafael.j.wysocki@intel.com>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <yangyingliang@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/5] bus: hisi_lpc: Correct error code for timeout
Date:   Thu, 1 Sep 2022 19:14:29 +0800
Message-ID: <1662030871-182688-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1662030871-182688-1-git-send-email-john.garry@huawei.com>
References: <1662030871-182688-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The usual error code is -ETIMEDOUT, the currently used -ETIME is specific
for timers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: John Garry <john.garry@huawei.com>
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
2.35.3

