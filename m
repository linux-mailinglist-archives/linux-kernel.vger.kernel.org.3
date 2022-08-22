Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EC159BDA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiHVKdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiHVKda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:33:30 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274DA21B6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 03:33:30 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id e4so7768234qvr.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 03:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7biQyLR7kJdpU1WtkQOgvb5Tg9+FQQtrig74Eiy/kVo=;
        b=JELjLkIpNcd4VCCyPrqAuWDw8LrY8z49NyEQFVOYJGwys6rEo6o9Q0/ONTSAvE2z5v
         l/PbUhfwOd1suKSnPlsvd7lh61VMKSvKmvkCfnTA2Osg6Fm5OFnaOXhWmXx0QbuaA5RC
         d+lezk/7PzbE0/VVtv+H7GTvwi8L40OuFfMHGehb67TwtZLZo0XLrY6PMTlq4VAl59GI
         JjoGpUUMGmMRWR5H+T/nrlAfWIheEM/vqb2HsUd6NUVDFtUg5YWcZeV1o+YBMRYG4yj2
         Zf7J1VxGuo6R6QdTsTMjpBVMFV3iENQEY6miZje9+xQXCrgFNAVcqAdQx49Epw1R9+/e
         H4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7biQyLR7kJdpU1WtkQOgvb5Tg9+FQQtrig74Eiy/kVo=;
        b=Kx64EKo5oMRoD6T8o4zypSRUgSAbVm/Nur+n4EMz1ur73TYeSijdOeFvwRMdYYeeZr
         9m56jxiUYth3qnZZ/5tMb05A6kOnLcaxUyI91JWJIN1uvbRnDY9ujzd3xRPiswWpGY0I
         q4cxYwfYnakJUyQyYEADNdxqYKZa96proA17p5D07F8cXBfvY3qH/wl8XI1h6bABJwsC
         UauoLT1vmM1awQJGHuDXWKTQ2YPpnaWOYEsBlzjJQ/kB38VebjCK15/6mjelorFMoylf
         00cs1uet4t1AEYJsUJ/2RQL74HoUYn/FGzrpreNZUHFlhMznn5brBxksvfHndtcyTSJP
         RlEg==
X-Gm-Message-State: ACgBeo1VN0/pWZbJeQ4g/s8PB0KZsTO/hqb1TqCyIY4PJRtUXgijY6Mj
        OhP0WhhkxpuAsSqOq5cpAsA=
X-Google-Smtp-Source: AA6agR4Y8CzCM94I8+mbSKTO7qptiETBHal4Zr+63IbKfwbKSCEBnW1MOXvbeQn8KxNDEOnSKRmUWA==
X-Received: by 2002:ad4:5aae:0:b0:496:dcfc:92aa with SMTP id u14-20020ad45aae000000b00496dcfc92aamr4276349qvg.105.1661164409282;
        Mon, 22 Aug 2022 03:33:29 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:901:9131::10])
        by smtp.gmail.com with ESMTPSA id bw12-20020a05622a098c00b0031eddc83560sm8716516qtb.90.2022.08.22.03.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 03:33:28 -0700 (PDT)
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
Subject: [PATCH] phy: rockchip-inno-usb2: Return zero after otg sync
Date:   Mon, 22 Aug 2022 06:32:18 -0400
Message-Id: <20220822103219.3985075-1-pgwipeout@gmail.com>
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
peripheral mode where the otg phy aborts halfway through setup. Fix this
by setting ret to zero after use.

Fixes: 8dc60f8da22f ("phy: rockchip-inno-usb2: Sync initial otg state")

Reported-by: Markus Reichl <m.reichl@fivetechno.de>
Reported-by: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 0b1e9337ee8e..5fc7c374a6b4 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1169,6 +1169,7 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 			/* do initial sync of usb state */
 			ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
 			extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
+			ret = 0;
 		}
 	}
 
-- 
2.25.1

