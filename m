Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEC258B0F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbiHEUx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbiHEUxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:53:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E1A7858B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659732826; x=1691268826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xjU61B6lF3k5YGmod3d3oaZwqF8bV+fUijf5OIFjevY=;
  b=ZXjHKoYYk/l4zKXoN6kfNOVHsK4s0G8TgXCk4+Jdsfl4WGmdbcA4KOFQ
   Cx2aWBDS0XTxhOl5riEpCeENC2CISpa+BzZyclMJ0h9VsZ9tZKLkbhboJ
   BlfXtQka//HwlPk53an70bSEQdoTf8CMLY0pDwLABeCtHp1uMgYQhgzVJ
   3QY9Zh0UlsaENI5okP0eg9N5LB8BcarYNqlakdHzge2drz9dEHwpzklYa
   NpRIWSqAz8Sq7Y6Ekpy4RsbGMG0je/4C9utvAJQJP9IGPsdEMqIn7y2+u
   +O/9tDxDwqMWE7Twe13bW9P7xgSigcxbY1BnrW5mfWZjsAN94/3oVUTxT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="352011970"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="352011970"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="931360030"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2022 13:53:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4AACC119; Fri,  5 Aug 2022 23:53:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 3/5] regmap: mmio: Remove mmio_relaxed member from context
Date:   Fri,  5 Aug 2022 23:53:19 +0300
Message-Id: <20220805205321.19452-3-andriy.shevchenko@linux.intel.com>
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

There is no need to keep mmio_relaxed member in the context, it's
onetime used during generation of the context. Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-mmio.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index e1923506a89a..c2b18973144b 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -16,7 +16,6 @@
 struct regmap_mmio_context {
 	void __iomem *regs;
 	unsigned int val_bytes;
-	bool relaxed_mmio;
 
 	bool attached_clk;
 	struct clk *clk;
@@ -283,7 +282,6 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 
 	ctx->regs = regs;
 	ctx->val_bytes = config->val_bits / 8;
-	ctx->relaxed_mmio = config->use_relaxed_mmio;
 
 	switch (regmap_get_val_endian(dev, &regmap_mmio, config)) {
 	case REGMAP_ENDIAN_DEFAULT:
@@ -293,7 +291,7 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 #endif
 		switch (config->val_bits) {
 		case 8:
-			if (ctx->relaxed_mmio) {
+			if (config->use_relaxed_mmio) {
 				ctx->reg_read = regmap_mmio_read8_relaxed;
 				ctx->reg_write = regmap_mmio_write8_relaxed;
 			} else {
@@ -302,7 +300,7 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 			}
 			break;
 		case 16:
-			if (ctx->relaxed_mmio) {
+			if (config->use_relaxed_mmio) {
 				ctx->reg_read = regmap_mmio_read16le_relaxed;
 				ctx->reg_write = regmap_mmio_write16le_relaxed;
 			} else {
@@ -311,7 +309,7 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 			}
 			break;
 		case 32:
-			if (ctx->relaxed_mmio) {
+			if (config->use_relaxed_mmio) {
 				ctx->reg_read = regmap_mmio_read32le_relaxed;
 				ctx->reg_write = regmap_mmio_write32le_relaxed;
 			} else {
@@ -321,7 +319,7 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 			break;
 #ifdef CONFIG_64BIT
 		case 64:
-			if (ctx->relaxed_mmio) {
+			if (config->use_relaxed_mmio) {
 				ctx->reg_read = regmap_mmio_read64le_relaxed;
 				ctx->reg_write = regmap_mmio_write64le_relaxed;
 			} else {
-- 
2.35.1

