Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A618529925
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 07:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbiEQFvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 01:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiEQFve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 01:51:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAE73DDD7;
        Mon, 16 May 2022 22:51:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q7so5025957plx.3;
        Mon, 16 May 2022 22:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwvzoeY6N9lJ4fKAAqEsuvjxiVm8EwN2t9yaRifsIoc=;
        b=IuBnJZko7z+mYQOiTfa5mrvWE04qWHy4+1eddt0J8qUj59+sfA03udQJQaX96+iHcv
         P1b5J/dplK6ghbqW3+VYgAsom2M9WheUcYvCSBzKpma5XPVT7lQ7nN3VuepLGQjF0B5y
         QDMGNvGh9NL1zl2VLOh0sTuwdtZaWxFOJguydVyW16KT3u64ydyNqSDC1bThTMCmdJ0D
         Z7dKNY5vIX8r74SWTZFAbOYFpGe/az/8Hvux2nMiguucbyfEo5PXp6LUp3nWGTy4ZDjC
         egLg7TIXkbtTl2/ll5yQBWDt85HWHB/cZIZ5RPYn6De6UZXFmUR6p0kegLlsDLYNBFvO
         /k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwvzoeY6N9lJ4fKAAqEsuvjxiVm8EwN2t9yaRifsIoc=;
        b=OJKTbS1ulOoe56j0x09UpPuBxkxaDGNESeC3I2iIjec5IALqExNCPKpD3kahBQyIM6
         xS4XrlrU5X391FPpiVxLUM6OZqVh0dWXfA8PuxID4711txteP95kOFlMO7QkHRsOEykG
         O0xVb4CcyFcnEXT+G6XKn/iyJG1tRtw7CtIxiIEaS8b/KyzoLNr2i9l65cbq1MbS/qst
         W/7jZJbCkm506tQGocjNZXc23DpCupZeUGtuyhPc/ouiMeaBHh3Cd9rQ5qpqtcksizsA
         XbqpJOoA5UwPF1cjZgFKRMc+4m/AAVgAl1eVi35j3m8/OI41j1JcaQ09ofHGI2voYvm/
         kAzg==
X-Gm-Message-State: AOAM531ORLhZFLvOCOdQnY+7/dWQijc1P6g+C1OcTUG9fOav42QsToXZ
        w0213oh1tWotm92TiYflWsg=
X-Google-Smtp-Source: ABdhPJxUvQzeLnS5fgfw4sRQZ85fmjGNSpwRzd4pl8qtvQDNTT/6Z3W8r7fBlzshAsesUF1CgWechA==
X-Received: by 2002:a17:902:eccd:b0:161:9e20:1a14 with SMTP id a13-20020a170902eccd00b001619e201a14mr3566936plh.43.1652766691934;
        Mon, 16 May 2022 22:51:31 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id c7-20020a62f847000000b0050dc76281f7sm7825217pfm.209.2022.05.16.22.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 22:51:31 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] thermal: imx_sc_thermal: Fix refcount leak in imx_sc_thermal_probe
Date:   Tue, 17 May 2022 09:51:21 +0400
Message-Id: <20220517055121.18092-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: e20db70dba1c ("thermal: imx_sc: add i.MX system controller thermal support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- use goto statement, also move of_node_put(sensor_np) to goto label
v1 Link: https://lore.kernel.org/all/20220516073151.25918-1-linmq006@gmail.com/
---
 drivers/thermal/imx_sc_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 8d76dbfde6a9..331a241eb0ef 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -94,8 +94,8 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 		sensor = devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
 		if (!sensor) {
 			of_node_put(child);
-			of_node_put(sensor_np);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto put_node;
 		}
 
 		ret = thermal_zone_of_get_sensor_id(child,
@@ -124,7 +124,9 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
 	}
 
+put_node:
 	of_node_put(sensor_np);
+	of_node_put(np);
 
 	return ret;
 }
-- 
2.25.1

