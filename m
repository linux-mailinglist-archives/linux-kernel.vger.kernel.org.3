Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E784B00F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiBIXIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:08:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiBIXIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:08:37 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44835C1038D3;
        Wed,  9 Feb 2022 15:08:39 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id u20so6857704ejx.3;
        Wed, 09 Feb 2022 15:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4p8pNRxlbLuMm4Zivi3qzSEX1/XkIY61NA/5+SHRUE=;
        b=GDYxvemGi17tsPt1GHWDoNRw66clseUB/uO4JIWKzcCvACwk7HeYNGUjzr9gF/r+34
         eokR8lDNNgUFUow8mSzalfpAwEEKYT5s+6cJkAgS0WPHkXrLCayerlj9gqGZyRhbyJ9c
         Kkh1Nn0F9k3ZSNs6JclkgcfF9VoezFI94Cbd47KKdbNc7x8LNwgLNUduDGO7MXYdPRNj
         mgQaWn2dp5tfZiAMJ/4xDkI5OBEkHvWf76tsHA1n0JC98vRlE2ApQpW4XqQ9IWnxbYD7
         Xfz8I4qO84SPDv3k6Ca8/xSEHdkVHG+oxupGQNyYW69y7h0swqc4vFeNQ1koDdkhkuIa
         425A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4p8pNRxlbLuMm4Zivi3qzSEX1/XkIY61NA/5+SHRUE=;
        b=m8iJxXa3IfkYRYt8fTBHPY1gHbwDH4Ydp9ct0mqY30Ohbnv5RQzw2WFa4vcjwDk1EU
         eQ/PP3InvFFJ0h6RlvTqypJ/WZjau2Uc1eImAmn8OJ0RBh+WYno+QRKN21R/cgZNeMBa
         6+FVCjZnKy18QxkN0xYg4mmXLw0bFDNn+GskfSKUdlXw9pnLyGRVNbsIz88gzHWjqsXt
         7W1WUbgsuluLV1CGC6CxpQ5Yo0iXFRTBS5LseNjVpeLXSW1szwCuv+c46SSlpsGd1Vwk
         BCNNwCwnlO0O1MMnbL2WG8DbhJytnZvJFkLRTtzMH3HTCrMvRXFaGrOZ3C6JMvB8cT13
         bhdA==
X-Gm-Message-State: AOAM530s8okMCZTMPm1yNsCuAUEFsra4eliLooooLyJkQgHVIXKivnz/
        FF2OGhZCA0mrgxPxi7Ro6Ms=
X-Google-Smtp-Source: ABdhPJwIG5feFVw1N3Qa7gtwNXlORasD8MGuGnqIF/J4wiv9+LUWW4IWxnx659skrjQsuDPh5l3Lbg==
X-Received: by 2002:a17:906:7812:: with SMTP id u18mr4078755ejm.335.1644448117785;
        Wed, 09 Feb 2022 15:08:37 -0800 (PST)
Received: from localhost (92.40.202.147.threembb.co.uk. [92.40.202.147])
        by smtp.gmail.com with ESMTPSA id p1sm6136112edy.69.2022.02.09.15.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:08:37 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, linus.walleij@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: ingenic: Fix regmap on X series SoCs
Date:   Wed,  9 Feb 2022 23:04:54 +0000
Message-Id: <20220209230452.19535-1-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X series Ingenic SoCs have a shadow GPIO group which
is at a higher offset than the other groups, and is used
for all GPIO configuration. The regmap did not take this
offset into account and set max_register too low. Writes
to the shadow group registers were blocked, which made it
impossible to change any pin configuration.

Fix this by pretending there are at least 8 chips on any
'X' SoC for the purposes of calculating max_register. This
ensures the shadow group is accessible.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/pinctrl/pinctrl-ingenic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 2712f51eb238..9d2bccda50f1 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -4168,7 +4168,10 @@ static int __init ingenic_pinctrl_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	regmap_config = ingenic_pinctrl_regmap_config;
-	regmap_config.max_register = chip_info->num_chips * chip_info->reg_offset;
+	if (chip_info->version >= ID_X1000)
+		regmap_config.max_register = MIN(8, chip_info->num_chips) * chip_info->reg_offset;
+	else
+		regmap_config.max_register = chip_info->num_chips * chip_info->reg_offset;
 
 	jzpc->map = devm_regmap_init_mmio(dev, base, &regmap_config);
 	if (IS_ERR(jzpc->map)) {
-- 
2.34.1

