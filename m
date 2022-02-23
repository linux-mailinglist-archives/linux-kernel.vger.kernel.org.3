Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6874C1189
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbiBWLlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbiBWLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:41:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E1B95A12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:40:47 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:995c:f547:d294:e4ca])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 979691F44691;
        Wed, 23 Feb 2022 11:40:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645616445;
        bh=Odo6dvcrTCaffyGv6tM4ZI49Z1HSi/r7+/fGLyy6ilA=;
        h=From:To:Cc:Subject:Date:From;
        b=RWeVp9Gavp0lThklna33hXdbWAxCRZXV1r+YOyxptw/+meIzZXsqtSHu7lhFDX1tH
         kq1k+RCEYJEbgChrnRqVY4c9FS6E846qnr4EHCGjYT+DPA3fbgjZUKYzH1UMx02Lx3
         7c1zYUDeERg7Neg+kLfm+ahP7yOm2LbfIEI6lIbnRKQozKSr5RsdkcczOSG83JNRiy
         34Y8XISpN09wCjxMaDtFenP4Ur6YgCtNQ/WzeEXf5Mb/OmZLfzcGF6e+Qf75dNYI7H
         WzD2RGr+mx34zGqKSPfdgHtSAnoMewOiuxqc297yZRNfjgPlOSyvpzZCxXf5Uc/weM
         HCKablplqE32A==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     yangcong5@huaqin.corp-partner.google.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] drm/panel: boe-tv101wum-nl6: Fix errors cases handling in prepare function
Date:   Wed, 23 Feb 2022 12:40:36 +0100
Message-Id: <20220223114036.445845-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that pp3300 regulator and enable gpio are cleaned before
leave in error cases.

Fixes: 18c58153b8c62 ("drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail")
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 5fcbde789ddb..382a17bb96d8 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1245,11 +1245,11 @@ static int boe_panel_prepare(struct drm_panel *panel)
 
 	ret = regulator_enable(boe->pp3300);
 	if (ret < 0)
-		return ret;
+		goto disablegpio;
 
 	ret = regulator_enable(boe->pp1800);
 	if (ret < 0)
-		return ret;
+		goto poweroff3v3;
 
 	usleep_range(3000, 5000);
 
@@ -1286,6 +1286,9 @@ static int boe_panel_prepare(struct drm_panel *panel)
 poweroff1v8:
 	usleep_range(5000, 7000);
 	regulator_disable(boe->pp1800);
+poweroff3v3:
+	regulator_disable(boe->pp3300);
+disablegpio:
 	gpiod_set_value(boe->enable_gpio, 0);
 
 	return ret;
-- 
2.32.0

