Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBBC507C03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358052AbiDSVkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357589AbiDSVk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:40:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE6381A0;
        Tue, 19 Apr 2022 14:37:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w4so24141822wrg.12;
        Tue, 19 Apr 2022 14:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HzjJ2MTgMzaGj1CR/cito5UBoUP4du8uF9tfJ2guak=;
        b=DC46k7gYUbv8MCUDj5L93SZ94PBWzbzq3rVih92WtQE31X09rOE8Xab8Vcv9HUE1rC
         yBIW9VKsi6iDKgmK8Q72k41MbVKMdyB3bdfIjwqLa9nuIreaVM0BG7j9xYK8Ln3Qj/fS
         XTU2KVZ+0yHPGHiobX3TkAPXujmB2fjSrz3YyzlaHVg7cNQGtXE+WuR3Z0I19Pg2TNAV
         l6AHzyZGPh4hLuwyq52WJoM6/GJOz5xtX+HITqC1NcfxIUElG6EgymS8/UYOf0FTFoeo
         1slZcHXfldsVO8SK6eKrFjQDs7fsed4yAQYzPbV7N7iyxSPNb6LUnRcn7u42q+sBBtxL
         gCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HzjJ2MTgMzaGj1CR/cito5UBoUP4du8uF9tfJ2guak=;
        b=Mn6dJL/pKWRiHlxzlnkgVfElpG/40bq40TlMDrgIJr/IaC1YALIORUxT3tht1GChpR
         0YYeehQOC/w59whZ3AZzGB8lSGYSvCDmUSkuZw7tHextirB31AaGEm/ZD01SM9CM7yak
         S3o8PTkl3TQ3QQIs79yNWW1/VElfnY4yfDgoTyeTftAFkHZ96G/rGeyUG01Zem/CJoFI
         7XeKKgOUdiuzcKKT0TboEWfMSrrar49V+EBjkoOkiiu3vTAJwZiv1NxgRsgh0oEX541j
         G1m06Bvyi4kJWZ9ezKZ7Sh1D9pNanNqkLI7XhsX1zC2k3Jrd/PmfM2zOn7rBpiYg6Kpi
         N/Sw==
X-Gm-Message-State: AOAM532Y8cpxf3mcrq67p6RwCYU6x8OoR6ROlFmcL7QHdZqdjUjGRyrT
        EiUjXqrUcqnC4l+tZjyXxP3K/eaIlDKxLA==
X-Google-Smtp-Source: ABdhPJwNcSoRHdUt+RQxWQDFEIssrjcoR4cKy5ClcIduAuGeO/63Dg72DuZE6HEBmTfzg7s5TRRBCA==
X-Received: by 2002:a05:6000:15c8:b0:20a:92f1:c054 with SMTP id y8-20020a05600015c800b0020a92f1c054mr9846278wry.146.1650404263988;
        Tue, 19 Apr 2022 14:37:43 -0700 (PDT)
Received: from tpt440p.steeds.sam ([69.63.75.250])
        by smtp.gmail.com with ESMTPSA id n4-20020a1ca404000000b00392965e41d6sm6574512wme.39.2022.04.19.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:37:43 -0700 (PDT)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     sre@kernel.org, pali@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH 1/1] power: supply: bq27xxx: expose battery data when CI=1
Date:   Tue, 19 Apr 2022 23:36:47 +0200
Message-Id: <20220419213647.1186284-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220419213647.1186284-1-absicsz@gmail.com>
References: <20220419213647.1186284-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the Capacity Inaccurate flag is set, the chip still provides data
about the battery, albeit inaccurate. Instead of discarding capacity
values for CI=1, expose the stale data and use the
POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED property to indicate that the
values should be used with care.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 58 +++++++++++++-------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 72e727cd31e8..a524237b758e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1572,14 +1572,6 @@ static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di, u8 reg)
  */
 static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info *di)
 {
-	int flags;
-
-	if (di->opts & BQ27XXX_O_ZERO) {
-		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
-		if (flags >= 0 && (flags & BQ27000_FLAG_CI))
-			return -ENODATA;
-	}
-
 	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_NAC);
 }
 
@@ -1742,6 +1734,18 @@ static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
 		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
 }
 
+/*
+ * Returns true if reported battery capacity is inaccurate
+ */
+static bool bq27xxx_battery_capacity_inaccurate(struct bq27xxx_device_info *di,
+						 u16 flags)
+{
+	if (di->opts & BQ27XXX_O_HAS_CI)
+		return (flags & BQ27000_FLAG_CI);
+	else
+		return false;
+}
+
 static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 {
 	/* Unlikely but important to return first */
@@ -1751,6 +1755,8 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 		return POWER_SUPPLY_HEALTH_COLD;
 	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
 		return POWER_SUPPLY_HEALTH_DEAD;
+	if (unlikely(bq27xxx_battery_capacity_inaccurate(di, di->cache.flags)))
+		return POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
 
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
@@ -1767,29 +1773,21 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 	if (cache.flags >= 0) {
 		cache.temperature = bq27xxx_battery_read_temperature(di);
 		if (has_ci_flag && (cache.flags & BQ27000_FLAG_CI)) {
-			dev_info_once(di->dev, "battery is not calibrated! ignoring capacity values\n");
-			cache.capacity = -ENODATA;
-			cache.energy = -ENODATA;
-			cache.time_to_empty = -ENODATA;
-			cache.time_to_empty_avg = -ENODATA;
-			cache.time_to_full = -ENODATA;
-			cache.charge_full = -ENODATA;
-			cache.health = -ENODATA;
-		} else {
-			if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
-				cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
-			if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
-				cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
-			if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
-				cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
-
-			cache.charge_full = bq27xxx_battery_read_fcc(di);
-			cache.capacity = bq27xxx_battery_read_soc(di);
-			if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
-				cache.energy = bq27xxx_battery_read_energy(di);
-			di->cache.flags = cache.flags;
-			cache.health = bq27xxx_battery_read_health(di);
+			dev_info_once(di->dev, "battery is not calibrated! capacity values are inaccurate\n");
 		}
+		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
+			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
+		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
+			cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
+		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
+			cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
+
+		cache.charge_full = bq27xxx_battery_read_fcc(di);
+		cache.capacity = bq27xxx_battery_read_soc(di);
+		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
+			cache.energy = bq27xxx_battery_read_energy(di);
+		di->cache.flags = cache.flags;
+		cache.health = bq27xxx_battery_read_health(di);
 		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
 			cache.cycle_count = bq27xxx_battery_read_cyct(di);
 
-- 
2.35.2

