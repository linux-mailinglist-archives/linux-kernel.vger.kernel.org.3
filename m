Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E425B5144FE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiD2JFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbiD2JE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:04:59 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7ACC4014
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:01:42 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id b17so4915055qvf.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qN8jOmqbyrS5RXGoZd3xn3V7UmWY48sLU7iq7QyAz14=;
        b=FiDOg6lxP6rQx1sCZnORopQcjFJvUQJ9ahgsWSTXHs5VvmGFrNMxMAJHVrRHylpvyp
         U1rm6EUxZEFK/A827xLVx/WghsxsivlyTvk49D7omiROu2VgJVK3HY8DC0thMl2FGslc
         VBfK0Jr3Q9YNj826nS555ffrXLSBJ7VkR73x6nkP6jwzomqHHRHTd+2jHxnak1IDtkio
         hQ16jmkxIIHvnJj122czUM0I3vS02Ynvy9pKSbU8RPLV1KVi2EBKqFNuTjCHp9J0dKjs
         0DIJxahxq20epdWhY/5G9WknNy45BvrKqQ+kOkKo8IhTgL/Z1GamYuddLHBZFdVJ4uaP
         KqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qN8jOmqbyrS5RXGoZd3xn3V7UmWY48sLU7iq7QyAz14=;
        b=Mfzr0XQ7RgHWVqzU7Y4pJNLQel+ceVqfPkDETY/J73OtPJaUVfxkUOapD1XH3sXGZ+
         BtF0D/zZfmmgiwsxlv8I53wWuRpcHFLSbv0GUqeTA/Ad7BU3BC0nTbBEprnsSBnxJgsn
         azZFksTrqQd9o281Yt72PSG6zPRE2Sbvcj+rBczshxx5qjLjSQ8yWQ/8hyPGk32JYdR7
         4z14e/sitNMZLuHYWmUG6CX8Jhkw0E3EdQJnsixvQtGojh2VXR6cGa7qMohm9gm/Bep7
         4L8X8aVH0cWVUB3f+rJPixsEnysofoTSuTAJF8xH+hX2HhfeN4IvRR7LwMnWXh1Zvwa2
         uiKg==
X-Gm-Message-State: AOAM531G86fIeS4oc7gtjVnbm0jHDgWtKVYJWs9jR1D+UtLQSTAS6xAI
        2BuUAYyYpL9kzClRs6gBPQ/0vI+9h8s=
X-Google-Smtp-Source: ABdhPJxyExyJJzS7R0bfMElF3R3wnu4fZpxOr6n6j5Muv937Ppjb7aYPXlgnhcPrUze8NFAi4gyLtQ==
X-Received: by 2002:a05:6214:e8c:b0:456:5066:1922 with SMTP id hf12-20020a0562140e8c00b0045650661922mr9158678qvb.106.1651222901385;
        Fri, 29 Apr 2022 02:01:41 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o14-20020a05622a138e00b002f335c3dbf2sm1275086qtk.37.2022.04.29.02.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 02:01:40 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     tomba@kernel.org
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] omapdss: HDMI: simplify the return expression of hdmi_init_pll_data()
Date:   Fri, 29 Apr 2022 09:01:35 +0000
Message-Id: <20220429090135.3852817-1-chi.minghao@zte.com.cn>
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
 drivers/gpu/drm/omapdrm/dss/hdmi_pll.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
index eea719243eaf..10c6b3e492d3 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
@@ -131,7 +131,6 @@ static int hdmi_init_pll_data(struct dss_device *dss,
 {
 	struct dss_pll *pll = &hpll->pll;
 	struct clk *clk;
-	int r;
 
 	clk = devm_clk_get(&pdev->dev, "sys_clk");
 	if (IS_ERR(clk)) {
@@ -151,11 +150,7 @@ static int hdmi_init_pll_data(struct dss_device *dss,
 
 	pll->ops = &hdmi_pll_ops;
 
-	r = dss_pll_register(dss, pll);
-	if (r)
-		return r;
-
-	return 0;
+	return dss_pll_register(dss, pll);
 }
 
 int hdmi_pll_init(struct dss_device *dss, struct platform_device *pdev,
-- 
2.25.1


