Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED8659E77C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244952AbiHWQgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244939AbiHWQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:36:31 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE01DF4D6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:47:33 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h22so10522447qtu.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=b8EYUe3JugOX0krlcI4SIAy+UPYGVeLR4PxCSdVOZKA=;
        b=kds/eg8K8iDSgVtBJnyCXPYIJMTjIe4TyWFlnVvOJk99djqYpAvmv2YGgDbvzOJPeA
         cE2QB/DTRvulIqdttMXeB9CLHfx2bIc2bsNRauw5PA0xGRIeStBVoAoHKLlT6RPuGZuV
         qFHH/TY6hqKpwWuWFIjJ5jikWkkWE4fBYdn+eyxk5YbSy7FNs9SK0jNuni93x7hSD0vs
         kQIqtSBLS3ML00Sq65XA8Ax7JZBDQriWvnPMN0ME5oOoRi/EZWOhMBsxT4kCByC5E9Qt
         PNM2JAFW7DafoTylAIZxeFPmkjhy3JFfkDuIgwzcQPEch9CAFRi7E4qa/uqBiOaS3J3v
         PYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=b8EYUe3JugOX0krlcI4SIAy+UPYGVeLR4PxCSdVOZKA=;
        b=mS07gWvCF9xqR1lAPQNfvDRfl1qSguFXl2im/f0tPILcoh4TdPgMh0ZIkLs3gC+vj/
         hc59S4n0P+Wwjq6gPwtVtUknsQtkf+XMliflfRJsS4aKjX4ymZbipMQ7XUhaZp52ymra
         9Nt2/leFvbr+HuHPGfssN7hcYQGmwClIC5j1Z6KYSKZKdghdGz0AfOvqbP7QTtvcYBeO
         dkXcYWiuNbzRe1o9HdaYUIOe5s+9zEzS9PcfFYfeWmBvyav7fIkIl/SKgPPxbEjGWI40
         3/wPbjtdQ9Yxz2rKTiSaSj7BBdTTjyNMrhkvZStSZd9eZOVJ0tjsh5TEbgQGSMqBkBA7
         gk6g==
X-Gm-Message-State: ACgBeo3k7Ot8PIpEaSXSIU3P5Qu0ZRFqBVP2yfT/hFNx9jLZa/yXeomT
        cfiIXQj9eOBZbI0J5bSLdMw=
X-Google-Smtp-Source: AA6agR5pSSGs0EgS8b/26ah8lKzgSPS8zmBy7jeWzv2OusfHLi0QCQsN/9wfq3U41+VJTU8fy5CYcw==
X-Received: by 2002:ac8:7f83:0:b0:343:869a:7db9 with SMTP id z3-20020ac87f83000000b00343869a7db9mr19705477qtj.46.1661266052867;
        Tue, 23 Aug 2022 07:47:32 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:901:9131::10])
        by smtp.gmail.com with ESMTPSA id y9-20020a05620a25c900b006bb83c2be40sm13304284qko.59.2022.08.23.07.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:47:32 -0700 (PDT)
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
Subject: [PATCH v2] phy: rockchip-inno-usb2: Return zero after otg sync
Date:   Tue, 23 Aug 2022 10:47:28 -0400
Message-Id: <20220823144728.47068-1-pgwipeout@gmail.com>
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
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 0b1e9337ee8e..d579a22c61df 100644
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
@@ -1164,11 +1164,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 					EXTCON_USB_HOST, &rport->event_nb);
 		if (ret)
 			dev_err(rphy->dev, "register USB HOST notifier failed\n");
+			goto out;
 
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

