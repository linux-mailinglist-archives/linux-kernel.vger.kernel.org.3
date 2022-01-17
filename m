Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E17349011D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiAQFWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiAQFWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:22:04 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D46C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:22:03 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id h11so28410732uar.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0P1WTEs+C+NbyMn3/HlAbUcrz7+Kd9kkvPJ4rg/pU4s=;
        b=psesmIOPOr5OiIVxN1wHFuJUnLekk2YFVaXZamYwh14J7oRo6/pLggWrMKide9+iDp
         YjpQLCMsexC7a2YVtl9qxAoLsn92ZJ/+qT1CdQJ/tlPX2Dk8PfWEq4r61ehGEpr5xZHr
         Bha2INqQ2gaBoFhb/J2kvVauaiVgpDIZxO5F2LbJqRAKmNwfvn/M8NVG3E+H1Z3/QjuC
         J8PCYgAnR4xDUvP82fDAhrLPqsa2Ox9Wa0dp1rq4R5klNhDFM34gYtu0znF2pvS88t/L
         feKsBELWedzI9RGLVe8abvhoV5XEYs8GXUHt4Y6jkOkT6X6shpe220HCljxumu9Jnt1Y
         SjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0P1WTEs+C+NbyMn3/HlAbUcrz7+Kd9kkvPJ4rg/pU4s=;
        b=Tl2ifIxpHY3YEIROiqY7km693GY60njs1GqVMyKGwOyOAu75MGUv69t3fbNihAsBKF
         tAMMYYWUJoR6wBWMI7inbp9kir1v7Yvd5Nx5v/sqflVu0FKXFfOOMTFueG7kO/ZpL5PU
         iOvIy62DG4htcR61lPS9cKyWOBOmKwmwO+dCsXmMYNpkK7CPm3z06rrkZrSIN4qJA795
         gz9STBpWoarfx4wo4p7uYhdiMbO6VEy252w5yaLdqZngL1NWDchvKruJgcUjJ0hJYC+y
         H3AsSYP9jexZdVW58WCUcQd0i4nYXSGreAGsei6WYfwQIdx+Jz0LctfA7ANz8KIY3C/U
         8oAg==
X-Gm-Message-State: AOAM532fFdPhZQEMAmevBlzVeSPhfcZtVRtSqv1U417bCTGK6+l6G4yM
        tyLge/lJ+VBz6jwKOP4cRYI=
X-Google-Smtp-Source: ABdhPJzyeSo2PP/9o8OtEwKETybhzkTyrtMW0L1Rzhtz2OHgwhbKaKuuKx1rGlyv39dxQHOsMLTsVA==
X-Received: by 2002:a05:6102:dcd:: with SMTP id e13mr3901912vst.84.1642396922557;
        Sun, 16 Jan 2022 21:22:02 -0800 (PST)
Received: from kubuntu-desktop.. ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id g5sm3233255vke.6.2022.01.16.21.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 21:22:02 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     narmstrong@baylibre.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     robert.foss@linaro.org, jagan@amarulasolutions.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3] drm: bridge: fix unmet dependency on DRM_KMS_HELPER for DRM_PANEL_BRIDGE
Date:   Mon, 17 Jan 2022 00:21:46 -0500
Message-Id: <20220117052146.75811-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DRM_CHIPONE_ICN6211 is selected, and DRM_KMS_HELPER is not selected,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for DRM_PANEL_BRIDGE
  Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && DRM_KMS_HELPER [=n]
  Selected by [y]:
  - DRM_CHIPONE_ICN6211 [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_BRIDGE [=y] && OF [=y]

This is because DRM_CHIPONE_ICN6211 selects DRM_PANEL_BRIDGE
without depending on or selecting DRM_KMS_HELPER,
despite DRM_PANEL_BRIDGE depending on DRM_KMS_HELPER.

This unmet dependency bug was detected by Kismet,
a static analysis tool for Kconfig.
Please advise if this is not the appropriate solution.

Fixes: ce517f18944e ("drm: bridge: Add Chipone ICN6211 MIPI-DSI to RGB bridge")
Reviewed-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
v2:
- changed from "select" to "depends on"

v3:
- new line now uses tabs instead of spaces.

 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 61db5a66b493..a1b52eaf26e0 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -30,6 +30,7 @@ config DRM_CDNS_DSI
 config DRM_CHIPONE_ICN6211
 	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
 	depends on OF
+	depends on DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL_BRIDGE
 	help
--
2.32.0
