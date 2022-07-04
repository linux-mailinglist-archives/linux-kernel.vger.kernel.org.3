Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C3456535C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiGDL1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGDL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:27:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37AB101F8;
        Mon,  4 Jul 2022 04:27:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e28so13091515wra.0;
        Mon, 04 Jul 2022 04:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nLBwX9kmE6hVcbXFLM7taHZTXSthvde/fcG/HY4cqc=;
        b=L+lAr+nu0qFALxH31vzInvRfJqJnXaiYiC6WDHr9fb0COCPrFN8jAgMAi63RngWbdI
         Fb6ZhEPEgaaA81dc4vQast4E8jf6kbG4V9bqCQBopfCcAwB/TOakzUaBw1fCm3udQPCU
         386zFEKkoFyBrrT5RD/rRtkX2tVDfEHvGHkI4RvAZfmwte9RPQptFnShqrkn5z4Zseb9
         rbng94Jjs9mgJg0cf4EM7nyyUcq/IRqATJSVZlqYMhpbGEMRkgC6L7x99WNUeeGZr78S
         lT2V+4W49amnvoKdWgDvDvzAhhHO/XR/Pu2P1aMD4AUzwz0EW2jNcLP7/tMcoIRpbL1D
         MEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nLBwX9kmE6hVcbXFLM7taHZTXSthvde/fcG/HY4cqc=;
        b=Qnb3Gc4HDw3vlbBbgj2x9kOMwtO+ftvGN4fh3TvemlMHKtgohRyJ1MUk9HLnrt/O+f
         ETZzoPnVskJArqIepvZVv1kxNFoJiA3n6K65BnG/YFqOFs+CiVKLwXbJoTbL1uOm5lAo
         z+6BecC19kE6sf73w9FRuUQ+LUXE+c+cXHuHqGCMB5j5lf+hLheZ7+83hyeATjj4Jtum
         DapwZyhuplJGkox8VVCLoW0gQ0/zBSqZJkFHZ8VVK74veSpbDsqbyncW+1sxHvopjpC9
         Mg3i6m8GlaB0aqYVikquDqcmNSap4bbF6/UdI3zTcsMkau21xBKGSQtQfkqOUSYnh6fH
         BVRw==
X-Gm-Message-State: AJIora/G/aCWsRNdDbVA0FceT55dkfJ2VETNnadswfrp8znWRMdX4NGT
        481oi5bhjR0dp6ldGvzF8zOH4I/MJ2g=
X-Google-Smtp-Source: AGRyM1v3/P4N+m+dpj/ZHDjm/AElzPHfA9AamezuYAQ02h/7nQPZZFlut747WmZcyWynZI6UK2Dz8g==
X-Received: by 2002:a5d:5088:0:b0:21b:a045:972f with SMTP id a8-20020a5d5088000000b0021ba045972fmr26164695wrt.95.1656934067306;
        Mon, 04 Jul 2022 04:27:47 -0700 (PDT)
Received: from localhost (92.40.202.48.threembb.co.uk. [92.40.202.48])
        by smtp.gmail.com with ESMTPSA id a2-20020adfbc42000000b0021ba1b6186csm33281671wrh.40.2022.07.04.04.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 04:27:46 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     andy.shevchenko@gmail.com, m.szyprowski@samsung.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH] regmap-irq: Fix bug in regmap_irq_get_irq_reg_linear()
Date:   Mon,  4 Jul 2022 12:28:47 +0100
Message-Id: <20220704112847.23844-1-aidanmacdonald.0x0@gmail.com>
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

irq_reg_stride in struct regmap_irq_chip is often 0, but that
actually means to use the default stride of 1. The effective
stride is stored in struct regmap_irq_chip_data->irq_reg_stride
and will get the corrected default value.

The default ->get_irq_reg() callback was using the stride from
the chip definition, which is wrong; fix it to use the effective
stride from the chip data instead.

Link: https://lore.kernel.org/lkml/acaaf77f-3282-8544-dd3c-7915fc1a6a4f@samsung.com/
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index a691553a0d6f..4ef9488d05cd 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -636,7 +636,7 @@ unsigned int regmap_irq_get_irq_reg_linear(struct regmap_irq_chip_data *data,
 		return base + subreg->offset[0];
 	}
 
-	return base + index * map->reg_stride * chip->irq_reg_stride;
+	return base + index * map->reg_stride * data->irq_reg_stride;
 }
 EXPORT_SYMBOL_GPL(regmap_irq_get_irq_reg_linear);
 
-- 
2.35.1

