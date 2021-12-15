Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB49475DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244939AbhLOQm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbhLOQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:42:26 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DF7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:42:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o29so17065818wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvzzcJBBRe/pXCF+v6jb3YyzpE8towMbOfGTpdBZYQ4=;
        b=Y/he0J6Lou1b7MK8UrLT4EAKChQ6wRnFzIemVHZMZCeMW/WAFa9sWB1PMvV5yKbNLy
         TSGt/WsYV01cW8EELmqGtGPajcsHjRw7qiPH73v5O2s1GHTj89wlriw0XsA7C7eofPmX
         5Gbbn9GRxCxBJ8GsxphD1mzARHA3tTvVDsj7qO6LFzFybTCD0ZftQx87a3BN1eIiW+pm
         b0m+CWGEnjiujkOALyZJD/GMHT1rFs2P9sUb1AN6cvk+4SBbTSIVI0aann4A+xD2rCDw
         QIyB9gDzW2mbRF0RHZHQ15MaIX5ba597mYAQcUo2a6xeR91FOPo+4+wya1/LOtivqiA8
         5ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvzzcJBBRe/pXCF+v6jb3YyzpE8towMbOfGTpdBZYQ4=;
        b=DCaz/iAEn3nc5d6bV4A1B1SspcMZ13vcX9eKebizjdKTXPXxkLsClCEyDfcVQggpeM
         t8IRiCDfEYR7ZYvmBSbHO0kw7yERRZhUkc5syC+S0jvB2ed835K1opkVNLptM6enru3x
         AMrf+UX8M4VkYOm+7zSCUF6lHrLn42gV7MfeGZejKviFqozFg25tJ0S9e+Mjhi07wmMx
         n6fjWCGkwUkNvZvkzlAQ0sbH38MnY2Amu7eKktAXDX3/iyXKUPw5DU50g2nKaRgGwZKf
         wRB+1bM4qMXUbDEDVYpqdCXruzCzzjSYMBgmTWVWLouEIdf5arRhFouWhC6A7RV8OaXU
         EoxQ==
X-Gm-Message-State: AOAM5304CbWpMsL28vzBm0Boe8WUh22YJPuhnU/tfDDGC0RYfss099K0
        305Ha/EZXg9EoANbW618Jxk7d0Yn9hkwgw==
X-Google-Smtp-Source: ABdhPJw4JBTMPtxa5ZwHTVMTxDQkDfoTJZtcvubScnA/WXNuCiBIpsjv1lyrwpTMJDGIIfafuHW4kw==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr685312wmf.187.1639586544711;
        Wed, 15 Dec 2021 08:42:24 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id p10sm2670828wrr.24.2021.12.15.08.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:42:24 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     rodrigosiqueiramelo@gmail.com
Cc:     melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/vkms: set plane modifiers
Date:   Wed, 15 Dec 2021 17:42:13 +0100
Message-Id: <20211215164213.9760-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where no modifiers are exposed, usually linear modifier is assumed.
However, userspace code is starting to expect IN_FORMATS even when the
only supported modifiers are linear [1].

To avoid possible issues, explicitly set the DRM_FORMAT_MOD_LINEAR
modifier.

[1] https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/599/diffs?commit_id=5aea1bc522f0874e6cc07f5120fbcf1736706536

Suggested-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 32409e15244b..1666fa59189b 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -20,6 +20,11 @@ static const u32 vkms_plane_formats[] = {
 	DRM_FORMAT_XRGB8888
 };
 
+static const u64 vkms_plane_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_INVALID
+};
+
 static struct drm_plane_state *
 vkms_plane_duplicate_state(struct drm_plane *plane)
 {
@@ -189,7 +194,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << index,
 					   &vkms_plane_funcs,
 					   formats, nformats,
-					   NULL, type, NULL);
+					   vkms_plane_modifiers, type, NULL);
 	if (IS_ERR(plane))
 		return plane;
 
-- 
2.25.1

