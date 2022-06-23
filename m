Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98799558A81
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiFWVNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWVNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B255F506DB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s1so493155wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1j/DIF/Fnv8RPcb6VzAvPxanMn+C+wmq9yB73HToH5Q=;
        b=MRkzlNJ6E7f7MsWd8tjufz+IN8bN9Gu64Hs8WWp8eQvKuAZzORqec28MAjjHoGWV8d
         ystjzntlOsSgckx/re43dmwR1khxqCIlOD2P01rOamRvzYHU+X40XcpGGoq3XCzrse91
         hwRQDelZWmsI7AEusxCUNl3WK8ke7MnXkfeRGF9SzBZEwKaa8LJdEic/MvUjOonYVfsx
         ojA2b1/2AUTFEnWn0H8Zi9VX4WnX3TbcO3lkcPvgBLNQxqKzqHuuE0rQMckKBY0LicPm
         vBurKPahZijnxOP5KruOrpwc5Xy/Ut+EZO2hMf7OHCywbHlrCPjTGyHyIcMl4/s0KagL
         1e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1j/DIF/Fnv8RPcb6VzAvPxanMn+C+wmq9yB73HToH5Q=;
        b=acqyjp7d8QO7ENX7fH//2wz7Y1SUlaD7YiFXrM5vgsZNFXelNL/UkAqIY79uPu/s6Y
         856DSAoZWk/RcGe9//PjKbd0mx/86P9yGCC8CaGNYjKsTRTSgevF+fAVo1hY4AQQdwcI
         9oihq7dvplhIa9F6sxWjbuw+EZMcW2Cbb7L8ZQ0EMaooLO9roJIb2YwBYrM/SqL//8n0
         xt95y4j7dQgVF1GA5gwoZnUzqx5t0zPvqzAZd4mGpPii1CeVZ5rDSjeG0p0s8IeTPiwA
         PjNY6iiSrCDfZ0pgE6QrCrJyCFviSyZ91eqLUHhALK3D3hZWNtAEEKZjLMxGKdRa9mCu
         2D9g==
X-Gm-Message-State: AJIora+hYyRSNQ7IpOJ5vsOBytXUDgXGyfiiGNFXl12PT5xXyU1T97su
        BZahsZ5uCt4IyATxBDSMjL8=
X-Google-Smtp-Source: AGRyM1uzR/LHMsuFGT4K5Q38BYjn0O+T5c3D1I/X4JlnrKKqsw5B6YopRiqGEK7YhtwkaXbCHU9hRQ==
X-Received: by 2002:a5d:4352:0:b0:213:4910:6616 with SMTP id u18-20020a5d4352000000b0021349106616mr10053266wrr.226.1656018809319;
        Thu, 23 Jun 2022 14:13:29 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b0020fcaba73bcsm388885wri.104.2022.06.23.14.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:28 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] regmap-irq: Remove unused type_reg_stride field
Date:   Thu, 23 Jun 2022 22:14:10 +0100
Message-Id: <20220623211420.918875-3-aidanmacdonald.0x0@gmail.com>
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

It appears that no chip ever required a nonzero type_reg_stride
and commit 1066cfbdfa3f ("regmap-irq: Extend sub-irq to support
non-fixed reg strides") broke support. Just remove the field.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 6 ------
 include/linux/regmap.h           | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index a58b29e9c7c7..475a959e2b8b 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -41,7 +41,6 @@ struct regmap_irq_chip_data {
 	unsigned int **virt_buf;
 
 	unsigned int irq_reg_stride;
-	unsigned int type_reg_stride;
 
 	unsigned int clear_status:1;
 };
@@ -743,11 +742,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	else
 		d->irq_reg_stride = 1;
 
-	if (chip->type_reg_stride)
-		d->type_reg_stride = chip->type_reg_stride;
-	else
-		d->type_reg_stride = 1;
-
 	if (!map->use_single_read && map->reg_stride == 1 &&
 	    d->irq_reg_stride == 1) {
 		d->status_reg_buf = kmalloc_array(chip->num_regs,
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 7c5e4a20e9cf..f75911239977 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1487,8 +1487,6 @@ struct regmap_irq_sub_irq_map {
  * @num_type_reg:    Number of type registers.
  * @num_virt_regs:   Number of non-standard irq configuration registers.
  *		     If zero unsupported.
- * @type_reg_stride: Stride to use for chips where type registers are not
- *			contiguous.
  * @handle_pre_irq:  Driver specific callback to handle interrupt from device
  *		     before regmap_irq_handler process the interrupts.
  * @handle_post_irq: Driver specific callback to handle interrupt from device
@@ -1539,7 +1537,6 @@ struct regmap_irq_chip {
 
 	int num_type_reg;
 	int num_virt_regs;
-	unsigned int type_reg_stride;
 
 	int (*handle_pre_irq)(void *irq_drv_data);
 	int (*handle_post_irq)(void *irq_drv_data);
-- 
2.35.1

