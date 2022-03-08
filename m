Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330044D1451
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbiCHKLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345666AbiCHKLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:11:05 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813063337D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:10:09 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s18so3381919plp.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noEqkBf5xzBolmnhdQPfwHD82qaYeiB8/RXOxn1DB2I=;
        b=PsIwM301p+zkfVPLNMuBY2fgeZYi4j+IGcIxp8lP2wQofQwsTA/SANTTxjG0S8RTAK
         Zz2rcqgxCgmmwveXGiLhoaqoV9LC4rAO+jCp0lqq4wCXA5PSkdUzbpTufzwn7Ap3iPbQ
         jmIKa5JsZRMgNuNQeXZh1sXnjbhE/kmJF87vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noEqkBf5xzBolmnhdQPfwHD82qaYeiB8/RXOxn1DB2I=;
        b=MbOQVVxn6afKo40uZTIZZQKQlopWaKrHHc9Wc8/VzeFe13qddZ+3V26UAtPsG1w/In
         KfaHjVn/zzGJTbXUbZqZ4xB10rNGMjQU5RDJ+zXN2zp2xLbw2rJsiv0geED2KAqR5cTl
         jFbDbfqHda/9h9dYT9poFotq5OxSS4wUFjZjyrfVldwkMdcQSoUiBFDoKjmdvwzlCwPw
         S2BHgF8CaIaPUklHXea8krVaxTfnDaV/FQp5Ff6HzdMhQFVsG34kB7zNz8s6edJ/xfl8
         0mT3xbLHfZbb/toLvCr5dLMOSLcIrNJzBx2CTN/Wr76tuwhXqPSpDj+PxtCFmAHViS4k
         0ByA==
X-Gm-Message-State: AOAM532Ny1ZX2h1jsUGCJseieCdAfMyHNChtzX1cAimdRkK4hHh3Cy8L
        d3JW2tq0djorlbPr5xSi8/d1jQ==
X-Google-Smtp-Source: ABdhPJwMnsLSH0Ugh0kYJjqmbKgwtim8f6qXQsngF85UoO3kJmueeC/GVPnsmGoroD8ZfCxe30PFag==
X-Received: by 2002:a17:903:2350:b0:151:e633:7479 with SMTP id c16-20020a170903235000b00151e6337479mr10346038plh.74.1646734208964;
        Tue, 08 Mar 2022 02:10:08 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:73f8:5e3f:6894:8f44])
        by smtp.gmail.com with ESMTPSA id k19-20020a056a00135300b004f734327960sm1707553pfu.106.2022.03.08.02.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:10:08 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 02/11] pinctrl: mediatek: paris: Fix PIN_CONFIG_BIAS_* readback
Date:   Tue,  8 Mar 2022 18:09:47 +0800
Message-Id: <20220308100956.2750295-3-wenst@chromium.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308100956.2750295-1-wenst@chromium.org>
References: <20220308100956.2750295-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading back pin bias settings, if the pin is not in the
corresponding bias state, the function should return -EINVAL.

Fix this in the mediatek-paris pinctrl library so that the read back
state is not littered with bogus a "input bias disabled" combined with
"pull up" or "pull down" states.

Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index f9f9110f2107..7037560ecda9 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -96,20 +96,16 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 			err = hw->soc->bias_get_combo(hw, desc, &pullup, &ret);
 			if (err)
 				goto out;
+			if (ret == MTK_PUPD_SET_R1R0_00)
+				ret = MTK_DISABLE;
 			if (param == PIN_CONFIG_BIAS_DISABLE) {
-				if (ret == MTK_PUPD_SET_R1R0_00)
-					ret = MTK_DISABLE;
+				if (ret != MTK_DISABLE)
+					err = -EINVAL;
 			} else if (param == PIN_CONFIG_BIAS_PULL_UP) {
-				/* When desire to get pull-up value, return
-				 *  error if current setting is pull-down
-				 */
-				if (!pullup)
+				if (!pullup || ret == MTK_DISABLE)
 					err = -EINVAL;
 			} else if (param == PIN_CONFIG_BIAS_PULL_DOWN) {
-				/* When desire to get pull-down value, return
-				 *  error if current setting is pull-up
-				 */
-				if (pullup)
+				if (pullup || ret == MTK_DISABLE)
 					err = -EINVAL;
 			}
 		} else {
-- 
2.35.1.616.g0bdcbb4464-goog

