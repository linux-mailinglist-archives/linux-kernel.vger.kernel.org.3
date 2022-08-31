Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BBF5A7FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiHaOQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiHaOPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:15:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9E22B30
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:15:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z6so20151251lfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=oyr/M5THRfXuofkR2FdLU5DqKefdd5DnYschP7srrC4=;
        b=q2MTJGp16PxpFk5FrY9JXxp+JJJ2HJTmDbCYqK4/39XF6DBhBO9LDhM5vZOcotkVND
         51RNgnRbHAebcY33bTUlDeA8RnN5RTN5XPjy66jyxq5uFBgsU+oida2any+8s8FCNv0x
         godu+cWAZcePI1X1aYCphP0t5jhNyxejQW0WAq+VXc0DIdaQjxQJA6kIaCrWBR2F8vwM
         7p5KvEt7JGXqhZGCr9yAUODp0B5QRsVAXDBt3RUG2Ln5K5dRdcN8vJEakwRwvhWd5SrB
         QX3LSmSBq+vySnW4wAZn8S7JndQ0dEhC2KcB53J3ipYpS4cfj4Dfb56QVr8IYl2s1cQ8
         iiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=oyr/M5THRfXuofkR2FdLU5DqKefdd5DnYschP7srrC4=;
        b=2EsQeW0+8BfJY0D35wt6m+V92OQgoduCIcRRa+7zi5rI/HU4zkhTn7OCenMkpnNyrt
         9JPXHybVR20o8m3iABLcunsBZBRv3FJslWIcFlC433wppWB5O43Nd+/748CpIEmUsrGp
         cOiMOXVHPfRf6VFnstEwsAIlEVlLH0toxRpugegYZPBu6a7nbriwe9HPOGinOfyZPeaO
         5H/CCPLMopUz5CGbwr1ayRfPHSvh8njK/XcnYjGpamhIGMXk98ekA6KaYRPCUbq68w9z
         M7PPltTvtDYSfxdbY5vy2sHJV76yGlDvvETRZYvTct6J4V1knKwAs1oALGmj57o9TijA
         SH7g==
X-Gm-Message-State: ACgBeo3coHACbzu7hGQlw+hsFKoDBIOGitoxCMTQ+7dSql5RhuB2wLBY
        BuY3vrDEcN5AnFoFAqClOfxGC5nnGRJr2A==
X-Google-Smtp-Source: AA6agR6AsSETunILgRQtztJlBJJCwSpIqIE9j75HrQx7DuXZn2UFjkiUNEIDXQma1dvXZSqKqjLhzQ==
X-Received: by 2002:a19:5e51:0:b0:494:6b70:9302 with SMTP id z17-20020a195e51000000b004946b709302mr4294114lfi.250.1661955306513;
        Wed, 31 Aug 2022 07:15:06 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id s8-20020a056512202800b0048b365176d9sm1992316lfs.286.2022.08.31.07.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:15:05 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH] regmap: mmio: Fix rebase error
Date:   Wed, 31 Aug 2022 16:13:03 +0200
Message-Id: <20220831141303.501548-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A dangling pointless "ret 0" was left in and some unneeded
whitespace can go too.

Fixes: 81c0386c1376 ("regmap: mmio: Support accelerared noinc operations")
Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/base/regmap/regmap-mmio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index e8d2675463ac..b47ee3e8d050 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -410,14 +410,11 @@ static int regmap_mmio_noinc_read(void *context, unsigned int reg,
 		}
 	}
 
-
 out_clk:
 	if (!IS_ERR(ctx->clk))
 		clk_disable(ctx->clk);
 
 	return ret;
-
-	return 0;
 }
 
 
-- 
2.37.2

