Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EC54FA6A3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbiDIKCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241128AbiDIKCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:02:33 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C0415FC0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 03:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1649498423; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=A5PJEamvB/Q6ZdrsbhzIrxfL3V+SEu121g25tOfMR6k=;
        b=K0HGJxv37mBu5ndPyGax7E9gMrLHTdObUC76F2MRpH4+rdMGmFgkxSyrXr9KyoF2jV7e5X
        hzbkrhMbeW6m5Or/XLj/z0SmJbXHItUt+0fLyRC1SnfLMtV5F30+OH9KUcLhfv5WJJPbDw
        Pv9nsv+bcslHCLeYaR5Qm39g52ZuVI4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        kbuild-all <kbuild-all@lists.01.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/panel: newvision-nv3052c: Fix build
Date:   Sat,  9 Apr 2022 11:00:16 +0100
Message-Id: <20220409100016.9337-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was compile-tested then rebased on drm-misc-next, and not
compile-tested after the rebase; unfortunately the driver didn't compile
anymore when it hit drm-misc-next.

Fixes: 49956b505c53 ("drm/panel: Add panel driver for NewVision NV3052C based LCDs")
Cc: Christophe Branchereau <cbranchereau@gmail.com>
Cc: kbuild-all <kbuild-all@lists.01.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-newvision-nv3052c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 127bcfdb59df..cf078f0d3cd3 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -416,15 +416,13 @@ static int nv3052c_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int nv3052c_remove(struct spi_device *spi)
+static void nv3052c_remove(struct spi_device *spi)
 {
 	struct nv3052c *priv = spi_get_drvdata(spi);
 
 	drm_panel_remove(&priv->panel);
 	drm_panel_disable(&priv->panel);
 	drm_panel_unprepare(&priv->panel);
-
-	return 0;
 }
 
 static const struct drm_display_mode ltk035c5444t_modes[] = {
-- 
2.35.1

