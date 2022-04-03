Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF54F0C4E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 21:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376341AbiDCThe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 15:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbiDCThd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 15:37:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1148813D70;
        Sun,  3 Apr 2022 12:35:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p15so13607727lfk.8;
        Sun, 03 Apr 2022 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8Pl8fQJAqqHWL8r7us0/7exv1W99GG2mi8uIF4DTLk=;
        b=oltd4lRXHltEO/SVMPlYiF9iOVp97IALEEDHJ754PCavoAfpfIZpXV7KKlHt2w5gPs
         WQOwMoisZ6DDB56FVI/I2C0nLdu5Xf/jyXLOubfjSgWBTWFlvtZHssRV7nQox3gf+Nvi
         UqxGcJTKwe4V9WmIWI+88ZVXFNhIicHXmFhV+8/SPevWQNBDzprDjMteeLrgWiJeZFhV
         CIytmcTryYUZxthfI50RjEAOkG4HiXG1LLxsDwLUfYNHnmCly83ZIm/RaeejtvQbJSKs
         thfu17/LXXEBoNK5eX9s1dU0AIJQ0U0gDee2UUevm80P7G1zKCaakhIqGW82SC34Wc+h
         OSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8Pl8fQJAqqHWL8r7us0/7exv1W99GG2mi8uIF4DTLk=;
        b=ZZ/dU66Rt95jCWqOBo0uBz1dZ3ZqGUoh+LKzz4Y4KilTBH3TbhBjAUrvOHMpkd321T
         qxUA9oLEZvRnt29f0oypGejb8VaoqERDx0sIGRf3GoFgHghI4F/YSHdfld+dTValwN+7
         3v3MU3q9ofbA5ZGWIpy1DfalH+G/hwxIpAdj4KiTBTjjCL5iIntOh72K9GCHmWBlvU0Q
         T+kfD6GphnxEuTR1ugAoB02PTBGUHRfzhxwMk2BmnVE0wGrF+sH0b36JWsE8VBAshGKC
         Uf4UUIREQhgy3qZvXeVZ3cfVvz3LWU/Wp+kHPpG8QHt87c5EWXYZZ6aDFm19EvkzHkq/
         GGZQ==
X-Gm-Message-State: AOAM533Bp3Dli6CnJWXtxwUfmTAk6B/4u+7YWF0OefKsXEHmkfwPp9/o
        umFcuU5Rr17mSjFUeHFiHfE=
X-Google-Smtp-Source: ABdhPJzqms4wPEjogwWW7uy9LOgZMZcwthXQYf7Mykloph8Qi4f5Mbt447Rmy9fttBzsey4VNL3riw==
X-Received: by 2002:a05:6512:ad5:b0:44a:614e:9d61 with SMTP id n21-20020a0565120ad500b0044a614e9d61mr20713431lfu.677.1649014537059;
        Sun, 03 Apr 2022 12:35:37 -0700 (PDT)
Received: from localhost.localdomain ([178.136.134.212])
        by smtp.googlemail.com with ESMTPSA id e11-20020a2e984b000000b00249b8b68f61sm875353ljj.74.2022.04.03.12.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 12:35:36 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (asus_wmi_sensors) Fix CROSSHAIR VI HERO name
Date:   Sun,  3 Apr 2022 22:34:54 +0300
Message-Id: <20220403193455.1363-1-pauk.denis@gmail.com>
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

CROSSHAIR VI HERO motherboard is incorrectly named as
ROG CROSSHAIR VI HERO. Issue is found by github user in [1].

[1]: https://github.com/electrified/asus-wmi-sensors/pull/79

Signed-off-by: Denis Pauk <pauk.denis@gmail.com>

---
Changes in v2:
- fix base commit.
---
 drivers/hwmon/asus_wmi_sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
index c80eee874b6c..49784a6ea23a 100644
--- a/drivers/hwmon/asus_wmi_sensors.c
+++ b/drivers/hwmon/asus_wmi_sensors.c
@@ -71,7 +71,7 @@ static const struct dmi_system_id asus_wmi_dmi_table[] = {
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X399-A"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X470-PRO"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VI EXTREME"),
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VI HERO"),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("CROSSHAIR VI HERO"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VI HERO (WI-FI AC)"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VII HERO"),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VII HERO (WI-FI)"),

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.35.1

