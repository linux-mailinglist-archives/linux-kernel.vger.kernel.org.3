Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28063510033
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351527AbiDZOTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351595AbiDZOTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:19:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8BB1FCD4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:15:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so579185wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q1KyJUwchUoMJntE9mPRVh4KvvxwI90zYF3ltbPaCFY=;
        b=V7IRbt5EQFW76RH4jXgUdRR8FufOUBWtIVlca2ZxxWIUPSKakLWhN6NoMNO5IZD0UY
         7teslQh66Y4cQDGhwdWKEBpJucBKT8Kw9noGNeZJdJA+5gCERJHybRg1UCyKQu7u+LU1
         AFi04iYHG7HYwGOpEjJ5YUY/aQWThYk2UP5MXCG7ujqdYGXab++cIWhyShRHkfiHoWtv
         zDcTF6WjzxoYxWiFXXI/6MEBibU66vS38LWYSU3GdEAVVQWdY1b45I8i3DbycG8Hx9Yj
         nnq2IyR0BgCF41G6qKvr75CK1tlc75cHlGx5qjMeyjIfhcJFrWE45SaT9TAVvsbJs/Yw
         CoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q1KyJUwchUoMJntE9mPRVh4KvvxwI90zYF3ltbPaCFY=;
        b=zTwZjMGLDwQqSoJn53G+fq1jUgvlI1ka2UtarTeyi8X/su0dYrUIRnA3/N6j57/Y0/
         Gxmho3pwSfLXTksfymesTatRPuzh68REaXKoq9UtKhufaH1FUO/6K4DViGfqgg7dD3Ce
         9vhljUXP9ZYn/PB3O6/ID/YHbMvZ/DMWXhpDRlaZ9UBaatz93TMsxkMyZC4PHpeh1loz
         gUBwFVldbIp05dRDiZjzhGZHrl+BaTK37d0MRlHz+39upuDBrPjVXWe8AplZGWyp0YpV
         l+QNcHRd26AypFKiRe3pTvBpew5+XrJSJS/50MoEcE+NVYiSWYf/3ed/laqQOEhvSAe0
         6ClA==
X-Gm-Message-State: AOAM53396uKyAxg+bLKSwO+tYP1xetXNW1FtO/vZC/IvixQ5GmwpRDQt
        TDkqi2t7to7LFgNu34tewhvLnQ==
X-Google-Smtp-Source: ABdhPJxxoSbGjXzk5tIl6+2yY+mTWtME38DIhEf/fNfzKwGxGg0RGNENtQj/S7apGfjiDtH5vwYQUQ==
X-Received: by 2002:a05:600c:1e09:b0:390:f313:bf15 with SMTP id ay9-20020a05600c1e0900b00390f313bf15mr30877213wmb.172.1650982551846;
        Tue, 26 Apr 2022 07:15:51 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id a2-20020a056000188200b0020aa2581c7fsm12998633wri.104.2022.04.26.07.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:15:51 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: ite-it6505: add missing Kconfig option select
Date:   Tue, 26 Apr 2022 16:15:36 +0200
Message-Id: <20220426141536.274727-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IT6505 is using functions provided by the DRM_DP_HELPER driver.
In order to avoid having the bridge enabled but the helper disabled,
let's add a select in order to be sure that the DP helper functions are
always available.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 007e5a282f67..2145b08f9534 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -78,6 +78,7 @@ config DRM_ITE_IT6505
         tristate "ITE IT6505 DisplayPort bridge"
         depends on OF
         select DRM_KMS_HELPER
+        select DRM_DP_HELPER
         select EXTCON
         help
           ITE IT6505 DisplayPort bridge chip driver.
-- 
2.36.0

