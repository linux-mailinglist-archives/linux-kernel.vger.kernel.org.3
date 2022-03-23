Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0514E525C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbiCWMnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiCWMnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:43:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0407E7B56D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:41:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r13so2582298ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9q5ZrmCokPC9Z7aa+GyRBFxvGpy5QI7QHPk6WFQeE0M=;
        b=Zx3FPQO5Pfom62MHOXFBrl64+TkzH3F2U669lkfasjC11tVbYCWhl+/77hdZpHW3HW
         iFG1x7z+lA0SpUvLm1hHZ8OYGkMIv3aGdEJ5gHzMDZK04Wi1nZnDQBmX9T+NIcEg1vQj
         itML3nEsEqaNgISKf15fp5CJ0wCkJlUtSpSj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9q5ZrmCokPC9Z7aa+GyRBFxvGpy5QI7QHPk6WFQeE0M=;
        b=ltqdbFuFBwz4M+IbZaCfWtueqHlH662NvMT0h1Wb1l7Nkzrelh0/EqvjXgRBU0ag7H
         HwD4hlFdG+7+oWgXCXMOia7r2W1/zMjYgr43/OZkQJdF2Ii/b3SiQDhv6idvVY4kbLqX
         bUQqTWTi1lpqH9FXXHfXwbETYbRPEXRwMeyBEgkh7ozRLFMshVsMjpAUIGLVqZKXRHLU
         kzz36UekSjExihn209iTCjeNTOX/6AMmNaDewpA8+bhLFeD+XGIbN9+mxZdkyvuSwhJZ
         pynYzi/NWhsf6dDniQgY0uKb+EVmrLsMezWFtTFblYmozW6IVHshBxwAwyQWAFmaDN4F
         XA1Q==
X-Gm-Message-State: AOAM532BZYTxyL8FmsUEsN+I256YQLRFW3nndX4D20PQyUWpGqle5BRn
        k2xy8KCTjwe20IrWy4JHtc/ezA==
X-Google-Smtp-Source: ABdhPJzh6y7QzcDdSiCG83MPvyvc0Nv29zmMPcPFTu+6qrbD3YKQb8M3tLFElBn55Jw5T5H8an4MMA==
X-Received: by 2002:a17:906:c344:b0:6b4:c768:4a9a with SMTP id ci4-20020a170906c34400b006b4c7684a9amr32011159ejb.151.1648039303495;
        Wed, 23 Mar 2022 05:41:43 -0700 (PDT)
Received: from capella.. ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7cfcb000000b0041902ac4c6asm8888597edy.1.2022.03.23.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 05:41:42 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: realtek: make interface drivers depend on OF
Date:   Wed, 23 Mar 2022 13:42:25 +0100
Message-Id: <20220323124225.91763-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The kernel test robot reported build warnings with a randconfig that
built realtek-{smi,mdio} without CONFIG_OF set. Since both interface
drivers are using OF and will not probe without, add the corresponding
dependency to Kconfig.

Link: https://lore.kernel.org/all/202203231233.Xx73Y40o-lkp@intel.com/
Link: https://lore.kernel.org/all/202203231439.ycl0jg50-lkp@intel.com/
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/net/dsa/realtek/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index b7427a8292b2..1aa79735355f 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -12,6 +12,7 @@ menuconfig NET_DSA_REALTEK
 config NET_DSA_REALTEK_MDIO
 	tristate "Realtek MDIO connected switch driver"
 	depends on NET_DSA_REALTEK
+	depends on OF
 	help
 	  Select to enable support for registering switches configured
 	  through MDIO.
@@ -19,6 +20,7 @@ config NET_DSA_REALTEK_MDIO
 config NET_DSA_REALTEK_SMI
 	tristate "Realtek SMI connected switch driver"
 	depends on NET_DSA_REALTEK
+	depends on OF
 	help
 	  Select to enable support for registering switches connected
 	  through SMI.
-- 
2.35.1

