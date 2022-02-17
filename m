Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06F24B9B32
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbiBQIgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:36:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbiBQIgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:36:09 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E78129A568
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645086955; x=1676622955;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bo9zcbgqbS7YT3gnI/qvruhzWKSfHvFO876SwoeW3XE=;
  b=L0U1U3ktkx3THV0oKN5muakH/5f4Mgke+uHa/cO86+90d06/FhUeqLRZ
   kPm0CbpnDvjfH49iz3c9GXHj+ny1Z68JBwtapOBgeUu5o2z6OQ3qVGQjT
   6h2C0lH5O7TZ8oEmWVSzkLjquZk+C4eKhPeZ4Dgtg+v3bYyt2t1Fa+gE1
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 17 Feb 2022 00:35:55 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 17 Feb 2022 00:35:53 -0800
X-QCInternal: smtphost
Received: from hu-pkumpatl-hyd.qualcomm.com (HELO hu-maiyas-hyd.qualcomm.com) ([10.213.109.81])
  by ironmsg02-blr.qualcomm.com with ESMTP; 17 Feb 2022 14:05:44 +0530
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3914174)
        id 81EE55001C2; Thu, 17 Feb 2022 14:05:43 +0530 (+0530)
From:   Prasad Kumpatla <quic_pkumpatl@quicinc.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Subject: [PATCH v2] regmap-irq: Update interrupt clear register for proper reset
Date:   Thu, 17 Feb 2022 14:05:28 +0530
Message-Id: <20220217083528.30026-1-quic_pkumpatl@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the existing logic where clear_ack is true (HW doesn’t support
auto clear for ICR), interrupt clear register reset is not handled
properly. Due to this only the first interrupts get processed properly
and further interrupts are blocked due to not resetting interrupt
clear register.

Example for issue case where Invert_ack is false and clear_ack is true:

    Say Default ISR=0x00 & ICR=0x00 and ISR is triggered with 2
    interrupts making ISR = 0x11.

    Step 1: Say ISR is set 0x11 (store status_buff = ISR). ISR needs to
            be cleared with the help of ICR once the Interrupt is processed.

    Step 2: Write ICR = 0x11 (status_buff), this will clear the ISR to 0x00.

    Step 3: Issue - In the existing code, ICR is written with ICR =
            ~(status_buff) i.e ICR = 0xEE -> This will block all the interrupts
            from raising except for interrupts 0 and 4. So expectation here is to
            reset ICR, which will unblock all the interrupts.

            if (chip->clear_ack) {
                 if (chip->ack_invert && !ret)
                  ........
                 else if (!ret)
                     ret = regmap_write(map, reg,
                            ~data->status_buf[i]);

So writing 0 and 0xff (when ack_invert is true) should have no effect, other
than clearing the ACKs just set.

Fixes: 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
---
 drivers/base/regmap/regmap-irq.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index d2656581a608..22b4c98bc026 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -189,11 +189,9 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 				ret = regmap_write(map, reg, d->mask_buf[i]);
 			if (d->chip->clear_ack) {
 				if (d->chip->ack_invert && !ret)
-					ret = regmap_write(map, reg,
-							   d->mask_buf[i]);
+					ret = regmap_write(map, reg, 0xff);
 				else if (!ret)
-					ret = regmap_write(map, reg,
-							   ~d->mask_buf[i]);
+					ret = regmap_write(map, reg, 0x00);
 			}
 			if (ret != 0)
 				dev_err(d->map->dev, "Failed to ack 0x%x: %d\n",
@@ -556,11 +554,9 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 						data->status_buf[i]);
 			if (chip->clear_ack) {
 				if (chip->ack_invert && !ret)
-					ret = regmap_write(map, reg,
-							data->status_buf[i]);
+					ret = regmap_write(map, reg, 0xff);
 				else if (!ret)
-					ret = regmap_write(map, reg,
-							~data->status_buf[i]);
+					ret = regmap_write(map, reg, 0x00);
 			}
 			if (ret != 0)
 				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
@@ -817,13 +813,9 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 					d->status_buf[i] & d->mask_buf[i]);
 			if (chip->clear_ack) {
 				if (chip->ack_invert && !ret)
-					ret = regmap_write(map, reg,
-						(d->status_buf[i] &
-						 d->mask_buf[i]));
+					ret = regmap_write(map, reg, 0xff);
 				else if (!ret)
-					ret = regmap_write(map, reg,
-						~(d->status_buf[i] &
-						  d->mask_buf[i]));
+					ret = regmap_write(map, reg, 0x00);
 			}
 			if (ret != 0) {
 				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
-- 
2.17.1

