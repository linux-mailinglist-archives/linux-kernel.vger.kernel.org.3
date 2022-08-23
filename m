Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7799B59CD45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbiHWAmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiHWAmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:42:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BFB4C60A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1SF0SGC2zWjdo96D+0xeHw99mifXdhz/ntpv5NKkPcQ=; b=f7o/RoHl4sysNkGDSqSmiH5bk+
        BVJXkWWoIXlAHXbFVu6OsXOhPlHhz1hdeH447tJvDg9Chs6MB4M73kvLa1CKs/3QBPzOJ1pSXjald
        mb34+DcKN5fLBzAM0CoUmFryXwVKav1A8fJe7pZTLLQiFPSnxNA1IJpMq/O3XyrfTBSOnGqJgw9hh
        K+4YFuuIuRHRValii8PQ6ecLqq0voaN88C4KK4uEWe4k5brxhpey4pAL5TmAMukdo7hcpDOSTMZ6R
        WTF3va/2IKPtSKI45SvDK+XNL657CjTfGdPeiOt0CvjPj49G+IxjVwOtqqf3ryzoIEXpyAJiGoKEv
        JYpiejbA==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQI03-00Eo63-Lo; Tue, 23 Aug 2022 00:42:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 1/2] drm/panel: use 'select' for Ili9341 panel driver helpers
Date:   Mon, 22 Aug 2022 17:42:27 -0700
Message-Id: <20220823004227.10820-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'select' instead of 'depends on' for DRM helpers for the
Ilitek ILI9341 panel driver.
This is what is done in the vast majority of other cases and
this makes it possible to fix a build error with drm_mipi_dbi.

Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dillon Min <dillon.minfei@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/panel/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -165,8 +165,8 @@ config DRM_PANEL_ILITEK_IL9322
 config DRM_PANEL_ILITEK_ILI9341
 	tristate "Ilitek ILI9341 240x320 QVGA panels"
 	depends on OF && SPI
-	depends on DRM_KMS_HELPER
-	depends on DRM_GEM_DMA_HELPER
+	select DRM_KMS_HELPER
+	select DRM_GEM_DMA_HELPER
 	depends on BACKLIGHT_CLASS_DEVICE
 	select DRM_MIPI_DBI
 	help
