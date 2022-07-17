Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ABC577770
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 19:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiGQRQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 13:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGQRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 13:16:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352031122;
        Sun, 17 Jul 2022 10:16:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m16so12473850edb.11;
        Sun, 17 Jul 2022 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2i4F6AGFnYSdCtjhDLG6driCXW44/grpJrqbhnMJpFY=;
        b=dsPcoU3MUFjvUYbrb5biwZDMOpFPHR6P54z0lzgGoId9CYm/nGXFfTAOYtPF/Sf2cM
         plPc9MC9AJnsvT1fQQL3VihgEtVrOVPqorHZpRFL78Q2+KdG9NOLgmtb25y/7nHetHru
         XXYMz1bwo+Guu0k2OZ6SNsuqy+X9mnJfLKN1apG3NoOSgIiEb0xbVyVvVSNz9c2ypylk
         hcWYHdMs6J0T4mLNZDFcyindD82bP7qY07hR3hiFJJOOXnWAVBtGPUxoox1JC1vm+B/C
         QdJnhMI3h+neFVdS06zzm6LkSQwcLM0YZBlkGwHIHopoyTRR8MYl31kLV8oHpHR4lJvo
         7RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2i4F6AGFnYSdCtjhDLG6driCXW44/grpJrqbhnMJpFY=;
        b=cXjCOqrsm4uUSGcV4KC37rmN5CKuDOWWhQ9kFWyxTS3raVc8DHDOGOJE9/tMbsQn9w
         E2KRATQcKEtYBxhvgLC50wsNQdH+wo0p0UjTg3Xu/OQKZv80IpWZfHr5BcI/2jUPIw2j
         qdpeR3Osc9zW9omo/acxDbDzdI1rr0apwzyBWzUQJx1sWzof15ZeYJ4zHqI83wlZ/HsZ
         gLKy6eqf2C/VzpoDrvH4JDuo6kIBMf2BZ9sDfvLgbM/VsIvqbY8xWzar+NFXnMQvAmTK
         E0G9CyFrGcPubnP2tKYkDQ2+JBNySoI4PGSf95Rl4Cgim13YCeUAiNAnHVmO1Z6yFrCU
         hoMg==
X-Gm-Message-State: AJIora+W9QPmEdvyMWK8GE4TnhpR+zQwGpaSpwD0oQDWjzEZB9rN3uHp
        LWTArXidqOgKHZUQ4HcricbhdZ2Wr+8o3Q==
X-Google-Smtp-Source: AGRyM1vr6444vzzDgvSaDNw+HjuwINOEyC+5sjW7UQN5pAwBWzTTX3tQA3RgYKfq1HcM9r+Jip83EA==
X-Received: by 2002:a05:6402:3551:b0:43a:a5c0:2fbc with SMTP id f17-20020a056402355100b0043aa5c02fbcmr31669199edd.288.1658078199493;
        Sun, 17 Jul 2022 10:16:39 -0700 (PDT)
Received: from DESKTOP-A98GP49.. (cable-178-148-254-8.dynamic.sbb.rs. [178.148.254.8])
        by smtp.gmail.com with ESMTPSA id gj10-20020a170907740a00b00726c0e63b94sm4496853ejc.27.2022.07.17.10.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 10:16:39 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (aquacomputer_d5next) Add D5 Next fan control support
Date:   Sun, 17 Jul 2022 19:14:12 +0200
Message-Id: <20220717171412.11142-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define pump and fan speed register offsets in
D5 Next control report, as well as its size, to expose PWM fan control.

Originally-from: Jack Doan <me@jackdoan.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
Changes in v2:
- Clarified in the commit message that Jack Doan is the code author
---
 drivers/hwmon/aquacomputer_d5next.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 0e56cc711a26..997d72ea6182 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -71,8 +71,12 @@ static u8 secondary_ctrl_report[] = {
 #define D5NEXT_PUMP_OFFSET		0x6c
 #define D5NEXT_FAN_OFFSET		0x5f
 #define D5NEXT_5V_VOLTAGE		0x39
+#define D5NEXT_CTRL_REPORT_SIZE		0x329
 static u8 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET };
 
+/* Pump and fan speed registers in D5 Next control report (from 0-100%) */
+static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };
+
 /* Register offsets for the Farbwerk RGB controller */
 #define FARBWERK_NUM_SENSORS		4
 #define FARBWERK_SENSOR_START		0x2f
@@ -667,9 +671,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->num_fans = D5NEXT_NUM_FANS;
 		priv->fan_sensor_offsets = d5next_sensor_fan_offsets;
+		priv->fan_ctrl_offsets = d5next_ctrl_fan_offsets;
 		priv->num_temp_sensors = D5NEXT_NUM_SENSORS;
 		priv->temp_sensor_start_offset = D5NEXT_COOLANT_TEMP;
 		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
+		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
 
 		priv->temp_label = label_d5next_temp;
 		priv->speed_label = label_d5next_speeds;
-- 
2.36.1

