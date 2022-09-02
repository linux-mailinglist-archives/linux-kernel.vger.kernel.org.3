Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DF65AAB40
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiIBJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiIBJUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:20:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C69B979FB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:20:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p18so1287226plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=a8efPwvErJ860QXNpCfLYUGMS5ISwEYQYvlbxrsvr0c=;
        b=iRMyjTV5Xvwu1ZcrMmE1BePnVONvT5/Yr6o6sUTziwoh/jMxk2/Qt1Gxj8Fo72vWjq
         6surj65A15WVg+zpUKWtWPQeIWzwvPBDy3XDsszXxGNJf6O4OTyseIMqksSuEleMzFja
         1XBkqignSUZJfreXt4l+l+NpW1/n9ITfjeRC5IDKYDwP/ts39Axj9fhEIoEcCgIomX9u
         eTK9hPU7gGX76BO7FxUbERKtBJHimAzSaxyZqwtsO2ui2tWC1aoHfvy+3la+g8aKYXhz
         CQbMDflgxVDznsbAbGC7GT7NOg+XYpTRzG62NoyQ++GCOe3hs90B+z8BEkkymToQcvQn
         sBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=a8efPwvErJ860QXNpCfLYUGMS5ISwEYQYvlbxrsvr0c=;
        b=eqgV3arFcAH9/39W6LD1FUpXpPXos2DRXM4/Z9I7hQ6oXMlEbEjmVOsnCU4X3IjyzM
         w7dd1yrnMV6tG6Fk8lFMNciUm3yUXfQ3e/iBozRHbiOEw3osHeVDxnHcjmnnE34S6yWi
         7mceVB56SZu+vRNOE9i3xQXAOKEY6AkyVnm6NIunTYU/AchBFSUJ51Ew+zM3Gb/9ownP
         Q8r9/cmrIG/vMMH4O/IIbZN36uqXveFdcRF0AyVpbcx73Aq4Gz09qnoSf3RKAflkXo+F
         aZQDWlAgHil0gpShwPKRyAlQ88wglhNOktKUuiz3LEzEtbsUpGbmlOMaM0NgphRJnUbe
         KtlA==
X-Gm-Message-State: ACgBeo3vZ1fE0LDM7QiWhs4hxE0Qbej4dcNmj1YExn4S55AQhzQOreu2
        Ufn4+JTvwDaSmBs7IM+myDc23/2tJFg=
X-Google-Smtp-Source: AA6agR7YC6a34aoZQV+vgq2FTvt8NUnTggvVcyC+RIWVPGRbz+Y/temb2uqswu2s3dUivxLdQl8C8Q==
X-Received: by 2002:a17:902:7b95:b0:172:9dc3:6c12 with SMTP id w21-20020a1709027b9500b001729dc36c12mr35089322pll.94.1662110433795;
        Fri, 02 Sep 2022 02:20:33 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s127-20020a637785000000b00429b6e6c539sm938712pgc.61.2022.09.02.02.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:20:33 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.songyi@zte.com.cn
To:     joonas.lahtinen@linux.intel.com
Cc:     rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/i915: Remove the unneeded result variables
Date:   Fri,  2 Sep 2022 09:20:27 +0000
Message-Id: <20220902092027.320738-1-zhang.songyi@zte.com.cn>
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

From: zhang songyi <zhang.songyi@zte.com.cn>

Return the mul_u32_fixed16() and div_fixed16() directly instead of
 redundant variables.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/gpu/drm/i915/intel_pm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 210c1f78cc90..a6757ed9081a 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -5272,7 +5272,6 @@ skl_wm_method2(u32 pixel_rate, u32 pipe_htotal, u32 latency,
 	       uint_fixed_16_16_t plane_blocks_per_line)
 {
 	u32 wm_intermediate_val;
-	uint_fixed_16_16_t ret;
 
 	if (latency == 0)
 		return FP_16_16_MAX;
@@ -5280,8 +5279,8 @@ skl_wm_method2(u32 pixel_rate, u32 pipe_htotal, u32 latency,
 	wm_intermediate_val = latency * pixel_rate;
 	wm_intermediate_val = DIV_ROUND_UP(wm_intermediate_val,
 					   pipe_htotal * 1000);
-	ret = mul_u32_fixed16(wm_intermediate_val, plane_blocks_per_line);
-	return ret;
+
+	return mul_u32_fixed16(wm_intermediate_val, plane_blocks_per_line);
 }
 
 static uint_fixed_16_16_t
@@ -5290,7 +5289,6 @@ intel_get_linetime_us(const struct intel_crtc_state *crtc_state)
 	struct drm_i915_private *dev_priv = to_i915(crtc_state->uapi.crtc->dev);
 	u32 pixel_rate;
 	u32 crtc_htotal;
-	uint_fixed_16_16_t linetime_us;
 
 	if (!crtc_state->hw.active)
 		return u32_to_fixed16(0);
@@ -5301,9 +5299,8 @@ intel_get_linetime_us(const struct intel_crtc_state *crtc_state)
 		return u32_to_fixed16(0);
 
 	crtc_htotal = crtc_state->hw.pipe_mode.crtc_htotal;
-	linetime_us = div_fixed16(crtc_htotal * 1000, pixel_rate);
 
-	return linetime_us;
+	return div_fixed16(crtc_htotal * 1000, pixel_rate);
 }
 
 static int
-- 
2.25.1


