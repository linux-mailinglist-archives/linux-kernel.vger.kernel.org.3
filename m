Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562FE560497
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiF2PaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiF2PaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:30:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD8F369D5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:30:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o9so22701205edt.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YM+AbWC19jugmctruXrYCqIRv2YGYgOFFX1PeI35Oss=;
        b=qLIJUtXYkIpODcJfHifnKXFE5qcQQLG2Wz/bg0gL0wYRpBV5vzhEa/8SGXn92FnQVi
         zxGF9NNWYpukQKcGa6B4pPCmoOhxJoyucSAqMfh1MUhOkMT5mJbsNFV0diMjIPWLkKiA
         h6pov3sYNneBYMfnhIXs93GwD58/PB4/+YfVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YM+AbWC19jugmctruXrYCqIRv2YGYgOFFX1PeI35Oss=;
        b=wexNQ7eJSiriYB/TdOCZBtgj5wx5+ct0+xgA9HGMG5l7q1hHPt14wp7ElJqbqRQkwY
         fvmwy6/3Vp4OCqB0pHH7pDFDzdkFvnitwxzqrnRjZtmFH7p0JkOaWTG4/3+xysKZvnWS
         lSru8FvtNpQWqdwpYdKZi86rDesw7QCRZeofeobhL5h56A48P5y7CfTJfxAdkHYh+bxB
         Abfrjyo1UCccXxxmeeNtrZ6+g+5dd2QfRp138D0+teaR4b4ge9p3ahIA+D7lgjZdGLvK
         ConDYL9kKSCZDpJwxFICbALck33Pz8Wy1sVGqkvURABEo8QN/7QizCsbm/QW+uW5meki
         UyPQ==
X-Gm-Message-State: AJIora+QJL+foMAocE9sLv331XKXPjRxsIeO/IFK79ZevZiNq0d2Gsz4
        A3qmGHggDYAeLxQmj/Y5D0k0Xw==
X-Google-Smtp-Source: AGRyM1t76aeDWU3Npw3pikScp+6JZnN5RmrXhyErEib0ezH30zTOHpxmhgthGS8X1vCNZR/EaxGKpg==
X-Received: by 2002:a05:6402:50ce:b0:435:9249:dfe9 with SMTP id h14-20020a05640250ce00b004359249dfe9mr4957862edb.310.1656516600532;
        Wed, 29 Jun 2022 08:30:00 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id h1-20020a1709063c0100b006feec47dae9sm7821853ejg.157.2022.06.29.08.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:30:00 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] media: ov5693: add ov5693_of_match, dts support
Date:   Wed, 29 Jun 2022 17:29:33 +0200
Message-Id: <20220629152933.422990-7-tommaso.merciai@amarulasolutions.com>
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

Add ov5693_of_match. Device tree support

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
Changes since v2:
 - Change patch order 7 -> 6 as suggested by Sakari
 - Add missing signed-off as suggested by Jacopo

 drivers/media/i2c/ov5693.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index 2359b00fc428..ac2ea3238db9 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -1532,10 +1532,17 @@ static const struct acpi_device_id ov5693_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, ov5693_acpi_match);
 
+static const struct of_device_id ov5693_of_match[] = {
+	{ .compatible = "ovti,ov5693", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ov5693_of_match);
+
 static struct i2c_driver ov5693_driver = {
 	.driver = {
 		.name = "ov5693",
 		.acpi_match_table = ov5693_acpi_match,
+		.of_match_table = ov5693_of_match,
 		.pm = &ov5693_pm_ops,
 	},
 	.probe_new = ov5693_probe,
-- 
2.25.1

