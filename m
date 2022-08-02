Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E5A587828
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiHBHq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiHBHqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:46:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644C941D22;
        Tue,  2 Aug 2022 00:46:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so12896879pjn.3;
        Tue, 02 Aug 2022 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=K6iJGYL9UOTfyxZuhDtKKHtK7jVAlQ/d6e1AxqHuS90=;
        b=j1V7g5kHpM84c24sFm2MSN0xyHQwwxiV6p9M/inrKVk7e9dIyRzG+aN5O0ShzLLBkE
         /ZISirsnYhatV4TiHi+rX9xaeYPK/ZBGbTW0nMXWVZfluuha/Rg+3Ej+7E8w/UXEznEH
         SjsfitQVr1ZfboQJZqPz8n28nhC5RPrJDCxVB1BT7WeSBRTAeKEnMwjsTR5/e8A0y31V
         GBae34RqtDO8B/AgGgF5gnO0jv4BiT74u6bt2Gmyr0c3aHjm4TdYNNQkSWEG05QgDnCI
         mGmIXETZcFDCdIvcGEXbB+sIY3PaZ5XtYCsnCtvn3AfQudA/VyyMln1/cysl/yI2byq4
         Zx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=K6iJGYL9UOTfyxZuhDtKKHtK7jVAlQ/d6e1AxqHuS90=;
        b=f1+XQXmCSAJgm7UMNA4UAZTyxJ3xEAZHAwVdcol43URL/kdPmUAOmYJ0XFpOLzp9ZH
         focrq2nHzkFhduqqkt9QgRPeuu+Wzb6VHRRoOkw1BCMjLPLkz2vrxAe7NiP5eDHG9K7A
         Vt294XT0sQdEXvKwYMpOhsLeLmmhw+9y8la8SqwziawEoQyrsKKPTVvQiJfNMagmVRKN
         fGwc4SYlfc+LlhdCXAdZK7C6xLRbT8yKVI9RnjfJupSAW1Edruv609C3hlxyGbsHSaZ2
         40TV9md1HqnSyZ99ewh2Fl+eP+elgC0y4dqP42hghy7mOHTtc5hURKYvWcbzNVqDHp2H
         NE8g==
X-Gm-Message-State: ACgBeo1cCrBbjJo1Z9K/5eQs1hQX2AUU9s/PVb+lAiBtX90EGGX/UkBr
        KXJuz370t5TY33pA52c58qCuJ66i2UE=
X-Google-Smtp-Source: AA6agR6NJD6v46rHuBj5hpjEvVeguESNO5hkrR6/GJoopeoZsOqyR8AKCEVdvD/ZYByGEimpl9QxPg==
X-Received: by 2002:a17:902:f608:b0:16d:20a0:5339 with SMTP id n8-20020a170902f60800b0016d20a05339mr19841374plg.133.1659426407650;
        Tue, 02 Aug 2022 00:46:47 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q30-20020a631f5e000000b0041c6541383dsm784429pgm.60.2022.08.02.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 00:46:47 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] watchdog: rti-wdt:using the pm_runtime_resume_and_get  to simplify the code
Date:   Tue,  2 Aug 2022 07:46:43 +0000
Message-Id: <20220802074643.1648660-1-ye.xingchen@zte.com.cn>
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
 drivers/watchdog/rti_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 053ef3bde12d..6e9253761fc1 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -225,9 +225,8 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		wdt->freq = wdt->freq * 9 / 10;
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
 		pm_runtime_disable(&pdev->dev);
 		return dev_err_probe(dev, ret, "runtime pm failed\n");
 	}
-- 
2.25.1
