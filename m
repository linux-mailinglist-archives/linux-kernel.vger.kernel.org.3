Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE258B0F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiHEUxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiHEUx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:53:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B2C14D0F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659732808; x=1691268808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXghPQuaJMyTR5Ic0RE8Yvr7esSnX3aRewGCrlOrFTU=;
  b=HsOlkPPDqca8i9kk8NaqKpAIAXnQtsa9DGCKi7vPNldrxEzXROxy9BeV
   JRv5wjgjNvUmASG+7j7sLEuFrCXUwe1XvJotsl4EcfxhM/NpsU38g72i7
   1BnmZh05GzP6ZLhk6ejbnxvg5RIATOBU+8c7/nAaOqSwN47FZ+X9xkZkr
   BVhSmnYn6OMQN6ohwym2jHxqEzrGFcDuSXPU4sPxSPiZwl21kwNbQGqMq
   tkFbMhMbaXGvq5hIiv7++L7XVlNGqDyV4ixz/cnECHgONnkfuvw4/Fgtz
   RqRtFEsfBdCYjLVAbE/SGNgOb32+YRcaF6GNU/7+OWqif+NsvCFePLU8P
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="316185191"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="316185191"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="849447496"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 05 Aug 2022 13:53:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 62A8611C; Fri,  5 Aug 2022 23:53:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 5/5] regmap: mmio: Introduce IO accessors that can talk to IO port
Date:   Fri,  5 Aug 2022 23:53:21 +0300
Message-Id: <20220805205321.19452-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently regmap MMIO is inconsistent with IO accessors. I.e.
the Big Endian counterparts are using ioreadXXbe() / iowriteXXbe()
which are not clean implementations of readXXbe(). Besides that
some users may use regmap MMIO for IO ports, and this can be done
by assigning ioreadXX()/iowriteXX() and their Big Endian counterparts
to the regmap context.

That said, reimplement current Big Endian MMIO accessors by replacing
ioread()/iowrite() with respective read()/write() and swab() calls.
While at it, add IO port support with a corresponding flag added.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-mmio.c | 102 +++++++++++++++++++++++++++---
 include/linux/regmap.h            |   3 +
 2 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 698295a8f5a6..6a0d370ac83b 100644
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
@@ -88,9 +94,21 @@ static void regmap_mmio_write16le_relaxed(struct regmap_mmio_context *ctx,
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
+{
+	writew(swab16(val), ctx->regs + reg);
+}
+
+static void regmap_mmio_iowrite16be(struct regmap_mmio_context *ctx,
+				    unsigned int reg, unsigned int val)
 {
 	iowrite16be(val, ctx->regs + reg);
 }
@@ -109,9 +127,21 @@ static void regmap_mmio_write32le_relaxed(struct regmap_mmio_context *ctx,
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
+{
+	writel(swab32(val), ctx->regs + reg);
+}
+
+static void regmap_mmio_iowrite32be(struct regmap_mmio_context *ctx,
+				    unsigned int reg, unsigned int val)
 {
 	iowrite32be(val, ctx->regs + reg);
 }
@@ -144,6 +174,12 @@ static unsigned int regmap_mmio_read8_relaxed(struct regmap_mmio_context *ctx,
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
@@ -156,8 +192,20 @@ static unsigned int regmap_mmio_read16le_relaxed(struct regmap_mmio_context *ctx
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
+{
+	return swab16(readw(ctx->regs + reg));
+}
+
+static unsigned int regmap_mmio_ioread16be(struct regmap_mmio_context *ctx,
+					   unsigned int reg)
 {
 	return ioread16be(ctx->regs + reg);
 }
@@ -174,8 +222,20 @@ static unsigned int regmap_mmio_read32le_relaxed(struct regmap_mmio_context *ctx
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
+{
+	return swab32(readl(ctx->regs + reg));
+}
+
+static unsigned int regmap_mmio_ioread32be(struct regmap_mmio_context *ctx,
+					   unsigned int reg)
 {
 	return ioread32be(ctx->regs + reg);
 }
@@ -253,7 +313,10 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
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
@@ -262,7 +325,10 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
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
@@ -271,7 +337,10 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
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
@@ -290,16 +359,31 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
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

