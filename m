Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F3057771F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiGQPln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGQPll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:41:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879D1BC9;
        Sun, 17 Jul 2022 08:41:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id k30so12290216edk.8;
        Sun, 17 Jul 2022 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVf7sB0l4zH/Rxpvh7W7/gvxcfaj5Mn8NQrlNnPne74=;
        b=L8HlfeOnmQDe9wm4ZoNIAPSFWX7DVXaLkCY6zna+tOeC2pje4VGsnHanqViN4TC9/u
         ZCTpL2iPwSYlbFecyEnd43kRy26lswwe37bpN+8d/2GqVANKu8t+fUyuo2DiZlG9sZxo
         03igbGK/AnJH9uCdT4qKd0VCSfDJxnr1zRqA66B235IDOhpkWjmuEJlrB8+UAJ802ZAP
         8nvVr/KyYTOTaJoSyav3Zj8X6sRjIieRi69EjMx12mbwTBr41yqxsXkkZrbpTBSZ2KIv
         bTnaAB7S0VzJwpu75uVRWJNxCFsVGiubh+bo+NYxpAyMwmvO2g7Hf+PU9z6t57vdPUVL
         MStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVf7sB0l4zH/Rxpvh7W7/gvxcfaj5Mn8NQrlNnPne74=;
        b=DzAPRzggD5HL7bErT36F4pcM5q6Jbq976ofRietijBc7nZfJI/ytX6X+fMzf1vq9bL
         /gYplsKE4HY7wrp29S66HJwVbeDcOlO0pitMI/pKlOQmbjQoe/YE+KSU+m3/t4Xh2vSw
         Mo2b6oMgOejMM7mH0IiWsu+cObM0EOZESTQU/7ZF4TXt6bo4IYAmkDQ1Jy32R1dOudHz
         zyTUx6gYwJOEP+xS0n9dwBYpJw8TIUYowRzlSn0Q5C2iVzoIu56wQjhr1sgVZLETHmCu
         2ixAByYSJOkHRskX6XceZezBV8Tn9jlSVHno8XW3rNQtmtE/lXOktG5KKykN9GGPShHM
         JOZQ==
X-Gm-Message-State: AJIora/UUrEPtbe56rkfn7krk+5Ct1XEtStBy+RW/GuXsSauZIUPrgYB
        RfgsxflUlmqGPLkGTOn8T3RmRFcj4UJ4pQ==
X-Google-Smtp-Source: AGRyM1ta/dXiqsjEBSHiRWRBwI40AUDaODJxfn1wN5mnUQlCE/N8V3b6RDEWViWM/0EkeMfRft9M5A==
X-Received: by 2002:a05:6402:2b93:b0:43a:5aad:73c2 with SMTP id fj19-20020a0564022b9300b0043a5aad73c2mr31983335edb.300.1658072498706;
        Sun, 17 Jul 2022 08:41:38 -0700 (PDT)
Received: from DESKTOP-A98GP49.. (cable-178-148-254-8.dynamic.sbb.rs. [178.148.254.8])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906388700b0072aac7446easm4403880ejd.47.2022.07.17.08.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 08:41:38 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Add D5 Next fan control support
Date:   Sun, 17 Jul 2022 17:41:14 +0200
Message-Id: <20220717154114.7545-1-savicaleksa83@gmail.com>
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

Signed-off-by: Jack Doan <me@jackdoan.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
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

