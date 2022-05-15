Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08A527765
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiEOMYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 08:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiEOMYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 08:24:14 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7771C1FA71;
        Sun, 15 May 2022 05:24:12 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t25so21590334lfg.7;
        Sun, 15 May 2022 05:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SUYig9sC8leaYOCWOdsNI+HlvuAaX37oi9lRYpsx+P8=;
        b=iiOULWswBYpK90JecBC9nc/knvuCpa1b6yQplA2pSGWDfTpf6U33KTLWFFk1ormmAM
         mgn3612DFjZpvY3q8R9gcQxuHrK6gQcSTZxKCqI+2JrWANkh23v0omtIQjutDebbEpHB
         iCD7cQQ6PHQ07YdTj7LxnlqDvxFfEd8BUC5IMwI0ytw9ZaeMZ5BnNZRj3eFKJOTHkwAD
         VyPciobVHOg4BY4jtVfmZEyUGnO/V+EDVUlzvb4UC6gvop2/aBvkQGFBuBnmNunI6d/1
         kIGeRcjPbrcU1xPyiRLB4EWs+2HzcW/23263gYNeIvnRVLfGerfzVMDRtmGfL8UeNiJE
         ku+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SUYig9sC8leaYOCWOdsNI+HlvuAaX37oi9lRYpsx+P8=;
        b=uIeGVe19x9QvNSPFJEKowN3sscERmzxSEWi4kNzGSGnJITJvHTy6v4m0Pbn9vrPDlL
         xHE3TzY84tcti+ZJOvR4rHodxBIxrZql+bXaVeeZPLeiFYx15DWmG+UqhozjklKNo7xk
         TPZfL2lQIFX4pksTh6UJa8Rbz+xcI3nKYpKbpzo88hICk58LxvQU7MP1pMAG0WMPG9Ni
         Y/B5mb0BJL9xhGivCzviNOTa9HXqh8P3QB6hGQFUC6RcuWAnytUuVazSJWyGBoENA8Pi
         FnWIna5XvHZBnxhOL4doZQfKg2gaha6plqPg1SHnUnb5i4GuOKGRgKmbhusFByJ2IDgN
         xB0Q==
X-Gm-Message-State: AOAM5336+4fWGSeCC0skuo2x+Hg4q4vqC6rPnk2FU/zQ3bPK66E4JN6m
        zWPpLPvJjHK77/pKxW2EUno=
X-Google-Smtp-Source: ABdhPJxueo7UdkBUCiG7xkIxGrbVht2IPsYta1UK+q2vDQr9FAab+n0M0AQ2er67IN7IQerFev5Htw==
X-Received: by 2002:a05:6512:3042:b0:473:b1e0:5667 with SMTP id b2-20020a056512304200b00473b1e05667mr9843775lfb.516.1652617450856;
        Sun, 15 May 2022 05:24:10 -0700 (PDT)
Received: from localhost.localdomain ([104.28.198.246])
        by smtp.gmail.com with ESMTPSA id 1-20020a2e0f01000000b0024f3d1daea2sm1172501ljp.42.2022.05.15.05.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 05:24:10 -0700 (PDT)
From:   Boris Lysov <arz65xx@gmail.com>
X-Google-Original-From: Boris Lysov <arzamas-16@mail.ee>
To:     arzamas-16@mail.ee, mturquette@baylibre.com, sboyd@kernel.org,
        matthias.bgg@gmail.com, wenst@chromium.org,
        miles.chen@mediatek.com, angelogioacchino.delregno@collabora.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: Fix unused 'ops' field in mtk_pll_data
Date:   Sun, 15 May 2022 15:24:09 +0300
Message-Id: <20220515122409.13423-1-arzamas-16@mail.ee>
X-Mailer: git-send-email 2.20.1
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

From: Boris Lysov <arzamas-16@mail.ee>

Allow to specify optional clk_ops in mtk_pll_data which will be picked up in
mtk_clk_register_pll. So far no already supported Mediatek SoC needs
non-default clk_ops for PLLs but instead of removing this field it will be
actually used in the future for supporting older SoCs (see [1] for details)
with quirky PLLs.

This patch depends on series "clk: mediatek: Move to struct clk_hw provider
APIs" [2] by Chen-Yu Tsai.

[1] https://lists.infradead.org/pipermail/linux-mediatek/2022-February/035093.html
[2] https://lists.infradead.org/pipermail/linux-mediatek/2022-May/040921.html

Signed-off-by: Boris Lysov <arzamas-16@mail.ee>
---
 drivers/clk/mediatek/clk-pll.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index cabdf25a27f3..509959a325f0 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -347,7 +347,10 @@ static struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
 
 	init.name = data->name;
 	init.flags = (data->flags & PLL_AO) ? CLK_IS_CRITICAL : 0;
-	init.ops = &mtk_pll_ops;
+	if (data->ops)
+		init.ops = data->ops;
+	else
+		init.ops = &mtk_pll_ops;
 	if (data->parent_name)
 		init.parent_names = &data->parent_name;
 	else
-- 
2.20.1

