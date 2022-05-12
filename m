Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4141652569A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358488AbiELUwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358481AbiELUw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:52:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8D91BB991
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:52:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a11so5896821pff.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Ies45XQh7ymdD5acJILStC2yG/IlgiJIKbLY52H88Q=;
        b=Zc+8sBWS1pojS7k/yPaJKk9BjzB/ATYdrEE1H/xsCuyenIYW19LxvPheqCeXWPmZrD
         OOdoPh+6HS1wB5oA53VwSqlqDOQqR1G1jmoJCMF8PDHBQPQX4IM6t2ImiFcbjqaLE5Nt
         EERMlp16x35JlLgCeCl/sSNUXfn8TWUZfRE+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Ies45XQh7ymdD5acJILStC2yG/IlgiJIKbLY52H88Q=;
        b=ADqRQdy56Gb/ZrXq/GEEFdVotFJvOrsFDDQ4oY3HFs99PODt0Z8wmfTEz15obw7TIS
         9aVW8alHyT6OJufNsIy3aqW1oT8juPljZYhOfkCEd64WEzFPh37x5OWc4ceQF5rltEfi
         llJ0Sm3USfPkQHxF9ZmuDHmoAXGLU2QSkhkPltcpRk3BlfBewWrhrPKYz1hyheB3io2O
         eW+RlkIne3y9NeOBL6/0nesqH+HCaacL676Z0QjmKwsOEUHKVkRyuL1tMn0Gnm4KtZfB
         rm1RiZ/+eZAzZaW7e4bpgKIIc/RmKv6A+MdgtjP1opvUX/NEx8E4noQ+3Z60FZjVqHtq
         Jl2g==
X-Gm-Message-State: AOAM533W25NaCGYPVfS1+nPrrEWmYWNG+E5oa/sgP2HRMNnQK5KcCxmf
        mhKJgoo++mavzNB/WXqKcC1OGA==
X-Google-Smtp-Source: ABdhPJxegJvQdMeDYnLXr1pjy2t9mHEjDACmKnVCoEdKhoZ9MnnfrVqDUATBEGvOT8sgCIE9Jo6b7Q==
X-Received: by 2002:a63:1d5f:0:b0:3c6:e822:2eb1 with SMTP id d31-20020a631d5f000000b003c6e8222eb1mr1122541pgm.99.1652388746275;
        Thu, 12 May 2022 13:52:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:1ee3:ea22:908:c2b5])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902a3cf00b0015eddb8e450sm370681plb.25.2022.05.12.13.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 13:52:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/msm/dsi: only powerup at modeset time if "early_poweron" modparam
Date:   Thu, 12 May 2022 13:52:18 -0700
Message-Id: <20220512135134.v3.1.Ia196e35ad985059e77b038a41662faae9e26f411@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
time") caused sc7180 Chromebooks that use the parade-ps8640 bridge
chip to fail to turn the display back on after it turns off.

Unfortunately, it doesn't look easy to fix the parade-ps8640 driver to
handle the new power sequence. The Linux driver has almost nothing in
it and most of the logic for this bridge chip is in black-box firmware
that the bridge chip uses.

Also unfortunately, reverting the patch will break "tc358762".

The long term solution here is probably Dave Stevenson's series [1]
that would give more flexibility. However, that is likely not a quick
fix.

For the short term, let's introduce a module parameter that selects
between the two behaviors. This is a short term hack but at least can
keep both users working. We'll default the value of the module
parameter to the old behavior. Given that the old behavior has existed
for longer it's probably a safer default.

[1] https://lore.kernel.org/r/cover.1646406653.git.dave.stevenson@raspberrypi.com

Fixes: 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset time")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- No longer a revert; now a module parameter.

Changes in v2:
- Remove the mud from my face.

 drivers/gpu/drm/msm/dsi/dsi_manager.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 50b987658b1f..2bf4123ef5df 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -34,6 +34,10 @@ static struct msm_dsi_manager msm_dsim_glb;
 #define IS_SYNC_NEEDED()	(msm_dsim_glb.is_sync_needed)
 #define IS_MASTER_DSI_LINK(id)	(msm_dsim_glb.master_dsi_link_id == id)
 
+bool early_poweron;
+MODULE_PARM_DESC(early_poweron, "Power DSI controller early");
+module_param(early_poweron, bool, 0600);
+
 static inline struct msm_dsi *dsi_mgr_get_dsi(int id)
 {
 	return msm_dsim_glb.dsi[id];
@@ -389,6 +393,9 @@ static void dsi_mgr_bridge_pre_enable(struct drm_bridge *bridge)
 	if (is_bonded_dsi && !IS_MASTER_DSI_LINK(id))
 		return;
 
+	if (!early_poweron)
+		dsi_mgr_bridge_power_on(bridge);
+
 	/* Always call panel functions once, because even for dual panels,
 	 * there is only one drm_panel instance.
 	 */
@@ -570,7 +577,8 @@ static void dsi_mgr_bridge_mode_set(struct drm_bridge *bridge,
 	if (is_bonded_dsi && other_dsi)
 		msm_dsi_host_set_display_mode(other_dsi->host, adjusted_mode);
 
-	dsi_mgr_bridge_power_on(bridge);
+	if (early_poweron)
+		dsi_mgr_bridge_power_on(bridge);
 }
 
 static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
-- 
2.36.0.550.gb090851708-goog

