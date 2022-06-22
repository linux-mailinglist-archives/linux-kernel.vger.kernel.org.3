Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEE1553F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 02:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354753AbiFVAbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 20:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiFVAbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 20:31:49 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8E82F3BE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:31:49 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 59so250277qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X0QEIToI/CFI0cgM+A/tlMGHfHXlQisMEaSeYjXmHHA=;
        b=mcheo+5zMZDnjR6yyVGONRNMiaAHvA2/guCw8onol6soGX3VbyfFTK6rQVCNsXmGam
         Cm/poHlz4TL9ELqEcUp6ys6TOGDmjhgwma9ywr01ijnH0TFaTjwiGGYDbfEMjdO8/+sa
         xmUoSbN7ffpWwOru8LeRV/YwF5vGOQzlNQ+YejH9HZdESi1teiYLv9ELSjWKfx3RFn9J
         36/hGmieXG6lC/CKbgMB98xoZMKyz0JvmxDMuLfC5uG7BxUJjBWj0+Xl6acSxKtfXfLv
         m/CswqG5/PeTF4TOpMb1+eZ+dqxcxr4EBbPhBv2+vs3fWwDkMm7QlUUoji7IngrxSIaZ
         vitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X0QEIToI/CFI0cgM+A/tlMGHfHXlQisMEaSeYjXmHHA=;
        b=GhR/55hlBGN4zOQzA+NK0k3xyS4ca3UyZmdI7rN0ZcRJRlQq/qCvQiVORy5nw0tLfi
         wQDjWmwY3UvEl3a5IBH4LJjXJNDPL6fByx2L/WjfdDGFMgDgVsFMXnn8A40YCvZy0e3L
         /losy5zdls+8xomlyqDPojOED3n3Y8qffcGIMUdIG2W3crOHteFIVFyhg0NYusTekoWk
         ydWmNPPZl0UChJW+g4xqOGHENR1MtbOUzvser7pDW/1qpXmQvYbh4idSAuEhm0/GMiI2
         Rg/ie8QErZF+juctgfbU6QyK7jcDIEKXWoAIOaFj543+OHPztcLE/a/8V2m3omDV1LE3
         rQxA==
X-Gm-Message-State: AJIora/29HFmJBOs60JjR7cEmZ/oq63BkLUNRBhqy+VvP0kpmhECjqa+
        WCXGnheq5MTa099GBkK7XNo=
X-Google-Smtp-Source: AGRyM1s6iU9poE7Ijqhj7rTba2yRmxwLcqau0ytkVnEFTWbNOaSpLsfzAFR6VZ05/rfC8yBTvB6fxQ==
X-Received: by 2002:a05:6214:cc4:b0:470:2c94:4fdf with SMTP id 4-20020a0562140cc400b004702c944fdfmr18133964qvx.2.1655857908195;
        Tue, 21 Jun 2022 17:31:48 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id b19-20020ac87553000000b00304ef50af9fsm13496995qtr.2.2022.06.21.17.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 17:31:47 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Peter Geis <pgwipeout@gmail.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: rockchip-inno-usb2: Sync initial otg state
Date:   Tue, 21 Jun 2022 20:31:40 -0400
Message-Id: <20220622003140.30365-1-pgwipeout@gmail.com>
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

The initial otg state for the phy defaults to device mode. The actual
state isn't detected until an ID IRQ fires. Fix this by syncing the ID
state during initialization.

Fixes: 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 6711659f727c..6e44069617df 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1162,6 +1162,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 					EXTCON_USB_HOST, &rport->event_nb);
 		if (ret)
 			dev_err(rphy->dev, "register USB HOST notifier failed\n");
+
+		if (!of_property_read_bool(rphy->dev->of_node, "extcon")) {
+			/* do initial sync of usb state */
+			ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
+			extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
+		}
 	}
 
 out:
-- 
2.25.1

