Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5365141E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354213AbiD2FvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344864AbiD2FvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:51:16 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FA9B18A5;
        Thu, 28 Apr 2022 22:47:59 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id kd11so4720588qvb.2;
        Thu, 28 Apr 2022 22:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmvctIow+IO8H7sfWVaNo+LfAgPKgXEAs61yE8oSiDQ=;
        b=oWiP1HCeTyemawgY2i30abE82xuGfAhqLYQ4az+d0RtVLrsc1W7y1QyPjWaHLwJNqQ
         v5cN/pTLQDNQO5acKAGmD1z2ODP3qmycMQLZ5D9JNR7gMrkfrGRuQ8hrjv7HIobEx++B
         Hxqv+O+18Bf1gmt8Y262IYlcex1TU7dElzqAlLPr+o57Rpgy35WLiShRzSPommRWRdsy
         OL2yD7pyRm0Dl3wMgkfvT3jrGH+LpEOb6zfnL0x8UHw8WPKo1Z4mMY7lBAvMNWqraoYy
         Eck7aVOyDPlrVnNMNNRGRSzvRyaxJ95QvJduLeLtXefZykn8XfJjjTSuLOOT73isEZUM
         DzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmvctIow+IO8H7sfWVaNo+LfAgPKgXEAs61yE8oSiDQ=;
        b=r/rg9F/tKxNjTseVl9QY0I///6jsVfadRTZvzK2vTrvhQbZiD41US7F33suun+A2xa
         qESzxYI6FFKa15TGTkO5+7jIWcj49jDalkHVqenuuVtrS6m1cthyL5MbSccUBn74Jfwd
         sHNpokJimdWQyI9bscY0ouQa5XlNP8zrTxxAjf+mwJTgNtwrHtsMxDNw5+1D/fARgqHb
         6L8ApiMAFYl9bk+cAZENUy6MMlfW+t82U2SVhsP08Nfi1JYWE+crXehRzr4OD7SdduHw
         TTSEjNKL6Sx8JgviPc1Hf0qq8GUUlR520HTXGG8wdY0exZseYVeKNMGca1wzontxZFDb
         8Y1w==
X-Gm-Message-State: AOAM533DABnFYTB5E5ykVYcDXsKOj0CWW3ZdhWsOf53XPsItpsF/B24R
        gI9AyDv+FTGs3jn6lvNXXgcHFCPsY6I=
X-Google-Smtp-Source: ABdhPJywgs83ZsnO6SkmFFnrihPXpXj6JdK9JpVZwtn37Q80rvE/ZAmW9KtZfoLczSxU8F+4hfgL0g==
X-Received: by 2002:ad4:444a:0:b0:456:52bc:41cb with SMTP id l10-20020ad4444a000000b0045652bc41cbmr8229203qvt.54.1651211278445;
        Thu, 28 Apr 2022 22:47:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o20-20020a05620a0d5400b0069c71a71ed3sm925303qkl.33.2022.04.28.22.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 22:47:58 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     deller@gmx.de
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] omapfb: simplify the return expression of dsi_init_pll_data()
Date:   Fri, 29 Apr 2022 05:47:51 +0000
Message-Id: <20220429054751.3851851-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
index c5f89129dcdd..531b36d2232b 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
@@ -173,7 +173,6 @@ static int dsi_init_pll_data(struct platform_device *pdev, struct hdmi_pll_data
 {
 	struct dss_pll *pll = &hpll->pll;
 	struct clk *clk;
-	int r;
 
 	clk = devm_clk_get(&pdev->dev, "sys_clk");
 	if (IS_ERR(clk)) {
@@ -203,12 +202,7 @@ static int dsi_init_pll_data(struct platform_device *pdev, struct hdmi_pll_data
 	}
 
 	pll->ops = &dsi_pll_ops;
-
-	r = dss_pll_register(pll);
-	if (r)
-		return r;
-
-	return 0;
+	return dss_pll_register(pll);
 }
 
 int hdmi_pll_init(struct platform_device *pdev, struct hdmi_pll_data *pll,
-- 
2.25.1


