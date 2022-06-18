Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A048E550709
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiFRVkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiFRVkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5933B7D6;
        Sat, 18 Jun 2022 14:40:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n20so7810345ejz.10;
        Sat, 18 Jun 2022 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yb2rrMUv1GxLtenpqlZ7JHfp3JMGxgAnwpb80DjiaaU=;
        b=NmM5eW5SURNJDJXz0JbO4qf9pDhkCtGrlsI+kxoXr2hZJE0jwXM6LHq/GbHLRS2aGi
         5wjJMhLys07ciulp/7C6fSo2LHUs3YwDVeD8BPe4f59xCirPqS9BQHjg3DRrYAU4G/Dc
         NWDc7B6k/0ZMwiseZwkzqnay0fOu+fuN15J8AwonSMLp8ZCrpGjg83DoC/0fLbvkvrbl
         QvqPeZUjEk663x0/8wPAG1ZdjsnoM0pjPkwFzYQgFOn9PhVDMQMZv3agr7IhbZJ61Igu
         jdnHEoNSkaarA7pbLggyksvnTBHzArjHdZYe6e3UlM4yIogs1lZZQYGqpMFlINzcIip+
         4fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yb2rrMUv1GxLtenpqlZ7JHfp3JMGxgAnwpb80DjiaaU=;
        b=FltZLMGfKq92tqwIjh4BwN+yoHeTb/K+pU3OC2qFq8M4rd7heoY0zwkj2bdetE/9l/
         70P3aMUhAuPm3LhL6r/8QQJjAr2l3WNRTHTfyD3FMTdLnRn1Wt2i/YM9cPllj8diyKWV
         41OhiZ2HRu2+n9I5hD0J693skYtYvB3WPR9Anpw3qez4xW9g5ZyrQkWFuCA/HYLOdhQc
         4DOowvBY6Q0RR4huCINcDb8IccLOsCntOghaPIfh+N0WOjGytcX1LMID9k/BfqD7MUG6
         wIJw7k1x49iO6WPZvM9XmW81/0heuwNKVsLoe6j0glkb0TB/ulsiO0I4vzu3YhFtEaHy
         084w==
X-Gm-Message-State: AJIora+FNjTyDAoYdWyUKD3evaUuOBes8scS8mt0lzCe5eslsVR5fnrW
        qhbpU3wR172WEEoDkKs6w30=
X-Google-Smtp-Source: AGRyM1v6FapO61bfdZLBEuM1nry05EHBD6aLYVLIBbwck02JEes3fdGAMFj2bQAqmENo3ko6CFxsmA==
X-Received: by 2002:a17:907:a407:b0:704:34ac:835c with SMTP id sg7-20020a170907a40700b0070434ac835cmr14902194ejc.663.1655588399508;
        Sat, 18 Jun 2022 14:39:59 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906480d00b00704b196e59bsm3801964ejq.185.2022.06.18.14.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:39:59 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 02/16] regmap-irq: Add get_irq_reg to support unusual register layouts
Date:   Sat, 18 Jun 2022 22:39:55 +0100
Message-Id: <20220618214009.2178567-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
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

