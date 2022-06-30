Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765D7561BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiF3NuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbiF3NtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:49:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC233347
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:48:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eq6so26599556edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jE26kz8uLkTSQmG0BFSrQuTDJo25o/aqMTxY60BA87o=;
        b=TjBJe4l27BlUK69/w9aTMBarDu8Hu5rsMI3YPuojTUPjti+DtWbeez4JTqjDFoBeCC
         4CZtxGHVq2VnWJD5DvM38qcux3B8HyI9Xg8OrP2idCpv7Mwz/L87esvTQcbeW5IV5aEh
         kXb0aqoVsHj1slf6mWtRUMYv8iIKOck2Jf5sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jE26kz8uLkTSQmG0BFSrQuTDJo25o/aqMTxY60BA87o=;
        b=n9Gy9M6adqUNcwSPXAOMQHu358zsiaWA1mGYNkPuI9B4R7RyXlAOJ2/Hd0wuJRdPFS
         Hy7w+oSRSgQqKoXvfzpWO8pbR3VbYA4uySVStmcKJ7jMr0src/lzEry2UXX+1+pxGRnB
         GU2k+Imy3AUQyMxvIUD1INe/clEZb3f+aK0/C7TUO1cscfB3SqPRf748ds4Ud9uQ7Waq
         y6ih8DrDzkwa5JtMvcctwM1CanyP42FbKR+k5EFdhCP7n8aCEKSOmZHgnRZIWLzK+VgY
         6yVUc1XBoHbgH1fSNa1E9NCYwST8kRY31TrjIcKYEZzIDbHUpOVqrt5QyKGb9XnQIYGs
         c7qw==
X-Gm-Message-State: AJIora/LPmh/JrP0lHyhlbeLJdjFzpu0jWqcdIbXjmDZAltZeca0X8+C
        yXxSzUhT/kdh6/tg565NFU+gygeTCBaPrg==
X-Google-Smtp-Source: AGRyM1vAypfxHpAD8WCEQkT4NzUt3sIuZbwI6E+sDAaDx0HZ1xtmOpSsPyY7FmDUDbKMZmjj//OAtQ==
X-Received: by 2002:a05:6402:40cc:b0:435:912b:257a with SMTP id z12-20020a05640240cc00b00435912b257amr11702414edb.380.1656596921341;
        Thu, 30 Jun 2022 06:48:41 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709067ac500b006fee526ed72sm9130288ejo.217.2022.06.30.06.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:48:41 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] media: ov5693: count num_supplies using array_size
Date:   Thu, 30 Jun 2022 15:48:30 +0200
Message-Id: <20220630134835.592521-2-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
References: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcode OV5693_NUM_SUPPLIES in a define is better use
ARRAY_SIZE function to count the number of supplies from
ov5693_supply_names array

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Reviewed-by: Daniel Scally <djrscally@gmail.com>
---
Changes since v3:
 - Add reviewed-by tag, suggested by Jacopo, Krzysztof

Changes since v4:
 - Add Daniel reviewed-by tag

 drivers/media/i2c/ov5693.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index 117ff5403312..f410333c4c67 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -127,11 +127,15 @@
 #define OV5693_LINK_FREQ_419_2MHZ		419200000
 #define OV5693_PIXEL_RATE			167680000
 
-/* Miscellaneous */
-#define OV5693_NUM_SUPPLIES			2
-
 #define to_ov5693_sensor(x) container_of(x, struct ov5693_device, sd)
 
+static const char * const ov5693_supply_names[] = {
+	"avdd",		/* Analog power */
+	"dovdd",	/* Digital I/O power */
+};
+
+#define OV5693_NUM_SUPPLIES	ARRAY_SIZE(ov5693_supply_names)
+
 struct ov5693_reg {
 	u32 reg;
 	u8 val;
@@ -352,11 +356,6 @@ static const s64 link_freq_menu_items[] = {
 	OV5693_LINK_FREQ_419_2MHZ
 };
 
-static const char * const ov5693_supply_names[] = {
-	"avdd",
-	"dovdd",
-};
-
 static const char * const ov5693_test_pattern_menu[] = {
 	"Disabled",
 	"Random Data",
-- 
2.25.1

