Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A949FE50
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350245AbiA1Qrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350235AbiA1Qrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:47:47 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91033C061714;
        Fri, 28 Jan 2022 08:47:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so11394383pjt.5;
        Fri, 28 Jan 2022 08:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4eWgk8DR7GAT8RScGPgtPJ9OOwKkWW5UUG5CMXRZ1BY=;
        b=cHYZFwQFHKOpWZ8QZadM5qtwujFptR4ATqBWCNoQbylpkw6gGn+w75cuXeX0xyrCPj
         S9t0ZM9P6JP/EBCH8jv436iJX06JP9f+qBRYFcfgUv6BnVlVMGKAIY4P0uvN2OR1zJj7
         TxhTNwDYrEbNYSDG7YXC/pzBjdF09F04DK66m4vIZx9qV5N9IrmnPZKAtUelCdjp54p0
         rxEdpJK4jmgMQMZOpYq2KqgnCTqncU+iiDurgywZg7jDHdXfnbHqrs2di8Fr5a8B6Gbg
         OVNRryr6aUzKygxztXEYRxZQ7huAhfyUduQVDpgz5gJvHuj1zcfKha1vz5/bbD6ed7xN
         R6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4eWgk8DR7GAT8RScGPgtPJ9OOwKkWW5UUG5CMXRZ1BY=;
        b=1wy1FYyE/k/YWVlZ48ob3mSjoDH69OYhbeBWdxLhM3iOZDuaIx5ZcZrpcVZhDzZaa/
         N4v1iJcd+K8Ke7VM+dJv9vlrYfb6TIhbw4d5hbX1WNeYJeetj0DjLkqWB93818VYj506
         GvP9puD0H23I+ykE2GmzLUu4kr9ooow3eKTDBmYaM3P7+JNoA1L0MwxDWR/96H6FNjul
         sRyf/nynHriU9dbdSteh2rEaO/jILI+ZOVlh50aitgDAfLv3UQscR5PEwRhLKO+raSzX
         v8cMasUMGl50MMFgVP6L52z4JFGWxljJVnV+Hgb3buyQ/R3WCAygZFPneXVrEpFpQXUI
         LQuA==
X-Gm-Message-State: AOAM532mYgEUw362BWDud15mzo+lt1decBciM2+aS7lrA0jMaOkkZR91
        UajopcOJufcyZnS1/LiGVboVPAJQbrBUNHVAX8E=
X-Google-Smtp-Source: ABdhPJzch/bx/xK6veOuRW6EwCaBlWtlLwEVKYSwAe/a9XLLwiiV+ZfsPbLgF2ega5d5XzNoyIuzkw==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10mr5105001plx.152.1643388467079;
        Fri, 28 Jan 2022 08:47:47 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id oo2sm3306726pjb.31.2022.01.28.08.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:47:46 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v3] spi: tegra20: Fix missing IRQ check in tegra_slink_probe
Date:   Fri, 28 Jan 2022 16:47:41 +0000
Message-Id: <20220128164741.23846-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <adfcf465-cff1-e15e-89fa-fdc573b7820f@gmail.com>
References: <adfcf465-cff1-e15e-89fa-fdc573b7820f@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_threaded_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.
Stop calling request_threaded_irq() with invalid IRQ #s.

Fixes: dc4dc3605639 ("spi: tegra: add spi driver for SLINK controller")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- fix wrong func name in commit message.
Changes in v3:
- fix Fixes tag info.
- remove redundant error message.
---
 drivers/spi/spi-tegra20-slink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 2a03739a0c60..f8661963ecba 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1100,6 +1100,10 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	reset_control_deassert(tspi->rst);
 
 	spi_irq = platform_get_irq(pdev, 0);
+	if (spi_irq < 0) {
+		ret = spi_irq;
+		goto exit_pm_put;
+	}
 	tspi->irq = spi_irq;
 	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
 				   tegra_slink_isr_thread, IRQF_ONESHOT,
-- 
2.17.1

