Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4925E54D48C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350137AbiFOWZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348838AbiFOWZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:25:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062142FFF2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:25:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u12so25870722eja.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EqzQW4bvuiA6pvJtGB4rjgOdvlv8E2OoMiyxcMbYrTc=;
        b=JSDW99nkzGyW3xICFnKaivNYgZ++b2aFROAcUyNdGBKm2s/+IJcAqkaFBg0XmZ2/at
         edM8wEefSZDksc/lyQB8aMS2rfc9PHBogmCkD0C28dfFHNWeHdX2doEMJ2WflhmFU6T5
         blyVH1ZWFdRN/Ja1usyOpD77t4Gzm8VRRbVYxcznxBulPSb2Rg4XrbBthfBXfH3v6Wf5
         4+gtdlhnHVpbJJ6lTB5wI7oyMLMavx+gBQ0uW6j/E6LKOih2kqRk1EiTCGWrocgUDsTJ
         pe8/Vzs97c3I+qE2ezj9xETPih6I6gJesyK/m3sf7ZybpEZiCtO4vJjtL42JwFhjEExG
         r0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EqzQW4bvuiA6pvJtGB4rjgOdvlv8E2OoMiyxcMbYrTc=;
        b=rXu6MJBuo1Hzt7bU4tuezWecGRMDKDGqNA7ahV3bOQMW/L8baaxY7QD7/HpZsWh5Ho
         KEk5a7DwFaXRYhIGQGJ250lAgBFnDw4UglanTQHRAFM0W6z/vAX2KjJ7g6YjDFC8LGb7
         enwo6Hjv+Ck8dnTNb9JcPSgsSv50/SEBbyr6qAELP5FO84euZN1y3GHVyF5Xlkv1y1WQ
         noLyXl1X6H+R+HX25Gb0kIOL1E4OokcmocccbcprmB8w1IDhS9PmZJctn/t+crIXqjCg
         uy7ebLnYHNGNwHexUSP62NvK6auG6RO5IL3yHo0hxiPZ7j4cMbcjlmJ75QOdCbdxmHQR
         j42A==
X-Gm-Message-State: AJIora+9uhFxQ7ALZzfkTmMA1xWQX6SbBcbILSM7CYa0HThjhiO1H1KB
        5HszlqKx5WNvY3jbbFKaZZU=
X-Google-Smtp-Source: AGRyM1vecP0FSol4KwYKeB+9vu236BPxycyySMJXvkigqrEt5XtwuYhjnuoaB3hP+TSVK07JAymodQ==
X-Received: by 2002:a17:906:14d5:b0:711:c55a:998 with SMTP id y21-20020a17090614d500b00711c55a0998mr1798067ejc.708.1655331913477;
        Wed, 15 Jun 2022 15:25:13 -0700 (PDT)
Received: from debian.home (90-180-208-18.rcn.o2.cz. [90.180.208.18])
        by smtp.gmail.com with ESMTPSA id y3-20020a056402358300b0042dc25fdf5bsm350427edc.29.2022.06.15.15.25.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2022 15:25:13 -0700 (PDT)
From:   Jiri Vanek <jirivanek1@gmail.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Vinay Simha B N <simhavcs@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiri Vanek <jirivanek1@gmail.com>
Subject: [PATCH 2/2] drm/bridge/tc358775: Fix DSI clock division for vsync delay calculation
Date:   Thu, 16 Jun 2022 00:22:21 +0200
Message-Id: <20220615222221.1501-3-jirivanek1@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220615222221.1501-1-jirivanek1@gmail.com>
References: <20220615222221.1501-1-jirivanek1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the same PCLK divide option (divide DSI clock to generate pixel clock)
which is set to LVDS Configuration Register (LVCFG) also for a VSync delay
calculation. Without this change an auxiliary variable could underflow
during the calculation for some dual-link LVDS panels and then calculated
VSync delay is wrong. This leads to a shifted picture on a panel.

Tested-by: Jiri Vanek <jirivanek1@gmail.com>
Signed-off-by: Jiri Vanek <jirivanek1@gmail.com>
---
 drivers/gpu/drm/bridge/tc358775.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index cd2721ab02a9..fecb8558b49a 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -430,7 +430,7 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 		val = TC358775_VPCTRL_MSF(1);
 
 	dsiclk = mode->crtc_clock * 3 * tc->bpc / tc->num_dsi_lanes / 1000;
-	clkdiv = dsiclk / DIVIDE_BY_3 * tc->lvds_link;
+	clkdiv = dsiclk / (tc->lvds_link == DUAL_LINK ? DIVIDE_BY_6 : DIVIDE_BY_3);
 	byteclk = dsiclk / 4;
 	t1 = hactive * (tc->bpc * 3 / 8) / tc->num_dsi_lanes;
 	t2 = ((100000 / clkdiv)) * (hactive + hback_porch + hsync_len + hfront_porch) / 1000;
-- 
2.30.2

