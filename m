Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF774B9B79
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiBQIud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:50:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbiBQIu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:50:29 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090592A2297
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645087815; x=1676623815;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=66scgPRS6kRQoZ6YzjFqve8ZyUUdKt+n3VOjraBcZ9A=;
  b=lghmDfAgXUCszQ2bgBpVuUBHZjqoSmbPIT0eaamD7TG8VRt+Inii7k1B
   86UvrVG4HOpROoAnL99fx3odjxNP6NhILn76VIinqacpRWVXx92rUnh+i
   UqDWANv4kuZcY20Bxmy+6SQ/3awTFCPjd3OgXSp/doXi95PuggzD1e1nR
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 17 Feb 2022 00:50:14 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 17 Feb 2022 00:50:13 -0800
X-QCInternal: smtphost
Received: from hu-pkumpatl-hyd.qualcomm.com (HELO hu-maiyas-hyd.qualcomm.com) ([10.213.109.81])
  by ironmsg02-blr.qualcomm.com with ESMTP; 17 Feb 2022 14:20:11 +0530
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3914174)
        id F1DB85001C2; Thu, 17 Feb 2022 14:20:10 +0530 (+0530)
From:   Prasad Kumpatla <quic_pkumpatl@quicinc.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Subject: [PATCH v3] regmap-irq: Update interrupt clear register for proper reset
Date:   Thu, 17 Feb 2022 14:20:07 +0530
Message-Id: <20220217085007.30218-1-quic_pkumpatl@quicinc.com>
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
index d2656581a608..4a446259a184 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -189,11 +189,9 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 				ret = regmap_write(map, reg, d->mask_buf[i]);
 			if (d->chip->clear_ack) {
 				if (d->chip->ack_invert && !ret)
-					ret = regmap_write(map, reg,
-							   d->mask_buf[i]);
+					ret = regmap_write(map, reg, UINT_MAX);
 				else if (!ret)
-					ret = regmap_write(map, reg,
-							   ~d->mask_buf[i]);
+					ret = regmap_write(map, reg, 0);
 			}
 			if (ret != 0)
 				dev_err(d->map->dev, "Failed to ack 0x%x: %d\n",
@@ -556,11 +554,9 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 						data->status_buf[i]);
 			if (chip->clear_ack) {
 				if (chip->ack_invert && !ret)
-					ret = regmap_write(map, reg,
-							data->status_buf[i]);
+					ret = regmap_write(map, reg, UINT_MAX);
 				else if (!ret)
-					ret = regmap_write(map, reg,
-							~data->status_buf[i]);
+					ret = regmap_write(map, reg, 0);
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
+					ret = regmap_write(map, reg, UINT_MAX);
 				else if (!ret)
-					ret = regmap_write(map, reg,
-						~(d->status_buf[i] &
-						  d->mask_buf[i]));
+					ret = regmap_write(map, reg, 0);
 			}
 			if (ret != 0) {
 				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
-- 
2.17.1

