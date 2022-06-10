Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD85546F82
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 00:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348044AbiFJWDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 18:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348213AbiFJWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 18:03:26 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85219275583;
        Fri, 10 Jun 2022 15:03:25 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D570BCD36F;
        Fri, 10 Jun 2022 22:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1654898602; bh=oeZz0OZexmMdYCMRKOgZDLEiOr1iNRAvEG7wdfdbtkA=;
        h=From:To:Cc:Subject:Date;
        b=NX/NiUfTnfYpFcspTrCqQqLYTDiBAp68cj/OwnswFvHiRrhRP4cfBBAXg9t4OhIIz
         BKUm2xllrZ+U40OITYYIUKP08W3QwAlAEw5X4IGrdB82TeWjPDy7lDiB8Oli5jA6Sv
         9Krvp4OZLjN0bo+hPBCcnZrAhJPFNUuTeKFe81B8=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dsi: Use single function for reset
Date:   Sat, 11 Jun 2022 00:02:57 +0200
Message-Id: <20220610220259.220622-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <vladimir.lypak@gmail.com>

There is currently two function for performing reset: dsi_sw_reset and
dsi_sw_reset_restore. Only difference betwean those is that latter one
assumes that DSI controller is enabled. In contrary former one assumes
that controller is disabled and executed during power-on. However this
assumtion is not true mobile devices which have boot splash set up by
boot-loader.

This patch removes dsi_sw_reset_restore and makes dsi_sw_reset disable
DSI controller during reset sequence if it's enabled.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 48 +++++++++++++-----------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index a95d5df52653..bab2634ebd11 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1080,12 +1080,32 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 
 static void dsi_sw_reset(struct msm_dsi_host *msm_host)
 {
+	u32 ctrl;
+
+	ctrl = dsi_read(msm_host, REG_DSI_CTRL);
+
+	if (ctrl & DSI_CTRL_ENABLE) {
+		dsi_write(msm_host, REG_DSI_CTRL, ctrl & ~DSI_CTRL_ENABLE);
+		/*
+		 * dsi controller need to be disabled before
+		 * clocks turned on
+		 */
+		wmb();
+	}
+
 	dsi_write(msm_host, REG_DSI_CLK_CTRL, DSI_CLK_CTRL_ENABLE_CLKS);
 	wmb(); /* clocks need to be enabled before reset */
 
+	/* dsi controller can only be reset while clocks are running */
 	dsi_write(msm_host, REG_DSI_RESET, 1);
 	msleep(DSI_RESET_TOGGLE_DELAY_MS); /* make sure reset happen */
 	dsi_write(msm_host, REG_DSI_RESET, 0);
+	wmb(); /* controller out of reset */
+
+	if (ctrl & DSI_CTRL_ENABLE) {
+		dsi_write(msm_host, REG_DSI_CTRL, ctrl);
+		wmb();	/* make sure dsi controller enabled again */
+	}
 }
 
 static void dsi_op_mode_config(struct msm_dsi_host *msm_host,
@@ -1478,32 +1498,6 @@ static int dsi_cmds2buf_tx(struct msm_dsi_host *msm_host,
 	return len;
 }
 
-static void dsi_sw_reset_restore(struct msm_dsi_host *msm_host)
-{
-	u32 data0, data1;
-
-	data0 = dsi_read(msm_host, REG_DSI_CTRL);
-	data1 = data0;
-	data1 &= ~DSI_CTRL_ENABLE;
-	dsi_write(msm_host, REG_DSI_CTRL, data1);
-	/*
-	 * dsi controller need to be disabled before
-	 * clocks turned on
-	 */
-	wmb();
-
-	dsi_write(msm_host, REG_DSI_CLK_CTRL, DSI_CLK_CTRL_ENABLE_CLKS);
-	wmb();	/* make sure clocks enabled */
-
-	/* dsi controller can only be reset while clocks are running */
-	dsi_write(msm_host, REG_DSI_RESET, 1);
-	msleep(DSI_RESET_TOGGLE_DELAY_MS); /* make sure reset happen */
-	dsi_write(msm_host, REG_DSI_RESET, 0);
-	wmb();	/* controller out of reset */
-	dsi_write(msm_host, REG_DSI_CTRL, data0);
-	wmb();	/* make sure dsi controller enabled again */
-}
-
 static void dsi_hpd_worker(struct work_struct *work)
 {
 	struct msm_dsi_host *msm_host =
@@ -1520,7 +1514,7 @@ static void dsi_err_worker(struct work_struct *work)
 
 	pr_err_ratelimited("%s: status=%x\n", __func__, status);
 	if (status & DSI_ERR_STATE_MDP_FIFO_UNDERFLOW)
-		dsi_sw_reset_restore(msm_host);
+		dsi_sw_reset(msm_host);
 
 	/* It is safe to clear here because error irq is disabled. */
 	msm_host->err_work_state = 0;
-- 
2.36.1

