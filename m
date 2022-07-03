Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CABD56470A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiGCLVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiGCLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:20:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A16B7C0;
        Sun,  3 Jul 2022 04:20:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id cl1so9474879wrb.4;
        Sun, 03 Jul 2022 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JSeaD64riMMLU3xw2mm2bmS0baE0x58eQS41zf6Qnu0=;
        b=IvngK6zY4QswSanQABqWYGe7YMdqj/q7i3LBZVz+KfDBXbtRp95tNRCS3u0Da4P9Gy
         V9UVzi+fB1kGbtNSoxjcChcu84rRrl7SMUHzO79shtjCWr2EVcB2yjF6y6dGmK2pn4Mw
         PvL/d+PkMK5NVFs2PnhIlKL4Nt70wWAF61nCpoAp8qvRrreG6tazQ/9YsUpNYa5lV7yN
         hDe8zxELwBmaDWTKbyoqxcSaQmsg3jLXk8GFAI4Y+SmN1k/K69yvfVseXNKWIN3pKAz3
         LUIGp6MK7sxY2kq26dO/AlkfJNTvmIe76aApRzUK4apWWQ1uDyw4UhOsTZ4UcGZulqip
         wqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSeaD64riMMLU3xw2mm2bmS0baE0x58eQS41zf6Qnu0=;
        b=DfSJfTP1/hlZM9tnDJus6T7bIenugf8bDJ8/qUdYvkq/wSDqIG78Nl8uTjC9fkMzIt
         MCYgZQtwga/LM0WPM0tdiLAHTkWaYeHwCrhzJtW/E/jIjz9JLUNe7i7Z7V0NqNXzK2R/
         XZ0XOIrLjsAUsDk7vjxUFdKqC+M2xhyPqYFxESIesBbdlS8KYv5h8R/3RMa4/f23az4Y
         Lli6bnuqp0JjSj8QKvdxRdCb89rHNaPxUWKkB3XchS0IAm7AqBcoc4TwzvjRGg6aszba
         LN0GNFQM6KYNURvO5Ownwj/yw+wbWVrk4t+/dmDgmw1f1K0wt9seXWi+h7alGdl5SKay
         qb6w==
X-Gm-Message-State: AJIora/M9C70PZFrKATE9WWtB3QbFXJFc2Pp0QkPuvbG856vwc1u2Jmz
        cxm3ruZI4Y9sdb0Fz2Lx5kDyPv5L1Oc=
X-Google-Smtp-Source: AGRyM1vfFRXdcslPSESxqaiTw6RugkIwo3UCXszSV+8qL3sm+Tc+NicFE9/Dr/i+sTavYkRSAzO1pw==
X-Received: by 2002:a5d:65c3:0:b0:21b:bca9:83b1 with SMTP id e3-20020a5d65c3000000b0021bbca983b1mr22067425wrw.568.1656847229989;
        Sun, 03 Jul 2022 04:20:29 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id ba15-20020a0560001c0f00b0021bae66362esm24186703wrb.58.2022.07.03.04.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:20:29 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, krzk@kernel.org,
        m.szyprowski@samsung.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 12/12] regmap-irq: Deprecate the not_fixed_stride flag
Date:   Sun,  3 Jul 2022 12:21:01 +0100
Message-Id: <20220703112101.24493-13-aidanmacdonald.0x0@gmail.com>
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

This flag is a bit of a hack and the same thing can be accomplished
using a custom ->get_irq_reg() callback. Add a warning to catch any
use of the flag.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 2 ++
 include/linux/regmap.h           | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index ec658755dd1b..4ef9488d05cd 100644
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

