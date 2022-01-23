Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E0949758B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 21:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiAWUoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 15:44:54 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:43314 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240098AbiAWUox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 15:44:53 -0500
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E2DEDCE792;
        Sun, 23 Jan 2022 20:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642970692; bh=Pz8Rr0gE1WWTUWJgZZYIwX9EYZcudB1mDd1+9t7DnGk=;
        h=From:To:Cc:Subject:Date;
        b=O3dMVzDCrTDe2kJ9DXp6XL1Ps797A/hGgiMdIYJXDsoeDtz6OOkQPyt2CRFis+MjR
         Gv0QEYK4TKALhfCt1yzauhgrMVekMVlbxZd90DdjoRw/ndWA/XahxOsCB4KeKTdWRM
         a5zVrMBABimkB+2ZRMRVpqKutdQtJQa8kaXzgqLw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, Luca Weiss <luca@z3ntu.xyz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: add missing dependency to DRM_PANEL_EDP
Date:   Sun, 23 Jan 2022 21:43:23 +0100
Message-Id: <20220123204322.345725-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_DRM_PANEL_EDP=y and CONFIG_DRM_KMS_HELPER=m the compilation
fails:

  drivers/gpu/drm/panel/panel-edp.c:843: undefined reference to `drm_panel_dp_aux_backlight'

Add a dependency on DRM_KMS_HELPER to fix this.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
I briefly tried "select DRM_KMS_HELPER" but that causes a circular
dependency.
If someone has a better idea how to solve this, feel free correct me.

 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 434c2861bb40..fda97837ecb3 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -102,6 +102,7 @@ config DRM_PANEL_SIMPLE
 config DRM_PANEL_EDP
 	tristate "support for simple Embedded DisplayPort panels"
 	depends on OF
+	depends on DRM_KMS_HELPER
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on PM
 	select VIDEOMODE_HELPERS
-- 
2.34.1

