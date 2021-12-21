Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2EC47C816
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhLUUL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhLUUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:11:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAABC061574;
        Tue, 21 Dec 2021 12:11:26 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id j21so52138888edt.9;
        Tue, 21 Dec 2021 12:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcYF0sJxfCsW5AbyQlpVqnAvfQ5ZjjzzRLMoH53YhLw=;
        b=Gi8L57PPvhuXcja1D3wFp2AkNoaB7TKIi4o+uOtS4L4ydvxYaxnP2EemQW46AGg2Pw
         kyBcv3YElHNDZ336eJoPGyG3TsGnxtFg33VDslZJdviFNZomjav9Fwty0n5Y5bWLlACC
         jnpT1yVQEtOsHdMHqetGLhmsqjmv9stC1sI3KpqxLh8dCRXksy9Wqjk74Lza3YZ4cRRl
         52SwljS035GU7q5EhD5tnmc5OxCvWMGA99rcHAXT1cPL/6ZeXMDEOj8CC5JHzOgFP9p7
         ABg8UpX3tZpw75zlZRumWgwaYyo6qNMG6h5k2flspqqVJEKL6eTM5DsITVV2CgJ4Pp9F
         Z/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcYF0sJxfCsW5AbyQlpVqnAvfQ5ZjjzzRLMoH53YhLw=;
        b=lc0N8jgPjGOo4QQ2VIqg6Ce2/QI/b8q9O5QuKw9yTpZrwdVeCwDr6amLMkscPCIw5D
         /5DFw0ZIepsnr4mruzsP7Jb28GHQm8q8KrEdALtzB9muthqm308I8fc1ESooRb9xTBf/
         wYxr1Evft+DZVR/0Dq67xTSv+W/nZ+JWyCHXbr2+LQq9FeHaKJBDGPe88WelV6OWblce
         IQQtofydQs3s5miKXDU2Zv2iGQX5h+4Jt1iJqYeVsHSh5GkM0M+DkzpjU3txjHgKBEM1
         1qpRXnHT7kH7boQy+bbTptCg9kgovOu0VNAFby5h22J6Gz93DBb9LJkq9Qb21thAY09r
         xQ9w==
X-Gm-Message-State: AOAM5324MLnbhrVM1W9I9zUm0BsxkjPmui5r/xVE2AaYS4X/EDPhB+tX
        amz0HxefKX/1DfGPTXBOUOg=
X-Google-Smtp-Source: ABdhPJwuuhZqAj3MyCbcWW64G3oL8Lkpm3t6gaNMjAWXD782vtRN81Ip/EO2HEcFUgAC5P09mYNZEw==
X-Received: by 2002:aa7:de86:: with SMTP id j6mr4945878edv.1.1640117485317;
        Tue, 21 Dec 2021 12:11:25 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id b7sm8648418edj.24.2021.12.21.12.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 12:11:24 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/8] hwmon: (adt7410) Pass name to core driver
Date:   Tue, 21 Dec 2021 22:11:06 +0200
Message-Id: <20211221201113.752827-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

It will later be used to register hwmon device using
hwmon_device_register_with_info.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index 973db057427b..ef4b5af865e9 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -45,7 +45,7 @@ static int adt7410_i2c_probe(struct i2c_client *client)
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
-	return adt7x10_probe(&client->dev, NULL, client->irq, &adt7410_i2c_ops);
+	return adt7x10_probe(&client->dev, client->name, client->irq, &adt7410_i2c_ops);
 }
 
 static int adt7410_i2c_remove(struct i2c_client *client)
-- 
2.34.1

