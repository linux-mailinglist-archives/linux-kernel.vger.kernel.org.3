Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C95C5AAA2A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiIBIeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiIBIdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:33:38 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE4FC2EA2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:33:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q63so1352544pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 01:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=AFGFaiPRdQ5SJ/dGxKMul5/KeG6XE7MZVomLSXeFr1o=;
        b=GfbpGSxiB5z4h6mofdFRD7IhSNN6H/kvkScfjjzVuU4kCHtB03x2/YG5ajOP1ham9p
         N/5Z/EXGSrrSjvBPNR3/UA4QXt4fnngNhBQNRqva5cNB95+Rlq4nNP8jfl73HFJ4uvsG
         DupdV6DgVxBw4li6whuOWiZVv3LeHw1LvDxnpw8Zrc9YuXEgfn9mZvEJN5278TxGyGEu
         aKgN8j1PaqSQd4JwabizbxNfJtVKGabNLlwXxa63Ed0Rm3CrKY3+bdW1dPm/kScJvp3x
         21OpcIGrABd2csoPPdV6VMWCSfC2VkDUKpVPhaQBWmS3AmoC825GxEYw+8+KWa3GG2qF
         OU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AFGFaiPRdQ5SJ/dGxKMul5/KeG6XE7MZVomLSXeFr1o=;
        b=kQtEObLU7ygf0w7mwjtcHH2xt8w/Q9hcQmYTkY8qdqvMrt1KW6LbBYGjZ1j0C/0nkE
         Z6sAidx+hzhs/RBi0bwFvwWKMsIrwbSC4/RqHBs5UiQVL4iON2TK6Bm0KNTVxBoaVzdq
         D672kl0bVEM4mfKDnjjTb6GTJ7MN4X1jjfKuF+YsGQHtiXifJqfsL28j5FnPpxuPeQ6V
         agjces06ZJAhgUmOZdZ3ARjETg8FzmylDHSTEv9US9xWarwY0EI6t0MKTov3P1tGs55O
         r3UN5Uq9+BfcGKa/m4Z/m/Vl3S4tKvv+4mEtrjzdEFP0lTKvIavA7svM/oPtQx4xItoD
         2rnw==
X-Gm-Message-State: ACgBeo0oGPkWR7Hf01Q3Oqma4MhvGtFcFSODeMD1iamiaVyef+lLBX+b
        ICvrVayZlQZDV1PYS/ap7o+fUgyNRR2WIxwuIPk=
X-Google-Smtp-Source: AA6agR7etKrfZqJZVfF3ephgmYjuNlp2VAVz0/N2qRZ861Z24fg6011vq8s7b9vtZmcOnjD7fZsVvw==
X-Received: by 2002:a05:6a00:124d:b0:538:148b:b989 with SMTP id u13-20020a056a00124d00b00538148bb989mr26873058pfi.82.1662107580322;
        Fri, 02 Sep 2022 01:33:00 -0700 (PDT)
Received: from localhost.localdomain ([103.150.184.130])
        by smtp.gmail.com with ESMTPSA id y5-20020aa79ae5000000b00537aa0fbb57sm1071241pfp.51.2022.09.02.01.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 01:32:59 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 2/2] input: touchscreen: elants_i2c: Add eth3915n touchscreen chip
Date:   Fri,  2 Sep 2022 08:32:36 +0000
Message-Id: <20220902082843.2.I19ac6cf9b8502d92f551ff4166861debb14576ec@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220902082843.1.I7da6ff6c8e8700624d61e51ff7d09e151bd83dcb@changeid>
References: <20220902082843.1.I7da6ff6c8e8700624d61e51ff7d09e151bd83dcb@changeid>
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

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>

---

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

