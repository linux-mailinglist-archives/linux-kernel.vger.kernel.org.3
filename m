Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EEC533EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiEYOCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244711AbiEYN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:48 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43093AEE2A;
        Wed, 25 May 2022 06:59:10 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-f2bb84f9edso2959826fac.10;
        Wed, 25 May 2022 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYe0yvkByZQIIt5odyFTdywSrjjAR0396YtmitTljn8=;
        b=JNawQPe1RB4s/LBXNObS/6el1VRZG2UdZVusm1dtW4Mdf5ALOcxl/Ya3q7IqXDZAuO
         0UGo7agS+DqV9QeQpfvD7SeqAib/C1gtFPtK3jkPFRDSv9jaz4heFgOudhMg1AK+8Y0x
         33cYzIA+lbFmWcFAwDN3NSSOF+3pT3AliOOq4t6cwnWMA3lVrfkQffscA9AyyZBthTjE
         da+bcE8seS7ceOBFuc1Ok/oJtkIfeUCxiS47jp3QDrhI7VyI6lM65hAwekCk/aUPcMqT
         ozPkhM5i6wbkQPGLMWSOmR4j8nK8M1d0/y88c7m2P9wVwvHdBhCSFm5W387gYIhjWCiy
         a9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uYe0yvkByZQIIt5odyFTdywSrjjAR0396YtmitTljn8=;
        b=8Kub321LL/4Q6aKKHZ9o3RFtU244MTBNNI5Pyiw5k35jb9+jxgHdwpLM040DMmosBL
         WgsEYHGYXFWEhirhdxI+ZPQrdpN9sSgYV5Ux5pGASk0tRuqVzWLNWoAek8y8GBG1w26W
         UUKxrBKinOycjbesVI7e4S6IHYMewLdrVvE9cN2CgU+u6nzJXIvQYohQEpudLC+nF2tL
         lhmN3dkFmTZD/WpqwbVasIZrE2tdDyQEC9EybZ2iJxzG5csTn/vwtiJfnT7cnHnbiYZi
         tCzLRNJUbMD5MWNcxIpgDU2CCMU1ygZdIJPTJa/mQBlXIUPj49F0qeUeIX/M9YoBaPWe
         f3Lg==
X-Gm-Message-State: AOAM531CEQsBm7Xzd8YG+LQyov4El88Db7wk0ddhmUtXrWfCuG69bDEV
        CODq+ZhoszvDAjzxP+bEOBgygeJCBbTrJQ==
X-Google-Smtp-Source: ABdhPJznc+mDZ4gfyfh1E2k3WontHUJDfZhc1bdosL9V6VV4TUNeCCcMzNRsPufIsJtghmq1JQdRMg==
X-Received: by 2002:a05:6870:e307:b0:de:e168:c43f with SMTP id z7-20020a056870e30700b000dee168c43fmr5922298oad.140.1653487149341;
        Wed, 25 May 2022 06:59:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k17-20020a9d1991000000b0060b0b638583sm4009761otk.13.2022.05.25.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:59:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 36/40] hwmon: (lm90) Only disable alerts if not already disabled
Date:   Wed, 25 May 2022 06:57:54 -0700
Message-Id: <20220525135758.2944744-37-linux@roeck-us.net>
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

It was observed that the alert handler may be called from the i2c core
even after alerts have already been disabled. Only disable alerts if
they have not already been disabled.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index d1435f55e31d..6d1e7052e3ed 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -2658,8 +2658,10 @@ static void lm90_alert(struct i2c_client *client, enum i2c_alert_protocol type,
 
 		if ((data->flags & LM90_HAVE_BROKEN_ALERT) &&
 		    (data->current_alarms & data->alert_alarms)) {
-			dev_dbg(&client->dev, "Disabling ALERT#\n");
-			lm90_update_confreg(data, data->config | 0x80);
+			if (!(data->config & 0x80)) {
+				dev_dbg(&client->dev, "Disabling ALERT#\n");
+				lm90_update_confreg(data, data->config | 0x80);
+			}
 			schedule_delayed_work(&data->alert_work,
 				max_t(int, HZ, msecs_to_jiffies(data->update_interval)));
 		}
-- 
2.35.1

