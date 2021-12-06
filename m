Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9534469690
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbhLFNRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:17:21 -0500
Received: from comms.puri.sm ([159.203.221.185]:48106 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244140AbhLFNRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:17:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9982FDFF4B;
        Mon,  6 Dec 2021 05:13:21 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3Y2dsPfrnCov; Mon,  6 Dec 2021 05:13:21 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 2/2] media: imx: imx8mq-mipi-csi2: remove wrong irq config write operation
Date:   Mon,  6 Dec 2021 14:12:42 +0100
Message-Id: <20211206131242.2697464-3-martin.kepplinger@puri.sm>
In-Reply-To: <20211206131242.2697464-1-martin.kepplinger@puri.sm>
References: <20211206131242.2697464-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The place where this register writel() that masks one interrupt is placed
does not guarantee that the device is powered so that's not allowed. Moreover
imx8mq_mipi_csi_start_stream() masks the interrupt anyway so the
write is not even needed. Remove it as this is a mistake that slipped in
with the driver.

Fixes: f33fd8d77dd0 ("media: imx: add a driver for i.MX8MQ mipi csi rx phy and controller")
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/staging/media/imx/imx8mq-mipi-csi2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
index 31a1e43733a0..776a00eed550 100644
--- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
@@ -398,9 +398,6 @@ static int imx8mq_mipi_csi_s_stream(struct v4l2_subdev *sd, int enable)
 	struct csi_state *state = mipi_sd_to_csi2_state(sd);
 	int ret = 0;
 
-	imx8mq_mipi_csi_write(state, CSI2RX_IRQ_MASK,
-			      CSI2RX_IRQ_MASK_ULPS_STATUS_CHANGE);
-
 	if (enable) {
 		ret = pm_runtime_resume_and_get(state->dev);
 		if (ret < 0)
-- 
2.30.2

