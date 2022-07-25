Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177A580088
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiGYONC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiGYOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:12:58 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26CB15A1B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:12:56 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o12so13279134ljc.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+h68/UdQXXbMficXAC0iBgwRyN+X6qyYClrVNRZdi0=;
        b=a5it5baTS9WwQq1d7VrWZbgehHeGK5sYCQ2mo0nd+fdX0FGwc24xaHkXFCVxabfPYk
         gdIHpkJAgfVWuWRopgMHCDMlwn69CVd0v1Zaev+XlYu5100CBKwX6H9unqLrT4rMbPc5
         Rc8JHZ6fWhMBobS6QmLJA4ZX8fSAFt/xiztpQ6X65kaYRBEIZxCCyzzGnHFf1WYo2BBv
         GWFUlQUGrim4QdjS3YPrIR5+rXHWwiApvas3DwE8bo+h5c4q9sQv3c6+G5HJHTPGfpn6
         WaAUH0WKmZ+lpqJHPYj81JrARFLSRdD7EWqOI6YugOGFWZaWLoY7wk9r/WaesPs+ndZc
         3H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+h68/UdQXXbMficXAC0iBgwRyN+X6qyYClrVNRZdi0=;
        b=X+dgnOdJwm+d9GZbQGQCKyt85/rF+LJwKxKWdRcIBK/azrXazvmL0d4+lCUBQ40R/n
         rDO7Vpp2SFyTpys2XVuvMTi9Uj6GRxKEIrv9YmXklP2C74ts0HnjIt06HMlU7vrNBgah
         u1CnpOqBgH7gPt6g+zicwIdRKWkrvyxuliSdyuXw0ECdLbp0JP9RGPL79uGUncVt84Xm
         2fZ6ImjLYBMWTHAYvFGokruIZ5WLjNRkfjNnFYs5awgebnk45F/o7ytExHZOuEXXrb1s
         pazOsiknIHwYMT2shxeZCDXv+WqQeThMo7Xqar/92a1RsoXzNIBh+QxP+DDI5oh882Sh
         wXUg==
X-Gm-Message-State: AJIora9D/lRXzQNpfJFAej3KeMvE2inYvm4yJG749InzlxhTRn5WpFIr
        i0RPNBf9c0GpdfjuF3Exu7QR7g==
X-Google-Smtp-Source: AGRyM1vVJg8MWR/yH0SSItnoe/QPOUADD/h5EkOyFM41FS32BqVlV5hqs7/4fpeQrK36b7RFiU1V1Q==
X-Received: by 2002:a2e:a287:0:b0:25d:b515:430c with SMTP id k7-20020a2ea287000000b0025db515430cmr4558943lja.358.1658758375019;
        Mon, 25 Jul 2022 07:12:55 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id a9-20020a195f49000000b00489ec0d7636sm2676028lfj.110.2022.07.25.07.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 07:12:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2 v2] regmap: mmio: Support accelerared noinc operations
Date:   Mon, 25 Jul 2022 16:10:36 +0200
Message-Id: <20220725141036.2399822-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220725141036.2399822-1-linus.walleij@linaro.org>
References: <20220725141036.2399822-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newly added callback for accelerated noinc MMIO
to provide writesb, writesw, writesl, writesq, readsb, readsw,
readsl and readsq.

A special quirk is needed to deal with big endian regmaps: there
are no accelerated operations defined for big endian, so fall
back to calling the big endian operations itereatively for this
case.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes.
---
 drivers/base/regmap/regmap-mmio.c | 153 ++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 71f16be7e717..031ee91020e8 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -17,6 +17,7 @@ struct regmap_mmio_context {
 	void __iomem *regs;
 	unsigned int val_bytes;
 	bool relaxed_mmio;
+	bool big_endian;
 
 	bool attached_clk;
 	struct clk *clk;
@@ -160,6 +161,79 @@ static int regmap_mmio_write(void *context, unsigned int reg, unsigned int val)
 	return 0;
 }
 
+static int regmap_mmio_noinc_write(void *context, unsigned int reg,
+				   const void *val, size_t val_count)
+{
+	struct regmap_mmio_context *ctx = context;
+	int ret = 0;
+	int i;
+
+	if (!IS_ERR(ctx->clk)) {
+		ret = clk_enable(ctx->clk);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * There are no native, assembly-optimized write single register
+	 * operations for big endian, so fall back to emulation if this
+	 * is needed. (Single bytes are fine, they are not affected by
+	 * endianness.)
+	 */
+	if (ctx->big_endian && (ctx->val_bytes > 1)) {
+		switch (ctx->val_bytes) {
+		case 2:
+		{
+			const u16 *valp = (const u16 *)val;
+			for (i = 0; i < val_count; i++)
+				iowrite16be(valp[i], ctx->regs + reg);
+			break;
+		}
+		case 4:
+		{
+			const u32 *valp = (const u32 *)val;
+			for (i = 0; i < val_count; i++)
+				iowrite32be(valp[i], ctx->regs + reg);
+			break;
+		}
+#ifdef CONFIG_64BIT
+		case 8:
+			/* This is just too esoteric */
+			fallthrough;
+#endif
+		default:
+			ret = -EINVAL;
+			goto out_clk;
+		}
+	}
+
+	switch (ctx->val_bytes) {
+	case 1:
+		writesb(ctx->regs + reg, (const u8 *)val, val_count);
+		break;
+	case 2:
+		writesw(ctx->regs + reg, (const u16 *)val, val_count);
+		break;
+	case 4:
+		writesl(ctx->regs + reg, (const u32 *)val, val_count);
+		break;
+#ifdef CONFIG_64BIT
+	case 8:
+		writesq(ctx->regs + reg, (const u64 *)val, val_count);
+		break;
+#endif
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+out_clk:
+	if (!IS_ERR(ctx->clk))
+		clk_disable(ctx->clk);
+
+	return ret;
+}
+
 static unsigned int regmap_mmio_read8(struct regmap_mmio_context *ctx,
 				      unsigned int reg)
 {
@@ -241,6 +315,82 @@ static int regmap_mmio_read(void *context, unsigned int reg, unsigned int *val)
 	return 0;
 }
 
+static int regmap_mmio_noinc_read(void *context, unsigned int reg,
+				  void *val, size_t val_count)
+{
+	struct regmap_mmio_context *ctx = context;
+	int ret = 0;
+	int i;
+
+	if (!IS_ERR(ctx->clk)) {
+		ret = clk_enable(ctx->clk);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * There are no native, assembly-optimized write single register
+	 * operations for big endian, so fall back to emulation if this
+	 * is needed. (Single bytes are fine, they are not affected by
+	 * endianness.)
+	 */
+	if (ctx->big_endian && (ctx->val_bytes > 1)) {
+		switch (ctx->val_bytes) {
+		case 2:
+		{
+			u16 *valp = (u16 *)val;
+			for (i = 0; i < val_count; i++)
+				valp[i] = ioread16be(ctx->regs + reg);
+			break;
+		}
+		case 4:
+		{
+			u32 *valp = (u32 *)val;
+			for (i = 0; i < val_count; i++)
+				valp[i] = ioread32be(ctx->regs + reg);
+			break;
+		}
+#ifdef CONFIG_64BIT
+		case 8:
+			/* This is just too esoteric */
+			fallthrough;
+#endif
+		default:
+			ret = -EINVAL;
+			goto out_clk;
+		}
+	}
+
+	switch (ctx->val_bytes) {
+	case 1:
+		readsb(ctx->regs + reg, (u8 *)val, val_count);
+		break;
+	case 2:
+		readsw(ctx->regs + reg, (u16 *)val, val_count);
+		break;
+	case 4:
+		readsl(ctx->regs + reg, (u32 *)val, val_count);
+		break;
+#ifdef CONFIG_64BIT
+	case 8:
+		readsq(ctx->regs + reg, (u64 *)val, val_count);
+		break;
+#endif
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+out_clk:
+	if (!IS_ERR(ctx->clk))
+		clk_disable(ctx->clk);
+
+	return ret;
+
+	return 0;
+}
+
+
 static void regmap_mmio_free_context(void *context)
 {
 	struct regmap_mmio_context *ctx = context;
@@ -257,6 +407,8 @@ static const struct regmap_bus regmap_mmio = {
 	.fast_io = true,
 	.reg_write = regmap_mmio_write,
 	.reg_read = regmap_mmio_read,
+	.reg_noinc_write = regmap_mmio_noinc_write,
+	.reg_noinc_read = regmap_mmio_noinc_read,
 	.free_context = regmap_mmio_free_context,
 	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
 };
@@ -347,6 +499,7 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 #ifdef __BIG_ENDIAN
 	case REGMAP_ENDIAN_NATIVE:
 #endif
+		ctx->big_endian = true;
 		switch (config->val_bits) {
 		case 8:
 			ctx->reg_read = regmap_mmio_read8;
-- 
2.36.1

