Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202344970AB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 10:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiAWJLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 04:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiAWJLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 04:11:03 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8C9C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 01:11:03 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id k4so16652506qvt.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 01:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bl3efp74ab4pQlhH6DVOKc+JdDnTDiX+IOOPZRvKFIk=;
        b=ARUGGp+cvzIrVwH8Dm9kcolQ5ADQqS9hkzPW2oU/pvWuhoSxM/q+3AwrAeJ84YpQhJ
         5ZhsIcShNnEkSJNMFsmOMMbtVITZdiRQP9QHx7G6IHtKcHdJEAggLTGWyQ+DgjxwpVZi
         +54QUmZ5MbQS+9QIAYpovzahcH2ewcRB9ki0m+sDijroUtEdAzackUaZmmiqZyeNDyGA
         E4fgcq0GyqKkeqm8d6Jrcq/h/HJmfxyg2VCSPbXDs+L+wOIDhP/JpI7difpGQHbau9HJ
         UQdz6DTVHWH8EAf0PVoPQO3hJfPhJyc0JRlbt9C9aTF8eu2gVyZbh6vXaNcsdOceFQa+
         47Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bl3efp74ab4pQlhH6DVOKc+JdDnTDiX+IOOPZRvKFIk=;
        b=CFd0qWLzZUcu/APQgmBn+Nx5RTDKJIXLoJyvA2kJs6RM0S6EqoNP7AB0c8JVd0+90t
         iajnt4OwRRX9ryD9Ht+LKva+XmBRQfwk1vEuOYMuTpL0E1m0G6Qzt0k1Qya0FwRa83Rc
         Bj7EuNw+WVlu5ryWCtiVAqURxyCOBgAcJ74qf9SXiZVX4pCyNskFaSsQVS/7sfutVzCc
         rZUfMjQuvm9PaB7LfkpLEn+NoYaIpX5mAlNYOwU9EPLm0Gu82n+JVKc8xcHKBjAAxRhT
         cwwQYxKS1RkikRQV0PHLJrN7w1FR/j3NUQaSn9xbXJKkJ0fm8/PBslOLrGwv/pxFLahP
         RnaA==
X-Gm-Message-State: AOAM532oLEnJIGGekHx2E0mz6mwiH6d06tXADjSSB5FSRuFfdrVnffd7
        vo7BfMAKQ8AG22i5QuRPYbo=
X-Google-Smtp-Source: ABdhPJzpO7Zzbcg01kfGn5FLWvm4y0zy0xN+rM7LtfVAM1UaB6ZlAdZ8qZNpdEmOBJYjasgcxGuM8A==
X-Received: by 2002:a05:6214:260d:: with SMTP id gu13mr10100714qvb.100.1642929062764;
        Sun, 23 Jan 2022 01:11:02 -0800 (PST)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id o126sm5479158qke.53.2022.01.23.01.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 01:11:02 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH v2] drm/privacy-screen: honor acpi=off in detect_thinkpad_privacy_screen
Date:   Sun, 23 Jan 2022 01:10:04 -0800
Message-Id: <20220123091004.763775-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when acpi=off is provided in bootarg, kernel crash with

[    1.252739] BUG: kernel NULL pointer dereference, address: 0000000000000018
[    1.258308] Call Trace:
[    1.258490]  ? acpi_walk_namespace+0x147/0x147
[    1.258770]  acpi_get_devices+0xe4/0x137
[    1.258921]  ? drm_core_init+0xc0/0xc0 [drm]
[    1.259108]  detect_thinkpad_privacy_screen+0x5e/0xa8 [drm]
[    1.259337]  drm_privacy_screen_lookup_init+0xe/0xe85 [drm]

The reason is that acpi_walk_namespace expects acpi related stuff
initialized but in fact it wouldn't when acpi is set to off. In this case
we should honor acpi=off in detect_thinkpad_privacy_screen().

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
v2: fix typo in previous commit -- my keyboard is eating letters 

 drivers/gpu/drm/drm_privacy_screen_x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
index a2cafb294ca6..e7aa74ad0b24 100644
--- a/drivers/gpu/drm/drm_privacy_screen_x86.c
+++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
@@ -33,6 +33,9 @@ static bool __init detect_thinkpad_privacy_screen(void)
 	unsigned long long output;
 	acpi_status status;
 
+	if (acpi_disabled)
+		return false;
+
 	/* Get embedded-controller handle */
 	status = acpi_get_devices("PNP0C09", acpi_set_handle, NULL, &ec_handle);
 	if (ACPI_FAILURE(status) || !ec_handle)
-- 
2.25.1

