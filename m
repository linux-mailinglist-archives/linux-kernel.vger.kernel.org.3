Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF3533E61
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbiEYN6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiEYN6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:05 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF1B91575;
        Wed, 25 May 2022 06:58:04 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t144so21862513oie.7;
        Wed, 25 May 2022 06:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1b5nILyGqqpNbh83B6jQJVoKjYjPJ5yWnONtHERzTk=;
        b=WebDmmFh5GpeE3XP8N35Cr+1d3W/PKwx4R3sVlXX5fkUfew7SZ02lEBxMv4YkP/G+b
         QocVfWlUuO27rC8CSGSk0QP+mHMoG/X64sbNb+kuoNX3oxBH6xXZvv/1UOHuK/fTy0oZ
         VwMZtCkBuyDiz+HntCDrNSG6/6BzZLt5HPJCjKlYr8fgdTnNS/mLdJ96jDBoovFceVI0
         kHU0P5rfhcf4IlNp9iYfkbN8E1Evng+sA72DjO+3/lRl/81T2UnKF/Dz7C5JdojM9Dzc
         zu67D468fCaiAjYBkj/LYsQx/rKYdOL5bNrpdP5JzdZLUzy43GEiRT4JpgZGsMnGPYbq
         ZIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=d1b5nILyGqqpNbh83B6jQJVoKjYjPJ5yWnONtHERzTk=;
        b=gVfvubWEea/6eOxApJtFiqN/O2Dy1Sd+E2NNPoy/1RQ/zZNayfi1tbRIEl3Avwd769
         FBJ8iAc0wBW+9KXWEBknochpWI+iyFjbHlbaLMptmtUSzaBv38o+GrbirtXY/FhhWTTL
         pZuiJDbY/PLnyppoIjwzIA10Xz2KjuiMzDWmR7vwL55boRtY2Iz9JJdgR41n0cbdXQpo
         5KFi3WawDyiXIlCwlZyLIrA5jlqO25iAo3acFs1E7/pdhw+/loekdXB+XAcKep+DVje7
         +ver3O3wUnLraAKUZAk84RJEB4vl018Z3cGICfOis2s6KIhYW98qE1iuxUo8lEw0CdWK
         R6Uw==
X-Gm-Message-State: AOAM530xjCPM8ifhDJtfMlqEKQJa5zZq5z8D13MWqXbBVqA5YmA/hm+y
        ESJ2Nq4ywMkaN6hf5rUowMMDxF4t1BmYKA==
X-Google-Smtp-Source: ABdhPJy7D20wc3bUV56gL+dEwyOhdNvi+KQdvMb2nOlFf6e1zoC5DBu7hfuwGrGPgNkv3VVhfMjtLA==
X-Received: by 2002:aca:f306:0:b0:32b:4753:db60 with SMTP id r6-20020acaf306000000b0032b4753db60mr5208399oih.157.1653487083486;
        Wed, 25 May 2022 06:58:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w187-20020acadfc4000000b0032b7b588f3asm2137256oig.46.2022.05.25.06.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 01/40] hwmon: (lm90) Generate sysfs and udev events for all alarms
Date:   Wed, 25 May 2022 06:57:19 -0700
Message-Id: <20220525135758.2944744-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135758.2944744-1-linux@roeck-us.net>
References: <20220525135758.2944744-1-linux@roeck-us.net>
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

So far the driver only generated sysfs and udev events for minimum and
maximum alarms. Also generate events for critical and emergency alarms.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 3820f0e61510..83d027c134be 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1829,6 +1829,26 @@ static bool lm90_is_tripped(struct i2c_client *client, u16 *status)
 		hwmon_notify_event(data->hwmon_dev, hwmon_temp,
 				   hwmon_temp_max_alarm, 2);
 
+	if (st & LM90_STATUS_LTHRM)
+		hwmon_notify_event(hwmon_dev, hwmon_temp,
+				   hwmon_temp_crit_alarm, 0);
+	if (st & LM90_STATUS_RTHRM)
+		hwmon_notify_event(hwmon_dev, hwmon_temp,
+				   hwmon_temp_crit_alarm, 1);
+	if (st2 & MAX6696_STATUS2_R2THRM)
+		hwmon_notify_event(hwmon_dev, hwmon_temp,
+				   hwmon_temp_crit_alarm, 2);
+
+	if (st2 & MAX6696_STATUS2_LOT2)
+		hwmon_notify_event(hwmon_dev, hwmon_temp,
+				   hwmon_temp_emergency_alarm, 0);
+	if (st2 & MAX6696_STATUS2_ROT2)
+		hwmon_notify_event(hwmon_dev, hwmon_temp,
+				   hwmon_temp_emergency_alarm, 1);
+	if (st2 & MAX6696_STATUS2_R2OT2)
+		hwmon_notify_event(hwmon_dev, hwmon_temp,
+				   hwmon_temp_emergency_alarm, 2);
+
 	return true;
 }
 
-- 
2.35.1

