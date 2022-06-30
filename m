Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FCE561379
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiF3Hpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiF3Hpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:45:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A9636B54
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:45:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sb34so37223069ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZOi0La7XXKtkYx/fp0c768hVBWWCXiluyMMk6qKUzU=;
        b=MOT4Ask04bvtjdcHefCiKgo0uVx8FBvfb4js6ZVh70fYN+94Z+RF5YJakY/9i2yCBM
         8wnt/IcUkrMBUbsEHWYnhaKERUTOtZjDlzGbgPQ8a2LrKyuK+cG+3HJt7g0zNKNsE3m8
         njN62LsIS8zqzUfqokqe15f5n7cKWndXbMiPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZOi0La7XXKtkYx/fp0c768hVBWWCXiluyMMk6qKUzU=;
        b=UYoqVZ1Jr0eWzSMcTgTtQHwRlg0Zc/wGcZBW0khB0VdeC1rg0YLodR44vCKyk9NSZJ
         L0x0lsdOFEsrqPhYQksEpTTnSNmq0rTaZFVQio3kaz490avjdIL1rRXTYN3alTGliR/h
         TAnsOvWJsPRB5jtwLxgTOnLiM1JJOuWLatsWyuosYGQZJjiIvhcgp/n3H835raj2ceIP
         yTDzYN8ESNnlNUVJ1nrU8p/fuarec0PWdKGEXFbCezUOuJ8w9Oud6n8X/FRwIcTJmIAd
         ZcviZenHEbNHCgQslwD9j1aHrS62zDor+je68vnp9OJGkt8o2wfsCkwwyLfzdu+AOmyB
         FyfQ==
X-Gm-Message-State: AJIora8WzLGoTrQQeFpbEKpRtjMvuSoifkKlSgEvBrOUOy1/EX3Kl1XB
        LGG2a/PDCOZvGsgOGnBQgj9Eug==
X-Google-Smtp-Source: AGRyM1vffMug1IlnVp5LGuJQrv0D0KZZCOijptBd51rIvW5fVLabUJ71Ie0xhbQzlqaDGjloLym3ug==
X-Received: by 2002:a17:907:7f1a:b0:726:2b37:7b82 with SMTP id qf26-20020a1709077f1a00b007262b377b82mr7314412ejc.366.1656575130059;
        Thu, 30 Jun 2022 00:45:30 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7c90d000000b0043564320274sm12594731edt.19.2022.06.30.00.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 00:45:29 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] media: ov5693: count num_supplies using array_size
Date:   Thu, 30 Jun 2022 09:45:20 +0200
Message-Id: <20220630074525.481790-2-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
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

Instead of hardcode OV5693_NUM_SUPPLIES in a define is better use
ARRAY_SIZE function to count the number of supplies from
ov5693_supply_names array

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
Changes since v3:
 - Add reviewed-by tag, suggested by Jacopo, Krzysztof

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

