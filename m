Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2D47D710
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbhLVSn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:43:57 -0500
Received: from whuk3.redbackinternet.net ([109.203.107.222]:44140 "EHLO
        whuk3.redbackinternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhLVSn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fbautosys.co.uk; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oyGWZaDZ/BO5KPkkZ+U0vp6/yJS+5/S7UTBXeEc+Mck=; b=HAxyz79Ly70tfpC7k2fnnBa08T
        FQiFdOndLjkXHxkHy5LPBuF7eH0hRoq3hm2eT9HtkO7wcskJDnVDWOlD1kO92/XHIcs9WeHtt2s1c
        RrnTgi+DapdSe65C/10FA8pTf8a3xwYCUaIEI/t/RYYmpcYJXXZHQrnU3BaXM84RkgtvMswWtVWdX
        9LD1TMjriof7pQlhltw1IuI8l1EvVdsb73dZ5jQfJX0tnER7NLNzEBpFfqDc3keVIP9VgvUv7E9fq
        hOVf6W+1w/tkBjycAHkZnlcZ8HayLVhsJDUDEEJFGdVob9nUhpQBWj7NVWXk5/qqiW13Du9Nr0wky
        lo5K2i1Q==;
Received: from 24.54.187.81.in-addr.arpa ([81.187.54.24]:44088 helo=kernelcomp.corp.firebladeautomationsystems.co.uk)
        by whuk3.redbackinternet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linuxkernel@fbautosys.co.uk>)
        id 1n06af-000CmX-Bg; Wed, 22 Dec 2021 18:43:55 +0000
From:   linuxkernel@fbautosys.co.uk
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org
Subject: [RFC PATCH v2 1/5] Add Parity bit Calculation to regmaps
Date:   Wed, 22 Dec 2021 18:43:36 +0000
Message-Id: <20211222184340.1907240-2-linuxkernel@fbautosys.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222184340.1907240-1-linuxkernel@fbautosys.co.uk>
References: <20211222184340.1907240-1-linuxkernel@fbautosys.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whuk3.redbackinternet.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fbautosys.co.uk
X-Get-Message-Sender-Via: whuk3.redbackinternet.net: authenticated_id: linuxkernel@fbautosys.co.uk
X-Authenticated-Sender: whuk3.redbackinternet.net: linuxkernel@fbautosys.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>

regmap.h

Added bitmasks "parity_read_mask" and "parity_write_mask" for read
and write operations to regmap_config bit mask defines location of
the parity bit.

Added optional callback "parity_calc" to regmap_config to
calculate parity bit value

Added regmap_parity_calc_even() and regmap_parity_calc_odd()
functions to regmap_config for standard parity calculations.

internal.h

Added bitmasks "parity_read_mask" and "parity_write_mask" for read
and write operations to regmap bit mask defines location of
the parity bit.

Added optional callback "parity_calc" to regmap to
calculate parity bit value

Added regmap_parity_calc_even() and regmap_parity_calc_odd()
functions to regmap to for standard parity calculations.

regmap.c

Added parity8(), parity16(), parity32() and parity64() bitwise parity
bit calculation functions for different unsigned integer sizes.

Added parity_even() parity calculation for unsigned int that
uses appropriate parityX fixed size function

Added regmap_parity_calc_even() that calculate bool value of even
parity bit from read/write mask, reg and val using appropriate
combinations of parityX functions

Added regmap_parity_calc_odd() that just boolean complement of
regmap_parity_calc_even()

Altered *__regmap_init to copy parity_read_mask, parity_write_mask
and parity_calc to from config to map and assign default
regmap_parity_calc_even() to map->parity_calc if map->parity_calc()
undefined.

Added regmap_set_work_buf_parity_mask() that sets the parity bit in
provided workbuf to calculated parity value using assigned
map->parity_calc() using rwmask, reg and val for calculation
and mask for bit location

Altered _regmap_raw_write_impl() to calculate parity by adding call
to regmap_set_work_buf_parity_mask()

Altered _regmap_raw_read() to calculate parity by adding call
to regmap_set_work_buf_parity_mask()

	modified:   drivers/base/regmap/internal.h
	modified:   drivers/base/regmap/regmap.c
	modified:   include/linux/regmap.h

Signed-off-by: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>
---
 drivers/base/regmap/internal.h |   6 ++
 drivers/base/regmap/regmap.c   | 168 ++++++++++++++++++++++++++++++++-
 include/linux/regmap.h         |  32 +++++++
 3 files changed, 204 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index b1905916f7af..78df50694cf4 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -168,6 +168,12 @@ struct regmap {
 
 	/* if set, the regmap core can sleep */
 	bool can_sleep;
+
+	unsigned long parity_write_mask;
+	unsigned long parity_read_mask;
+
+	bool (*parity_calc)(unsigned long rwmask, unsigned int reg,
+						const void *val, size_t val_len);
 };
 
 struct regcache_ops {
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 2d74f9f82aa9..05c104659381 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -57,6 +57,13 @@ static int _regmap_bus_reg_write(void *context, unsigned int reg,
 static int _regmap_bus_raw_write(void *context, unsigned int reg,
 				 unsigned int val);
 
+static bool parity_even(uint v);
+
+static bool parity8_even(u8 v);
+static bool parity16_even(u16 v);
+static bool parity32_even(u32 v);
+static bool parity64_even(u64 v);
+
 bool regmap_reg_in_ranges(unsigned int reg,
 			  const struct regmap_range *ranges,
 			  unsigned int nranges)
@@ -892,6 +899,14 @@ struct regmap *__regmap_init(struct device *dev,
 		map->reg_update_bits = bus->reg_update_bits;
 	}
 
+	map->parity_write_mask = config->parity_write_mask;
+	map->parity_read_mask = config->parity_read_mask;
+
+	if (config->parity_calc)
+		map->parity_calc = config->parity_calc;
+	else
+		map->parity_calc = regmap_parity_calc_even;
+
 	reg_endian = regmap_get_reg_endian(bus, config);
 	val_endian = regmap_get_val_endian(dev, bus, config);
 
@@ -1655,6 +1670,31 @@ static void regmap_set_work_buf_flag_mask(struct regmap *map, int max_bytes,
 		buf[i] |= (mask >> (8 * i)) & 0xff;
 }
 
+static void regmap_set_work_buf_parity_mask(struct regmap *map, int max_bytes,
+					  unsigned long mask, unsigned long rwmask,
+					  unsigned int reg, const void *val, size_t val_len)
+{
+
+	bool paritybit;
+	u8 *buf;
+	int i;
+
+	if (!mask || !map->work_buf)
+		return;
+
+	paritybit = map->parity_calc(rwmask, reg, val, val_len);
+
+
+	if (paritybit) {
+		buf = map->work_buf;
+
+		for (i = 0; i < max_bytes; i++)
+			buf[i] |= (mask >> (8 * i)) & 0xff;
+	}
+}
+
+
+
 static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 				  const void *val, size_t val_len, bool noinc)
 {
@@ -1736,7 +1776,12 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 
 	map->format.format_reg(map->work_buf, reg, map->reg_shift);
 	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
-				      map->write_flag_mask);
+								  map->write_flag_mask);
+
+
+	regmap_set_work_buf_parity_mask(map, map->format.reg_bytes,
+				map->parity_write_mask, map->write_flag_mask, reg, val, val_len);
+
 
 	/*
 	 * Essentially all I/O mechanisms will be faster with a single
@@ -1748,6 +1793,9 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 		val = work_val;
 	}
 
+
+
+
 	if (map->async && map->bus->async_write) {
 		struct regmap_async *async;
 
@@ -2674,7 +2722,12 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 
 	map->format.format_reg(map->work_buf, reg, map->reg_shift);
 	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
-				      map->read_flag_mask);
+						map->read_flag_mask);
+
+	regmap_set_work_buf_parity_mask(map, map->format.reg_bytes,
+						map->parity_read_mask, map->read_flag_mask, reg,
+						val, val_len);
+
 	trace_regmap_hw_read_start(map, reg, val_len / map->format.val_bytes);
 
 	ret = map->bus->read(map->bus_context, map->work_buf,
@@ -3340,3 +3393,114 @@ static int __init regmap_initcall(void)
 	return 0;
 }
 postcore_initcall(regmap_initcall);
+
+
+/**
+ * regmap_parity_calc_even() - calculates Value of parity bit for even parity
+ *
+ * @rwmask: value of the read/write mask
+ * @reg: value of register
+ * @val: pointer to value of data
+ * @val_len: size of val
+ *
+ * Calculate the value of the parity bit for even parity
+ */
+bool regmap_parity_calc_even(unsigned long rwmask, unsigned int reg,
+							 const void *val, size_t val_len)
+{
+	bool paritybuf = 0;
+	uint count = 0;
+
+	while (count < val_len) {
+		if (val_len - count >= 8) {
+			paritybuf ^= parity64_even(*(u64 *)val+count);
+			count += 8;
+		} else if (val_len - count >= 4) {
+			paritybuf ^= parity32_even(*(u32 *)val+count);
+			count += 4;
+		} else if (val_len - count >= 2) {
+			paritybuf ^= parity16_even(*(u16 *)val+count);
+			count += 2;
+		} else if (val_len - count >= 1) {
+			paritybuf ^= parity8_even(*(u8 *)val+count);
+			count += 1;
+		}
+	}
+
+	return (parity_even(rwmask) ^ parity_even(reg) ^ paritybuf);
+}
+EXPORT_SYMBOL_GPL(regmap_parity_calc_even);
+
+/**
+ * regmap_parity_calc_odd() - calculates Value of parity bit for odd parity
+ *
+ * @rwmask: value of the read/write mask
+ * @reg: value of register
+ * @val: pointer to value of data
+ * @val_len: size of val
+ *
+ * Calculate the value of the parity bit for odd parity
+ */
+
+bool regmap_parity_calc_odd(unsigned long rwmask, unsigned int reg,
+							const void *val, size_t val_len)
+{
+	return !(regmap_parity_calc_even(rwmask, reg, val, val_len));
+
+
+}
+EXPORT_SYMBOL_GPL(regmap_parity_calc_odd);
+
+static bool parity_even(uint v)
+{
+	switch (sizeof(v)) {
+	case 1:
+		return parity8_even((u8)v);
+	case 2:
+		return parity16_even((u16)v);
+	case 4:
+		return parity32_even((u32)v);
+	case 8:
+	default:
+		return parity64_even((u64)v);
+
+	}
+}
+static bool parity8_even(u8 v)
+{
+	v ^= v >> 4;
+	v ^= v >> 2;
+	v ^= v >> 1;
+	return v & 1;
+}
+
+
+static bool parity16_even(u16 v)
+{
+	v ^= v >> 8;
+	v ^= v >> 4;
+	v ^= v >> 2;
+	v ^= v >> 1;
+	return v & 1;
+}
+
+static bool parity32_even(u32 v)
+{
+	v ^= v >> 16;
+	v ^= v >> 8;
+	v ^= v >> 4;
+	v ^= v >> 2;
+	v ^= v >> 1;
+	return v & 1;
+}
+
+static bool parity64_even(u64 v)
+{
+	v ^= v >> 32;
+	v ^= v >> 16;
+	v ^= v >> 8;
+	v ^= v >> 4;
+	v ^= v >> 2;
+	v ^= v >> 1;
+	return v & 1;
+}
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 22652e5fbc38..511fc9228e1d 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -354,6 +354,10 @@ typedef void (*regmap_unlock)(void *);
  * @hwlock_mode: The hardware spinlock mode, should be HWLOCK_IRQSTATE,
  *		 HWLOCK_IRQ or 0.
  * @can_sleep: Optional, specifies whether regmap operations can sleep.
+ *
+ * @parity_read_mask: bit mask of location of parity bit for reads
+ * @parity_write_mask: bit mask of location of parity bit for writes
+ * @parity_calc: Optional callback to calculate parity, defaults to even parity
  */
 struct regmap_config {
 	const char *name;
@@ -416,6 +420,12 @@ struct regmap_config {
 	unsigned int hwlock_mode;
 
 	bool can_sleep;
+
+	unsigned long parity_read_mask;
+	unsigned long parity_write_mask;
+	bool (*parity_calc)(unsigned long rwmask, unsigned int reg,
+						const void *val, size_t val_len);
+
 };
 
 /**
@@ -1237,6 +1247,11 @@ static inline int regmap_clear_bits(struct regmap *map,
 
 int regmap_test_bits(struct regmap *map, unsigned int reg, unsigned int bits);
 
+bool regmap_parity_calc_even(unsigned long rwmask, unsigned int reg,
+								const void *val, size_t val_len);
+bool regmap_parity_calc_odd(unsigned long rwmask, unsigned int reg,
+								const void *val, size_t val_len);
+
 /**
  * struct reg_field - Description of an register field
  *
@@ -1866,6 +1881,23 @@ static inline struct device *regmap_get_device(struct regmap *map)
 	return NULL;
 }
 
+static inline bool regmap_parity_calc_even(unsigned long rwmask, unsigned int reg,
+						const void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return NULL;
+}
+
+static inline bool regmap_parity_calc_odd(unsigned long rwmask, unsigned int reg,
+						const void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return NULL;
+}
+
+
 #endif
 
+
+
 #endif
-- 
2.25.1

