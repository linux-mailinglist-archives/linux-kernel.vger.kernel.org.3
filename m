Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521DB5AE1AB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiIFH46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbiIFH44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:56:56 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDA956C762
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+xJPG
        LVVPK9/2WNOsQZiw8/Tc51nwCdtlBxjc0EKuGk=; b=L4Y9+vtJro9GCd4pI1DlD
        fjvE5b6IKpy11ILalLowDipnL4dEj9O9mFpz5z7YJArB+pJ4jEgsTlzK2xgEKSoW
        AvXdIlWQCM5nmKC/QgbgV8h+9LKgQ4MLU2D5xrQEhiZ0v+5gezhyduvDs88O/1zL
        FDEbRMtkY8k9nT+v6+vaiM=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.20])
        by smtp8 (Coremail) with SMTP id DMCowAD3nSIh_RZjXrl6ZQ--.31024S2;
        Tue, 06 Sep 2022 15:56:18 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Evgeny Boger <boger@wirenboard.com>,
        qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH 1/2] drivers: net: mdio-sun4i: Speedup mdio read and write
Date:   Tue,  6 Sep 2022 15:56:15 +0800
Message-Id: <20220906075616.21347-1-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAD3nSIh_RZjXrl6ZQ--.31024S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw47WrW3Zr15Wry8AF47Jwb_yoW5GFyxpF
        WagrZxKr48Ja1093yqyw4DWrsxXryxJry2yFWxCa9Yqwn5Crn8KFWDKF9Yqry5KrWUJ3yq
        vrWjyF429wnFqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoa0dUUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbCqRx07V0Dg3ODygAAsL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

msleep(1) on my board takes about 30ms, and it is too long to accept.
Use read_poll_timeout to speedup.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 drivers/net/mdio/mdio-sun4i.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/net/mdio/mdio-sun4i.c b/drivers/net/mdio/mdio-sun4i.c
index f798de3276dc..168e2a375535 100644
--- a/drivers/net/mdio/mdio-sun4i.c
+++ b/drivers/net/mdio/mdio-sun4i.c
@@ -26,8 +26,6 @@
 #define EMAC_MAC_MIND_REG	(0x10)
 #define EMAC_MAC_SSRR_REG	(0x14)
 
-#define MDIO_TIMEOUT		(msecs_to_jiffies(100))
-
 struct sun4i_mdio_data {
 	void __iomem		*membase;
 	struct regulator	*regulator;
@@ -36,8 +34,7 @@ struct sun4i_mdio_data {
 static int sun4i_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 {
 	struct sun4i_mdio_data *data = bus->priv;
-	unsigned long timeout_jiffies;
-	int value;
+	int ret, tmp, value;
 
 	/* issue the phy address and reg */
 	writel((mii_id << 8) | regnum, data->membase + EMAC_MAC_MADR_REG);
@@ -45,12 +42,11 @@ static int sun4i_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 	writel(0x1, data->membase + EMAC_MAC_MCMD_REG);
 
 	/* Wait read complete */
-	timeout_jiffies = jiffies + MDIO_TIMEOUT;
-	while (readl(data->membase + EMAC_MAC_MIND_REG) & 0x1) {
-		if (time_is_before_jiffies(timeout_jiffies))
-			return -ETIMEDOUT;
-		msleep(1);
-	}
+	ret = read_poll_timeout(readl, tmp, (tmp & 1) == 0,
+				20, 10000, false,
+				data->membase + EMAC_MAC_MIND_REG);
+	if (ret < 0)
+		return ret;
 
 	/* push down the phy io line */
 	writel(0x0, data->membase + EMAC_MAC_MCMD_REG);
@@ -64,7 +60,7 @@ static int sun4i_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			    u16 value)
 {
 	struct sun4i_mdio_data *data = bus->priv;
-	unsigned long timeout_jiffies;
+	int ret, tmp;
 
 	/* issue the phy address and reg */
 	writel((mii_id << 8) | regnum, data->membase + EMAC_MAC_MADR_REG);
@@ -72,12 +68,11 @@ static int sun4i_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 	writel(0x1, data->membase + EMAC_MAC_MCMD_REG);
 
 	/* Wait read complete */
-	timeout_jiffies = jiffies + MDIO_TIMEOUT;
-	while (readl(data->membase + EMAC_MAC_MIND_REG) & 0x1) {
-		if (time_is_before_jiffies(timeout_jiffies))
-			return -ETIMEDOUT;
-		msleep(1);
-	}
+	ret = read_poll_timeout(readl, tmp, (tmp & 1) == 0,
+				20, 10000, false,
+				data->membase + EMAC_MAC_MIND_REG);
+	if (ret < 0)
+		return ret;
 
 	/* push down the phy io line */
 	writel(0x0, data->membase + EMAC_MAC_MCMD_REG);
-- 
2.25.1

