Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37C3492056
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343594AbiARH15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbiARH12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:27:28 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14102C061574;
        Mon, 17 Jan 2022 23:26:48 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q75so5413932pgq.5;
        Mon, 17 Jan 2022 23:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yecptQTSi6NHIXvVrHT44imb/ZHLpBwj2o/CiNFNizM=;
        b=hVhfzXlx7zb7Mv7XXWzaSW0qeRU9iNGFs0tfo1QhR//6OhkcPL7ziN9w2xznA2uKpN
         xtxHufpWkn/67SM5UAPZNS5yyJGIm13iAB5+0vh+D8796jtEsx2976HeswgUWqZy/BnA
         cE/jphJBbqqjMlVFlgwzO8kURtRwRwTh1bsQpLe1YeJ34tRUuDUserWr+e228GnEO7cI
         ysZV6BES2xN18x/Q8Ww4XJ0qnnrIItnKrRvfvDwxRMGHomrDZ66ZVQq0THOGK4LLVeiS
         Xv2xUaqjsIJ00o9vIGdhFHeSNE+ePBBD6jHyRYyWnmAjKerDJWDXRMIwhK+qmNz0bitv
         au1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yecptQTSi6NHIXvVrHT44imb/ZHLpBwj2o/CiNFNizM=;
        b=eoHBA/l1Dale03VqzYwitIjUgysT9XEV5IoXzUOkqhoVe05DV7D5e4B4dz0b8D75fu
         o5nZ89ZMwi4OubXurcvtXn1lHkLJRvXI4b8HfnA7Tk/xK0QuOaqzwt/pSIPvOBAGnxdU
         xyDU5BM5TijGymNZuURYvYXQve5t+dpUuYoN+OUWrk1P89PWlTtoLL7fHjo7bc2EvHR9
         pcYqJmgDBBbCi7fBjNPtgZ2LzX4wiD2rHVie1vz9thzuLpOAtvJcF3Bc5+4RQawIh2HU
         glcPmw9Rv7DTxqtCAmte7sy/V0cC+NUV4LUSWUu68rYQBiXbKgv3F3GEyPqcLXw84L+M
         b2mQ==
X-Gm-Message-State: AOAM530pUxZHH5KFUaHGwClhOtFIiGBHpsws13phj0NSBqfApCc1oo5T
        i/alNinxDLW484guk+A/5yY=
X-Google-Smtp-Source: ABdhPJyrm9834y/iiIqzI1/VwpK5Aibqv1C5Ymyrcrsd6Nz92eHyDJe++I1AdzOzsSCD8fyuziCAOA==
X-Received: by 2002:a63:c5e:: with SMTP id 30mr14979339pgm.522.1642490807480;
        Mon, 17 Jan 2022 23:26:47 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:46 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] HID: i2c-hid: use helpers to do endian conversion in i2c_hid_get_input()
Date:   Mon, 17 Jan 2022 23:26:26 -0800
Message-Id: <20220118072628.1617172-11-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to use helpers to do endian conversion as it documents
and draws attention to it, and might be a bit more performant as
well.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 433b6692f277..07c2ea057013 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -508,9 +508,9 @@ static int i2c_hid_hwreset(struct i2c_hid *ihid)
 
 static void i2c_hid_get_input(struct i2c_hid *ihid)
 {
+	u16 size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
+	u16 ret_size;
 	int ret;
-	u32 ret_size;
-	int size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
 
 	if (size > ihid->bufsize)
 		size = ihid->bufsize;
@@ -525,8 +525,8 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 		return;
 	}
 
-	ret_size = ihid->inbuf[0] | ihid->inbuf[1] << 8;
-
+	/* Receiving buffer is properly aligned */
+	ret_size = le16_to_cpup((__le16 *)ihid->inbuf);
 	if (!ret_size) {
 		/* host or device initiated RESET completed */
 		if (test_and_clear_bit(I2C_HID_RESET_PENDING, &ihid->flags))
@@ -534,19 +534,20 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 		return;
 	}
 
-	if (ihid->quirks & I2C_HID_QUIRK_BOGUS_IRQ && ret_size == 0xffff) {
-		dev_warn_once(&ihid->client->dev, "%s: IRQ triggered but "
-			      "there's no data\n", __func__);
+	if ((ihid->quirks & I2C_HID_QUIRK_BOGUS_IRQ) && ret_size == 0xffff) {
+		dev_warn_once(&ihid->client->dev,
+			      "%s: IRQ triggered but there's no data\n",
+			      __func__);
 		return;
 	}
 
-	if ((ret_size > size) || (ret_size < 2)) {
+	if (ret_size > size || ret_size < sizeof(__le16)) {
 		if (ihid->quirks & I2C_HID_QUIRK_BAD_INPUT_SIZE) {
-			ihid->inbuf[0] = size & 0xff;
-			ihid->inbuf[1] = size >> 8;
+			*(__le16 *)ihid->inbuf = cpu_to_le16(size);
 			ret_size = size;
 		} else {
-			dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
+			dev_err(&ihid->client->dev,
+				"%s: incomplete report (%d/%d)\n",
 				__func__, size, ret_size);
 			return;
 		}
@@ -555,10 +556,9 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 	i2c_hid_dbg(ihid, "input: %*ph\n", ret_size, ihid->inbuf);
 
 	if (test_bit(I2C_HID_STARTED, &ihid->flags))
-		hid_input_report(ihid->hid, HID_INPUT_REPORT, ihid->inbuf + 2,
-				ret_size - 2, 1);
-
-	return;
+		hid_input_report(ihid->hid, HID_INPUT_REPORT,
+				 ihid->inbuf + sizeof(__le16),
+				 ret_size - sizeof(__le16), 1);
 }
 
 static irqreturn_t i2c_hid_irq(int irq, void *dev_id)
-- 
2.34.1.703.g22d0c6ccf7-goog

