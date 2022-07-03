Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84BE564710
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiGCLU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiGCLUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:20:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DCA9FCD;
        Sun,  3 Jul 2022 04:20:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s1so9447480wra.9;
        Sun, 03 Jul 2022 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqID5x/tjmobIccvt6tf2g3gXW+2/FDTRjd9KrrHqF4=;
        b=d4PXzIx1PJErn9Uy2EDzGRD+E2Nbcs6RZpo0yI7IrkhA/iuGU9MPm1VK2MIDxJH1/v
         tWgyTeJSwsvuzYOtBU4sda1lmwDv/7V5Pabdqktqke0MACJuSu6Mm+a7dQWbUvrbXERp
         5DyfWU+Y7R/2CUitPzIB7LpSCFu08IySB58MdH3RUtlO39NRepdPbQe/X42DBksr9s/i
         vDhLsH6p5mGiGJy6owfZQWfZdJpUOGLYsLbw5Cp+24YGFHxtYds/HlJ+ixktSEVm4Lhw
         I+xRW7RvEkbgy2uyA2wYw3bXnap8iVzgmpw1coOHHnmJdmgP3EVdBFD+W+uGOX6kNISF
         2sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqID5x/tjmobIccvt6tf2g3gXW+2/FDTRjd9KrrHqF4=;
        b=2GyyLze8KGR6PFbLqcOOPHeptQVeIp1mSVltjXxIVnHBE6i1Vs5p2M+LxzeOWtfg4O
         UKecFANlusCmdXkVr1xFpXtS6Z7uZYQXN3+DUuyNt5+mH1Fn1A4M68qEifd68QZZg0ng
         QNHURBaz+DiBJeCr9t0aW63Ofa7daLe+5NF3qZqaTl92S5kTrfqlCrX2hxqR6i3nNPUp
         oqXQtZTlDIhPtG5/oQ5BNFr9/1sRgx0xaqURHmpbTKfWqQ3KiOP9aTGRQng6uc1g0jpR
         +UzlontQ4+c17aG7GH3zTzKxFToVAEtzbLioIFaHXiyP2w9R1H5ioAKN2zODog4HlCha
         RMNA==
X-Gm-Message-State: AJIora8J/YSBP3Af3Do1BAviTeoGQ6jt5bhGZo9sBa0qb3afSxhtoCQs
        V5yGLgESlNFDWFA7dTPdScA=
X-Google-Smtp-Source: AGRyM1ucoV4eygJAYC4FPKlfYevd8mXuhGpdVsvgf2tZwNZTwxXLapGZfa9mDAfenf7w1WTVZNgp6Q==
X-Received: by 2002:a5d:664c:0:b0:21d:2d0d:e729 with SMTP id f12-20020a5d664c000000b0021d2d0de729mr21101920wrw.585.1656847216859;
        Sun, 03 Jul 2022 04:20:16 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id t5-20020a1c4605000000b0039db31f6372sm12531769wma.2.2022.07.03.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:20:16 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, krzk@kernel.org,
        m.szyprowski@samsung.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 04/12] regmap-irq: Remove an unnecessary restriction on type_in_mask
Date:   Sun,  3 Jul 2022 12:20:53 +0100
Message-Id: <20220703112101.24493-5-aidanmacdonald.0x0@gmail.com>
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

Check types_supported instead of checking type_rising/falling_val
when using type_in_mask interrupts. This makes the intent clearer
and allows a type_in_mask irq to support level or edge triggers,
rather than only edge triggers.

Update the documentation and comments to reflect the new behavior.

This shouldn't affect existing drivers, because if they didn't
set types_supported properly the type buffer wouldn't be updated.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 19 ++++++++-----------
 include/linux/regmap.h           |  8 +++++---
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index dca27b4e29d3..fd7c4315d16b 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -252,22 +252,19 @@ static void regmap_irq_enable(struct irq_data *data)
 	struct regmap *map = d->map;
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
 	unsigned int reg = irq_data->reg_offset / map->reg_stride;
-	unsigned int mask, type;
-
-	type = irq_data->type.type_falling_val | irq_data->type.type_rising_val;
+	unsigned int mask;
 
 	/*
 	 * The type_in_mask flag means that the underlying hardware uses
-	 * separate mask bits for rising and falling edge interrupts, but
-	 * we want to make them into a single virtual interrupt with
-	 * configurable edge.
+	 * separate mask bits for each interrupt trigger type, but we want
+	 * to have a single logical interrupt with a configurable type.
 	 *
-	 * If the interrupt we're enabling defines the falling or rising
-	 * masks then instead of using the regular mask bits for this
-	 * interrupt, use the value previously written to the type buffer
-	 * at the corresponding offset in regmap_irq_set_type().
+	 * If the interrupt we're enabling defines any supported types
+	 * then instead of using the regular mask bits for this interrupt,
+	 * use the value previously written to the type buffer at the
+	 * corresponding offset in regmap_irq_set_type().
 	 */
-	if (d->chip->type_in_mask && type)
+	if (d->chip->type_in_mask && irq_data->type.types_supported)
 		mask = d->type_buf[reg] & irq_data->mask;
 	else
 		mask = irq_data->mask;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f75911239977..106ca1172d3d 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1468,9 +1468,11 @@ struct regmap_irq_sub_irq_map {
  * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
  * @type_invert: Invert the type flags.
- * @type_in_mask: Use the mask registers for controlling irq type. For
- *                interrupts defining type_rising/falling_mask use mask_base
- *                for edge configuration and never update bits in type_base.
+ * @type_in_mask: Use the mask registers for controlling irq type. Use this if
+ *		  the hardware provides separate bits for rising/falling edge
+ *		  or low/high level interrupts and they should be combined into
+ *		  a single logical interrupt. Use &struct regmap_irq_type data
+ *		  to define the mask bit for each irq type.
  * @clear_on_unmask: For chips with interrupts cleared on read: read the status
  *                   registers before unmasking interrupts to clear any bits
  *                   set when they were masked.
-- 
2.35.1

