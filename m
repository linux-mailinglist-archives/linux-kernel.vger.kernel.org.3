Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5045F58CF3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244502AbiHHUe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244420AbiHHUeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:34:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12C11ADAF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659990848; x=1691526848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3yeeouUXhmPOEmayGL2Ar0HGqC8NKQqj9/+RQV8UZu8=;
  b=b/9N4aMMuDtQdSbXCJcf1DsGLiDmtUp7gbI+NLrqV55FNdFvK3qvZFq3
   RNfIU0DpuaTl1nqcNOBHPz1MG2S7VDnzNyYEeBU8g+XA6K+ICP2QtyIMI
   ox1Zn4qOd1U3UByTteWwdYW1gpoW6upwN4sNp22BwVBSWKXhWTqM1a7aL
   /DaQhQR3NhNTJygHbcTYZ1feTbY+bFhNYhSMtI2xMw86nzQAkmVIHqrXK
   7hrGU0Tv7Lpo7luIBKlQCNQvwaYUpCLbIv5OEImpgUz3ba8DP4PAUoJ24
   G39AnoeNBup39cb+h/ES3qxk8OBlHqKHHtwDA45NZ7UECIqazb1AyZdmO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="288250841"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="288250841"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 13:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="607969134"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 Aug 2022 13:34:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 63342F7; Mon,  8 Aug 2022 23:34:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 3/4] regmap: mmio: Introduce IO accessors that can talk to IO port
Date:   Mon,  8 Aug 2022 23:33:59 +0300
Message-Id: <20220808203401.35153-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808203401.35153-1-andriy.shevchenko@linux.intel.com>
References: <20220808203401.35153-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users may use regmap MMIO for IO ports, and this can be done
by assigning ioreadXX()/iowriteXX() and their Big Endian counterparts
to the regmap context.

Add IO port support with a corresponding flag added.

While doing that, make sure that user won't select relaxed MMIO access
along with IO port because the latter have no relaxed variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-mmio.c | 105 +++++++++++++++++++++++++++---
 include/linux/regmap.h            |   3 +
 2 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index b1bd93ea405e..37f79e912d01 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -74,6 +74,12 @@ static void regmap_mmio_write8_relaxed(struct regmap_mmio_context *ctx,
 	writeb_relaxed(val, ctx->regs + reg);
 }
 
+static void regmap_mmio_iowrite8(struct regmap_mmio_context *ctx,
+				 unsigned int reg, unsigned int val)
+{
+	iowrite8(val, ctx->regs + reg);
+}
+
 static void regmap_mmio_write16le(struct regmap_mmio_context *ctx,
 				  unsigned int reg,
 				  unsigned int val)
@@ -88,6 +94,12 @@ static void regmap_mmio_write16le_relaxed(struct regmap_mmio_context *ctx,
 	writew_relaxed(val, ctx->regs + reg);
 }
 
+static void regmap_mmio_iowrite16le(struct regmap_mmio_context *ctx,
+				    unsigned int reg, unsigned int val)
+{
+	iowrite16(val, ctx->regs + reg);
+}
+
 static void regmap_mmio_write16be(struct regmap_mmio_context *ctx,
 				  unsigned int reg,
 				  unsigned int val)
@@ -95,6 +107,12 @@ static void regmap_mmio_write16be(struct regmap_mmio_context *ctx,
 	iowrite16be(val, ctx->regs + reg);
 }
 
+static void regmap_mmio_iowrite16be(struct regmap_mmio_context *ctx,
+				    unsigned int reg, unsigned int val)
+{
+	iowrite16be(val, ctx->regs + reg);
+}
+
 static void regmap_mmio_write32le(struct regmap_mmio_context *ctx,
 				  unsigned int reg,
 				  unsigned int val)
@@ -109,6 +127,12 @@ static void regmap_mmio_write32le_relaxed(struct regmap_mmio_context *ctx,
 	writel_relaxed(val, ctx->regs + reg);
 }
 
+static void regmap_mmio_iowrite32le(struct regmap_mmio_context *ctx,
+				    unsigned int reg, unsigned int val)
+{
+	iowrite32(val, ctx->regs + reg);
+}
+
 static void regmap_mmio_write32be(struct regmap_mmio_context *ctx,
 				  unsigned int reg,
 				  unsigned int val)
@@ -116,6 +140,12 @@ static void regmap_mmio_write32be(struct regmap_mmio_context *ctx,
 	iowrite32be(val, ctx->regs + reg);
 }
 
+static void regmap_mmio_iowrite32be(struct regmap_mmio_context *ctx,
+				    unsigned int reg, unsigned int val)
+{
+	iowrite32be(val, ctx->regs + reg);
+}
+
 static int regmap_mmio_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct regmap_mmio_context *ctx = context;
@@ -147,6 +177,12 @@ static unsigned int regmap_mmio_read8_relaxed(struct regmap_mmio_context *ctx,
 	return readb_relaxed(ctx->regs + reg);
 }
 
+static unsigned int regmap_mmio_ioread8(struct regmap_mmio_context *ctx,
+					unsigned int reg)
+{
+	return ioread8(ctx->regs + reg);
+}
+
 static unsigned int regmap_mmio_read16le(struct regmap_mmio_context *ctx,
 				         unsigned int reg)
 {
@@ -159,12 +195,24 @@ static unsigned int regmap_mmio_read16le_relaxed(struct regmap_mmio_context *ctx
 	return readw_relaxed(ctx->regs + reg);
 }
 
+static unsigned int regmap_mmio_ioread16le(struct regmap_mmio_context *ctx,
+					   unsigned int reg)
+{
+	return ioread16(ctx->regs + reg);
+}
+
 static unsigned int regmap_mmio_read16be(struct regmap_mmio_context *ctx,
 				         unsigned int reg)
 {
 	return ioread16be(ctx->regs + reg);
 }
 
+static unsigned int regmap_mmio_ioread16be(struct regmap_mmio_context *ctx,
+					   unsigned int reg)
+{
+	return ioread16be(ctx->regs + reg);
+}
+
 static unsigned int regmap_mmio_read32le(struct regmap_mmio_context *ctx,
 				         unsigned int reg)
 {
@@ -177,12 +225,24 @@ static unsigned int regmap_mmio_read32le_relaxed(struct regmap_mmio_context *ctx
 	return readl_relaxed(ctx->regs + reg);
 }
 
+static unsigned int regmap_mmio_ioread32le(struct regmap_mmio_context *ctx,
+					   unsigned int reg)
+{
+	return ioread32(ctx->regs + reg);
+}
+
 static unsigned int regmap_mmio_read32be(struct regmap_mmio_context *ctx,
 				         unsigned int reg)
 {
 	return ioread32be(ctx->regs + reg);
 }
 
+static unsigned int regmap_mmio_ioread32be(struct regmap_mmio_context *ctx,
+					   unsigned int reg)
+{
+	return ioread32be(ctx->regs + reg);
+}
+
 static int regmap_mmio_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct regmap_mmio_context *ctx = context;
@@ -245,6 +305,9 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 	if (config->reg_stride < min_stride)
 		return ERR_PTR(-EINVAL);
 
+	if (config->use_relaxed_mmio && config->io_port)
+		return ERR_PTR(-EINVAL);
+
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
@@ -261,7 +324,10 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 #endif
 		switch (config->val_bits) {
 		case 8:
-			if (config->use_relaxed_mmio) {
+			if (config->io_port) {
+				ctx->reg_read = regmap_mmio_ioread8;
+				ctx->reg_write = regmap_mmio_iowrite8;
+			} else if (config->use_relaxed_mmio) {
 				ctx->reg_read = regmap_mmio_read8_relaxed;
 				ctx->reg_write = regmap_mmio_write8_relaxed;
 			} else {
@@ -270,7 +336,10 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 			}
 			break;
 		case 16:
-			if (config->use_relaxed_mmio) {
+			if (config->io_port) {
+				ctx->reg_read = regmap_mmio_ioread16le;
+				ctx->reg_write = regmap_mmio_iowrite16le;
+			} else if (config->use_relaxed_mmio) {
 				ctx->reg_read = regmap_mmio_read16le_relaxed;
 				ctx->reg_write = regmap_mmio_write16le_relaxed;
 			} else {
@@ -279,7 +348,10 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 			}
 			break;
 		case 32:
-			if (config->use_relaxed_mmio) {
+			if (config->io_port) {
+				ctx->reg_read = regmap_mmio_ioread32le;
+				ctx->reg_write = regmap_mmio_iowrite32le;
+			} else if (config->use_relaxed_mmio) {
 				ctx->reg_read = regmap_mmio_read32le_relaxed;
 				ctx->reg_write = regmap_mmio_write32le_relaxed;
 			} else {
@@ -298,16 +370,31 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 #endif
 		switch (config->val_bits) {
 		case 8:
-			ctx->reg_read = regmap_mmio_read8;
-			ctx->reg_write = regmap_mmio_write8;
+			if (config->io_port) {
+				ctx->reg_read = regmap_mmio_ioread8;
+				ctx->reg_write = regmap_mmio_iowrite8;
+			} else {
+				ctx->reg_read = regmap_mmio_read8;
+				ctx->reg_write = regmap_mmio_write8;
+			}
 			break;
 		case 16:
-			ctx->reg_read = regmap_mmio_read16be;
-			ctx->reg_write = regmap_mmio_write16be;
+			if (config->io_port) {
+				ctx->reg_read = regmap_mmio_ioread16be;
+				ctx->reg_write = regmap_mmio_iowrite16be;
+			} else {
+				ctx->reg_read = regmap_mmio_read16be;
+				ctx->reg_write = regmap_mmio_write16be;
+			}
 			break;
 		case 32:
-			ctx->reg_read = regmap_mmio_read32be;
-			ctx->reg_write = regmap_mmio_write32be;
+			if (config->io_port) {
+				ctx->reg_read = regmap_mmio_ioread32be;
+				ctx->reg_write = regmap_mmio_iowrite32be;
+			} else {
+				ctx->reg_read = regmap_mmio_read32be;
+				ctx->reg_write = regmap_mmio_write32be;
+			}
 			break;
 		default:
 			ret = -EINVAL;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 7cf2157134ac..8cccc247cd37 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -311,6 +311,8 @@ typedef void (*regmap_unlock)(void *);
  *		  This field is a duplicate of a similar file in
  *		  'struct regmap_bus' and serves exact same purpose.
  *		   Use it only for "no-bus" cases.
+ * @io_port:	  Support IO port accessors. Makes sense only when MMIO vs. IO port
+ *		  access can be distinguished.
  * @max_register: Optional, specifies the maximum valid register address.
  * @wr_table:     Optional, points to a struct regmap_access_table specifying
  *                valid ranges for write access.
@@ -399,6 +401,7 @@ struct regmap_config {
 	size_t max_raw_write;
 
 	bool fast_io;
+	bool io_port;
 
 	unsigned int max_register;
 	const struct regmap_access_table *wr_table;
-- 
2.35.1

