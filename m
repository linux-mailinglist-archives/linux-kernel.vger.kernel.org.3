Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922DC4C4697
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiBYNe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBYNex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:34:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EB71DB3C3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:34:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m13-20020a7bca4d000000b00380e379bae2so1687752wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Z55n6Cqx+EaPx4O80f/x/Rk57EohQE86voS2AD32pXA=;
        b=MgF9Lot9UDj7ZuOqQAoC5Ro1Hksoai8qbKZGl2nWBuiltuiq7zYXphXG4TaHjHULil
         ErJPNotRQyxAenLlqE/K1OQYggkePSxiD2Z/jZJmUj5zbxi+L6NDPSL6CrpCEhL//5Fb
         hdNq+0Tl46azkJbddbTFH8F5m0SKR0kzAyP7maZ78MVVCxe+oOKLteWt5Rw/PvbcpOoX
         zch7nRFn+IIdeja8qAJ8wcddavRHTMI1Ke+PBIpCz0hF66s0hENxWI2wLMk2m77+bcQN
         Z5FjkUEyHOQohPlpzglwPGOOPdH1f+DJmc6cINAvBoadKy5bWA0zzYdJ+Vgy+UXzZLyI
         ogIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z55n6Cqx+EaPx4O80f/x/Rk57EohQE86voS2AD32pXA=;
        b=zNqPWkA/Af5l+E6+2GvbSVPWqWt9s+tqFMyeXovi6Kp2/4mfs/cI/9AzzlFEYP3lhC
         lwuC43gPcy5OxGYgmai/NHjrE0OXD/udIQR0xKp0XE8XRdQj7XhRxHQaUTGwuuvGxDT9
         LFTZ92fZt1QMSx6nLnsuHCbmxoL/4ci/bsWhT54hG3LYpeEXdqUXREawJyv+U3b9Z1Rt
         /Vf4+DafINLw2LMAdUX8XvAs8Wqv/ZIdWto+5IMr4zkCbR1aAY57bmdFs22O/mKVGOwX
         U2O3zCziUvASsRToQrgQbT+sRlvN2HgxuCj0A9/6I+BO6KAIyvq+wFFgbty5YNPqQdzZ
         ELKQ==
X-Gm-Message-State: AOAM530aZHM+obzAMAQteJ7Kb+DWN8CJbm/f9k1WUq5+WY/mPUjYyVvV
        W7HK95NqVFpJRvIgaGo+NDAzbemv7vjLtQ==
X-Google-Smtp-Source: ABdhPJwD+bsYR4PwgXpcFxKwujDMNsL14+FM0G2FydtTnl8mYaITgmGIMbccrtzmYPiUFGoR+JC4Qg==
X-Received: by 2002:a05:600c:20b:b0:381:263:b5d6 with SMTP id 11-20020a05600c020b00b003810263b5d6mr2794145wmi.73.1645796059707;
        Fri, 25 Feb 2022 05:34:19 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.58])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6b43000000b001e317fb86ecsm2327469wrw.57.2022.02.25.05.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:34:19 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] staging: wfx: correct error handling code in wfx_init_common()
Date:   Fri, 25 Feb 2022 05:34:09 -0800
Message-Id: <20220225133409.28109-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In wfx_init_common(), devm_kmalloc() can fail, so its return value
should be checked. Moreover, in error handling code, ieee80211_free_hw()
should be called to free the memory allocated by ieee80211_alloc_hw().

Fixes: 40115bbc40e2 ("staging: wfx: implement the rest of mac80211 API")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/wfx/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 858d778cc589..ebc6c7db8d63 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -307,6 +307,10 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	hw->wiphy->n_iface_combinations = ARRAY_SIZE(wfx_iface_combinations);
 	hw->wiphy->iface_combinations = wfx_iface_combinations;
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = devm_kmalloc(dev, sizeof(wfx_band_2ghz), GFP_KERNEL);
+	if (!hw->wiphy->bands[NL80211_BAND_2GHZ]) {
+		ieee80211_free_hw(hw);
+		return NULL;
+	}
 	/* FIXME: also copy wfx_rates and wfx_2ghz_chantable */
 	memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz,
 	       sizeof(wfx_band_2ghz));
@@ -321,8 +325,10 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 				&wdev->pdata.file_pds);
 	wdev->pdata.gpio_wakeup = devm_gpiod_get_optional(dev, "wakeup",
 							  GPIOD_OUT_LOW);
-	if (IS_ERR(wdev->pdata.gpio_wakeup))
+	if (IS_ERR(wdev->pdata.gpio_wakeup)) {
+		ieee80211_free_hw(hw);
 		return NULL;
+	}
 	if (wdev->pdata.gpio_wakeup)
 		gpiod_set_consumer_name(wdev->pdata.gpio_wakeup, "wfx wakeup");
 
@@ -337,8 +343,10 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	wfx_init_hif_cmd(&wdev->hif_cmd);
 	wdev->force_ps_timeout = -1;
 
-	if (devm_add_action_or_reset(dev, wfx_free_common, wdev))
+	if (devm_add_action_or_reset(dev, wfx_free_common, wdev)) {
+		ieee80211_free_hw(hw);
 		return NULL;
+	}
 
 	return wdev;
 }
-- 
2.17.1

