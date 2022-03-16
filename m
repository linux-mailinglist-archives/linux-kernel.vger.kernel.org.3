Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DE64DB804
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357752AbiCPSit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbiCPSip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:38:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEC56E290;
        Wed, 16 Mar 2022 11:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A32E8618D3;
        Wed, 16 Mar 2022 18:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF1AC340F7;
        Wed, 16 Mar 2022 18:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647455850;
        bh=SIbAZruduzRSnrWzOuWAI4SxaF18hsmgKxmS/1M5bhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7pAnQaGxH5XguHxVvJXRImcQeTVI3Ghe06RgDHhhIeS2LKTdJ5665C2pJ5SdYO+7
         Di2cKTvLZSwnBz71+ZkTKj6c8kFx9zThPZCxgSspTu24wQJPs59+/IYh9gqBDNoM0p
         GzeFUdcI+WWA0Pioii1/wbYWRjGV03+Dc+DnuF5sBGLI1FT/wCbTjT3CowmUgylqP8
         /aOUAkBV7+slOzBawZSK0Q6+rP77MxjawrlvTZUAMclTdgyLVYKobaUFFyo01GQm5A
         D/Zy9AtQ+M4e4OGlPYqOEfLm8Toee2Tg8HVhC3AVBbtQ6wQ3v5TksI/TbTDXwO5gIZ
         WMJ7CvOwTgfiQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tegra: vic: fix unused-function warnings
Date:   Wed, 16 Mar 2022 19:36:47 +0100
Message-Id: <20220316183708.1505846-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220316183708.1505846-1-arnd@kernel.org>
References: <20220316183708.1505846-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The use of the old-style SET_RUNTIME_PM_OPS() and
SET_SYSTEM_SLEEP_PM_OPS() macros requires function definitions
to be hidden to avoid

drivers/gpu/drm/tegra/vic.c:326:12: error: 'vic_runtime_suspend' defined but not used [-Werror=unused-function]
  326 | static int vic_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tegra/vic.c:292:12: error: 'vic_runtime_resume' defined but not used [-Werror=unused-function]
  292 | static int vic_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~

Use the new-style SYSTEM_SLEEP_PM_OPS() and RUNTIME_PM_OPS() instead.

Fixes: 1e15f5b911d6 ("drm/tegra: vic: Stop channel on suspend")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/tegra/vic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

I see this warning on 5.17-rc8, but did not test it on linux-next,
which may already have a fix.

diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 1e342fa3d27b..f56f5921a8c2 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -513,9 +513,8 @@ static int vic_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops vic_pm_ops = {
-	SET_RUNTIME_PM_OPS(vic_runtime_suspend, vic_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	RUNTIME_PM_OPS(vic_runtime_suspend, vic_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_vic_driver = {
-- 
2.29.2

