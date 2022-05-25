Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62145345E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245439AbiEYViJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiEYViH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:38:07 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0655EAB0C8;
        Wed, 25 May 2022 14:38:05 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24PLbpnL034943;
        Wed, 25 May 2022 16:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653514671;
        bh=unEU3yu6XitRBUF0X3b3HqPGfQ24x1GXFPO/xiQYto8=;
        h=From:To:CC:Subject:Date;
        b=LXM/LbXnyVD/xHo53tWgYowMmQtgdVWU0/jqn6R9yjDbK0dZANeS8CKvR6zDWGsTi
         QUdPGak+SxW1PGd4FR7NXmqHjJW9SnSpX6Wo6eTZi/B5uVmJULbU6K4pRAjMBV4BnX
         puP/WKbz3ixFWI3uzDTjSDFFriCZcDXqSiA9mpB4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24PLbpDB007258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 May 2022 16:37:51 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 25
 May 2022 16:37:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 25 May 2022 16:37:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24PLbpFS018664;
        Wed, 25 May 2022 16:37:51 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     Keerthy <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH] thermal: k3_j72xx_bandgap: Fix ref_table memory leak during probe
Date:   Wed, 25 May 2022 16:36:17 -0500
Message-ID: <20220525213617.30002-1-bb@ti.com>
X-Mailer: git-send-email 2.17.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; h=from:subject; bh=jAry1GfKB2IXde/WjnhULMOUIPI3IX37C1dJv1gsc9s=; b=owEBbQGS/pANAwAKAcD4q9PiE9cMAcsmYgBijqFQoomfFMXwXhjrDSIGMaT+atNSHe1YzydEHzZY RLtkYHOJATMEAAEKAB0WIQT86LDvkHWcjT+1Kb7A+KvT4hPXDAUCYo6hUAAKCRDA+KvT4hPXDAnDB/ 4jE6Up2Wn5ZbODu6KFyeMvWn5O03dNwlXDj9/pYdo39zDZ3elEKfk5rZXLOXncwzJE/+Q8orPhD9P2 QW99DNp26O/Rm9a0LnTEdnBTsP5KdcRp7DD86G7KqDsYDqYXNVnaNZgiQsX76G4JIllOpsOKps5UKx 7vJExENpewfgdHFyopQg/PXZ+lPwjY9vognA13ehw2Z0jSekmoMjwVpPp1Ci79zp+dNJSdaz3JV/tr RtTr0yyl9AFI82L1kMVjar+1O+npoJqkI36vXEEQb0zKhFhT64xSDmvHbsZC0v89y114omcKOGorBJ Dov0KJBYStFtjCQZEuAMWzlrZBua34
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs in the k3_j72xx_bandgap_probe() function the memory
allocated to the 'ref_table' will not be released.

Add a err_free_ref_table step to the error path to free 'ref_table'

Fixes: 72b3fc61c752 ("thermal: k3_j72xx_bandgap: Add the bandgap driver support")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 64e3231589527..3a35aa38ff512 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -433,7 +433,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 				     GFP_KERNEL);
 	if (!derived_table) {
 		ret = -ENOMEM;
-		goto err_alloc;
+		goto err_free_ref_table;
 	}
 
 	/* Workaround not needed if bit30/bit31 is set even for J721e */
@@ -483,7 +483,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		if (IS_ERR(ti_thermal)) {
 			dev_err(bgp->dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(ti_thermal);
-			goto err_alloc;
+			goto err_free_ref_table;
 		}
 	}
 
@@ -514,6 +514,9 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_free_ref_table:
+	kfree(ref_table);
+
 err_alloc:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.17.1

