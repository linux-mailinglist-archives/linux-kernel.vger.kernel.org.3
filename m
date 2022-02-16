Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1304B7CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbiBPBlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:41:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245577AbiBPBks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:40:48 -0500
Received: from mail-m17640.qiye.163.com (mail-m17640.qiye.163.com [59.111.176.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98FF237CA;
        Tue, 15 Feb 2022 17:40:37 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id ADA055402AF;
        Wed, 16 Feb 2022 09:40:35 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengfei Xu <xsf@rock-chips.com>,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v3 5/6] spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops
Date:   Wed, 16 Feb 2022 09:40:27 +0800
Message-Id: <20220216014028.8123-6-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216014028.8123-1-jon.lin@rock-chips.com>
References: <20220216014028.8123-1-jon.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlCSUpWQhkeTRkfQk5CSE
        JMVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxA6FDo6DD5PNBYjLg8TGRQj
        OBhPCxhVSlVKTU9PQkxOTUhNSU9DVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFISUlDNwY+
X-HM-Tid: 0a7f00303e18d995kuwsada055402af
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: shengfei Xu <xsf@rock-chips.com>

the wakeup interrupt handler which is guaranteed not to run while
@resume noirq() is being executed. the patch can help to avoid the
wakeup source try to access spi when the spi is in suspend mode.

Signed-off-by: shengfei Xu <xsf@rock-chips.com>
Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None
Changes in v1: None

 drivers/spi/spi-rockchip.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 83da8fdb3c02..8b4d56ee2193 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -964,14 +964,14 @@ static int rockchip_spi_suspend(struct device *dev)
 {
 	int ret;
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	ret = spi_controller_suspend(ctlr);
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_force_suspend(dev);
-	if (ret < 0)
-		return ret;
+	clk_disable_unprepare(rs->spiclk);
+	clk_disable_unprepare(rs->apb_pclk);
 
 	pinctrl_pm_select_sleep_state(dev);
 
@@ -986,10 +986,14 @@ static int rockchip_spi_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = pm_runtime_force_resume(dev);
+	ret = clk_prepare_enable(rs->apb_pclk);
 	if (ret < 0)
 		return ret;
 
+	ret = clk_prepare_enable(rs->spiclk);
+	if (ret < 0)
+		clk_disable_unprepare(rs->apb_pclk);
+
 	ret = spi_controller_resume(ctlr);
 	if (ret < 0) {
 		clk_disable_unprepare(rs->spiclk);
@@ -1031,7 +1035,7 @@ static int rockchip_spi_runtime_resume(struct device *dev)
 #endif /* CONFIG_PM */
 
 static const struct dev_pm_ops rockchip_spi_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(rockchip_spi_suspend, rockchip_spi_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_spi_suspend, rockchip_spi_resume)
 	SET_RUNTIME_PM_OPS(rockchip_spi_runtime_suspend,
 			   rockchip_spi_runtime_resume, NULL)
 };
-- 
2.17.1

