Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56E049FAEA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349004AbiA1NiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245248AbiA1NiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:38:20 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FA9C061714;
        Fri, 28 Jan 2022 05:38:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 6B9981F459D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643377099;
        bh=tjEk8d0FDgHsxlcZ3Ake1MkPBeCUhxnRcVA14+aoN30=;
        h=From:To:Cc:Subject:Date:From;
        b=d9lQkqYsjK6BwmwbxdMHe3LfiS7qUPiwGC6pD2+LSsYvTtEWivRtbDbBCcCfYqYvL
         kqjHwe7IuAtqzqf9QbP2T8naH351qtq6RBM8vWCvRyuByo4EzC3vZEiFS81xKpUYpU
         RnaTewMPNjKPKEFQhKiFnv+50oz3FMefbFtEt0yEJFd2X2o1B+ADjOjJf/vdyDOLby
         t19SBvaHO2dMeSwkPyrxRCnD4ruZDvAoBPKB4BCzd9HfszerxidPbkqUjmeb5JNDfo
         ZFOApVnJcpOetTB4bIgMTn0+5rGM+kWc2MR0jm2+emn0K705vwG9svpzfU78263kJx
         0D0G+BgWCIIrQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: imx: imx8mq-mipi_csi2: Remove unneeded code
Date:   Fri, 28 Jan 2022 18:36:49 +0500
Message-Id: <20220128133649.1393201-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret is constant in imx8mq_mipi_csi_pm_suspend(). This function cannot
return error. Remove the return variable. Simplify other functions which
are using this function.

Fixes: f0c2ba1ed4ad ("media: imx: imx8mq-mipi_csi2: fix system resume")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/staging/media/imx/imx8mq-mipi-csi2.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
index 3b9fa75efac6b..c992b845e63d1 100644
--- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
@@ -693,11 +693,10 @@ static int imx8mq_mipi_csi_async_register(struct csi_state *state)
  * Suspend/resume
  */
 
-static int imx8mq_mipi_csi_pm_suspend(struct device *dev)
+static void imx8mq_mipi_csi_pm_suspend(struct device *dev)
 {
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct csi_state *state = mipi_sd_to_csi2_state(sd);
-	int ret = 0;
 
 	mutex_lock(&state->lock);
 
@@ -708,8 +707,6 @@ static int imx8mq_mipi_csi_pm_suspend(struct device *dev)
 	}
 
 	mutex_unlock(&state->lock);
-
-	return ret ? -EAGAIN : 0;
 }
 
 static int imx8mq_mipi_csi_pm_resume(struct device *dev)
@@ -742,15 +739,12 @@ static int __maybe_unused imx8mq_mipi_csi_suspend(struct device *dev)
 {
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct csi_state *state = mipi_sd_to_csi2_state(sd);
-	int ret;
 
-	ret = imx8mq_mipi_csi_pm_suspend(dev);
-	if (ret)
-		return ret;
+	imx8mq_mipi_csi_pm_suspend(dev);
 
 	state->state |= ST_SUSPENDED;
 
-	return ret;
+	return 0;
 }
 
 static int __maybe_unused imx8mq_mipi_csi_resume(struct device *dev)
@@ -770,9 +764,7 @@ static int __maybe_unused imx8mq_mipi_csi_runtime_suspend(struct device *dev)
 	struct csi_state *state = mipi_sd_to_csi2_state(sd);
 	int ret;
 
-	ret = imx8mq_mipi_csi_pm_suspend(dev);
-	if (ret)
-		return ret;
+	imx8mq_mipi_csi_pm_suspend(dev);
 
 	ret = icc_set_bw(state->icc_path, 0, 0);
 	if (ret)
-- 
2.30.2

