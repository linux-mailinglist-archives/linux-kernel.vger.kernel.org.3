Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889AE5AB884
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIBSpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiIBSpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:45:50 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503BE28E2F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:45:49 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j6so2071386qvu.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=l8lXRjJOTwa1pdbI6AHOCcVerD9joOqdaqD9HG8JOnk=;
        b=JT/5wswXZeLkBTP7NJmehoUSznJrZkjGyuGX1VZeMQR87I5/I/NvC9NhtkHkHevMSL
         5paJSt0K5hZEpDRgeCxtFxnTKXpFoCEV5uLmC/RZa8nU/JMLoii/ODoudvh4JSNPln9r
         flyLLR6wueAYBsGUk77HDDs8p+nAmTgUWFfhoFCyFIqr7XLImMfoEFRtCs1YTxbSlbin
         TMdomDl3vxaGu21qX/p1bUgflUS3QboZZAC8Zyc6O/qyjTSOXXu1b7Z73pYtVziaRZxz
         ZZJyGa4LwaeeHT8W4jwcUJgY238hFy1EK660+OjBPTyX+qcLKcGymUVM2WQSDdOVKze8
         BBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=l8lXRjJOTwa1pdbI6AHOCcVerD9joOqdaqD9HG8JOnk=;
        b=lL/nHFQ8MhINPMnGg7jaVjeo4PZyQq5SVBabJFVc9FXbuZvOaeGPQG70Hesz+SnMy7
         ZkxRmZ8PpoQ2g7k6vjLqi9wvWKsc/cnRcjbXja1YnrTqQ/nUos+oTSiXYcw7uk7v5Irl
         cx0mKyAXw+hS/7WlmuG+MME7syMGkBVIMxKHCIBTFdHPNaBDi5u0XnyaRySu4Kod4TXT
         H/1LO7x2wsNAkkZHNvYGMwtEcUR5sO3HuQZABrmSEc+Bz7/14mMFoEU0lVEyAtU/W9CJ
         sQFNhGCImPIOpHn8iY2AVy/M2Tt1iZS1vHAIznCHDwRQGjKYrljihshwAFPniyG6TEnB
         ZV5Q==
X-Gm-Message-State: ACgBeo3XjIQYTu8OVYmbeMMS+Zs0N65zpRrSVQoKDR8+64/zfE6qs06f
        EoPPlo9V+9KzECiZYsT73Yc=
X-Google-Smtp-Source: AA6agR7rAtz5HXoZEwSh+DlfA67M7HYVo7709S81K0h8mjg1oqA4O4cUjrdXJOOpwysFE1THXuW/zg==
X-Received: by 2002:a05:6214:1a43:b0:49a:f1ea:d8e1 with SMTP id fi3-20020a0562141a4300b0049af1ead8e1mr2795452qvb.103.1662144348356;
        Fri, 02 Sep 2022 11:45:48 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:901:9131::10])
        by smtp.gmail.com with ESMTPSA id a2-20020a05622a02c200b003447ee0a6bfsm884723qtx.17.2022.09.02.11.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:45:47 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] phy: rockchip-inno-usb2: Return zero after otg sync
Date:   Fri,  2 Sep 2022 14:45:42 -0400
Message-Id: <20220902184543.1234835-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The otg sync state patch reuses the ret variable, but fails to set it to
zero after use. This leads to a situation when the otg port is in
peripheral mode where the otg phy aborts halfway through setup.  It also
fails to account for a failure to register the extcon notifier. Fix this
by using our own variable and skipping otg sync in case of failure.

Fixes: 8dc60f8da22f ("phy: rockchip-inno-usb2: Sync initial otg state")
Reported-by: Markus Reichl <m.reichl@fivetechno.de>
Reported-by: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
---
Changelog:
v4
- fix a checkpatch style error (thanks Vinod)
v3
- add missing brackets around new goto
v2
- switch to using our own variable
- add missing goto to skip sync in case of registration failure
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 0b1e9337ee8e..e6ededc51523 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1124,7 +1124,7 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 					  struct rockchip_usb2phy_port *rport,
 					  struct device_node *child_np)
 {
-	int ret;
+	int ret, id;
 
 	rport->port_id = USB2PHY_PORT_OTG;
 	rport->port_cfg = &rphy->phy_cfg->port_cfgs[USB2PHY_PORT_OTG];
@@ -1162,13 +1162,15 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 
 		ret = devm_extcon_register_notifier(rphy->dev, rphy->edev,
 					EXTCON_USB_HOST, &rport->event_nb);
-		if (ret)
+		if (ret) {
 			dev_err(rphy->dev, "register USB HOST notifier failed\n");
+			goto out;
+		}
 
 		if (!of_property_read_bool(rphy->dev->of_node, "extcon")) {
 			/* do initial sync of usb state */
-			ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
-			extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
+			id = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
+			extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !id);
 		}
 	}
 
-- 
2.25.1

