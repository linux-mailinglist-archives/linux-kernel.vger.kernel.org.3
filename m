Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10059CD99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbiHWBIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiHWBIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:08:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A865789E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:08:10 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 73so10917048pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=O/GRXlknE27pccxIQi0v6x37LcKJV0n9KgXcmO8i7No=;
        b=NBH1dAZrOEP6/aJqO0jUoEl+NZFNZkKLRXxgQqcTMtOwt/72p4XNIipsh1Bph7ziHI
         UXfMW4bSoKQo5IIENuUenVfyTZFOBlHzTSTC1Ke15APrQ4nY7SfDhtXpRhB1yUpEU1rZ
         jVEyLbzYFKBG+uHpGVRA4yM3PKiPASEpMCPcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=O/GRXlknE27pccxIQi0v6x37LcKJV0n9KgXcmO8i7No=;
        b=N46ylP71XfLPzgxuMZOMrqntdD9YdyhDS+x3b9uN24BokioqSdGUWABUJ9KtQfX4ca
         TaD/YaWzRVm6zRc6AhnYyfMQcbM7LcQA4UTflJAhdfv+FAjRxm5eXANessU9cxwUutJl
         bAr2+3Yx/Vm6sk6D4ip0z//YBIie0t0BscbcqnFZV27+qw8ODa/khJoli/YtgxswsA2v
         4ZxfD3vpEo8vBO1iAvfCTuq5F6Q/Eodjq0QgLfJYWymQIvlsfU2q0cjB+rYzHhz5/K7L
         BosLK6TGx3TTo0tTXaLLcP+T07S35CktI8SQmLfkPdjiQnThTWuhoTFlCGb42kdvPjAJ
         T9cw==
X-Gm-Message-State: ACgBeo0NhHILxbVxiKN0V/p78Ta2e/icnd/Kasiy52O3hySFi/ebilLi
        gyeFPsvXzwVV7ZpSG+7GR8I9EA==
X-Google-Smtp-Source: AA6agR4ZLDwap6nFG5ubFR8pGzzvNUfGWzeDGJnuhXHkOX8FHjJL4BN60/0Iv7M2fovC1SBQ4bKQJQ==
X-Received: by 2002:a63:fe12:0:b0:42a:e57:7464 with SMTP id p18-20020a63fe12000000b0042a0e577464mr18017508pgh.552.1661216890094;
        Mon, 22 Aug 2022 18:08:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:34e2:c40e:42d3:27e0])
        by smtp.gmail.com with UTF8SMTPSA id u186-20020a6279c3000000b0052e0b928c3csm9209544pfc.219.2022.08.22.18.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 18:08:09 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     xuqiang36@huawei.com, Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Zhang Zekun <zhangzekun11@huawei.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] Revert "drm: bridge: analogix/dp: add panel prepare/unprepare in suspend/resume time"
Date:   Mon, 22 Aug 2022 18:08:04 -0700
Message-Id: <20220822180729.1.I8ac5abe3a4c1c6fd5c061686c6e883c22f69022c@changeid>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 211f276ed3d96e964d2d1106a198c7f4a4b3f4c0.

For quite some time, core DRM helpers already ensure that any relevant
connectors/CRTCs/etc. are disabled, as well as their associated
components (e.g., bridges) when suspending the system. Thus,
analogix_dp_bridge_{enable,disable}() already get called, which in turn
call drm_panel_{prepare,unprepare}(). This makes these drm_panel_*()
calls redundant.

Besides redundancy, there are a few problems with this handling:

(1) drm_panel_{prepare,unprepare}() are *not* reference-counted APIs and
are not in general designed to be handled by multiple callers --
although some panel drivers have a coarse 'prepared' flag that mitigates
some damage, at least. So at a minimum this is redundant and confusing,
but in some cases, this could be actively harmful.

(2) The error-handling is a bit non-standard. We ignored errors in
suspend(), but handled errors in resume(). And recently, people noticed
that the clk handling is unbalanced in error paths, and getting *that*
right is not actually trivial, given the current way errors are mostly
ignored.

(3) In the particular way analogix_dp_{suspend,resume}() get used (e.g.,
in rockchip_dp_*(), as a late/early callback), we don't necessarily have
a proper PM relationship between the DP/bridge device and the panel
device. So while the DP bridge gets resumed, the panel's parent device
(e.g., platform_device) may still be suspended, and so any prepare()
calls may fail.

So remove the superfluous, possibly-harmful suspend()/resume() handling
of panel state.

Fixes: 211f276ed3d9 ("drm: bridge: analogix/dp: add panel prepare/unprepare in suspend/resume time")
Link: https://lore.kernel.org/all/Yv2CPBD3Picg%2FgVe@google.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 8aadcc0aa90b..df9370e0ff23 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1864,12 +1864,6 @@ EXPORT_SYMBOL_GPL(analogix_dp_remove);
 int analogix_dp_suspend(struct analogix_dp_device *dp)
 {
 	clk_disable_unprepare(dp->clock);
-
-	if (dp->plat_data->panel) {
-		if (drm_panel_unprepare(dp->plat_data->panel))
-			DRM_ERROR("failed to turnoff the panel\n");
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(analogix_dp_suspend);
@@ -1884,13 +1878,6 @@ int analogix_dp_resume(struct analogix_dp_device *dp)
 		return ret;
 	}
 
-	if (dp->plat_data->panel) {
-		if (drm_panel_prepare(dp->plat_data->panel)) {
-			DRM_ERROR("failed to setup the panel\n");
-			return -EBUSY;
-		}
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(analogix_dp_resume);
-- 
2.37.2.609.g9ff673ca1a-goog

