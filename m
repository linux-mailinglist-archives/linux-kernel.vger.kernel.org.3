Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC832564713
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiGCLU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiGCLUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:20:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB899FCB;
        Sun,  3 Jul 2022 04:20:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j7so3824135wmp.2;
        Sun, 03 Jul 2022 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7iiZ1g2foyg+pIBZL+lLC+0n9kDHXAVzLQyCSVfDJ08=;
        b=AF3/N+VlWriwsqQjDN0LQU4rlOeuHMpEIODcmvPhddblcXdFnt7gcZz8sTZKyXH6wb
         7OaHzDG5Rs29DCZvquL6MAG8grJ3gIAwWn8emtVMV5TIP4Sk+LgC4EATGWipAKmv9zfj
         /LJXfw04Pe4RqHYCL2EqcgrhKikHVlnWIKgiMP+z9D76j2Ju4DMe4kcAP/lSh1W9bTq+
         pOy6iCn0qCsDEOFUL2IxFAPNIIiQr2x88iZ+bhaxPIyftWN7kfDdGGCLYQFOMjNvf1hU
         v2QMbiV90ZCkXg/Tg/wj+ijCC9qm4xlnDhDhpD6hmp76sfqZILNTAvYZfl8AhTRtQ8XH
         zuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7iiZ1g2foyg+pIBZL+lLC+0n9kDHXAVzLQyCSVfDJ08=;
        b=FHeRcrShpdzNtckc20GMGkn4/lmgOjWWACIPRxr2PCwql4hH7Mf4WDA4z8sZOcpa2a
         SX3/ovDnz8oVpBYe4VARHrBNaQoOkEGfpc4ke8KTKE29HKYYr8LHzGdeY71YXh1LsotA
         NbplrlRInMMk/Z3b10S/4WM35rSmprBpTtICAe3o0iaVOfwLLYkxCxaJcNFnSgUS1Z/0
         PO5AXJ+fTJAACwvunLog5/L9cQBRJlZcm7xmQhT+uettjfl/ssx7ZK365SpGaXTx+3iy
         eVFT0qwQ8s3hHkLtdkUFQ/bRXf3PqRudDwSGCfZSphG93cC2eO5J56lVyTmYwErcPPhM
         3muQ==
X-Gm-Message-State: AJIora++joiob4OHYuLzxpR6FE0kcjlYPgoZ7lnCRtXQw0HLcfpTgAMu
        24i30MkJBUDDM45mxSs2hjk=
X-Google-Smtp-Source: AGRyM1uNt9ZqHL3Y8zHeW7d3UlPenLhPi6dVF1jSG88DC1y8dXGqolI6pe2pXJMV6Ei3zPJVL4ZPuw==
X-Received: by 2002:a05:600c:a02:b0:39c:97cc:82e3 with SMTP id z2-20020a05600c0a0200b0039c97cc82e3mr27666501wmp.97.1656847215255;
        Sun, 03 Jul 2022 04:20:15 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b003a04d19dab3sm15194653wms.3.2022.07.03.04.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:20:14 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, krzk@kernel.org,
        m.szyprowski@samsung.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 03/12] regmap-irq: Cleanup sizeof(...) use in memory allocation
Date:   Sun,  3 Jul 2022 12:20:52 +0100
Message-Id: <20220703112101.24493-4-aidanmacdonald.0x0@gmail.com>
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

Instead of mentioning unsigned int directly, use a sizeof(...)
involving the buffer we're allocating to ensure the types don't
get out of sync.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 475a959e2b8b..dca27b4e29d3 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -670,30 +670,30 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 
 	if (chip->num_main_regs) {
 		d->main_status_buf = kcalloc(chip->num_main_regs,
-					     sizeof(unsigned int),
+					     sizeof(*d->main_status_buf),
 					     GFP_KERNEL);
 
 		if (!d->main_status_buf)
 			goto err_alloc;
 	}
 
-	d->status_buf = kcalloc(chip->num_regs, sizeof(unsigned int),
+	d->status_buf = kcalloc(chip->num_regs, sizeof(*d->status_buf),
 				GFP_KERNEL);
 	if (!d->status_buf)
 		goto err_alloc;
 
-	d->mask_buf = kcalloc(chip->num_regs, sizeof(unsigned int),
+	d->mask_buf = kcalloc(chip->num_regs, sizeof(*d->mask_buf),
 			      GFP_KERNEL);
 	if (!d->mask_buf)
 		goto err_alloc;
 
-	d->mask_buf_def = kcalloc(chip->num_regs, sizeof(unsigned int),
+	d->mask_buf_def = kcalloc(chip->num_regs, sizeof(*d->mask_buf_def),
 				  GFP_KERNEL);
 	if (!d->mask_buf_def)
 		goto err_alloc;
 
 	if (chip->wake_base) {
-		d->wake_buf = kcalloc(chip->num_regs, sizeof(unsigned int),
+		d->wake_buf = kcalloc(chip->num_regs, sizeof(*d->wake_buf),
 				      GFP_KERNEL);
 		if (!d->wake_buf)
 			goto err_alloc;
@@ -702,11 +702,11 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	num_type_reg = chip->type_in_mask ? chip->num_regs : chip->num_type_reg;
 	if (num_type_reg) {
 		d->type_buf_def = kcalloc(num_type_reg,
-					  sizeof(unsigned int), GFP_KERNEL);
+					  sizeof(*d->type_buf_def), GFP_KERNEL);
 		if (!d->type_buf_def)
 			goto err_alloc;
 
-		d->type_buf = kcalloc(num_type_reg, sizeof(unsigned int),
+		d->type_buf = kcalloc(num_type_reg, sizeof(*d->type_buf),
 				      GFP_KERNEL);
 		if (!d->type_buf)
 			goto err_alloc;
@@ -723,7 +723,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 
 		for (i = 0; i < chip->num_virt_regs; i++) {
 			d->virt_buf[i] = kcalloc(chip->num_regs,
-						 sizeof(unsigned int),
+						 sizeof(**d->virt_buf),
 						 GFP_KERNEL);
 			if (!d->virt_buf[i])
 				goto err_alloc;
-- 
2.35.1

