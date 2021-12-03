Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89648467368
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351240AbhLCIrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379246AbhLCIrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:47:00 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D8BC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 00:43:36 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 133so2333045pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 00:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZE+eyVTlgGs9+AIP2vmWrN/5/319nQUIDXkWbwr6YtE=;
        b=VDbYfoQXRs9UHxCEK9S7OW6FTx6guHxJyZPP8BKTaq0BFlv1ouM9tI/H+QI2QIkmUK
         vgNlj4Ue10IZAYAlk/k49AlI32/okqaqbppNdQK7LogVZRyeh01/lzK3NNuCqwX+eMPD
         rsCM4drqg2NnCzdiVRNfrrH8YCSrmsLck/IT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZE+eyVTlgGs9+AIP2vmWrN/5/319nQUIDXkWbwr6YtE=;
        b=e1XnlV586zMaHk8Y37eyWkNkj+UWh+47vPgnirUdIGWzAe9eq9XXGy4D6iveOy9PJt
         ScaYpMkCQX200jDRg7bak0mTtV57rr34TroPGYYTaBqpVcpvywR4Seqb0bBVFzCnNGpN
         j0JPDLxCL9DRnqjY2p3Q4Z2M8jTn6NjnJ+3O0B8uMnZ80yMbBjH+a8We20jT+tqeC7ob
         fiBWUPSoSm+tk9H9z4nQppwvubbp9ZDjHLqcoAEbJVQGBRuDXNWIEn/Ptob+PSP6tKJg
         AEx7mZJ38mxQJ3rhY8jk8OC0Z/D23EkY3ltvFruSjf9T2VBFr1SVVGUf1trmdIrAWUSD
         ta4w==
X-Gm-Message-State: AOAM533GQBaGkuwmEBZDz8AIdXHKPiSWrC1ogX3+5SUwe2D6nkddCCAf
        ajfZaTJCqYNaF3WAWTMHWHeCNw==
X-Google-Smtp-Source: ABdhPJwQfA/hRvvynLK4rv8xy6QfeakwaLWnL/8X265xiYrZ7weDjYz9N+w5NMQ2McIaic7OerHAMA==
X-Received: by 2002:a63:2542:: with SMTP id l63mr3502793pgl.431.1638521016128;
        Fri, 03 Dec 2021 00:43:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g20sm2838048pfj.12.2021.12.03.00.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 00:43:35 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] drm/dp: Fix off-by-one in register cache size
Date:   Fri,  3 Dec 2021 00:43:33 -0800
Message-Id: <20211203084333.3105038-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; h=from:subject; bh=rsrmXkTfjT0xKWn6tW4v+AFF+Qh9FSj0rQAAqFtZsnE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhqdi1VB8a7JgU9iVrIiez0JAFg3QRkKnyojAvpfmk xGJenGaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYanYtQAKCRCJcvTf3G3AJqDrD/ 0Q+WlLCtIOelpAxkp8i+3mzggF/AKL3hGb0fhgFfr9eL9oxCO1iQd/QVz2OFadF0kFQnNrCXYxSJs8 1/B1Bzi03yQGmwxPIuwwbg9ptXI7iFNa+s80WXYT/HVmQ5YhLMiRE/TyY3AQBt9xDgYWpHRD97reQr 49WW92g7ss6Q4EU6rXL3s3iooH1ZRsg6dueYFAzVgOO8O7YIjMRPKFwhquL9zdU3fjZqzYmKEwLt22 tkERTbWN82Q6g0k+SVAeLR1iTI4tPwFr3Vy9FzAf+USQA2EAG/v9EQilBmGbRgmjDMXr+4EXqyqTie 7904y4yhNPlflKyU/Y34LYTBQTddQWL7QjK78RtgwFjtKptCyj+WMnHReEExsZnfGLeiKW/KmN8IhW l7ftFOGMzOUiwOQQkdEuveoUoxciBZFbzpwsqoA4uwwMajShbSLtO/c1JP/x+/A/XTHdz3bsussdV1 ehpcCbWNIN1WZJnX3GHM/K4eUT6ESl1ZWnkex/7KfwKXmwOydgLLuzhVjEYGXWhT30kj7HSIaZp6WI Xbk10bTyszsaJunW6tdhjRtB4FjbGYT0Y0KuAbKTHqkihlqeXUv7Ss0zJJ9u5EU/FWY9YKHE6NrLIg 077Wg3pDM8XyeZ6VIeYvaqhsWd0ceqfxO2gwgpDqf6WJwg/Gm7y1dFUxnofg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcon_dsc_dpcd array holds 13 registers (0x92 through 0x9E). Fix the
math to calculate the max size. Found from a -Warray-bounds build:

drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_pcon_dsc_bpp_incr':
drivers/gpu/drm/drm_dp_helper.c:3130:28: error: array subscript 12 is outside array bounds of 'const u8[12]' {aka 'const unsigned char[12]'} [-Werror=array-bounds]
 3130 |         buf = pcon_dsc_dpcd[DP_PCON_DSC_BPP_INCR - DP_PCON_DSC_ENCODER];
      |               ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/drm_dp_helper.c:3126:39: note: while referencing 'pcon_dsc_dpcd'
 3126 | int drm_dp_pcon_dsc_bpp_incr(const u8 pcon_dsc_dpcd[DP_PCON_DSC_ENCODER_CAP_SIZE])
      |                              ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: e2e16da398d9 ("drm/dp_helper: Add support for Configuring DSC for HDMI2.1 Pcon")
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/drm/drm_dp_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 30359e434c3f..472dac376284 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -456,7 +456,7 @@ struct drm_panel;
 #define DP_FEC_CAPABILITY_1			0x091   /* 2.0 */
 
 /* DP-HDMI2.1 PCON DSC ENCODER SUPPORT */
-#define DP_PCON_DSC_ENCODER_CAP_SIZE        0xC	/* 0x9E - 0x92 */
+#define DP_PCON_DSC_ENCODER_CAP_SIZE        0xD	/* 0x92 through 0x9E */
 #define DP_PCON_DSC_ENCODER                 0x092
 # define DP_PCON_DSC_ENCODER_SUPPORTED      (1 << 0)
 # define DP_PCON_DSC_PPS_ENC_OVERRIDE       (1 << 1)
-- 
2.30.2

