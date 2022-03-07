Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4584CF2FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbiCGHxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiCGHxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:53:44 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120013B566;
        Sun,  6 Mar 2022 23:52:50 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v4so12588619pjh.2;
        Sun, 06 Mar 2022 23:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=fNVhu6NstuF9oQwubQhxrrg5qS1nBL78GxXqPU0UXj4=;
        b=AoG99Mg6T+IVKUbJHAXoR+Sp8bcgGB0jHy32u7VbdEU8d+2Om7533Qb85hxIS9xvSd
         8HArsoR9K1FP693STCoRuFab6hWwsDuy8t8ZSW+9TuqV/QV6Vvc2dchHX6Unbef+Z7iC
         oJHHa+gzIAo4ERyLoSCysrR/5Z3hkZXgOql3M3qk76UintPRcg+U1XZf5AABzii1YVxN
         n5KJMCnDz6+ZFJQVaoJpr2hc3gJTLT3dVS8LL6K3AFDJEaNdsbjtMQczFWGlnt35J+l5
         v8xTdOuehkXK5ejjVNOckogM111ptMethooTfaQB2DLf5xeoTl1tAlC9gBUJlvHT3OIa
         mrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fNVhu6NstuF9oQwubQhxrrg5qS1nBL78GxXqPU0UXj4=;
        b=Vtd956dZzbRbGmmYOYMwl6PfV3gv+g1vn5lHRuzZpEmkazDtnR9c7CJI2eAa8WaHcK
         nN/q8whjg1H2lRj8ir8+eECmPuYzBaLBhk3mEfZ5nUzSdzrn3d0OxJtrQ8EkwPAKgh/B
         DzKNUj7iUmdAKRRnYh9WSONI0oZVjlkkcqb8V4wtawLDA5QwAKLITRtGnRvM8dZNV/by
         9/ZU4NAxpWRnQHk/G/AXrLkG4dljSuAU8TI5UvYAKWnl0ljfe1xmJR8ZxPQsIjlNqZet
         58QQIAZr6UjMGGd0w+0SpPr1K7BRhb97A4XnO9aloPlADdu/5Y80Qra9U4UP7COgG53f
         7ZOQ==
X-Gm-Message-State: AOAM5312rCMmdIPopH4rv/ooKiN/Xxry8lnH3RthWG+ERmwL5EBKJlw6
        RYt4MRBxY1xTBDPMSAmd/Fo=
X-Google-Smtp-Source: ABdhPJwdZXTCxgo9TNoVYXkRa1iK3ipktgWmQFvyow6ygoh7afXRkDlVL1IVZIQJ65C6hA06x7FtVw==
X-Received: by 2002:a17:90b:4b4a:b0:1bf:83d:6805 with SMTP id mi10-20020a17090b4b4a00b001bf083d6805mr24285924pjb.174.1646639569513;
        Sun, 06 Mar 2022 23:52:49 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id a133-20020a621a8b000000b004f6a79008ddsm12310777pfa.45.2022.03.06.23.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 23:52:49 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Younghwan Joo <yhwan.joo@samsung.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] media: exynos4-is:  Fix PM disable depth imbalance in fimc_is_probe
Date:   Mon,  7 Mar 2022 07:52:06 +0000
Message-Id: <20220307075206.10737-1-linmq006@gmail.com>
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

If probe fails then we need to call pm_runtime_disable() to balance
out the previous pm_runtime_enable() call.

Fixes: 9a761e436843 ("[media] exynos4-is: Add Exynos4x12 FIMC-IS driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/media/platform/exynos4-is/fimc-is.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
index e55e411038f4..81b290dace3a 100644
--- a/drivers/media/platform/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/exynos4-is/fimc-is.c
@@ -830,7 +830,7 @@ static int fimc_is_probe(struct platform_device *pdev)
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
-		goto err_irq;
+		goto err_pm_disable;
 
 	vb2_dma_contig_set_max_seg_size(dev, DMA_BIT_MASK(32));
 
@@ -864,6 +864,8 @@ static int fimc_is_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(dev);
 	if (!pm_runtime_enabled(dev))
 		fimc_is_runtime_suspend(dev);
+err_pm_disable:
+	pm_runtime_disable(dev);
 err_irq:
 	free_irq(is->irq, is);
 err_clk:
-- 
2.17.1

