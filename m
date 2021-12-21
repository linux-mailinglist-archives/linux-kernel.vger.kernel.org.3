Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7196347C8FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbhLUV7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbhLUV6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:58:50 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345B0C061401;
        Tue, 21 Dec 2021 13:58:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f5so621754edq.6;
        Tue, 21 Dec 2021 13:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Jkv8qUJh2Qvz2gJBqyHxg6YZrouzoh2tHirL2oPEjY=;
        b=iq/pk6NgohH+0UaKLHMIjTOf1BJewCVzMaRX8fja+VP6gaZtT/BnkkjWeosA6wufww
         ap9VDDkIqd+LjxK2qA9+Fv/rb3FhqFtDzGP4voHVrfui64fITFhXejU2n9Dx2C3rjY54
         45cxcw0jUmR2Y43429FyZtqCm7BpiMwZiENY/hlAQWEck0VkcV6+wWVRoiplU4WPsCn0
         vobPpEuzB35uSOICtNVJYnKdH/K8sjcVbM/0sI/2SNowcfj15e0MFFhS8eqPZ/F8z40B
         /ZJ9skqbu4xzzI0+mdF0ff5noCWzkfQtnA9xlcDpXroX3nfz8U4uqiw0cwouJlik5W6p
         PsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Jkv8qUJh2Qvz2gJBqyHxg6YZrouzoh2tHirL2oPEjY=;
        b=crLBEIrLUiMEBKAM6+PgnCSLHD18IRHEfHBNemjBRIGeYTBEadPSODztjzLUfSG+w+
         Iz4qzYpbC8elaj2zbksxfUau6azM5E8FyBvneDM6E67pV+YMm4DR8nZR97lSvLfsriNU
         MyEDIE58f1LMIymzflkFh2KzOAUKgJOr5T7xUZq+YrXuJNA1oGUzoaEXarWkhALYFxxz
         6DQab9GYGPnJaVXcOlESpbsCTnWBkIJP0OFaQGbafRLlnIfLNhn/Aw0rbhktIuOpM2is
         bt+awyExVO7IsDXYdGZfoFnWERV3Hc/VSMmIRAgrpw3iv02vGZoC7P9RoK/ulvxJs0Hh
         P7CQ==
X-Gm-Message-State: AOAM532uDggSpYBkCM8zQ97vairKSdHPGjp8Q0AIr2UElShxgdm8iyau
        GcK0NRqJalvTQ5B47tjInfGpU9vQqJo=
X-Google-Smtp-Source: ABdhPJytYgC1ieiOXEq23LGTvZpYuCfpCilP37zIO4lKpGr1ajXJTGAM+chws8JHAYec2Kvdm6MXuQ==
X-Received: by 2002:a17:907:6eac:: with SMTP id sh44mr200986ejc.507.1640123928855;
        Tue, 21 Dec 2021 13:58:48 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id nc29sm41640ejc.3.2021.12.21.13.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:58:48 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] hwmon: (adt7x10) Pass hwinfo dev to irq handler
Date:   Tue, 21 Dec 2021 23:58:40 +0200
Message-Id: <20211221215841.2641417-7-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221215841.2641417-1-demonsingur@gmail.com>
References: <20211221215841.2641417-1-demonsingur@gmail.com>
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

