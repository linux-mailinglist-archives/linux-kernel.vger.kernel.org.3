Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB08847B5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhLTW3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhLTW3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:29:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1B9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:29:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y125-20020a25dc83000000b005c2326bf744so21750065ybe.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fksgA1JsDJpYuy0g0e7IGPB8FkPT8ahC676Z+SBk5d0=;
        b=e+5atsRINdfmhMu85Kr/tAJ7TrsaeUuxdCQLTvU0+Xrk4IYm96lVIa+5DRuZfPxMtY
         MNbBAfxGzbhcucB8PMyMvRB7XBftaV5ZXWJxiiAoIqGt6ldQEPwx21iGX9GgZesD9jx3
         htU6B+xl/3DoWdZupBUOHRLqmNnQd+CyigxzAJTFB3ABYke0O50KOencRIXmkEvRbllz
         c6e+a3masCoiLqB33CZbf8dLtOO0/QqbPf9kVrvFEhvs6On0IdSUT53xBiUwh32VDhQK
         SEThbYVuxk6HdFQ+lPeoHPIdaw/WhO4ddxGUTa3fgP/8XEb0Nh39J5sSd3fcFccajl9y
         trkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fksgA1JsDJpYuy0g0e7IGPB8FkPT8ahC676Z+SBk5d0=;
        b=7MIxQBuczep+kzOWlLAxMpZ/dJcLB4RN2iKc8gjebfhEpYx4ft94Uzl2AIcpfhiLHG
         wtkcb6h55wz+xmX58G7nIkMl1Xhb7jNZ9TBY+zxkYG9RDEK89iiEan9EAqJr3P9ShYc4
         r4gNUXzD0LTEvAGqDMkgf1jU+UNi0JM4WMeEV8eKQKfJxIbnHnL8am/rw27YAKnZNs+u
         hQz+MG3BmY/6unwzLLRc0GK7CkIMEqSNDZcct5iR0zIWIKKoUksmuhpy7wcx6g3Qmorz
         nx/NVi6iHQYOr1DOZ17LHN71uI/4LNP0gAQ8GY7dG/MR0C7RxhSkzNrtoRpHE1omas0t
         nqyQ==
X-Gm-Message-State: AOAM5338W1t7x9vloFEtpPYKFIeXe70END/OVu0qt1/tgB8+iFCga9b+
        oVKl8ziKmDfv5gZqrlMCACrM65IrhTuH
X-Google-Smtp-Source: ABdhPJzrXPMAorJsrHo+Qwly1Bs2XrhOf9wwHctqzTpYT/FCrcPqa8tsV3CcEMZ8RHpJyIAgOErATcevbHqr
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:f6d7:6572:2e42:ea7d])
 (user=rajatja job=sendgmr) by 2002:a25:3b95:: with SMTP id
 i143mr380252yba.423.1640039360896; Mon, 20 Dec 2021 14:29:20 -0800 (PST)
Date:   Mon, 20 Dec 2021 14:28:28 -0800
In-Reply-To: <20211220222828.2625444-1-rajatja@google.com>
Message-Id: <20211220222828.2625444-3-rajatja@google.com>
Mime-Version: 1.0
References: <20211220222828.2625444-1-rajatja@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v3 3/3] drm/privacy_screen_x86: Add entry for ChromeOS privacy-screen
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
v3: * Remove the pr_info() from detect_chromeos_privacy_screen(), instead
      enhance the one already present in drm_privacy_screen_lookup_init()
v2: * Use #if instead of #elif
    * Reorder the patches in the series.
    * Rebased on drm-tip

 drivers/gpu/drm/drm_privacy_screen_x86.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
index a2cafb294ca6..0fdd2b500e6d 100644
--- a/drivers/gpu/drm/drm_privacy_screen_x86.c
+++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
@@ -47,6 +47,16 @@ static bool __init detect_thinkpad_privacy_screen(void)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
+static bool __init detect_chromeos_privacy_screen(void)
+{
+	if (!acpi_dev_present("GOOG0010", NULL, -1))
+		return false;
+
+	return true;
+}
+#endif
+
 static const struct arch_init_data arch_init_data[] __initconst = {
 #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
 	{
@@ -58,6 +68,16 @@ static const struct arch_init_data arch_init_data[] __initconst = {
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
@@ -68,7 +88,8 @@ void __init drm_privacy_screen_lookup_init(void)
 		if (!arch_init_data[i].detect())
 			continue;
 
-		pr_info("Found '%s' privacy-screen provider\n",
+		pr_info("Found '%s' privacy-screen provider."
+			"Might have to defer probe for it...\n",
 			arch_init_data[i].lookup.provider);
 
 		/* Make a copy because arch_init_data is __initconst */
-- 
2.34.1.307.g9b7440fafd-goog

