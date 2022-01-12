Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62148C27B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352605AbiALKpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbiALKpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:45:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC3EC06173F;
        Wed, 12 Jan 2022 02:45:07 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so3927944pji.3;
        Wed, 12 Jan 2022 02:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JzZ7d8XwF8MhpbwD4+Hdjzg0Z45zmAN8uBwwJBzi4zQ=;
        b=q3RRx0mYNQVlr4kqv7yShIj6HRNI/aSNAiLz/bZyBgl0vAHbZZLQ/yx0ecdUCEZMM4
         DVcLGfhO67Y+j86vKUUpxgNjj7541xRuxpPhh33wLYVY+twZZxx03k5MmPrGQa3uUBGR
         VrwPj62lRchlnEkFg/PjO6PsV7V2FMd+JW+F/mtgJUsKdIquRd7s70Hzgj4W1HNt0mce
         LjgjTk7fNpbnBMyg4E6FZaiQECFmYb6mNptT2WjZDqRWcFb7YwJCvF+PPJW/2sjbNyqB
         u8N5OzR52Y0JVRBMBheoYkj4jOChFYuB3rE1Rpj+xuIEOquDcsfpUquSquG46tCt1E3h
         /TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JzZ7d8XwF8MhpbwD4+Hdjzg0Z45zmAN8uBwwJBzi4zQ=;
        b=xYIM7qtNM6B28tbODM+SN1rB6cCmnzMci2XMJZdFrslU+YHf/ZuwjLFkhbezYqKaUu
         XY9GNbrqRMh1mim6UJxwkzIwKLI9Ih5zdkgKEP3CdS3m9T8OiZC+l6VcFv0Mgjw4+tB2
         VGDvvG+wFSMa+Ca7/qaG3t67M2YVIXNPtbkjGPgjaeMbIP6JHZw2gdjXIrIBWtg9/7dM
         BsMm+gT9of1n0WNuOQhJPsVVF8dgBNaXPThhIAHupfVRNvUpFg6IO7PtPJmihKv6K4Tq
         qW1qZ7ZBeACR7uultE6cyhyE1iwHQ0P52kwxtNxhoQRFxJMsgTnq4n8/QXqJ1tvGEO6a
         pZUQ==
X-Gm-Message-State: AOAM532c9FlvgLhv9aigQBn+gY8eDsu1vwT6O20k+BGbr5M2VM5GcurK
        e7u/z7/28QFyviZ6BPsHAIA=
X-Google-Smtp-Source: ABdhPJxU4/bOztWiN9Ml/4hswAeMDpi/1GtNTavaQMzL4LfxSu03ArhdSTOGELa+Sv/+mdtDsdIX4A==
X-Received: by 2002:a17:902:c411:b0:149:e086:22a9 with SMTP id k17-20020a170902c41100b00149e08622a9mr8908803plk.155.1641984306648;
        Wed, 12 Jan 2022 02:45:06 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id g5sm14714076pfj.143.2022.01.12.02.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 02:45:06 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     sboyd@kernel.org
Cc:     jonathanh@nvidia.com, linmq006@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, mturquette@baylibre.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        thierry.reding@gmail.com
Subject: [PATCH v2] clk: tegra: tegra124-emc: Fix missing put_device() call in emc_ensure_emc_driver
Date:   Wed, 12 Jan 2022 10:45:01 +0000
Message-Id: <20220112104501.30655-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112025200.95C4BC36AEB@smtp.kernel.org>
References: <20220112025200.95C4BC36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling path.

Fixes: 2db04f16b589 ("clk: tegra: Add EMC clock driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- add fixes tag.
---
 drivers/clk/tegra/clk-tegra124-emc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/tegra/clk-tegra124-emc.c b/drivers/clk/tegra/clk-tegra124-emc.c
index 74c1d894cca8..219c80653dbd 100644
--- a/drivers/clk/tegra/clk-tegra124-emc.c
+++ b/drivers/clk/tegra/clk-tegra124-emc.c
@@ -198,6 +198,7 @@ static struct tegra_emc *emc_ensure_emc_driver(struct tegra_clk_emc *tegra)
 
 	tegra->emc = platform_get_drvdata(pdev);
 	if (!tegra->emc) {
+		put_device(&pdev->dev);
 		pr_err("%s: cannot find EMC driver\n", __func__);
 		return NULL;
 	}
-- 
2.17.1

