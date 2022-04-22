Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7226150B34E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445662AbiDVIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiDVIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:55:43 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F4BDF8D;
        Fri, 22 Apr 2022 01:52:51 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id dw17so5550365qvb.9;
        Fri, 22 Apr 2022 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FgfsY8zghdIG3MG6NzB7iJnFEqL6mHjUuEcnrb0A+gk=;
        b=ZMpEuRGUztjIkzmlf7oB+UK9QofUKnNk+tXjW6udoH3EEZFEQxLbvaF6nVTUrTT4Zm
         zKx+NWpJfvGOdwaVUs17OIQUargX7cxwGAfl/K0SYtvSQCbLHRHWdM5Z2LA8z/P+xvoL
         En9tumKOVEWP7hU8sgSdfLglZ8Lq0OpFwA6kKc88Gilwk2yX/hHgAL2b6nyoUqa27dY9
         /fcnwNrC5N3icEG+T2FeDpZKlej4sR7M4mol/zOzDHUECosW5Pq5GVGZ4RMj2igf8YcT
         9krOoqK6msBcbfyatQSG/pFrcda3YSOPokjJY8ggOW5eTZEhTIkQYW1ZAN/Xw7WHoKkw
         hnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FgfsY8zghdIG3MG6NzB7iJnFEqL6mHjUuEcnrb0A+gk=;
        b=IAnGI+sAUvC/evDHd9w92+IJf7zWPxCOL2pwGFC6ff8u5WsMWjMrY1YdU/fu6oeBfc
         HHGy+9+J1Bu1w7Vf3dF4MGRzxLKIbt7GH++9qzS8i4D6/FaWoWthdM9i1bTm8IAUGZBq
         uWIIQGnMM/Vu7bHGCovF1SH45GND8knxpcJ0oeZPXBXG3odJ5d7EO+LYk//UmIIJ+kvz
         Lvgs/3fiobj/Jy6alNi8kCrk/O6gNDcDGDOQCgkMABllDKrKb69tpRzWUTkarv6wOn0h
         MQpQh2GL5J61GSkTP6n7qFrQ/iinvOFT6M05FRrsl8PRjZ1NfskLH8NUOOcmid0TC3zN
         XzhQ==
X-Gm-Message-State: AOAM533+odBCOcRYy7EVUuc92Z7/nm4pxQgFz+RSFAhJb2UrkF23+g7G
        xpAUypnTGGyraaCspSgaxcc=
X-Google-Smtp-Source: ABdhPJzOgS3R+dSdsTo0h6O0xrZ6YNYOUA5+cd+v7WRcuC2/opB0Uf1StsM4PMQPU1cnX9lBx7FTdw==
X-Received: by 2002:a05:6214:62c:b0:452:c77b:a242 with SMTP id a12-20020a056214062c00b00452c77ba242mr801280qvx.77.1650617570538;
        Fri, 22 Apr 2022 01:52:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n11-20020a05622a11cb00b002f344f11849sm878762qtk.71.2022.04.22.01.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 01:52:50 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     linus.walleij@linaro.org, govindraj.raja@imgtec.com
Cc:     Damien.Horsley@imgtec.com, abrestic@chromium.org,
        ezequiel.garcia@imgtec.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] pinctrl: fix error check return value of irq_of_parse_and_map()
Date:   Fri, 22 Apr 2022 08:52:40 +0000
Message-Id: <20220422085240.2776527-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

Fixes: 	cefc03e5995e ("pinctrl: Add Pistachio SoC pin control driver")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/pinctrl/pinctrl-pistachio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index 8d271c6b0ca4..ff34f9755368 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -1374,7 +1374,7 @@ static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
 		}
 
 		irq = irq_of_parse_and_map(child, 0);
-		if (irq < 0) {
+		if (!irq) {
 			dev_err(pctl->dev, "No IRQ for bank %u: %d\n", i, irq);
 			of_node_put(child);
 			ret = irq;
-- 
2.25.1

