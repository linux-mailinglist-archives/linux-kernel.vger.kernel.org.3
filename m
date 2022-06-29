Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6055F2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiF2BlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2BlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:41:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DB522BE8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:41:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l6so12644603plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=S2ALH10CiIJ9QarbU1oFFB9yUYMcWtOsqvnVKD2phWs=;
        b=Wtpkw/+ZZca6AButPmm3hgE1RwtlB7vp2QjhuYjzW9XWR5P8J835GNQ9GfSeFSr4Kh
         9A2cK63SET+iyqCW2bFPd0GgSjFj0viFFM2+MD/kKYKPhLzkWvjhdugQsWd5rzaRbZhR
         WCEh+IW2w975E9HgFUnPNMC0N0mXMy8x2LaUP43iNQuvM9XlXEqO3AELxs9RKI29vkfw
         JP1EAjSd8W+1XpcKznqvQBolr6YlNyaYggL+MqqtmWlPs7zAKGVYN9TmisZPAS4OanZb
         MWx8xF5OrGr7gCEKgUbMq2LUGYEbYXjAZ1AkOm1OsQsbh2/HTf8eNDPVqCiBGnLWX2dV
         /pdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S2ALH10CiIJ9QarbU1oFFB9yUYMcWtOsqvnVKD2phWs=;
        b=BZ7vhfRETmYvl/32zoGJGzwWb/0v4S+bsIvZrDKazVU/hYypyPy22zfVVU3wLb5B3c
         S5xlgik/JTGnk7QWptINKU9urMegxEla3FHanxhHGKtJDAlTCeuPb4tZmJW0cm4k5Rf2
         NDSCkiYYeffEFAxmPHCyO04wCM+O7RpWeWnaSnWgjPU2C7EMmZiZQqnkEwTQOSHB9Z3/
         J5wiA3I9zf3ANTZZgOMAh5d0qr2K+jRbycnFokjrxgfbB/FORBox7lbL5qCjKlwzF3nd
         KxUu4QY+VMoYIoquxwtMcPM9xkVLK8EkJ/3vDJ+4QyJE5bf/SU2/qt98A5aXxzxO5UNj
         MGfA==
X-Gm-Message-State: AJIora+81z73JzF3IMyAoRusaDLxrsggh8lsxvl55iVABdw4KGZwwpHB
        vt/Qwh2PtRcwT1GducVyyWF69E8q/pf3vg==
X-Google-Smtp-Source: AGRyM1v8CXE6gypzs36wg8Rh/T42PFlavrif+6TTtAf/MYaXBleCdFPsSq11fHsVxknSlLyhqjDIcA==
X-Received: by 2002:a17:902:ab87:b0:16a:82a9:feb7 with SMTP id f7-20020a170902ab8700b0016a82a9feb7mr8011328plr.37.1656466869173;
        Tue, 28 Jun 2022 18:41:09 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46a:3e21:914b:bb3e:3e56:4806])
        by smtp.gmail.com with ESMTPSA id u15-20020aa7838f000000b0052592a8ef62sm7182965pfm.110.2022.06.28.18.41.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 18:41:08 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, matthias.bgg@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH 1/2] regulator: mt6370: Use 'fwnode_gpiod_get_index' to fix gpio parsing
Date:   Wed, 29 Jun 2022 09:41:00 +0800
Message-Id: <1656466861-7737-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

From the common binding, 'enable-gpio' or 'enable-gpios' are all well
for external 'enable' gpio.

'gpiod_get_from_of_node' only parse the 'enable' property, it need to
add the gpio suffix. It's more convenient to use fwnode_gpiod_get_index.
Although fwnode parsing is not preferred, but 'of_parse_cb' already can
guarantee the callback will only be used by regulator of_node parsing.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/mt6370-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6370-regulator.c b/drivers/regulator/mt6370-regulator.c
index bc356b4..949b2c7 100644
--- a/drivers/regulator/mt6370-regulator.c
+++ b/drivers/regulator/mt6370-regulator.c
@@ -153,7 +153,8 @@ static int mt6370_of_parse_cb(struct device_node *np,
 	struct gpio_desc *enable_gpio;
 	int ret;
 
-	enable_gpio = gpiod_get_from_of_node(np, "enable", 0, GPIOD_OUT_HIGH |
+	enable_gpio = fwnode_gpiod_get_index(of_fwnode_handle(np), "enable", 0,
+					     GPIOD_OUT_HIGH |
 					     GPIOD_FLAGS_BIT_NONEXCLUSIVE,
 					     desc->name);
 	if (IS_ERR(enable_gpio)) {
-- 
2.7.4

