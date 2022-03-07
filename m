Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B834CF048
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiCGDhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiCGDhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:37:32 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057785E155;
        Sun,  6 Mar 2022 19:36:39 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id t28so12244288qtc.7;
        Sun, 06 Mar 2022 19:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82smPzrd64J4jzkvd+yj19VF5/h1TZU7TJD+nXhzeao=;
        b=EB52k5R1jCqgYGxUBEzfQwSS27kJTyQxieIz8/Sk76Hdvgl7HvRBvZnYsB6zrB8iOU
         bD4u20Uq8qaoDU9Zkk2RaYAkMbvLvWz3s++zcy4Zbf7i52UBWehzqZagVjOFQp8e5Ov9
         cAENGzuF4njRdgshvzQ00LubouM31bVWhS8MsmGTGLtoCLFB6tyXZG41wmzvGy6GojM8
         ZOQEO6BX0EHxsXg5oavlPw7ypBY/2ND5MqSgfESBXcOr9oj/ofmZKpdJOlinZe1zS/kq
         xAr9SA0ULBig8C1WN+zj0VLt/+UOz6AvlR2Heoi+RtpvR03UgZiTzsFG/KaalcsnZB/V
         KyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82smPzrd64J4jzkvd+yj19VF5/h1TZU7TJD+nXhzeao=;
        b=nr9GXy6AHTpBHchlpjLd4enjl1QfOncFXl1eEWio1ONxRoL0sGHl+xPq5KLvpPxDTD
         adJDHs6td63GCQyFtrKnl5fzEGJ11sjmxM1Xve7YpU5uh/MoZiloZPt+7T1BER+8h2iu
         EXltZmEZmTlcppK0toogm0ze4OmQHbr6vMCn+roCRb1XZwdeqWmBOvxt6M7tki8nvjqd
         ETXN9gfixMs6Z3v0puqE4GEUXtLW5PkaHViLRJweN63vk0q4R8nm/ahuFlz1wJEeCsdz
         EC2EsLU5c9SCFYglc8afjVpHCYSVoyetWshVetRDtnBS0K1RMKPG1pVp9NGFLZzTmHw/
         cWdg==
X-Gm-Message-State: AOAM530pw15TZpccxQpeQNIy5DRQv/Pm48Z0FRXf8gsbKDebqepmpUjl
        1hCt2EM/d7JdBiNGlq94ioU=
X-Google-Smtp-Source: ABdhPJyx+HrJ/v0m+NvujWpkdlALDPsI5utM6IpKvzEADyhwjfVMTm679Qa1jNal9keTg1lRHRWDFw==
X-Received: by 2002:ac8:4e82:0:b0:2dd:e5a1:3b2a with SMTP id 2-20020ac84e82000000b002dde5a13b2amr8010971qtp.196.1646624198218;
        Sun, 06 Mar 2022 19:36:38 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t2-20020a05622a01c200b002de5098fbaesm8180122qtw.26.2022.03.06.19.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 19:36:37 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jdelvare@suse.com
Cc:     linux@roeck-us.net, liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drivers/hwmon: Use of_device_get_match_data()
Date:   Mon,  7 Mar 2022 03:36:31 +0000
Message-Id: <20220307033631.2075160-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/hwmon/vexpress-hwmon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/vexpress-hwmon.c b/drivers/hwmon/vexpress-hwmon.c
index 44d798be3d59..2ac5fb96bba4 100644
--- a/drivers/hwmon/vexpress-hwmon.c
+++ b/drivers/hwmon/vexpress-hwmon.c
@@ -207,7 +207,6 @@ MODULE_DEVICE_TABLE(of, vexpress_hwmon_of_match);
 
 static int vexpress_hwmon_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct vexpress_hwmon_data *data;
 	const struct vexpress_hwmon_type *type;
 
@@ -216,10 +215,9 @@ static int vexpress_hwmon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, data);
 
-	match = of_match_device(vexpress_hwmon_of_match, &pdev->dev);
-	if (!match)
+	type = of_device_get_match_data(&pdev->dev);
+	if (!type)
 		return -ENODEV;
-	type = match->data;
 
 	data->reg = devm_regmap_init_vexpress_config(&pdev->dev);
 	if (IS_ERR(data->reg))
-- 
2.25.1

