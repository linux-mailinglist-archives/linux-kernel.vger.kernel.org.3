Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423A2502DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355833AbiDOQ2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353415AbiDOQ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:28:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C476C976
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:26:01 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.94]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N7hw4-1o1ti31ybK-014oAX; Fri, 15 Apr 2022 18:25:49 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 1/2] drm/panel/raspberrypi-touchscreen: Avoid NULL deref if not initialised
Date:   Fri, 15 Apr 2022 18:25:12 +0200
Message-Id: <20220415162513.42190-2-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415162513.42190-1-stefan.wahren@i2se.com>
References: <20220415162513.42190-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EYMVcLrb9H+Ys80yT6gFs2ZIdoUSwACQps7CMLFV5G87zLTOyFG
 hfnoSvzEpyVFuJd3Cf3Zs7Y2ETgFBhX8MQdZjyF5J5NWGdOHetgiX1P2+ExWo6/GBx+7faq
 kSFqs7g89+lXEpU0084yfRzecLjzSRRqW0dhCH+yHYabTHMqd6rijzPa/7c1TWhiofiPqHK
 l4vKPHl6yR6G8wpPCo0Kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gzkemWTVne4=:2D2sOLPTpBkviaDJLnda9M
 /ePyFTbB0C9ekj87YF7SXhtjWVuz9Hl+Svo4d5zDSCaZ84zwbaQbJ+b4Dc+Q+Ny7hcfev5Y6Z
 7QGBZn/OgskqUe+9AqWIjlj1g3CFaROyOVsOSYVzCmjz5ulngu1tvGzDp7gFwGPdCb1E+ljkI
 4dPf68qRfJ+AAFAGxb+YuAlEn6IUPqfPaZ+mbfPbZHI8f5U3uK1Y/r2LEkJZ4KGnZiiR/kGHo
 6mSj4BUolweS6guUBWKDLC74fkWuXQBJ0M1tCtbiV1jKpxuy/YBYBaahZLXjM0bH+okFsgQTB
 E4iIPg+OOVleoybd1LkUfa9iiIYZgh9zHx67YYQrBvivXWd8u2MCtuaLgATjdmilrnWdMLUK4
 Rsq0lEHntAKWZQ6H0roQPLByzS1Co9JtT4yftUiF5rj2IOeHO3Oltc2crh6oPa9F2IboCeGzZ
 /74Lvhqls/KaMOJwAjXuzS+Ny8mX4va/lFG58q7ntMTfm9PIJkG555GwV/IYZRXctlfjkWUWw
 Ya+kZ8bN9KE1G1r7FTJD1FAT/HENxyuT8U9cJOteIF0dzE7wAUJ3pykkVQVlCOGs1PzarZFJG
 5qMmWl8ghyTA8/zmKWE61m1zEElR+8esB5J6UCBtyhR4nS9HZWoFarlQei1oYnhKkgu9bPBlY
 PBP1FFX7WktoErhpnHTDm4QNCUSKeLHSaOIEkooqAJXY5P3zoSX9GjTT+pPqx2CxfzkkNyDKU
 gyNgBvyd3aLO7jVJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

If a call to rpi_touchscreen_i2c_write from rpi_touchscreen_probe
fails before mipi_dsi_device_register_full is called, then
in trying to log the error message if uses ts->dsi->dev when
it is still NULL.

Use ts->i2c->dev instead, which is initialised earlier in probe.

Fixes: 2f733d6194bd ("drm/panel: Add support for the Raspberry Pi 7" Touchscreen.")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 46029c5610c8..1f805eb8fdb5 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -229,7 +229,7 @@ static void rpi_touchscreen_i2c_write(struct rpi_touchscreen *ts,
 
 	ret = i2c_smbus_write_byte_data(ts->i2c, reg, val);
 	if (ret)
-		dev_err(&ts->dsi->dev, "I2C write failed: %d\n", ret);
+		dev_err(&ts->i2c->dev, "I2C write failed: %d\n", ret);
 }
 
 static int rpi_touchscreen_write(struct rpi_touchscreen *ts, u16 reg, u32 val)
-- 
2.25.1

