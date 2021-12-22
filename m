Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8E547CA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbhLVALj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238309AbhLVALh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:11:37 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DA8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:11:37 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id fw10-20020a056214238a00b003c05d328ad2so737334qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YYb+8tLZ47QzRVX8j4athTjjpGdUhJh58y4J69hbL0Y=;
        b=TM9tBt+zGKZxNfTdWhBaBCEIjk8AYxQEhDF68xQ3fyxhJ7s/QixPumAStVUXRUIx6I
         HG0saNv/V5pSDkeCImQqNAHjaSHgKsjzkIeQ9XmEAKhIG6kjySluWUhvNqrVITWvYgLG
         ayqZz6Q3VVm5BKdngrbKJ8ac2bxIQI40R7iJ3+iHXq84QEEVGYJmATN8H380523HdYzA
         NxI6U4eFie4urepMv5sDYK8D68NpNqGROch5ZO64oBSak7kbvyGPZ9Y0DQ7YpDabmGgH
         l/8L8e7K96Am5YAFNeihy9qAnV5xpLfp4LIUMkzeHHSB7OfnZ+YJlgDW4Gpit8MgUIDH
         0UFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YYb+8tLZ47QzRVX8j4athTjjpGdUhJh58y4J69hbL0Y=;
        b=RnjTWQ/IlmLeLXh+bYwBcDVkdSlfQKonon3sbaH1j4gkaG4xwkL5Q4eqJ3cbYBCvod
         SztuqXtIjGDGEBuG6Ga0cB0gA9ipiK6jqvB7pqf471Ep+reEU/N4YrT3IbJMI/dJhcCM
         FqHNWMuxguo2ZeKzwfDM0CHrafUqdl2huK7CGW54vMcPO/O/AJ5DjiXiG70NASSiX/eq
         6eHeL9/4QttxLROp5of5gRLkRnQ56FUeNFOh0XCEvKfb5FF7lKPVky1K+PwH/3Iv+vv3
         GlP3rihiJve/BnEvIu9q2DwbqnU5eZlz0s1kcwEKufstYQgJAx0eAOl5ftefFO+93t43
         nrvg==
X-Gm-Message-State: AOAM532awzPJaCrMHQzAc0RN9ueIp2OnigI22iX3LwJDrsSt5Yz+U6/N
        5MNHsYOK1MabeJFLcqUw3ootaBxaSZdD
X-Google-Smtp-Source: ABdhPJxQwLEuYw7TjPR7onP8Y2kPEBKoK0AWyW10YKyCPQO4WG8nydIrFxyGVJpkk1pyNsa/7iLdM7fhropu
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:8d27:feea:1b0b:3782])
 (user=rajatja job=sendgmr) by 2002:a05:622a:11ce:: with SMTP id
 n14mr539152qtk.432.1640131896647; Tue, 21 Dec 2021 16:11:36 -0800 (PST)
Date:   Tue, 21 Dec 2021 16:11:27 -0800
In-Reply-To: <20211222001127.3337471-1-rajatja@google.com>
Message-Id: <20211222001127.3337471-3-rajatja@google.com>
Mime-Version: 1.0
References: <20211222001127.3337471-1-rajatja@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v4 3/3] drm/privacy_screen_x86: Add entry for ChromeOS privacy-screen
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
        seanpaul@google.com, marcheu@google.com, dtor@google.com
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
2.34.1.307.g9b7440fafd-goog

