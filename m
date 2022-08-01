Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D03258733A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiHAVZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiHAVYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:24:40 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E50447B9E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:23:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so6128186wmm.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5vPTvuI94uga8nmWiqOTMlhssMKMlt7Rbmmokv8UyAg=;
        b=wt6xODkYD445EYpWI+JRw0WXGCdZoqDEH7S8eChD38t2bqFCPkHvBFSd2Jkn0soefk
         0HeC/+81c+2PYP0+unORNyqe1RPzBOcfdn8NJJzOIjcyFt7z0OidueDoaL+PXKDpuDB6
         BK8IIyOpf8yqwebHYkptv0nHlTuROoN1Qi1Px7oT7XUMDmhe1Hc5ABlSGHePFSiZRfi3
         +VI5OI718UhkNG+5IhLRoJojMsPC5qtl/JzD5IjcKRBwfoSHBkJibLe0pwBAgXmVxjtX
         kwrOvFt3Op4Li+ocwD2unkfqfNmG9BGCBamaMbzR2M93LRbynQepoSvYZQ5nRRQ2FsH5
         E70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5vPTvuI94uga8nmWiqOTMlhssMKMlt7Rbmmokv8UyAg=;
        b=diEkh+FC9LZ40OAlSSIl2wpRiuVW2pZNQcnN9s41aIudy4ongEkp0uXzhSbrgGWnM1
         5wClgXEXrHtvkrqUQFw+vW9v4RXZfO7IucMRTHo9qeRjt4OlI71OZh+/RL6njmXii7k7
         F3/JtULjKM1BF3ksOyZydkaHtdv/fE3+ZnXdFXOrpJ2UP7g7W3O9+TUhCirboQbVLFLy
         sv7YQ3uLwSnxJtCpbQjYwVSWhmzRw1QtJQv6MsUeSBVwc7GuVnIPdTmH9vMUuOQScKeh
         zQS58uSAFhwufNE7f0kUqumDBDwkne/rQ9peGVjIwAsTBYCutgPdDOOV8iMfYeNlgX91
         pqCQ==
X-Gm-Message-State: AJIora8gbe8nSdODKYpFGvoz3cwjbt2kGSe+mGV+PKKaqlcK4Ea/HqYL
        gh4OVo6yeDVcmf2Gm/6DhVAAyA==
X-Google-Smtp-Source: AGRyM1vKRd1XHoDvV7OiS2x/zhAy1mn9ywFi1Bp99Dat/GKqhlZQfpbkAaO2FfJ22mOsniM7EEQo6g==
X-Received: by 2002:a1c:4c0d:0:b0:3a2:fc6e:f8c7 with SMTP id z13-20020a1c4c0d000000b003a2fc6ef8c7mr11822533wmf.102.1659389037073;
        Mon, 01 Aug 2022 14:23:57 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:56 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 22/32] thermal/drivers/maxim: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:34 +0200
Message-Id: <20220801212244.1124867-23-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/max77620_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 82d06c7411eb..6451a55eb582 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -44,9 +44,9 @@ struct max77620_therm_info {
  * Return 0 on success otherwise error number to show reason of failure.
  */
 
-static int max77620_thermal_read_temp(void *data, int *temp)
+static int max77620_thermal_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct max77620_therm_info *mtherm = data;
+	struct max77620_therm_info *mtherm = tz->devdata;
 	unsigned int val;
 	int ret;
 
@@ -66,7 +66,7 @@ static int max77620_thermal_read_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops max77620_thermal_ops = {
+static const struct thermal_zone_device_ops max77620_thermal_ops = {
 	.get_temp = max77620_thermal_read_temp,
 };
 
@@ -114,7 +114,7 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 	 */
 	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
-	mtherm->tz_device = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
+	mtherm->tz_device = devm_thermal_of_zone_register(&pdev->dev, 0,
 				mtherm, &max77620_thermal_ops);
 	if (IS_ERR(mtherm->tz_device)) {
 		ret = PTR_ERR(mtherm->tz_device);
-- 
2.25.1

