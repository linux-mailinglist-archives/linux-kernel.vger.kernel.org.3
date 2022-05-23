Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800B1531247
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiEWP36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbiEWP2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:28:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3815FF04;
        Mon, 23 May 2022 08:28:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d22so13407518plr.9;
        Mon, 23 May 2022 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUC4YaTkSvnRYrJyCu9bbmLHjPFEHYU8Y+xctYQuBfo=;
        b=pBMqPUwvyvmRiCSpJnrPcKBj4tXANwPwaJQfBeQZbvwD5TWozoyG0AJi0UUreYt344
         zOf8BbJLr7L8Q27sVXv8Xe/01vjze+sZIZujLJtacMGT25Ek6OwfZJzjVLxZK7pnRZqq
         w+NlZCn2XazKc9Q+SsUiwDR/EcgWrQCOtFh2AJkgN/dGFO7ntUZsjWuMBlNAjO7V8hp8
         KM56AtIcTVjuRmWL68A2wCVioWILVggaPBR20LmcqgoOAbSmpWCZAKhMpwl6ObVUpORP
         4ZNxuFZze22j3imNb4w8yFimrFs8SKdWRstnlHu8BGCnFqUf5JcdPkmeqsZ4Ly0QW9RN
         yp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUC4YaTkSvnRYrJyCu9bbmLHjPFEHYU8Y+xctYQuBfo=;
        b=fA5ZzaXz0lHsK56YcpT7hgxF+7saNSM8Sc8qijxsKRrHs+hPaNjB3sebh0kWKxIhWu
         XC7ekH8hIxzb26x0zXZtDDjcbO9UikcglDjfPCZf1MI+N3nyL4cBbb76F+x49wsHkkr1
         qurM+WEwHmluTR++ezoN6CQdc1ce7B7fuDJJiZ4QwJoiDOdaH/B78bMyMtcDN9LGTY7B
         PD7k6ts184eW/C/E1OolQZc7TBNNAxWT2JKwwZpPTvLPJz+MEn7fNzXc/MkIqpEtymPE
         rWgEoaFrnNcuVMhtbG5585DLzMSwVl+yvL4jHAYTra/w7iGMnASNcR4MCa+uGLb6jjyj
         yY7w==
X-Gm-Message-State: AOAM5320em1uWd9xJd78fNkF1Puzx87sbUiHVrPccgAjrw1WLe0G5eDe
        /DUp0nQ4Tljs+00/d8Ru6C0=
X-Google-Smtp-Source: ABdhPJyiXyFb6VGU02rrA8lDxILq34YkqQDZvpgVob/1vxaCbMYzV8kEf0lpwxYeYymyJEiLCAvhpQ==
X-Received: by 2002:a17:902:b58b:b0:162:2e01:9442 with SMTP id a11-20020a170902b58b00b001622e019442mr3261166pls.6.1653319700549;
        Mon, 23 May 2022 08:28:20 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id p1-20020a056a0026c100b0051810d460adsm7412307pfw.114.2022.05.23.08.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 08:28:20 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Warren <swarren@nvidia.com>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] clk: tegra20: Fix refcount leak in tegra20_clock_init
Date:   Mon, 23 May 2022 19:28:11 +0400
Message-Id: <20220523152811.19692-1-linmq006@gmail.com>
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

of_find_matching_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 37c26a906527 ("clk: tegra: add clock support for Tegra20")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index be3c33441cfc..8a4514f6d503 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1131,6 +1131,7 @@ static void __init tegra20_clock_init(struct device_node *np)
 	}
 
 	pmc_base = of_iomap(node, 0);
+	of_node_put(node);
 	if (!pmc_base) {
 		pr_err("Can't map pmc registers\n");
 		BUG();
-- 
2.25.1

