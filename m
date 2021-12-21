Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A85B47C891
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbhLUVE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhLUVEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:04:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DECEC061574;
        Tue, 21 Dec 2021 13:04:54 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o20so97694eds.10;
        Tue, 21 Dec 2021 13:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZcYF0sJxfCsW5AbyQlpVqnAvfQ5ZjjzzRLMoH53YhLw=;
        b=MI6nFeKhN4kO+GnEbPmN2onIF42QVIuJjmDzri49wV8fPFu32dfsCFF+jgxvsx+fgq
         lmQJziN+hvI2EbGQJX0pSxB0qG2D8GlLE46eaX75+z8m1Rjm9Vn824NZbglgYoBJ4EXK
         MUa5jLxQhKjp3LDek9Ch8VzA0BxnpI/HpE49C9qOYTJ1OpUU5As8cECsZ91v1rIqOFUZ
         Le7S9nyEl/7BvfhMVhivRcTR7+rtm02qRrmw5n4VM7xht2KL+9tKxD++LPi2ZtgnGvQ8
         X1OII5Z+v7L03E4gKPR2LA2gSLyjUonO2pnwWn56k42wlYB5e/x+PtQg2RnEJE6+XHaH
         m4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZcYF0sJxfCsW5AbyQlpVqnAvfQ5ZjjzzRLMoH53YhLw=;
        b=oSQvyJYJybSzaWa1fKy6Edbe3WXr/dADZr6NpICpM4d3l3FZ5y9eAEp2dv0mMx8MuX
         tvxa1iujZtAwfeD8Z6IjjCnWCYLj2uvm3Qjh3ZskRYDQ2IcaAS2zPQ+/AFJQQBqbV4wI
         CgeL9Kgs/GA05/F1oY4TaNaI6N8e7pJQ85jVyEERLpSAovc97pMQ1o/Wzr9g0k6tb8jO
         fRu83yMoKGtaUYC23CHnAO3e1MZ8p2svN+4mv+zdJBjUoXC4SEsBQOb2w2lqqIEjwjGN
         /Y7QSmMcYcW5EMBptkrwPHIMmOHZLqvgZMpvvCOIUIjDcZqD+86ev9GymgfiHTAIs/cM
         i+1g==
X-Gm-Message-State: AOAM530x1Guk64/U7ww/SF1P4zx7xHPLLYRUqh5dZOmxtLAnrCBqGHLG
        Bow7vVX4iSIyLFvNWNza0Aw=
X-Google-Smtp-Source: ABdhPJyGMRs03jmtnz8auj9jakNys4ZUnQxuuZ7ifmy2DHdpSx60FHDGs19ZrPBojG6GEjtcMQlEDA==
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr91173edw.346.1640120692884;
        Tue, 21 Dec 2021 13:04:52 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id c3sm6355041edr.33.2021.12.21.13.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:04:52 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] hwmon: (adt7410) Pass name to core driver
Date:   Tue, 21 Dec 2021 23:04:31 +0200
Message-Id: <20211221210438.2637430-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221210438.2637430-1-demonsingur@gmail.com>
References: <20211221210438.2637430-1-demonsingur@gmail.com>
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

