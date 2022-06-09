Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0925447E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiFIJp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiFIJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:45:25 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EFB50B14
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:45:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 703BFDFDD0;
        Thu,  9 Jun 2022 02:45:23 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KnrSODr8z27T; Thu,  9 Jun 2022 02:45:22 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1654767922; bh=13VRg4Lwk4+BEnm3SUM2cb0pYq53kKrwUDqrt4YlzQc=;
        h=From:To:Cc:Subject:Date:From;
        b=V9/MIKvNERmqtpSd5O4VRXuaCcwmEMjmDBxKaLvBGLG7nbWDxpahnGafIQcn2XF9K
         pxSwLPVxwZmqgUCV2eNHTmhDCGtGrzV4kSgEeU52EUlshc0JtoMnO8fim+PW5fcgDQ
         GzCjnEmNawpU6VUUx/pGgTz2MFMJJrRzzmHQWJGhnBULWeJmItGsyQrEuAsjUSG+Z5
         WwKFxdasmbbMYweNJHiaL6lDIaFxevPb3RDGE4unaN4jNg400e6G7vXnN3hSRfd01E
         9J9HW2LQuCCCehgah9orN5uxPsKa/GSTKGs/3caNnG8CWVLerxOm0eyhblGePQpX2l
         X2RF9MxOKC7cg==
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, kernel@puri.sm, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] soc: imx: gpcv2: print errno for regulator errors
Date:   Thu,  9 Jun 2022 11:44:53 +0200
Message-Id: <20220609094453.2120099-1-martin.kepplinger@puri.sm>
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
 drivers/soc/imx/gpcv2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 3cb123016b3e..311507a815c5 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -233,7 +233,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 	if (!IS_ERR(domain->regulator)) {
 		ret = regulator_enable(domain->regulator);
 		if (ret) {
-			dev_err(domain->dev, "failed to enable regulator\n");
+			dev_err(domain->dev, "failed to enable regulator: %d\n",
+				ret);
 			goto out_put_pm;
 		}
 	}
@@ -372,7 +373,8 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 	if (!IS_ERR(domain->regulator)) {
 		ret = regulator_disable(domain->regulator);
 		if (ret) {
-			dev_err(domain->dev, "failed to disable regulator\n");
+			dev_err(domain->dev,
+				"failed to disable regulator: %d\n", ret);
 			return ret;
 		}
 	}
-- 
2.30.2

