Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E032558A84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiFWVNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiFWVNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E7250B03
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so414652wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqID5x/tjmobIccvt6tf2g3gXW+2/FDTRjd9KrrHqF4=;
        b=WNeouhwZYUPPBBHO7307nHyxJ9XH1mT1cVB692WnpZFRrcCViR+9OjwGR1fSISBDcQ
         +fjtJBH9ryQ+z2qB4OcWcqQIYjitMM8UJxXY+nrOdy6WJn2926X1UDKizIRC+95k/Biy
         Y1VXgNSdvLxJB0uBNTQxKs40JCLW0s7hD5I+pzd1trSYYUEOR7X+iTX6/bxESJnn9tGh
         n/FwgloopEhy+vs3HaF35yipXR5BG6lCgJI60DNHb/hKcu3/jPxSmBpIx6QF8jK1W90f
         +O3Ush+nI0EG+72TNMo7H9Y/fI0SPCSkgW0kZLDK7pian6wFJTAkaQAKB/k0gl1Hiix6
         lL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqID5x/tjmobIccvt6tf2g3gXW+2/FDTRjd9KrrHqF4=;
        b=fELqrhtrXMCqiclXJzuXuEAjWALoOV+jU3VsBHPAV8PSStDzeRRgO7kZ9mEk9Fp8Kp
         YxjItsYexLwvuJIyKTWsKkEtXaP6WiY6/fy8WHTd3wR5ffaV2Z6kSnaRBTNEbzmZ04I2
         fp5TWH1JElE8NZxYxaqH0azTjYLEOaR1e2nM+eWEbMDPepbXTJfcMmi9qmUXlTjL4hnz
         +0w1ofevhSOODaJ2XMitnxyypm5QdZZH+JLqoGUTzPeHKac6qZIOjAwDidF8Bp8gxxWr
         YFfn5f7JxREn3wZVlvOrZggoc9RuntF+NjXBhzvlW087ZKuNU2iemu7UWuCO3HPLxI67
         RP9Q==
X-Gm-Message-State: AJIora+cFj1nQDTMwYIFVNejWw042C0OCWJVziavkysgU1yWaFyV8j2+
        SULu2qgDdBKS/QoUn7EvSjk=
X-Google-Smtp-Source: AGRyM1u0qTmDVNQgQjlHVSFDyEpSORhptzldhUSlvugxOT3R2t6PvpxsdIF5N2CbS35e9NDQJEYHGw==
X-Received: by 2002:a05:600c:19c9:b0:39c:72fc:9530 with SMTP id u9-20020a05600c19c900b0039c72fc9530mr6292709wmq.88.1656018812622;
        Thu, 23 Jun 2022 14:13:32 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id j3-20020adfe503000000b0021b8a0d680esm400194wrm.86.2022.06.23.14.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:32 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/12] regmap-irq: Remove an unnecessary restriction on type_in_mask
Date:   Thu, 23 Jun 2022 22:14:12 +0100
Message-Id: <20220623211420.918875-5-aidanmacdonald.0x0@gmail.com>
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

