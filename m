Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A96F56471C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiGCLUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiGCLUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:20:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DAC95BA;
        Sun,  3 Jul 2022 04:20:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r14so3675338wrg.1;
        Sun, 03 Jul 2022 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEQIwlQTc4kPghW2wNEhgQMVH2n26SLzg8zoPvmRxGU=;
        b=jf/lFRst6UFUH21MpR8E90vea7crjb6XxvlT/OyLjocpaos3O/SMROskcbtS9x8I/T
         z7ypXsukvAEmsFdM5t0ALf5dsoJFs0YGtLEUr3EhU1v15aEd2SjTpx17C/JowaIR44wp
         KqIOLs17XmwH58Gy4F2O/9ev9YkkGor6np3/dOH/2itC7onnj/Rj0UTKLkiGrnbkw13L
         qreWE4gsoLdsXrVBDNLOqb+MZ5IXL4pE1YEocbiQNRJPoHhsCmtb5P8p2ozLDAkvLKcb
         mhIwTaq1m+d3QjtwNEki4s5gEVM4q+ou2DiPgIJb9yOWAGD2O4c51Xro6ksStNjzg51B
         njtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEQIwlQTc4kPghW2wNEhgQMVH2n26SLzg8zoPvmRxGU=;
        b=A3tBH/MaDdfQ6iCFRXRYLaz4O50D3ChnEnkg4zq11bc89Z9vlogqGv1M4bbpga8asH
         4h5/FOju/ExslOna1JG7AS9k5WKl5YusHQJxS3aAanOb7esA0Rm9GVdIcPa5qmHsiYzP
         NM85RfofE6HWVFYOt114DFBpncJGR0pMiaOGDvQqptcMShOIdxY9l2Cg3H9fgmdHXLqA
         oAGZ7TqWH508Hoy9pFORMWi/Q0C3FpMDfj7ayc8VLlZFjGewglqyJL5t2TADHbNTiZJW
         YMwgtKUp400LxEpsPsVDIyrvWSs3BV2l6ZQ9c5mECJgQ2D5LyFZxPhX4Mr0sY4hxzs42
         fw1A==
X-Gm-Message-State: AJIora8eK809lUBRfiHfOJ6Jp+ls7cK6V8RlO2Z7xgFIpL4D+vj3LQCa
        Jth0zyp7UwxbZITVi3OVATM=
X-Google-Smtp-Source: AGRyM1uWuIWWAG7w7PwDhCMz+5larkbJP4ggYW9BJ7CluyIvf+ZF7lyAtrgkEm5cD1EoJJNmsnMOZA==
X-Received: by 2002:a05:6000:1888:b0:21d:151c:92a0 with SMTP id a8-20020a056000188800b0021d151c92a0mr21519051wri.609.1656847219868;
        Sun, 03 Jul 2022 04:20:19 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b002185631adf0sm28301183wre.23.2022.07.03.04.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:20:19 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, krzk@kernel.org,
        m.szyprowski@samsung.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 06/12] regmap-irq: Remove mask_writeonly and regmap_irq_update_bits()
Date:   Sun,  3 Jul 2022 12:20:55 +0100
Message-Id: <20220703112101.24493-7-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220703112101.24493-1-aidanmacdonald.0x0@gmail.com>
References: <20220703112101.24493-1-aidanmacdonald.0x0@gmail.com>
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

