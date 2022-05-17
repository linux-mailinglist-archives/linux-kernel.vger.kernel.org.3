Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4AF529BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbiEQIFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbiEQIFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:05:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7AF3EB83;
        Tue, 17 May 2022 01:05:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id tk15so9594956ejc.6;
        Tue, 17 May 2022 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2wIEkKAYlLfnMCLScX38TBed0imkFSk5PiJ4mF7M7o=;
        b=XjUMaNeNzpjq8DGAKoTxcsxLvLebR52j5/UrFr1fTm14UTuFI3vWzbAR3mWREbJrUF
         ZGbxRFQiQMr6X/eo8TtfkrQsTVsdmjWljyblQ9GG2B0QLn6IaAgrbpb/KjilGGuaWtWt
         0DoRAyhIe4lW5Ny01IH6/E/EG6Y/r8/S6NFftsO4DFAPfGlobpLHiDYhxk4hZKvx5bEQ
         PUgZ+m/XTvLtv0CC55yEQz7Mu8dLZ/Lfcf8zaproBUbm7zQJr56Lja5CCVkYLDxJyXol
         y9mAsz4laAxacTX5wgq6wz6THqYNNcAsoXLAv2tcbhdlW7tkF4eGK8ig9oZn/pwNInx7
         jzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2wIEkKAYlLfnMCLScX38TBed0imkFSk5PiJ4mF7M7o=;
        b=byJaFHv3Z3jTM72i0kVnXH7njJUQk3rcxb7ovp3Q8oITUqpMolOGzbmnqBEUDhejPi
         UAB5FYBwtG1VbjKrRY9As8UjyeUpwTe7Cx3t2ZmUKYn7F17vwlenNYVQaOcdlfqgGZyV
         8zm9iqglnJfmyBrrDqpj/RAPjpKuY8icpWbh6Qqe2ViM7xSSilxXRYXUrfPbOwgcCQjl
         a0cJInN+5iimT3a8ItXwQSxZqfi74LjQNXCj5YpO3inwW4Wk3ycvoK26Hx0a/pc046hH
         Ws1jNo80HngQ2q66Rjtctl/jEMQRssFtMcvbelu37aeYw3Bukg78F2GxykzcGKClZO7r
         BHHw==
X-Gm-Message-State: AOAM531k+UYSFRQmPgV/VochiJUxDxwaYTFCJ3BMB0xKEuvSQlu4dPUk
        kRlkZt7REzit17J3m8JJWbg=
X-Google-Smtp-Source: ABdhPJxgF/tHnSq60sCri5mmqNhkR2Ul32Ist6TJ34IoQ3vHZ0wZ4dD8QavmgsQBhklbg2npiIkRJQ==
X-Received: by 2002:a17:906:a5b:b0:6f4:55f6:78af with SMTP id x27-20020a1709060a5b00b006f455f678afmr18785426ejf.238.1652774717367;
        Tue, 17 May 2022 01:05:17 -0700 (PDT)
Received: from caracal.goemobile.intern (erm103.goemobile.de. [134.76.0.103])
        by smtp.googlemail.com with ESMTPSA id n1-20020a05640204c100b0042617ba63basm6396052edw.68.2022.05.17.01.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 01:05:16 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) fix Formula VIII definition
Date:   Tue, 17 May 2022 10:05:08 +0200
Message-Id: <20220517080508.1910953-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
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

The ROG CROSSHAIR VIII FORMULA board has the same sensors as the
CROSSHAIR VIII HERO [1] thus let's join their definitions which adds
missing sensors for Formula.

[1] https://github.com/LibreHardwareMonitor/LibreHardwareMonitor/pull/740

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 611e897429b1..57e11b2bab74 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -54,7 +54,7 @@ static char *mutex_path_override;
 /* ACPI mutex for locking access to the EC for the firmware */
 #define ASUS_HW_ACCESS_MUTEX_ASMX	"\\AMW0.ASMX"
 
-#define MAX_IDENTICAL_BOARD_VARIATIONS	2
+#define MAX_IDENTICAL_BOARD_VARIATIONS	3
 
 /* Moniker for the ACPI global lock (':' is not allowed in ASL identifiers) */
 #define ACPI_GLOBAL_LOCK_PSEUDO_PATH	":GLOBAL_LOCK"
@@ -257,17 +257,9 @@ static const struct ec_board_info board_info[] = {
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 		.family = family_amd_500_series,
 	},
-	{
-		.board_names = {"ROG CROSSHAIR VIII FORMULA"},
-		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-			SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
-			SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
-			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
-		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-		.family = family_amd_500_series,
-	},
 	{
 		.board_names = {
+			"ROG CROSSHAIR VIII FORMULA"
 			"ROG CROSSHAIR VIII HERO",
 			"ROG CROSSHAIR VIII HERO (WI-FI)",
 		},
-- 
2.35.1

