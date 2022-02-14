Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E254B3F33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbiBNCHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:07:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbiBNCFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:05:45 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA6C54BF3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:05:37 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id k25so14331855qtp.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8dYgaqbyzaZ4a+XQK3SFxEhLH9q+oOb32bnkEUBxzw=;
        b=KV84/vMa70N+J/DIogaMTUeES93B0syybArjN7osEoJOSpOCp9rYn9jWzfGEXqMSKo
         Cy1KPWa6R3Lw2UQX1knSyRtUQRvWh1o/6c3KCLlBnTL53cLn8FGqBoaJUqnZnTHnZ7cr
         DqiZ38ciDR0TVM/igfYdpd/fBStNq4SjqFzhHkI4hdxcQG+AhVndWxS2kg2XE06hVbOz
         WT2s2yZW1YSvlhlc4ZRedB5SMpaNp34X5xLJo7BcX56WPLpzhA2hfaWLs/BEl9KODo2X
         DOmOPSTmhO4AeM549//yiQlS3o6pGkRyrjHWSlRLo/u5Lk1aveys4XPkUuLitNRzUy4j
         tWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8dYgaqbyzaZ4a+XQK3SFxEhLH9q+oOb32bnkEUBxzw=;
        b=61FD43iYwfF34C7gr2hWCDa+kbhZBuEG6gA+GcBo0LbGD4hxtNgz8A+yhedX+k696X
         48tL66wYpQltVgK0K19QI5wnwY+nc18CuPs7QQZYEExY9jsCnZWDPL5ZQI0msnNXe/xk
         F2a6S8VAqHpEc6A5iH7dFRsaUGVOMkDemJ1p9KovPSG9qBnjjNlCVPbwfuy4GK9BayB3
         UfyNZiLCqfDX4QhTbpybXrJy7CmClT8lLeKpPbv4sZK9k+AVAunyMb9ZDZAT76tYkQ+Y
         LaFzXmFKorREXT2hmdPNy5S5ZQKquMDkcNBJBCF+6ZFUhXghseoVRyhHehx7rX8ZjOzU
         GK3A==
X-Gm-Message-State: AOAM530yBFCZ3Ge2Vrhi+23Hx+VNUVXFog4Dtopxt/bJblCmmZkzNKFG
        4cb9B0jWfMTc2szZGh1tG00=
X-Google-Smtp-Source: ABdhPJw+RLbcabsgmELQsb14jJa1NSKg6RdpkA7E1IVL2FwAU5mE916WH2ux+C01+YMT4Zr0JOqpMA==
X-Received: by 2002:ac8:5992:: with SMTP id e18mr8111155qte.66.1644804336919;
        Sun, 13 Feb 2022 18:05:36 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b9sm14652626qkj.24.2022.02.13.18.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 18:05:36 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     emma@anholt.net
Cc:     mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/vc4: Use of_device_get_match_data()
Date:   Mon, 14 Feb 2022 02:05:30 +0000
Message-Id: <20220214020530.1714631-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 9300d3354c51..752f921735c6 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1493,15 +1493,10 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 	struct drm_device *drm = dev_get_drvdata(master);
 	struct vc4_dsi *dsi = dev_get_drvdata(dev);
 	struct vc4_dsi_encoder *vc4_dsi_encoder;
-	const struct of_device_id *match;
 	dma_cap_mask_t dma_mask;
 	int ret;
 
-	match = of_match_device(vc4_dsi_dt_match, dev);
-	if (!match)
-		return -ENODEV;
-
-	dsi->variant = match->data;
+	dsi->variant = of_device_get_match_data(dev);
 
 	vc4_dsi_encoder = devm_kzalloc(dev, sizeof(*vc4_dsi_encoder),
 				       GFP_KERNEL);
-- 
2.25.1

