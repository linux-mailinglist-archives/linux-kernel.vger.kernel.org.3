Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9F047C89C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhLUVFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbhLUVE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:04:59 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F21C061574;
        Tue, 21 Dec 2021 13:04:58 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y13so51023edd.13;
        Tue, 21 Dec 2021 13:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86w3eyiKacs5uaGphCz79xA1hlTYBtSnubTIMb1PBmo=;
        b=NX7xCB8Aex6XzSuYGWqRHcYEon+NkTDZ8fmUSilRev/npT7EUQw97FTSHfa2OvA1FL
         09d6d7GsJ2x6UaAPGPMcktUhk1ouJtu85K9ys5YlfvJPWf8QhAqdtWUF/Zr9lDvehvYx
         7fLdoMbZ8bHo/UCH9HYPxzKFKn07eYG3orXU5hfkSD/pwe1gI3PUkaeogO7hZJKPO83n
         ZUjNAelWqUIx1lEkc4WqwGn+IqxcYPmqfFgQAy1vchIUoTa1soz4x9WpwX8XQESHf3xk
         HO8j9KKKtokt2uAOGGKue27O7rF7uh0rs2BhdCJQU/mEFwiHtHN2Sc0NkwUzozFj8DIY
         8WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86w3eyiKacs5uaGphCz79xA1hlTYBtSnubTIMb1PBmo=;
        b=3nLREtmV7tIcAkRZQHHq9qbm1F6Jn0QXOa/aPzmL6jacLPvWvOTNB/BZNWnyH6Xe8S
         hgi53C0AyFFkHd2zJgkM7rR8ChekKPm2n7fFMjRmVWVETLhMOCY8mAahJjhz6tcOz6Rc
         +tdmo3E3kg/Se4Lup5AHeveCO6FlNDU7WbfeRbonW+/4oPN0AlGsN9gkJiYTLxMzyNLb
         BSXs3plBPvY6pyZuRhiwK3G3g7ilRWboHrR2a4UOGsCVZoYU7EHN9Ge0L51Q63nwnwmD
         EoxktMHicWV8lVQl+m8A0K/IoPryhX7iiQiPRlLD577I6tDg8zT1MzqtATxLBZ66j+Sb
         iJYA==
X-Gm-Message-State: AOAM5319u3blAaKWKi/HB8u9AEKbDgLuTNAE40gjM0M/PsDoHDs/+MGw
        5oqrQIuIe901P1qFVPRVsPQ=
X-Google-Smtp-Source: ABdhPJziDgJtitq2IfFdP6PBQ0inrdNJj/TOlJ4S7JkXy9qgbL/gvATdzwO36GseeKS1d/Hn0VSTVw==
X-Received: by 2002:a17:907:9694:: with SMTP id hd20mr84497ejc.360.1640120697164;
        Tue, 21 Dec 2021 13:04:57 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id c3sm6355041edr.33.2021.12.21.13.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:04:56 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] hwmon: (adt7x10) Use devm_request_threaded_irq
Date:   Tue, 21 Dec 2021 23:04:35 +0200
Message-Id: <20211221210438.2637430-6-demonsingur@gmail.com>
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

To simplify the core driver remove function.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 2e6e54bf1d15..84e8879d4ca7 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -450,9 +450,11 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
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
 			return ret;
 	}
@@ -463,8 +465,6 @@ EXPORT_SYMBOL_GPL(adt7x10_probe);
 
 void adt7x10_remove(struct device *dev, int irq)
 {
-	if (irq > 0)
-		free_irq(irq, dev);
 }
 EXPORT_SYMBOL_GPL(adt7x10_remove);
 
-- 
2.34.1

