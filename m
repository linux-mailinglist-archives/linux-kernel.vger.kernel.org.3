Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8E24B0DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241697AbiBJMrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:47:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240903AbiBJMrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:47:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817F7FC7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:47:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v129so3369510wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mntgPn8Qh+Nga93zR2phIa+qhcyXEPyRC4rw0pc7QyU=;
        b=CBWimZf5de7rEjmsIbxW3CkZ60rLERED1BkV9KD7RlFFX1/jSQ0iQujTrsjEqdyatc
         TGucGngeS0HAEfQdmLnuUU9bJYzv7aeAxdxRp3pVk2sfsjvLg+iqX9DDb7KH3YkypUJr
         oJgdm4QB/zazezXnNWw/2NGivfLqUJ5hD+6MHG8JsjA+SxJ9CZZRttVTo/z9Mof1cyDX
         /tUdxtb5mjbVUUppHuRWzxdARUE+sWUAOKJFgjgi4D1pZaWfhTpLSQTEOGp27Oc3ss6c
         8CHO5LzVKWymSWP06deo8tlSVJQO21bHmYgdFZIUwRtYgm0Rwc0ivlRgKF7Cwc1wjRKH
         lA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mntgPn8Qh+Nga93zR2phIa+qhcyXEPyRC4rw0pc7QyU=;
        b=XNFGFLqF3PxdOmNib50wHLFShC+76eIIZexOhYqwXSBkUCVsLIkq8q8MfjEoJTXWDt
         FtF8vHx/TPqJH+ZN2JIKpj6MNdxIFpKa6tjFpur+Lm3mnx7NicYQOUVoBbMAPo6pQVbT
         rpqernTga93Rg+xwcK68igfZObYx99NzO9yrAawAbNqAQG1anuTELieV46HcZQRQz14A
         xtPhSL7TGoLdZy1wna74DmLjORX0OuC4XrW+s6gVI1WLgXdSf9Fgn3J3rCznu54OtaRx
         JMwSdo+9Z0GXJMvcdLdB/kosqlAnWPVKPNVoTWTXjboenUi0Q1cR9r8azWjSEPTQtcVA
         dknA==
X-Gm-Message-State: AOAM530noQ6i2Xt1dTkCliQa+nFwFFMYE3+fvQPS0x1YszlzY9s28AjK
        XbWJgOq0JPx/nHbUSLNtmMeyBw==
X-Google-Smtp-Source: ABdhPJx1QVGMDH3bSUlRi8xCAZYjMCX58cJhV8Nzi0bBPvuN8l8LEJFyXhAp8Uy4QXE2zk+rqIBFWQ==
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr2050270wmh.67.1644497270112;
        Thu, 10 Feb 2022 04:47:50 -0800 (PST)
Received: from localhost.localdomain (179.160.117.78.rev.sfr.net. [78.117.160.179])
        by smtp.gmail.com with ESMTPSA id 24sm1331687wmf.48.2022.02.10.04.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 04:47:49 -0800 (PST)
From:   Julien STEPHAN <jstephan@baylibre.com>
To:     ck.hu@mediatek.com
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
Subject: [PATCH v2] drm/mediatek: allow commands to be sent during video mode
Date:   Thu, 10 Feb 2022 13:46:38 +0100
Message-Id: <20220210124638.2330904-1-jstephan@baylibre.com>
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
Changes in v2:
  - update commit message to be more descriptive

 drivers/gpu/drm/mediatek/mtk_dsi.c | 34 ++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 5d90d2eb0019..7d66fdc7f81d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -891,24 +891,34 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 	u8 read_data[16];
 	void *src_addr;
 	u8 irq_flag = CMD_DONE_INT_FLAG;
-
-	if (readl(dsi->regs + DSI_MODE_CTRL) & MODE) {
-		DRM_ERROR("dsi engine is not command mode\n");
-		return -EINVAL;
+	u32 dsi_mode;
+
+	dsi_mode = readl(dsi->regs + DSI_MODE_CTRL);
+	if (dsi_mode & MODE) {
+		mtk_dsi_stop(dsi);
+		if (mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500)) {
+			recv_cnt = -EINVAL;
+			goto restore_dsi_mode;
+		}
 	}
 
 	if (MTK_DSI_HOST_IS_READ(msg->type))
 		irq_flag |= LPRX_RD_RDY_INT_FLAG;
 
-	if (mtk_dsi_host_send_cmd(dsi, msg, irq_flag) < 0)
-		return -ETIME;
+	if (mtk_dsi_host_send_cmd(dsi, msg, irq_flag) < 0) {
+		recv_cnt = -ETIME;
+		goto restore_dsi_mode;
+	}
 
-	if (!MTK_DSI_HOST_IS_READ(msg->type))
-		return 0;
+	if (!MTK_DSI_HOST_IS_READ(msg->type)) {
+		recv_cnt = 0;
+		goto restore_dsi_mode;
+	}
 
 	if (!msg->rx_buf) {
 		DRM_ERROR("dsi receive buffer size may be NULL\n");
-		return -EINVAL;
+		recv_cnt = -EINVAL;
+		goto restore_dsi_mode;
 	}
 
 	for (i = 0; i < 16; i++)
@@ -933,6 +943,12 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 	DRM_INFO("dsi get %d byte data from the panel address(0x%x)\n",
 		 recv_cnt, *((u8 *)(msg->tx_buf)));
 
+restore_dsi_mode:
+	if (dsi_mode & MODE) {
+		mtk_dsi_set_mode(dsi);
+		mtk_dsi_start(dsi);
+	}
+
 	return recv_cnt;
 }
 
-- 
2.35.1

