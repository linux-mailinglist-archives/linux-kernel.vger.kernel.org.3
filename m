Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1422C50CECE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbiDXDRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiDXDRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:17:38 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E62C645;
        Sat, 23 Apr 2022 20:14:39 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id fu34so8243506qtb.8;
        Sat, 23 Apr 2022 20:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LiTHk6NYHNcjkgsXWwU3xj8DtzjqIh0k2tmc7NARpz0=;
        b=KygCetfNjkeYazf3O4/Mj6Yz13JZzut3isY4oLR5c6cyHrkZJdx9/OA2WMzoj66swY
         paSqWgQDfBN0TyBrM7ImD40b7VUuMjzus0D5qrVETABJG1RVIqVdHAGzQlOnsaY8AqdZ
         5lPSVtO6JQXq4LrwpkcDsSH0/S5K1LddfVws74fq9MfGXYDjcqeqtw/ttU5+ZtIN3MPh
         o/R3moy4tlZZxe/lgj0zbhiDZizLSqHJPbgQMEnSaM7tUimiCS94B2Mu26Yo7BhB5x1N
         cLPl7kipzy6SiN9YhdjHR41Njdw+GTRCtxo2aIRbFLlfEBM6FnxqyVP2b7hShRfwZUmE
         PsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LiTHk6NYHNcjkgsXWwU3xj8DtzjqIh0k2tmc7NARpz0=;
        b=lPfW1vSjCByGBM8kKb2j99+/FTgHE/O1mjHc+AlDva9MOdw1cf+osqFBPkyUjvq0Yo
         9zH+jJXsJoC8ixRj8vJQma492QfJA5klGlDPM2e6SriMBvOO/M6abH23kLpcVBmzfytl
         5FrV2q8xfjEnrXklsm0u4WfLZIut3q0wlCXff8DdbrxApqstuSX2VDS4OXHbPTbuSfM/
         yY8xAwtu94fxRSrLKwz/llPI1ur+sC9oQ5yFa9K7lHD2XB+2qT0EEVYkVnFyUb51Zjl3
         P/PHAlpu7TMZ3P/ofCy6jXfBSupPZ8t/VI3LxeueorH03KzK8oOi0AXA6G5tNqnO2Qum
         DYmg==
X-Gm-Message-State: AOAM5316Hi3L5BzFJ4YgA5GXrIT4tnYYC5KgMYX8B9hoR7uVEBIrG6NM
        IKDwnvfFdd38o77gtjWV6JM=
X-Google-Smtp-Source: ABdhPJx+eomGSWkTG/JdLAzmB9ga3m8aGQ/EvPaTksvvC50EOGHsffaXEHTziAmC3Ly3P6cn9eGbxg==
X-Received: by 2002:a05:622a:1647:b0:2f3:6077:bffb with SMTP id y7-20020a05622a164700b002f36077bffbmr3416779qtj.462.1650770078291;
        Sat, 23 Apr 2022 20:14:38 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id cr24-20020a05622a429800b002ed12cea2cdsm3584317qtb.96.2022.04.23.20.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 20:14:37 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     cgel.zte@gmail.com
Cc:     Damien.Horsley@imgtec.com, abrestic@chromium.org,
        ezequiel.garcia@imgtec.com, govindraj.raja@imgtec.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lv.ruyi@zte.com.cn,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] pinctrl: fix error check return value of irq_of_parse_and_map()
Date:   Sun, 24 Apr 2022 03:14:30 +0000
Message-Id: <20220424031430.3170759-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422085240.2776527-1-lv.ruyi@zte.com.cn>
References: <20220422085240.2776527-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

The irq_of_parse_and_map() function returns 0 on failure, and does not
return an negative value.

Fixes: cefc03e5995e ("pinctrl: Add Pistachio SoC pin control driver")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
v2: don't print irq, and return -EINVAL rather than 0
---
 drivers/pinctrl/pinctrl-pistachio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index 8d271c6b0ca4..5de691c630b4 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -1374,10 +1374,10 @@ static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
 		}
 
 		irq = irq_of_parse_and_map(child, 0);
-		if (irq < 0) {
-			dev_err(pctl->dev, "No IRQ for bank %u: %d\n", i, irq);
+		if (!irq) {
+			dev_err(pctl->dev, "No IRQ for bank %u\n", i);
 			of_node_put(child);
-			ret = irq;
+			ret = -EINVAL;
 			goto err;
 		}
 
-- 
2.25.1

