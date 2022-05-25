Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B974533EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244662AbiEYOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244681AbiEYN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:48 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B876AE261;
        Wed, 25 May 2022 06:58:44 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id s11-20020a4ab54b000000b0035f0178dfcfso3800920ooo.7;
        Wed, 25 May 2022 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U+UXxY05M5TJmi4jLyRXXMaHNAZH++lXKcrFl1VFWV8=;
        b=BgZZyZtQ7wCoyINfVpNxMetNS6uzBVZ1RvSn/eaxmGYy0bo7kSL0E2kh2x/XmHPaFf
         V8VO1D0RIJcG3/xyL/kQwmy+dR1mhem+3N7gia1ldfy9zHQDcSgl79GtnDzkC5VgSq8N
         cnEKwnLf7MVvq0zM3W5yP/v/2nIzckxNtGzbNOgDlxu9euPoRFYr1//PrnHUoPVeJP74
         b6gMK9SRXkmbELMqRB4FdemvugVfyDNfYJ5HDBwX/4qaEEd1CxJ9IheJpEj6mlOAyvc3
         XdF2wtTIwpTIrj71IysYo4IN5mNGrJOCscvQrl6kFHa8xN8XFqKLxjcnaUuAF+ma6E7H
         3/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=U+UXxY05M5TJmi4jLyRXXMaHNAZH++lXKcrFl1VFWV8=;
        b=UGGlJ0OWqa434e9j1qMgnOyEXfpQyDbwJjPmAzahcYDIfX8QXPUi+Fwxg5PfVTLC1j
         9QWA0PfYZp16Kczw6kHcmsdWbR3H7P6RfQi0fFq/1a6koXVXRLN2RJx7C+puo6ZYHNcX
         U+nn7+QvUsupj7CUM5i6FaeN/HgfEflL1/Vz6CtYKSOB1N3UyCfscC2S/gmC/HagMEe9
         CgUfuXeP383urR3bRwIWo3LrgReTzf8jCaGvzShi+2pdMa9HtsoLmRHzM1ETgk4zIFoa
         wYLZEGQfM76cCidCoM3dhBcF2FzA2TNJvsqb3QkcSO7cLkDW/6bzgexrEvf/7NK+ig4r
         9XNA==
X-Gm-Message-State: AOAM5327errbrhiy6zbz2tzzlql6QiFmE2r2wwUiK0KaCPe4Lwkay5dW
        bFttQBlR3h8ewTFt/bKYPPv9dlsrn+TgMw==
X-Google-Smtp-Source: ABdhPJyjYoF6zvRQEWSpyLYIBh5bFJvBZaW5Yqc3bd41NmnICeJmFZ6eB0xjMiAxgSTKn0XqtwcJwA==
X-Received: by 2002:a4a:968e:0:b0:324:22c6:1a31 with SMTP id s14-20020a4a968e000000b0032422c61a31mr12891226ooi.93.1653487123176;
        Wed, 25 May 2022 06:58:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o7-20020a4abe87000000b0035eb4e5a6c0sm6515750oop.22.2022.05.25.06.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 22/40] hwmon: (lm90) Add support for MAX6690
Date:   Wed, 25 May 2022 06:57:40 -0700
Message-Id: <20220525135758.2944744-23-linux@roeck-us.net>
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

MAX6690 is all but identical to MAX6654. Revision 1 of its
datasheet lists the same chip ID as MAX6654, and a chip labeled
MAX6654 was found to have the chip ID listed as MAX6690 chip ID
in Revision 2 of its datasheet.

A devicetree node is not added for this chip since it is quite unlikely
that such an old chip will ever be used in a devicetree based system.
It can be added later if needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm90.rst |  2 +-
 drivers/hwmon/lm90.c         | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index 53429f79b819..45bc333a1219 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -370,7 +370,7 @@ MAX6648, MAX6692:
   * Better local resolution
   * Unsigned temperature
 
-MAX6654:
+MAX6654, MAX6690:
   * Better local resolution
   * Selectable address
   * Remote sensor type selection
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index abc64738e892..22ea75535ab4 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -42,7 +42,8 @@
  * accordingly, and is done during initialization. Extended precision is only
  * available at conversion rates of 1 Hz and slower. Note that extended
  * precision is not enabled by default, as this driver initializes all chips
- * to 2 Hz by design.
+ * to 2 Hz by design. The driver also supports MAX6690, which is practically
+ * identical to MAX6654.
  *
  * This driver also supports the MAX6646, MAX6647, MAX6648, MAX6649 and
  * MAX6692 chips made by Maxim.  These are again similar to the LM86,
@@ -237,6 +238,7 @@ static const struct i2c_device_id lm90_id[] = {
 	{ "max6659", max6659 },
 	{ "max6680", max6680 },
 	{ "max6681", max6680 },
+	{ "max6690", max6654 },
 	{ "max6692", max6648 },
 	{ "max6695", max6696 },
 	{ "max6696", max6696 },
@@ -1716,6 +1718,19 @@ static const char *lm90_detect_maxim(struct i2c_client *client, int chip_id,
 		if (!(config1 & 0x07) && convrate <= 0x07)
 			name = "max6654";
 		break;
+	case 0x09:
+		/*
+		 * The chip_id of the MAX6690 holds the revision of the chip.
+		 * The lowest 3 bits of the config1 register are unused and
+		 * should return zero when read.
+		 * Note that MAX6654 and MAX6690 are practically the same chips.
+		 * The only diference is the rated accuracy. Rev. 1 of the
+		 * MAX6690 datasheet lists a chip ID of 0x08, and a chip labeled
+		 * MAX6654 was observed to have a chip ID of 0x09.
+		 */
+		if (!(config1 & 0x07) && convrate <= 0x07)
+			name = "max6690";
+		break;
 	case 0x4d:
 		/*
 		 * The MAX6657, MAX6658 and MAX6659 do NOT have a chip_id
-- 
2.35.1

