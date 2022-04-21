Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A684F50A086
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiDUNR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiDUNR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:17:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7325FE5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:14:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t11so9910873eju.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5AA//nz8eioK2obF5S6G7yI3Qq8Yz3xKC1cGsmA3bs8=;
        b=zA0HPeX+G3XppyfmI4v/W/W0aBnJtLr0AZF1FL68CpnUyfBynwJEnSO6+OSn26XvyY
         wuQp+JMaPUY2ruPSPmgCX+46EBvdblpAyKtG2EX64eMiWOzq4T4YABLG5YJzgNFWq0ZY
         PJsrV4S+RQJBZ2oHAsKnnhMZo0goSGciybgBiCXmweUN0sxEMK7DwZ1l/G0rYaTWHjA5
         F+YwZI1nrWS/vpJsHIzM17oeGQUn04c59jhSsViNCxqDCJAwt3nXUImNBI5rmbvizt/n
         5d/YjACevHEvoZSYflYhXExrz3ZCRDOZb+cPJ2peWF5FLugbgZT2roOO+BJGMmcACOuS
         r7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5AA//nz8eioK2obF5S6G7yI3Qq8Yz3xKC1cGsmA3bs8=;
        b=bBBur4oJa7np+BoVNp3NB/4Ic/P2JkZyT56q+/J1ZpYs0IU1JGdTCx4REzvcvBUXU7
         Qnu6ShPM/cCVbBebKz21LtP6R4xkbZktvWJXdhqs1U4AbNSfSfz1wBzhUWfLPKB0tZ+Y
         z/KosTb48aOeaesvEeb9AZDCBGKHL0lrgQqvNd+Gyndb1gfxc9g3BbMaWvV+QyWY52Fg
         IF4B+FbmJ677MC250nk5GyubYo0Xezn18pqbwpCpwLaCP2uWy7MUQgDAteJXrubqf+L4
         0GA4gbSAc8jzT29gYKTYkDw0bEPQcBPqPbV4m0EE9t5NY9rOkubZslH/CtKP+tKMNiko
         wFYw==
X-Gm-Message-State: AOAM530oPC1zy87cN5UWJIBxbsFqhviaufR26Gpa0QLeP4Q+0x2VQ6X0
        zOFTb+yPNIWAllGMr9DCSJSdiQ==
X-Google-Smtp-Source: ABdhPJyA8BdIM0wRS4oJgIe/AJBafd52nt4hkn/4fL4bly7jxM82GWK0bG+l6YbDzA5syjqD7m+4NQ==
X-Received: by 2002:a17:907:7ea4:b0:6f0:1205:fea9 with SMTP id qb36-20020a1709077ea400b006f01205fea9mr4527828ejc.534.1650546874555;
        Thu, 21 Apr 2022 06:14:34 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id x1-20020a170906148100b006efa8a81a52sm4540605ejc.120.2022.04.21.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:14:33 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, hermes.wu@ite.com.tw,
        angelogioacchino.delregno@collabora.com, allen.chen@ite.com.tw,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH v1] drm/bridge: Fix it6505 Kconfig DRM_DP_AUX_BUS dependency
Date:   Thu, 21 Apr 2022 15:14:15 +0200
Message-Id: <20220421131415.1289469-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it6505 depends on DRM_DP_AUX_BUS, the kconfig for it6505 should
reflect this dependency using 'select'.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index c08ccb4b332b..4cff9206045b 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -78,6 +78,7 @@ config DRM_DISPLAY_CONNECTOR
 config DRM_ITE_IT6505
         tristate "ITE IT6505 DisplayPort bridge"
         depends on OF
+        select DRM_DP_AUX_BUS
 	select DRM_DP_HELPER
         select DRM_KMS_HELPER
         select EXTCON
-- 
2.32.0

