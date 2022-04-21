Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED83D50AA29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392505AbiDUUlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392468AbiDUUkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:40:52 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2424DF76;
        Thu, 21 Apr 2022 13:37:59 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23LKbl8p090016;
        Thu, 21 Apr 2022 15:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650573467;
        bh=0d5eQnd+UR9U9jPUjFIONA+8xaxiU9xXTiPVUnEhXc4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Vc5jk9sV9XyEevpIGBybWpxJH2n/iCl6PeAJw/y73wgs4/bIuOCyWGw0A8Tyb2m5w
         1Dz9Ro2EbsU+abZ0ZUaDw2+UdvQ4987Pk4+MezAXNp+CtZoeR9PwI2JXqODv8sI2iS
         qbBu73f9jgb7jr3aJgGmUsu33dVAyS6WQ7mXZbXM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23LKbll4001174
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 15:37:47 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 15:37:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 15:37:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23LKbkZm093984;
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
Subject: [PATCH 6/6] firmware: ti_sci: Introduce prepare system suspend call
Date:   Thu, 21 Apr 2022 15:36:59 -0500
Message-ID: <20220421203659.27853-7-d-gerlach@ti.com>
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

Introduce a ti_sci_prepare_system_suspend call to be used in the driver
suspend handler to allow the system to identify the low power mode being
entered and if nevessary, send TI_SCI_MSG_BEGIN_SLEEP with information
about the mode is being entered and the address for DDR memory carveout.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/firmware/ti_sci.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 772643cb940c..07b6fa98bb45 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/suspend.h>
 #include <linux/reboot.h>
 
 #include "ti_sci.h"
@@ -3388,11 +3389,41 @@ static void ti_sci_set_is_suspending(struct ti_sci_info *info, bool is_suspendin
 	info->is_suspending = is_suspending;
 }
 
+static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
+{
+	int ret = 0;
+	int mode;
+
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_MEM:
+		mode = TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	/*
+	 * Do not fail if we don't have action to take for a
+	 * specific suspend mode.
+	 */
+	if (ret)
+		return 0;
+
+	ret = ti_sci_cmd_prepare_sleep(&info->handle, mode, info->mem_ctx_lo,
+				       info->mem_ctx_hi, 0);
+
+	return ret;
+}
+
 static int ti_sci_suspend(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
 	int ret = 0;
 
+	ret = ti_sci_prepare_system_suspend(info);
+	if (ret)
+		return ret;
+
 	/*
 	 * We must switch operation to polled mode now as drivers and the genpd
 	 * layer may make late TI SCI calls to change clock and device states
-- 
2.35.0

