Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1652D528
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiESNwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbiESNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:50:35 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DE7DFF65;
        Thu, 19 May 2022 06:50:08 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i68so3493356qke.11;
        Thu, 19 May 2022 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwBfJw5/BJNtRay4oCR2RSqvzBCGfp1734JkjgoOzz4=;
        b=fs/uXmWU4zDYd3zoUKnpovlsFnqcRqmWaXzoviY7wwM2pBe5X5WKqiF/JoNVYlXgqo
         rd1qd9Pca064uvXp6jBK8L6PO0tKPNYhFtemVkpvOinxgzdQf0reeVTqxBroIjdI8lmf
         ZzbDvr1GK9OPkNPRntI+WIQdO1NsTUvp0M820JOhdvjqfpLhrBarf+F33e5PcPb7lYDY
         aeIsjzgla1dh87peoGViai6UGzX3IduUt7quVBqvOuii60owMzU8tZxKvEiAoV9zIiC0
         LdnZ1xo8sWe6VpuZbVWl7fRERJF+yx+H4Qo43BuOxWLGcsKb9O58JZGN9087LAfxSO/S
         asyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwBfJw5/BJNtRay4oCR2RSqvzBCGfp1734JkjgoOzz4=;
        b=PisAGzgag6/YjobR12C0KvAKkV7UuA+F5vtGBoI2/RQLDFxiaVuGqywIabLoieTmYV
         pYm2yf3Bc8P9DkmvLJomnV+jyYEWsm3+Fsnuvmt7YQDJdzuVXAnf3mSt64Jne/MJYqe5
         u+jLsgT1ktsccUmRnaqHlANlJMv/YzRCdFmd+mwZrLjV+8Y21dZaueZkWEcR7Bl2lSqN
         tZW4TUjVW98cylnvZ6b2Xdrf6i6mmkwFj9mvEiC3oqTMXvtBjtoSdJ8MCp/wsPRKAJ3Q
         PQQD926wwc5JFA4Olgh+IiFc0BYbDNaALqz5DZy5Ib/h7K4SHU9WAF9tF5umiH7bUGBG
         ExNw==
X-Gm-Message-State: AOAM5312ehEnax25P4qrYkg0UVX+aaUiz9Gv1VRPZSfro4DqO1qhqOvo
        lS54/j2qqguKxQmLmp6vYGQ=
X-Google-Smtp-Source: ABdhPJxXOzQEfbshSAFTXW/WKDfXcuWSh8vP79n1R4ztS9+cKHzly2gJ9NajNbLKHmij01cQOZXqDA==
X-Received: by 2002:a05:620a:258b:b0:680:f66e:3381 with SMTP id x11-20020a05620a258b00b00680f66e3381mr2961492qko.291.1652968170786;
        Thu, 19 May 2022 06:49:30 -0700 (PDT)
Received: from localhost.localdomain ([217.138.206.82])
        by smtp.gmail.com with ESMTPSA id i186-20020a3754c3000000b0069fc13ce23dsm1315024qkb.110.2022.05.19.06.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:49:30 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 2/6] clk: mediatek: Use mtk_clk_register_gates_with_dev in simple probe
Date:   Thu, 19 May 2022 17:47:24 +0400
Message-Id: <20220519134728.456643-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519134728.456643-1-y.oudjana@protonmail.com>
References: <20220519134728.456643-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Register gates with dev in mtk_clk_simple_probe.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Dependencies:
- clk: mediatek: Move to struct clk_hw provider APIs (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220510104804.544597-1-wenst@chromium.org/ 
- Cleanup MediaTek clk reset drivers and support MT8192/MT8195 (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220503093856.22250-1-rex-bc.chen@mediatek.com/
- Export required symbols to compile clk drivers as module (single patch)
  https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/

 drivers/clk/mediatek/clk-mtk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 41e60a7e8ff9..3a8875b6c37f 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -434,7 +434,8 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, mcd->clks, mcd->num_clks, clk_data);
+	r = mtk_clk_register_gates_with_dev(node, mcd->clks, mcd->num_clks,
+					    clk_data, &pdev->dev);
 	if (r)
 		goto free_data;
 
-- 
2.36.1

