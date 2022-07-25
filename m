Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD7657FBE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiGYJAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbiGYJAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:00:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898BAB85D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:00:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bf9so16971527lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=me3OVL1nn7XM6F+0ou+AMgoAk19MVv6fz5xIk8IwPU8=;
        b=xIclQEvTrK1yf2B0AWVT8grYpHJcUxmUiUN4f8ML411IQs0oGYblieVUomys7YhBVA
         wW6FIQP9BFK7BEOvSmWTAvHqx8YGqGlZI20UgPyW9/P0QSWkm+FLXe64qg4jYfq5qTKs
         idzdvtP20qHs+kpg2WzsEVVhamx3gcGRoWnpzbnQaOgWP/PCUPE98cKqMXRP4dGYOMOp
         uCVrJZr+tsIb1F9TlpVcKZvIY8aFc9j0orkkvnQ/EVrcedFR6H91wUM0FzFJfl0yGteQ
         IX8DAfky8UTKcuxUWIG6/RAF+pUlc9LEmGQOy3rSyhUSE1Tuq7gfMJOtkt3VquRZ015h
         jYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=me3OVL1nn7XM6F+0ou+AMgoAk19MVv6fz5xIk8IwPU8=;
        b=1igARGoZ6rgBR2nlphBACBnsvpyxg3O+gMXAHkgO2OhLPHI/80fqyNbmG0pHgmMlUZ
         QjY9Ny9DZWPGcP1w+zFcFbZl9h+6Pv0g+TBmu2KeZjXWLVfMSlZq3NtLnCcY+zTT1E4x
         V+UK6H+Dxt6VVJ8SJWrsxX1+NudeVsPM+ckhaP60hHeGn+R7v5LJlkoGZk3ZknVT68qZ
         39q85foQ7GxVhDYUX+fyFV6T66WG17YFIPSmOCAaL03d75ARmvHsDAyxPlbCqScgXMjs
         TbNI98uwWaJFiWuhyOCVELUmMVsugpBLILC3Ks+AxlRIQYb9UsHLNo8ks5NABn4Jms4s
         Q1Qg==
X-Gm-Message-State: AJIora/tlyE0Yq3sSbOVg2Jz8ZNM1HrvkHF22FSYGzH5QzAV+nvXoPw2
        NB7k2UcYXKNLtU9B6y4mQTNl0Ai90Gu0HA==
X-Google-Smtp-Source: AGRyM1tgHboZ/znJO7GK8jIrGKI1A+aH2aoVUKcFjSbPTo/t3AJz/4J/Nc1njwG2gFSXcB1gXfyoeg==
X-Received: by 2002:ac2:4c4d:0:b0:48a:7a96:470d with SMTP id o13-20020ac24c4d000000b0048a7a96470dmr4061399lfk.682.1658739627364;
        Mon, 25 Jul 2022 02:00:27 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id n20-20020a2ebd14000000b0025de9ff35b4sm2291364ljq.35.2022.07.25.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 02:00:26 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] regmap: Support accelerated noinc operations
Date:   Mon, 25 Jul 2022 10:58:21 +0200
Message-Id: <20220725085822.2360234-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.36.1
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

Several architectures have accelerated operations for MMIO
operations writing to a single register, such as writesb, writesw,
writesl, writesq, readsb, readsw, readsl and readsq but regmap
currently cannot use them because we have no hooks for providing
an accelerated noinc back-end for MMIO.

Solve this by providing reg_[read/write]_noinc callbacks for
the bus abstraction, so that the regmap-mmio bus can use this.

Currently I do not see a need to support this for custom regmaps
so it is only added to the bus.

Callbacks are passed a void * with the array of values and a
count which is the number of items of the byte chunk size for
the specific register width.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/base/regmap/regmap.c | 164 ++++++++++++++++++++++++++++++++++-
 include/linux/regmap.h       |   8 ++
 2 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 2221d9863831..2923bb63ab95 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2157,7 +2157,7 @@ int regmap_noinc_write(struct regmap *map, unsigned int reg,
 
 	if (!map->bus)
 		return -EINVAL;
-	if (!map->bus->write)
+	if (!map->bus->write && !map->bus->reg_noinc_write)
 		return -ENOTSUPP;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
@@ -2173,6 +2173,92 @@ int regmap_noinc_write(struct regmap *map, unsigned int reg,
 		goto out_unlock;
 	}
 
+	/* Use the accelerated operation if we can */
+	if (map->bus->reg_noinc_write) {
+		size_t val_bytes = map->format.val_bytes;
+		size_t val_count = val_len / val_bytes;
+		unsigned int lastval;
+		const u8 *u8p;
+		const u16 *u16p;
+		const u32 *u32p;
+#ifdef CONFIG_64BIT
+		const u64 *u64p;
+#endif
+		int i;
+
+		switch (val_bytes) {
+		case 1:
+			u8p = val;
+			lastval = (unsigned int)u8p[val_count - 1];
+			break;
+		case 2:
+			u16p = val;
+			lastval = (unsigned int)u16p[val_count - 1];
+			break;
+		case 4:
+			u32p = val;
+			lastval = (unsigned int)u32p[val_count - 1];
+			break;
+#ifdef CONFIG_64BIT
+		case 8:
+			u64p = val;
+			lastval = (unsigned int)u64p[val_count - 1];
+			break;
+#endif
+		default:
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		/*
+		 * Update the cache with the last value we write, the rest is just
+		 * gone down in the hardware FIFO. We can't cache FIFOs. This makes
+		 * sure a single read from the cache will work.
+		 */
+		if (!map->cache_bypass && !map->defer_caching) {
+			ret = regcache_write(map, reg, lastval);
+			if (ret != 0)
+				goto out_unlock;
+			if (map->cache_only) {
+				map->cache_dirty = true;
+				ret = 0;
+				goto out_unlock;
+			}
+		}
+
+		ret = map->bus->reg_noinc_write(map->bus_context, reg, val, val_count);
+
+		if (!ret && regmap_should_log(map)) {
+			dev_info(map->dev, "%x <= [", reg);
+			for (i = 0; i < val_len; i++) {
+				switch (val_bytes) {
+				case 1:
+					pr_cont("%x", u8p[i]);
+					break;
+				case 2:
+					pr_cont("%x", u16p[i]);
+					break;
+				case 4:
+					pr_cont("%x", u32p[i]);
+					break;
+#ifdef CONFIG_64BIT
+				case 8:
+					pr_cont("%llx", u64p[i]);
+					break;
+#endif
+				default:
+					break;
+				}
+				if (i == (val_len - 1))
+					pr_cont("]\n");
+				else
+					pr_cont(",");
+			}
+		}
+		ret = 0;
+		goto out_unlock;
+	}
+
 	while (val_len) {
 		if (map->max_raw_write && map->max_raw_write < val_len)
 			write_len = map->max_raw_write;
@@ -2918,6 +3004,82 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
 		goto out_unlock;
 	}
 
+	/* Use the accelerated operation if we can */
+	if (map->bus->reg_noinc_read) {
+		size_t val_bytes = map->format.val_bytes;
+		size_t val_count = val_len / val_bytes;
+		const u8 *u8p;
+		const u16 *u16p;
+		const u32 *u32p;
+#ifdef CONFIG_64BIT
+		const u64 *u64p;
+#endif
+		int i;
+
+		/*
+		 * We have not defined the FIFO semantics for cache, as the
+		 * cache is just one value deep. Should we return the last
+		 * written value? Just avoid this by always reading the FIFO
+		 * even when using cache. Cache only will not work.
+		 */
+		if (map->cache_only) {
+			ret = -EBUSY;
+			goto out_unlock;
+		}
+
+		switch (val_bytes) {
+		case 1:
+			u8p = val;
+			break;
+		case 2:
+			u16p = val;
+			break;
+		case 4:
+			u32p = val;
+			break;
+#ifdef CONFIG_64BIT
+		case 8:
+			u64p = val;
+			break;
+#endif
+		default:
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		ret = map->bus->reg_noinc_read(map->bus_context, reg, val, val_count);
+
+		if (!ret && regmap_should_log(map)) {
+			dev_info(map->dev, "%x => [", reg);
+			for (i = 0; i < val_len; i++) {
+				switch (val_bytes) {
+				case 1:
+					pr_cont("%x", u8p[i]);
+					break;
+				case 2:
+					pr_cont("%x", u16p[i]);
+					break;
+				case 4:
+					pr_cont("%x", u32p[i]);
+					break;
+#ifdef CONFIG_64BIT
+				case 8:
+					pr_cont("%llx", u64p[i]);
+					break;
+#endif
+				default:
+					break;
+				}
+				if (i == (val_len - 1))
+					pr_cont("]\n");
+				else
+					pr_cont(",");
+			}
+		}
+		ret = 0;
+		goto out_unlock;
+	}
+
 	while (val_len) {
 		if (map->max_raw_read && map->max_raw_read < val_len)
 			read_len = map->max_raw_read;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 8952fa3d0d59..c60bd3a4b098 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -489,8 +489,12 @@ typedef int (*regmap_hw_read)(void *context,
 			      void *val_buf, size_t val_size);
 typedef int (*regmap_hw_reg_read)(void *context, unsigned int reg,
 				  unsigned int *val);
+typedef int (*regmap_hw_reg_noinc_read)(void *context, unsigned int reg,
+					void *val, size_t val_count);
 typedef int (*regmap_hw_reg_write)(void *context, unsigned int reg,
 				   unsigned int val);
+typedef int (*regmap_hw_reg_noinc_write)(void *context, unsigned int reg,
+					 const void *val, size_t val_count);
 typedef int (*regmap_hw_reg_update_bits)(void *context, unsigned int reg,
 					 unsigned int mask, unsigned int val);
 typedef struct regmap_async *(*regmap_hw_async_alloc)(void);
@@ -511,6 +515,8 @@ typedef void (*regmap_hw_free_context)(void *context);
  *               must serialise with respect to non-async I/O.
  * @reg_write: Write a single register value to the given register address. This
  *             write operation has to complete when returning from the function.
+ * @reg_write_noinc: Write multiple register value to the same register. This
+ *             write operation has to complete when returning from the function.
  * @reg_update_bits: Update bits operation to be used against volatile
  *                   registers, intended for devices supporting some mechanism
  *                   for setting clearing bits without having to
@@ -538,9 +544,11 @@ struct regmap_bus {
 	regmap_hw_gather_write gather_write;
 	regmap_hw_async_write async_write;
 	regmap_hw_reg_write reg_write;
+	regmap_hw_reg_noinc_write reg_noinc_write;
 	regmap_hw_reg_update_bits reg_update_bits;
 	regmap_hw_read read;
 	regmap_hw_reg_read reg_read;
+	regmap_hw_reg_noinc_read reg_noinc_read;
 	regmap_hw_free_context free_context;
 	regmap_hw_async_alloc async_alloc;
 	u8 read_flag_mask;
-- 
2.36.1

