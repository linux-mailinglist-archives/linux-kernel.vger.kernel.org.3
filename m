Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC1B56049D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiF2P3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiF2P3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:29:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679A021E07
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:29:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id pk21so33382127ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpdfidpXpaazosoDOCbj0RBJV66iHVFwcJEcEN756BA=;
        b=IUS/tQRV9Xs0sgYfGzsGhha70gjVBz73nkez+m28P78MxPJ1VnIrffUNwQHOD1NfT+
         ApcTOwQaguPZMCwXAqs7FLzkEWj5L3+8to103g1o2rAmze8MxSROnytO0DzP7F/XyhKy
         IF0Kp8RgZkV+gLPO8ejmugKNnzK/fdxR412Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpdfidpXpaazosoDOCbj0RBJV66iHVFwcJEcEN756BA=;
        b=HNWYfK+i4b6aQlvQU+F/3bPXyWh7lE8jLC++JXwCB/cVC9kmsxuk81EoXvclFnrnyn
         pBkIOHbgx3TalFInn29rb0D+PPoFJbDrEzZHpQp699oBjuf2aVGb7usBOrrs6Nz2bZ/0
         sBKgxsmX1piAPxR4YxZ1f/RmkbhA7bzZ8nn0eHbGArR0FienNw+dx+g5XQgE8vVWTuL5
         5A3x3vrX9FhtpON43Tg6gk6xOfMI2zrziBTVl5HZjcsO8NRlYMISQovN9cZukYWe0hfi
         WcT+LnV6OLWTYPkJknpcPAw3VfoJ9/jlCLICOp+Vx0xdymcwwlo2yaxzJaP9GYYx4S5d
         fQEA==
X-Gm-Message-State: AJIora9oMnBgK3Qu8cW6Z+jXg64nazB8hdKwWkxNCZ8ZEfzbvGFlCV8G
        qithj7npeaLHWhlIEzMIKlZzeg==
X-Google-Smtp-Source: AGRyM1u4hDEDe8vTP5yvMrLYpGxV5O1fWsGZEEbyIItQ7ZfOMuq+gWVjiushepTKDboGCuaJ6DmYaA==
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id f17-20020a1709063f5100b0071239458c0dmr3823631ejj.302.1656516583001;
        Wed, 29 Jun 2022 08:29:43 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id h1-20020a1709063c0100b006feec47dae9sm7821853ejg.157.2022.06.29.08.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:29:42 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] media: ov5693: count num_supplies using array_size
Date:   Wed, 29 Jun 2022 17:29:28 +0200
Message-Id: <20220629152933.422990-2-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629152933.422990-1-tommaso.merciai@amarulasolutions.com>
References: <20220629152933.422990-1-tommaso.merciai@amarulasolutions.com>
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

