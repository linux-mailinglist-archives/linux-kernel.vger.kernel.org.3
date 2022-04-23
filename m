Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8350C9C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiDWMMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbiDWMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:12:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C05229ED2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:09:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id s18so21146463ejr.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ul8xsTObKq7dxqXoQV8EI09Hux8ap60oboJuoV8LAW0=;
        b=LSUia2p58gc1dfhUGH1PJMFheVOjwroaUmlgzniFrkbYBhuGWBDk+B7Iv9WplY0336
         a0as++9UuzYctPIX3rhw7aIWxs2Xk3T9yRkpdil0rMMeWfSlO4PFREFoNIwXqw0XPAuJ
         q+xBynMJP6MZVlczjrhH+zWmpeNYKbpMcF7TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ul8xsTObKq7dxqXoQV8EI09Hux8ap60oboJuoV8LAW0=;
        b=5qkYkRdfURS+sSYrOF47sZKum1nU6GB+asNZyPeQ+kUCk15xC7hM7xC5AaEK+Wrtfb
         8AeNVEfLHW23Z8JLuGPq3Orb7Em3uB7+Op6UKxjh1EO31yx/J8vKH2q+vrVm0w7UUW+T
         CiKGi44GaBvyDDhMdO/FYB7Y+QvcyDewq/GSk1um6M+AQxw0hsnNVAoDjO8O6E/GjiIy
         sKHog0NC7uPoUAwWAYQexEs6TcqPUn4wwakaOnDQ9qFJk43iAf/9OfvtKBrx+HaFq5sh
         0bYezrROvOu191s/N3Ji0r8VWeDULQpsWdIDcglGfaWPVy6As1uXZpdzb0eHpGWSa0IU
         95QQ==
X-Gm-Message-State: AOAM531n+gPa/AeipFxbA1srgQjHehsJjogrLgeroWSTSXwpjqWAtcY/
        2Rar/qFbvqp3toPbB2miz8RQkA==
X-Google-Smtp-Source: ABdhPJxs/w+J//eja9Fb7hXl/nc1YqFmIlFoGP9adBbpZUPaD6iHXBPpaUOzLdBJMBPwFbyA3K8rEg==
X-Received: by 2002:a17:906:3919:b0:6e8:688d:5fd9 with SMTP id f25-20020a170906391900b006e8688d5fd9mr7961042eje.263.1650715760057;
        Sat, 23 Apr 2022 05:09:20 -0700 (PDT)
Received: from capella.. (109.58.122.219.mobile.3.dk. [109.58.122.219])
        by smtp.gmail.com with ESMTPSA id hz24-20020a1709072cf800b006f383a4d56bsm24902ejc.4.2022.04.23.05.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:09:19 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm: bridge: adv7511: enable CEC support for ADV7535
Date:   Sat, 23 Apr 2022 14:08:52 +0200
Message-Id: <20220423120854.1503163-2-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220423120854.1503163-1-alvin@pqrs.dk>
References: <20220423120854.1503163-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Like the ADV7533, the ADV7535 has an offset for the CEC register map,
and it is the same value (ADV7533_REG_CEC_OFFSET = 0x70).

Rather than testing for numerous chip types in the offset calculations
throughout the driver, just compute it during driver probe and put it in
the private adv7511 data structure.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511.h     |  1 +
 drivers/gpu/drm/bridge/adv7511/adv7511_cec.c | 18 ++++++------------
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c |  5 +++--
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
index 6a882891d91c..da6d8ee2cd84 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
@@ -335,6 +335,7 @@ struct adv7511 {
 
 	struct regmap *regmap;
 	struct regmap *regmap_cec;
+	unsigned int reg_cec_offset;
 	enum drm_connector_status status;
 	bool powered;
 
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
index 28d9becc939c..1f619389e201 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
@@ -21,8 +21,7 @@
 
 static void adv_cec_tx_raw_status(struct adv7511 *adv7511, u8 tx_raw_status)
 {
-	unsigned int offset = adv7511->type == ADV7533 ?
-					ADV7533_REG_CEC_OFFSET : 0;
+	unsigned int offset = adv7511->reg_cec_offset;
 	unsigned int val;
 
 	if (regmap_read(adv7511->regmap_cec,
@@ -73,8 +72,7 @@ static void adv_cec_tx_raw_status(struct adv7511 *adv7511, u8 tx_raw_status)
 
 void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
 {
-	unsigned int offset = adv7511->type == ADV7533 ?
-					ADV7533_REG_CEC_OFFSET : 0;
+	unsigned int offset = adv7511->reg_cec_offset;
 	const u32 irq_tx_mask = ADV7511_INT1_CEC_TX_READY |
 				ADV7511_INT1_CEC_TX_ARBIT_LOST |
 				ADV7511_INT1_CEC_TX_RETRY_TIMEOUT;
@@ -118,8 +116,7 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
 static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool enable)
 {
 	struct adv7511 *adv7511 = cec_get_drvdata(adap);
-	unsigned int offset = adv7511->type == ADV7533 ?
-					ADV7533_REG_CEC_OFFSET : 0;
+	unsigned int offset = adv7511->reg_cec_offset;
 
 	if (adv7511->i2c_cec == NULL)
 		return -EIO;
@@ -165,8 +162,7 @@ static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool enable)
 static int adv7511_cec_adap_log_addr(struct cec_adapter *adap, u8 addr)
 {
 	struct adv7511 *adv7511 = cec_get_drvdata(adap);
-	unsigned int offset = adv7511->type == ADV7533 ?
-					ADV7533_REG_CEC_OFFSET : 0;
+	unsigned int offset = adv7511->reg_cec_offset;
 	unsigned int i, free_idx = ADV7511_MAX_ADDRS;
 
 	if (!adv7511->cec_enabled_adap)
@@ -235,8 +231,7 @@ static int adv7511_cec_adap_transmit(struct cec_adapter *adap, u8 attempts,
 				     u32 signal_free_time, struct cec_msg *msg)
 {
 	struct adv7511 *adv7511 = cec_get_drvdata(adap);
-	unsigned int offset = adv7511->type == ADV7533 ?
-					ADV7533_REG_CEC_OFFSET : 0;
+	unsigned int offset = adv7511->reg_cec_offset;
 	u8 len = msg->len;
 	unsigned int i;
 
@@ -289,8 +284,7 @@ static int adv7511_cec_parse_dt(struct device *dev, struct adv7511 *adv7511)
 
 int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511)
 {
-	unsigned int offset = adv7511->type == ADV7533 ?
-						ADV7533_REG_CEC_OFFSET : 0;
+	unsigned int offset = adv7511->reg_cec_offset;
 	int ret = adv7511_cec_parse_dt(dev, adv7511);
 
 	if (ret)
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index b3f10c54e064..556ba1b447ba 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1027,8 +1027,7 @@ static bool adv7511_cec_register_volatile(struct device *dev, unsigned int reg)
 	struct i2c_client *i2c = to_i2c_client(dev);
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
-	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
-		reg -= ADV7533_REG_CEC_OFFSET;
+	reg -= adv7511->reg_cec_offset;
 
 	switch (reg) {
 	case ADV7511_REG_CEC_RX_FRAME_HDR:
@@ -1073,6 +1072,8 @@ static int adv7511_init_cec_regmap(struct adv7511 *adv)
 		ret = adv7533_patch_cec_registers(adv);
 		if (ret)
 			goto err;
+
+		adv->reg_cec_offset = ADV7533_REG_CEC_OFFSET;
 	}
 
 	return 0;
-- 
2.35.1

