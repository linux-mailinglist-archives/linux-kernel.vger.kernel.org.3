Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6155B50C9CC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiDWMM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiDWMMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:12:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB32A229EDA
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:09:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i27so21012280ejd.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t074mnfEprPk+Vw6axHsXlIYvMupjvMD/CwCAB3T5xQ=;
        b=OG5oZB+vyMSReXGxuLXWzO+jYzlYCzDcMT99lc3FzgT3o3MB5erPoJoTs0TjnMrfs8
         vHgAnRDG4LRRBeuQruXPBwWBuLS677+DQNHPnQnPmDLf1zh+5TBuykxSHNQXKd+ZMURM
         mxqO8oZCbeslYADcSe6SUghC/ETsgl1eKYW3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t074mnfEprPk+Vw6axHsXlIYvMupjvMD/CwCAB3T5xQ=;
        b=vjGzYyafmzdamGaeBUhu/DOxOYiAfuWauZKTLlNqN/P8pOZonDA1zm1YvQVBfrxs8T
         qZjAnUxKLSLbyq0mtU2zvCR188Yt3BvGURMW8aPaLIw6DEILioEjhnXcF4ch9cMNbT5z
         VmRe6ZM6W71fPG01i0FzFvhd78lYtuLNzFGeknCIyi7ZYHwPzTmXQ6MOeHE2C1Ft6eT/
         le86mxieQOGO8gb6f5GxhUQi/vrNq42DKNovsCD9auJ6NfXR6PBfq+20xwD1E7DnIlUz
         rtc3xpDwboctquhzSHSENk/ff24t6gAXbfs9lYfVeF174ABFfOIElq5yMj+WVluyJcd4
         oUvg==
X-Gm-Message-State: AOAM533Q1siS7tAmzgcbUr5r13SjM3yAUOb5MSlDUW9DkkhSslxXzxKQ
        ZvSxlYPsi7ls9GNbxeSQuW9nnA==
X-Google-Smtp-Source: ABdhPJyHXKYOCALDmYqYqgRoTwTkxXyq6wEHBPcQ4PSKn9Ls5UIBVylwIM7h5Tq0mpBB+IBrQQ+59g==
X-Received: by 2002:a17:906:a089:b0:6ef:e9e6:1368 with SMTP id q9-20020a170906a08900b006efe9e61368mr8224891ejy.626.1650715762263;
        Sat, 23 Apr 2022 05:09:22 -0700 (PDT)
Received: from capella.. (109.58.122.219.mobile.3.dk. [109.58.122.219])
        by smtp.gmail.com with ESMTPSA id hz24-20020a1709072cf800b006f383a4d56bsm24902ejc.4.2022.04.23.05.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:09:21 -0700 (PDT)
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
Subject: [PATCH v2 2/2] drm: bridge: adv7511: use non-legacy mode for CEC RX
Date:   Sat, 23 Apr 2022 14:08:53 +0200
Message-Id: <20220423120854.1503163-3-alvin@pqrs.dk>
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

The ADV7511 family of bridges supports two modes for CEC RX: legacy and
non-legacy mode. The only difference is whether the chip uses a single
CEC RX buffer, or uses all three available RX buffers. Currently the
adv7511 driver uses legacy mode.

While debugging a stall in CEC RX on an ADV7535, we reached out to
Analog Devices, who suggested to use non-legacy mode instead.  According
to the programming guide for the ADV7511 [1], and the register control
manual of the ADV7535 [2], this is the default behaviour on reset. As
previously stated, the adv7511 driver currently overrides this to legacy
mode.

This patch updates the adv7511 driver to instead use non-legacy mode
with all three CEC RX buffers. As a result of this change, we no longer
experience any stalling of CEC RX with the ADV7535. It is not known why
non-legacy mode solves this particular issue, but besides this, no
functional change is to be expected by this patch. Please note that this
has only been tested on an ADV7535.

What follows is a brief description of the non-legacy mode interrupt
handling behaviour. The programming guide in [1] gives a more detailed
explanation.

With three RX buffers, the interrupt handler checks the CEC_RX_STATUS
register (renamed from CEC_RX_ENABLE in this patch), which contains
2-bit psuedo-timestamps for each of the RX buffers. The RX timestamps
for each buffer represent the time of arrival for the CEC frame held in
a given buffer, with lower timestamp values indicating chronologically
older frames. A special value of 0 indicates that the given RX buffer
is inactive and should be skipped. The interrupt handler parses these
timestamps and then reads the active RX buffers in the prescribed order
using the same logic as before. Changes have been made to ensure that
the correct RX buffer is cleared after processing. This clearing
procesure also sets the timestamp of the given RX buffer to 0 to mark it
as inactive.

[1] https://www.analog.com/media/en/technical-documentation/user-guides/ADV7511_Programming_Guide.pdf
    cf. CEC Map, register 0x4A, bit 3, default value 1:
    0 = Use only buffer 0 to store CEC frames (Legacy mode)
    1 = Use all 3 buffers to stores the CEC frames (Non-legacy mode)

[2] The ADV7535 register control manual is under NDA, but trust me when
    I say that non-legacy CEC RX mode is the default here too. Here the
    register is offset by 0x70 and has an address of 0xBA in the DSI_CEC
    regiser map.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511.h     | 26 +++++-
 drivers/gpu/drm/bridge/adv7511/adv7511_cec.c | 98 +++++++++++++++-----
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 14 ++-
 3 files changed, 106 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
index da6d8ee2cd84..9e3bb8a8ee40 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
@@ -209,10 +209,16 @@
 #define ADV7511_REG_CEC_TX_ENABLE	0x11
 #define ADV7511_REG_CEC_TX_RETRY	0x12
 #define ADV7511_REG_CEC_TX_LOW_DRV_CNT	0x14
-#define ADV7511_REG_CEC_RX_FRAME_HDR	0x15
-#define ADV7511_REG_CEC_RX_FRAME_DATA0	0x16
-#define ADV7511_REG_CEC_RX_FRAME_LEN	0x25
-#define ADV7511_REG_CEC_RX_ENABLE	0x26
+#define ADV7511_REG_CEC_RX1_FRAME_HDR	0x15
+#define ADV7511_REG_CEC_RX1_FRAME_DATA0	0x16
+#define ADV7511_REG_CEC_RX1_FRAME_LEN	0x25
+#define ADV7511_REG_CEC_RX_STATUS	0x26
+#define ADV7511_REG_CEC_RX2_FRAME_HDR	0x27
+#define ADV7511_REG_CEC_RX2_FRAME_DATA0	0x28
+#define ADV7511_REG_CEC_RX2_FRAME_LEN	0x37
+#define ADV7511_REG_CEC_RX3_FRAME_HDR	0x38
+#define ADV7511_REG_CEC_RX3_FRAME_DATA0	0x39
+#define ADV7511_REG_CEC_RX3_FRAME_LEN	0x48
 #define ADV7511_REG_CEC_RX_BUFFERS	0x4a
 #define ADV7511_REG_CEC_LOG_ADDR_MASK	0x4b
 #define ADV7511_REG_CEC_LOG_ADDR_0_1	0x4c
@@ -220,6 +226,18 @@
 #define ADV7511_REG_CEC_CLK_DIV		0x4e
 #define ADV7511_REG_CEC_SOFT_RESET	0x50
 
+static const u8 ADV7511_REG_CEC_RX_FRAME_HDR[] = {
+	ADV7511_REG_CEC_RX1_FRAME_HDR,
+	ADV7511_REG_CEC_RX2_FRAME_HDR,
+	ADV7511_REG_CEC_RX3_FRAME_HDR,
+};
+
+static const u8 ADV7511_REG_CEC_RX_FRAME_LEN[] = {
+	ADV7511_REG_CEC_RX1_FRAME_LEN,
+	ADV7511_REG_CEC_RX2_FRAME_LEN,
+	ADV7511_REG_CEC_RX3_FRAME_LEN,
+};
+
 #define ADV7533_REG_CEC_OFFSET		0x70
 
 enum adv7511_input_clock {
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
index 1f619389e201..399f625a50c8 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
@@ -17,7 +17,8 @@
 
 #define ADV7511_INT1_CEC_MASK \
 	(ADV7511_INT1_CEC_TX_READY | ADV7511_INT1_CEC_TX_ARBIT_LOST | \
-	 ADV7511_INT1_CEC_TX_RETRY_TIMEOUT | ADV7511_INT1_CEC_RX_READY1)
+	 ADV7511_INT1_CEC_TX_RETRY_TIMEOUT | ADV7511_INT1_CEC_RX_READY1 | \
+	 ADV7511_INT1_CEC_RX_READY2 | ADV7511_INT1_CEC_RX_READY3)
 
 static void adv_cec_tx_raw_status(struct adv7511 *adv7511, u8 tx_raw_status)
 {
@@ -70,25 +71,16 @@ static void adv_cec_tx_raw_status(struct adv7511 *adv7511, u8 tx_raw_status)
 	}
 }
 
-void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
+static void adv7511_cec_rx(struct adv7511 *adv7511, int rx_buf)
 {
 	unsigned int offset = adv7511->reg_cec_offset;
-	const u32 irq_tx_mask = ADV7511_INT1_CEC_TX_READY |
-				ADV7511_INT1_CEC_TX_ARBIT_LOST |
-				ADV7511_INT1_CEC_TX_RETRY_TIMEOUT;
 	struct cec_msg msg = {};
 	unsigned int len;
 	unsigned int val;
 	u8 i;
 
-	if (irq1 & irq_tx_mask)
-		adv_cec_tx_raw_status(adv7511, irq1);
-
-	if (!(irq1 & ADV7511_INT1_CEC_RX_READY1))
-		return;
-
 	if (regmap_read(adv7511->regmap_cec,
-			ADV7511_REG_CEC_RX_FRAME_LEN + offset, &len))
+			ADV7511_REG_CEC_RX_FRAME_LEN[rx_buf] + offset, &len))
 		return;
 
 	msg.len = len & 0x1f;
@@ -101,18 +93,76 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
 
 	for (i = 0; i < msg.len; i++) {
 		regmap_read(adv7511->regmap_cec,
-			    i + ADV7511_REG_CEC_RX_FRAME_HDR + offset, &val);
+			    i + ADV7511_REG_CEC_RX_FRAME_HDR[rx_buf] + offset,
+			    &val);
 		msg.msg[i] = val;
 	}
 
-	/* toggle to re-enable rx 1 */
-	regmap_write(adv7511->regmap_cec,
-		     ADV7511_REG_CEC_RX_BUFFERS + offset, 1);
-	regmap_write(adv7511->regmap_cec,
-		     ADV7511_REG_CEC_RX_BUFFERS + offset, 0);
+	/* Toggle RX Ready Clear bit to re-enable this RX buffer */
+	regmap_update_bits(adv7511->regmap_cec,
+			   ADV7511_REG_CEC_RX_BUFFERS + offset, BIT(rx_buf),
+			   BIT(rx_buf));
+	regmap_update_bits(adv7511->regmap_cec,
+			   ADV7511_REG_CEC_RX_BUFFERS + offset, BIT(rx_buf), 0);
+
 	cec_received_msg(adv7511->cec_adap, &msg);
 }
 
+void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
+{
+	unsigned int offset = adv7511->reg_cec_offset;
+	const u32 irq_tx_mask = ADV7511_INT1_CEC_TX_READY |
+				ADV7511_INT1_CEC_TX_ARBIT_LOST |
+				ADV7511_INT1_CEC_TX_RETRY_TIMEOUT;
+	const u32 irq_rx_mask = ADV7511_INT1_CEC_RX_READY1 |
+				ADV7511_INT1_CEC_RX_READY2 |
+				ADV7511_INT1_CEC_RX_READY3;
+	unsigned int rx_status;
+	int rx_order[3] = { -1, -1, -1 };
+	int i;
+
+	if (irq1 & irq_tx_mask)
+		adv_cec_tx_raw_status(adv7511, irq1);
+
+	if (!(irq1 & irq_rx_mask))
+		return;
+
+	if (regmap_read(adv7511->regmap_cec,
+			ADV7511_REG_CEC_RX_STATUS + offset, &rx_status))
+		return;
+
+	/*
+	 * ADV7511_REG_CEC_RX_STATUS[5:0] contains the reception order of RX
+	 * buffers 0, 1, and 2 in bits [1:0], [3:2], and [5:4] respectively.
+	 * The values are to be interpreted as follows:
+	 *
+	 *   0 = buffer unused
+	 *   1 = buffer contains oldest received frame (if applicable)
+	 *   2 = buffer contains second oldest received frame (if applicable)
+	 *   3 = buffer contains third oldest received frame (if applicable)
+	 *
+	 * Fill rx_order with the sequence of RX buffer indices to
+	 * read from in order, where -1 indicates that there are no
+	 * more buffers to process.
+	 */
+	for (i = 0; i < 3; i++) {
+		unsigned int timestamp = (rx_status >> (2 * i)) & 0x3;
+
+		if (timestamp)
+			rx_order[timestamp - 1] = i;
+	}
+
+	/* Read CEC RX buffers in the appropriate order as prescribed above */
+	for (i = 0; i < 3; i++) {
+		int rx_buf = rx_order[i];
+
+		if (rx_buf < 0)
+			break;
+
+		adv7511_cec_rx(adv7511, rx_buf);
+	}
+}
+
 static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool enable)
 {
 	struct adv7511 *adv7511 = cec_get_drvdata(adap);
@@ -126,11 +176,11 @@ static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool enable)
 		regmap_update_bits(adv7511->regmap_cec,
 				   ADV7511_REG_CEC_CLK_DIV + offset,
 				   0x03, 0x01);
-		/* legacy mode and clear all rx buffers */
+		/* non-legacy mode and clear all rx buffers */
 		regmap_write(adv7511->regmap_cec,
-			     ADV7511_REG_CEC_RX_BUFFERS + offset, 0x07);
+			     ADV7511_REG_CEC_RX_BUFFERS + offset, 0x0f);
 		regmap_write(adv7511->regmap_cec,
-			     ADV7511_REG_CEC_RX_BUFFERS + offset, 0);
+			     ADV7511_REG_CEC_RX_BUFFERS + offset, 0x08);
 		/* initially disable tx */
 		regmap_update_bits(adv7511->regmap_cec,
 				   ADV7511_REG_CEC_TX_ENABLE + offset, 1, 0);
@@ -138,7 +188,7 @@ static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool enable)
 		/* tx: ready */
 		/* tx: arbitration lost */
 		/* tx: retry timeout */
-		/* rx: ready 1 */
+		/* rx: ready 1-3 */
 		regmap_update_bits(adv7511->regmap,
 				   ADV7511_REG_INT_ENABLE(1), 0x3f,
 				   ADV7511_INT1_CEC_MASK);
@@ -304,9 +354,9 @@ int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511)
 	regmap_write(adv7511->regmap_cec,
 		     ADV7511_REG_CEC_SOFT_RESET + offset, 0x00);
 
-	/* legacy mode */
+	/* non-legacy mode - use all three RX buffers */
 	regmap_write(adv7511->regmap_cec,
-		     ADV7511_REG_CEC_RX_BUFFERS + offset, 0x00);
+		     ADV7511_REG_CEC_RX_BUFFERS + offset, 0x08);
 
 	regmap_write(adv7511->regmap_cec,
 		     ADV7511_REG_CEC_CLK_DIV + offset,
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 556ba1b447ba..5bb9300040dd 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1030,10 +1030,16 @@ static bool adv7511_cec_register_volatile(struct device *dev, unsigned int reg)
 	reg -= adv7511->reg_cec_offset;
 
 	switch (reg) {
-	case ADV7511_REG_CEC_RX_FRAME_HDR:
-	case ADV7511_REG_CEC_RX_FRAME_DATA0...
-		ADV7511_REG_CEC_RX_FRAME_DATA0 + 14:
-	case ADV7511_REG_CEC_RX_FRAME_LEN:
+	case ADV7511_REG_CEC_RX1_FRAME_HDR:
+	case ADV7511_REG_CEC_RX1_FRAME_DATA0 ... ADV7511_REG_CEC_RX1_FRAME_DATA0 + 14:
+	case ADV7511_REG_CEC_RX1_FRAME_LEN:
+	case ADV7511_REG_CEC_RX2_FRAME_HDR:
+	case ADV7511_REG_CEC_RX2_FRAME_DATA0 ... ADV7511_REG_CEC_RX2_FRAME_DATA0 + 14:
+	case ADV7511_REG_CEC_RX2_FRAME_LEN:
+	case ADV7511_REG_CEC_RX3_FRAME_HDR:
+	case ADV7511_REG_CEC_RX3_FRAME_DATA0 ... ADV7511_REG_CEC_RX3_FRAME_DATA0 + 14:
+	case ADV7511_REG_CEC_RX3_FRAME_LEN:
+	case ADV7511_REG_CEC_RX_STATUS:
 	case ADV7511_REG_CEC_RX_BUFFERS:
 	case ADV7511_REG_CEC_TX_LOW_DRV_CNT:
 		return true;
-- 
2.35.1

