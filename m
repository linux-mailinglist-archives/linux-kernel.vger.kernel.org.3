Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0509558CF39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbiHHUeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244423AbiHHUeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:34:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22DD1ADA6
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659990846; x=1691526846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYeR5qgC7OY8xHvhYlDf7AD1egF42eQOeSm+U6mKFXM=;
  b=P1uaq22emrqI8kcDs5Moj+krvJnVMNsT/6DYLsfbY1Z50k5B9ECi3J3X
   hA+qmu5izJeAC0NjifaFGxLvPrh8FQR+CB95Clc5XEmcofucXZmEp7SOA
   sLc3iNhSy4oS4mp8h5EySoYtSRrXhkmpooViblwlgc8Apa/ZLDy4DjoJC
   S7FbrMKXS89TjWgJ1b1s0cnjzqSqTNY1QdUounThZk21ofD4hg5WRrHqu
   VfwGXJt8C/JJJTqpPjhnK+LwiDwM6H414svy7vC1+/3xdMU3UMWXEGI7K
   Uy6AxnS8Ah3fMP25GDlo0zUJuXod8WrP7n8sUja9S+UkND5BTrPdbq3Bs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291925285"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291925285"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 13:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="637451686"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 08 Aug 2022 13:34:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5FA871AA; Mon,  8 Aug 2022 23:34:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 2/4] regmap: mmio: Get rid of broken 64-bit IO
Date:   Mon,  8 Aug 2022 23:33:58 +0300
Message-Id: <20220808203401.35153-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808203401.35153-1-andriy.shevchenko@linux.intel.com>
References: <20220808203401.35153-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation, besides having no active users, is broken
by design of regmap. For 64-bit IO we need to supply 64-bit value,
otherwise there is no way to handle upper 32 bits in 64-bit register.

Hence, remove the broken IO accessors for good and wait for real user
that can fix entire regmap API for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-mmio.c | 49 -------------------------------
 1 file changed, 49 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 3a5c81e4ce84..b1bd93ea405e 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -32,9 +32,6 @@ static int regmap_mmio_regbits_check(size_t reg_bits)
 	case 8:
 	case 16:
 	case 32:
-#ifdef CONFIG_64BIT
-	case 64:
-#endif
 		return 0;
 	default:
 		return -EINVAL;
@@ -56,11 +53,6 @@ static int regmap_mmio_get_min_stride(size_t val_bits)
 	case 32:
 		min_stride = 4;
 		break;
-#ifdef CONFIG_64BIT
-	case 64:
-		min_stride = 8;
-		break;
-#endif
 	default:
 		return -EINVAL;
 	}
@@ -124,22 +116,6 @@ static void regmap_mmio_write32be(struct regmap_mmio_context *ctx,
 	iowrite32be(val, ctx->regs + reg);
 }
 
-#ifdef CONFIG_64BIT
-static void regmap_mmio_write64le(struct regmap_mmio_context *ctx,
-				  unsigned int reg,
-				  unsigned int val)
-{
-	writeq(val, ctx->regs + reg);
-}
-
-static void regmap_mmio_write64le_relaxed(struct regmap_mmio_context *ctx,
-				  unsigned int reg,
-				  unsigned int val)
-{
-	writeq_relaxed(val, ctx->regs + reg);
-}
-#endif
-
 static int regmap_mmio_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct regmap_mmio_context *ctx = context;
@@ -207,20 +183,6 @@ static unsigned int regmap_mmio_read32be(struct regmap_mmio_context *ctx,
 	return ioread32be(ctx->regs + reg);
 }
 
-#ifdef CONFIG_64BIT
-static unsigned int regmap_mmio_read64le(struct regmap_mmio_context *ctx,
-				         unsigned int reg)
-{
-	return readq(ctx->regs + reg);
-}
-
-static unsigned int regmap_mmio_read64le_relaxed(struct regmap_mmio_context *ctx,
-						 unsigned int reg)
-{
-	return readq_relaxed(ctx->regs + reg);
-}
-#endif
-
 static int regmap_mmio_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct regmap_mmio_context *ctx = context;
@@ -325,17 +287,6 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 				ctx->reg_write = regmap_mmio_write32le;
 			}
 			break;
-#ifdef CONFIG_64BIT
-		case 64:
-			if (config->use_relaxed_mmio) {
-				ctx->reg_read = regmap_mmio_read64le_relaxed;
-				ctx->reg_write = regmap_mmio_write64le_relaxed;
-			} else {
-				ctx->reg_read = regmap_mmio_read64le;
-				ctx->reg_write = regmap_mmio_write64le;
-			}
-			break;
-#endif
 		default:
 			ret = -EINVAL;
 			goto err_free;
-- 
2.35.1

