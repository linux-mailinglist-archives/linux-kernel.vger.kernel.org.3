Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E875A6038
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiH3KFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiH3KEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:04:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5D0E9262
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:02:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z25so14798795lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=k7Wv9JPGNGx0Ra+ScROhfKK2Z6NrammxPt9kEIj+dCk=;
        b=jAs2s1oey20xSErXkICNpaSNBGzCeHhnTCVMAkezqM2iDSBymdbRgGSaaZmG2O+hGA
         JUws8HVuuAtihjZ1D7+VcKJr67BVS9hCfc5nqKaEKmIfbuwElTn3jv47zkhU9cc+oM9e
         kA+dXbPbUMWf30/4o6dlWpoAW7GjV47sTGW70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=k7Wv9JPGNGx0Ra+ScROhfKK2Z6NrammxPt9kEIj+dCk=;
        b=bdlyw0g+NZeKi3oHQeMu4YADCQH9rliOsaRto/fxoUimJ2nqETSwR3kY+u1oKC6v3X
         fNmBjqzn1hpFRtgPTOmQqNMtZlXLYrjgip/pjnDcFHNoo+kXw5KAKJm9vjMYgHlJVjEx
         jg7y72M0/IIiLxxDVLxbQXbSKVrSUe0kahFrffBLE6Zcbv2dDHCtjuK7mqVet7rJuV6q
         RsjrbQpVLCmJHg1nEnjdb229pwbABbgq2esZBrCPKYHgSzz0JoBBxtyYgJNiAjDnVcnk
         rkRpk1iGQ4T7tYZZaQ3/yUoqgnUyNCEQE0iLtb1mF9y+ly3/xz5k3DbBq3YQt5tlJBkx
         QfTQ==
X-Gm-Message-State: ACgBeo2JeyzckUFFqIYjF/MyFY8b/DkJctQjxpO5Rf2vIKX+vGdiFR3V
        sN/6UTK2HS1UQPCXmoJlc8Net1qzJ3IcS5RP
X-Google-Smtp-Source: AA6agR5aa6IuoXrnZxnufKGhkpywqvL9kzgYI7nkY/a6xflmkkTjJnDhgyIn/TZiG7tG0lGcbNSUmg==
X-Received: by 2002:a19:661a:0:b0:492:d9c8:c683 with SMTP id a26-20020a19661a000000b00492d9c8c683mr7085961lfc.205.1661853722276;
        Tue, 30 Aug 2022 03:02:02 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b0048af6242892sm1573435lfg.14.2022.08.30.03.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 03:02:01 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] rtc: isl12022: simplify some expressions
Date:   Tue, 30 Aug 2022 12:01:48 +0200
Message-Id: <20220830100152.698506-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These instances of '&client->dev' might as well be spelled 'dev', since
'client' has been computed from 'dev' via 'client =
to_i2c_client(dev)'.

Later patches will get rid of that local variable 'client', so remove
these unnecessary references so those later patches become easier to
read.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 2dc19061cf5f..5e6bb9153c89 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -112,13 +112,13 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return ret;
 
 	if (buf[ISL12022_REG_SR] & (ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75)) {
-		dev_warn(&client->dev,
+		dev_warn(dev,
 			 "voltage dropped below %u%%, "
 			 "date and time is not reliable.\n",
 			 buf[ISL12022_REG_SR] & ISL12022_SR_LBAT85 ? 85 : 75);
 	}
 
-	dev_dbg(&client->dev,
+	dev_dbg(dev,
 		"%s: raw data is sec=%02x, min=%02x, hr=%02x, "
 		"mday=%02x, mon=%02x, year=%02x, wday=%02x, "
 		"sr=%02x, int=%02x",
@@ -141,7 +141,7 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_mon = bcd2bin(buf[ISL12022_REG_MO] & 0x1F) - 1;
 	tm->tm_year = bcd2bin(buf[ISL12022_REG_YR]) + 100;
 
-	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
+	dev_dbg(dev, "%s: secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
 		__func__,
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
@@ -158,7 +158,7 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	int ret;
 	uint8_t buf[ISL12022_REG_DW + 1];
 
-	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
+	dev_dbg(dev, "%s: secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
 		__func__,
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
@@ -173,8 +173,7 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		/* Check if WRTC (write rtc enable) is set factory default is
 		 * 0 (not set) */
 		if (!(buf[0] & ISL12022_INT_WRTC)) {
-			dev_info(&client->dev,
-				 "init write enable and 24 hour format\n");
+			dev_info(dev, "init write enable and 24 hour format\n");
 
 			/* Set the write enable bit. */
 			ret = isl12022_write_reg(client,
-- 
2.37.2

