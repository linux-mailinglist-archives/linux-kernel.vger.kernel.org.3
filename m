Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15102510A55
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354975AbiDZUZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355046AbiDZUY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:24:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543AA2657B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:21:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id iq10so6127533pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PC82LstV6tocxMGUgC+f9s/KheVTFFbt3d61yAZ2go=;
        b=kTSO+u0oPyCgqiOMOit0gAUCMZRNZxANk+X/wb8YJ7K82r0PKU60PVtTM8yJOlTVI2
         tQA12jy2wCF8duMMzy++AdPcptLc7XN5vhaE+zINVCTQzuObUq8Wn6KcAXnaYuxvXlUF
         F9idAg4n+2jPJzP/RL1PE2pxV3+gzUC68C5PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PC82LstV6tocxMGUgC+f9s/KheVTFFbt3d61yAZ2go=;
        b=UjDQuCgNVpfWHiYhN/7Ybh4r7UVtuLH4zKvIKSePuyp04hrJZpCCfuYguD6khOyCe/
         lYte1jOCVnTIw6/BvGf0QACLMxrj3Zs4SLQj3/HJ3qo00QgisgYxKfyl/TSL3EvcuCxZ
         b7IEeVPWr0VUBi1aU/dCkT1WOGmH9EXFjNq+3XcNDNsFuh6TsnNARnxMxh5YmgppBNDl
         Onb8w3s5Qp8F2UZrT6EtXbiNlVzDschC0bQ6kFgOK0ILHkdA4B46NKhPGFk96vNzKLMs
         NWml58OlHao23o1o8iwz0h8iNLtDgcmwFzNo055mthyw4+zeeQpGJWdjBObP6szE6gFk
         WRug==
X-Gm-Message-State: AOAM532VPleKzRVqUmZ3aQKRIQkMFE6OvVUc3irb2zCdYwZsT+Dnl1LR
        vOgXbZHyu4qRlU0+WlscC8Iw/Q==
X-Google-Smtp-Source: ABdhPJzNq1iE5QQhWz5FHSE6fbIuvdm3ZiwM9Z8WYDwJn0e17SMpLk/f5RFeGQ7Yc2aCs/MGDJFQ/Q==
X-Received: by 2002:a17:902:dac1:b0:15d:356:887c with SMTP id q1-20020a170902dac100b0015d0356887cmr14441943plx.78.1651004509863;
        Tue, 26 Apr 2022 13:21:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:8e92:9f42:eda6:c0ee])
        by smtp.gmail.com with ESMTPSA id h195-20020a6283cc000000b0050d2c0729b0sm11285215pfe.18.2022.04.26.13.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:21:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        quic_aravindh@quicinc.com, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org, quic_sbillaka@quicinc.com,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/edid: drm_add_modes_noedid() should set lowest resolution as preferred
Date:   Tue, 26 Apr 2022 13:21:26 -0700
Message-Id: <20220426132121.RFC.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're unable to read the EDID for a display because it's corrupt /
bogus / invalid then we'll add a set of standard modes for the
display. When userspace looks at these modes it doesn't really have a
good concept for which mode to pick and it'll likely pick the highest
resolution one by default. That's probably not ideal because the modes
were purely guesses on the part of the Linux kernel.

Let's instead set 640x480 as the "preferred" mode when we have no EDID.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/drm_edid.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 7a8482b75071..64ccfff4167e 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -5839,6 +5839,15 @@ int drm_add_modes_noedid(struct drm_connector *connector,
 			continue;
 		mode = drm_mode_duplicate(dev, ptr);
 		if (mode) {
+			/*
+			 * The drm_dmt_modes array is sorted so that lower
+			 * resolutions come first. We'll set the lowest
+			 * resolution mode as preferred. We have no EDID so
+			 * we should prefer the lowest resolution mode as
+			 * the safest one.
+			 */
+			if (num_modes == 0)
+				mode->type |= DRM_MODE_TYPE_PREFERRED;
 			drm_mode_probed_add(connector, mode);
 			num_modes++;
 		}
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

