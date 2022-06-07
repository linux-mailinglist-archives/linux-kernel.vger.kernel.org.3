Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C405402D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbiFGPwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344351AbiFGPwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:52:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB6528735;
        Tue,  7 Jun 2022 08:52:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y19so36074942ejq.6;
        Tue, 07 Jun 2022 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yb2rrMUv1GxLtenpqlZ7JHfp3JMGxgAnwpb80DjiaaU=;
        b=Ow2BCMUHX9hGlUzVz5J6IHY9XghYbhpHAFLPo7HXPrKbean5UmU6ZybnmfYFQOJu2C
         z7zbCT5yzQ7BJRgYVjLYlgT/VZTynX6682lwWUP+VxQJGioicpCK0tsnzWdhQMsbD/6A
         LUBz+96o58vmoUVUupD2mDM/IQRHsAp/HtUtvAOC/EJYx9dsovH6aodoC3xuPIF9kpTp
         TCtT6QmJnBxRphPOUaKUzd8+y8BEFq56Sexz8aA4170iXB9QmGniUGQzLubqWa18wyiy
         PVxY8TwXsx0ddPj+YfakKaAAkTtqKQWasgC31bnuyj//0MJvLzI4xGCm6zWYlG4gvwKm
         3jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yb2rrMUv1GxLtenpqlZ7JHfp3JMGxgAnwpb80DjiaaU=;
        b=AyTD40yEdkBSHD5EZeIRp1+qZN5BTjpG42soxGDpD1qUN7JR7KLbq0sOIFo+amNWkN
         07hi1m8S6YCuVooUWL17iyqRsZ1laDOVIZOPduSXc5ECnhpp8ATnX30EQjSO9pU6mD/v
         a9qw5xLroQM6Wgk+xmlvMBv8aCwfHCtDJ3jmMkTLT9tZC2EZwj36XUOwBAEiSZwQtHiQ
         THclCCCsRtm45rjeYhTthRSiHMj7f9dRWB5E/qsCj+3uXPnE+xwcH7GWVPUjsRIpBeR9
         sV/5WxJVVOp79leZ38ojTja3QM1w8V/ejuMg+tNhi3zejVpE7E2tuMeGVlgeh2NnPMOs
         tMNQ==
X-Gm-Message-State: AOAM533LZ/S6q0anFjvYI7RKU97w83yyd6gdyyO5yTwz1UOStU+LRjM7
        GKSxTaMACFdrEgjyJB0Zkwg=
X-Google-Smtp-Source: ABdhPJy9iw+ebDgVx+/v4fUrlwUC1Sj4D216lLPykNcZ4JeJUqaI1D0KkHPJuY6dl8hgrDttDPsCLg==
X-Received: by 2002:a17:907:1b19:b0:6f0:1022:1430 with SMTP id mp25-20020a1709071b1900b006f010221430mr27995616ejc.13.1654617148523;
        Tue, 07 Jun 2022 08:52:28 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906614900b00711c7cca428sm3481287ejl.155.2022.06.07.08.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:28 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 02/17] regmap-irq: Add get_irq_reg to support unusual register layouts
Date:   Tue,  7 Jun 2022 16:53:09 +0100
Message-Id: <20220607155324.118102-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
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

Add a new callback, get_irq_reg, for regmap IRQ chips, to support devices
with unusual register layouts. This is required in the rare cases where
the offset of an IRQ register is not constant with respect to the base
register. This is probably best illustrated with an example (taken from
the AXP192 PMIC):

            mask    status
    IRQ0    0x40    0x44
    IRQ1    0x41    0x45
    IRQ2    0x42    0x46
    IRQ3    0x43    0x47
    IRQ4    0x4a    0x4d

If we set mask_base = 0x40 and status_base = 0x44, the offsets of each
register relative to the base are:

            mask    status
    IRQ0    0       0
    IRQ1    1       1
    IRQ2    2       2
    IRQ3    3       3
    IRQ4    10      9

The existing mapping mechanisms can't include IRQ4 in the same irqchip
as IRQ0-3 because the offset of IRQ4's register depends on which type
of register we're asking for, ie. which base register is used.

The get_irq_reg callback allows drivers to specify an arbitrary mapping
of (base register, register index) pairs to register addresses, instead
of the default linear mapping "base_register + register_index". This
allows unusual layouts, like the one above, to be handled using a single
regmap IRQ chip.

The drawback is that when get_irq_reg is used, it's impossible to use
bulk reads for status registers even if some of them are contiguous,
because the mapping is opaque to regmap-irq. This should be acceptable
for the case of a few infrequently-polled status registers.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 6 ++++--
 include/linux/regmap.h           | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 4a2e1f6aa94d..e50437b18284 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -55,7 +55,9 @@ static int sub_irq_reg(struct regmap_irq_chip_data *data,
 	unsigned int offset;
 	int reg = 0;
 
-	if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
+	if (chip->get_irq_reg) {
+		reg = chip->get_irq_reg(base_reg, i);
+	} else if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
 		/* Assume linear mapping */
 		reg = base_reg + (i * map->reg_stride * data->irq_reg_stride);
 	} else {
@@ -479,7 +481,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 
 		}
 	} else if (!map->use_single_read && map->reg_stride == 1 &&
-		   data->irq_reg_stride == 1) {
+		   data->irq_reg_stride == 1 && !chip->get_irq_reg) {
 
 		u8 *buf8 = data->status_reg_buf;
 		u16 *buf16 = data->status_reg_buf;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 8952fa3d0d59..4828021ab9e8 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1495,6 +1495,10 @@ struct regmap_irq_sub_irq_map {
  *		     after handling the interrupts in regmap_irq_handler().
  * @set_type_virt:   Driver specific callback to extend regmap_irq_set_type()
  *		     and configure virt regs.
+ * @get_irq_reg:     Callback to map a register index in range [0, num_regs[
+ *		     to a register, relative to a specific base register. This
+ *		     is mainly useful for devices where the register offsets
+ *		     change depending on the base register.
  * @irq_drv_data:    Driver specific IRQ data which is passed as parameter when
  *		     driver specific pre/post interrupt handler is called.
  *
@@ -1545,6 +1549,7 @@ struct regmap_irq_chip {
 	int (*handle_post_irq)(void *irq_drv_data);
 	int (*set_type_virt)(unsigned int **buf, unsigned int type,
 			     unsigned long hwirq, int reg);
+	int (*get_irq_reg)(unsigned int base_reg, int i);
 	void *irq_drv_data;
 };
 
-- 
2.35.1

