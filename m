Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A3D558A89
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiFWVOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiFWVNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC3750B01
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v14so519768wra.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+h6m2WrlhLKh1rsIi7rtOncBT2rRMbfAs6nZpXF74k=;
        b=IEoepcsOLywRJfkzkeDDN4hUJr72gij73XggCt8M+g9XqH5VW8ON4SmJS81275UleT
         guluKyCWuTv+KYj6Q0hEo+8RH3yaJFDjrTw1DHkhGTezpRIKRZPU1dvnPrwjJTsTgfov
         D37YB111nUeWi7Rk2fPh+09yQzWNole7txWzwIkgAnIuqoONe9/6NVCchJyT9Q6xYuUg
         tzx9jedq4HQyIhhgw6juknHteusDtMXK9G/kuvmuU7Lj5CP7YBqrzZFRok5cDnOMmVQy
         tnAorlauwJTHLzfbPU9/1bTmyioJGuw5b5H4sumfvNq1+af3Y5jgvnyIjQnyTlsPk0Ox
         DVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+h6m2WrlhLKh1rsIi7rtOncBT2rRMbfAs6nZpXF74k=;
        b=FQYJ0zXj84jIdnqy3X+cB/ZJAuKQbZWj1VmEwMINKINNLwOfY2Outl80ffHAqnWHvL
         DdL5rYX+D+EtlAaFqTIoNPBNO1KkBtB8XrurJT9lcWD9nBYUTBM35dr8Np1pD7yCJlpy
         yAx11EQ0iGGyOAQS96Ol+BLtGFU+rETLX7ENP2R0wVs5NKjN7tPjB6M0IQO9HoHc0D2h
         6kZKxohDPgyJHS8wbjYTb53ZZUrGH3EqogHOyHbtrnDuxnpfNZ96MPGfsKm5dYUacIOS
         Uwnuesff7Op+vLJS6kEtC04Thp88mD0h5bqPCKttqgYVd923T4eN51ZkVpSJNkU1+a8l
         rgoQ==
X-Gm-Message-State: AJIora89p90I/rWxo43BkIefk4DZVpBHjz5zBMfFyCgzfvSiaWYrRB7w
        AGreuNwzDfvT4YMsUMZR6vk=
X-Google-Smtp-Source: AGRyM1stxdtjDnroLVt8emPiHyEHaaBd1/F/furJ9EGijU99d42NlszL/hF7Gy8C7a+G9bvFvSumOg==
X-Received: by 2002:a5d:4649:0:b0:218:4d6c:3f3f with SMTP id j9-20020a5d4649000000b002184d6c3f3fmr10199882wrs.148.1656018825629;
        Thu, 23 Jun 2022 14:13:45 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id c17-20020a05600c0ad100b003973ea7e725sm6371287wmr.0.2022.06.23.14.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:45 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/12] regmap-irq: Deprecate the not_fixed_stride flag
Date:   Thu, 23 Jun 2022 22:14:20 +0100
Message-Id: <20220623211420.918875-13-aidanmacdonald.0x0@gmail.com>
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

This flag is a bit of a hack and the same thing can be accomplished
using a custom ->get_irq_reg() callback. Add a warning to catch any
use of the flag.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 2 ++
 include/linux/regmap.h           | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 71de097847a7..a691553a0d6f 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -739,6 +739,8 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	}
 
 	if (chip->not_fixed_stride) {
+		dev_warn(map->dev, "not_fixed_stride is deprecated; use ->get_irq_reg() instead");
+
 		for (i = 0; i < chip->num_regs; i++)
 			if (chip->sub_reg_offsets[i].num_regs != 1)
 				return -EINVAL;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index ae5f1f7d4b5a..84ab1c32271f 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1493,8 +1493,10 @@ struct regmap_irq_chip_data;
  *                   registers before unmasking interrupts to clear any bits
  *                   set when they were masked.
  * @not_fixed_stride: Used when chip peripherals are not laid out with fixed
- * 		      stride. Must be used with sub_reg_offsets containing the
- * 		      offsets to each peripheral.
+ *		      stride. Must be used with sub_reg_offsets containing the
+ *		      offsets to each peripheral. Deprecated; the same thing
+ *		      can be accomplished with a @get_irq_reg callback, without
+ *		      the need for a @sub_reg_offsets table.
  * @status_invert: Inverted status register: cleared bits are active interrupts.
  * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
  *
-- 
2.35.1

