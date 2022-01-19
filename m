Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4E493252
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350665AbiASB06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344934AbiASB04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:26:56 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4E3C061574;
        Tue, 18 Jan 2022 17:26:55 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id c2so1267896qvw.3;
        Tue, 18 Jan 2022 17:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NWlDBPay0RGRxyzmyjS3XEbFyqNkOj8Iv5n6OG3o+U=;
        b=MpCWDmk9NXxy8yh771xJmT8SjmAc4LyW3XkxX8w8EQnnfBdgTpBgLBF5iARZPixajw
         k/tEqF2rp1uKJ23uGCaE4911d5t5Lf9IPYrPpQwlXOKYLucLNEMbeZPXaYcVZEiUF5Su
         x15lDzRGfxJ3RFqXsF2cFoouwf/gtmVY6Pp5rLi0p1vhhnfHQi6zx3o4H5dObUTWGZqB
         CoNSqWaHphEJMDNED1Wib4RDDsS0LItpM2PZDAhTDJJmGd3H7haLqcAT4jxHZD95Z+PE
         zibQD9ih/JProH8A0Q77ROJYM1KO17C2TWTtR6ju5wQSgC+yZuiqWyCpI6F22cIuILs/
         L7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NWlDBPay0RGRxyzmyjS3XEbFyqNkOj8Iv5n6OG3o+U=;
        b=qM3L5Z39vzhoNtQbClxzvR4Xpq1lJFv5pRbcP+ICo/q8UZzhiWwY43je68FjGjVg5H
         G9ZBo0rP38AzHSA/YaT+CSK9zQ9qmwctSFtNf8B67EJOUtLgJ11Vh8Q26xYfLDly9rdR
         2hXbUjEQs0bmJJSwPb5ljNQo1pLsm5FT+cAPGND7e6xvmyQZ9a2J+YcBmZXzyVhEzj+Z
         ZsHrfMcHYvFpPbUeOUqk36ALoki9zTJL9kCE/PQH8sbEUZ3T2fipAxPNRjbmKWYj9eje
         rDxVtbuCWkFD/CG03G9N4n6V1BlliL57P0lqlzhbr1G/ADkfxyY13ykodx/BqjrJn0Gz
         1jcg==
X-Gm-Message-State: AOAM530h3vCeVe289g6Rr/yI0WVXvJg0tlwOR/FIJb7+lNPYcXq15ZpC
        seIxJhKueZ7fjXVZia/YX3Q=
X-Google-Smtp-Source: ABdhPJweR7nifJO9R2GZlvuMLezNTTbucnA1uu5O7n6SgJbFqgigbuCMlv/M9bpIzvmN7gndvUmYTA==
X-Received: by 2002:ad4:5965:: with SMTP id eq5mr22296832qvb.115.1642555615018;
        Tue, 18 Jan 2022 17:26:55 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.md.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id j2sm4275999qko.117.2022.01.18.17.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 17:26:54 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     alistair@alistair23.me
Cc:     alistair23@gmail.com, andreas@kemnade.info,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.ripard@bootlin.com, mylene.josserand@bootlin.com,
        robh+dt@kernel.org, rydberg@bitmath.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v5 1/4] Input: Add driver for Cypress Generation 5 touchscreen
Date:   Tue, 18 Jan 2022 20:26:37 -0500
Message-Id: <20220119012637.1713748-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220109115331.388633-2-alistair@alistair23.me>
References: <20220109115331.388633-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Evening,

I tried using this with a cypress tma448 and thought there was an issue
with the driver.
Further investigation found the tma448 in question had no configuration
burned into it, thus max size and pressure are zero.

I've added the patch below to extend the driver with device tree
overrides.
Unfortunately device_property_read_u16 is broken on arm64 currently, as
it returns zero.

Also, with this patch, the driver works spectacularly on my broken touch
screen.
As such-
Tested-by: Peter Geis <pgwipeout@gmail.com>

[PATCH] Input: cyttsp5: support touchscreen device tree overrides

It is possible for the cyttsp5 chip to not have a configuration burned
to it.
This leads to a sitatuion where all calibration values return zero,
leading to a broken touchscreen configuration.

The current driver does not support utilizing overrides from the device
tree.
Extend the driver to support this, and permit it to do some basic sanity
checking of the values for the touchscreen and abort if they are
invalid.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/input/touchscreen/cyttsp5.c | 62 ++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 3ac45108090c..e837985d199a 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -507,15 +507,66 @@ static int cyttsp5_get_sysinfo_regs(struct cyttsp5 *ts)
 	struct cyttsp5_sensing_conf_data_dev *scd_dev =
 		(struct cyttsp5_sensing_conf_data_dev *)
 		&ts->response_buf[HID_SYSINFO_SENSING_OFFSET];
+	u32 tmp;
 
 	cyttsp5_si_get_btn_data(ts);
 
 	scd->max_tch = scd_dev->max_num_of_tch_per_refresh_cycle;
-	scd->res_x = get_unaligned_le16(&scd_dev->res_x);
-	scd->res_y = get_unaligned_le16(&scd_dev->res_y);
-	scd->max_z = get_unaligned_le16(&scd_dev->max_z);
-	scd->len_x = get_unaligned_le16(&scd_dev->len_x);
-	scd->len_y = get_unaligned_le16(&scd_dev->len_y);
+
+	if (scd->max_tch == 0) {
+		dev_dbg(ts->dev, "Max touch points cannot be zero\n");
+		scd->max_tch = 2;
+	}
+
+	if(device_property_read_u32(ts->dev, "touchscreen-size-x", &tmp))
+		scd->res_x = get_unaligned_le16(&scd_dev->res_x);
+	else
+		scd->res_x = tmp;
+
+	if (scd->res_x == 0) {
+		dev_err(ts->dev, "ABS_X cannot be zero\n");
+		return -ENODATA;
+	}
+
+	if(device_property_read_u32(ts->dev, "touchscreen-size-y", &tmp))
+		scd->res_y = get_unaligned_le16(&scd_dev->res_y);
+	else
+		scd->res_y = tmp;
+
+	if (scd->res_y == 0) {
+		dev_err(ts->dev, "ABS_Y cannot be zero\n");
+		return -ENODATA;
+	}
+
+	if(device_property_read_u32(ts->dev, "touchscreen-max-pressure", &tmp))
+		scd->max_z = get_unaligned_le16(&scd_dev->max_z);
+	else
+		scd->max_z = tmp;
+
+	if (scd->max_z == 0) {
+		dev_err(ts->dev, "ABS_PRESSURE cannot be zero\n");
+		return -ENODATA;
+	}
+
+	if(device_property_read_u32(ts->dev, "touchscreen-x-mm", &tmp))
+		scd->len_x = get_unaligned_le16(&scd_dev->len_x);
+	else
+		scd->len_x = tmp;
+
+	if (scd->len_x == 0) {
+		dev_dbg(ts->dev, "Touchscreen size x cannot be zero\n");
+		scd->len_x = scd->res_x + 1;
+	}
+
+	if(device_property_read_u32(ts->dev, "touchscreen-y-mm", &tmp))
+		scd->len_y = get_unaligned_le16(&scd_dev->len_y);
+	else
+		scd->len_y = tmp;
+
+	if (scd->len_y == 0) {
+		dev_dbg(ts->dev, "Touchscreen size y cannot be zero\n");
+		scd->len_y = scd->res_y + 1;
+	}
 
 	return 0;
 }
@@ -877,6 +928,7 @@ static int cyttsp5_i2c_probe(struct i2c_client *client,
 
 static const struct of_device_id cyttsp5_of_match[] = {
 	{ .compatible = "cypress,tt21000", },
+	{ .compatible = "cypress,tma448", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, cyttsp5_of_match);
-- 
2.25.1

