Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4A647C822
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhLUULo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbhLUULd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:11:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D16AC061574;
        Tue, 21 Dec 2021 12:11:33 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z29so56387526edl.7;
        Tue, 21 Dec 2021 12:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Jkv8qUJh2Qvz2gJBqyHxg6YZrouzoh2tHirL2oPEjY=;
        b=i7DlPC8hunO7b9Ca44FoAj4NTyiOe5HIz1Gox/5gJSMbPz2fPZqHAdAc1Bpk0iLaeP
         isEhr58ECcupjzJqCRDjRF7e8S1Jf2VTKz+kKsUDhT1rT10Z1I1GgP7hDp8gjLs7PWQ2
         x8J5q0suZzmlGj1H/hu3TCPxy4LThURmBT8OQPqDg3nze3rUGi/B8q0a6wXug3stgsHr
         dSNdlpEJkq+lTE1sU04UremTCofRqGBBKKtTUZ2/lcoaDJbTcDX5xUqz2zIqa8GupROD
         ElW8BNNzrKGltyKR+w9Kz6SR7tymcDU7npMK2K0NvlS0uCDO5nUJ4ZjWPLJFdjzZQ7Xk
         UHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Jkv8qUJh2Qvz2gJBqyHxg6YZrouzoh2tHirL2oPEjY=;
        b=jGzn6VDrPzsedn0gmaPnXbWsgfv/tn/aBnK+qChaP/qux5zsozylC5nk2t11xzTwVM
         1qBL2HGzxR1GITKdBKXW+DhPoWom/hHLvupc+pJqfJyT+88pjXwQCiEkqY8hD1UEI6d9
         VW/EOX7BSDHmALMMu4REo7/HI97naPUFiMuMYvKxF62MIEE2hEUTONlniI0MK0kxARZ3
         UnzPzMMQJuCS4IFLF52f+DB4bcuFXxH3PXqq3RWMTYwpWICGXqVX9BCs0YbJaVJ6UVE/
         +HekZPvmgzTwDuuf2lJXU+HLePSxjI7O1yIlcZGMTHWIFfJ4Yp3LE7LRk2HKqVkD7Qnn
         uwrw==
X-Gm-Message-State: AOAM532TNFQGRkORM8I0LG5a2qv0vJ5mBygQPwDlzNu1ZrNoGQWIukPA
        9O+15HeIBCnNbnXPHlxlLPY=
X-Google-Smtp-Source: ABdhPJwWX6ueiELbbia9OPY/Ac0P/7wg0qodfLA+B+wmLR0+lP7vxpCPVRySSl4e9j0ejCKFJyTkTg==
X-Received: by 2002:a17:907:7616:: with SMTP id jx22mr4130824ejc.119.1640117491688;
        Tue, 21 Dec 2021 12:11:31 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id b7sm8648418edj.24.2021.12.21.12.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 12:11:31 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/8] hwmon: (adt7x10) Pass hwinfo dev to irq handler
Date:   Tue, 21 Dec 2021 22:11:12 +0200
Message-Id: <20211221201113.752827-7-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221201113.752827-1-demonsingur@gmail.com>
References: <20211221201113.752827-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

The irq handler will need to trigger events on the
hwmon device. Pass it so that we don't store it in
private data.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 72d3a5de359e..964cbe43de46 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -101,7 +101,9 @@ static const u8 ADT7X10_REG_TEMP[4] = {
 
 static irqreturn_t adt7x10_irq_handler(int irq, void *private)
 {
-	struct device *dev = private;
+	struct device *hdev = private;
+	struct adt7x10_data *d = dev_get_drvdata(hdev);
+	struct device *dev = d->bus_dev;
 	int status;
 
 	status = adt7x10_read_byte(dev, ADT7X10_STATUS);
@@ -454,7 +456,7 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 						adt7x10_irq_handler,
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
-						dev_name(dev), dev);
+						dev_name(dev), hdev);
 		if (ret)
 			return ret;
 	}
-- 
2.34.1

