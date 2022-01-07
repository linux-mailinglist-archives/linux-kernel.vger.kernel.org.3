Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC9F487415
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345805AbiAGIYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbiAGIYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:24:42 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993DFC061245;
        Fri,  7 Jan 2022 00:24:42 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id g2so4870593pgo.9;
        Fri, 07 Jan 2022 00:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=WtLGsCrs6oaOhLe+VQXDzRq71v+rbr11qctVh2htIKQ=;
        b=ap1tO93bDo/S+bcu3kEQrSkXl6lnnIRmFxbM+zZDOXWU8oo54hF8M/a6q7S8a34AMg
         Fvb0xvnSZGYCudIr4eHfVVFYzuOHoN52x/tsv+KdelRC4TPIMJr5LtJq2YKpS3rAi5gW
         Y2TekZv4L9usC+UbUB1jPnWiXJlxEMx60I0sec9TlwiRYRaIGDa1GAGZWh6dkJVqj9Sq
         Sr1RPbS3N5XLiCcDzb/ork4RozS0t4KYD5c8O504pDm9IiBNN43jM7PaD9jcML+D7xta
         /yG5nOnR2l4CCvY7EAKgGI9qtDCOyhhSdR+a36szDupj4vSZEn8hbB3g9PFTV5R6JUsg
         W4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WtLGsCrs6oaOhLe+VQXDzRq71v+rbr11qctVh2htIKQ=;
        b=Iy2w0ZHy2QYii1i7F1Ta/yk/RuwM5/GAua1JgDLEY2E/wAbmaxrLasY3BrYobb53kG
         XbPXb9iXM12WqbA4jGH5tDQwRsmRNSoXkTsrDKDC4IXEMawVnjl3AYVXYebecstpLGUp
         SAGYlDr82kXQ0+kKKlybogyCIYW7HuSTyKuB9QoqGPrtWt8ro9Uubx/aoTUBAAjXgDuI
         AdWZhxyMVj28p9bgiWV5ETXwNt1T0YYhUG0YsRwbqFjYlgk8ox9dZx6rdj3NGl2vUlXb
         EKgjX5Jpwv9emJ101uoc7N/zPb6QLHDEu0/uLOfl2ODOhSV7wEM8j0/v2FfWe/hn8tLK
         qgag==
X-Gm-Message-State: AOAM5300O5KUdQFyM16ydcSqSV8+JouBVY/3IdePATo2gZa4+tdw+qAT
        PsrkSaO/FCEO0uckYByltzQ=
X-Google-Smtp-Source: ABdhPJzhPWaoKFfZ/MO94DlOUAHangb0E+B7CpDDTc3L95JGqdzIUy87aLS15WukZj2GRH3xIhvx3w==
X-Received: by 2002:a05:6a00:16c7:b0:4a5:d9c1:89da with SMTP id l7-20020a056a0016c700b004a5d9c189damr63875071pfc.34.1641543882138;
        Fri, 07 Jan 2022 00:24:42 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id k6sm5107471pfu.96.2022.01.07.00.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 00:24:41 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: tegra: tegra124-emc: Fix missing put_device() call in emc_ensure_emc_driver
Date:   Fri,  7 Jan 2022 08:24:36 +0000
Message-Id: <20220107082436.17716-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling path.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
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

