Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DFB558A86
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiFWVNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiFWVNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD651311
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so414652wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEQIwlQTc4kPghW2wNEhgQMVH2n26SLzg8zoPvmRxGU=;
        b=D1K7AwVK5TzTFfifp7CxhpuosId2pz3TPE1ZZ5GjzjzlaYwwMu6UaDllJsKTSokYNE
         IdbUYwhhq29gNPT6scTGB1QQaSQxFN2z+qgT/M+InuNGKNB7sKg8u45zxgFCxs0B4gS/
         OVixmcVH7c3lS18imyMnV/bTRjEpkBhSJ7PLjpT14WSqto+CUht00ql7xs1LVeMdXpTp
         dTparxaP5J0EjxhxFR8MBkhIKfbu+Uw6t2hZzdbCqMlODOaLukFBY49FWEJPAOZyj2TZ
         Xu4W0Y3p4c+cyPKzlwLkHwQnO9KJR7Wxwk/9XlTWbmrKHg57R1y5fQ6eqA02m3rG6pop
         Ru/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEQIwlQTc4kPghW2wNEhgQMVH2n26SLzg8zoPvmRxGU=;
        b=W26WtVt2FuaIccWKm+ragnPcJyb89vT6/E3eue884WBWgK+BqIJD+OE6JQyUQEBey2
         uSFpZbj1Iv+g9UktEx4keXMnJWhH156dQI7DX/UxUHFTgrVC4gxEiJbzl/UnJ2Vl9kat
         xq4rs3ejfFCZle1TUgGpDRKiuktvmCi2cUcmY2098F6Bt3D68kR8UaCryXW9g8orHGoD
         mt1qbf0Z3Iv9LwgyHAzH0sg6B/38cXmA2zAKbAtGP8cVBwSppB2qfrPCk5qLE+ncAK3+
         dBBLR0IOj37rQb4rE2zyxKJlkfk0FUMlTfwvPnQSj1OOB6tAWlvbXDmuwoX/FAeTnR6A
         5sYA==
X-Gm-Message-State: AJIora9CoQnttpLudADwV9Kzi0dBsP26hGBJICCXRbsULlsYqPrb6Ebz
        rQy8N0PqPDS8bRLzBlXp9nI=
X-Google-Smtp-Source: AGRyM1sKGmoNY+PQxGWT9xM1gV+pQC1cyP1FizJFGFljm7mH2aH9KPanBjdo9sFor6Huy2jdSvUn9A==
X-Received: by 2002:a05:600c:1c24:b0:39c:6530:2a60 with SMTP id j36-20020a05600c1c2400b0039c65302a60mr6311706wms.78.1656018815833;
        Thu, 23 Jun 2022 14:13:35 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000100300b0021b943a50b3sm399654wrx.85.2022.06.23.14.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:35 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/12] regmap-irq: Remove mask_writeonly and regmap_irq_update_bits()
Date:   Thu, 23 Jun 2022 22:14:14 +0100
Message-Id: <20220623211420.918875-7-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a71411dbf6c8 ("regmap: irq: add chip option mask_writeonly")
introduced the mask_writeonly option, but it isn't used now and it
appears it's never been used by any in-tree drivers. The motivation
for the option is mentioned in the commit message,

    Some irq controllers have writeonly/multipurpose register
    layouts. In those cases we read invalid data back. [...]

The option causes mask register updates to use regmap_write_bits()
instead of regmap_update_bits().

However, regmap_write_bits() doesn't solve the reading invalid data
problem. It's still a read-modify-write op like regmap_update_bits().
The difference is that 'update bits' will only write the new value
if it is different from the current value, while 'write bits' will
write the new value unconditionally, even if it's the same as the
current value.

This seems like a bit of a specialized use case and probably isn't
that useful for regmap-irq, so let's just remove the option and go
back to using an 'update bits' op for the mask registers. We can
always add the option back if some driver ends up needing it in the
future.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 24 +++++++-----------------
 include/linux/regmap.h           |  2 --
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index cb20ce6f91e7..7e93dd8af56b 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -80,16 +80,6 @@ static void regmap_irq_lock(struct irq_data *data)
 	mutex_lock(&d->lock);
 }
 
-static int regmap_irq_update_bits(struct regmap_irq_chip_data *d,
-				  unsigned int reg, unsigned int mask,
-				  unsigned int val)
-{
-	if (d->chip->mask_writeonly)
-		return regmap_write_bits(d->map, reg, mask, val);
-	else
-		return regmap_update_bits(d->map, reg, mask, val);
-}
-
 static void regmap_irq_sync_unlock(struct irq_data *data)
 {
 	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
@@ -130,11 +120,11 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 
 		reg = sub_irq_reg(d, d->chip->mask_base, i);
 		if (d->chip->mask_invert) {
-			ret = regmap_irq_update_bits(d, reg,
+			ret = regmap_update_bits(d->map, reg,
 					 d->mask_buf_def[i], ~d->mask_buf[i]);
 		} else if (d->chip->unmask_base) {
 			/* set mask with mask_base register */
-			ret = regmap_irq_update_bits(d, reg,
+			ret = regmap_update_bits(d->map, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
 			if (ret < 0)
 				dev_err(d->map->dev,
@@ -143,12 +133,12 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 			unmask_offset = d->chip->unmask_base -
 							d->chip->mask_base;
 			/* clear mask with unmask_base register */
-			ret = regmap_irq_update_bits(d,
+			ret = regmap_update_bits(d->map,
 					reg + unmask_offset,
 					d->mask_buf_def[i],
 					d->mask_buf[i]);
 		} else {
-			ret = regmap_irq_update_bits(d, reg,
+			ret = regmap_update_bits(d->map, reg,
 					 d->mask_buf_def[i], d->mask_buf[i]);
 		}
 		if (ret != 0)
@@ -763,17 +753,17 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		reg = sub_irq_reg(d, d->chip->mask_base, i);
 
 		if (chip->mask_invert)
-			ret = regmap_irq_update_bits(d, reg,
+			ret = regmap_update_bits(d->map, reg,
 					 d->mask_buf[i], ~d->mask_buf[i]);
 		else if (d->chip->unmask_base) {
 			unmask_offset = d->chip->unmask_base -
 					d->chip->mask_base;
-			ret = regmap_irq_update_bits(d,
+			ret = regmap_update_bits(d->map,
 					reg + unmask_offset,
 					d->mask_buf[i],
 					d->mask_buf[i]);
 		} else
-			ret = regmap_irq_update_bits(d, reg,
+			ret = regmap_update_bits(d->map, reg,
 					 d->mask_buf[i], d->mask_buf[i]);
 		if (ret != 0) {
 			dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 106ca1172d3d..d21eb8ad2675 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1452,7 +1452,6 @@ struct regmap_irq_sub_irq_map {
  *
  * @status_base: Base status register address.
  * @mask_base:   Base mask register address.
- * @mask_writeonly: Base mask register is write only.
  * @unmask_base:  Base unmask register address. for chips who have
  *                separate mask and unmask registers
  * @ack_base:    Base ack address. If zero then the chip is clear on read.
@@ -1518,7 +1517,6 @@ struct regmap_irq_chip {
 	unsigned int type_base;
 	unsigned int *virt_reg_base;
 	unsigned int irq_reg_stride;
-	unsigned int mask_writeonly:1;
 	unsigned int init_ack_masked:1;
 	unsigned int mask_invert:1;
 	unsigned int use_ack:1;
-- 
2.35.1

