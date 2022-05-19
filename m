Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E0052D520
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiESNwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbiESNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:50:35 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01420427C7;
        Thu, 19 May 2022 06:50:06 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id dm17so4629237qvb.2;
        Thu, 19 May 2022 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XR4ztzwAfmurkh92tXKLFkllUmpZEqqatJbPeBbcOM=;
        b=m+kywaRl9XQL9PMsizCVDjVI4pa4msSwSGHHkLzTxeizpWwebWTLOtp0fGGy7zcdA3
         JNUQc3vk1MYM56qDik0bw+s1rFMdPA5/2s5l7IdzpbBj1Nno28ggt0dM2M84iU4cW+ba
         7mtzTUMAGu0K/k8LTaw9Cz27HE6mHrCe32yDTj5h3kXfwxm0rPqC+v7p4u8PacpXGYLQ
         vgR6fF+OG3mt4jYAZGiESEB3mqlZLGN6vFHJ5yJZLJpB+bAXjxGF5cvaZ68tNTt5pRfo
         8mMnPQIy0Dqtei/2DeV72q+PmDLnmTUtuUYlYtdB25xJ7LryAD8n08vvKC00fnOz31H5
         rwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XR4ztzwAfmurkh92tXKLFkllUmpZEqqatJbPeBbcOM=;
        b=0rP1eUe124m4H0uLGQo6YaWsSndwal/ZodZ+a3kAHXaW/upjk4DjCN/xlU9FwVwil6
         UVlnAFf1HNtrj68bW4yzB3YhQ1a+0bDULyvuualIPvBG5c3RRQPkTmRrbCyzeDn0rbvn
         v0GzGqzGZESBmJboPplRfaJT8pYnJ8iC4TnGNOZSgVe/cXsr7Ug0ZegGzAOdhQkQSOlJ
         FhveFTWLQzJX0qARrIBXXxy2+4sAAFNOsiuPnRZj31ssSIn19ltEw5IdZHoORtRIX3or
         JZB7XUQPH4q3KtP5quU4uKrBgb8DLHvddOEdsv25+e7pjzL6CSZqRkCaeShlzfkmBDT1
         1T0w==
X-Gm-Message-State: AOAM5338HhCJwboSwqdw21b01Z09gT+GxYo9K78XxrHHeq3ciARmPSaj
        YW3YsWdCQhAIRIZzw1GCOZc=
X-Google-Smtp-Source: ABdhPJz3B+e46dXhNUkl2WT1y31axELp3CqGKGpHA3AN7h3CTzl9SjS7mKx+1xlBV234PR20g/oMdw==
X-Received: by 2002:a05:6214:e4a:b0:45a:dfa5:404a with SMTP id o10-20020a0562140e4a00b0045adfa5404amr3973844qvc.126.1652968163004;
        Thu, 19 May 2022 06:49:23 -0700 (PDT)
Received: from localhost.localdomain ([217.138.206.82])
        by smtp.gmail.com with ESMTPSA id i186-20020a3754c3000000b0069fc13ce23dsm1315024qkb.110.2022.05.19.06.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:49:22 -0700 (PDT)
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
Subject: [PATCH 1/6] clk: mediatek: gate: Export mtk_clk_register_gates_with_dev
Date:   Thu, 19 May 2022 17:47:23 +0400
Message-Id: <20220519134728.456643-2-y.oudjana@protonmail.com>
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

This allows it to be used in drivers built as modules.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Dependencies:
- clk: mediatek: Move to struct clk_hw provider APIs (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220510104804.544597-1-wenst@chromium.org/ 
- Cleanup MediaTek clk reset drivers and support MT8192/MT8195 (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220503093856.22250-1-rex-bc.chen@mediatek.com/
- Export required symbols to compile clk drivers as module (single patch)
  https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/

 drivers/clk/mediatek/clk-gate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 421806236228..0c867136e49d 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -261,6 +261,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 
 	return PTR_ERR(hw);
 }
+EXPORT_SYMBOL_GPL(mtk_clk_register_gates_with_dev);
 
 int mtk_clk_register_gates(struct device_node *node,
 			   const struct mtk_gate *clks, int num,
-- 
2.36.1

