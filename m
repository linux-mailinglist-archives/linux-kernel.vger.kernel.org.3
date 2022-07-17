Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ED4577384
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiGQC7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiGQC6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:58:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB65581;
        Sat, 16 Jul 2022 19:58:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so15108740pjm.2;
        Sat, 16 Jul 2022 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/VI7YUfA5Fsxh+qRIziCTYBbz2ocw98Lfn29Sh44rrA=;
        b=qTDxMO+v4qvRl/qq+VwyHKx/LIEmhLdzp2ZDtJNh+F+ks0Kv0UflWGQnkdGOioltiO
         +a9O+WP5yke0yyO5t/u9BSJt7JzmoTsr76CIPP837tIaXbp4QE9pDOozcVHlM+qYo891
         rPTgyiWJzq232b3kf3W5MXLMaYJrB6zqGwaVqrZ/hWkBBJuSLpWXeWlRf2BA6o9ko9sa
         kQ830ZFfi4J2s7XTpaZyGuY85/gj3FkFECHczXTbZWW17ILMsu6YjZa+sXCbqSn4JUzP
         3jzbeO3u8SuWFwHwt2KkxBmQsnhZsd3etZXVZFwppQk3xrQPJH6THmn7feblsFoD6pJV
         7MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/VI7YUfA5Fsxh+qRIziCTYBbz2ocw98Lfn29Sh44rrA=;
        b=jMF1Gglc9FjISpzfV9zXI75PP7qK55Nbg2AuEIkbHpxr5M2pc1MBFQd9sJPexTwe2K
         ujioDpRDZZY3gd8o7unXXjqB403SdHnznAezEkU2FKpKBRCcG93JHCZ1y5RuQAhxwHjT
         GaniIf9cPjuySBFo6rR2FpGpoCVk++sXzMhRitNPyL1tse+i9bgCgmBXcbPN97l/k8W6
         PCPT/uOn15+JREBGl9ih5He2dVoSbjjIvt/QRVnbwO89mRqLgQ84h0B0PQ4WSdQQLjj2
         L1Jp/93Qehwf3q5xsFJi8Ld3V2FC1va2HAx/V0X8TPVjQ9Siid75vooE1Ti78po6wZ6z
         Aw9g==
X-Gm-Message-State: AJIora8LmxvGiW2PPfmMTfMRcbcijwwf6Q/e1ZIktfwn1wuF+x2Xvbah
        UV7RVFys8qad3Vwe1Ln1Qg==
X-Google-Smtp-Source: AGRyM1sXw6VE5tW7ajLmW2A1FcYbP7hd9CuyNXGLTTzWc42ZEJQwTEWapwlZBorABnPBw5jEmcKe8A==
X-Received: by 2002:a17:902:a513:b0:16c:e25e:16b with SMTP id s19-20020a170902a51300b0016ce25e016bmr3744596plq.86.1658026717073;
        Sat, 16 Jul 2022 19:58:37 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79852000000b005252a06750esm1693975pfq.182.2022.07.16.19.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 19:58:36 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     t.schramm@manjaro.org, sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] power: supply: cw2015: Use device managed API to simplify the code
Date:   Sun, 17 Jul 2022 10:58:20 +0800
Message-Id: <20220717025820.1610091-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_delayed_work_autocancel() instead of the INIT_DELAYED_WORK() to
remove the cw_bat_remove() function.

And power_supply_put_battery_info() can also be removed because the
power_supply_get_battery_info() uses device managed memory allocation.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/power/supply/cw2015_battery.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 728e2a6cc9c3..6d52641151d9 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -21,6 +21,7 @@
 #include <linux/regmap.h>
 #include <linux/time.h>
 #include <linux/workqueue.h>
+#include <linux/devm-helpers.h>
 
 #define CW2015_SIZE_BATINFO		64
 
@@ -698,7 +699,8 @@ static int cw_bat_probe(struct i2c_client *client)
 	}
 
 	cw_bat->battery_workqueue = create_singlethread_workqueue("rk_battery");
-	INIT_DELAYED_WORK(&cw_bat->battery_delay_work, cw_bat_work);
+	devm_delayed_work_autocancel(&client->dev,
+							  &cw_bat->battery_delay_work, cw_bat_work);
 	queue_delayed_work(cw_bat->battery_workqueue,
 			   &cw_bat->battery_delay_work, msecs_to_jiffies(10));
 	return 0;
@@ -725,15 +727,6 @@ static int __maybe_unused cw_bat_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(cw_bat_pm_ops, cw_bat_suspend, cw_bat_resume);
 
-static int cw_bat_remove(struct i2c_client *client)
-{
-	struct cw_battery *cw_bat = i2c_get_clientdata(client);
-
-	cancel_delayed_work_sync(&cw_bat->battery_delay_work);
-	power_supply_put_battery_info(cw_bat->rk_bat, cw_bat->battery);
-	return 0;
-}
-
 static const struct i2c_device_id cw_bat_id_table[] = {
 	{ "cw2015", 0 },
 	{ }
@@ -752,7 +745,6 @@ static struct i2c_driver cw_bat_driver = {
 		.pm = &cw_bat_pm_ops,
 	},
 	.probe_new = cw_bat_probe,
-	.remove = cw_bat_remove,
 	.id_table = cw_bat_id_table,
 };
 
-- 
2.25.1

