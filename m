Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D978B51C3DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381334AbiEEP3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381325AbiEEP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:29:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA1912AB7;
        Thu,  5 May 2022 08:25:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 129so2871794wmz.0;
        Thu, 05 May 2022 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yLBoSbardbjKzXlK7cUTAZT7oQyC5cdV78AVWhwvXUo=;
        b=pZrqFtC4+HbRG+ge+WDczNxBseJ4feE/uYnTzO9hxzDIaZilNSNrYCRj0/IPwA7RyJ
         kWj3ye2KT2Bx/Gk4SliLi/FF9EWx8L1vpwFglDHoU0sEZmQw1igNqiusATyeKnobN2l8
         PVS5xR7xDe7Rp++5sK2QGVs7ZOD5agQmTDbgotn0i/GPRvhwicEq1YXeYXjuOiLo88ns
         vB/21VHEjoEuS7GzGcXmuy8gHqYUtIBTeu2WfxBB2MsclFr8U/LrE/nY4pjTjpqUHfZc
         BpcOSsPDFOkPK8kL+Cd0wsLRKJwbtzuUfUycwbejnvRoyjeZb3CvkgyUl/8bGF/qwZSI
         AtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yLBoSbardbjKzXlK7cUTAZT7oQyC5cdV78AVWhwvXUo=;
        b=p7dJ7NxMCCwlsqSkRarieFGudSMOuY/2mn+2JgUAApetPp0G4f/Y0V8try2fI5WWtl
         HT1GPl1ExnSRPu2HEXfzUNdD5nibkxgVkv4d5nkPIuxo4td8tk/aBlGmaSbh1unLUHhb
         223CIg7oOmcPqoCQs+bm9g66u5UpksarRfyvxPgQTQaxyzTRr9OUnJXMXUGCDVW3vGAz
         rzPyygRhXqHw341wSTR47VGW2ce4gzFWL/zbpfFAsomlvUwUTQo+bi6LzzLzMOJ10qA6
         U0z9cyq/Ov8DNHJ4GBqguwOwDYlYBKzvaU0pBixVr3HvpdsA24oATy2grrwsHY7JoWfM
         WDtQ==
X-Gm-Message-State: AOAM5322Ybs1nCx9mdOP0xNSeSev5RgPYHC+iU3SF/eZWy8rjrCOqzIp
        9X3bzRLB4iFRmlNdw6pEvxkHP+ekZii43Q==
X-Google-Smtp-Source: ABdhPJzDQcNtHYCYmlbuo41WROkkbv/6djDeJIgLcpbfEt0FAYFxmgTTdtyOu0RnRK6SgyqXECoQfg==
X-Received: by 2002:a7b:cd98:0:b0:394:2431:2393 with SMTP id y24-20020a7bcd98000000b0039424312393mr5426664wmj.122.1651764332687;
        Thu, 05 May 2022 08:25:32 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600016cc00b0020c5253d8e4sm1578679wrf.48.2022.05.05.08.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 08:25:32 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     pavel@ucw.cz
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/3] leds: ktd2692: Avoid duplicate error messages on probe deferral
Date:   Thu,  5 May 2022 18:25:16 +0300
Message-Id: <20220505152521.71019-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505152521.71019-1-markuss.broks@gmail.com>
References: <20220505152521.71019-1-markuss.broks@gmail.com>
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

Use dev_err_probe instead of dev_err to avoid duplicate error
messages if the GPIO allocation makes the probe defer.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/leds/flash/leds-ktd2692.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index ed1f20a58bf6..8b99742cb68a 100644
--- a/drivers/leds/flash/leds-ktd2692.c
+++ b/drivers/leds/flash/leds-ktd2692.c
@@ -279,17 +279,13 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 
 	led->ctrl_gpio = devm_gpiod_get(dev, "ctrl", GPIOD_ASIS);
 	ret = PTR_ERR_OR_ZERO(led->ctrl_gpio);
-	if (ret) {
-		dev_err(dev, "cannot get ctrl-gpios %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot get ctrl-gpios\n");
 
 	led->aux_gpio = devm_gpiod_get(dev, "aux", GPIOD_ASIS);
 	ret = PTR_ERR_OR_ZERO(led->aux_gpio);
-	if (ret) {
-		dev_err(dev, "cannot get aux-gpios %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, PTR_ERR(led->aux_gpio), "cannot get aux-gpios\n");
 
 	led->regulator = devm_regulator_get(dev, "vin");
 	if (IS_ERR(led->regulator))
-- 
2.35.1

