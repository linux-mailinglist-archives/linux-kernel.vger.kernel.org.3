Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A65471AA8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 15:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhLLOWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 09:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhLLOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 09:22:32 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0FEC061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 06:22:32 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v19so9438028plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 06:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZWrvl8F+5ZsZqqN1/f2CJOo+5n6LcVWRAabb8RZsrIY=;
        b=eGgJyxTzHAZ68924wqTozbqQkO7+kdcouG86WxzM2zKxAzzHtk6ibtz7IUyXaGoZNi
         GHQJJLE/qxW6OVtD6C3kRN1yzKhJ4niGziNW+0sz30j1MJ4dQemOZcVjLtG5qqkYgED8
         z3egKzAir1dLekkw/LeJZrnz0VgCMiHHGwiI2dONGv2CeVuZyLF1AJG8km8RHS0B2kdM
         vj4BBVpVyb+uRdJ3Vvq/rgykC+0dTU2cn2JcVw3UdHmJ8lJOZpTa4lX1tTwiPGqEQO85
         xseBQKSKDkwKKHNvRID0R4s3nl8H2HWNOMHuw9Ciwjo5jJNLeZGcFviWRHgJWSed09ZH
         8pAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZWrvl8F+5ZsZqqN1/f2CJOo+5n6LcVWRAabb8RZsrIY=;
        b=MgoYHk/FO8h3+TXYYO4gdmP3BtcltiPHJ73bSVmr+iC+CNWuQQSps8RIelSfKZ0t0K
         /Y9+0Uiy7TL+g8XEgJ6R3xVKXvbnonhCCLDME3rJHo1JJlbbYU4WYnscXT19jgUiXIkf
         BQp8hO1J2P/tPC1IWOBrlTXmCSocSZQUnzOxuVUg9Q5y20vuiOCzb3LB4BshQEovGrJp
         9RygzP1iKGmHgeXDF7nnG3ByDV5iAjZp+SwN+BrwkFbQ2oQRqEaRxFcbGAFoyekTUVSp
         SH/JWAy874VqkcmdT6Hln/fK1odqlrmodqeJyUOFEgxf/sjxVI2AYkHJc8n3vhpPrXmk
         G+Ug==
X-Gm-Message-State: AOAM531kZYwXCkoVGD70iQfB/c5q2FioB9OpJMLN86fkk61wKML1RImQ
        GF6zzjq+qGEvaFzZ7gTn070=
X-Google-Smtp-Source: ABdhPJz/4LNqrQx02YorlMGDlqCE2XkkIuzbZvDKDHVytuJtqywQlPeE4YGlaHCq1lQkqRSNSl01zQ==
X-Received: by 2002:a17:90b:1c87:: with SMTP id oo7mr37033855pjb.159.1639318951549;
        Sun, 12 Dec 2021 06:22:31 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id x3sm178091pgl.79.2021.12.12.06.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 06:22:31 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: ti: Use IS_ERR_OR_NULL() to clean code
Date:   Sun, 12 Dec 2021 14:22:21 +0000
Message-Id: <20211212142226.23674-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_ERR_OR_NULL() to make the code cleaner.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/ti/phy-omap-control.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-omap-control.c b/drivers/phy/ti/phy-omap-control.c
index 47482f106fab..76c5595f0859 100644
--- a/drivers/phy/ti/phy-omap-control.c
+++ b/drivers/phy/ti/phy-omap-control.c
@@ -26,7 +26,7 @@ void omap_control_pcie_pcs(struct device *dev, u8 delay)
 	u32 val;
 	struct omap_control_phy	*control_phy;
 
-	if (IS_ERR(dev) || !dev) {
+	if (IS_ERR_OR_NULL(dev)) {
 		pr_err("%s: invalid device\n", __func__);
 		return;
 	}
@@ -61,7 +61,7 @@ void omap_control_phy_power(struct device *dev, int on)
 	unsigned long rate;
 	struct omap_control_phy	*control_phy;
 
-	if (IS_ERR(dev) || !dev) {
+	if (IS_ERR_OR_NULL(dev)) {
 		pr_err("%s: invalid device\n", __func__);
 		return;
 	}
@@ -202,7 +202,7 @@ void omap_control_usb_set_mode(struct device *dev,
 {
 	struct omap_control_phy	*ctrl_phy;
 
-	if (IS_ERR(dev) || !dev)
+	if (IS_ERR_OR_NULL(dev))
 		return;
 
 	ctrl_phy = dev_get_drvdata(dev);
-- 
2.17.1

