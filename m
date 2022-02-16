Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C0A4B8517
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiBPKBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:01:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiBPKBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:01:07 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA0C2B68E5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645005656; x=1676541656;
  h=from:to:cc:subject:date:message-id;
  bh=LUXHlrtHc2yL9GmUjffM8NUvsJAmWCQSnK4ipvnMKKk=;
  b=IX7IJSpY7GklH3jaslZjoB0BPZwu9VLphQad/0I10n6DqBwf2+WouML+
   fuOrB07+j7i7jIuuWVcycvbtJrLPAxIXL9NMMn0CJ1Zy6EZyGW1UL+A00
   iIrCtzf7vl35LNurVvetid8UwlRcxwSsRJ0Bx6SicL2iUNkxyOfTdfEsb
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 16 Feb 2022 02:00:56 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 Feb 2022 02:00:55 -0800
X-QCInternal: smtphost
Received: from hu-pkumpatl-hyd.qualcomm.com (HELO hu-maiyas-hyd.qualcomm.com) ([10.213.109.81])
  by ironmsg02-blr.qualcomm.com with ESMTP; 16 Feb 2022 15:30:45 +0530
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3914174)
        id 646A95000B9; Wed, 16 Feb 2022 15:30:44 +0530 (+0530)
From:   Prasad Kumpatla <quic_pkumpatl@quicinc.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        "Srinivas Kandagatla =?ISO-8859-1?Q?=20=1B?= [ 
        =?ISO-8859-1?Q?=20B=1B?= [ =?ISO-8859-1?Q?=20B?= =?ISO-8859-1?Q?=1B?= [
        B" <srinivas.kandagatla@linaro.org>
Cc:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Subject: [PATCH] regmap-irq: Update interrupt clear register for proper reset
Date:   Wed, 16 Feb 2022 15:30:26 +0530
Message-Id: <20220216100026.25543-1-quic_pkumpatl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the existing logic where clear_ack is true, interrupt clear register
reset is not handled properly. Due to this only the first interrupts get
processed properly and further interrupts are blocked due to interrupt
clear register is not reset. So writing 0x00 and 0xff(when ack_invert is
true) should have no effect, other than clearing the ACKs just set.

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

