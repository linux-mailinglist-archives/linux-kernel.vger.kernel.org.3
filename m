Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8400492046
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbiARH1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245189AbiARH0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:26:49 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B50FC06174E;
        Mon, 17 Jan 2022 23:26:43 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id hv15so22492997pjb.5;
        Mon, 17 Jan 2022 23:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5cTrYGjBflhhMN+moNPPDrBhqrz1YMurZIOtJGj4T8=;
        b=PnRPOQlOkC0+w2q3TwAX4p9rjPF13nnic+JiOLS5P8IioE7xRg7kDifNJFNd5SlbkQ
         j6dMtDwMty2mP0hn8n7tVG7AsxYnsioWbIicTCvWfJ7+VEgLgTjWC9mi6SrU8GY4mkqw
         8WOVL9z6/eUBlcsEgbtA8NYreBsjnoduNm4xGaIRz9HSLa2PNOMAqf8sQwLEyELf/a0J
         CpgPBR8xt9HtpFbvqLXBeggS+AWdI+ZiM0bBYvz8aDrisIduD3nFtxV0d2gzn6xqdLhD
         Lc2Nh/rYifYppCk1Z91OpwuTIlfnkxQOHSu5DD8+Up0OQql7j9S7tLIOuz0xkiU7lQMY
         E6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5cTrYGjBflhhMN+moNPPDrBhqrz1YMurZIOtJGj4T8=;
        b=UCRI4YXQ0i3Ln1FdCUe48HQjTM8QlanY189CJxlkeccsEWmcxqUjX2pTI+3ms227SM
         qOi2+pTbRC0tpBz7RMVmCmLgIxCMym1BpLZPhx9EdQXpjwP8aTTJoGee8u1N5OYLkQ7p
         lzNhZDuU9TC/5y9c9TUqhdGwrUY5ihvaE1DJxSKnq2Owc3Dsei7XhdwrVyVqH8LD2z2R
         /wxrr6CdE3naBCKl2K3tiQj8u4K4aBf73t+QsX5d+0Xxxmn7Vh4DnEdt+STqDzgup8tZ
         EUOZHyOdKVYiRhvBorz4LyRK/L9D+p0XI/sstKQlqpObYfj0K8Pnf2DD9aVOXz0EHLrB
         iQqg==
X-Gm-Message-State: AOAM532CqZjDoGq9S2+hV42PS/kiNAVYOPad/6ROIjZvnq3j+xKIedKX
        vSmWHMj6/kqqWuUj0C+6MEqxtMSch5Q=
X-Google-Smtp-Source: ABdhPJyGmwVLeZUI6G30LQqbTTobWIVDhijM49SVWx7lgNZEcFLEghjxLpa0gExdKXDoVRn9AtBD+w==
X-Received: by 2002:a17:902:ecc9:b0:14a:7a70:1fb8 with SMTP id a9-20020a170902ecc900b0014a7a701fb8mr25230777plh.22.1642490803026;
        Mon, 17 Jan 2022 23:26:43 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:42 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] HID: i2c-hid: create a helper for SET_POWER command
Date:   Mon, 17 Jan 2022 23:26:23 -0800
Message-Id: <20220118072628.1617172-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another case where creating a dedicated helper allows for cleaner code that
shows exactly what communication happens with the device when toggling its
power.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index b1a2c6ad374d..da673e3f2910 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -107,7 +107,6 @@ struct i2c_hid_cmd {
 /* commands */
 static const struct i2c_hid_cmd hid_reset_cmd =		{ I2C_HID_CMD(0x01) };
 static const struct i2c_hid_cmd hid_get_report_cmd =	{ I2C_HID_CMD(0x02) };
-static const struct i2c_hid_cmd hid_set_power_cmd =	{ I2C_HID_CMD(0x08) };
 
 /*
  * These definitions are not used here, but are defined by the spec.
@@ -396,6 +395,22 @@ static int i2c_hid_set_or_send_report(struct i2c_hid *ihid,
 	return data_len;
 }
 
+static int i2c_hid_set_power_command(struct i2c_hid *ihid, int power_state)
+{
+	size_t length;
+
+	/* SET_POWER uses command register */
+	*(__le16 *)ihid->cmdbuf = ihid->hdesc.wCommandRegister;
+	length = sizeof(__le16);
+
+	/* Now the command itself */
+	length += i2c_hid_encode_command(ihid->cmdbuf + length,
+					 I2C_HID_OPCODE_SET_POWER,
+					 0, power_state);
+
+	return i2c_hid_xfer(ihid, ihid->cmdbuf, length, NULL, 0);
+}
+
 static int i2c_hid_set_power(struct i2c_hid *ihid, int power_state)
 {
 	int ret;
@@ -409,15 +424,14 @@ static int i2c_hid_set_power(struct i2c_hid *ihid, int power_state)
 	 */
 	if (power_state == I2C_HID_PWR_ON &&
 	    ihid->quirks & I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV) {
-		ret = i2c_hid_command(ihid, &hid_set_power_cmd, NULL, 0);
+		ret = i2c_hid_set_power_command(ihid, I2C_HID_PWR_ON);
 
 		/* Device was already activated */
 		if (!ret)
 			goto set_pwr_exit;
 	}
 
-	ret = __i2c_hid_command(ihid, &hid_set_power_cmd, power_state,
-		0, NULL, 0, NULL, 0);
+	ret = i2c_hid_set_power_command(ihid, power_state);
 	if (ret)
 		dev_err(&ihid->client->dev,
 			"failed to change power setting.\n");
-- 
2.34.1.703.g22d0c6ccf7-goog

