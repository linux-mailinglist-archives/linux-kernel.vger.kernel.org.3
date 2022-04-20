Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C469508835
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378581AbiDTMe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378557AbiDTMeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:34:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8CB4093B;
        Wed, 20 Apr 2022 05:31:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m14so2061929wrb.6;
        Wed, 20 Apr 2022 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ieFyPM7qLxem8XQW8qH6ZsBF3gD5CdZ45mGbsiUiaFc=;
        b=MSTUZCHRR2Dst97gveOvSCqtDiE4vDdw9/hXTqBcAGSZuPnC+WiO0RLeOQtSABs3c7
         qmVndv0HXVZ6B4cBz/dfUonUmYBSWKn2MNW0RXCZ50UOKLGIuTID/ImB1l4UeP0U2SPA
         UZVBnaqwnYZfQp3kabQXTKCL2bmPh4P7QEkKU9SQqx/SfT0mXKfvo0e+bt/ATWhqhrog
         F1b7f6c7DW/gN744+2Le7J8ai+rYhUHMN6TJHMMLtxYAGJAruBowWRKRjoTceg+N0K82
         /gXMfjq/bN6veVy8hTqtkSETGRKaVDKncRE2+FukNUoLgUk192ckD3KYhhVKhCq7V//0
         wARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ieFyPM7qLxem8XQW8qH6ZsBF3gD5CdZ45mGbsiUiaFc=;
        b=5ovXnXl3geuhBueNLMK/ohakID3nj/Byme+Gavttqrw7Vol6N+YPNktZXLZHVopKbM
         PqjjBkP1BtXXSGTnbpawaSck4nFtJV+UtK20Ir8JGgtcyo+6cjvJN6vy2ViqfVDvJ/3r
         cPi3P8I2nfhS5QcaiUtbo4/kU6pyIekLH2w7h7hD3AQpa0bW/x2+24Pu4G+hP8Y7bBjn
         rrzn7pCjSdpzM97mEcA821TppsHNvJL4WN3s4S4tgbGl+0bDAycHT20crrZ8WZqyDxiI
         S9ckwYBlhbVI0JQvl6PEHze0N+ScFRbPomOH1ABEfmOadUASNU8FRGxOcm5TqXEjEhSo
         JKKg==
X-Gm-Message-State: AOAM531vlUqcSI2gv/V/OI24TMpUuUPUFRkH5ae8ROd4WC4OaYCNMKax
        rM5EmdKkhm9qjJfIMDI5j0tz/DSAUv0j+g==
X-Google-Smtp-Source: ABdhPJwaP28Yz/dBy3z2KMxh3KoGE5KGifFFq6Ff0We44WEvco4tinvVT2CYQV6wP6omeKldMIX32A==
X-Received: by 2002:a5d:6983:0:b0:207:a226:df4b with SMTP id g3-20020a5d6983000000b00207a226df4bmr15389885wru.192.1650457892485;
        Wed, 20 Apr 2022 05:31:32 -0700 (PDT)
Received: from tpt440p.steeds.sam ([41.84.241.188])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm21277277wmq.35.2022.04.20.05.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 05:31:32 -0700 (PDT)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     pali@kernel.org, sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2 1/1] power: supply: bq27xxx: expose battery data when CI=1
Date:   Wed, 20 Apr 2022 14:30:59 +0200
Message-Id: <20220420123059.1206443-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220420123059.1206443-1-absicsz@gmail.com>
References: <20220420123059.1206443-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 59 ++++++++++++--------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 72e727cd31e8..9adc7f43bbfd 100644
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
@@ -1766,30 +1772,19 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 		cache.flags = -1; /* read error */
 	if (cache.flags >= 0) {
 		cache.temperature = bq27xxx_battery_read_temperature(di);
-		if (has_ci_flag && (cache.flags & BQ27000_FLAG_CI)) {
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
-		}
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

