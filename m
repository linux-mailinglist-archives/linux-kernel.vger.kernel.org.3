Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29938479579
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbhLQU3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbhLQU26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:28:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A75C06173F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:28:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso6984686ybl.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9buOhFi0q+Dx/OMfzTqRPp5hw+SV6/dM42HWcYuNNO8=;
        b=P66pa3NcByvXTlgt0CoajClGTkCuKScmYPVO/GC/7GIFd5e9PTTGrSSUBNkmJ1ONwy
         cNfw/vooGPmlxJPnexTZklmAoS/ED6I9WMdalVFo1INHssCF0H2R28H3qwssvKkvsM8K
         7Yd2BA02rywzvDdUJN/uilAuPtQ5M9V1OWUmMX1r++HRUUy/o3CW+wm1avDI3lA3Qy3Z
         ApmTmui9Q8xAPo2rdMgV+lqRTIrSP1GvjyGwSrD0uo92aNkm0wd6sytsnLcdaNZ3guho
         XLeORcPpHY2FdkTIxm77R38sg5v7ZOZmksRBz+cvBtTKaNCbRLv7N2IdsCUqfmy1rLnE
         pSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9buOhFi0q+Dx/OMfzTqRPp5hw+SV6/dM42HWcYuNNO8=;
        b=6hdh3/GSaWpJIhBj59k07qcRFzBEP96j4T0MsIFhZEQeFdGgdOH8um7EXt+RjEn6sn
         RAsgWHJFSib5jyb0cdlYKemtxqc+xLDdoiMIjghMQ60YU7pU8a15Nd5TSroI1uuoROEZ
         yICXJ3aE8h8mHY5tSp0maU6Ke7nfx2TYAWpe6dXrI5W2KtBo8v9/xMWg4RuXFD6VzmKI
         cnXMo5PWN+8+y3GJZK/tgo9W9/ovOvqHNDGhiPjB/a1t2uxosgL0+yoE0zvOo5XTD22U
         hAZsO2UZVY3ZI9mcPV2GMELr/7d3AKuFQKhub49Uqeof0NGKtJB3kQXQh8zrfnG226Ua
         iBwQ==
X-Gm-Message-State: AOAM530hY94uKKTgbznZ5TXH/GjsSOmiDIx2nj9OqnlaU/olOc62FwwU
        KQ2DVMA2i+bhO9g9qJD0zba4HJbNvPPw
X-Google-Smtp-Source: ABdhPJxCNefaz2E9hWLS/2ohTOPd+lksZ93cTIt4DZZY2vVGhK/t8zXAXkUWbgXIDdW5t4c3oRMrMHeaWvZp
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:1bc7:219f:9362:ade9])
 (user=rajatja job=sendgmr) by 2002:a5b:c4b:: with SMTP id d11mr6627318ybr.452.1639772937573;
 Fri, 17 Dec 2021 12:28:57 -0800 (PST)
Date:   Fri, 17 Dec 2021 12:28:50 -0800
In-Reply-To: <20211217202850.1967594-1-rajatja@google.com>
Message-Id: <20211217202850.1967594-2-rajatja@google.com>
Mime-Version: 1.0
References: <20211217202850.1967594-1-rajatja@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 2/2] drm/privacy_screen_x86: Add entry for ChromeOS privacy-screen
From:   Rajat Jain <rajatja@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        gwendal@google.com, seanpaul@google.com, marcheau@google.com,
        dtor@google.com
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a static entry in the x86 table, to detect and wait for
privacy-screen on some ChromeOS platforms.

Please note that this means that if CONFIG_CHROMEOS_PRIVACY_SCREEN is
enabled, and if "GOOG0010" device is found in ACPI, then the i915 probe
shall return EPROBE_DEFER until a platform driver actually registers the
privacy-screen: https://hansdegoede.livejournal.com/25948.html

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: * Use #if instead of #elif
    * Reorder the patches in the series.
    * Rebased on drm-tip

 drivers/gpu/drm/drm_privacy_screen_x86.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
index a2cafb294ca6..0c5699ad70a3 100644
--- a/drivers/gpu/drm/drm_privacy_screen_x86.c
+++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
@@ -47,6 +47,18 @@ static bool __init detect_thinkpad_privacy_screen(void)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
+static bool __init detect_chromeos_privacy_screen(void)
+{
+	if (!acpi_dev_present("GOOG0010", NULL, -1))
+		return false;
+
+	pr_info("%s: Need to wait for ChromeOS privacy-screen drvr", __func__);
+	return true;
+
+}
+#endif
+
 static const struct arch_init_data arch_init_data[] __initconst = {
 #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
 	{
@@ -58,6 +70,16 @@ static const struct arch_init_data arch_init_data[] __initconst = {
 		.detect = detect_thinkpad_privacy_screen,
 	},
 #endif
+#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
+	{
+		.lookup = {
+			.dev_id = NULL,
+			.con_id = NULL,
+			.provider = "privacy_screen-GOOG0010:00",
+		},
+		.detect = detect_chromeos_privacy_screen,
+	},
+#endif
 };
 
 void __init drm_privacy_screen_lookup_init(void)
-- 
2.34.1.307.g9b7440fafd-goog

