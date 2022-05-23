Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC05D531353
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiEWOir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbiEWOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:38:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D16517E1F;
        Mon, 23 May 2022 07:38:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gg20so14267768pjb.1;
        Mon, 23 May 2022 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VsAAAqoiWJYzT060x2OOnd/EtlLZzAOosAhFcrN/2Zk=;
        b=bIrL0ljJ2ar84oH/3npslA/NhLklqWI/M3QLvrYEuyTZLsvI7bcbd4KLAfCR6pIwJg
         eCQzxsKiOV5bfD3E3Mt5MvWZ3AtY3SRbhkW8d05YIq2/QE2Eeeth16o6EziC7tF2eL2S
         CDXTqlNVFypyYv2qy7v1tUYa5CgzaI5tPWspSG0FuzfpitLuDkXy9yWu9YCTpQ9HbY3m
         L5eov2Snw8Ebg0eQaKOZyGTlHoF4w1Kb5+p2koQIDd/RiOGqO73nQnpoSADUQoPRIb5G
         Bf3r0/8sO4wSkc7mSSs/IYNOKFTHG2ts9iX4TPyheZgPahvh34aCIrxC3Qcvrlu15xMU
         p02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VsAAAqoiWJYzT060x2OOnd/EtlLZzAOosAhFcrN/2Zk=;
        b=f0K57csno82Un5ZbNDi2yQCA2U4/PNxIfZpinongr5JpqzSRg5B5qwvSaz6jy2L4DZ
         ElS5u79UzsXILIQPJBkVTdB+e/4qm9GSWIL9j24n2TEKGCe5qob/TuLOf3hLldG48Ufv
         uflocejgzSoOBVtEDMTCdgEg6Oed0UzNPoJtit5tfceWJxkYi63omiebvoPDX4ez8RvR
         +r6qROlg4IPqR8t3XBjufhrMCIe2DGtiQ6fBQkliQCzBEFdahIlPCCe5egNl/oFMt/TF
         XdAK7Ol09CJSq/wYROFf6cBWkwar7V+2Mf1Qv5g47K3k+XR1bXAMTLZ2yfKwvwj9Y1ME
         9S6A==
X-Gm-Message-State: AOAM530zyKoYMexL5EJS8XUz2laU7MJe38JQvb+EXUkneOBNOeuIne2A
        a+tbK5BVaGCvEV4GRSwz3SerZHa/Sn7YWNVp
X-Google-Smtp-Source: ABdhPJw73APqKEgTYdp3THPVllOx5I+H5e2taUgQZ0ht38Wqr+kbCW3uYL7d0L6K8+rft5bn/apxeg==
X-Received: by 2002:a17:90a:bb16:b0:1de:fd98:94c5 with SMTP id u22-20020a17090abb1600b001defd9894c5mr27400110pjr.48.1653316724163;
        Mon, 23 May 2022 07:38:44 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id s67-20020a637746000000b003c6a71b2ab7sm4857972pgc.46.2022.05.23.07.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:38:43 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        Mike Turquette <mturquette@linaro.org>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] clk: tegra: Fix refcount leak in tegra114_clock_init
Date:   Mon, 23 May 2022 18:38:34 +0400
Message-Id: <20220523143834.7587-1-linmq006@gmail.com>
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

Fixes: 2cb5efefd6f7 ("clk: tegra: Implement clocks for Tegra114")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/clk/tegra/clk-tegra114.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index ef718c4b3826..f7405a58877e 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -1317,6 +1317,7 @@ static void __init tegra114_clock_init(struct device_node *np)
 	}
 
 	pmc_base = of_iomap(node, 0);
+	of_node_put(node);
 	if (!pmc_base) {
 		pr_err("Can't map pmc registers\n");
 		WARN_ON(1);
-- 
2.25.1

