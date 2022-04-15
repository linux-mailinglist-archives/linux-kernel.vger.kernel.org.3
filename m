Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6A7502DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355821AbiDOQ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242633AbiDOQ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:28:29 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E885568339
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:26:00 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.94]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5W4y-1nzgmd3Vda-01715x; Fri, 15 Apr 2022 18:25:49 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/2] drm/panel/raspberrypi-touchscreen: Initialise the bridge in prepare
Date:   Fri, 15 Apr 2022 18:25:13 +0200
Message-Id: <20220415162513.42190-3-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415162513.42190-1-stefan.wahren@i2se.com>
References: <20220415162513.42190-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mKSLJHmAOiI+EmXgsdiCyuseqCHBZtLatfo/N7D6PmccbTLK4ti
 Ba7N26Tk7cBKRSQPbQrnqkyX9sByH3UV9FgLrl+L8YJ7QsKBQvAx9HJQloPXrZsgOmYTDF8
 dF6xye4+mMOpV0UGTkwpyT8rGOgb0s/09HeP3yUiftLApNa9crzWn3UJqbD+uoOSUj2780n
 7V2Zy55TEFyU/UocePIig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xUBDiT9w8cw=:HCyXnQJeqGcKF6G9DjUnjZ
 puX20Htbf7204KArWKbAoFx/HcC5UPx+FBalFYJiEK8pTuto7NdgY4/knjK3l9bZ6qwXrXCj1
 BQIAREi7obMoWI4CEYflM82gDjQMOJvKuWglQEcde+l3cmZs5wAjvpcR3D7WINy4+LqcW0hYC
 CZLUl9eQwldHTrhRw6Z0SbmObaYTrOPQ7/AYpS520pzlNN8iufzfREJEFO+7ItkFAMiXC9UMN
 hzOeXRdzWP42TYAiWNV4uP/1Gs36IT8sPeVVFSrkHpVWmzlZsKv3DQiaTPPi7G5mXHhCwoHMX
 PftdrCbEDbfhC96psisWdGJY5LOFdfh1Sbqjp7DIeYJvXTNBKOQIzlt9yCM+sQHfkByzLw/Ol
 7XMtuiK5T/keHJHQyeB6ukhljuky8155WO9ZEQ5KQ4g8olxtfSNnO/UJjyiOzqSnUljHjbqVY
 rNXbudlCJvb5IziKP9Dlsu0sbiF//IXmS1nDB2BDfstqtx6syKQeVpgTJ4JxUzlkjfdTkwqiR
 ihmROGi7faeOUl2up5HCsRi5KKkMP/AmCMW1SzuZIRK7gRqpeW9hlEFpam5xADFjaqkci9wze
 b0iS2g8fmytzcNwLaGMzoQNUDac2vTMqZN/cxkczSa8g5tqFT1VTpbZ9eTgnGItHTUKbtJEAu
 17ZXKRM9cPtV+LAOhJoI5AQXXpufq1l0vC7uVaCShimBXGxcFHI5xnJOsf4AdyPT13k0afyag
 ghG6Z9xbC6vkkRye
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The panel has a prepare call which is before video starts, and an
enable call which is after.
The Toshiba bridge should be configured before video, so move
the relevant power and initialisation calls to prepare.

Fixes: 2f733d6194bd ("drm/panel: Add support for the Raspberry Pi 7" Touchscreen.")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 1f805eb8fdb5..145047e19394 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -265,7 +265,7 @@ static int rpi_touchscreen_noop(struct drm_panel *panel)
 	return 0;
 }
 
-static int rpi_touchscreen_enable(struct drm_panel *panel)
+static int rpi_touchscreen_prepare(struct drm_panel *panel)
 {
 	struct rpi_touchscreen *ts = panel_to_ts(panel);
 	int i;
@@ -295,6 +295,13 @@ static int rpi_touchscreen_enable(struct drm_panel *panel)
 	rpi_touchscreen_write(ts, DSI_STARTDSI, 0x01);
 	msleep(100);
 
+	return 0;
+}
+
+static int rpi_touchscreen_enable(struct drm_panel *panel)
+{
+	struct rpi_touchscreen *ts = panel_to_ts(panel);
+
 	/* Turn on the backlight. */
 	rpi_touchscreen_i2c_write(ts, REG_PWM, 255);
 
@@ -349,7 +356,7 @@ static int rpi_touchscreen_get_modes(struct drm_panel *panel,
 static const struct drm_panel_funcs rpi_touchscreen_funcs = {
 	.disable = rpi_touchscreen_disable,
 	.unprepare = rpi_touchscreen_noop,
-	.prepare = rpi_touchscreen_noop,
+	.prepare = rpi_touchscreen_prepare,
 	.enable = rpi_touchscreen_enable,
 	.get_modes = rpi_touchscreen_get_modes,
 };
-- 
2.25.1

