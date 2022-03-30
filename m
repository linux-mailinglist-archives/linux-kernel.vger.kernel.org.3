Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5774ECB5A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349703AbiC3SIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349768AbiC3SI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:08:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB70233E81;
        Wed, 30 Mar 2022 11:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43B1160BAD;
        Wed, 30 Mar 2022 18:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2037CC340EE;
        Wed, 30 Mar 2022 18:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648663598;
        bh=c40oLSuQ05wWwsFeXD0porA4/1RgYoRPdHiOlqdCHXE=;
        h=From:To:Cc:Subject:Date:From;
        b=kQKiSz1we2LYxuvicJhG6Ebsg1zV7ks2eShcPlJO1sWfP3CbtT1qa9KV5oJs12Dlr
         Hu0tz7xgQWo2EdZ4f8115s3FccUEPu63qvJxB9Cq2S5QQu52/wIUVNBS+nx2n+BlQp
         11rvaoZKFK8/TjvZKOW+UB6S2RcS7abmU3ghFZ8wpjm1nWGxobpeV7yZEwFLP80xMQ
         WIQTyjmXVAYb8WoforyrsHywOyYZEHGMaVu8heEKKpNB3WhDOZxkgRugSt4JbHZBr2
         rc6+7CVYm73Req1UNo6e/S8+ZFgCgQrVqIfHiTxhJqx5E32wwz5j+Suxmwoh8p26US
         YMPSajaOPl7hQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] drm/msm/gpu: Avoid -Wunused-function with !CONFIG_PM_SLEEP
Date:   Wed, 30 Mar 2022 11:05:41 -0700
Message-Id: <20220330180541.62250-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
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

When building with CONFIG_PM=y and CONFIG_PM_SLEEP=n (such as ARCH=riscv
allmodconfig), the following warnings/errors occur:

  drivers/gpu/drm/msm/adreno/adreno_device.c:679:12: error: 'adreno_system_resume' defined but not used [-Werror=unused-function]
    679 | static int adreno_system_resume(struct device *dev)
        |            ^~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/msm/adreno/adreno_device.c:655:12: error: 'adreno_system_suspend' defined but not used [-Werror=unused-function]
    655 | static int adreno_system_suspend(struct device *dev)
        |            ^~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

These functions are only used in SET_SYSTEM_SLEEP_PM_OPS(), which
evaluates to empty when CONFIG_PM_SLEEP is not set, making these
functions unused.

Traditionally, these functions are marked as __maybe_unused but in this
case, there is already an '#ifdef CONFIG_PM' in the code, so just do the
same thing with CONFIG_PM_SLEEP to resolve the warning.

Fixes: 7e4167c9e021 ("drm/msm/gpu: Park scheduler threads for system suspend")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 661dfa7681fb..b25915230bab 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -621,6 +621,7 @@ static int adreno_runtime_suspend(struct device *dev)
 	return gpu->funcs->pm_suspend(gpu);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static void suspend_scheduler(struct msm_gpu *gpu)
 {
 	int i;
@@ -681,8 +682,8 @@ static int adreno_system_resume(struct device *dev)
 	resume_scheduler(dev_to_gpu(dev));
 	return pm_runtime_force_resume(dev);
 }
-
-#endif
+#endif /* CONFIG_PM_SLEEP */
+#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops adreno_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(adreno_system_suspend, adreno_system_resume)

base-commit: 05241de1f69eb7f56b0a5e0bec96a7752fad1b2f
-- 
2.35.1

