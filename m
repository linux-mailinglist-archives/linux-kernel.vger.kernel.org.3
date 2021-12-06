Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5519846968E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244151AbhLFNRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:17:18 -0500
Received: from comms.puri.sm ([159.203.221.185]:48098 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244073AbhLFNRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:17:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 97658DF539;
        Mon,  6 Dec 2021 05:13:18 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QP9B0PAlJ5sC; Mon,  6 Dec 2021 05:13:18 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 1/2] media: imx: imx8mq-mipi-csi2: fix system resume issue
Date:   Mon,  6 Dec 2021 14:12:41 +0100
Message-Id: <20211206131242.2697464-2-martin.kepplinger@puri.sm>
In-Reply-To: <20211206131242.2697464-1-martin.kepplinger@puri.sm>
References: <20211206131242.2697464-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

during system resume, interconnect bandwidth would be requested even
though the device is runtime suspended. This leaves the system in an
unbalanced state. Fix that by checking the state before.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/staging/media/imx/imx8mq-mipi-csi2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
index 7adbdd14daa9..31a1e43733a0 100644
--- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
@@ -714,6 +714,9 @@ static int imx8mq_mipi_csi_pm_suspend(struct device *dev, bool runtime)
 
 	mutex_unlock(&state->lock);
 
+	if (!runtime && pm_runtime_suspended(state->dev))
+		return 0;
+
 	ret = icc_set_bw(state->icc_path, 0, 0);
 	if (ret)
 		dev_err(dev, "icc_set_bw failed with %d\n", ret);
@@ -727,6 +730,9 @@ static int imx8mq_mipi_csi_pm_resume(struct device *dev, bool runtime)
 	struct csi_state *state = mipi_sd_to_csi2_state(sd);
 	int ret = 0;
 
+	if (!runtime && pm_runtime_suspended(state->dev))
+		return 0;
+
 	ret = icc_set_bw(state->icc_path, 0, state->icc_path_bw);
 	if (ret) {
 		dev_err(dev, "icc_set_bw failed with %d\n", ret);
-- 
2.30.2

