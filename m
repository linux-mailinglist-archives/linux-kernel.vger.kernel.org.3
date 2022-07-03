Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649C6564712
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiGCLUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiGCLUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:20:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DA99FC7;
        Sun,  3 Jul 2022 04:20:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q9so9456141wrd.8;
        Sun, 03 Jul 2022 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qGHCihlNL7T5T1G7aMDu8MmDKY14zb9oDODHpK/qzo=;
        b=mDSFIrmEh3iCggKyQQ342Lh7aDiPqeH6ELx3zx81FkUZA2xWShm82noN5JDWSXKfd0
         lroYsULAVn7MnlCzEvor26gXErCbaAo5y2GHuwtxWHN00fM8QgVFcqOHZksHGmJmdnFv
         pAFPiH6TuRKdJqRVilw8g4014k1BE8qx2xh4KVTtW96q+XaVaqNNaRxmhfuyP7HGqfFp
         qdQ5GM16CBi/TzuogVPFg5S/OxvAUzNAyrGKMZtgtPCilT6rDeJ9KmZQXAm/IGq2KZ3I
         4WV8/UIhGx6RmaP6irKxKL0BWP4IOu8BULLHQV3oh+TKoBSjboGK65eHgc124K6Hd/rF
         IgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qGHCihlNL7T5T1G7aMDu8MmDKY14zb9oDODHpK/qzo=;
        b=lKdAG/sQIwsMDaPsPyyR3dtVL+T7i3eykZiuLJ+c4KTEylKJlZckMUX9VlBVEVbQmT
         W1IhcxwkxS30L2As3BpiDnaG+aVSTAQv21aZ8/ayG/d/EqY2SUMu2N7hZiLNJ6sIRpud
         KKyfcTxv9x19bSAAgoNXAPD8sQGSPHBnEqrxUnu6aPAU9L3eDQKZhuAMnZe77TmdIHtv
         FtHanTUy8bw5BR7NVQGUEt/dYpXT05O079M4TWDo1jxyf/Ss0Rv3k0LMhehmpv295aED
         rPzQAahhg+0hn+Cwl5MFkohvMEP1bGKh+FSlUM7MH4oN/euLGGLGUwJIaPutzDM5gV+6
         f0/g==
X-Gm-Message-State: AJIora9X0o51/piiolnaDAA8nJeESBY/+7iwNUJovgi1AUAWcEmgUCJN
        g4PXdaLeEoA+i5dKwTwg4m0=
X-Google-Smtp-Source: AGRyM1s0pSQbc35l3UIcCC5dxYRuJKUNwus2ZoTRJTvM1QfVMbun5o/ZzSvDe7WKsCprPPHG/fylnA==
X-Received: by 2002:adf:dbc1:0:b0:219:e994:6ba7 with SMTP id e1-20020adfdbc1000000b00219e9946ba7mr21880459wrj.229.1656847218368;
        Sun, 03 Jul 2022 04:20:18 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d67c7000000b0021b9e8d4c22sm27314305wrw.61.2022.07.03.04.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:20:18 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, krzk@kernel.org,
        m.szyprowski@samsung.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 05/12] regmap-irq: Remove inappropriate uses of regmap_irq_update_bits()
Date:   Sun,  3 Jul 2022 12:20:54 +0100
Message-Id: <20220703112101.24493-6-aidanmacdonald.0x0@gmail.com>
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

