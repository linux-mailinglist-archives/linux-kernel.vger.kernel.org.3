Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550184ACBE4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbiBGWNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbiBGWNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:13:23 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56424C061355;
        Mon,  7 Feb 2022 14:13:22 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a25so21729040lji.9;
        Mon, 07 Feb 2022 14:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wdbWjM8eoz1rtM3sTLi8IH/lKU9rb0SeE8VSMizMzlI=;
        b=O781Yilo70eyNuBaD3ol/8LC5JHsl6oyoxnIJZ/zGE7Plk/6adJoGSPpbPCP7D4Snx
         qtievuPLVZOVevfBTXXnABJK4J1jN4/fc3XFPt5EV7aggTBqi5BMtIgkKseCLSMTs4HD
         DQoQsRqlgxIHQ8flNQ1Ouv/gqIHkiZJlB8G6y6wBmA/sfki0+diNoZJ09ymYOIzBJp6e
         MuYi9AwYJ9YNdKnV7A1wTopgfVSSUEUGH9ZaqCW4wpGksJ/W1ushd/4PjH2J2GbrTDr0
         VQdpCzNcMPBJQbh/usgOu96tmFUw2sllNwMbRZGNtB4YqLbDjeQrMTzCD4syKNejfHTe
         XOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wdbWjM8eoz1rtM3sTLi8IH/lKU9rb0SeE8VSMizMzlI=;
        b=ADlLwMCvSb6EBcXUVIV8D+tNIfP1fs0IWQfxCNFAsuJUS1YsFCQPvm7/r4y0ve678M
         yj6GsM9ivGBr/666VILLc8ThgSkdWPfWmA9uQYOR08shvoUJGrgcbSTB4TqyKvdxZQWi
         0CxFyDKtN0JaezBF3doIz4izYqfRfn9xUzJbhVBC7Nug5ZmjlQamoUaccm1w36LIXhWh
         skipzIHeCFM0k2VWPOHrjuaalzYllK5FL9EDcEIABgiv2OCJCKLPpw59wDkGplbbEbjH
         nVhHkZMWf9SjYZYxH20vKbmKn3ZSI+qcVN8GXbAtRIvnZEtwVL65mxVJk9anD+aKV0hG
         yztg==
X-Gm-Message-State: AOAM533M1zA/dJkA0UFPuNQCSNSOigBhUAo4e9R6cm54FeN+89Ad9N/x
        X8N97v9vaXFimYpqZynKVuw=
X-Google-Smtp-Source: ABdhPJw8Da4PWG2Lr6PzhVtKx/qzH1WM4bMJfczUsdOChFZM32xp1YwyIDy7SqYdPPn3IRYIkeQ3yA==
X-Received: by 2002:a2e:9090:: with SMTP id l16mr987967ljg.366.1644272000720;
        Mon, 07 Feb 2022 14:13:20 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id o17sm1662503lfl.16.2022.02.07.14.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:13:20 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Marc Zyngier <maz@kernel.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] sh: mach-x3proto: Constify static irq_domain_ops
Date:   Mon,  7 Feb 2022 23:13:14 +0100
Message-Id: <20220207221314.97788-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.35.1
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

The only usage of x3proto_gpio_irq_ops is to pass its address to
irq_domain_add_linear() which takes a pointer to const struct
irq_domain_ops. Make it const to allow the compiler to put it in
read-only memory

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 arch/sh/boards/mach-x3proto/gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3proto/gpio.c
index f82d3a6a844a..dd8ef41e5562 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -91,7 +91,7 @@ static int x3proto_gpio_irq_map(struct irq_domain *domain, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops x3proto_gpio_irq_ops = {
+static const struct irq_domain_ops x3proto_gpio_irq_ops = {
 	.map	= x3proto_gpio_irq_map,
 	.xlate	= irq_domain_xlate_twocell,
 };
-- 
2.35.1

