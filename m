Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0358CF37
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244434AbiHHUeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244402AbiHHUeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:34:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF22E1AD8A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659990844; x=1691526844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fYninJtK+P2j2m0xNhJZNPCXHwvPsRfJcZpXXbr/muk=;
  b=Z5HSEAUPl7xn1WLNLc2M/w5q0Iqj25QBrTLVaH8IW15auUzPsIlUrbJH
   xg0tuCW6fLYjYJR3NuuVSWFFae1dWaWPyM9OJXjb4w49JaYR0WPEcUA0v
   ivLU1/4p/D31h7ht7Ap5kKr4CFbdYf7rKis5pyy4jb4Gl/nxtUypRDDI8
   LMQM1XrhjCmtsFo9KqRRfbbSQdfuZUI+Mt+/Spp/f1/ZC/JgbuTq/mXx+
   zvs6kDRDHmAfmbM+oOggLKukpsKOZ7htlJjpbtt4lgPjfIxu5NT13DEna
   TO5gMF5TOQs3mZqtRPBP2y0JQ90JI4pFtahjDyaC8l3hx9bWgc5g0THoe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="352414536"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="352414536"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 13:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="664126939"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Aug 2022 13:34:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A8A61F7; Mon,  8 Aug 2022 23:34:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 1/4] regmap: mmio: Remove mmio_relaxed member from context
Date:   Mon,  8 Aug 2022 23:33:57 +0300
Message-Id: <20220808203401.35153-2-andriy.shevchenko@linux.intel.com>
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

There is no need to keep mmio_relaxed member in the context, it's
onetime used during generation of the context. Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-mmio.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 71f16be7e717..3a5c81e4ce84 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -16,7 +16,6 @@
 struct regmap_mmio_context {
 	void __iomem *regs;
 	unsigned int val_bytes;
-	bool relaxed_mmio;
 
 	bool attached_clk;
 	struct clk *clk;
@@ -290,7 +289,6 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 
 	ctx->regs = regs;
 	ctx->val_bytes = config->val_bits / 8;
-	ctx->relaxed_mmio = config->use_relaxed_mmio;
 	ctx->clk = ERR_PTR(-ENODEV);
 
 	switch (regmap_get_val_endian(dev, &regmap_mmio, config)) {
@@ -301,7 +299,7 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 #endif
 		switch (config->val_bits) {
 		case 8:
-			if (ctx->relaxed_mmio) {
+			if (config->use_relaxed_mmio) {
 				ctx->reg_read = regmap_mmio_read8_relaxed;
 				ctx->reg_write = regmap_mmio_write8_relaxed;
 			} else {
@@ -310,7 +308,7 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 			}
 			break;
 		case 16:
-			if (ctx->relaxed_mmio) {
+			if (config->use_relaxed_mmio) {
 				ctx->reg_read = regmap_mmio_read16le_relaxed;
 				ctx->reg_write = regmap_mmio_write16le_relaxed;
 			} else {
@@ -319,7 +317,7 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 			}
 			break;
 		case 32:
-			if (ctx->relaxed_mmio) {
+			if (config->use_relaxed_mmio) {
 				ctx->reg_read = regmap_mmio_read32le_relaxed;
 				ctx->reg_write = regmap_mmio_write32le_relaxed;
 			} else {
@@ -329,7 +327,7 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
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

