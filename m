Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62211580693
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiGYV2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbiGYV1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:27:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB0B24978
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z13so17706450wro.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3rC2SEgtKSVYrTT7ru1qnZcNbf0y/uFQwB+BT2UAJtk=;
        b=tTJaqnwqmawVByEqOMOm/Nv3cFkRkBv4F34hoQsNqeHfIYqK9b0w66zJ/b3DteSjE1
         CHI6TILbelwqxEbn7yu8S84Wj83o7+k9RDgpf4OsPl/VhX2/NHgT9NHt30QJdHRJmU7P
         ASp0U3bFvVVapXQlJhLp0OES774M/RjK2gEt4JzEB+1jJ6BuJEm4pg5OgBVubA7S4X3g
         BLOZ+1ai2apSnYTD/xJ4aVpdZqmaScGkmZ3Gl9QlSB4s02WAnNrIQQqTKunMp3hqUSIi
         npcv7Xfdim52pzhuNJ7iGQKLvUmKVrLirrEoYvLetmViTgh9GNtuhNpyEf/uwj5fjep+
         6dTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3rC2SEgtKSVYrTT7ru1qnZcNbf0y/uFQwB+BT2UAJtk=;
        b=0kTZrpnutz5rYqtzQT+K4HU36sxuJemcWow8V5RrsejNeAAJSW1WKxRL1YoLMHw/Wx
         0C6DBSCNNK+qIZsoNoMaG2FAuwIXkQPTm4tzvENkgpMib7KCydpxni3FNRz7+VEG+pIQ
         l3eUV6M/LU9TWyhexeHoIVL78LqtqI4ux2TLawt8N7+QvD2WUEUPcN9JdOsTWDVJ9IN1
         D6VinajZL40LK8qgAGwKsz2SSPZuxpgtEilcpnSUgqS1Q1P55at6F73HXEz6EK2XmKC9
         PoaoGSQbvtqM6RQjVSSs5J+Xr/DZefGV/NaqFAvX2Xsi3zoeOm/7kEW2KPod/BPxIAzV
         dNDQ==
X-Gm-Message-State: AJIora9oBUJnNPYW7EPWEn47D3dKZmlRydOALnuG2dzCEgSiYn4aR3WE
        LaS0EfPYNClukAM9UokXahFOIQ==
X-Google-Smtp-Source: AGRyM1ttVeL1IJspkC7l7dkljVdsHkFLoAkcA2NnEFSotEZrsW61Y/M6NtQUvLW/0P5DpewP6i9a8A==
X-Received: by 2002:adf:d084:0:b0:21e:5570:2b05 with SMTP id y4-20020adfd084000000b0021e55702b05mr8661442wrh.554.1658784435454;
        Mon, 25 Jul 2022 14:27:15 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:15 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Amit Kucheria <amitk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 09/32] thermal/drivers/sprd: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:14 +0200
Message-Id: <20220725212637.2818207-10-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/sprd_thermal.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index fff80fc18002..ac884514f116 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -204,9 +204,9 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
 	return clamp(val, val, (u32)(SPRD_THM_RAW_DATA_HIGH - 1));
 }
 
-static int sprd_thm_read_temp(void *devdata, int *temp)
+static int sprd_thm_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sprd_thermal_sensor *sen = devdata;
+	struct sprd_thermal_sensor *sen = tz->devdata;
 	u32 data;
 
 	data = readl(sen->data->base + SPRD_THM_TEMP(sen->id)) &
@@ -217,7 +217,7 @@ static int sprd_thm_read_temp(void *devdata, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops sprd_thm_ops = {
+static const struct thermal_zone_device_ops sprd_thm_ops = {
 	.get_temp = sprd_thm_read_temp,
 };
 
@@ -408,10 +408,10 @@ static int sprd_thm_probe(struct platform_device *pdev)
 
 		sprd_thm_sensor_init(thm, sen);
 
-		sen->tzd = devm_thermal_zone_of_sensor_register(sen->dev,
-								sen->id,
-								sen,
-								&sprd_thm_ops);
+		sen->tzd = devm_thermal_of_zone_register(sen->dev,
+							 sen->id,
+							 sen,
+							 &sprd_thm_ops);
 		if (IS_ERR(sen->tzd)) {
 			dev_err(&pdev->dev, "register thermal zone failed %d\n",
 				sen->id);
@@ -523,8 +523,8 @@ static int sprd_thm_remove(struct platform_device *pdev)
 
 	for (i = 0; i < thm->nr_sensors; i++) {
 		sprd_thm_toggle_sensor(thm->sensor[i], false);
-		devm_thermal_zone_of_sensor_unregister(&pdev->dev,
-						       thm->sensor[i]->tzd);
+		devm_thermal_of_zone_unregister(&pdev->dev,
+						thm->sensor[i]->tzd);
 	}
 
 	clk_disable_unprepare(thm->clk);
-- 
2.25.1

