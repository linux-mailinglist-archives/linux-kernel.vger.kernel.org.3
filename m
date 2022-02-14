Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9BF4B45DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbiBNJ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:29:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243147AbiBNJ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:29:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665B560D81
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:28:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so11985689wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KStTxY9XVfRTy0jNX2vsLO+sccZ6tcP3+MXbZKzhUog=;
        b=RRmTvdH206P9cFagseNai5Qkh/Y3gvxhEZYcItRUx3Z9rEGdbrrj8+RMSJBQMDQ6Ti
         /KIXUPdzytBTQ0ksw/z3Qy94t1bAcG+ahCZXsO5wv9qTuL6ocOaX36x2KxnoYqtfHLdE
         nFbBnJLi7GqAsDtg8KQ+jO0zGiDqzGuWjOsar7FHjFlqRu68oHIVacm6iRybNRxOjlTl
         Qws1U8zaHo6hRAFlR2mkexqUTohqw7KSmEu/U0A0tn4DOBw/2YdbewEFZPnm+YTTOocr
         Wb13phnqsbITLtgPk2htUT1bTW3fTdqeyiUuqExmM68oWDlGVOFyFj6r2o+jO7ofAevM
         SIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KStTxY9XVfRTy0jNX2vsLO+sccZ6tcP3+MXbZKzhUog=;
        b=quo+OAGwTzK5dWYeAdQlSl7ZNM17MjsitX1oZ+3twGWKCt6al7K/GczVz5HtVfzPm4
         0EbAJdjZIA9dicWc4cBzz9cvXH+qyF8L2NCn93ZbT1JHiv8HcIKzVK9FTSUzpeTeikkr
         SJ4ldLr+bW6OovPrR+kI85CzU7+u+3w7SBtZMCirrthxaM5jby2BzfaDwT1ZDp3K1cUy
         rImp/2AbG0dJ8yqkV2uDjJ164+S8KY+qtIj4QjMTae+6UA2tdIRVeVijEuwqOtvV+QQv
         IeGBPDhY1EE3X4jPi5wISSYm0idFByAityMwcdPSSPVhGz8KnEY4NsO9RaDgNPQoHWig
         WnXQ==
X-Gm-Message-State: AOAM533c3R0OOADVnPi9+X1yPARy9G0bUjbphwvBJvUI6vikSZ7Ow9rw
        rOYXq2JxNy/JzCZOToLdkZli7A==
X-Google-Smtp-Source: ABdhPJyGQ/UgchooSSeFiGSP/VpjbWioBhy23eoI5rS7fHkwylzEihvSntyQAg6+0NSZa+CRPy+XjA==
X-Received: by 2002:adf:fe01:: with SMTP id n1mr10579723wrr.141.1644830935927;
        Mon, 14 Feb 2022 01:28:55 -0800 (PST)
Received: from localhost.localdomain (179.160.117.78.rev.sfr.net. [78.117.160.179])
        by smtp.gmail.com with ESMTPSA id o14sm11182012wmr.3.2022.02.14.01.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 01:28:55 -0800 (PST)
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
Subject: [PATCH v4] drm/mediatek: allow commands to be sent during video mode
Date:   Mon, 14 Feb 2022 10:27:42 +0100
Message-Id: <20220214092742.3461587-1-jstephan@baylibre.com>
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
Changes in v4:
    - fix missing space:  "ret : recv_cnt;"
Changes in v3:
    - increase readability of code and use correct return variable (see
      comment
https://lore.kernel.org/linux-mediatek/4907bdc1-b4a6-e9ad-5cfa-266fc20c0bec@collabora.com/)

Changes in v2:
    - update commit message to be more descriptive

 drivers/gpu/drm/mediatek/mtk_dsi.c | 33 ++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 5d90d2eb0019..abdd9cdebd86 100644
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
+	return ret < 0 ? ret : recv_cnt;
 }

 static const struct mipi_dsi_host_ops mtk_dsi_ops = {
--
2.35.1

