Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB159F9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiHXMZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiHXMZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:25:54 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8EB7E80C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:25:52 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g21so12483417qka.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9U7sd7xcwxQ9yB0a4u1XKB3ZhZTZ5GAHw7+laA2TH8E=;
        b=LjZ/wqTVS/JtUiGast16cN6CBPLVniH3ADtIKMaZV3hsURfGFmIVil4M9bR1pUK1cP
         5tryb/YT3bfxcJ0PBCLAPl3WwAh9VUvYho/AZKWRcrmZ3Y7xFCHaAajSpBgNH7ulvt94
         wX5VFkW4VamGTzkPGKsRgQJ0yf5Kn8P1U5pZVDA2hT53DzSSoh1ublVCpKpmisncGAbc
         nVsKvJjlU2KY485A5+04/lwhJuhe3GaqC3zNnhNQ9G3p2EZ2lICUJcSuZjQ3mk2wKHhb
         UxhEJctSDH3OtYnt4itJaUvYQM08qJ8Z3WRIzNGDSC9ci6loz3ufJqV+oiTHY8e3CkI2
         g11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=9U7sd7xcwxQ9yB0a4u1XKB3ZhZTZ5GAHw7+laA2TH8E=;
        b=tOtaVcdCUH+JLnF9DHfCFIsJ5/rlL+DgPU9nXp1qw89UTniuC3KAnAxddOS6+3odMr
         dkjqrUTeKEgiWKn9ReKbAgSEtifrrdCUn4kXiOhZBzSHJbeONI21II9JDZr/dvqiQS8r
         HKZDkE+LJsoFuHM9IV/zho5Up2HDzhZc73PpYjbPGHhQsPf77koTjbDDP8Bf+XJVXFpI
         Y+omsQ74X7YAlqqw38mbjj6qTHg8A1Dz3CP+bidjH0ZjbK+rCGZU5YqPuXT0hW+nNhEb
         Kzj3wh3Fpww1ToX0FbcAVZ1QYPyEFvl6MhSMHHdOIWK2pQSs0faeQMVKl9EdvHiP3CFs
         akZQ==
X-Gm-Message-State: ACgBeo0JP1ubii4LBM+yBqGTwOtq90WCFqde86nBkrtYpgeG5bJqTqWZ
        OAkxgKvIJfVAfb9OrUIADUo=
X-Google-Smtp-Source: AA6agR4Yz5+Wne0chNlUFuKSXicK3OSjoAb8O4xJVr0Zj7ULRZu0USsPGwNhON/AKZbWM9PE2KkVAg==
X-Received: by 2002:ae9:e104:0:b0:6bb:fb42:1e93 with SMTP id g4-20020ae9e104000000b006bbfb421e93mr12431015qkm.693.1661343951372;
        Wed, 24 Aug 2022 05:25:51 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:901:9131::10])
        by smtp.gmail.com with ESMTPSA id x30-20020a05620a0b5e00b006b872b606b1sm14548248qkg.128.2022.08.24.05.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:25:50 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] phy: rockchip-inno-usb2: Return zero after otg sync
Date:   Wed, 24 Aug 2022 08:25:43 -0400
Message-Id: <20220824122543.174730-1-pgwipeout@gmail.com>
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
v3
- add missing brackets around new goto
v2
- switch to using our own variable
- add missing goto to skip sync in case of registration failure
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 0b1e9337ee8e..27da5ba379c4 100644
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
@@ -1163,12 +1163,15 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 		ret = devm_extcon_register_notifier(rphy->dev, rphy->edev,
 					EXTCON_USB_HOST, &rport->event_nb);
 		if (ret)
+		{
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

