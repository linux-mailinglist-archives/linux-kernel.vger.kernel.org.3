Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A274C1897
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242678AbiBWQao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiBWQao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:30:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65750E009;
        Wed, 23 Feb 2022 08:30:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1E6AB81EB0;
        Wed, 23 Feb 2022 16:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D76C340E7;
        Wed, 23 Feb 2022 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645633813;
        bh=R55TaZ1yeTOZBHSm3FPqIV1ej7TW8V8o3let2ioiVFM=;
        h=From:To:Cc:Subject:Date:From;
        b=dwMtTEPcCdUHF9egKhE7OHv83pbzIb3Qzi9S8NV7YVzhsRHasoGh2X8l8UWOyR39u
         TWh9u0zoWjTDO8+tAhI/lVT60ygtxxUWBNOowxEjSAcNcPX378Y3sXGlTZT0if93vZ
         NSTFDCn4EBeQmcaiFeJ8wY3ydzBIrsCuJSlDYV+KeRtoae/RQlxlwAdhPTM5vTg2ek
         kjiy5LcgElG1y32JAklSYkkjK2ZHHVI0G4wQxxdbvluf8ctzZiaVG2fV6i/5YExa8k
         AlBvpkKQgfkYWW8pEjSMESPHcDbJsvnuuIkwtO55HWKI/hUXVyEGMT1rAHgJ7zXUHH
         hgg4vT/OWmwog==
From:   broonie@kernel.org
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the drm-tegra tree with the drm tree
Date:   Wed, 23 Feb 2022 16:30:07 +0000
Message-Id: <20220223163007.328242-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the drm-tegra tree got conflicts in:

  drivers/gpu/drm/tegra/dpaux.c
  drivers/gpu/drm/tegra/Kconfig

between commit:

  adb9d5a2cc77e ("drm/dp: Move DisplayPort helpers into separate helper module")

from the drm tree and commit:

  8913e1aea4b32 ("drm/tegra: dpaux: Populate AUX bus")

from the drm-tegra tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/tegra/Kconfig
index 18c319b804c00,201f5175ecfec..0000000000000
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@@ -5,7 -5,7 +5,8 @@@ config DRM_TEGR
  	depends on COMMON_CLK
  	depends on DRM
  	depends on OF
 +	select DRM_DP_HELPER
+ 	select DRM_DP_AUX_BUS
  	select DRM_KMS_HELPER
  	select DRM_MIPI_DSI
  	select DRM_PANEL
diff --cc drivers/gpu/drm/tegra/dpaux.c
index 8ca500977a46b,d7a731d287d23..0000000000000
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@@ -18,7 -18,8 +18,8 @@@
  #include <linux/reset.h>
  #include <linux/workqueue.h>
  
 -#include <drm/drm_dp_helper.h>
 -#include <drm/drm_dp_aux_bus.h>
 +#include <drm/dp/drm_dp_helper.h>
++#include <drm/dp/drm_dp_aux_bus.h>
  #include <drm/drm_panel.h>
  
  #include "dp.h"
