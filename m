Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1015604DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiF2PmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiF2PmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:42:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C562CCB3;
        Wed, 29 Jun 2022 08:42:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l6so14464319plg.11;
        Wed, 29 Jun 2022 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRCJMAl9ZNLoVnPNV8HMGzRaHKIYDVWSPhvooPOy6DI=;
        b=NiILxxt7TAQ04yKYdK7wM6rBnIDUIrrEdPVYf7ZipeLpkR8p+HLYNR+xEWrtOadrYZ
         GC6o1Ze7NXZJY0pYEeUqMXOcHtob1WD3y4Jz6t34NPNlQsXIjGj/llIE0EAHGaeEXUFp
         0ROHyPsRXJFOWLg9sO/lK9IUprsFX5m9dGD33EG9OmF+yVghkg8NfVmX8iOKcS5H7YQ+
         XY27LlMtTivEowTZhhRskXTWWAcDpFViqip33C/4bAxYR3O5N0i7AqPy7fGYfcb5uvfA
         i7Epjkd8B4uNFyaXS9mSNs7/OyURAfjZmTAZlp+27+uM1ct3hFr6pucxD8ojuYq7N/hF
         EqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PRCJMAl9ZNLoVnPNV8HMGzRaHKIYDVWSPhvooPOy6DI=;
        b=kF3+Ru+qiKjaWNmIvGm8s4k5Zq1cVX2F7xBobQg3BlvltFvTZzkRfRHr92hrejz7Gp
         Qii9BkmfzCxtlLNlLobLbqpNkBTTd3MGkZMIF6mAiitUBb8UMsq+OJCiniy5SCn6ddD3
         A8qcXrx2j8qsvN1RfbpZhkPxp/dyHkKvk6JM+pr3BKnGyFehmsOjjC9jWGWU/a4X6ZKF
         p2tV3nHcWq48sPZ8D3/rzYeI4o1WvrK/NQTwpb2gt5oE+WJ9q9tq9mL19CUKN14WgxNo
         tctLmHxAds0Xo3jJVUBZ24QCA7vH0CMiedrojB0ygFR0fL/zoE4YTs6lsYufF2Tt2kFb
         qXPg==
X-Gm-Message-State: AJIora9oZpA/fwZMgfy9zwakP/FNur84gclSlh7SJFenZD2m7468sCfT
        HMdrv53w8MHZtYRxzAoXmjRofpIClNE=
X-Google-Smtp-Source: AGRyM1sJMLTeRpcboSggEajkrdbV/zFqV4my8lideOrK0J2JBEs6b/rg3y1gjMEagKzBQ5ZKNCg89Q==
X-Received: by 2002:a17:90b:4b42:b0:1ed:f6f:ff2 with SMTP id mi2-20020a17090b4b4200b001ed0f6f0ff2mr6672395pjb.131.1656517333711;
        Wed, 29 Jun 2022 08:42:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 1-20020a620501000000b00527d84dfa42sm2653412pff.167.2022.06.29.08.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:42:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH] hwmon: (lm90) Use worker for alarm notifications
Date:   Wed, 29 Jun 2022 08:42:10 -0700
Message-Id: <20220629154210.2389765-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting alarms using hwmon_notify_event() may result in a callback
from the thermal subsystem. This means that such notifications must
not hold the update lock to avoid a deadlock. To avoid this situation,
use a worker to handle notifications.

Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Fixes: e182cf579f0f ("hwmon: (lm90) Rework alarm/status handling")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Dmitry,

can you give this patch a try in your system ?

Thanks,
Guenter

 drivers/hwmon/lm90.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 9d878163a1f2..03d07da8c2dc 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -693,6 +693,7 @@ struct lm90_data {
 	struct hwmon_chip_info chip;
 	struct mutex update_lock;
 	struct delayed_work alert_work;
+	struct work_struct report_work;
 	bool valid;		/* true if register values are valid */
 	bool alarms_valid;	/* true if status register values are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -1043,13 +1044,18 @@ static int lm90_update_limits(struct device *dev)
 	return 0;
 }
 
-static void lm90_report_alarms(struct device *dev, struct lm90_data *data)
+static void lm90_report_alarms(struct work_struct *work)
 {
-	u16 cleared_alarms = data->reported_alarms & ~data->current_alarms;
-	u16 new_alarms = data->current_alarms & ~data->reported_alarms;
+	struct lm90_data *data = container_of(work, struct lm90_data, report_work);
+	u16 cleared_alarms, new_alarms, current_alarms;
 	struct device *hwmon_dev = data->hwmon_dev;
+	struct device *dev = &data->client->dev;
 	int st, st2;
 
+	current_alarms = data->current_alarms;
+	cleared_alarms = data->reported_alarms & ~current_alarms;
+	new_alarms = current_alarms & ~data->reported_alarms;
+
 	if (!cleared_alarms && !new_alarms)
 		return;
 
@@ -1101,7 +1107,7 @@ static void lm90_report_alarms(struct device *dev, struct lm90_data *data)
 	if (st2 & MAX6696_STATUS2_R2OT2)
 		hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_emergency_alarm, 2);
 
-	data->reported_alarms = data->current_alarms;
+	data->reported_alarms = current_alarms;
 }
 
 static int lm90_update_alarms_locked(struct lm90_data *data, bool force)
@@ -1143,7 +1149,7 @@ static int lm90_update_alarms_locked(struct lm90_data *data, bool force)
 			(data->config & 0x80);
 
 		if (force || check_enable)
-			lm90_report_alarms(&client->dev, data);
+			schedule_work(&data->report_work);
 
 		/*
 		 * Re-enable ALERT# output if it was originally enabled, relevant
@@ -2552,6 +2558,7 @@ static void lm90_restore_conf(void *_data)
 	struct i2c_client *client = data->client;
 
 	cancel_delayed_work_sync(&data->alert_work);
+	cancel_work_sync(&data->report_work);
 
 	/* Restore initial configuration */
 	if (data->flags & LM90_HAVE_CONVRATE)
@@ -2769,6 +2776,7 @@ static int lm90_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 	INIT_DELAYED_WORK(&data->alert_work, lm90_alert_work);
+	INIT_WORK(&data->report_work, lm90_report_alarms);
 
 	/* Set the device type */
 	if (client->dev.of_node)
-- 
2.35.1

