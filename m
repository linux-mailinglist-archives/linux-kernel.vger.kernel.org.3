Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E140D558A82
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiFWVNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWVNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E31E5130D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i67-20020a1c3b46000000b003a03567d5e9so593489wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qGHCihlNL7T5T1G7aMDu8MmDKY14zb9oDODHpK/qzo=;
        b=S1xehfFKO5ilpkywkeqlpTy+vnCc2lcbAhOiTJQSxZ3d/gTT/HgbPo2UWfbSSoVwTS
         DneIJA/68lETzir+R8relctPzs/1FJY//sJ84eG1WUkngGwjE5TUzt0qHAkcmismR+ZR
         91Ckvg8o4L2dVdrp+0IwKVuhSIAPcFT+PZUs1HYm3qHK0QF91ZRXMtJRod94Kz+HuHRY
         vRnBZGPXsVpX2L/sRWxb5oEhuueZ3keqOhrqj91YuFwvj3S7X22zBSkvVirK91TaAvfv
         Rk5lJGRiYNandi43Grk/gRA7cUaT7SUaMFsvZ51nQm3xhHlCrMYHXRG3fIaUaFo69/jZ
         uDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qGHCihlNL7T5T1G7aMDu8MmDKY14zb9oDODHpK/qzo=;
        b=anqCRdnL4u1v79YD3AGneAEfwotiljfUTvqj6vBOKwXvk9eOlzGYpqQt4p/xBOnKFl
         Gerl5fi/KNCYESUkfQHnB/Oy0pHhRu8HspUyxAA4lpr8RxD4mpI56dOUIYU0WZZ9zWRm
         BkQROt3JmL0P0A9Q++7n762twJh0pNyiqIm1Sf+CpLLyz6yzQ8hVVEz9ISRca6XagBA9
         6tXFXHmnVwrM14fXj1ge5ty1DgiVk4vqOtgjJRH7Grr5YJqFXzBKDHdP7g1X1TFF7PiE
         7PP22/j1GpGxE3kGkJD81N80hzBhC3wW/tMG6ZRFE37wo4ULtzQgmvcfizNrtsX1G+Wy
         61RA==
X-Gm-Message-State: AJIora9Qemmpf9onDkA+70lTAc+c//X8ShDW85cUO9sy33gUftONQUKV
        kPLpWppadRZr848lGswwP+0=
X-Google-Smtp-Source: AGRyM1s96y5jbOAruKIBOzv3fj3rhEH6KOs8iL9c93S8NUrIz/RFOi+AdNow2XwwmJ4ztQ3QS/BTSw==
X-Received: by 2002:a05:600c:35d2:b0:39c:8490:abbf with SMTP id r18-20020a05600c35d200b0039c8490abbfmr6439848wmq.86.1656018814254;
        Thu, 23 Jun 2022 14:13:34 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c26ca00b003973b9d0447sm5070837wmv.36.2022.06.23.14.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:33 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/12] regmap-irq: Remove inappropriate uses of regmap_irq_update_bits()
Date:   Thu, 23 Jun 2022 22:14:13 +0100
Message-Id: <20220623211420.918875-6-aidanmacdonald.0x0@gmail.com>
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

regmap_irq_update_bits() is misnamed and should only be used for
updating mask registers, since it checks the mask_writeonly flag.
However, it was also used for updating wake and type registers.

It's safe to replace these uses with regmap_update_bits() because
there are no users of the mask_writeonly flag.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index fd7c4315d16b..cb20ce6f91e7 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -158,11 +158,11 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		reg = sub_irq_reg(d, d->chip->wake_base, i);
 		if (d->wake_buf) {
 			if (d->chip->wake_invert)
-				ret = regmap_irq_update_bits(d, reg,
+				ret = regmap_update_bits(d->map, reg,
 							 d->mask_buf_def[i],
 							 ~d->wake_buf[i]);
 			else
-				ret = regmap_irq_update_bits(d, reg,
+				ret = regmap_update_bits(d->map, reg,
 							 d->mask_buf_def[i],
 							 d->wake_buf[i]);
 			if (ret != 0)
@@ -205,10 +205,10 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 				continue;
 			reg = sub_irq_reg(d, d->chip->type_base, i);
 			if (d->chip->type_invert)
-				ret = regmap_irq_update_bits(d, reg,
+				ret = regmap_update_bits(d->map, reg,
 					d->type_buf_def[i], ~d->type_buf[i]);
 			else
-				ret = regmap_irq_update_bits(d, reg,
+				ret = regmap_update_bits(d->map, reg,
 					d->type_buf_def[i], d->type_buf[i]);
 			if (ret != 0)
 				dev_err(d->map->dev, "Failed to sync type in %x\n",
@@ -825,11 +825,11 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			reg = sub_irq_reg(d, d->chip->wake_base, i);
 
 			if (chip->wake_invert)
-				ret = regmap_irq_update_bits(d, reg,
+				ret = regmap_update_bits(d->map, reg,
 							 d->mask_buf_def[i],
 							 0);
 			else
-				ret = regmap_irq_update_bits(d, reg,
+				ret = regmap_update_bits(d->map, reg,
 							 d->mask_buf_def[i],
 							 d->wake_buf[i]);
 			if (ret != 0) {
-- 
2.35.1

