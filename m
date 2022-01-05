Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8700D485755
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiAERfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiAERfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:35:10 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62546C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 09:35:10 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c3so119166pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tIC6uuWRKMlRN9gOImOZjC9PBybxdHFz2/AlVg+R3sY=;
        b=fBowwtQbsu73vuHnIg7R/ykQmzlw/+8OVSY9nwq6n+84ZwzOsAoT7/3Shi8yJJihUG
         nX/KVRrtC1VYWRKzdLjCEeBDcQ6RMINgkcbXR81zczv46VzZDKHirlx6R2V9pece747z
         7K3pyw434Japsntzij0eDiNxsM9+9/01ABdt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tIC6uuWRKMlRN9gOImOZjC9PBybxdHFz2/AlVg+R3sY=;
        b=UlaYcva1nMwqI/laISCckzulm4+jKiYvrtvQrj7IHWBRgGvu46Wqp/vbCpxKNWXQYx
         rz7ifmTq9O56EEgMQdfjAsndMlvtvx9RnEYx0IP1ICkKBN3xfGuf+eK3mE6NbsS1RboY
         UA3355kRUPsou64kLh20FkoDcJqNOHbCs0bwQAwvtbsDkNxdNEJXTbTC5jWSftiRy7/s
         zdhlMcEwRy1+urzWTU2rBj7FliNxg5XvFZiqb10RUXCHPbiyVXEVk+IgB7BBVniUaAV2
         4RKbVtK9WUWzLh1es+8Sfc1sY1y7Q+psIbAoeTJJC95Z2Xy4/4RWYcwAgXtVAU29njrL
         POaA==
X-Gm-Message-State: AOAM530DgRwKJK8CTPTAJZI/NT8i5U0HCP0KRYnpD6BGxQy73BwEUHtk
        Rhgztvg2dZViYO33e+3bSA63YQ==
X-Google-Smtp-Source: ABdhPJyTlrJsuhPVaJ6QnXY+UarEB//h1AKJBq8kF/RN4mCbv5Z6bn36JXuY0ndfaNEEDahv+61z7A==
X-Received: by 2002:a17:90a:8543:: with SMTP id a3mr938028pjw.108.1641404109952;
        Wed, 05 Jan 2022 09:35:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ls7sm3372767pjb.11.2022.01.05.09.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:35:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] drm/dp: Remove common Post Cursor2 register handling
Date:   Wed,  5 Jan 2022 09:35:07 -0800
Message-Id: <20220105173507.2420910-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4014; h=from:subject; bh=73h6EjWgnCSmfmbkSfUNBCV9VTZTOb7XCwDmD6zlz6w=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh1dbKi5OtSAWBzj/YGWn/GazhxEKMlTtqWjeRoBDb 1G0KF4eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYdXWygAKCRCJcvTf3G3AJjq4D/ 0VBFZ9LHP9VPZi909vPYapIM1Z4FjlvzBIAMQNjv+TO2UZRrOfKRvJnkm9mGEnEIpuajucKKXHxioO Qb2S081y9bbvPupYTU2SQ5BaLxhsY7ZOcNQEiwUUcYm/ugMDUF3ADmfq8YMxXmqByq9GALz07o+K2E XfWsw3/3gBHWry66zEw8KLi2mBisi+ukr1VtaWWsTiSw4MJgbTpnQkE/2+sQ9mo6cDzZPc5tSsvm5R 1iU8uEQtba9jMuRKFuVzr38IBR6ka+5Lw16l5mYJp746H4zqcAeVNAT0nhGKflUyj/8gtxYH0G5qyz 252nhRhVk96LyXdNw2VLk0j4AOJbOXxI2FuTcu0aL5DRzVzSdYMU+C35v9DWDCA5a5wfdh2/Y9tL9U ACnjusJpNNxoWRdV0pJDHB+htNxSJrZTK9CK7SShMn+ZBozu4e67vX0ePgh+DxdhGFR4j0cQT/OSGS hvenaq0nuEdSH9ECIFL/q9WFICFiPNNGx/bKcdMyWFsqo2JDn5c+Gg/z4CIZrR6iCaIohKkKCtlb3B KzIEhimkSDq3I2mLl/pS8d8FI9gGomVVtpa5bGqvMDRdsooVv+efWATl37Kl/6iUVrJ0E6sgXAwOhx WqKpGtxYsBAz0KKbBLe0xaNMcpIXJr5TLfV4tVJKOKpzoGTDHj4qijBJ/3tA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The link_status array was not large enough to read the Adjust Request
Post Cursor2 register, so remove the common helper function to avoid
an OOB read, found with a -Warray-bounds build:

drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_get_adjust_request_post_cursor':
drivers/gpu/drm/drm_dp_helper.c:59:27: error: array subscript 10 is outside array bounds of 'const u8[6]' {aka 'const unsigned char[6]'} [-Werror=array-bounds]
   59 |         return link_status[r - DP_LANE0_1_STATUS];
      |                ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/drm_dp_helper.c:147:51: note: while referencing 'link_status'
  147 | u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
      |                                          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Replace the only user of the helper with an open-coded fetch and decode,
similar to drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c.

Fixes: 79465e0ffeb9 ("drm/dp: Add helper to get post-cursor adjustments")
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is the alternative to:
https://lore.kernel.org/lkml/20211203084354.3105253-1-keescook@chromium.org/
---
 drivers/gpu/drm/drm_dp_helper.c | 10 ----------
 drivers/gpu/drm/tegra/dp.c      | 11 ++++++++++-
 include/drm/drm_dp_helper.h     |  2 --
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 23f9073bc473..c9528aa62c9c 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -144,16 +144,6 @@ u8 drm_dp_get_adjust_tx_ffe_preset(const u8 link_status[DP_LINK_STATUS_SIZE],
 }
 EXPORT_SYMBOL(drm_dp_get_adjust_tx_ffe_preset);
 
-u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
-					 unsigned int lane)
-{
-	unsigned int offset = DP_ADJUST_REQUEST_POST_CURSOR2;
-	u8 value = dp_link_status(link_status, offset);
-
-	return (value >> (lane << 1)) & 0x3;
-}
-EXPORT_SYMBOL(drm_dp_get_adjust_request_post_cursor);
-
 static int __8b10b_clock_recovery_delay_us(const struct drm_dp_aux *aux, u8 rd_interval)
 {
 	if (rd_interval > 4)
diff --git a/drivers/gpu/drm/tegra/dp.c b/drivers/gpu/drm/tegra/dp.c
index 70dfb7d1dec5..f5535eb04c6b 100644
--- a/drivers/gpu/drm/tegra/dp.c
+++ b/drivers/gpu/drm/tegra/dp.c
@@ -549,6 +549,15 @@ static void drm_dp_link_get_adjustments(struct drm_dp_link *link,
 {
 	struct drm_dp_link_train_set *adjust = &link->train.adjust;
 	unsigned int i;
+	u8 post_cursor;
+	int err;
+
+	err = drm_dp_dpcd_read(link->aux, DP_ADJUST_REQUEST_POST_CURSOR2,
+			       &post_cursor, sizeof(post_cursor));
+	if (err < 0) {
+		DRM_ERROR("failed to read post_cursor2: %d\n", err);
+		post_cursor = 0;
+	}
 
 	for (i = 0; i < link->lanes; i++) {
 		adjust->voltage_swing[i] =
@@ -560,7 +569,7 @@ static void drm_dp_link_get_adjustments(struct drm_dp_link *link,
 				DP_TRAIN_PRE_EMPHASIS_SHIFT;
 
 		adjust->post_cursor[i] =
-			drm_dp_get_adjust_request_post_cursor(status, i);
+			(post_cursor >> (i << 1)) & 0x3;
 	}
 }
 
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 472dac376284..fdf3cf6ccc02 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1528,8 +1528,6 @@ u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SI
 					  int lane);
 u8 drm_dp_get_adjust_tx_ffe_preset(const u8 link_status[DP_LINK_STATUS_SIZE],
 				   int lane);
-u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
-					 unsigned int lane);
 
 #define DP_BRANCH_OUI_HEADER_SIZE	0xc
 #define DP_RECEIVER_CAP_SIZE		0xf
-- 
2.30.2

