Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1364A813C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbiBCJNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:13:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58232 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiBCJNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:13:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 156E71F3A5;
        Thu,  3 Feb 2022 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643879623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=u5dzOBpi5slnG+KP3+FSjvUZbPbQH3eycn8SRktnow4=;
        b=kgUP145PH4fJet1Vjz0zJJk6SMTGLUPHA+0UqllhTB/vEnlpbRWKN9QzdaEnFnNWNx9Ajy
        LwmpD5EMxJXHzRXAMPYaTQezogVZ3+9kCqYfhxnLS/YvGLSeCl+GzGIrtQmg0w0/HqChLf
        szTn535BWcTFgN0Y4HRiLzezmKsJRI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643879623;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=u5dzOBpi5slnG+KP3+FSjvUZbPbQH3eycn8SRktnow4=;
        b=5CzlLWE2RNohTr6Xr9WQFijPxd54rTMGfLf4YtogWGHsa1ozDXZMUlbSk9hIUsJPnOzg/d
        qRcqZQLzMtk6LTDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7E0313310;
        Thu,  3 Feb 2022 09:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wxbhK8ac+2GtMQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 03 Feb 2022 09:13:42 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, lyude@redhat.com, linus.walleij@linaro.org,
        dianders@chromium.org, ardb@kernel.org, naresh.kamboju@linaro.org
Cc:     rdunlap@infradead.org, arnd@arndb.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] drm/panel: Select DRM_DP_HELPER for DRM_PANEL_EDP
Date:   Thu,  3 Feb 2022 10:13:40 +0100
Message-Id: <20220203091340.20285-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported in [1], DRM_PANEL_EDP depends on DRM_DP_HELPER. Select
the option to fix the build failure. The issue has been reported
before, when DisplayPort helpers where hidden behind the option
CONFIG_DRM_KMS_HELPER. [2]

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: adb9d5a2cc77 ("drm/dp: Move DisplayPort helpers into separate helper module")
Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-simple")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 434c2861bb40..0aec5a10b064 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -106,6 +106,7 @@ config DRM_PANEL_EDP
 	depends on PM
 	select VIDEOMODE_HELPERS
 	select DRM_DP_AUX_BUS
+	select DRM_DP_HELPER
 	help
 	  DRM panel driver for dumb eDP panels that need at most a regulator and
 	  a GPIO to be powered up. Optionally a backlight can be attached so
-- 
2.34.1

