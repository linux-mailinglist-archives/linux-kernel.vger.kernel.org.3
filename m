Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9A8591971
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbiHMIe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 04:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMIew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 04:34:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17106B664;
        Sat, 13 Aug 2022 01:34:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l22so3419053wrz.7;
        Sat, 13 Aug 2022 01:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=IkARQOyCkbKRyiQVo0E+3fF3PnzXAw1PITXNc7Jpyh0=;
        b=iy2tGlJJWOePjP4JMIf2lWvBMTtWcxBCklDT3Rer6sFEgnlJJEM8z97vQMqav6pmT4
         Is04EhSQMJadSQuv0fQj0oYzHiIpgrfvRQ2ZvQFvsdsnkk4gSZk/N3G1jAwUMHp71imR
         kimdykDY14s0nu8Enb9f9vSCxCHQzqjYVfmjceGisBBurTmDOI4G6A4/MLrow2KUmh7p
         6I8BLVpwbxceUC7ozfY62oeon/v9MJ9RtG++gaUugVc938y4pSUotBSwG7Egl5CAv0/s
         dLSRQ9l4/yS2jxQI0GEYexvHn3vk/iRdZTKI12cTYXen00JY58bnctTmka273oG6i1Ue
         fEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=IkARQOyCkbKRyiQVo0E+3fF3PnzXAw1PITXNc7Jpyh0=;
        b=VeGzH/AWH0YaFoTPNgh4q2GODouZRGQpehsLfcsP1Bk9nCZNmYuoooeUnUJiHjUuuQ
         ofsrRBymS2zOiXgr0lX1LQ3nfR6PAM9SaDduBZyjS2qLMzP8jNY5T9v9tYUQ5Nb4UvDX
         PCBT9GNwpQZWjyUi+WSw8Zyk2BiPfoQ31fVD4hPU0zeoqKAF0JkIAxAq7k96IbvwyMQL
         8FZ5Ex+f5QoaGI+5BEOjIhl7yhHM4JgrM8u0LuQGkjGrDI5WRjwNnaSuBLgUWMkZ3WXy
         6t8vsdY9THVpKpU61FmCNCudbyc2Olt7tkbeo0r8l/SzInCnOg5p5KHylmPvu4DRdywi
         u2Ew==
X-Gm-Message-State: ACgBeo2lOpNafZi00ka6Sbk+E8qelSextO++jqKGHxxhg+7JK2t62ThZ
        alzvgFH/iSoMTeFOAEvgb0A=
X-Google-Smtp-Source: AA6agR7rr8NCgKEiWScS7tmJrKZ0xvzCBH96rM1Fx03ZPKypl/m1UJj5NiIZA8ksFaWKOBT90pXuGA==
X-Received: by 2002:a05:6000:547:b0:218:5f6a:f5db with SMTP id b7-20020a056000054700b002185f6af5dbmr4024036wrf.480.1660379690470;
        Sat, 13 Aug 2022 01:34:50 -0700 (PDT)
Received: from localhost.localdomain ([105.235.129.49])
        by smtp.gmail.com with ESMTPSA id q4-20020a05600000c400b0021e8d205705sm1471365wrx.51.2022.08.13.01.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 01:34:50 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: mediatek: Use mtk_clk_register_gates_with_dev in simple probe
Date:   Sat, 13 Aug 2022 09:33:20 +0100
Message-Id: <20220813083319.45455-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.1
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
This patch was originally part of a series, and is sent alone now since
it doesn't depend on the rest of it and can be applied directly:
https://lore.kernel.org/linux-clk/20220519134728.456643-1-y.oudjana@protonmail.com/

 drivers/clk/mediatek/clk-mtk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 05a188c62119..4977870912b1 100644
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
2.37.1

