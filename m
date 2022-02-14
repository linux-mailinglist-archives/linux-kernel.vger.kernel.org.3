Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159684B44DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbiBNItF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:49:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242425AbiBNItB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:49:01 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC62D5F8F3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:48:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d27so25561710wrc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDE2yNU8P4fdqNYbBxxI65OvUTBCmdeIAAj2LgzPKAs=;
        b=IbonyEV+9C8urgFscwP5SMpYJpuDdalopVZGuNmDcbOwE9H1M2gOG/T9JIe5n6zRfr
         gLeUe/kNbG05x3kGzKQl3tY2DUYimObTU0eFumzwlPdM/efcUmq8pQ8y30qYimDuQoHX
         l9AQMBqziiDy0cHCLrAqr5+O8aBiLcsGDZv9nv09B6wyPSYba3OaH05P9t3Z8ZQSAf5M
         nAiNLn0/lthA91A3AiMODe4afZk+GRyvjM5f16ipS8S9z5+abCM9d1slFnciY5kr7fxz
         cvY9aO09VsLyeeGVSrFww1O4EcX5untTiJaYwWDPDWaH16rCt3wViM95+wkVYDmBNPmw
         qtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDE2yNU8P4fdqNYbBxxI65OvUTBCmdeIAAj2LgzPKAs=;
        b=YX4mqz4p7o0XsZUyr2rSeRi4GrVZj2VzKzvVtvpUzvcfDMpQjMAyvIf8pX2gJecLp4
         0Y2721Ncb0wS20sbLhzt8Ekdh7+XcY+Ei265QKvNMeMPWhaYUkl9sdiONK3lhDQKvwB4
         j8TzQXdqWg+U881/X46fEJ2kUKZBmY0G5PM6ebERIUPynJGcnlHVnQ9ZjIrLEfTY3IBp
         WmRBRd909OaXISh8uxJJH/FKrnI4qLrIUMdZqTBQYQkFsRiIbmkUOSdkFeuNE+frxabs
         0n8HyFOyEvTO3YzVC7TTpgMfqe7VuRLxcnPevJS4iWNLLRGRyeVkndYltuC9MeuY0KOL
         0lNw==
X-Gm-Message-State: AOAM533BL3c4dA4p/P64DOHFE/LtIlTs1u3OBaE287s2flzBv8CaLIyu
        pbixlrttEH9gQ9hpSKM3x7Vqfonn4lLRbg==
X-Google-Smtp-Source: ABdhPJyzL++bK8rE9MHyjyMK5tAC+ty5zZCR7BnVxJXu2kuykUHnUrWNsGeRiBmI+OFT7STG1OHTww==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr10275152wrr.168.1644828531216;
        Mon, 14 Feb 2022 00:48:51 -0800 (PST)
Received: from localhost.localdomain (179.160.117.78.rev.sfr.net. [78.117.160.179])
        by smtp.gmail.com with ESMTPSA id f8sm7189992wmq.19.2022.02.14.00.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:48:50 -0800 (PST)
From:   Julien STEPHAN <jstephan@baylibre.com>
To:     angelogioacchino.delregno@collabora.com
Cc:     Julien STEPHAN <jstephan@baylibre.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR MEDIATEK),
        linux-mediatek@lists.infradead.org (moderated list:DRM DRIVERS FOR
        MEDIATEK),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] drm/mediatek: allow commands to be sent during video mode
Date:   Mon, 14 Feb 2022 09:47:36 +0100
Message-Id: <20220214084736.3374211-1-jstephan@baylibre.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mipi dsi panel drivers can use mipi_dsi_dcs_{set,get}_display_brightness()
to request backlight changes.

This can be done during panel initialization (dsi is in command mode)
or afterwards (dsi is in Video Mode).

When the DSI is in Video Mode, all commands are rejected.

Detect current DSI mode in mtk_dsi_host_transfer() and switch modes
temporarily to allow commands to be sent.

Signed-off-by: Julien STEPHAN <jstephan@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Changes in v3:
    - increase readability of code and use correct return variable (see
      comment https://lore.kernel.org/linux-mediatek/4907bdc1-b4a6-e9ad-5cfa-266fc20c0bec@collabora.com/)

Changes in v2:
    - update commit message to be more descriptive


 drivers/gpu/drm/mediatek/mtk_dsi.c | 33 ++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 5d90d2eb0019..7f1b2b7ed3fd 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -891,24 +891,33 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 	u8 read_data[16];
 	void *src_addr;
 	u8 irq_flag = CMD_DONE_INT_FLAG;
+	u32 dsi_mode;
+	int ret;

-	if (readl(dsi->regs + DSI_MODE_CTRL) & MODE) {
-		DRM_ERROR("dsi engine is not command mode\n");
-		return -EINVAL;
+	dsi_mode = readl(dsi->regs + DSI_MODE_CTRL);
+	if (dsi_mode & MODE) {
+		mtk_dsi_stop(dsi);
+		ret = mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500);
+		if (ret)
+			goto restore_dsi_mode;
 	}

 	if (MTK_DSI_HOST_IS_READ(msg->type))
 		irq_flag |= LPRX_RD_RDY_INT_FLAG;

-	if (mtk_dsi_host_send_cmd(dsi, msg, irq_flag) < 0)
-		return -ETIME;
+	ret = mtk_dsi_host_send_cmd(dsi, msg, irq_flag);
+	if (ret)
+		goto restore_dsi_mode;

-	if (!MTK_DSI_HOST_IS_READ(msg->type))
-		return 0;
+	if (!MTK_DSI_HOST_IS_READ(msg->type)) {
+		recv_cnt = 0;
+		goto restore_dsi_mode;
+	}

 	if (!msg->rx_buf) {
 		DRM_ERROR("dsi receive buffer size may be NULL\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto restore_dsi_mode;
 	}

 	for (i = 0; i < 16; i++)
@@ -933,7 +942,13 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 	DRM_INFO("dsi get %d byte data from the panel address(0x%x)\n",
 		 recv_cnt, *((u8 *)(msg->tx_buf)));

-	return recv_cnt;
+restore_dsi_mode:
+	if (dsi_mode & MODE) {
+		mtk_dsi_set_mode(dsi);
+		mtk_dsi_start(dsi);
+	}
+
+	return ret < 0 ? ret: recv_cnt;
 }

 static const struct mipi_dsi_host_ops mtk_dsi_ops = {
--
2.35.1

