Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D3B47BFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhLUMkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbhLUMj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:39:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B24CC061574;
        Tue, 21 Dec 2021 04:39:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so51392497eds.10;
        Tue, 21 Dec 2021 04:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtXTHbqxfUrJd07UnlL9gYnL8S+oVs50aZUatV+N5Uw=;
        b=FSw9+p/bP0dPHT8ZbOR/9MypFRQZNBtRi265hJmv3xL71xTmimNX+sOIm39KjoR7SP
         EqMkfTTjpVSy6UTc3nUmk9L1rtCbnxAWxoHj07V5+1OHRgCW4r0OYVQM8jl8WJkVeKvi
         f5CZJmoNf4IVBWxQG/ZGlMBbcWJmMxsM0xV91HZSeJBIN3D0zIwv1Sb0OpiJ4/Bj9zYJ
         z7q06PTRgsGymoe9qEB4wWVYeiJDdY1fZh6SbgSqEs8XBRrMr/hB9u5TswUTkBjKrGSK
         LQpQPpZKnbDMPUSVD1skT1nOMn+vpXWW1IPJVc+CbDEDmNeSnWHmH7+3EbakIXEFUsTX
         HU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtXTHbqxfUrJd07UnlL9gYnL8S+oVs50aZUatV+N5Uw=;
        b=UgRYhPISK/+CFEaMAvUOUBK1Qgxo/XrkzMgKIAY1GDiPMP29ZpK4UYkI+hoOfbZeti
         9HqDbTpDNyi9ZPP3v1/HSDKESbjMT+RXe4l6U7HXmcdEK1+GWh+P9jxx+8n3CEDjMVEw
         PbtHS2wRHA3312RJSgbCE40qRNu41Na4xvhoyV8TwCGqMSmwrKzWv+/2BCiTVWX94ZoY
         bfelCZrBWSnjxorUhPHOEJMIv4ZKEbPpxSDRjnj0vjAUJCg6FtH1ZEKSsnIdMw5YjkON
         2TpP8nwvjOl+BoqS0iatCMEQqK7Gw+DIZeOPsJXeXnU/s8LtzQKWpT7BWk8NWKGRBjUc
         6dDw==
X-Gm-Message-State: AOAM5312oy3eGgHc/Ozjd1Q3Yw4w33sFPT4YCPmIPz+3Y882pZT51bOs
        eVglC7tFs5G85PttArdBI7L7WXasbGY=
X-Google-Smtp-Source: ABdhPJz+Jqsrx9cTrcMWsi+kFG0/IHU6mcAzciy758RLbJeLxFR+KAC/VHk8/AiC2/eESdSUOYsl0Q==
X-Received: by 2002:a17:907:76d4:: with SMTP id kf20mr2571064ejc.44.1640090395900;
        Tue, 21 Dec 2021 04:39:55 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id bx6sm2849438edb.78.2021.12.21.04.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:39:55 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/10] hwmon: adt7x10: use devm_request_threaded_irq
Date:   Tue, 21 Dec 2021 14:39:37 +0200
Message-Id: <20211221123944.2683245-3-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221123944.2683245-1-demonsingur@gmail.com>
References: <20211221123944.2683245-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

To simplify the core driver remove function.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index dbe9f1ad7db0..48adc0344e88 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -402,9 +402,11 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 	}
 
 	if (irq > 0) {
-		ret = request_threaded_irq(irq, NULL, adt7x10_irq_handler,
-				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				dev_name(dev), dev);
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						adt7x10_irq_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						dev_name(dev), dev);
 		if (ret)
 			goto exit_hwmon_device_unregister;
 	}
@@ -425,9 +427,6 @@ void adt7x10_remove(struct device *dev, int irq)
 {
 	struct adt7x10_data *data = dev_get_drvdata(dev);
 
-	if (irq > 0)
-		free_irq(irq, dev);
-
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&dev->kobj, &adt7x10_group);
 	if (data->oldconfig != data->config)
-- 
2.34.1

