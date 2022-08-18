Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8837597DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 07:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbiHRFAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 01:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243474AbiHRFAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:00:34 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722A698582;
        Wed, 17 Aug 2022 22:00:31 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q16so429466pgq.6;
        Wed, 17 Aug 2022 22:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=s4xeiciv0oEXOOrELlvavMW1V2yOoGFDn06W9jus6bc=;
        b=hTtv51oheeUktD5EFDVqEtImldmicU2cDDbVGBc85sv+/4bhVXVp7z0Sun9nTVinS3
         QtUGyFpI8+CzPlEHLXgxI99OlpCiUZ5o/hxx9H1BDZGL55KzjcT79mHUPthUX2qLAlJI
         yWZYrjyW0drfsDM0vNtrHc1iehdf6H6cVTRrq9pFWAk0Dsr52dQk34PXnBv6Gi61WMWw
         ju6L+Nqzsz/vI6KRcpmf26zcjksrJC5TonHdCQSOtXAD+3T6OKWYAREqlVgWxtA3vlUd
         1fWZ9Towj5Zcu62OjzWQeNVJDLqF7678cKLKAUOg72y9rGOH0Xs78f5tiQZUmcjM6kIE
         Ba8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=s4xeiciv0oEXOOrELlvavMW1V2yOoGFDn06W9jus6bc=;
        b=DBEZq20DxPAnKXy47p05nScq7BDNLObbFdZL52mTFD1p1NeQ891lHQTLHhxZU8MX4r
         A57nPRoUb2dCo+OcgUTsHEyW1dW6t7Q1yV+YDL99kHme5uOdYC48Azr+bSWW4PmnYywY
         C4N6lX8+9J4c5RlJMxtTQIyti+8HAjM9Kn4d5CK0jK760PwE8ViU+cmIshnbEaAqVcwK
         ZyKafi6+c01e3zG9ejJK6b65IdltGfSlhwE+XEMovxvc94FzhbkQ3MoRcRLShxj52WRF
         cINGDAjZNoj1s5PcHSDmysLw7Sn7dF9VmH6He8sKZMxgOd27d/YsdMlg9zF3Gxv/Y9vd
         LjUg==
X-Gm-Message-State: ACgBeo1KWYs9NVY5q6W7M6RTK1+EKRTH4ZThRjXXhj5DnBlT3tD++38k
        vy2OCcE5BXYENzSfeJ1tNpTBzmWdt6bOSMbZ
X-Google-Smtp-Source: AA6agR4IVipj31ziauof72LTquHFfXMds+VCSZdiBCDU2gIx2meR1drcHbM96e327IbBFmQ+9IrWDA==
X-Received: by 2002:a63:5a1c:0:b0:429:9ad7:c725 with SMTP id o28-20020a635a1c000000b004299ad7c725mr1206385pgb.608.1660798830646;
        Wed, 17 Aug 2022 22:00:30 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([136.175.179.175])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b00172b0272f1asm349283plh.51.2022.08.17.22.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 22:00:30 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: loongson32: Fix the validation failure of LS1B & LS1C Ethernet PHY
Date:   Thu, 18 Aug 2022 13:00:19 +0800
Message-Id: <20220818050019.1924408-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

The Ethernet of LS1B/LS1C doesn't work due to the stmmac driver
using phylink_generic_validate() instead of stmmac_validate().
Moreover the driver assumes the PHY interface mode
passed in platform data is always supported.

stmmaceth stmmaceth.0 eth0: validation of gmii with support 00000000,00000000,000062cf and advertisement 00000000,00000000,000062cf failed: -EINVAL
stmmaceth stmmaceth.0 eth0: stmmac_open: Cannot attach to PHY (error: -22)

This patch sets phy_interface field of platform data.

Fixes: 04a0683f7db4 ("net: stmmac: convert to phylink_generic_validate()")
Fixes: d194923d51c9 ("net: stmmac: fill in supported_interfaces")
Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/loongson32/common/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 794c96c2a4cd..741aace80b80 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -147,8 +147,10 @@ static struct plat_stmmacenet_data ls1x_eth0_pdata = {
 	.phy_addr		= -1,
 #if defined(CONFIG_LOONGSON1_LS1B)
 	.interface		= PHY_INTERFACE_MODE_MII,
+	.phy_interface		= PHY_INTERFACE_MODE_MII,
 #elif defined(CONFIG_LOONGSON1_LS1C)
 	.interface		= PHY_INTERFACE_MODE_RMII,
+	.phy_interface		= PHY_INTERFACE_MODE_RMII,
 #endif
 	.mdio_bus_data		= &ls1x_mdio_bus_data,
 	.dma_cfg		= &ls1x_eth_dma_cfg,

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.34.1

