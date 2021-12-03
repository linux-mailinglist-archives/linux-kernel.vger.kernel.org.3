Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3C446736A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379246AbhLCIrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351255AbhLCIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:47:20 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D882C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 00:43:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r5so2366449pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 00:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jwfwvPS3SZnddmRu3EkHYo20QbmNUlRhVyPukNO4yM=;
        b=ixVYRox7qzvylyohIUWv2s6os/wzOij0nIdi3xWuyqLIrD4dH/csz0UlpXgSWJiKm9
         i6qR18mEajcrAwFh/8tkZ6nnSe6VyOZUzTKbd+w6ovjbsUzF6p8bVGqqgzrVO1Cc1zDU
         lI8PWoez6j7H1f/ybi+W8ZkoW4HVo0h7mHt7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jwfwvPS3SZnddmRu3EkHYo20QbmNUlRhVyPukNO4yM=;
        b=aZ6/SGrqfLgpHT45Vq5q3o645CgrXLlMkgP5N8s1NERqHsNxcyS70UfqTgsybxb5Sy
         WkGmkffXNcpxveVkagHBOj0pWXPf4gvPjtkm6P7rS765KNhpqSOkKpAybiE3TtH9uLP+
         PU3ij8hvfwX6n5FKsqC5efDxPakx7wT2vlWeGfVEpes2n6ibHDzgz5Qxig1zFou0DIwv
         fmqK404lN0UlnfyFdZt7pF1nl4gup5k2vbBMvfRfTD2n3Cue5FUzB/g6xepNAVYG401p
         3LyYuxrBnkfFKjhQd+cE7b4GTUO2Jx2QHL4EkvFlfCEo/AHRo+ewHeB3BWAMfjgHToGR
         seFQ==
X-Gm-Message-State: AOAM532fAzw0L0TBehkJcRV91H2LDdYPzREPDms/pLEKB4ixK77cvEdz
        cxHEhLWwuOeytdltzGnMzNFA6Q==
X-Google-Smtp-Source: ABdhPJxvHgcUEm6pkImumlN3NDt4T9kppox84nQO/xN59LmIgpvXK53wqI48a83X5fF4XuF0xUbdbA==
X-Received: by 2002:a05:6a00:b83:b0:49f:b555:1183 with SMTP id g3-20020a056a000b8300b0049fb5551183mr17859414pfj.32.1638521036989;
        Fri, 03 Dec 2021 00:43:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v10sm2349386pfu.123.2021.12.03.00.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 00:43:56 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <treding@nvidia.com>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org
Subject: [PATCH] drm/dp: Actually read Adjust Request Post Cursor2 register
Date:   Fri,  3 Dec 2021 00:43:54 -0800
Message-Id: <20211203084354.3105253-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1803; h=from:subject; bh=9JOQiuj7TTHMOIrtT48MH/xn46TtMCcgKbKW1dyTq3E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhqdjJBwKxJy6+JwZ4OqaSJ7ISRTYXbeTtcnduRNWr DglEwtSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYanYyQAKCRCJcvTf3G3AJuZ9D/ 9jk0wLyG83Y5p/DZnnFqqAkrkA/xqzdG+/IMe+N+7qZz48w+ZeQcXswMwHSIusHPxjMc7nb74BsN6h 0Uht0OXHp3Fn9sv7brKDeHpqPcjFB/gi8Xlk2Ntd/q6Bx835f7rx/WUlnwPrZXR54N+Nn0E6esMsu2 jv9wttfTOrWmmEfc3IQnhMMaUyHOgLwQM8/7Q39MVGqpw4jaDeUs5F6cXADXGUUVq0MbohUl9ae/DG gXHU857JO8QW6TAS2peVjNBgnASM2FsJWipqSqEHSHLI2RCrYI93Y6bxccrvaQX0ZCN1cyWqXHG8WK ehGJOB+qnrIIcxmNbdHkJlZPFI2gQEA3xft7ML+UUG2zd8waPYZtfAP8rOjx3R0Fwn4E7neIT2Q4PM 1HJ8ZpNH8BTVZ2cC4/ZwsyOlDhyVRfL1AHWDJ64mUfCQVjIYDlHjhxY7qIVS5PHaQmyn/e+EvtaM8a MMxG3O942mTTNrR+71Csiwx3p1RdwMNCEJoYJhPNzP9dZPQ56c+ESOO9h/q43ZW3d3qGHh36noePNA lyCwskgg5N6OTsyqiMdtJKjTLbDKzUewAvkw6XIvPJod3uUzgxs08E9svfOgi51JKYgYbtAlZ9xBkl iEMVScEQ/7+d++me2Ktg6mnCVyVhB5AMHT4u2SZa4Enf9lTYnhFuXUc2zvjQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The link_status array was not large enough to read the Adjust Request
Post Cursor2 register. Adjust the size to include it. Found with a
-Warray-bounds build:

drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_get_adjust_request_post_cursor':
drivers/gpu/drm/drm_dp_helper.c:59:27: error: array subscript 10 is outside array bounds of 'const u8[6]' {aka 'const unsigned char[6]'} [-Werror=array-bounds]
   59 |         return link_status[r - DP_LANE0_1_STATUS];
      |                ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/drm_dp_helper.c:147:51: note: while referencing 'link_status'
  147 | u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
      |                                          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 79465e0ffeb9 ("drm/dp: Add helper to get post-cursor adjustments")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/drm/drm_dp_helper.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 472dac376284..277643d2fe2c 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1517,7 +1517,15 @@ enum drm_dp_phy {
 #define DP_MST_LOGICAL_PORT_0 8
 
 #define DP_LINK_CONSTANT_N_VALUE 0x8000
-#define DP_LINK_STATUS_SIZE	   6
+/*
+ * DPCD registers in link_status:
+ * Link Status:		0x202 through 0x204
+ * Sink Status:		0x205
+ * Adjust Request:	0x206 through 0x207
+ * Training Score:	0x208 through 0x20b
+ * AR Post Cursor2:	0x20c
+ */
+#define DP_LINK_STATUS_SIZE	   11
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
 bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
-- 
2.30.2

