Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AB74AB198
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 20:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiBFTRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 14:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiBFTRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 14:17:07 -0500
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 11:17:04 PST
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3B6C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 11:17:04 -0800 (PST)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id D335E20056;
        Sun,  6 Feb 2022 20:07:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1644174423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UJwP4f8oteGGn0vzBKGJSEJApAsEqkPzF2JBHrzRrEU=;
        b=XdwP9KlByhvaZk6RpTlP3n7bvBlVvaJEY0wOdmjpVjh9o+ZCDhOIAin+BxypxJJWPFz9tc
        1tv1U19vlvL4nOe+DWibYnuffvyO5KiR2YR4V8E1sWXSOed3B6p/OkyNuV2g9SKByp84lB
        LVNdHesUXiWXTBNdo4XI4r35pdaYtWE=
From:   David Heidelberg <david@ixit.cz>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: JDI LT070ME05000 remove useless warning
Date:   Sun,  6 Feb 2022 20:07:02 +0100
Message-Id: <20220206190702.450643-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do as most of panel and in case of deffered probe, don't print error.

Fixes warning:
panel-jdi-lt070me05000 4700000.dsi.0: cannot get enable-gpio -517

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index ea0e7221e706..b5c0b51dc146 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -408,7 +408,8 @@ static int jdi_panel_add(struct jdi_panel *jdi)
 	jdi->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(jdi->enable_gpio)) {
 		ret = PTR_ERR(jdi->enable_gpio);
-		dev_err(dev, "cannot get enable-gpio %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "cannot get enable-gpio %d\n", ret);
 		return ret;
 	}
 
-- 
2.34.1

