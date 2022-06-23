Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356F3558A83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiFWVNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiFWVNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5731F506E0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r20so547593wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7iiZ1g2foyg+pIBZL+lLC+0n9kDHXAVzLQyCSVfDJ08=;
        b=g4Grn3YmGC1+IcwN8QObevjbd44d+989zZV+3JaTY0xt8f1ITTyHLY15SH3o3Pclfo
         jYDv4Vr7GOSZ05ufB0Br/B8EHSblAJr/fkGVc72codtkMdE1zq9PJbCd6sodW2TQSLum
         osZmiOCWEG6jhR3R0gbVnM4Izz2BwSG0aFlC+jqlPGEbGTFX/8j6HmecQ5jEumqbInp8
         sKZV22XFx1wYMMOAZMGgs+U351HVh/hct3l5X6lwd8hD8vS2MF+O2WY+nfspmYPLTxy7
         TD5hml3FtevOv1YsGFALikrAqkz1NrpKtR1VCfoejqakoB6HkBwfMAlJVNRI/aA36gXf
         9kLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7iiZ1g2foyg+pIBZL+lLC+0n9kDHXAVzLQyCSVfDJ08=;
        b=R+wTkg3D3gz5jPhO5voJBfuDgKwps2faq89fn1nhTN4EFO0J7QMlO0rIiGf3ggIGNW
         IWOOgBXn/t9LdFlHtzz9bdXmALs+qb3dcjvPqxhIUglgvCyaiUg30lrzgNk7msSQNgwJ
         Qps8TvThstsnloAhNdMtpYxjKoSKW7NLTQDrn8TzTqixi4u9wFIl30wuBPFH7nGwY67O
         +H26egCI2w5/H9Z3zXQ2aUZ+GvAMoyb3/H2C/rf3OYW/8N05b26RS2jyjgxsdWUnQKPP
         jpU2KBY6NmUJn+yFrI9bSqhkgnJCc1DuvRSwg06niGw4KMtQ/29syvBPTLR1S8Nb6c/l
         aQ/Q==
X-Gm-Message-State: AJIora/gOOMo0Drcs1Mg0HFxc3gxOHDTF1upXvgPEQx3M1kLxCOKimSR
        Ljn7bJLWctvzCR9v5N3yCeY=
X-Google-Smtp-Source: AGRyM1vHoi5qUwVQ7GRAfiQIs4odq2EG3Vef2E3QjtfiIxAnIND7243E1l5CFaj1TE5wf764TtYLEA==
X-Received: by 2002:adf:fa52:0:b0:21b:910d:cddd with SMTP id y18-20020adffa52000000b0021b910dcdddmr10192030wrr.291.1656018810933;
        Thu, 23 Jun 2022 14:13:30 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id ay26-20020a5d6f1a000000b0021baf5e590dsm412186wrb.71.2022.06.23.14.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:30 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/12] regmap-irq: Cleanup sizeof(...) use in memory allocation
Date:   Thu, 23 Jun 2022 22:14:11 +0100
Message-Id: <20220623211420.918875-4-aidanmacdonald.0x0@gmail.com>
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

