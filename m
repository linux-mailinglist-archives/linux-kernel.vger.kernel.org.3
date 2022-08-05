Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796A458B24D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 00:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbiHEWCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 18:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241632AbiHEWCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 18:02:38 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A5160F0
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 15:02:36 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id K5OrodtROkootK5Oroved1; Sat, 06 Aug 2022 00:02:35 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 00:02:35 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mathieu Poirier <mathieu.poirer@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] remoteproc: imx_rproc: Simplify some error message
Date:   Sat,  6 Aug 2022 00:02:32 +0200
Message-Id: <6b9343c2688117a340661d8ee491c2962c54a09a.1659736936.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() already prints the error code in a human readable way, so
there is no need to duplicate it as a numerical value at the end of the
message.

While at it, remove 'ret' that is mostly useless.

Fixes: 2df7062002d0 ("remoteproc: imx_proc: enable virtio/mailbox")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/remoteproc/imx_rproc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 38383e7de3c1..7cc4fd207e2d 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -646,7 +646,6 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
 	struct imx_rproc *priv = rproc->priv;
 	struct device *dev = priv->dev;
 	struct mbox_client *cl;
-	int ret;
 
 	if (!of_get_property(dev->of_node, "mbox-names", NULL))
 		return 0;
@@ -659,18 +658,15 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
 	cl->rx_callback = imx_rproc_rx_callback;
 
 	priv->tx_ch = mbox_request_channel_byname(cl, "tx");
-	if (IS_ERR(priv->tx_ch)) {
-		ret = PTR_ERR(priv->tx_ch);
-		return dev_err_probe(cl->dev, ret,
-				     "failed to request tx mailbox channel: %d\n", ret);
-	}
+	if (IS_ERR(priv->tx_ch))
+		return dev_err_probe(cl->dev, PTR_ERR(priv->tx_ch),
+				     "failed to request tx mailbox channel\n");
 
 	priv->rx_ch = mbox_request_channel_byname(cl, "rx");
 	if (IS_ERR(priv->rx_ch)) {
 		mbox_free_channel(priv->tx_ch);
-		ret = PTR_ERR(priv->rx_ch);
-		return dev_err_probe(cl->dev, ret,
-				     "failed to request rx mailbox channel: %d\n", ret);
+		return dev_err_probe(cl->dev, PTR_ERR(priv->rx_ch),
+				     "failed to request rx mailbox channel\n");
 	}
 
 	return 0;
-- 
2.34.1

