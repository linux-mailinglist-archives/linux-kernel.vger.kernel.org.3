Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF175600F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiF2NKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiF2NKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:10:04 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3938C21A2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:10:03 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id z7so11909191qko.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92nHiG72czsDSt8Vv1MxkfjJxISivqdWpiajRhXOz3g=;
        b=nBVrqAzFrCHqh+zX1QE6OKR/pKbey1MtqrDn2kCoBsw+z8WdUYOgapk12JytD2jKNM
         EV8k0OrLS6OEX1G8Dgwy5hURtD5+IE3r55/n4yWuhXG7Gy4EsfH8iLWlqfzrvA+XD2l0
         TFGJn+NZE1g1+iiZcZLCZoC5+EkLZXP/RcFVauQjtVfyBVb4t0yNF461RJGleV1IPPHK
         zHpU7HBWZGCo5zDx9ZpKbcUS6sbyihwM96PA97Fza3idUW53vRYZdmsJDr12N2M78POL
         TU/fiAq/bPl8tBtkTYLuS+68IjmJc3U0sb5c4BYg3Ua1eEGEF0mMRnf5n9TIkJ/wr08Z
         XC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92nHiG72czsDSt8Vv1MxkfjJxISivqdWpiajRhXOz3g=;
        b=E7V97WD5FaWoADpcy0izf/BMBUFzZYv8CO64RAqSjDl1HrhdAlOgABr+Yvm5i6Q+j5
         s5adWHked8+N9EVwVW55oeT6ovkSIGjGl8SIAwkjRKZ9zDRruTcDXIahB/lpQncPQXY4
         kkssO9H5cabToTp0fy7W8RyMtRbFUN4kacPGVMILDlV0qWqj8TgDpEBKZGh4ew/crNre
         RraeryhhCvNTLbT/Tqf1F+IEBbk9RGV9VhwVZQe5ZWZlNLtqPz1LfRfgaXdSuWEL+6CQ
         3HaisL1GTQf6I/t74iBwBCxxUQ4itcdqMOvJIM8WteOLZRJb3SASR5CfiZkRtnWpXNl7
         ghkw==
X-Gm-Message-State: AJIora+aF0V8Itkzc6G4uqMSWaRmKBsQxv22BFs4LTium3wnzMcf7rZg
        sjafU2LzA2AvDZ2HRM2Batg=
X-Google-Smtp-Source: AGRyM1t0Z0eZSa4UvruI9diFz0lVhGg+3SzNvqqO6ZyxAsMj3XFK/cXBuSO9xt4w8W68TVh2t1mW5Q==
X-Received: by 2002:a05:620a:269a:b0:6ac:665e:1dd8 with SMTP id c26-20020a05620a269a00b006ac665e1dd8mr1913394qkp.636.1656508202059;
        Wed, 29 Jun 2022 06:10:02 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id cj20-20020a05622a259400b002f936bae288sm10751764qtb.87.2022.06.29.06.09.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2022 06:10:01 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>
Subject: [PATCH] regmap: cache: Add extra parameter check in regcache_init
Date:   Wed, 29 Jun 2022 21:09:51 +0800
Message-Id: <20220629130951.63040-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
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

When num_reg_defaults > 0 but reg_defaults is NULL, there will be a
NULL pointer exception.

Current code has no such usage, but as additional hardening, also
check this to prevent any chance of crashing.

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/base/regmap/regcache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index d0f5bc827978..d8c31c8ac4a0 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -133,6 +133,12 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
 		return -EINVAL;
 	}
 
+	if (config->num_reg_defaults && !config->reg_defaults) {
+		dev_err(map->dev,
+			"Register defaults number are set without the reg!\n");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < config->num_reg_defaults; i++)
 		if (config->reg_defaults[i].reg % map->reg_stride)
 			return -EINVAL;
-- 
2.29.0

