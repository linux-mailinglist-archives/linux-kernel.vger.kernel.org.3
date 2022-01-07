Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470A9487178
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345917AbiAGDwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiAGDwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:52:05 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EB6C0611FD;
        Thu,  6 Jan 2022 19:52:05 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id i30so4392422pgl.0;
        Thu, 06 Jan 2022 19:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VV2PQ7PmQhWzfQWCU4GSl8RsFiXS5v11ANHvanOzj28=;
        b=iNHuZh13Y7Zymb9vn8Bmeklqg1VbkDF23eULhbAN+956ElilZviAAE47gg5fq8/Hty
         C7yIhGaL3+orDLFH8i8Q76Qqw3/bt2BA524wMceBA2lYsgPy0B0S86Bw/jaQBE8qt6hO
         b5PUcSS6zokWWSJ8iE/Z3E05iI8zcHHIkXBHyGRgJQ+5EDwx/uQl8qAKhYnz1nO7/jC/
         k8tqxKWPpUVzFqxQNWyjQG08LRPsSb/bz49G4ydKMirgr3RqTY2xDwG81yGf29wMuiig
         ikFImnjiZHAm7bgqkyx4oDaO2MSUgm9o1TXSml148ZjoifCsNbQuho2jRaK48si2ve1+
         4/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VV2PQ7PmQhWzfQWCU4GSl8RsFiXS5v11ANHvanOzj28=;
        b=5Rl9kFteHMCoit3/37Vcb1b2PT6c1FQA/LWzPSroQR68CO8nnH0qbyAAQqhp63p3tC
         SP4s1PGkCGzpNRx1MUTayfNDIXCWEA+f7xBXOTQbY7a9TEJ2B7HkbmgrMYpu7u/vGYCk
         hwE+DhU6SwNLK0dk65lLdRNWjwEwMHlxct1snohzy5lhsZeid2XUs5sBpUXEgbAPjGY8
         dhsCo2UQ24mT5eTsQToRTM0+BSF/DYPeyDSb4q+Yx8yxTzi16/m1agGW6pRTrk2a/AcU
         QbKxyV4xlu29MoZrZ518GXWJWZqB9zfXdHR4nV5xaUQjyXj2pMzYOb2Nc/D/vI67AIna
         i15Q==
X-Gm-Message-State: AOAM532yb9g+OReQHa8rpKGIhDAYVE0Ybk2152MZsAzpKTdRe8i/eNcP
        dztWyFBQbNa50J2j9qT7HUVJgmn8hzw=
X-Google-Smtp-Source: ABdhPJyWrtz4GWY+YXc9qqtXQWtNeHVRwCHJKUO6zxAp028ponY7PqM2Qp1eiIZm5+bUPfjTeFAQiw==
X-Received: by 2002:a63:6dc8:: with SMTP id i191mr55568349pgc.34.1641527524263;
        Thu, 06 Jan 2022 19:52:04 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j16sm4043855pfj.16.2022.01.06.19.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 19:52:03 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] MIPS: BCM47XX: Define Linksys WRT310N V2 buttons
Date:   Thu,  6 Jan 2022 19:51:37 -0800
Message-Id: <20220107035141.2325384-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107035141.2325384-1-f.fainelli@gmail.com>
References: <20220107035141.2325384-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the buttons registration code to register the two buttons (WPS,
system rester) using the existing BCM47XX_BOARD_LINKSYS_WRT310NV2 board
entry.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/bcm47xx/buttons.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 535d84addcdb..9e7ecc585d59 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -276,6 +276,12 @@ bcm47xx_buttons_linksys_wrt310nv1[] __initconst = {
 	BCM47XX_GPIO_KEY(8, KEY_UNKNOWN),
 };
 
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt310n_v2[] __initconst = {
+	BCM47XX_GPIO_KEY(5, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
 static const struct gpio_keys_button
 bcm47xx_buttons_linksys_wrt54g3gv2[] __initconst = {
 	BCM47XX_GPIO_KEY(5, KEY_WIMAX),
@@ -608,6 +614,9 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_LINKSYS_WRT310NV1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt310nv1);
 		break;
+	case BCM47XX_BOARD_LINKSYS_WRT310NV2:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt310n_v2);
+		break;
 	case BCM47XX_BOARD_LINKSYS_WRT54G3GV2:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt54g3gv2);
 		break;
-- 
2.25.1

