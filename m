Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458094896A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbiAJKnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244202AbiAJKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:43:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1451C061756;
        Mon, 10 Jan 2022 02:43:07 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so15359784pjp.0;
        Mon, 10 Jan 2022 02:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwjtUK79HtzEY6JZw+5TMzJHPMEcPlAmgTPPJbtawIk=;
        b=REwOgmOXzUtV+FNOTUtDQitSbH3+HTqE33Dtada4ZtcXcwKzY+NY/qy2uhKKDF9rG5
         l4eRlWqRgH5ChAcMeXb+2gmYugIr8Xp1ILrIH8UnX2zhvABQMO17ei8xdoSIC/AHVT6j
         6D/PaOsUL698MUkxLEvEx0f6MH676VrIUTnngyFDxuh0HLp96Na+2fYO2QudmYsTOCI+
         5hZ5dfSslXskmzD6jQp4/ljvN526I6T0TuERuBgyCMYs+M5RZW39RuQ62xidx9V5mGm9
         rKtxdkz2qbXPY4L1NekqrGQgzSxXLW0MajAvTVJ0iPIHX+sRongxcQ8BNVL5lLzmJnP8
         50ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwjtUK79HtzEY6JZw+5TMzJHPMEcPlAmgTPPJbtawIk=;
        b=2ZxKHKMrryqodnOGw0kBYkkKvD13PSfWHuf91BEresOtvJy+MSq5Wpvfrhd9PhHqU9
         1Llxv9Q6Z2UQlDRTlZqoM9AhFpTHv01yooMlCgaSqKcxae+7BNskBEoiqn8MpvsSJGwN
         CKa0jVYqtyeKaMGjFwCPWREgPY3TUtGfo8ncVXpEUtNbRYv06MzZo+NK0hjMhChCsjqS
         ldRq5b9pS8taKCrZx6hhHf5Yifm28WXpblrVA6afucL/gOpgkqBamiSQV5V4tib0p1ou
         78qUypjPHyNlR56ifBPgiec3hpbGtTna9vv4FRIXqNTyV67ByhmZLqBeitrZoT6VnOx4
         Bt4Q==
X-Gm-Message-State: AOAM532BiwpQ08qwiLQhlcUh8Ik3tE/Z6gl0AGtMygLN0kwAC/gVFITD
        sUTlmzOPh688Jsb60GVPpMJICqSEe6Q=
X-Google-Smtp-Source: ABdhPJzbDEiFq/3ABKwL0jpasSilhMkn5qgk1ZpVvES3Oi9jopbgOmxsBD7QTbqfypOzUlHwXZOMeQ==
X-Received: by 2002:a17:90a:d154:: with SMTP id t20mr633921pjw.43.1641811387440;
        Mon, 10 Jan 2022 02:43:07 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u8sm6466665pfi.147.2022.01.10.02.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 02:43:07 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/rtc: remove redundant ret variable
Date:   Mon, 10 Jan 2022 10:43:01 +0000
Message-Id: <20220110104301.646715-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from tps65910_rtc_set_calibration() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/rtc/rtc-tps65910.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index 75e4c2d777b9..b0a95d9eb368 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -304,7 +304,6 @@ static int tps65910_set_offset(struct device *dev, long offset)
 {
 	int calibration;
 	s64 tmp;
-	int ret;
 
 	/* Make sure offset value is within supported range */
 	if (offset < MIN_OFFSET || offset > MAX_OFFSET)
@@ -321,9 +320,7 @@ static int tps65910_set_offset(struct device *dev, long offset)
 	/* Offset value operates in negative way, so swap sign */
 	calibration = (int)-tmp;
 
-	ret = tps65910_rtc_set_calibration(dev, calibration);
-
-	return ret;
+	return tps65910_rtc_set_calibration(dev, calibration);
 }
 
 static irqreturn_t tps65910_rtc_interrupt(int irq, void *rtc)
-- 
2.25.1

