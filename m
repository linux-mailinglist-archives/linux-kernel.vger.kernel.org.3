Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D998C564717
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiGCLUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiGCLUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:20:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2899A458;
        Sun,  3 Jul 2022 04:20:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o4so9471974wrh.3;
        Sun, 03 Jul 2022 04:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGdqQ4oAuggJEmpNM1D1Sw+hLvuTVREq9oE+Alw71tA=;
        b=EG+vkCFgVJoNQmekAArWwhAIumrg5B9uWzpello5Vp+bS2/wq4tdmTeIUPTizpCB75
         ZKndRpeWlUGYYWnRKCkM3mUqQ03DggomNogks1Tk0/PmueWOvqbBSiNtmri1j87Ga0+B
         ZbB3tj6DXGApQCCQRFGbSWja7kdb8NVRKlz6/hhGePxSA/NrMJz5YcqhyRugr8coFW5S
         nKutK5XQq+JMPOVWBH3JyJY9JJpH7LUmmOPIJfLVEkUnKiaLURHIKRJlRDuw22MAZCdj
         KBEVD1bvV2LdHFIt7qimYhPKGhivQFDaMGTFix6jdNQU8hniPzLclR4YG+zh2l7N9ydx
         d2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGdqQ4oAuggJEmpNM1D1Sw+hLvuTVREq9oE+Alw71tA=;
        b=o/N6fSIu/RXxrHnfnt2XmoAIS+A5NzvLL7KHBBbj1mh5jBJYO+LvmiJLB1cOjQj7ha
         pwztGnxG6eduVd7mrz3MxWJPqojoBaN036GBpg4AiUkinjVPSCnQKT5vtPlPhfvCNoas
         z3ZxsHjRK8w05Bg5ALTtYH13q0vK5Gn4noBUzt759912CfLUXP/eu0OMECyD6NOhEdQ7
         a1lGHWtYAqJ3haXeCTj7hObwgU47TUklHv5kSo4ttbAGd0AK0fB30Yg5MGXpDIHAi772
         LXobbuxL49YoK1ifepOAs+Q0+zCxaN7oYR/s5XLHWS9eRaYH428XFgcoy3y2WxSuCPD/
         wk4A==
X-Gm-Message-State: AJIora9IoT2FVTzCmvqh5fFnadu3j+JG/lWzmVBfpAPavOHqthCcoYMV
        yHnQrPJjk1+9AyrUrvSml/M=
X-Google-Smtp-Source: AGRyM1ujFOaT8twkJWv+8aYHlazN6/7EE9xBdAmm4iYAMFxEvQ353Bu1GuiUrBByM7FG1VBhjY3HjQ==
X-Received: by 2002:a5d:4d8e:0:b0:21d:68d4:56eb with SMTP id b14-20020a5d4d8e000000b0021d68d456ebmr1571358wru.40.1656847221425;
        Sun, 03 Jul 2022 04:20:21 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm26735987wrr.101.2022.07.03.04.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:20:20 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, krzk@kernel.org,
        m.szyprowski@samsung.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 07/12] regmap-irq: Refactor checks for status bulk read support
Date:   Sun,  3 Jul 2022 12:20:56 +0100
Message-Id: <20220703112101.24493-8-aidanmacdonald.0x0@gmail.com>
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

There are several conditions that must be satisfied to support
bulk read of status registers. Move the check into a function
to avoid duplicating it in two places.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 7e93dd8af56b..5f9a5856c45e 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -73,6 +73,14 @@ struct regmap_irq *irq_to_regmap_irq(struct regmap_irq_chip_data *data,
 	return &data->chip->irqs[irq];
 }
 
+static bool regmap_irq_can_bulk_read_status(struct regmap_irq_chip_data *data)
+{
+	struct regmap *map = data->map;
+
+	return data->irq_reg_stride == 1 && map->reg_stride == 1 &&
+	       !map->use_single_read;
+}
+
 static void regmap_irq_lock(struct irq_data *data)
 {
 	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
@@ -467,8 +475,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 			}
 
 		}
-	} else if (!map->use_single_read && map->reg_stride == 1 &&
-		   data->irq_reg_stride == 1) {
+	} else if (regmap_irq_can_bulk_read_status(data)) {
 
 		u8 *buf8 = data->status_reg_buf;
 		u16 *buf16 = data->status_reg_buf;
@@ -729,8 +736,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	else
 		d->irq_reg_stride = 1;
 
-	if (!map->use_single_read && map->reg_stride == 1 &&
-	    d->irq_reg_stride == 1) {
+	if (regmap_irq_can_bulk_read_status(d)) {
 		d->status_reg_buf = kmalloc_array(chip->num_regs,
 						  map->format.val_bytes,
 						  GFP_KERNEL);
-- 
2.35.1

