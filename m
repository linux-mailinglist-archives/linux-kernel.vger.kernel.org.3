Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635444EA353
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiC1W6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiC1W6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:58:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67B62DDF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:56:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lr4so23192680ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gsnbPHN1+bJ5AgqkGTl4dGaLitG9L/CZ09Bd+KwNgt8=;
        b=Nmc6PrFt6l1vzHoSiGbeJVaO2omXu1zy0HbTQgmkhtqaoMUk850z389Usqgda2XjCw
         7qxtOJQ0mt98v793Ly+rhMDTjDCid4BOX4I7rLXv9xEdRYju+bZEmv462n26Cr4L+y4+
         92z2himg1vWBiE1x7B92vwcVVbhU+CPPxPs5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gsnbPHN1+bJ5AgqkGTl4dGaLitG9L/CZ09Bd+KwNgt8=;
        b=J9Vm9wQ2K6SYpWBkiSQZ650tUj2SHJ1fUzJFtmLruFw1Gl2SqS3JDvvRcCvcnOWnc7
         CeVzv6DiBzowgbkqkmBLlBEHMfFp+Dd0xIrZ4xmcxRawsL/WIsJYvtMdfTBGdLAtmjvU
         ZGjg6cs/14EFaLL4djSd+xHQsCKeiCkKXyRcgyrJQa9fp3Myv/hs9w6r15EF2yrFxe4C
         JVSsn34D4bMGXMOuhnGopbvYGHAvR9Oosbu0YZjpTNcLnWbCvMRmg3t4jYdEUaqivY9E
         c0V1sU8EjpsJ4bZNQycx0dpSQed8dRSLs6CoJc3SX7FmQWu5X1elhjOIlZECBcuH8v7C
         I6Fw==
X-Gm-Message-State: AOAM530IGB1qrqcYhh6k6ZBqKdGBTVUYLBjix28/mWUZUmjsR4uaV5H/
        CD+hRVgG6Duusg/tPTDO/tp7Hg==
X-Google-Smtp-Source: ABdhPJwDQnj/ROBBuZuaqnx106ED7fkzgOyheeZAC0CiYJv4yEO4htrkiieMhqfBUYpz8+9IZIpz+A==
X-Received: by 2002:a17:907:3e03:b0:6da:8c5a:6d4a with SMTP id hp3-20020a1709073e0300b006da8c5a6d4amr30831660ejc.585.1648508192251;
        Mon, 28 Mar 2022 15:56:32 -0700 (PDT)
Received: from localhost.localdomain ([80.208.64.233])
        by smtp.gmail.com with ESMTPSA id by4-20020a0564021b0400b00418fc410299sm7510740edb.62.2022.03.28.15.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 15:56:31 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: make range check functions static
Date:   Tue, 29 Mar 2022 00:56:28 +0200
Message-Id: <20220328225628.3012397-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
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

regmap_reg_in_ranges() and regmap_check_range_table() have no callers
outside regmap.c, so they have no reason to be exported nor have
external linkage.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/regmap/regmap.c | 12 +++++-------
 include/linux/regmap.h       |  7 -------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 5e12f7cb5147..8b3fdc966ed6 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -57,9 +57,9 @@ static int _regmap_bus_reg_write(void *context, unsigned int reg,
 static int _regmap_bus_raw_write(void *context, unsigned int reg,
 				 unsigned int val);
 
-bool regmap_reg_in_ranges(unsigned int reg,
-			  const struct regmap_range *ranges,
-			  unsigned int nranges)
+static bool regmap_reg_in_ranges(unsigned int reg,
+				 const struct regmap_range *ranges,
+				 unsigned int nranges)
 {
 	const struct regmap_range *r;
 	int i;
@@ -69,10 +69,9 @@ bool regmap_reg_in_ranges(unsigned int reg,
 			return true;
 	return false;
 }
-EXPORT_SYMBOL_GPL(regmap_reg_in_ranges);
 
-bool regmap_check_range_table(struct regmap *map, unsigned int reg,
-			      const struct regmap_access_table *table)
+static bool regmap_check_range_table(struct regmap *map, unsigned int reg,
+				     const struct regmap_access_table *table)
 {
 	/* Check "no ranges" first */
 	if (regmap_reg_in_ranges(reg, table->no_ranges, table->n_no_ranges))
@@ -85,7 +84,6 @@ bool regmap_check_range_table(struct regmap *map, unsigned int reg,
 	return regmap_reg_in_ranges(reg, table->yes_ranges,
 				    table->n_yes_ranges);
 }
-EXPORT_SYMBOL_GPL(regmap_check_range_table);
 
 bool regmap_writeable(struct regmap *map, unsigned int reg)
 {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index de81a94d7b30..5008db9bf69a 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1210,9 +1210,6 @@ void regcache_cache_only(struct regmap *map, bool enable);
 void regcache_cache_bypass(struct regmap *map, bool enable);
 void regcache_mark_dirty(struct regmap *map);
 
-bool regmap_check_range_table(struct regmap *map, unsigned int reg,
-			      const struct regmap_access_table *table);
-
 int regmap_register_patch(struct regmap *map, const struct reg_sequence *regs,
 			  int num_regs);
 int regmap_parse_val(struct regmap *map, const void *buf,
@@ -1224,10 +1221,6 @@ static inline bool regmap_reg_in_range(unsigned int reg,
 	return reg >= range->range_min && reg <= range->range_max;
 }
 
-bool regmap_reg_in_ranges(unsigned int reg,
-			  const struct regmap_range *ranges,
-			  unsigned int nranges);
-
 static inline int regmap_set_bits(struct regmap *map,
 				  unsigned int reg, unsigned int bits)
 {
-- 
2.31.1

