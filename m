Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C779B4904A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiAQJQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:16:46 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:16229 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233321AbiAQJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642411005; x=1673947005;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=wEzHBSPCqhOTBHnM0eI8UM0L9TiLU0oONFu3MNIreVM=;
  b=xvXbAuE0dQmlmofYnTnDln/yaIkPh/SI3f59RJc5XoaqG8HO2wfRUpLt
   L0ear5tKRVZfRXRlqQWV9+k0bjrPMVATStRw0F3LFAUprR8y5aGTnX+jm
   dsOcgT3hXkhF0fj2DqVwIvHX4rJnKee+vWrSmJeMRs2e+HRGnWjywVweL
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Jan 2022 01:16:45 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 01:16:45 -0800
Received: from hu-pkumpatl-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 17 Jan 2022 01:16:42 -0800
From:   Prasad Kumpatla <quic_pkumpatl@quicinc.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Subject: [PATCH 1/1] regmap-irq: Use regmap_irq_update_bits instead of regmap_write
Date:   Mon, 17 Jan 2022 14:46:21 +0530
Message-ID: <20220117091621.30330-1-quic_pkumpatl@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the existing interrupt ack and clear ack logic, only the first
interrupt gets processed properly and further interrupts will not as
the ack register is not reset as expected. Use regmap_irq_update_bits
to update the required bits instead of regmap_write to fix the ack and
clear ack sequence.

Fixes: 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
---
 drivers/base/regmap/regmap-irq.c | 52 ++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index d2656581a608..bb9d07960dd0 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -184,16 +184,18 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 
 			/* some chips ack by write 0 */
 			if (d->chip->ack_invert)
-				ret = regmap_write(map, reg, ~d->mask_buf[i]);
+				ret = regmap_irq_update_bits(d, reg,
+						d->mask_buf[i], 0x00);
 			else
-				ret = regmap_write(map, reg, d->mask_buf[i]);
+				ret = regmap_irq_update_bits(d, reg,
+						d->mask_buf[i], d->mask_buf[i]);
 			if (d->chip->clear_ack) {
 				if (d->chip->ack_invert && !ret)
-					ret = regmap_write(map, reg,
-							   d->mask_buf[i]);
+					ret = regmap_irq_update_bits(d, reg,
+						d->mask_buf[i], d->mask_buf[i]);
 				else if (!ret)
-					ret = regmap_write(map, reg,
-							   ~d->mask_buf[i]);
+					ret = regmap_irq_update_bits(d, reg,
+						d->mask_buf[i], 0x00);
 			}
 			if (ret != 0)
 				dev_err(d->map->dev, "Failed to ack 0x%x: %d\n",
@@ -549,18 +551,20 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 			reg = sub_irq_reg(data, data->chip->ack_base, i);
 
 			if (chip->ack_invert)
-				ret = regmap_write(map, reg,
-						~data->status_buf[i]);
+				ret = regmap_irq_update_bits(d, reg,
+						data->status_buf[i], 0x00);
 			else
-				ret = regmap_write(map, reg,
+				ret = regmap_irq_update_bits(d, reg,
+						data->status_buf[i],
 						data->status_buf[i]);
 			if (chip->clear_ack) {
 				if (chip->ack_invert && !ret)
-					ret = regmap_write(map, reg,
-							data->status_buf[i]);
+					ret = regmap_irq_update_bits(d, reg,
+						data->status_buf[i],
+						data->status_buf[i]);
 				else if (!ret)
-					ret = regmap_write(map, reg,
-							~data->status_buf[i]);
+					ret = regmap_irq_update_bits(d, reg,
+						data->status_buf[i], 0x00);
 			}
 			if (ret != 0)
 				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
@@ -810,20 +814,22 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		if (d->status_buf[i] && (chip->ack_base || chip->use_ack)) {
 			reg = sub_irq_reg(d, d->chip->ack_base, i);
 			if (chip->ack_invert)
-				ret = regmap_write(map, reg,
-					~(d->status_buf[i] & d->mask_buf[i]));
+				ret = regmap_irq_update_bits(d, reg,
+					(d->status_buf[i] & d->mask_buf[i]),
+					0x00);
 			else
-				ret = regmap_write(map, reg,
-					d->status_buf[i] & d->mask_buf[i]);
+				ret = regmap_irq_update_bits(d, reg,
+					(d->status_buf[i] & d->mask_buf[i]),
+					(d->status_buf[i] & d->mask_buf[i]));
 			if (chip->clear_ack) {
 				if (chip->ack_invert && !ret)
-					ret = regmap_write(map, reg,
-						(d->status_buf[i] &
-						 d->mask_buf[i]));
+					ret = regmap_irq_update_bits(d, reg,
+					(d->status_buf[i] & d->mask_buf[i]),
+					(d->status_buf[i] & d->mask_buf[i]));
 				else if (!ret)
-					ret = regmap_write(map, reg,
-						~(d->status_buf[i] &
-						  d->mask_buf[i]));
+					ret = regmap_irq_update_bits(d, reg,
+					(d->status_buf[i] & d->mask_buf[i]),
+					0x00);
 			}
 			if (ret != 0) {
 				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
-- 
2.17.1

