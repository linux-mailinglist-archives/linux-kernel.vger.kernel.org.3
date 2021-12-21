Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89F447BFDE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbhLUMkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbhLUMj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:39:59 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17559C061574;
        Tue, 21 Dec 2021 04:39:59 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x15so51582179edv.1;
        Tue, 21 Dec 2021 04:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygo8ojrCo6BZT32LoIuN07MJGwf7kqUO/5JQytz0V/s=;
        b=GCege4vuFl7SWJxuixyuNgk5DAhMWrElUtjVPPtUjDP1lVOZhMjw/ZfbxHA+yaMjyh
         FPNygCD54AWOko8COyuDLXP1AjIKnoCAZFImdEhV3q++6UcUCOge29u0jO5Pzx8HeLhK
         rMdhKbXr1dDCGmeZzeX0zHK7i0wzBPtudkZbkk/LTv6HX/amBxSLMKBW5d8eu22UoYus
         33bs9Y7dUq/WVy34AUJHJvhtHJt/ciHL1Pk7zM3OgwlCwqwjY/J+0Eps4w1foU7IfUpH
         vLx1D01UDivKyvuuYjDFuFHmz39vxezjDQk2Fl1EYVPBpKs5liL7sSCtoPTcEkm9gBO9
         8s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygo8ojrCo6BZT32LoIuN07MJGwf7kqUO/5JQytz0V/s=;
        b=pjG9HOPBa7sRgNACX1E8O2AciICcgc1OyC/cA361jSz23ilgYy9+Wdpqzz01i3WgTM
         pj1uR9Bxeb2RgVx0zr/U+D9MQiPpVuD9ttD5CJFWCffPH7BHPEBzOu3yGyX79DsD1ut6
         5MqrMxwj0H81ZOfkOr1GmWMhK3yFP+qDDgfXVk9Ud0BIlUuZI7iwv+yA2Qxp9C9n2Up7
         //txFV7v5k3uM9BVErMFPqfnb2YouAfWxtbjPmzB6UyTMudFC8JX0R3EhkoQ8NFZNR29
         jZ7E/yfRkjrQsbL9qHVgWcuOMUPr15NOZBfJbYRPEGZOSok4dao5h7qg5Bmr9Wn2zkDh
         KtdQ==
X-Gm-Message-State: AOAM530Uq5K3vZxPISp3n8vf3HnoyhZzSNLfvZbhXUwJsKwNLU4bTwef
        O/1JaPflXrQYbCe7wzIRLWk=
X-Google-Smtp-Source: ABdhPJzDKbYAb40eOpQQohllGJi1aX/EbebO/vPFulK8FiyD6xOty3p6IxpGRm7mJr0xOAOE2ECfaA==
X-Received: by 2002:aa7:c943:: with SMTP id h3mr3001616edt.233.1640090397706;
        Tue, 21 Dec 2021 04:39:57 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id bx6sm2849438edb.78.2021.12.21.04.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:39:57 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/10] hwmon: adt7x10: pass hwinfo dev to irq handler
Date:   Tue, 21 Dec 2021 14:39:39 +0200
Message-Id: <20211221123944.2683245-5-demonsingur@gmail.com>
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

The irq handler will need to trigger events on the
hwmon device. Pass it so that we don't store it in
private data.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 25c1ab199658..ec7e526b3441 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -102,7 +102,9 @@ static const u8 ADT7X10_REG_TEMP[4] = {
 
 static irqreturn_t adt7x10_irq_handler(int irq, void *private)
 {
-	struct device *dev = private;
+	struct device *hdev = private;
+	struct adt7x10_data *d = dev_get_drvdata(hdev);
+	struct device *dev = d->bus_dev;
 	int status;
 
 	status = adt7x10_read_byte(dev, ADT7X10_STATUS);
@@ -407,7 +409,7 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 						adt7x10_irq_handler,
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
-						dev_name(dev), dev);
+						dev_name(dev), hdev);
 		if (ret)
 			goto exit_hwmon_device_unregister;
 	}
-- 
2.34.1

