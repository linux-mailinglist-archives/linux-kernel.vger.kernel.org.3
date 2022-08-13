Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C382359196F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 10:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbiHMIdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 04:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMIdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 04:33:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A716B64F;
        Sat, 13 Aug 2022 01:33:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l4so3392858wrm.13;
        Sat, 13 Aug 2022 01:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=XGEs78t61pwV6z3o8igEPiG1BYLAhumLfK2vsVLOvIA=;
        b=Au8c358uhsjusyM1DYBsBAk6XpkgxHtNdF0Mo4H7rpPFZfeua78wPKIT82gnkdWiL6
         3pcRhBfcMF1EjOoaW6sWed78nJ/oAnJuGfRo6uERH7iy5aWvlnBcOJ9G/1ElexJh5D8M
         V7wmotx1ITh6LXVnlaOtjwst/hdEPtkonvzrZGxBJE4R2x8tYYSicvB/J6/Kbq+amqbk
         6Z4W8yBc17YQI6igVOrqHojnX2e0n0ESqtIQUpQURHrNycd8v1eagV0D0sWx0YF+7rl7
         jbs62XVPFg8XSqpxXXCcw7dbTQg6Lxp4I07099QSA09x8DSbGmhaPE0IYGV7HraLV8Ag
         Pj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=XGEs78t61pwV6z3o8igEPiG1BYLAhumLfK2vsVLOvIA=;
        b=emcMdgs/z9uw4L2llMlQrweM+UpVeeLx8ATjoSZTBrkWDAATFV7Ej+UX4KtrkGq7CS
         JhxcyQac7Lre8xIWV2N+RRgX5JtQYqG4qRDidvV8KnhUCRev2BIK/aMx3lT4W7kTvGbS
         aexH+VADmzNG5/ZKRSLwrQTj75Kmqf+qxTiN8AE3+ydnblpU4TK/KFQ2/KMGF/EgwVnk
         W3ofzX+bASRTjGnlXVu6RUK94Cvh7MSAyoW6Q8cZRqvTnWPQNM+9dcm1eAijwK/Xqg/Y
         lWiyRQKYhYUEDmvUFKgIsspQ/sqhnRxI5iwVqWs5kXAdjWnsUiu+vRvbCuJYZ6VDx8IS
         BYfg==
X-Gm-Message-State: ACgBeo3nCemsiRBHjv2LrWDvtiy9UOQ9W0mJQ1BFc4FyZkN6+dztdPcy
        vmpZhZjyRp4Zzq3ehUbm5XjNLw0wrqk=
X-Google-Smtp-Source: AA6agR5/Uen48okuYlyJMikWEFJDJ47YA4XkvLJ/qnLoWqk+4jNv47jTLJHr3RNKjp+insaSa9wJcg==
X-Received: by 2002:adf:e542:0:b0:21e:c148:3ef2 with SMTP id z2-20020adfe542000000b0021ec1483ef2mr3912848wrm.533.1660379593822;
        Sat, 13 Aug 2022 01:33:13 -0700 (PDT)
Received: from localhost.localdomain ([105.235.129.49])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003a54109a6a0sm2142267wmm.3.2022.08.13.01.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 01:33:13 -0700 (PDT)
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
Subject: [PATCH v2] clk: mediatek: gate: Export mtk_clk_register_gates_with_dev
Date:   Sat, 13 Aug 2022 09:32:49 +0100
Message-Id: <20220813083249.45427-1-y.oudjana@protonmail.com>
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

This allows it to be used in drivers built as modules.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
This patch was originally part of a series, and is sent alone now since
it doesn't depend on the rest of it and can be applied directly:
https://lore.kernel.org/linux-clk/20220519134728.456643-1-y.oudjana@protonmail.com/

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
2.37.1

