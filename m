Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91473533EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbiEYORx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbiEYORq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:17:46 -0400
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.146.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20C79C2D2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:17:45 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 49D67498BB
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:57:22 -0500 (CDT)
Received: from 162-215-252-169.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id trVpndlkveI1itrVqnlNWg; Wed, 25 May 2022 08:57:22 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jkeP4GwJvBOCaJylAO1wG73yjst6A2ktNXJqi4BU/pY=; b=zZjw13T48cCmm81iMvjrpUCyN5
        DreKojrvdZSDM+Z2N/ys8sbsxd6X4TrEoAJKkpW5fZru/M7sXCQ2h4yggt0CaC4Tvt7ZYwEeSDFF6
        THiJi9eGrSjUnYczjpeTUjdKCJ9UwfjS6ojxhE4grPaiiA0SK4qAvDvoMYHLyf4/HgaNwweJ/OeM/
        0ZBRs9QqAsLOvI2N7C0mwW6+CZaXaweDbK/i+wtw/HxBGOmdRrvvLyYf2A9PcVr2RSIf0dbiDoz2U
        Zirs+AuqQIiw8somqPsW9VYj2HT//86tMZRd5okmMT4yttT1D32INVkPXgB0oVHrwZnPblPjaSXeg
        ThHA3cJw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58274 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1ntrVp-000PAM-KV; Wed, 25 May 2022 13:57:21 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 05/40] hwmon: (lm90) Use BIT macro
Date:   Wed, 25 May 2022 06:56:34 -0700
Message-Id: <20220525135709.2899592-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525135709.2899592-1-linux@roeck-us.net>
References: <20220525135709.2899592-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1ntrVp-000PAM-KV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:58274
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 23
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

