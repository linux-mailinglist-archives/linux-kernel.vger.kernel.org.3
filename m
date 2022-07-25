Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D150580087
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbiGYOMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiGYOMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:12:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4F9AE45
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:12:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u20so5485650ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qiq7WCJKSnlSj6lmH1b9VNldBVS8jyuQSsbMLlUQIu8=;
        b=XIGFyhFZjsyhSBKfMKKgnltUtxqTYmTaKmgeHFnyXCoFjyRtBfPZi71jVwZKsBrRRv
         LHt4wgPI/HRcEvKVQbcaoS25dkJeB32aNCnmPmmGGnoY0tA45rLxAHUs9fSdISP0H8h5
         UXtDrqEYZZ9Bba/GYjLIyj0n6g195E4yQTliws3TK/bZd8N2khehPzAAEluC3FMD4y+z
         yuVaMGE11mtXo2hSAmQ8g/R+o2/wnR6U8ItvxMA/3DHZcPC4B9mkUaMOGsUxCjOqZnNz
         iu9VhE2yvpMfHkDiUd+tsHVxqTlIBrgu1b37H5m1wMFMYMN+pIqTBn1bEaXXgegULusx
         OAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qiq7WCJKSnlSj6lmH1b9VNldBVS8jyuQSsbMLlUQIu8=;
        b=kGDc2PMAcz1GtfY8v9nrGa2xqycygNoHAkx8kUbZE/E/oyy4hLjmYDP2wktfB3NnlG
         1+Q58Ysh6asIbPyMDh9zc/zWjiAGSuaiyYZ/kOcEXgOmYoVmMCeFfGgMIwZEuYidfbVu
         kTpTx6wHXY5kZONxITPVrcrOZTu7LaaM9Am3Rh6Y2I3MKV6HTVuBKVybYlrn8LpqyUAP
         w8hu6LjafK3q4Em9BLZqzMoCgVUkaCf5EG+OnuEGIg3SXU82aCQY9vZ5qVkO+20Konej
         um4/ni1bTLyfAfXoz0UDZ0yrBCwEaPB3hhbJ91X8hlSsNpT11BxqMTGkDn7OkEgdxcT/
         0uQA==
X-Gm-Message-State: AJIora+9R0i9nxFRYkmh1YsnR+j3kYmDNGTGrFvQRhmubU+Z8+aMHRaH
        En5SBNvCzQZwU2MR8KckUfYAt8rqswNEMw==
X-Google-Smtp-Source: AGRyM1t4oM/pQXfEHYiH4dyUSBdBL8pMugGsLRjQhAssiR6NZjI2JjFe4/L5gOFFzWFqAqPQP+zTAw==
X-Received: by 2002:a05:651c:2111:b0:25d:fe11:5971 with SMTP id a17-20020a05651c211100b0025dfe115971mr3370927ljq.39.1658758359775;
        Mon, 25 Jul 2022 07:12:39 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id a9-20020a195f49000000b00489ec0d7636sm2676028lfj.110.2022.07.25.07.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 07:12:39 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2 v2] regmap: Support accelerated noinc operations
Date:   Mon, 25 Jul 2022 16:10:35 +0200
Message-Id: <20220725141036.2399822-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Factor out and reuse the code to format and read or write a
  buffer of data to a noinc register at the cost of dropping
  const from the buffer pointer in the write call. This is a
  deadly sin in Rust and therefore impossible, but hey, this is
  C, and dropping a const is a lesser evil than not being
  able to reuse code.
---
 drivers/base/regmap/regmap.c | 120 ++++++++++++++++++++++++++++++++++-
 include/linux/regmap.h       |   8 +++
 2 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 2221d9863831..16461b768f77 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2128,6 +2128,99 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
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
@@ -2157,7 +2250,7 @@ int regmap_noinc_write(struct regmap *map, unsigned int reg,
 
 	if (!map->bus)
 		return -EINVAL;
-	if (!map->bus->write)
+	if (!map->bus->write && !map->bus->reg_noinc_write)
 		return -ENOTSUPP;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
@@ -2173,6 +2266,15 @@ int regmap_noinc_write(struct regmap *map, unsigned int reg,
 		goto out_unlock;
 	}
 
+	/*
+	 * Use the accelerated operation if we can. The val drops the const typing
+	 * in order to facilitate code reuse in regmap_noinc_readwrite().
+	 */
+	if (map->bus->reg_noinc_write) {
+		ret = regmap_noinc_readwrite(map, reg, (void *)val, val_len, true);
+		goto out_unlock;
+	}
+
 	while (val_len) {
 		if (map->max_raw_write && map->max_raw_write < val_len)
 			write_len = map->max_raw_write;
@@ -2918,6 +3020,22 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
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

