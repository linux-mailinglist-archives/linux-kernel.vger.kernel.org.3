Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F1572BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiGMDQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiGMDQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:16:10 -0400
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8834CD7A4D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:16:07 -0700 (PDT)
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 13 Jul 2022 11:16:06 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 26D3G1r5010517;
        Wed, 13 Jul 2022 11:16:01 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from VirtualBox.internal.ite.com.tw (192.168.70.46) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.14; Wed, 13 Jul 2022 11:16:00 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Pin-yen Lin <treapking@google.com>,
        Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/bridge: it6505: Add i2c api power on check
Date:   Wed, 13 Jul 2022 11:15:47 +0800
Message-ID: <20220713031547.11641-1-allen.chen@ite.com.tw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.70.46]
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP: 24D321129413D9267E4F3E545413DC97FAB72075DC9AC9B6D9DBCF0786A3E6E42002:8
X-MAIL: mse.ite.com.tw 26D3G1r5010517
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: allen chen <allen.chen@ite.com.tw>

Use i2c bus to read/write when it6505 power off will occur i2c error.
Add this check will prevent i2c error when it6505 power off.

Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index aa5e0aa1af85..cfd2c3275dc5 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -518,6 +518,9 @@ static int it6505_read(struct it6505 *it6505, unsigned int reg_addr)
 	int err;
 	struct device *dev = &it6505->client->dev;
 
+	if (!it6505->powered)
+		return -ENODEV;
+
 	err = regmap_read(it6505->regmap, reg_addr, &value);
 	if (err < 0) {
 		dev_err(dev, "read failed reg[0x%x] err: %d", reg_addr, err);
@@ -533,6 +536,9 @@ static int it6505_write(struct it6505 *it6505, unsigned int reg_addr,
 	int err;
 	struct device *dev = &it6505->client->dev;
 
+	if (!it6505->powered)
+		return -ENODEV;
+
 	err = regmap_write(it6505->regmap, reg_addr, reg_val);
 
 	if (err < 0) {
@@ -550,6 +556,9 @@ static int it6505_set_bits(struct it6505 *it6505, unsigned int reg,
 	int err;
 	struct device *dev = &it6505->client->dev;
 
+	if (!it6505->powered)
+		return -ENODEV;
+
 	err = regmap_update_bits(it6505->regmap, reg, mask, value);
 	if (err < 0) {
 		dev_err(dev, "write reg[0x%x] = 0x%x mask = 0x%x failed err %d",
@@ -2553,13 +2562,12 @@ static int it6505_poweron(struct it6505 *it6505)
 		usleep_range(10000, 20000);
 	}
 
+	it6505->powered = true;
 	it6505_reset_logic(it6505);
 	it6505_int_mask_enable(it6505);
 	it6505_init(it6505);
 	it6505_lane_off(it6505);
 
-	it6505->powered = true;
-
 	return 0;
 }
 
-- 
2.25.1

