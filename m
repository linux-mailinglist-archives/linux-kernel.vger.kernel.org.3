Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72754BAA0D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiBQTnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:43:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiBQTnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:43:42 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492241FB1;
        Thu, 17 Feb 2022 11:43:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m17so11467196edc.13;
        Thu, 17 Feb 2022 11:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wgvtN1ZQc+diRsoquyOr2biiBOjENYGILhh+mveGGk=;
        b=MMdX0VU2f6zUULyNzRYU0JwT0hCkCl5ZhwG4mPmWLugNGLY1WmUKENJnyLzGWjsEuR
         AVqI20TT8TkXKt8Q3eMrvV0+3VjUK9duBRBPiTpRpp/8WreaiHMEvOiyJeqyAl2blXD/
         WCODTJwM//2GGTx5B+xRHKT5axMJOQhx5tLuqjyMruNIT2VA6+KvvQOAMJaN0TdTD1IL
         JP8vUJqQ3aRoU6hbv85qOSwOPocLHuTmSixEkGgH2EIIHX+xsragidbEWdr7LabZJJUn
         xW4EcYpH2k2HxUQcMIlABqoLaDi3cBXroAWKEB8lJ77zuQuPSo9+uNi7rHfeD0zG1yK/
         VAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wgvtN1ZQc+diRsoquyOr2biiBOjENYGILhh+mveGGk=;
        b=VNMVFpg/m1GS9vUTnPHIgUXLrQFSS/SDTpDflmcu95FSNvfPo0nHRoXwTEMSp9QvlO
         aFbQ5kbUvYwv63g/j6MRhNTp7bagN0g0uXY4C+mC/O3rBVipxj4t0pyTJpFyfH4/JH2E
         J1UNC45gg+xRgpsvXkRkp+ae4Fd309clloh5hU5ALkxIbZ2tPVCcYNE5QI6EMhLUU0Jm
         D+p/+yf9LWCRBqynnzgNnD5i9KpV8YjfAxkmKP1mpQR9xqMk1/tt0Fauu7m93Is5ECB/
         DiHEd6AKvQWJSCFMpzqzONUCq6HmXE+eiTWXDfCG1gyFuwo2biFsRB2qPhqkx3Jq0yht
         lGqA==
X-Gm-Message-State: AOAM532FYplsveuwpguXQpJyXDs+titHhcnaoazKqse6P3bYF5E8P8Wt
        OW3SRZyiQLeTL/X1n7b8YuACoytZqkQ=
X-Google-Smtp-Source: ABdhPJyyBVWBdAUXDvSrh5BxAuXTnKmP9jEDL4E5JsMAwx0E1RbtDMwO234OqWUh3nrrZ2F4W2DSWg==
X-Received: by 2002:a50:cd59:0:b0:410:ac25:e570 with SMTP id d25-20020a50cd59000000b00410ac25e570mr4302197edj.252.1645127006235;
        Thu, 17 Feb 2022 11:43:26 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id c11sm3950409edx.42.2022.02.17.11.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 11:43:25 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (asus-ec-sensors) do not print from .probe()
Date:   Thu, 17 Feb 2022 20:43:18 +0100
Message-Id: <20220217194318.2960472-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the call to dev_info() from the board detection function, which
is called from probe(), not only to be in line with hwmon driver rules, but
also because the message duplicates the error code returned from probe()
for that case (ENODEV).

Changes in:
 - v2: add missing newline (style).

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 0701ade16227..b5cf0136360c 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -597,18 +597,12 @@ static struct hwmon_chip_info asus_ec_chip_info = {
 	.ops = &asus_ec_hwmon_ops,
 };
 
-static unsigned long __init
-get_board_sensors(const struct device *dev)
+static unsigned long __init get_board_sensors(void)
 {
-	const struct dmi_system_id *dmi_entry;
+	const struct dmi_system_id *dmi_entry =
+		dmi_first_match(asus_ec_dmi_table);
 
-	dmi_entry = dmi_first_match(asus_ec_dmi_table);
-	if (!dmi_entry) {
-		dev_info(dev, "Unsupported board");
-		return 0;
-	}
-
-	return (unsigned long)dmi_entry->driver_data;
+	return dmi_entry ? (unsigned long)dmi_entry->driver_data : 0;
 }
 
 static int __init asus_ec_probe(struct platform_device *pdev)
@@ -625,7 +619,7 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	struct device *hwdev;
 	unsigned int i;
 
-	board_sensors = get_board_sensors(dev);
+	board_sensors = get_board_sensors();
 	if (!board_sensors)
 		return -ENODEV;
 
-- 
2.35.1

