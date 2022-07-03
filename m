Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AEF56471B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiGCLUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiGCLUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:20:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7780295B5;
        Sun,  3 Jul 2022 04:20:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v14so9469610wra.5;
        Sun, 03 Jul 2022 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oky3YgKKfNXCQVslFZi4xoyuek1RvMVadIY0VBZTguA=;
        b=lpOSvTd0mAYDGb//x5zEvoOwU/rHy4WR7/+BvxY2xqoMfI8LB+oT+ohMUO/f8j4qM7
         dE2F9Ff12mPlOEVNc6RtRdX17AShgCaMrdY52lwQt6OU/HWDCI7qVCffL4IMxeiTWhoc
         9Z76m1THTAyAmF7rQF8vdM75dnE9dk9eEOkWNpuqMFamUOGhgLiS6Ub6r8NkVq27k6bf
         jBYHvzhJ+om5mANoOw/RDJdv9tde7s5rRqKEp2BjxEhD+sIH5CHNUrGg9oEcEB4ONN/0
         h3iTGqzA88M9vBj0zI3PNGu1sKnc9phq39Xu7fTk6fXMAQ0BRdQlCEiJF6wBHfz2YPdL
         JWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oky3YgKKfNXCQVslFZi4xoyuek1RvMVadIY0VBZTguA=;
        b=PYHfeZlzmxTcwnY5klbft2/qUu92Arxqietl7TngcArv22Dk+G93aSmBojGrZW+XK1
         rkQgMU+dSEDsk4JMR/qDDmXxHcK9ibJqTevJQwFdKIWIc15y/iOe8cFmkTSiL6XaqwHp
         dxVuXW+yNL0VRj8uFwOZe6FQUQsVO+BwQbiQ+PCX376hW+iYyQa1tjGkwdDYxOjvDwCg
         pQnUXKHw1WYEx8JRm83uTWXrBmgqadvKrit8h5HazxSTHg5mkfGT5xHDQcIE+9WudeJL
         N8ohMxwIQJtM2yMYMsxTEFHhE6iPs7hhAy8JYVmwX6THLyIXb2MowIKUhHtDbdlI2w8z
         yfFg==
X-Gm-Message-State: AJIora9R/QVBxtCiRYfy7Uef+3MT+xvkvvFoAutYy8a5pPP6jgQk3n9G
        RIFdUtepcINv6t5s0uLCJOg=
X-Google-Smtp-Source: AGRyM1sw2ixdXyl8YxX0sNYLCwi3+d2i86gtrFRsb0J/c4Y5b7ori14ll7nRTGrDw1Q0JsaQ0yHPVw==
X-Received: by 2002:a05:6000:38f:b0:21b:aded:e791 with SMTP id u15-20020a056000038f00b0021badede791mr20980183wrf.225.1656847212119;
        Sun, 03 Jul 2022 04:20:12 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003a02f957245sm10437466wmq.26.2022.07.03.04.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:20:11 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, krzk@kernel.org,
        m.szyprowski@samsung.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 01/12] regmap-irq: Convert bool bitfields to unsigned int
Date:   Sun,  3 Jul 2022 12:20:50 +0100
Message-Id: <20220703112101.24493-2-aidanmacdonald.0x0@gmail.com>
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

Use 'unsigned int' for bitfields for consistency with most other
kernel code.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c |  2 +-
 include/linux/regmap.h           | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index a6db605707b0..a58b29e9c7c7 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -43,7 +43,7 @@ struct regmap_irq_chip_data {
 	unsigned int irq_reg_stride;
 	unsigned int type_reg_stride;
 
-	bool clear_status:1;
+	unsigned int clear_status:1;
 };
 
 static int sub_irq_reg(struct regmap_irq_chip_data *data,
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 8952fa3d0d59..7c5e4a20e9cf 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1518,19 +1518,19 @@ struct regmap_irq_chip {
 	unsigned int type_base;
 	unsigned int *virt_reg_base;
 	unsigned int irq_reg_stride;
-	bool mask_writeonly:1;
-	bool init_ack_masked:1;
-	bool mask_invert:1;
-	bool use_ack:1;
-	bool ack_invert:1;
-	bool clear_ack:1;
-	bool wake_invert:1;
-	bool runtime_pm:1;
-	bool type_invert:1;
-	bool type_in_mask:1;
-	bool clear_on_unmask:1;
-	bool not_fixed_stride:1;
-	bool status_invert:1;
+	unsigned int mask_writeonly:1;
+	unsigned int init_ack_masked:1;
+	unsigned int mask_invert:1;
+	unsigned int use_ack:1;
+	unsigned int ack_invert:1;
+	unsigned int clear_ack:1;
+	unsigned int wake_invert:1;
+	unsigned int runtime_pm:1;
+	unsigned int type_invert:1;
+	unsigned int type_in_mask:1;
+	unsigned int clear_on_unmask:1;
+	unsigned int not_fixed_stride:1;
+	unsigned int status_invert:1;
 
 	int num_regs;
 
-- 
2.35.1

