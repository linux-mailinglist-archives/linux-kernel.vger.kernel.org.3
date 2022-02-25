Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B134C4548
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbiBYNFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbiBYNFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:05:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C25D1E5A5D;
        Fri, 25 Feb 2022 05:05:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id x15so4408265wrg.8;
        Fri, 25 Feb 2022 05:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=vjStoIuqx4/+xKn8hhME8xw2P1U6/FgR67qcc7GF0Co=;
        b=kBPHoRZ6GUxR3CkARd+hQ03jaD2d3oT3/qF94dp+4Z1PDLrGA4ZDYwes2ePSZbAMXi
         /wBslFDXVk3GGK/lyF53J88QCvbxcZHOjQlDVkrvwX0LWH1d59DHX64oCN/tHet0zNdp
         Iu5e/+57MxNk1herkrIzXxYdcKlqoikgVQDnZSsOxM0Cf+9k5TcLkNGmeI3U3PWHyIe6
         +j5FdL8dw+JdsG158BpoFmN4LNx+C7K4Rnk8LCBs5bhx5TAqKAk53/jZmw87/CpYm7XF
         vSN17AlKfeZ12hqldO0NY3iz6m/nV0Aw8H5PmaZ6e6y5ls/Pxrz0PdQ1TCxEjmcyflr3
         Z69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vjStoIuqx4/+xKn8hhME8xw2P1U6/FgR67qcc7GF0Co=;
        b=wANwUl5Xee9DPecO80oB3vufxLUxz96X/TVYqU/USl3O4pQvnCUyGERDS4Xd8GkxRu
         d2Y9zVYs+DOlHcHmwwDfcULfWU/AfV452VP03DQzBmeKdvT5acM7DGoB7WZozxyvGZvv
         wooVkX5Jjjd+pvglANUsGa1r6dTFz/sConhJ801rRztGQhDCnFlK4h3dH4eZfrrC8Qy0
         oRYVHDfTPSNDESgkH4F6kxVfRV6YOsyWbOJfbay95jXrvWfkMB2jMQiy382Ldz1L/bFw
         e8tcKUaknkKDUjGIpSaSnvwZa4Jd98tQDRQRbZpDxWRoFE4MSqCQPVZwuGqXi8uLTeHF
         s5qg==
X-Gm-Message-State: AOAM530veb80IZOMS8zZLuqC8U6cX1TJculdymdMSZePrzkVvQDtWzSM
        ntsmiuRCdo/T57TrG0kJWBs=
X-Google-Smtp-Source: ABdhPJyLzqnIfBLpLiSqrfRSyKpPpg1yJRFwLRgi24JCgan5tokl7y5jvyZO0t7e3+tSCJHDtygDJw==
X-Received: by 2002:adf:fa8b:0:b0:1ee:d06f:ed0f with SMTP id h11-20020adffa8b000000b001eed06fed0fmr4658846wrr.535.1645794298905;
        Fri, 25 Feb 2022 05:04:58 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.58])
        by smtp.gmail.com with ESMTPSA id d6-20020a5d4f86000000b001ea8119512bsm2148489wru.55.2022.02.25.05.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:04:58 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] platform: x86: huawei-wmi: check the return value of device_create_file()
Date:   Fri, 25 Feb 2022 05:04:48 -0800
Message-Id: <20220225130448.27063-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function device_create_file() in huawei_wmi_battery_add() can fail,
so its return value should be checked.

Fixes: 355a070b09ab ("platform/x86: huawei-wmi: Add battery charging thresholds")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index a2d846c4a7ee..2ffd3840f3e8 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -470,10 +470,19 @@ static DEVICE_ATTR_RW(charge_control_thresholds);
 
 static int huawei_wmi_battery_add(struct power_supply *battery)
 {
-	device_create_file(&battery->dev, &dev_attr_charge_control_start_threshold);
-	device_create_file(&battery->dev, &dev_attr_charge_control_end_threshold);
+	int err = 0; 
+	err = device_create_file(&battery->dev, 
+						&dev_attr_charge_control_start_threshold);
+	if (err)
+		return err;
+	err = device_create_file(&battery->dev, 
+						&dev_attr_charge_control_end_threshold);
+	if (err) {
+		device_remove_file(&battery->dev, 
+						&dev_attr_charge_control_start_threshold);
+	}
 
-	return 0;
+	return err;
 }
 
 static int huawei_wmi_battery_remove(struct power_supply *battery)
-- 
2.17.1

