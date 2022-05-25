Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D401533E93
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244585AbiEYN7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244560AbiEYN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:58:17 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A7FA502F;
        Wed, 25 May 2022 06:58:11 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id f5-20020a4aa685000000b0040e7e819183so1904070oom.3;
        Wed, 25 May 2022 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkeP4GwJvBOCaJylAO1wG73yjst6A2ktNXJqi4BU/pY=;
        b=cqVCQJfe04xaW1cxQT3cqw2mvzt6bVpHDpDLoPAejS6TsgOgCkhVJJtvMT2C0R5i9N
         bWjQewzqLmPORz/dR47FdtcI9CcnMyvBMXLlXFa+JFH2+olAH4W3SosE7KCV7wXcL2Z0
         k9lxfhY5UNxOyxTzQ+86My3jSzhlKmtbhSnfgy9Cs/nqIS9/4vNQZQrD/71a7QSUEYqi
         hduVVMgKksChs+b69Fhm7Ndp/XE9YO121QeDjyQc6jrDlsWj0RkXY1iJyRkisnDMAEk5
         XhQN+mcCZcLcLvjFdZfCcZ1/W3pCy6vNEJxMYHxH/EgtQ98n9CSLfGzFN2ZEPJ8fwLsN
         cKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jkeP4GwJvBOCaJylAO1wG73yjst6A2ktNXJqi4BU/pY=;
        b=Ri5LKHtqbXhE/77VR8+akNaaI06EZR2M4tuVNktmN13N12In7o6FKdCfxkrr/REUJO
         uTFoGiqVoRxs3cClpkhFfrYY0v+rWzzbvjKtbdltKuOmdrZRc6vr4QXIbal8umKFWGxq
         dtYOCX3tm+q25FFRQt4KYIttQIHtTpm05/t/LvaMWPSXsk7GP3Xs42QEnqSA6AolF95h
         3isU1GuFpm5ib5LSCcoDHvWWuPBj2BJiTa50PB7p6kJVjlGAo6DMmA2rZjDG9f/adQOC
         2vgE+dYUkm1jXA61T4lyH5ocxqaaHbObC5N/B9wkrSfH3Pjhl9w2f52a1d0+gTb8aRdc
         cpnA==
X-Gm-Message-State: AOAM531ywWnQD3T1xMZetnkvyEgplIlCIo3J56EbGa2hzViL80Iv2JIW
        nwI0LdvwX87LLB9IRiAZZv9dlz52vN7TwA==
X-Google-Smtp-Source: ABdhPJwkUSNuTTyyMbgqfJ52uV0l2q3NL/HtZPF7Yj90++bjom9RuOkDk1ke4NYdRG/6zcA4qXS05Q==
X-Received: by 2002:a4a:b307:0:b0:324:c7f2:386 with SMTP id m7-20020a4ab307000000b00324c7f20386mr12921515ooo.18.1653487090927;
        Wed, 25 May 2022 06:58:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w184-20020aca62c1000000b0032b99637366sm832463oib.25.2022.05.25.06.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:58:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 05/40] hwmon: (lm90) Use BIT macro
Date:   Wed, 25 May 2022 06:57:23 -0700
Message-Id: <20220525135758.2944744-6-linux@roeck-us.net>
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

Use BIT macro instead of shift operation to improve readability.
No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c | 55 ++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 6728520a21ca..0f3fadc1631c 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -80,6 +80,7 @@
  * concern all supported chipsets, unless mentioned otherwise.
  */
 
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -182,36 +183,36 @@ enum chips { adm1032, adt7461, g781, lm86, lm90, lm99,
 /*
  * Device flags
  */
-#define LM90_FLAG_ADT7461_EXT	(1 << 0) /* ADT7461 extended mode	*/
+#define LM90_FLAG_ADT7461_EXT	BIT(0)	/* ADT7461 extended mode	*/
 /* Device features */
-#define LM90_HAVE_OFFSET	(1 << 1) /* temperature offset register	*/
-#define LM90_HAVE_REM_LIMIT_EXT	(1 << 3) /* extended remote limit	*/
-#define LM90_HAVE_EMERGENCY	(1 << 4) /* 3rd upper (emergency) limit	*/
-#define LM90_HAVE_EMERGENCY_ALARM (1 << 5)/* emergency alarm		*/
-#define LM90_HAVE_TEMP3		(1 << 6) /* 3rd temperature sensor	*/
-#define LM90_HAVE_BROKEN_ALERT	(1 << 7) /* Broken alert		*/
-#define LM90_HAVE_EXTENDED_TEMP	(1 << 8) /* extended temperature support*/
-#define LM90_PAUSE_FOR_CONFIG	(1 << 9) /* Pause conversion for config	*/
-#define LM90_HAVE_CRIT		(1 << 10)/* Chip supports CRIT/OVERT register	*/
-#define LM90_HAVE_CRIT_ALRM_SWP	(1 << 11)/* critical alarm bits swapped	*/
+#define LM90_HAVE_OFFSET	BIT(1)	/* temperature offset register	*/
+#define LM90_HAVE_REM_LIMIT_EXT	BIT(3)	/* extended remote limit	*/
+#define LM90_HAVE_EMERGENCY	BIT(4)	/* 3rd upper (emergency) limit	*/
+#define LM90_HAVE_EMERGENCY_ALARM BIT(5)/* emergency alarm		*/
+#define LM90_HAVE_TEMP3		BIT(6)	/* 3rd temperature sensor	*/
+#define LM90_HAVE_BROKEN_ALERT	BIT(7)	/* Broken alert			*/
+#define LM90_HAVE_EXTENDED_TEMP	BIT(8)	/* extended temperature support	*/
+#define LM90_PAUSE_FOR_CONFIG	BIT(9)	/* Pause conversion for config	*/
+#define LM90_HAVE_CRIT		BIT(10)	/* Chip supports CRIT/OVERT register	*/
+#define LM90_HAVE_CRIT_ALRM_SWP	BIT(11)	/* critical alarm bits swapped	*/
 
 /* LM90 status */
-#define LM90_STATUS_LTHRM	(1 << 0) /* local THERM limit tripped */
-#define LM90_STATUS_RTHRM	(1 << 1) /* remote THERM limit tripped */
-#define LM90_STATUS_ROPEN	(1 << 2) /* remote is an open circuit */
-#define LM90_STATUS_RLOW	(1 << 3) /* remote low temp limit tripped */
-#define LM90_STATUS_RHIGH	(1 << 4) /* remote high temp limit tripped */
-#define LM90_STATUS_LLOW	(1 << 5) /* local low temp limit tripped */
-#define LM90_STATUS_LHIGH	(1 << 6) /* local high temp limit tripped */
-#define LM90_STATUS_BUSY	(1 << 7) /* conversion is ongoing */
-
-#define MAX6696_STATUS2_R2THRM	(1 << 1) /* remote2 THERM limit tripped */
-#define MAX6696_STATUS2_R2OPEN	(1 << 2) /* remote2 is an open circuit */
-#define MAX6696_STATUS2_R2LOW	(1 << 3) /* remote2 low temp limit tripped */
-#define MAX6696_STATUS2_R2HIGH	(1 << 4) /* remote2 high temp limit tripped */
-#define MAX6696_STATUS2_ROT2	(1 << 5) /* remote emergency limit tripped */
-#define MAX6696_STATUS2_R2OT2	(1 << 6) /* remote2 emergency limit tripped */
-#define MAX6696_STATUS2_LOT2	(1 << 7) /* local emergency limit tripped */
+#define LM90_STATUS_LTHRM	BIT(0)	/* local THERM limit tripped */
+#define LM90_STATUS_RTHRM	BIT(1)	/* remote THERM limit tripped */
+#define LM90_STATUS_ROPEN	BIT(2)	/* remote is an open circuit */
+#define LM90_STATUS_RLOW	BIT(3)	/* remote low temp limit tripped */
+#define LM90_STATUS_RHIGH	BIT(4)	/* remote high temp limit tripped */
+#define LM90_STATUS_LLOW	BIT(5)	/* local low temp limit tripped */
+#define LM90_STATUS_LHIGH	BIT(6)	/* local high temp limit tripped */
+#define LM90_STATUS_BUSY	BIT(7)	/* conversion is ongoing */
+
+#define MAX6696_STATUS2_R2THRM	BIT(1)	/* remote2 THERM limit tripped */
+#define MAX6696_STATUS2_R2OPEN	BIT(2)	/* remote2 is an open circuit */
+#define MAX6696_STATUS2_R2LOW	BIT(3)	/* remote2 low temp limit tripped */
+#define MAX6696_STATUS2_R2HIGH	BIT(4)	/* remote2 high temp limit tripped */
+#define MAX6696_STATUS2_ROT2	BIT(5)	/* remote emergency limit tripped */
+#define MAX6696_STATUS2_R2OT2	BIT(6)	/* remote2 emergency limit tripped */
+#define MAX6696_STATUS2_LOT2	BIT(7)	/* local emergency limit tripped */
 
 /*
  * Driver data (common to all clients)
-- 
2.35.1

