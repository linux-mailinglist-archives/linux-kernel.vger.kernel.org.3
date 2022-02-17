Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EDB4B99CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiBQHYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:24:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiBQHYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:24:03 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C532A0D6E;
        Wed, 16 Feb 2022 23:23:47 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qx21so4876174ejb.13;
        Wed, 16 Feb 2022 23:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1tQoEbr0D4gsHzJpM3PLoZgJhPWb7Ob/NQyGQcPRV0=;
        b=AVHpUSUxFrjY67mV9VDo6jxANROTNpGQPjL259CTMW5H/t8rg5FjY0m+XOIt326ks6
         NxEe5VjSpk2XF4p3aOMIdFM+8EssZkVuM2y73Wgd1Sb7oNSLWF4f3JVewqpgdm1+lBZS
         0e+UIaxz7qhHfELSvkFzxpQSTzej8laVwAdJIA9nnu+3kd1vL6JCnYjhRFm4fByAXJm7
         u3oesos0n9ggoB8x/bLB7Ap3WDFlIJe1iHwZMHQ2/9fSDPzkIshEegYcYj//Gmxe5oQP
         TYFmw0ZPYswGkClx5D5Q8KsqybKcHdXU95kL5D8bEQ+5fAx8DadqJJupT9Q8uC2ezTJE
         k0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1tQoEbr0D4gsHzJpM3PLoZgJhPWb7Ob/NQyGQcPRV0=;
        b=uDyghDOsDg3J6OV1Mkeat034wTc1cVIsJSkWyp38FgPuzwNixKEpsmtRrkCW0JGXrm
         kOn8LKxsNfiO1V632Ex6LwbVK+Ly7IMs6DrQNPKYcaVV21/RzZa2TSZJDL1fWBsuZDiw
         wcCFWcUkGOqx3YRn02JXOhVH0ipmYoBV5kplpP0VMNVkI+7+fQJZuIcMyOxXXivh/D6i
         nUwaAfv1B+VNYa5/3TpyWZzPQgWFxO8m5KNQZLCicjttUDf6etZuRVSqDHFr4p04iTrv
         FX3pJc/Qjs/u/CO7fvNafmySWHjdRPfWhExC2WOmsLsoQKH/oh2Lo3o2lbJ2V7rY1GHn
         sp8w==
X-Gm-Message-State: AOAM531Ozm2Wx2Vkvt15EWSPgFp4HQXSl0xEwUZIHLoB7plLhAj2B7Dw
        AFwgDgUfbmmgSnbaosp479AvRfjn1Xw=
X-Google-Smtp-Source: ABdhPJxVo7JRo26jY1QTKJuLOg+ynEscWbCQktB7QAvvN6yZyc7IZS32ivj2YEdrX/YvRWfxSJbmgw==
X-Received: by 2002:a17:906:dd7:b0:6b8:783f:a49d with SMTP id p23-20020a1709060dd700b006b8783fa49dmr1265069eji.623.1645082625536;
        Wed, 16 Feb 2022 23:23:45 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id o11sm2726316edq.101.2022.02.16.23.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 23:23:44 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) do not print from .probe()
Date:   Thu, 17 Feb 2022 08:23:39 +0100
Message-Id: <20220217072340.2472987-1-eugene.shalygin@gmail.com>
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

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 0701ade16227..cbe1b987144a 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -597,18 +597,11 @@ static struct hwmon_chip_info asus_ec_chip_info = {
 	.ops = &asus_ec_hwmon_ops,
 };
 
-static unsigned long __init
-get_board_sensors(const struct device *dev)
+static unsigned long __init get_board_sensors(void)
 {
-	const struct dmi_system_id *dmi_entry;
-
-	dmi_entry = dmi_first_match(asus_ec_dmi_table);
-	if (!dmi_entry) {
-		dev_info(dev, "Unsupported board");
-		return 0;
-	}
-
-	return (unsigned long)dmi_entry->driver_data;
+	const struct dmi_system_id *dmi_entry =
+		dmi_first_match(asus_ec_dmi_table);
+	return dmi_entry ? (unsigned long)dmi_entry->driver_data : 0;
 }
 
 static int __init asus_ec_probe(struct platform_device *pdev)
@@ -625,7 +618,7 @@ static int __init asus_ec_probe(struct platform_device *pdev)
 	struct device *hwdev;
 	unsigned int i;
 
-	board_sensors = get_board_sensors(dev);
+	board_sensors = get_board_sensors();
 	if (!board_sensors)
 		return -ENODEV;
 
-- 
2.35.1

