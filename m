Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9674DE8F2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbiCSPMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243418AbiCSPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:12:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95FC54BC0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 08:10:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b15so13354975edn.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c5GV8Sqa9HxG9jNF600oPxEBUAnTnn/ZeyJz7jRUQIQ=;
        b=SHTVXk9wr6d7wqUrX0FDI5UpwdkcTkwfUASd1NtVoF5T7XFjZN8PyDQ/nPxI+Blm28
         wY7yn5pybqjy+55htDInP51kX0EXqsuA1DtMzoKHa8n7vm5krmKMGMLLl7egVBWJWR+L
         DYil3Kjjprho1ulnX6PZtISdszq9LpwMeQffo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5GV8Sqa9HxG9jNF600oPxEBUAnTnn/ZeyJz7jRUQIQ=;
        b=rBT1jFG1vFvNk9gPw5O4bXQABX1dAN4kwfen9VIFePAqNjHMNsHfCnSX+fwyfUgInD
         4wq+gahBaBmjvoa+ZMLg/UyZlBk7SBGucXJ+oSSqZoWe6kUfCytuK59ZC6+tAje2uaNv
         NE5LG1CVlSnPnpQPeR+g58byIezS3zL03IS8PYfPrILRXDx7X1sYSqtaAXwD5Wg09jYw
         v77b0aRIDn32LCpCZXe0wIHnF1w/RcoCJ0bVgzxopr9TFa+yohNHy7Hv8jwDN8X0zKX2
         cYk4bZjkikHox49wsPxDvTRw74GjXkesvWZKXKSn37bfiB1Oqh+B6YEj9fBItBsUb9dL
         X4lw==
X-Gm-Message-State: AOAM531KNXhqSj3C46bsUe66sp06QTS5mOIr4K/T6GdygxvSL5ZodMBO
        Wq7AdtUTcB1+pJ28sxmflznqrA==
X-Google-Smtp-Source: ABdhPJzsezxQxWdDTkbcj8Yehhry13s97rbvKlWNQegZwhRfy56Vf0B/ayrWU6fxH7pkYVmjtqnrAA==
X-Received: by 2002:a05:6402:5304:b0:413:8a0c:c54a with SMTP id eo4-20020a056402530400b004138a0cc54amr14653104edb.172.1647702645508;
        Sat, 19 Mar 2022 08:10:45 -0700 (PDT)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906728b00b006df8494d384sm4573778ejl.122.2022.03.19.08.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 08:10:45 -0700 (PDT)
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
Subject: [PATCH 1/2] drm: bridge: adv7511: enable CEC support for ADV7535
Date:   Sat, 19 Mar 2022 16:10:14 +0100
Message-Id: <20220319151016.983348-2-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319151016.983348-1-alvin@pqrs.dk>
References: <20220319151016.983348-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 005bf18682ff..0be65a1ffc47 100644
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

