Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193BE529B45
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbiEQHmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbiEQHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:41:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B412D31
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:40:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so1701334pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeK9VUF3y97S0wYhYQH6NYZJR1s4W4dg36hM35BXnkI=;
        b=VupddrZxTMFF73/Fue6HCMHW6Yoruq+qwq1j8nmvyN4q3Kge6zBZmPbdbCdhgTNm7G
         K+3ZCUSOnhFe9Tc9O82layM+tqkcZrUl3Q46xhogrMcMxeqPGFN+drURYDqqrMXiojaK
         uhO/q1kBMMAnidWWpeoyoejNNuF0pfTHTFkYOaGLo4IvJ/E6DncS2hO8zUPNDHpVgAwQ
         duFj/ge7M0qSOkwcJXtDYFGn1yAsJNkMRjBdjiCnGLGtrZqW3z5N9qLn3lhFQ90b/qmG
         iEtb+lzlqKNW/vo0tGOWZ0wP0ZO1AttJaL+Pn/ZL7zvvCYJMX13P/9+/Cgy2JiIb7JI4
         ibUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeK9VUF3y97S0wYhYQH6NYZJR1s4W4dg36hM35BXnkI=;
        b=syHyH9QK/Fb4qhS3+Lk3Q+hMKHNcxynxQzs63IqgikXOCEGCstl18bUtNY+xfYJBMT
         ko2tt13BouBrEPmb+/wBRdhTeCeftK3eBkl4Gin/CB3BKRG1IxTqB7B6ojzNGZZXTBYv
         92OL8Tl2aTgwk/97Z5COs3RbjI1M8xjmJ1KNoDqZIzOhWbB2eEhwGtIoA+q0taVCS/xF
         oJcLEAdIR+DMgiEKc7qzWUZQXKMMeHgNlGpbPqPHriF+qWc97+cOWf2e00iNKwc5x3Ar
         WVPpb1G8CqGpPSy/CQ86wYQAtof4v7zKo7zrNJRYo2D5At++8GtleBjBuxj5dXenBsZ4
         gFGQ==
X-Gm-Message-State: AOAM531vdE9VxRMrxHfKvGS3QAYh6u9C+Tp3ampmSiqLLOlju1UQpFCi
        IIJK9DD3zBwtQ8JfCC5TWvE=
X-Google-Smtp-Source: ABdhPJw3kAp82GIvb+U/WV5uzx98ZnVuNSiGaWQ74X5doZXomOr+UfBtgAq9ucg9N8O/pRcE5pOx1w==
X-Received: by 2002:a17:90a:778c:b0:1df:56a5:8474 with SMTP id v12-20020a17090a778c00b001df56a58474mr9439550pjk.63.1652773248364;
        Tue, 17 May 2022 00:40:48 -0700 (PDT)
Received: from localhost.localdomain ([103.167.60.51])
        by smtp.gmail.com with ESMTPSA id n22-20020a056a0007d600b0050dc7628139sm8551987pfu.19.2022.05.17.00.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 00:40:47 -0700 (PDT)
From:   Genjian Zhang <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian Zhang <zhanggenjian@kylinos.cn>
To:     hsweeten@visionengravers.com, alexander.sverdlin@gmail.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhanggenjian123@gmail.com, Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH v2] ep93xx: clock: Do not return the address of the freed memory
Date:   Tue, 17 May 2022 15:39:46 +0800
Message-Id: <20220517073946.1339333-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid return freed memory addresses,Modified to the actual error
return value of clk_register().

Fixes: 9645ccc7bd7a ("ep93xx: clock: convert in-place to COMMON_CLK")
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 arch/arm/mach-ep93xx/clock.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 4fa6ea5461b7..85a496ddc619 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -345,9 +345,10 @@ static struct clk_hw *clk_hw_register_ddiv(const char *name,
 	psc->hw.init = &init;
 
 	clk = clk_register(NULL, &psc->hw);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
 		kfree(psc);
-
+		return ERR_CAST(clk);
+	}
 	return &psc->hw;
 }
 
@@ -452,9 +453,10 @@ static struct clk_hw *clk_hw_register_div(const char *name,
 	psc->hw.init = &init;
 
 	clk = clk_register(NULL, &psc->hw);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
 		kfree(psc);
-
+		return ERR_CAST(clk);
+	}
 	return &psc->hw;
 }
 
-- 
2.25.1

