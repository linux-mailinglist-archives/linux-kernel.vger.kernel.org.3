Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4835AFBFE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiIGFwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiIGFwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:52:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFC988DCA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 22:52:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t65so1666141pgt.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 22:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=JFk6Wy6/dMaKMuY8o7j06cewyOb+0XexmdFM4uw0rXA=;
        b=HjIL4ef7mowqU62OfWZrSCwqEpM5S75JQqwiHvyaejZxlqxz4uXb6mW5XJuHqk043a
         9XeW+8KToe6qaTO8d3n8+yOz3W+mMkkK+kgqTTn3Sbt42SNUx/deXNkqxpOo2tpV/HMD
         CMC8ZCVbtDMFEbOzXhpF0wrW4ekwwvLvNt7T+6jyV+R62kPbIw0/xfswwobrcz2jotpd
         fZ4khXwffRkooIl2ob6yCall5UrOnIUdYcAPnN1fJZukYkuirOcztjYCx1a1uBctcusP
         e2nIpyWnAycOj2w9hBWS3A+Q6+VvmCJxiAN+IeFIxckRlh39p3jDnwWeE+U/RKljBSPQ
         hNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JFk6Wy6/dMaKMuY8o7j06cewyOb+0XexmdFM4uw0rXA=;
        b=S0sfyhznvdtPEzGCfvWrsd+QqSHKb43gmSwkFwnCIQU2qR927jN7yEhnQrfmPinUkP
         Ahml2Wy9tTOPIRP0cqP9O84qIFgKSJRzV1bN7rnq0wsnfHsDzwDOdqbD1iKSVKNktMHe
         ZpfcbbVAmaJyyZOOm2UFix4x//UPSijgVxcCXe2ldEwQHfvH91QbEdvPGfCPHV7TqoJZ
         4DAKEWAXJ/NTO2gRqUrOOLH/8lQilaKoNdwtnG3+O/Sb0clz6qzmlRw3maxE0YApD0/w
         ksK/hKuILjDVpqT+aoJ7W/x2KP9iR5gHvi6iHQo1xBxcmG2HQJSXCmZPJsVm/vW/+kLq
         Ppfw==
X-Gm-Message-State: ACgBeo1jvkt6WHBW+Sh6fJJnn3cjiwGNuHz/r5ZctGBj7Wp7fXSFMFCT
        o9eQBXGsUtJD5eW7dbp6oVppN0IisfdQdQjvbPU=
X-Google-Smtp-Source: AA6agR77t5rxjeuUTD8QAqc8sAxs5M3rLjd+1dfwed5GqOwnJcyVIY85AF1H9rj8mKhNGYSYlqOd5A==
X-Received: by 2002:a63:106:0:b0:430:805a:f1ad with SMTP id 6-20020a630106000000b00430805af1admr1982367pgb.284.1662529951192;
        Tue, 06 Sep 2022 22:52:31 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b00172dc6e1916sm6168094pln.220.2022.09.06.22.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 22:52:30 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH v2 2/2] input: touchscreen: elants_i2c: Add eth3915n touchscreen chip
Date:   Wed,  7 Sep 2022 05:52:04 +0000
Message-Id: <20220907054805.v2.2.Ib278031fb2e3f4eafdfd8297b9d41031a2e080e0@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907054805.v2.1.I1168feec10de16e0f130dfe72ce7976762597dba@changeid>
References: <20220907054805.v2.1.I1168feec10de16e0f130dfe72ce7976762597dba@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eth3915n requires more delay time than the eth3500 when reset.
Define EKTH3915_RESET_DELAY_MSEC as the reset delay time of eth3915n,
about 300ms.

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.com.tw>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/input/touchscreen/elants_i2c.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index c9dd703b0c7d8..60ddb58281bdf 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -116,6 +116,7 @@
 
 #define ELAN_POWERON_DELAY_USEC	500
 #define ELAN_RESET_DELAY_MSEC	20
+#define EKTH3915_RESET_DELAY_MSEC	300
 
 /* FW boot code version */
 #define BC_VER_H_BYTE_FOR_EKTH3900x1_I2C        0x72
@@ -133,6 +134,7 @@
 enum elants_chip_id {
 	EKTH3500,
 	EKTF3624,
+	EKTH3915,
 };
 
 enum elants_state {
@@ -664,6 +666,7 @@ static int elants_i2c_initialize(struct elants_data *ts)
 
 	switch (ts->chip_id) {
 	case EKTH3500:
+	case EKTH3915:
 		if (!error)
 			error = elants_i2c_query_ts_info_ekth(ts);
 		break;
@@ -1361,7 +1364,17 @@ static int elants_i2c_power_on(struct elants_data *ts)
 	if (error)
 		return error;
 
-	msleep(ELAN_RESET_DELAY_MSEC);
+	if (ts->chip_id == EKTH3915)
+		/*
+		 * There need delay 300ms for power on sequence.
+		 * T1 + T2 + T3 >= 305 ms
+		 * T1: 0<time<500us
+		 * T2: >5ms
+		 * T3: >300ms
+		 */
+		msleep(EKTH3915_RESET_DELAY_MSEC);
+	else
+		msleep(ELAN_RESET_DELAY_MSEC);
 
 	return 0;
 }
@@ -1686,6 +1699,7 @@ static const struct i2c_device_id elants_i2c_id[] = {
 	{ DEVICE_NAME, EKTH3500 },
 	{ "ekth3500", EKTH3500 },
 	{ "ektf3624", EKTF3624 },
+	{ "ekth3915", EKTH3915 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, elants_i2c_id);
@@ -1702,6 +1716,7 @@ MODULE_DEVICE_TABLE(acpi, elants_acpi_id);
 static const struct of_device_id elants_of_match[] = {
 	{ .compatible = "elan,ekth3500", .data = (void *)EKTH3500 },
 	{ .compatible = "elan,ektf3624", .data = (void *)EKTF3624 },
+	{ .compatible = "elan,ekth3915", .data = (void *)EKTH3915 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, elants_of_match);
-- 
2.17.1

