Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9462E533E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbiEYN6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244570AbiEYN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:19 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDB4A88BA;
        Wed, 25 May 2022 06:58:13 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id s32-20020a4a96a3000000b0040e504332adso3160353ooi.10;
        Wed, 25 May 2022 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t3cFHh53b7IS8Ryw+ayFhZMqP5rwh0La2dUSPu/QbWY=;
        b=cZVij116AZiKG7kv+anRi/e1ATjyNjEbhNpgluWM7nFMB8SHkC2z9KV+/Jfjp2+Lln
         9VNiX6ydMKfZ90POVveIKoFBIwaFQGGnH1H4xuCpvGah3245fiwP9POP0HzJcOqiOHSW
         UbIXgWL7rGw6QBM7um77j1txqE/OhMzYKzqoCELzK80W8DNUnQvY9WI/y9HcPYUTBgPY
         k5rmDTy/w+VJ8XIVKnG6LvGT17BkXrHFjKZIXID7v++OmC/rhRTmld0wzMcCUZMC5/XS
         Wz75cLgHY21IUbeuQuHvDh3WeXGA4+6AXsoLdvmee+kWf2INTOnqHF5P+43vcUVguVcy
         ctaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=t3cFHh53b7IS8Ryw+ayFhZMqP5rwh0La2dUSPu/QbWY=;
        b=o+Kd3sUh7y0KAuYjaqM2c2wkRtg1w/BvGMel09vzjgH83qG+N4I5RGRuxCgS7rLX30
         vQGAndToSgEuF9LcHnrUVkpLvepv7eORkeUOFQ9nQsZ2Vf0kY5vmJorY55GWlOuAD8KC
         9ZgQ0z8wRUEhgGDwGtDwpyUwHRmEQuLQBLI4bn/b/Oo4lkDY1rkabDSF9K4fZW8rTygB
         7OktseYJa2haGLEVREZhes2DMPdL9cBzzbFHNeDFoZ7VdcIjizigTe97YhG6+htnCddO
         GBeRPb1PxirbLaDrrF3zWvT9S8PaKVfMDHFwQsfmA5GBvJVlhfvNV9WSknCB0N6/fW+o
         Lxag==
X-Gm-Message-State: AOAM531gF4DPwhgZf0zo+hUrmCNtT2Fe4pzExaF7ZSoPP4yMLYAsqCw1
        87aSEjZJiImNs9A1tjbsOCIeVcHpON+w+Q==
X-Google-Smtp-Source: ABdhPJxlGyhMA64i6beydqc0mlGTZSoqfkBU8C15z9ySEwoxh2byJdg0BpsmU2l95RiNqaGW0s+X4w==
X-Received: by 2002:a4a:430b:0:b0:35e:a582:5ba1 with SMTP id k11-20020a4a430b000000b0035ea5825ba1mr12822967ooj.75.1653487092765;
        Wed, 25 May 2022 06:58:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5-20020a9d0005000000b00606387601a2sm6067420ota.34.2022.05.25.06.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 06/40] hwmon: (lm90) Move status register bit shifts to compile time
Date:   Wed, 25 May 2022 06:57:24 -0700
Message-Id: <20220525135758.2944744-7-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135758.2944744-1-linux@roeck-us.net>
References: <20220525135758.2944744-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling bit shifts necessary to extract status bits during compile time
reduces code and data size by almost 5% when building for x86_64.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 0f3fadc1631c..cc26dd08fbff 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1345,17 +1345,18 @@ static const u8 lm90_temp_emerg_index[3] = {
 	LOCAL_EMERG, REMOTE_EMERG, REMOTE2_EMERG
 };
 
-static const u8 lm90_min_alarm_bits[3] = { 5, 3, 11 };
-static const u8 lm90_max_alarm_bits[3] = { 6, 4, 12 };
-static const u8 lm90_crit_alarm_bits[3] = { 0, 1, 9 };
-static const u8 lm90_crit_alarm_bits_swapped[3] = { 1, 0, 9 };
-static const u8 lm90_emergency_alarm_bits[3] = { 15, 13, 14 };
-static const u8 lm90_fault_bits[3] = { 0, 2, 10 };
+static const u16 lm90_min_alarm_bits[3] = { BIT(5), BIT(3), BIT(11) };
+static const u16 lm90_max_alarm_bits[3] = { BIT(6), BIT(4), BIT(12) };
+static const u16 lm90_crit_alarm_bits[3] = { BIT(0), BIT(1), BIT(9) };
+static const u16 lm90_crit_alarm_bits_swapped[3] = { BIT(1), BIT(0), BIT(9) };
+static const u16 lm90_emergency_alarm_bits[3] = { BIT(15), BIT(13), BIT(14) };
+static const u16 lm90_fault_bits[3] = { BIT(0), BIT(2), BIT(10) };
 
 static int lm90_temp_read(struct device *dev, u32 attr, int channel, long *val)
 {
 	struct lm90_data *data = dev_get_drvdata(dev);
-	int err, bit;
+	int err;
+	u16 bit;
 
 	mutex_lock(&data->update_lock);
 	err = lm90_update_device(dev);
@@ -1374,22 +1375,22 @@ static int lm90_temp_read(struct device *dev, u32 attr, int channel, long *val)
 	case hwmon_temp_fault:
 		switch (attr) {
 		case hwmon_temp_min_alarm:
-			bit = BIT(lm90_min_alarm_bits[channel]);
+			bit = lm90_min_alarm_bits[channel];
 			break;
 		case hwmon_temp_max_alarm:
-			bit = BIT(lm90_max_alarm_bits[channel]);
+			bit = lm90_max_alarm_bits[channel];
 			break;
 		case hwmon_temp_crit_alarm:
 			if (data->flags & LM90_HAVE_CRIT_ALRM_SWP)
-				bit = BIT(lm90_crit_alarm_bits_swapped[channel]);
+				bit = lm90_crit_alarm_bits_swapped[channel];
 			else
-				bit = BIT(lm90_crit_alarm_bits[channel]);
+				bit = lm90_crit_alarm_bits[channel];
 			break;
 		case hwmon_temp_emergency_alarm:
-			bit = BIT(lm90_emergency_alarm_bits[channel]);
+			bit = lm90_emergency_alarm_bits[channel];
 			break;
 		case hwmon_temp_fault:
-			bit = BIT(lm90_fault_bits[channel]);
+			bit = lm90_fault_bits[channel];
 			break;
 		}
 		*val = !!(data->alarms & bit);
-- 
2.35.1

