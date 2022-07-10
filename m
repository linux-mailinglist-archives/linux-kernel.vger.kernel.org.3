Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21FD56D198
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGJV0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGJV0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:26:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974FE15A2C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v14so4766546wra.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9855bcD552GJSWzdSCMScVvlZ52p09zVu+Xav1fO3uQ=;
        b=m/g9crDtZC0kIrS+BX9yIchWTNbmQnD5qx93xAy8gvioRQg3BDDaqAEWN+0Y98GC/3
         US3JKNH/WviYe1i1bdTEhK2ZNv5uAmqbgxW+NsjlLB6FG9FObAd1aPjZ3DeMIEp7F/8R
         N69Cj3i0wKhXGgL79k3hYeMZ/cvqByDYlye0b0XFAnsFBJbtOq7/nsHzpcgMBorV7d4a
         A8y9bv4cYd6kqqWK0CIu6Wd+V+h3Jjv6gTSsO6uYavzZM0Zm0pKbwuiWcLDJZhFO1GO0
         XeZCS9yRRMUDzGtsf/yG5bNgZ38VykvIYo5bYXwGd+f88UGWF82Dzc68xH2UctuYnQ1/
         RZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9855bcD552GJSWzdSCMScVvlZ52p09zVu+Xav1fO3uQ=;
        b=FWbGym8x7qZp99ynXSngsHhdYm+6biDHFsQNa44x2oCL4Qj3ppIjFnccyudtQr8gxE
         +bBYWOGqjDSTFE++WGV+MrTb1v5dqhnjGvtC1GzQ7AzV5Ktxti/DYCDv7pdP5L9KKUSw
         U5CUsqYekSSuQ7N8iuzAXM71EZqi9wQ3UBz18G9ipst+UNmavcmgkkvU81Meo/Sb9b2k
         dxIfDO3f4MNmdCj1b7JQGRJOcaBzDMG5M12Rmx54rcUD4e2FKb0ztlewmZCF8/47esT7
         ++kDNkQxtESLYHQvB+f73Ws2GYnlffnvv4SnHUU2gXcT9K9GYYEAG9YR25loCD7MytnR
         41UA==
X-Gm-Message-State: AJIora+fWCNzVD+qdQqwDQL/Uw0+h288kPzM8Bg13FWGzuq+3BjVBnIs
        cqSXAnuyRCQV52re2C3ezeopjQ==
X-Google-Smtp-Source: AGRyM1tt6ENRWIiaSfIKK6zn2vgRUnwKDlsTdemCipZ8p/zzmnqRH8+pNUZZCj7ShkPgfPflA1WmCA==
X-Received: by 2002:a5d:47a4:0:b0:21d:99b2:9434 with SMTP id 4-20020a5d47a4000000b0021d99b29434mr8097259wrb.597.1657488312172;
        Sun, 10 Jul 2022 14:25:12 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 22/33] thermal/drivers/maxim: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:12 +0200
Message-Id: <20220710212423.681301-23-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/max77620_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 82d06c7411eb..b64070cf17e7 100644
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
+static struct thermal_zone_device_ops max77620_thermal_ops = {
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

