Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BBF533E85
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239319AbiEYOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244599AbiEYN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:46 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B43A889D;
        Wed, 25 May 2022 06:58:35 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id m125so2069831oia.6;
        Wed, 25 May 2022 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kBZbief4RK9Ka1jxdWPMvx6QXs+iQ5T6yLeGIM3oN6w=;
        b=aj3IJLufUSUNh7Gzu5T2GO+JO9HdW6NbcH2WtaK1qyoBiQc8wM8XzSL4rzCxM3sI+O
         yc232fYkYWyHMMcOzbb2mnOkxSwrn3xCf/8hSmcIcyUJew1tDDe+kO51U6rJyQAd1pux
         HOC14YTDR6VxEiPC9cPMlI6mN0HF0tCdzLXxyyuSo3xicBq27tpnNV8eru9oni+ClaPC
         O2H5mxAeOJ2NWubmEOCNevnC7GIMl+0ZLAJapz0psYj86KVqhHqVzursdR3FkCBlYU8V
         ACsCYmy54wctW1XvMs9S2vbQa7wYwe/1dEUIPRVcB4ZM4ojdo2knw2x5tFrfO3iksi7e
         earg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kBZbief4RK9Ka1jxdWPMvx6QXs+iQ5T6yLeGIM3oN6w=;
        b=fbsb1KG+yy6TD9VHwmNfEHrf7qbZpe6pkyNrZf5+ZYALGdWBu18sPbcN6xZG4Wx1CD
         KspVESpBUsl+/Qeax5j9R4PCdwIIxULjwmULG6mtHjWgbsr//7vh42pT0oZNLq1kjFdx
         bspSXrR1URfimJqHrhUohsiyUlKreghiJI4t7eFeHpGuF0RoMtgxUY9wJkUlRKN/+0bz
         5v9ldFuwU62qpaxiIy8Mfp8M9oWnU1+NUZvi/IesZCdFBA//r+bh0wY2NqCvA7uozEE/
         cof3TUzQwMzBMS0Qz5tA8JWyLWFRiZAPElXjnXHFu3rfHg0ueTWF2jFY0S1JFt6Amuc6
         4uTg==
X-Gm-Message-State: AOAM5317OqqC4zuEIN/rYmbLBovUG+gm0dLUz9yzQZQEb0OA6qNndefN
        jjC3Xc9UOW4GZx5NEieK4HsfZVl+ANSoYA==
X-Google-Smtp-Source: ABdhPJykOIL3+aMb0RJQ8dFYbUm0GY9CvmZH0sw9MPUV0B1VNnyZit6V7b/jHvRpvoiuiveWMV4kKQ==
X-Received: by 2002:a05:6808:1a22:b0:32b:60c2:e2bd with SMTP id bk34-20020a0568081a2200b0032b60c2e2bdmr5147815oib.189.1653487114172;
        Wed, 25 May 2022 06:58:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x2-20020a9d5882000000b0060603221274sm5985139otg.68.2022.05.25.06.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 17/40] hwmon: (lm90) Fix/Add detection of G781-1
Date:   Wed, 25 May 2022 06:57:35 -0700
Message-Id: <20220525135758.2944744-18-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135758.2944744-1-linux@roeck-us.net>
References: <20220525135758.2944744-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When support for G781 was added, chips with ID 0x01 were found at I2C
addresses 0x4c and 0x4d. The G781 datasheet (version 1.3 from October 2003)
says that the device ID for G781-1 is 0x03, not 0x01. Also, the datasheet
states that the chip at I2C address is G781 and the chip at I2C address
0x4d is G781-1.

A G781-1 at I2C address 0x4d was now found to have a chip ID of 0x03
as suggested by the datasheet. Accept both 0x01 and 0x03 chip IDs at both
addresses to ensure that all variants of G781 are detected properly.

While at it, improve chip detection accuracy by reading two additional
registers and ensuring that only expected bits are set in those registers.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 17312d173b8a..b39e31ded2cb 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1728,13 +1728,42 @@ static const char *lm90_detect_gmt(struct i2c_client *client, int chip_id,
 				   int config1, int convrate)
 {
 	int address = client->addr;
-	const char *name = NULL;
 
-	if ((address == 0x4c || address == 0x4d) && chip_id == 0x01 &&
-	    !(config1 & 0x3f) && convrate <= 0x08)
-		name = "g781";
+	/*
+	 * According to the datasheet, G781 is supposed to be at I2C Address
+	 * 0x4c and have a chip ID of 0x01. G781-1 is supposed to be at I2C
+	 * address 0x4d and have a chip ID of 0x03. However, when support
+	 * for G781 was added, chips at 0x4c and 0x4d were found to have a
+	 * chip ID of 0x01. A G781-1 at I2C address 0x4d was now found with
+	 * chip ID 0x03.
+	 * To avoid detection failures, accept chip ID 0x01 and 0x03 at both
+	 * addresses.
+	 * G784 reports manufacturer ID 0x47 and chip ID 0x01. A public
+	 * datasheet is not available. Extensive testing suggests that
+	 * the chip appears to be fully compatible with G781.
+	 * Available register dumps show that G751 also reports manufacturer
+	 * ID 0x47 and chip ID 0x01 even though that chip does not officially
+	 * support those registers. This makes chip detection somewhat
+	 * vulnerable. To improve detection quality, read the offset low byte
+	 * and alert fault queue registers and verify that only expected bits
+	 * are set.
+	 */
+	if ((chip_id == 0x01 || chip_id == 0x03) &&
+	    (address == 0x4c || address == 0x4d) &&
+	    !(config1 & 0x3f) && convrate <= 0x08) {
+		int reg;
 
-	return name;
+		reg = i2c_smbus_read_byte_data(client, LM90_REG_REMOTE_OFFSL);
+		if (reg < 0 || reg & 0x1f)
+			return NULL;
+		reg = i2c_smbus_read_byte_data(client, TMP451_REG_CONALERT);
+		if (reg < 0 || reg & 0xf1)
+			return NULL;
+
+		return "g781";
+	}
+
+	return NULL;
 }
 
 static const char *lm90_detect_ti(struct i2c_client *client, int chip_id,
-- 
2.35.1

