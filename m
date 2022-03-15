Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A734D92AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbiCOCfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiCOCfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:35:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734D44754F;
        Mon, 14 Mar 2022 19:34:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so1039548pjb.5;
        Mon, 14 Mar 2022 19:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jv/uO4ktRhHgJvY0t9qThitrZmG/d53V0zX21g8e8ks=;
        b=IvCkPDBcj3XHekHZSIEmUfeoOwo5PQoUgdF9NMN0BZ6hse1Gvhr+Lgz4EjZM/1rRf1
         LI0CxvyJHHy5HOxvNGPWjYudiSnKW/mC+Ffw3cQqjzE+yMN/aOUkmXN1YF+pBz50s8OU
         eaxMA27/d/Z5hydW5QFhjbQJdpCjRMsUmiTRxTFOKYF2FXWUWjGWUD+6+230UBNWwVyC
         zplXG+cVFXaBUuY8LLjfHdWokC02rCXPpIhcd6uquiIK3D12myiJXHGamCdqidQZB+98
         VUliAGfIFvWKHD480hyp4Kbr1zptNMZx3cknMfyEy/sRS1WfVCe4+y+IdKhwfeJk6ld/
         wmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jv/uO4ktRhHgJvY0t9qThitrZmG/d53V0zX21g8e8ks=;
        b=SXZlATPFPd0ZZfkzc/Yvf7P8WOqSFX8DyXp31ftjsVXiaIJGQx1kIgROh1KteJeaDM
         NPIBCvVvJlBRFqqyjum5UJFKaephaazB0GQX/0bmLSUr5KxIe2aTivt9HJeqo1ClpZP9
         fThWUH6XtEyrLix4d/vFz0iZ/J/M20YEmvdsisy66NZpkX03DJYs90gAzq/kFLHGlxyG
         3G2oHXC09R33moUiYqWhyEt/Mk6uVOYOxO48ehTyHutjAC1YmOxMokz7/s3TGhtJgleT
         /89lMCNzOeVUDyA6ATffV0tVVLLJZBCER0SCNYFMiHfyfXkDX5QvAEyjP8/MszVfkeV+
         9ZOw==
X-Gm-Message-State: AOAM533LOlC0Jp9XmNh7t6/0WN/MB7+XjbKfpURTdeva3OGZSKgXLxRg
        M59UQmiPuphHvUWgFlEHHbY=
X-Google-Smtp-Source: ABdhPJx6LgLHKafIvEvSSeHextJqmzgrHBJJsu3z9XjfEglz0xHEf5YQwhEC2yYUdbu7u2Sft+XxCQ==
X-Received: by 2002:a17:902:7fc5:b0:151:863e:44ee with SMTP id t5-20020a1709027fc500b00151863e44eemr25924553plb.163.1647311658821;
        Mon, 14 Mar 2022 19:34:18 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id oj2-20020a17090b4d8200b001bef79ea006sm875759pjb.29.2022.03.14.19.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 19:34:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jdelvare@suse.com
Cc:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] hwmon: (scpi-hwmon): Use of_device_get_match_data()
Date:   Tue, 15 Mar 2022 02:34:12 +0000
Message-Id: <20220315023412.2118415-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/hwmon/scpi-hwmon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 919877970ae3..5187c6dd5a4f 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -141,7 +141,6 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 	struct scpi_ops *scpi_ops;
 	struct device *hwdev, *dev = &pdev->dev;
 	struct scpi_sensors *scpi_sensors;
-	const struct of_device_id *of_id;
 	int idx, ret;
 
 	scpi_ops = get_scpi_ops();
@@ -171,12 +170,11 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 
 	scpi_sensors->scpi_ops = scpi_ops;
 
-	of_id = of_match_device(scpi_of_match, &pdev->dev);
-	if (!of_id) {
+	scale = of_device_get_match_data(&pdev->dev);
+	if (!scale) {
 		dev_err(&pdev->dev, "Unable to initialize scpi-hwmon data\n");
 		return -ENODEV;
 	}
-	scale = of_id->data;
 
 	for (i = 0, idx = 0; i < nr_sensors; i++) {
 		struct sensor_data *sensor = &scpi_sensors->data[idx];
-- 
2.25.1

