Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03D950AA25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392469AbiDUUkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347666AbiDUUkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:40:49 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA6B4DF77;
        Thu, 21 Apr 2022 13:37:55 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23LKbluq026800;
        Thu, 21 Apr 2022 15:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650573467;
        bh=Buk4/Q/Knf7GPVo3lVclQIHMgwwIxKgFs+8J/u0XktY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kvg8JTnVdaKyaD+Un6CrCT6k/LrvaseU+4s8Ynr2H4OY7YdUaYsU/CUNYujbbGqda
         Ho7CvZST0L/bxbB51FHdDfiHzHVa6AjD3ZN1V3nID2l9qzoCUZRRYsqIgAu6Bxq1NS
         K+a6rr7N5sKAyDfcuUEFaQ//shevxb7NaZTGa5Sg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23LKblN1084675
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 15:37:47 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 15:37:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 15:37:46 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23LKbkcQ012880;
        Thu, 21 Apr 2022 15:37:46 -0500
From:   Dave Gerlach <d-gerlach@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 4/6] firmware: ti_sci: Introduce ti,ctx-memory-region for reserved LPM memory
Date:   Thu, 21 Apr 2022 15:36:57 -0500
Message-ID: <20220421203659.27853-5-d-gerlach@ti.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220421203659.27853-1-d-gerlach@ti.com>
References: <20220421203659.27853-1-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A reserved memory region in DDR must be used during low power modes for
saving of some system context when using the ti_sci firmware, so
introduce a property to allow providing this in the device tree so that
it can be read and shared with the firmware.

Also send a TISCI_MSG_PREPARE_SUSPEND message to the firmware during
probe to determine if system suspend is supported and if
ti_sci_init_suspend should be called based on the response received.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/firmware/ti_sci.c | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 4b0f747251c8..1c2000b40e8f 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -17,6 +17,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/semaphore.h>
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
@@ -96,6 +97,8 @@ struct ti_sci_desc {
  * @minfo:	Message info
  * @node:	list head
  * @host_id:	Host ID
+ * @mem_ctx_lo: Low word of address used for low power context memory
+ * @mem_ctx_hi: High word of address used for low power context memory
  * @users:	Number of users of this instance
  * @is_suspending: Flag set to indicate in suspend path.
  */
@@ -114,6 +117,8 @@ struct ti_sci_info {
 	struct ti_sci_xfers_info minfo;
 	struct list_head node;
 	u8 host_id;
+	u32 mem_ctx_lo;
+	u32 mem_ctx_hi;
 	/* protected by ti_sci_list_mutex */
 	int users;
 	bool is_suspending;
@@ -3374,6 +3379,29 @@ static int ti_sci_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ti_sci_pm_ops, ti_sci_suspend, ti_sci_resume);
 
+static int ti_sci_init_suspend(struct platform_device *pdev, struct ti_sci_info *info)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *rmem_np;
+	struct reserved_mem *rmem;
+
+	rmem_np = of_parse_phandle(dev->of_node, "ti,ctx-memory-region", 0);
+	if (!rmem_np) {
+		dev_warn(dev, "ti,ctx-memory-region is required for suspend but not provided.\n");
+		return -EINVAL;
+	}
+
+	rmem = of_reserved_mem_lookup(rmem_np);
+	of_node_put(rmem_np);
+	if (!rmem)
+		return -EINVAL;
+
+	info->mem_ctx_lo = (rmem->base & 0xFFFFFFFF);
+	info->mem_ctx_hi = (rmem->base >> 32);
+
+	return 0;
+}
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3526,6 +3554,23 @@ static int ti_sci_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * Attempt to call prepare_sleep, this will be NAK'd if suspend is not
+	 * supported by firmware in use, in which case we will not attempt to
+	 * init suspend.
+	 */
+	ret = ti_sci_cmd_prepare_sleep(&info->handle, 0, info->mem_ctx_lo,
+				       info->mem_ctx_hi, 0);
+	if (!ret) {
+		ret = ti_sci_init_suspend(pdev, info);
+		if (ret)
+			dev_warn(dev,
+				 "ti_sci_init_suspend failed, mem suspend will be non-functional.\n");
+	}
+
+	/* Suspend is an optional feature, reset return value and continue. */
+	ret = 0;
+
 	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
 		 info->handle.version.abi_major, info->handle.version.abi_minor,
 		 info->handle.version.firmware_revision,
-- 
2.35.0

