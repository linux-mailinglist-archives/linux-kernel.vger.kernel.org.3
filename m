Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C2F59E8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbiHWRLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344789AbiHWRLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:11:19 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2CFB02B7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:59:05 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u24so8012018lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=TB4fzvGynChj0diYVwW7vNz++lUcmWmnfkYK/WfFPbk=;
        b=Cf6pRmo0VLu+xGrGdE3eKXNCOmScTpkXwE3m7wQGqjxFI7edzhe/H+yjbTa8yC0wEw
         m78eS/B6RgeDpGmTzdpKeq3LmDe48/5TZF5s92emu+rAMVUtdZX9ITHLlO5zf2nZ84Jj
         72Empqd51gXn9jL3AOsisHhBci8YU+Dp/Rdo1gtSUroIgrwP59CRkHiFp8CR+nwnRTJm
         KC8suujCUIMgLfoMTAwxwFD4KkzU72BITSgQoyLRz4OscYlJrZ+Qd+7fGr+Wup2TJb0z
         44xiKnw4cZMbQ4bXhtjYRpOP+cNGqonbJA8dzixAJImREkwp365UzC5bz5orcPbdYXf2
         UbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=TB4fzvGynChj0diYVwW7vNz++lUcmWmnfkYK/WfFPbk=;
        b=nA/1PYz8kpBxwx+4XhyNiAJoeZUm0h7ObEsGcuv7q/QbLn7m5Mwfc1fX8Eq/1j3Qrl
         W4ob/X+a8OSz2BhVn9xeeg1tjY53NkC3PUMtSnxumCQpztTb5YYD6efRws402HcYsSqa
         q5IdkKISNLK2SDM+CFBkzsdMGOLTaxEQLzza6wIc+Zpc3gNnFmk9cTD4YX1AnFBf5AII
         pksnoZWBjeffGw8nDnPUbBuFwF3UhqSWGnX9WqRpHk4M7GlQBQvplzg054n5+WCNpwLd
         CpSXR9H8eGjGEtq3hb0mntz60lHUcUuNm/Od0Dg3ZzWStICLSuIhWyZF4KtL/zktw9tz
         yYgQ==
X-Gm-Message-State: ACgBeo2jZx1bRHhOn17To3dqU8ar5EdyGlLybRFdnKGL6Cn3Lipu89U0
        y9poHvMtSEFrZABIVdBZFHAJww==
X-Google-Smtp-Source: AA6agR7piNo6Tlz4yxnxMV5YyJ+UklXpryJy0GBOL0UxfiPvDNg+AsMFhPwB86aXgrPtpLrElRNQWQ==
X-Received: by 2002:a2e:9d91:0:b0:25e:dd34:f5d6 with SMTP id c17-20020a2e9d91000000b0025edd34f5d6mr6900236ljj.501.1661263142982;
        Tue, 23 Aug 2022 06:59:02 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r5-20020a2ea385000000b0025a65b784b6sm2375939lje.33.2022.08.23.06.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:59:02 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] regmap: check right noinc bounds in debug print
Date:   Tue, 23 Aug 2022 15:57:00 +0200
Message-Id: <20220823135700.265019-1-linus.walleij@linaro.org>
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

We were using the wrong bound in the debug prints: this
needs to be the number of elements, not the number of bytes,
since we're indexing into an element-size typed array.

Fixes: c20cc099b30a ("regmap: Support accelerated noinc operations")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/base/regmap/regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 41ff9f18b6a3..f8815a8fedcb 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2193,7 +2193,7 @@ static int regmap_noinc_readwrite(struct regmap *map, unsigned int reg,
 
 	if (!ret && regmap_should_log(map)) {
 		dev_info(map->dev, "%x %s [", reg, write ? "<=" : "=>");
-		for (i = 0; i < val_len; i++) {
+		for (i = 0; i < val_count; i++) {
 			switch (val_bytes) {
 			case 1:
 				pr_cont("%x", u8p[i]);
@@ -2212,7 +2212,7 @@ static int regmap_noinc_readwrite(struct regmap *map, unsigned int reg,
 			default:
 				break;
 			}
-			if (i == (val_len - 1))
+			if (i == (val_count - 1))
 				pr_cont("]\n");
 			else
 				pr_cont(",");
-- 
2.37.2

