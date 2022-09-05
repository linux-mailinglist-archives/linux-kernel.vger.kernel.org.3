Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD665AD4C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbiIEO2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237410AbiIEO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:28:20 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C389B3FA2B;
        Mon,  5 Sep 2022 07:28:18 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1274ec87ad5so6876889fac.0;
        Mon, 05 Sep 2022 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=359GYAs8ZQEGiA1yrYxZIQU/fxEBZPO4MtR/BpyF6no=;
        b=QyJFjImVHKsFUXcuEIIxm1QBZ6F5WX/sHOSmuzUtlr7sTml4xZKCgKOO7zx7Jk+Htw
         BO4UtvlsksDPUVqRFqYs5ZgYZs2NfeiggcrHWuXYiupRw/nBnH9ITxLunEOSgwFwSQoz
         7/ul3szHj/K7Cs5EUX2YBb4jA2uHox1GEzBIJBnmeoD0rPU+1CkdylgmM0pq3Ll+9tPh
         dTRatdeCu20FF0XRjrgx5yE8W1f/qMGA3P5J4PTaOInPp/wvkKroObu4FbyONwui9nY+
         AMnDCuUgOdNpAKTw2s+SeosJ9nVsYeblfBCY/t4MppNVlUHdwzrmmR18mkylj52Ez+G7
         spvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=359GYAs8ZQEGiA1yrYxZIQU/fxEBZPO4MtR/BpyF6no=;
        b=OHtBGqIt8E05MhLNzJ57RzAed6vQje+fYIKKDpGvHAbeftcsqOnkvtsdXV1Wa2ysJk
         ljqxN8mlB1/S9VbHssUPi3emUi2/Ae3E0b4p81fBaYZb3mv0ERp8AUPsZho7l9zRP7jV
         T2h1JKeLbBSU/pnJVw24k/GH3kdXkso2DE8M/IcNfrFVM8aAucSjPX3XOq36y+TJtcF3
         +jkG65XyR9Owsdhr7bUEMmposGybt9j0tbjN54V9wtqSMDn4AHbt4JnLbAe9OI4QYRJ4
         9XQG/MfvXA2UtzmLQ08uIZBcs94UG8yPLA7NDQDnq3SsCLO0Xz7xhhGCrQhzuRK9sJDn
         cWpg==
X-Gm-Message-State: ACgBeo0zdAAEkTVXXJ8F7m2+7j8VLPO94T7eiOCu3WUwMBpNPtRcjM7j
        rLSaYU0z0P5fZMHtgEhjLaY=
X-Google-Smtp-Source: AA6agR7xyR6hB8JevrvQf8wyYBdY4Sel0VtguifE5c4gFkRg8a2F7bTnIBsszN4WNHnZGevuvaUr+A==
X-Received: by 2002:a05:6870:96a9:b0:126:dbc4:76db with SMTP id o41-20020a05687096a900b00126dbc476dbmr4334147oaq.174.1662388098088;
        Mon, 05 Sep 2022 07:28:18 -0700 (PDT)
Received: from nuclearis3.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id n17-20020a056870241100b0011f00b027bdsm2052857oap.45.2022.09.05.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:28:17 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     robert.marko@sartura.hr, luka.perkov@sartura.hr, jdelvare@suse.com,
        dev@aboehler.at, linux-kernel@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH 1/3] hwmon: (tps23861) fix byte order in resistance register
Date:   Mon,  5 Sep 2022 09:28:04 -0500
Message-Id: <20220905142806.110598-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tps23861 registers are little-endian, and regmap_read_bulk() does
not do byte order conversion. On BE machines, the bytes were swapped,
and the interpretation of the resistance value was incorrect.

To make it work on both big and little-endian machines, use
le16_to_cpu() to convert the resitance register to host byte order.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/hwmon/tps23861.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index 42762e87b014..f7c59ff7ae8e 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -493,18 +493,20 @@ static char *tps23861_port_poe_plus_status(struct tps23861_data *data, int port)
 
 static int tps23861_port_resistance(struct tps23861_data *data, int port)
 {
-	u16 regval;
+	unsigned int raw_val;
+	__le16 regval;
 
 	regmap_bulk_read(data->regmap,
 			 PORT_1_RESISTANCE_LSB + PORT_N_RESISTANCE_LSB_OFFSET * (port - 1),
 			 &regval,
 			 2);
 
-	switch (FIELD_GET(PORT_RESISTANCE_RSN_MASK, regval)) {
+	raw_val = le16_to_cpu(regval);
+	switch (FIELD_GET(PORT_RESISTANCE_RSN_MASK, raw_val)) {
 	case PORT_RESISTANCE_RSN_OTHER:
-		return (FIELD_GET(PORT_RESISTANCE_MASK, regval) * RESISTANCE_LSB) / 10000;
+		return (FIELD_GET(PORT_RESISTANCE_MASK, raw_val) * RESISTANCE_LSB) / 10000;
 	case PORT_RESISTANCE_RSN_LOW:
-		return (FIELD_GET(PORT_RESISTANCE_MASK, regval) * RESISTANCE_LSB_LOW) / 10000;
+		return (FIELD_GET(PORT_RESISTANCE_MASK, raw_val) * RESISTANCE_LSB_LOW) / 10000;
 	case PORT_RESISTANCE_RSN_SHORT:
 	case PORT_RESISTANCE_RSN_OPEN:
 	default:
-- 
2.34.3

