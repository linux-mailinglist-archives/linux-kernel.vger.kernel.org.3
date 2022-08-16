Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3AD595CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiHPNKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiHPNKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:10:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD91EB2872
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:10:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id v2so14855549lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=VWpYwCLhP7eZqC4D4JBHP79cil+ybsD9UUSNaW9dg5I=;
        b=wp5QxLjhmHSycO37sn7zL1Vl6AaulglwLUD/NnGDLyntGnqPF/18Gb4DnP9yGfvaS9
         yVaPiJYHDVjuhs+S1NKoeB4lLmfvyZq3jUraOL/sRw53/niuK4FIfRMjxGy1vngy8qTD
         dvoa9E79UKzgeHl6vvUe4vygvj0TCKPvbITX1nKNJR8GXypZMrqeuWmJ7iEaiPmjbZ57
         5PY75+qgHwylsxWrz7a0luidsDytuTnZgMClAr0Smez4xGVXEq2Wp8iOIk2qG5zTazFw
         zXm9+rdxeimCNTdIXHjN6pgsytOddCZ0hvwVVQzyJXu1+QO8q41X9W9OdFSbqHfEoh88
         823w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=VWpYwCLhP7eZqC4D4JBHP79cil+ybsD9UUSNaW9dg5I=;
        b=iNkyJSodgJoeCQ1E/DU3hm2zEWAZQd67aoazGJhs2YnSuW19FPtcibDcieKx6d56jt
         aulEy1EsNFt9GC9e3jnJWJk3xjGnfV6nD+pGJBUFxO01q0QzPpJAVYAjms2DGs2mGL+y
         lUhJfu1aAHo5cgqeOY+zYPFe/fB4KFoSUDgVvwvJiEw7xB89+AjAF9IZoFhFcE+wOCqQ
         8DrhzrYnOqYDQ3pf4L0QhdAnsW5+Iqcn3N8lGXXvUelZUsibcwZlaMIZ5GNBWokNzmWB
         RXFkcBsDjI5j8eOg6KtLwYWkLGZhlLtNxDMQRQMf6SJd98YH/2MI9ssBHaR+lRvm53Qa
         4yWQ==
X-Gm-Message-State: ACgBeo3iOYSRaPGvFLQ7EZTw/XHHUGRH+sTGHd58CTwarDY0NsMR1hgH
        42YwgCMLTaxP2as44ZCsVc4LOg==
X-Google-Smtp-Source: AA6agR6DYbBphGqpOieweCqlfAkRbrp9u98b1v/16/c4TqZ3fJ0xz5bkf72VBKNAb6+IgSwdYAzu9Q==
X-Received: by 2002:ac2:5bc4:0:b0:48b:1be:f02d with SMTP id u4-20020ac25bc4000000b0048b01bef02dmr7157204lfn.486.1660655426003;
        Tue, 16 Aug 2022 06:10:26 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id h25-20020ac24d39000000b0048b2be5320csm1385568lfk.118.2022.08.16.06.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 06:10:25 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2 v3] regmap: Support accelerated noinc operations
Date:   Tue, 16 Aug 2022 15:08:22 +0200
Message-Id: <20220816130823.97903-1-linus.walleij@linaro.org>
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
ChangeLog v2->v3:
- Rebase on kernel v6.0-rc1
ChangeLog v1->v2:
- Factor out and reuse the code to format and read or write a
  buffer of data to a noinc register at the cost of dropping
  const from the buffer pointer in the write call. This is a
  deadly sin in Rust and therefore impossible, but hey, this is
  C, and dropping a const is a lesser evil than not being
  able to reuse code.
---
 drivers/base/regmap/regmap.c | 123 ++++++++++++++++++++++++++++++++++-
 include/linux/regmap.h       |   8 +++
 2 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fee221c5008c..dbe2042f92f3 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2132,6 +2132,99 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(regmap_raw_write);
 
+static int regmap_noinc_readwrite(struct regmap *map, unsigned int reg,
+				  void *val, unsigned int val_len, bool write)
+{
+	size_t val_bytes = map->format.val_bytes;
+	size_t val_count = val_len / val_bytes;
+	unsigned int lastval;
+	u8 *u8p;
+	u16 *u16p;
+	u32 *u32p;
+#ifdef CONFIG_64BIT
+	u64 *u64p;
+#endif
+	int ret;
+	int i;
+
+	switch (val_bytes) {
+	case 1:
+		u8p = val;
+		if (write)
+			lastval = (unsigned int)u8p[val_count - 1];
+		break;
+	case 2:
+		u16p = val;
+		if (write)
+			lastval = (unsigned int)u16p[val_count - 1];
+		break;
+	case 4:
+		u32p = val;
+		if (write)
+			lastval = (unsigned int)u32p[val_count - 1];
+		break;
+#ifdef CONFIG_64BIT
+	case 8:
+		u64p = val;
+		if (write)
+			lastval = (unsigned int)u64p[val_count - 1];
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Update the cache with the last value we write, the rest is just
+	 * gone down in the hardware FIFO. We can't cache FIFOs. This makes
+	 * sure a single read from the cache will work.
+	 */
+	if (write) {
+		if (!map->cache_bypass && !map->defer_caching) {
+			ret = regcache_write(map, reg, lastval);
+			if (ret != 0)
+				return ret;
+			if (map->cache_only) {
+				map->cache_dirty = true;
+				return 0;
+			}
+		}
+		ret = map->bus->reg_noinc_write(map->bus_context, reg, val, val_count);
+	} else {
+		ret = map->bus->reg_noinc_read(map->bus_context, reg, val, val_count);
+	}
+
+	if (!ret && regmap_should_log(map)) {
+		dev_info(map->dev, "%x %s [", reg, write ? "<=" : "=>");
+		for (i = 0; i < val_len; i++) {
+			switch (val_bytes) {
+			case 1:
+				pr_cont("%x", u8p[i]);
+				break;
+			case 2:
+				pr_cont("%x", u16p[i]);
+				break;
+			case 4:
+				pr_cont("%x", u32p[i]);
+				break;
+#ifdef CONFIG_64BIT
+			case 8:
+				pr_cont("%llx", u64p[i]);
+				break;
+#endif
+			default:
+				break;
+			}
+			if (i == (val_len - 1))
+				pr_cont("]\n");
+			else
+				pr_cont(",");
+		}
+	}
+
+	return 0;
+}
+
 /**
  * regmap_noinc_write(): Write data from a register without incrementing the
  *			register number
@@ -2159,9 +2252,8 @@ int regmap_noinc_write(struct regmap *map, unsigned int reg,
 	size_t write_len;
 	int ret;
 
-	if (!map->write)
-		return -ENOTSUPP;
-
+	if (!map->write && !(map->bus && map->bus->reg_noinc_write))
+		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
@@ -2176,6 +2268,15 @@ int regmap_noinc_write(struct regmap *map, unsigned int reg,
 		goto out_unlock;
 	}
 
+	/*
+	 * Use the accelerated operation if we can. The val drops the const
+	 * typing in order to facilitate code reuse in regmap_noinc_readwrite().
+	 */
+	if (map->bus->reg_noinc_write) {
+		ret = regmap_noinc_readwrite(map, reg, (void *)val, val_len, true);
+		goto out_unlock;
+	}
+
 	while (val_len) {
 		if (map->max_raw_write && map->max_raw_write < val_len)
 			write_len = map->max_raw_write;
@@ -2946,6 +3047,22 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
 		goto out_unlock;
 	}
 
+	/* Use the accelerated operation if we can */
+	if (map->bus->reg_noinc_read) {
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
+		ret = regmap_noinc_readwrite(map, reg, val, val_len, false);
+		goto out_unlock;
+	}
+
 	while (val_len) {
 		if (map->max_raw_read && map->max_raw_read < val_len)
 			read_len = map->max_raw_read;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 7cf2157134ac..7d4d257b2bf9 100644
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
2.37.2

