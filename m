Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B2D46E72C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbhLILCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbhLILCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:02:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4791BC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 02:58:42 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d24so9087339wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 02:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPVDqP6AO9LVEl6lajkZHncKthtZt07+0YhDuniXOPA=;
        b=WA9/ePSao582d/GYRd7Jz94W92c3AWteQOTfTAj6orMwwIm68pFItOT9jBkkRohxcX
         MWfS04AYWo5Rv3bRaPjWQT2uQlucEcRG/fj5PyWAIWtN1zRX8+D/bShz0e/qHSc5D5ju
         rXdhC0yUdUvXmZKatNBKNBUAYsSCoWZdsnys53pA6JEK1cf+TcQbgdTnZnJ5cT44XTOz
         KtwVnH1GRub6IzLWnvHoOc6JiYhjh98k/FgEErds9yi4KxxNuW72toDgsWy8DGryQjI0
         4o0MsdECIIRsWKfAE7CaKrk7KXaQL5/+DD87p7wk07puml/bvWFuJgSZc92bET57+Mq7
         DZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPVDqP6AO9LVEl6lajkZHncKthtZt07+0YhDuniXOPA=;
        b=m1n6+EPRyhynXJktWQOcfVJhIULw13SLglM11LU5GGDM16ZuBeWfdxV2eSoo7h/AdH
         Vrj/HGXdeRrlhLNp10PkoOJQEyt7jF13+RlMvlhArd+XINO1zkO+i5c2VfYyrmqdNfh3
         XK7MyLKsTbAfjoCxetzwfafnv+l4GSl2J7eiRmBdxAgHrIxZd08D3uykr1kgMoGP/Cfz
         lPCBFl2XVlvb6+Yl0u2mOJQWpUVVtiJyz/ULyEn19JhvTbhWKK0xYDQIuW5by+VM1Bbv
         2BFz9LRtMNzPwxpJWWkdOtjUnGGpFJ70kTMMSJx4IPEr/9oIIsWZTg0JrRQdrRXc//X4
         45iw==
X-Gm-Message-State: AOAM531F+lyrCJyWpx2qzEMnq+K6xX9nX78lUkW8ieMx9Z655oYsZOcs
        SpxNICw/eoYu4vvtyUtehXY=
X-Google-Smtp-Source: ABdhPJyDnicrhx4DOizUgPooeXzxaKxflrK2kqFTZE4ANwdvUg94zdrYuIOstE390zM0g/3KmTMBFA==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr5731548wrn.521.1639047520873;
        Thu, 09 Dec 2021 02:58:40 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id s8sm5495024wro.19.2021.12.09.02.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:58:40 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     LW@KARO-electronics.de
Cc:     airlied@linux.ie, daniel@ffwll.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/imx: Fix memory leak in imx_pd_connector_get_modes
Date:   Thu,  9 Dec 2021 11:58:33 +0100
Message-Id: <20211209105833.9921-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 76ecd9c9fb24 ("drm/imx: parallel-display: check return code from of_get_drm_display_mode()")
Addresses-Coverity-ID: 1443943 ("Resource leak")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/imx/parallel-display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index a8aba0141ce7..3bf8e0a4803a 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -75,8 +75,10 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 		ret = of_get_drm_display_mode(np, &imxpd->mode,
 					      &imxpd->bus_flags,
 					      OF_USE_NATIVE_MODE);
-		if (ret)
+		if (ret) {
+			drm_mode_destroy(connector->dev, mode);
 			return ret;
+		}
 
 		drm_mode_copy(mode, &imxpd->mode);
 		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
-- 
2.25.1

