Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3BF55C6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbiF0PFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbiF0PFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:05:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C1B1759E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:04:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i1so8994447wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpdfidpXpaazosoDOCbj0RBJV66iHVFwcJEcEN756BA=;
        b=HSNeFexte5YkNrSfmpa24bzpLSXiYVRqoRKgeLPFcCWAvFPnSgrKiQA4645Db6YcDV
         yKY2H+NIK0Yu7fS7aY00WqUc79oeuRg2g2YBRK3zu2E9cePfSRHr5FuecOL0EaoqwyQJ
         R38CdPHI63ndISKRhryCUirI/1ZO7jft5dQEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpdfidpXpaazosoDOCbj0RBJV66iHVFwcJEcEN756BA=;
        b=j16GT28TVSEWpo6ZP3yMghEcZgBao+O/onU3B6Ui6mbl3CUe/LyYH4tC0PF4ZlI1kZ
         ngYuUwzeR5iTw/th0V1maCFBETRhUZSb5QlcCtB3/CveAAD2YPIVWRgBPqtj+pZ+PkPo
         JX5Tna+mIAxBgeofh2JwoVvXV1JiSYLukiW3juFepW5udZOubh+AuvD8WMPfeGKYxjwK
         4Nz6ngiPJ5ihJNUjYCOF7+jgMNBpeeMIAcD2gkWkrzdaFhCZlmW6E/8wGXa4rhv7clKK
         jP5B+oZ7LtFDzGJrBTmikPEDC+GJUEuTXwTOKp8ymgNhOAWBbqLaz5a7SF/dGSNMXpCs
         qlfQ==
X-Gm-Message-State: AJIora8J9oOQumN1xjv3hNJ6eZB+SUD0ErnQS/slngnGThOmpqGpgdiY
        zPV9fBw4PzM1OIzQ7nTlTP6biA==
X-Google-Smtp-Source: AGRyM1ugjMfso+GuSpxwGlBX35ok7y0Cmr7FXEAySzs+qOBy37hvkpgpQ9Zblc9e7HrHHRK7lQqhvg==
X-Received: by 2002:a05:6000:1689:b0:218:3fb1:fd30 with SMTP id y9-20020a056000168900b002183fb1fd30mr12607196wrd.302.1656342298051;
        Mon, 27 Jun 2022 08:04:58 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b0021ba3d1f2a0sm10581250wrn.48.2022.06.27.08.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:04:57 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] media: ov5693: count num_supplies using array_size
Date:   Mon, 27 Jun 2022 17:04:47 +0200
Message-Id: <20220627150453.220292-2-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
References: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcode OV5693_NUM_SUPPLIES in a define is better use
ARRAY_SIZE function to count the number of supplies from
ov5693_supply_names array

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
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

