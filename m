Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F55862B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiHACii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbiHACia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:38:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4690223;
        Sun, 31 Jul 2022 19:38:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y141so9364409pfb.7;
        Sun, 31 Jul 2022 19:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zNIL0d60+lP47ZBgcTkvjxzvvxJ/d6RHaA53rs7bZXo=;
        b=ZhaTHb6h5NaWbmcaBac8WRQF0u5GyIfHdsfOk+yF8bJrM/ADNiTFnCC2LwJinyqYls
         dvbugYZFWVccDX++veX8Lnba3wJKr6cuksTOC9axM7NT/eWt4TP9/flKndLmGBQzC7Ms
         SKymiOdQB7P1iZNhgBhW6Rv5UiMoFTtbf//W+tym7iGOocDbB+wfHTjdG4aV8p6aQSm3
         9zo1ULrWwFOrMmpRY38v4IK8WzFPz124EdG4i3PBsAGUrWCvEsU/rRfWW2F+KodKjk6G
         9zlNENCg2KxmtJ2Owi6fr4PXER91ywN5JKpnpmeaB+xW6gd2AQbd+OwcKCVTVYaPW2eO
         SEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zNIL0d60+lP47ZBgcTkvjxzvvxJ/d6RHaA53rs7bZXo=;
        b=Obft3PuKcxhUkNSZ+fNwy9zd5QO1I+zEGWmdGE3C0D/TPAwxQx7mL0nQPwdFnbkfMD
         9W1h0YAdDdKjUsYoa1rpbTkrgGNw+LYvL1ZV1fnaH3VxDoCLRNs68+OsRkn6MnhTzmS3
         CI7xM8PK5l0HJkuuTIKPsNGvib6KqdDzAQLjjxeWI4BusjGAvfZ5nMqU63n2UE5n5gwF
         Ytgn7HhaMK+Km24yHAycVIrnSCGCKZ00loCsKipAwnhzJdsSU2JlgH3pTbWpHqCgF5Lw
         5RwLHD2hEJGbjrPIkM6ys0RZTmL/t/FDaxQPRlvpeUABY/Uyew2VfitpgBppUKattMO3
         4bTQ==
X-Gm-Message-State: AJIora+Nfl2SfI3izZfUDXDgZvC1i+3ogcVh2M8RX4MOPf+bvIkCt4GH
        iUAkNOYd8+Lr7DLznzcICqAX/RcC9g4=
X-Google-Smtp-Source: AGRyM1suHZXC+Q4CTRBSQf5r/19buWarOMOoo2orLz0T2aIijGM7NZXwh0Kd94sC+7OU8QQmjXH06Q==
X-Received: by 2002:aa7:8811:0:b0:52a:b0a4:a324 with SMTP id c17-20020aa78811000000b0052ab0a4a324mr14339903pfo.63.1659321509151;
        Sun, 31 Jul 2022 19:38:29 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id pg14-20020a17090b1e0e00b001f200eabc65sm7523795pjb.41.2022.07.31.19.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:38:28 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] thermal/drivers/k3_j72xx_bandgap:using the pm_runtime_resume_and_get  to simplify the code
Date:   Mon,  1 Aug 2022 02:38:24 +0000
Message-Id: <20220801023824.1595268-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
and pm_runtime_put_noidle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/thermal/k3_j72xx_bandgap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 115a44eb4fbf..5aabb89cf46d 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -403,9 +403,8 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		workaround_needed = driver_data->has_errata_i2128;
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
 		pm_runtime_disable(dev);
 		return ret;
 	}
-- 
2.25.1
