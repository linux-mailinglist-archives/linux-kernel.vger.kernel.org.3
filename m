Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79714F5E32
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiDFMjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiDFMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:38:14 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337B85A1143
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:40:29 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DB4771A1E84;
        Wed,  6 Apr 2022 10:40:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 914A81A1784;
        Wed,  6 Apr 2022 10:40:11 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AE8E8183AC4F;
        Wed,  6 Apr 2022 16:40:09 +0800 (+08)
From:   Sandor.yu@nxp.com
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com
Cc:     Sandor.yu@nxp.com, shengjiu.wang@nxp.com, cai.huoqing@linux.dev,
        maxime@cerno.tech, harry.wentland@amd.com,
        hverkuil-cisco@xs4all.nl, amuel@sholland.org
Subject: [PATCH v1 1/5] drm: bridge: dw_hdmi: cec: Add cec suspend/resume function
Date:   Wed,  6 Apr 2022 16:48:33 +0800
Message-Id: <27380b83a1b17419a35a13e29a86a1989204d1c3.1649230434.git.Sandor.yu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1649230434.git.Sandor.yu@nxp.com>
References: <cover.1649230434.git.Sandor.yu@nxp.com>
In-Reply-To: <cover.1649230434.git.Sandor.yu@nxp.com>
References: <cover.1649230434.git.Sandor.yu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandor Yu <Sandor.yu@nxp.com>

CEC interrupt status/mask and logical address registers
will be reset when device enter suspend.
It will cause cec fail to work after device resume.
Add CEC suspend/resume functions, save these registers status
when suspend and restore them when resume.

Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
index c8f44bcb298a..ceb619b32fde 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
@@ -18,6 +18,8 @@
 
 #include "dw-hdmi-cec.h"
 
+static u8 cec_saved_regs[5];
+
 enum {
 	HDMI_IH_CEC_STAT0	= 0x0106,
 	HDMI_IH_MUTE_CEC_STAT0	= 0x0186,
@@ -306,11 +308,44 @@ static int dw_hdmi_cec_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused dw_hdmi_cec_resume(struct device *dev)
+{
+	struct dw_hdmi_cec *cec = dev_get_drvdata(dev);
+
+	/* Restore logical address and interrupt status/mask register */
+	dw_hdmi_write(cec, cec_saved_regs[0], HDMI_CEC_ADDR_L);
+	dw_hdmi_write(cec, cec_saved_regs[1], HDMI_CEC_ADDR_H);
+	dw_hdmi_write(cec, cec_saved_regs[2], HDMI_CEC_POLARITY);
+	dw_hdmi_write(cec, cec_saved_regs[3], HDMI_CEC_MASK);
+	dw_hdmi_write(cec, cec_saved_regs[4], HDMI_IH_MUTE_CEC_STAT0);
+
+	return 0;
+}
+
+static int __maybe_unused dw_hdmi_cec_suspend(struct device *dev)
+{
+	struct dw_hdmi_cec *cec = dev_get_drvdata(dev);
+
+	/* store logical address and interrupt status/mask register */
+	cec_saved_regs[0] = dw_hdmi_read(cec, HDMI_CEC_ADDR_L);
+	cec_saved_regs[1] = dw_hdmi_read(cec, HDMI_CEC_ADDR_H);
+	cec_saved_regs[2] = dw_hdmi_read(cec, HDMI_CEC_POLARITY);
+	cec_saved_regs[3] = dw_hdmi_read(cec, HDMI_CEC_MASK);
+	cec_saved_regs[4] = dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT0);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dw_hdmi_cec_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(dw_hdmi_cec_suspend, dw_hdmi_cec_resume)
+};
+
 static struct platform_driver dw_hdmi_cec_driver = {
 	.probe	= dw_hdmi_cec_probe,
 	.remove	= dw_hdmi_cec_remove,
 	.driver = {
 		.name = "dw-hdmi-cec",
+		.pm = &dw_hdmi_cec_pm,
 	},
 };
 module_platform_driver(dw_hdmi_cec_driver);
-- 
2.25.1

