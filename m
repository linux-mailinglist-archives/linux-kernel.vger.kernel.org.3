Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEFA4AE055
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384451AbiBHSIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiBHSII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:08:08 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CECC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:08:04 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w11so32293031wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JMh0kEFjwRWWk+1XHv7gVJ8Hpyf3EWCdFFn+Jweb7k=;
        b=TBxL7N3MT59b7iiL8T3Liji0tNYRV0YQpr4VmZbtlCwTDF6guicYakW3piuqkblF6P
         z5w66wT4auVoLP/HQsQfYoQIi2zUJIO32+Qg98sUNPevUEo+zZDuyUXV1t7LLIszesZC
         sB36y65LcRJKT18Dk2koP4XEHOUhVJKWU5TUZgq62Eu6dYAbIfUZb6H1sTmGneM2zPfQ
         Ho3tEIrIe3vh4urF9r9MPrmqzOIYc7jPdtdzoDxlHNGbQ7zfocSkk7C1stAjVhUpiGu6
         cL+fuzXHxh6MAGkBdSnMiwNDf6mQtm5UuazSL5MsFW457C6jagrNgaxTyZ0mtukOPMUe
         WiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JMh0kEFjwRWWk+1XHv7gVJ8Hpyf3EWCdFFn+Jweb7k=;
        b=ZS5yBffzMFNfTQXJ9meVsXjrHcKyO3bkHaccjtPzgCyVPhpEPk6wchUM2CSZNAm3ya
         wn8GmOI4Q3C8Cvuq4fX6EOOiXZ5aDtdohSKYDbpqwgoWt3T3xtutB2kmXY6z/jFlec2V
         C14LjPgXHL3e14yqPCc3xrdeWLTK2mvKWb/H4CJJGytJKCVjD+ZWalMqtih29s5Utb3x
         hsSWWTTUwZW0kvpQj7FCMs0PvtxphBFqjeL865fDKxH/J9lHBhBkPP2yjnse1uvk1IkF
         tRu+GcVjYn1lLR7xz2rYiCOWd4ARANI9YG6hyvcMIVVrQ0Vb+vlWk40lPc6W4TxU5N3Q
         Vcfg==
X-Gm-Message-State: AOAM5306xDk+cJd1cRyIqhBJ3EHeIh8Or3KYTGdskMtZL+aA86PuEmSZ
        KyI3em41ACx1GnCpZBB5yz5tc3c/dFE50g==
X-Google-Smtp-Source: ABdhPJxtksjX91rPiGjY9Ly7fTiS/Xhqn6J3q2EbZpF9HlFuxavVAE6e4Z+m2/JR4F8eDfTQluGJpA==
X-Received: by 2002:adf:f504:: with SMTP id q4mr1514450wro.670.1644343683027;
        Tue, 08 Feb 2022 10:08:03 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id j46sm1218519wrj.58.2022.02.08.10.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:08:02 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     rodrigosiqueiramelo@gmail.com
Cc:     contact@emersion.fr, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Chris Healy <cphealy@gmail.com>
Subject: [PATCH -next RESEND v3] drm/vkms: set plane modifiers
Date:   Tue,  8 Feb 2022 19:07:46 +0100
Message-Id: <20220208180746.24141-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

v2:

  Implement format_mod_supported (Simon Ser)

v3:

  Now that "drm_plane_funcs.format_mod_supported" has been made truly
  optional [1] its implementations has been removed.

  [1] https://lore.kernel.org/dri-devel/20211222090552.25972-1-jose.exposito89@gmail.com/T/
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

