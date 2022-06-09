Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4A65449D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbiFILR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242319AbiFILR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:17:27 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D926834BAB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:17:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 88B14DFDE2;
        Thu,  9 Jun 2022 04:17:25 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AdmpqNhmYmWs; Thu,  9 Jun 2022 04:17:24 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1654773444; bh=304FzTc7kUGpYL6mGifeAk9dzSjFz6UXTYRUkbSJLYM=;
        h=From:To:Cc:Subject:Date:From;
        b=bwfPRCPyEtBLaKFBANzW1EfITBel1MbMTpIqxVevsDRz8FlsIzEOTdP3777X5jOgo
         Q7OJKXJ+A0k7gziDsfYO1kWfeNf9dMcfHfY6OplonoyGXYL9cEdttyy0gTRCt9521M
         QdsJO9OPaMkZUDiDx7ef8cIiAVJj3Zrj+Y7GQKcqLneiKpRyy6FDH/oPXBzAifWC+S
         CoXXLEzCKY5lLt8ims7du21LbPJvrTxCiqmsVN8DKTNIQSYAXiD6qoTRso8G3cw9XJ
         nHa2cN0bb0cWC7qI5Ck5iYVN0CbAnRVMa0isab5C2SL1STX0s7BXdirnP1rN1o0vqG
         G9qUsc7uTAeEQ==
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, kernel@puri.sm, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2] soc: imx: gpcv2: print errno for regulator errors
Date:   Thu,  9 Jun 2022 13:17:07 +0200
Message-Id: <20220609111707.2216036-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make debugging of power management issues easier by printing the reason
why a regulator fails to be enabled or disabled.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

revision history
----------------
v2: (thank you Ahmad)
 * use %pe format
 * sent out a bit early because it's pretty obvious
v1:
https://lore.kernel.org/linux-arm-kernel/64828809-1eb7-dff3-da57-95b545aefc22@pengutronix.de/T/#t


 drivers/soc/imx/gpcv2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 85aa86e1338a..6383a4edc360 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -328,7 +328,9 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 	if (!IS_ERR(domain->regulator)) {
 		ret = regulator_enable(domain->regulator);
 		if (ret) {
-			dev_err(domain->dev, "failed to enable regulator\n");
+			dev_err(domain->dev,
+				"failed to enable regulator: %pe\n",
+				ERR_PTR(ret));
 			goto out_put_pm;
 		}
 	}
@@ -467,7 +469,9 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 	if (!IS_ERR(domain->regulator)) {
 		ret = regulator_disable(domain->regulator);
 		if (ret) {
-			dev_err(domain->dev, "failed to disable regulator\n");
+			dev_err(domain->dev,
+				"failed to disable regulator: %pe\n",
+				ERR_PTR(ret));
 			return ret;
 		}
 	}
-- 
2.30.2

