Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953FF58B0F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbiHEUxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240390AbiHEUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:53:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AC46582A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659732819; x=1691268819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=scKvlEy0EmpXTjyB9aEHto1bj7/eJOEs3+sYkYXVOuM=;
  b=PnsefIwYJBgTTuoOcL5kzX++/silpfMVC3wc7SPRQJGAKKwUE0cMBYo7
   m36vGaIwItHrBrOIoBcqSAE1qz7gS5c6/p9MrOy+GvwyNJSOrNSyMnFzO
   xb9GuKAlHmYys7eGO/tdYW96b/ItogsgGMIuYadwXWFAwI/QmiIYkhX01
   RsnTx7qXqn3c8ZdvhRmvKpwX3WfTpS0CBUB8HkkG9w43Ty5JiE4JY/5w+
   ywq7YMDgCytnOdgZBEiX6R/SBVIYln2WlidVsHjhMc1LZ6QETP67jc+Uj
   uLBzmAY/BhPC3AcizMS7G27Bz06xIkxkWvPPIaCiTsI8p8fOoepetJpGn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="291513887"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="291513887"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="554238791"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Aug 2022 13:53:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 58A5B1D0; Fri,  5 Aug 2022 23:53:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 4/5] regmap: mmio: Get rid of broken 64-bit IO
Date:   Fri,  5 Aug 2022 23:53:20 +0300
Message-Id: <20220805205321.19452-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
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
index c2b18973144b..698295a8f5a6 100644
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
@@ -204,20 +180,6 @@ static unsigned int regmap_mmio_read32be(struct regmap_mmio_context *ctx,
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
@@ -317,17 +279,6 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
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

