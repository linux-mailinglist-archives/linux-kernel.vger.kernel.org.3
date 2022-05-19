Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDE652D52A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiESNxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239288AbiESNum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:50:42 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F062D028B;
        Thu, 19 May 2022 06:50:20 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h9so254542qtx.2;
        Thu, 19 May 2022 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GPQSto0N+lNtNNPY9TQEtm6CehsZLQib25ZHkbMOJIA=;
        b=adkuYIA2mXgko5wthuK/XjjYRyngB+DETgkoIBQDD3HMWAj9jfOOH/RCTedqah5QZ7
         bW8+W5vvpka6zCqHPWKMoAQz/YznRj0OaI2TS8ny4pIX+qNeHxSN+XX83GWkOaM2NGrB
         Gs66YMt0zhFgyL5O4wKbfjvEHY3qa9YUrhEgiGvrbUX7oieTqFuBOXXpdy6DToMR/rDz
         NsV17sJmk2u6ZU+FHtdO+hs69UKVVLIUS1eNemCHvpMPtUAV718m4dQBopAJ0HsXsQy4
         taKSoA9cQlV8VdG8NAKdXkF+pJTgNU3zRBf8Xxm/1X7CfJk99n3ic3vuFl334U6RYV0v
         5JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GPQSto0N+lNtNNPY9TQEtm6CehsZLQib25ZHkbMOJIA=;
        b=EQe0nN2uBXs214xU7cm7WLdzsEjuva6cBjxQ3T3HFhYUhSl3VL28YTA40/1isk6jze
         g1CleAxRiUXatE6OPY/RT+e/IbXO8zxAqQx2BxxjE82hD/X+82u0aGydKJNnDJb7JJet
         sYmrSWolER1WC/OMl9c6dUsZXHnU9PY+GXzJ0MPfAEa0yRkUIy58257ljQgGnEobs96J
         J+sAgpT1eAEDvAW0EJTK8NZOLimNzT6e7iAOiNK5Wi6EPX+4IAV+byuQCMHc/+aXtA0b
         0838BqYbkhRZlJQHn1fgVULlMzhAIZjGTOSnA0aN/3VYFHY6pf5W6g1/FE239dGvBJNj
         h5tg==
X-Gm-Message-State: AOAM532ix4jGVAavctqtq8KDbHfse2N6/eQTRbDHaNsL3dQNDoU5MiMn
        BMXdps0pZTQ7eiKqtc7UTbY=
X-Google-Smtp-Source: ABdhPJy2Mn4bJ/OGia0z2jO+j7RXe7CmgUJKP8L5VG0CbG61g4fYIWUGIMHMBGJozxeEppfkByZ6hQ==
X-Received: by 2002:ac8:7d8e:0:b0:2f9:1176:c24b with SMTP id c14-20020ac87d8e000000b002f91176c24bmr2139993qtd.500.1652968186128;
        Thu, 19 May 2022 06:49:46 -0700 (PDT)
Received: from localhost.localdomain ([217.138.206.82])
        by smtp.gmail.com with ESMTPSA id i186-20020a3754c3000000b0069fc13ce23dsm1315024qkb.110.2022.05.19.06.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:49:45 -0700 (PDT)
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
Subject: [PATCH 4/6] clk: mediatek: reset: Implement mtk_unregister_reset_controller() API
Date:   Thu, 19 May 2022 17:47:26 +0400
Message-Id: <20220519134728.456643-5-y.oudjana@protonmail.com>
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

Add a function to unregister a reset controller previously
registered with mtk_register_reset_controller() or
mtk_register_reset_controller_with_dev(), and do the
necessary cleanup.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Dependencies:
- clk: mediatek: Move to struct clk_hw provider APIs (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220510104804.544597-1-wenst@chromium.org/ 
- Cleanup MediaTek clk reset drivers and support MT8192/MT8195 (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220503093856.22250-1-rex-bc.chen@mediatek.com/
- Export required symbols to compile clk drivers as module (single patch)
  https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/

 drivers/clk/mediatek/reset.c | 7 +++++++
 drivers/clk/mediatek/reset.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 09862baf1d57..c1ab8c87ec27 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -232,4 +232,11 @@ struct mtk_clk_rst_data
 }
 EXPORT_SYMBOL_GPL(mtk_register_reset_controller_with_dev);
 
+void mtk_unregister_reset_controller(struct mtk_clk_rst_data *data)
+{
+	reset_controller_unregister(&data->rcdev);
+	kfree(data);
+}
+EXPORT_SYMBOL_GPL(mtk_unregister_reset_controller);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index 7418dd0d046f..0feaea4115a8 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -81,4 +81,10 @@ struct mtk_clk_rst_data
 *mtk_register_reset_controller_with_dev(struct device *dev,
 					const struct mtk_clk_rst_desc *desc);
 
+/**
+ * mtk_unregister_reset_controller - Unregister mediatek clock reset controller
+ * @data: Pointer to previously registered struct mtk_clk_rst_data.
+ */
+void mtk_unregister_reset_controller(struct mtk_clk_rst_data *data);
+
 #endif /* __DRV_CLK_MTK_RESET_H */
-- 
2.36.1

