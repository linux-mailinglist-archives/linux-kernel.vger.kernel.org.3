Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE46487CBC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiAGTCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiAGTCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:02:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C983AC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:02:19 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c132-20020a251c8a000000b0060c39ab7d36so13487356ybc.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 11:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y6PAvnRuxROUR0bgSKQyDzG37YrnpW6c8zYDf6/qNiY=;
        b=mtFavPz7VtUvwAWVsH2koev6PorVIE4+YmHl27H+yWyjx9Kv/U5dkUqKuWcsjNUcZA
         GLpHvOwyUF9Iv04bkkwdi816HS0ia+I8fECRo3/EjzKblMJkC0AxPRIIxB0Ckm/H9wKe
         247/BoUoAUEQxAestHEyr7jhivVhfV5ZKHf6u12FGeu3DcINtW04sKpYyyYWjnBSF9vM
         QUjAyEgfk0cNjZi0ohudc2VzxLnFeoVi7+6ezxrUl0Ylxkrlmw6GItjxm/ru8icXz6JF
         gHR+m6WtqAvm9CvmIGfx59cdrvENRfdjy3Uq/Vg5iJu+OyNSaAdI9HpCm9e36/Cdojxy
         fG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y6PAvnRuxROUR0bgSKQyDzG37YrnpW6c8zYDf6/qNiY=;
        b=ojoQ1c9wQcfIH+gRJlM7wZu6RY3G0L6s/cluKUIvjgj32mTMRA06XcaHaJ+wDG70Vc
         G58Hta2R1dUO1KWRNA9GP95Zm5LtLnRBOJbplZ+SDVGNkgnQPIktNi0MgYb96jHl04/O
         kQayg0i2eyZ72Cb+pjPRuhODelNM68ZxIuLCv2ee3mHmbLzPNrQotWfJVRIMwhFctsCJ
         jfv/JBjkGpy3pqQw0D4ocPW+Aus3CCtSNQVglwBUJMGUtIG+6+e1eUBoVw/aJ9NUTuvD
         WO0XVNSLUsv7cbqW6JYRL8uaLtLostJWqwuyEvFfAmGhpCzp5UQMkdorj3GcZCF0jQF/
         qmfQ==
X-Gm-Message-State: AOAM530nmm0CB1erWvsk8xzb2crq7ReDYbP1TxEwTfcSbb2lJMtcH8nz
        5nI66hgkiD0tCvYxtwPEyaUGbCyEXVDX
X-Google-Smtp-Source: ABdhPJwAIfW3yyucuEGk/1pEFnwommgSoZNuKwzDcO9qTu2l2mP/KrodOH1cfOSVrm0vTviLlJNHcdwWs8Do
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:6a56:3de8:84b7:696d])
 (user=rajatja job=sendgmr) by 2002:a25:ab45:: with SMTP id
 u63mr66456905ybi.480.1641582139012; Fri, 07 Jan 2022 11:02:19 -0800 (PST)
Date:   Fri,  7 Jan 2022 11:02:08 -0800
In-Reply-To: <20220107190208.95479-1-rajatja@google.com>
Message-Id: <20220107190208.95479-3-rajatja@google.com>
Mime-Version: 1.0
References: <20220107190208.95479-1-rajatja@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH v5 3/3] drm/privacy_screen_x86: Add entry for ChromeOS privacy-screen
From:   Rajat Jain <rajatja@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, gwendal@google.com,
        seanpaul@google.com, marcheu@google.com, dtor@google.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@google.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v5: * Add Hans' "Reviewed by"
v4: * Simplify the detect_chromeos_privacy_screen() function
    * Don't change the existing print statement
v3: * Remove the pr_info() from detect_chromeos_privacy_screen(), instead
      enhance the one already present in drm_privacy_screen_lookup_init()
v2: * Use #if instead of #elif
    * Reorder the patches in the series.
    * Rebased on drm-tip

 drivers/gpu/drm/drm_privacy_screen_x86.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
index a2cafb294ca6..88802cd7a1ee 100644
--- a/drivers/gpu/drm/drm_privacy_screen_x86.c
+++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
@@ -47,6 +47,13 @@ static bool __init detect_thinkpad_privacy_screen(void)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
+static bool __init detect_chromeos_privacy_screen(void)
+{
+	return acpi_dev_present("GOOG0010", NULL, -1);
+}
+#endif
+
 static const struct arch_init_data arch_init_data[] __initconst = {
 #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
 	{
@@ -58,6 +65,16 @@ static const struct arch_init_data arch_init_data[] __initconst = {
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
2.34.1.575.g55b058a8bb-goog

