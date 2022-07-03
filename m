Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAE056470C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiGCLUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiGCLUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:20:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE7195BA;
        Sun,  3 Jul 2022 04:20:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j7so3824110wmp.2;
        Sun, 03 Jul 2022 04:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1j/DIF/Fnv8RPcb6VzAvPxanMn+C+wmq9yB73HToH5Q=;
        b=UsTYyk+6Jr2BmuDqwpyKYS8/Jig7Kaihh6axH9wvlIYALIplq7Bz+GIraW26OfVH2G
         CkW8ws2xwGlHI6YrTHZFN0yXonND/mxxKMb1Ct6rwqAyxAdfB5gye7wzMHsnBUHJhVhy
         lAZHRzEv1IlW5sEt/DBntYY87O/hd6dmGtgc9o3WBbxMfG+wNH8y2EDk99p3gWHhAh7M
         Q9zeh5uCnEKn0bLjnZ61tDeI4Q/R/VjFCwxEck+6gXAjufkeR67PjyMxVGEtHIvs3yKY
         uFFZTotEjyCu6Jf13z3APjs6w/Q+W5bnn5dqSeTl7m2YX8k8FOPqut15qIVkwk90j5gr
         zZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1j/DIF/Fnv8RPcb6VzAvPxanMn+C+wmq9yB73HToH5Q=;
        b=JCt1oazWZ6t5gjIXM5kT2Ld8nQCEOLb88IzEaoPCIUgmLLPYm/aREVNWTG6tu2+NuP
         1yWXvzrZgi7Z6Op0F5JvA6WdcLdBuQY+xW4vE668vg6eJ0wIg1lY7dM/YZCO5+3mhLjf
         t5iodMh1HLEz9plmZ192DXJ62LKnL77GYCgNvpLIk/hT14KR3FmkcE0mRVX7dHcsOy+R
         +UcAvBZ9UHTs/1bKRpTCxwg3P1VzwXlxiqb4aducckI/Z2Ai7zJi4nUDtpHU6GsahrpN
         qGGb16Ya0BvaF2QFBmCW++oY6KrXITBHwkt/TG+bFClCKZzFski5OE7ztXg8kMHjIntB
         gIfw==
X-Gm-Message-State: AJIora/45o/QnYCKg8UvifYRx7tqUyecTYGy4ZjCTGFkC6b0jAXRGsZA
        tOmIWlGnScngMt0z3wKD/z0n2vSwy3w=
X-Google-Smtp-Source: AGRyM1uwZvWD027BAhy4r7enluUTY5m/fwRJdDNoUNTe0KUJRHVRu5ipTusVaOHouuBGxQ1ovAbSWw==
X-Received: by 2002:a05:600c:4254:b0:3a1:6c19:f3aa with SMTP id r20-20020a05600c425400b003a16c19f3aamr24877321wmm.205.1656847213729;
        Sun, 03 Jul 2022 04:20:13 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c348800b00397623ff335sm16936118wmq.10.2022.07.03.04.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:20:13 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, krzk@kernel.org,
        m.szyprowski@samsung.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 02/12] regmap-irq: Remove unused type_reg_stride field
Date:   Sun,  3 Jul 2022 12:20:51 +0100
Message-Id: <20220703112101.24493-3-aidanmacdonald.0x0@gmail.com>
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

