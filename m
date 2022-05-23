Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00005307BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353003AbiEWCiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiEWCiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:38:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E883B24BF3
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 19:38:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so844151pjt.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 19:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SCo+/6Dp4ecMyx6QNBbOhrueItFKCDaZsh/nXDu21/Q=;
        b=KGrKQnUUU7VYp7oY1krEq1Dxac6fcHVjyMu04Zlf5yf4eWdtjEzZyrrkpDQAE3bQdR
         zPNoDecL6J8lCvnvlFCaFO16fDRmHi1/8Mn9DahQQZMjUjLoaBdk8t1u0QI6T/6Nx3tO
         kojSMZ42poyxlAR5Nb58aO26fM6BV7VyFyNdfpSR6YCkOaBe7qtvB4sKS/WfQt98O3tS
         p5jQxyloh7VG6oRlRIHEg0GqETp5K5UXfWeEUZvlS7rUYM2lYyhDRnEab0MA+GeDuaKy
         i80fFaNLir+8GXMG+rEVqrwRIEqQS0Hh11+fxvZdOilmfjNauXtmMcAQYCAakvCh27PF
         /zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SCo+/6Dp4ecMyx6QNBbOhrueItFKCDaZsh/nXDu21/Q=;
        b=ajACGNOcveODuWdK4oDdGgaCG5fdGS/WFsO4F/r6NF0OuULztOy5X2ins86p/qxWde
         +8IhivvHOiGQpHbbau2oJTcj6uObxata6mj5YpA06hK7qMwYV9rnfoz4if+1eQf3QWYJ
         1jVyaggtBUeskNjkt+WJm/2t9Jb9BGJbU1fqne0MjO0DAMTOrjJOWyyHcaC1RcM4y4Id
         c77QZhGjQ9aki3Cc+3novBT4ASTJWCvySEIzKnm4PLiZVK74Dl+b39gjR0dx8Eis4hT/
         Dk+M5ukGN0ts1tfb/65mx9uBpim/C5ZXMcNyEQMoBo2JZgpEQUHmiaeAh3HMP5tid1BZ
         iREA==
X-Gm-Message-State: AOAM530ShVw4yxmQtf+rAEyT7jUw2qWyOPfLpJzbnErNN+w8tiC+HhjF
        y5AbEgvB6IDw1hCQj3YGnU8=
X-Google-Smtp-Source: ABdhPJyDVzE2P4ymfaOGVOOmfUl6s5sR7i3Bo99wlzNrSFcEA67aq2i5jvFGmxnaYPhaiREBxKGXsQ==
X-Received: by 2002:a17:902:f144:b0:15e:cd78:e36e with SMTP id d4-20020a170902f14400b0015ecd78e36emr21159798plb.144.1653273491169;
        Sun, 22 May 2022 19:38:11 -0700 (PDT)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id l6-20020a63be06000000b003c66480613esm3579768pgf.80.2022.05.22.19.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 19:38:10 -0700 (PDT)
From:   Jonathan Liu <net147@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Marek Vasut <marex@denx.de>, Maxime Ripard <maxime@cerno.tech>,
        Jonathan Liu <net147@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: bridge: icn6211: Adjust clock phase using SYS_CTRL_1
Date:   Mon, 23 May 2022 12:38:00 +1000
Message-Id: <20220523023801.410050-1-net147@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code from [1] sets SYS_CTRL_1 to different values depending on the
desired clock phase (0, 1/4, 1/2 or 3/4). A clock phase of 0 aligns the
positive edge of the clock with the pixel data while other values delay
the clock by a fraction of the clock period. A clock phase of 1/2 aligns
the negative edge of the clock with the pixel data.

The driver currently hard codes SYS_CTRL_1 to 0x88 which corresponds to
aligning the positive edge of the clock with the pixel data. This won't
work correctly for panels that require aligning the negative edge of the
clock with the pixel data.

Adjust the clock phase to 0 if DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE is
present in bus_flags, otherwise adjust the clock phase to 1/2 as
appropriate for DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE.

[1] https://github.com/tdjastrzebski/ICN6211-Configurator

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/bridge/chipone-icn6211.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 47dea657a752..df0290059aa3 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -57,6 +57,10 @@
 #define BIST_CHESS_XY_H		0x30
 #define BIST_FRAME_TIME_L	0x31
 #define BIST_FRAME_TIME_H	0x32
+#define CLK_PHASE_0		0x88
+#define CLK_PHASE_1_4		0x98
+#define CLK_PHASE_1_2		0xa8
+#define CLK_PHASE_3_4		0xb8
 #define FIFO_MAX_ADDR_LOW	0x33
 #define SYNC_EVENT_DLY		0x34
 #define HSW_MIN			0x35
@@ -414,7 +418,11 @@ static void chipone_atomic_enable(struct drm_bridge *bridge,
 	chipone_configure_pll(icn, mode);
 
 	chipone_writeb(icn, SYS_CTRL(0), 0x40);
-	chipone_writeb(icn, SYS_CTRL(1), 0x88);
+
+	if (bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
+		chipone_writeb(icn, SYS_CTRL(1), CLK_PHASE_0);
+	else
+		chipone_writeb(icn, SYS_CTRL(1), CLK_PHASE_1_2);
 
 	/* icn6211 specific sequence */
 	chipone_writeb(icn, MIPI_FORCE_0, 0x20);
-- 
2.36.1

