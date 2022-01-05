Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057D4485743
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbiAER3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242235AbiAER3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:29:31 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4898C061201;
        Wed,  5 Jan 2022 09:29:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so2150760wmb.1;
        Wed, 05 Jan 2022 09:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/KLdWPq2TSaneQFglZodsHn4AgWZAik17MpBqvatAUA=;
        b=BAn3+iUQ0dqioR3HJwq+czhX93m962svq4IVH6J3qNJRzpSb3YJJUvH08ve/94iTM3
         u21cpMA8eel3N0sX3VG0bDUYMTVOk/MVPoR5ySWY2bGn3w/WnLA2/lDlMT9Da9fsvIQR
         jMoopLNOP95QxBioY4NDmrSF2AN1P0gTbS8iPxnr5h2EQlziWu6w92GEgSFAfmHwZj/v
         JtYzmlBzv4G6XYcq6qOS37krkR7F9g+XhbaldWX0WCdULvcGkTZPGrBJWsWbGnTD3DVF
         /8aTd2BSPa7cUnEKTW10ur2u9Wzmt0aLERjzIrdGKGsYA3e+JQTyC7q0efzWP9NHSvEg
         V7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/KLdWPq2TSaneQFglZodsHn4AgWZAik17MpBqvatAUA=;
        b=et0nhsdDjFOOL9vmM4Q5pz03vzT0Lu8gKTDfeunKaI2yKKHS2BfaxHJIwTYh8/X/wE
         AuwjXZUiZB3k0U5d5DrTEGAWDyqYFovf0X8UM/EHCB/gkPmzLBmeWa3hl7mY4dMckHZu
         GSFtJucmV+Hemwj3VeShmrFLDEyGeVbgKPrvO92M4C7M16L5uGeNZtbK1drBQaXA3XVv
         XibCYaJ7a8sDovAhpfMF5yEwRoAQuvOlmjJVy83MzmInqaSUCFEDlCz+HZAlMlMl7UDB
         g9hEJhJ9rTT1PYiSEso03oTpyJSC2Ch4fyeXjuNrRaP+kcHijjm+YTDOnar3xHUuSM94
         NgwQ==
X-Gm-Message-State: AOAM533+ZgoWLJD9msEKRrUEaKxcG7jnK9gNerbOEE9UcxXcA+gis2NX
        g3PreE06NKWa+pekfQbqVPU=
X-Google-Smtp-Source: ABdhPJwVS4+SzhHbQTHSejCm1ylGwMd7EpICFV/Iu43Pvr7T7PFRWlZKMdVMlcjFcGInXBKBmTwWVQ==
X-Received: by 2002:a05:600c:3589:: with SMTP id p9mr3822613wmq.65.1641403769390;
        Wed, 05 Jan 2022 09:29:29 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g6sm43071442wri.67.2022.01.05.09.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:29:29 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, spbnick@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 4/4] HID: hid-uclogic-params: Invalid parameter check in uclogic_params_frame_init_v1_buttonpad
Date:   Wed,  5 Jan 2022 18:29:15 +0100
Message-Id: <20220105172915.131091-5-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105172915.131091-1-jose.exposito89@gmail.com>
References: <20220105172915.131091-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function performs a check on the hdev input parameters, however, it
is used before the check.

Initialize the udev variable after the sanity check to avoid a
possible NULL pointer dereference.

Fixes: 9614219e9310e ("HID: uclogic: Extract tablet parameter discovery into a module")
Addresses-Coverity-ID: 1443763 ("Null pointer dereference")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 4136837e4d15..3e70f969fb84 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -452,7 +452,7 @@ static int uclogic_params_frame_init_v1_buttonpad(
 {
 	int rc;
 	bool found = false;
-	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
+	struct usb_device *usb_dev;
 	char *str_buf = NULL;
 	const size_t str_len = 16;
 
@@ -462,6 +462,8 @@ static int uclogic_params_frame_init_v1_buttonpad(
 		goto cleanup;
 	}
 
+	usb_dev = hid_to_usb_dev(hdev);
+
 	/*
 	 * Enable generic button mode
 	 */
-- 
2.25.1

