Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E226B50F285
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbiDZHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343994AbiDZHfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:35:19 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E94F69A7;
        Tue, 26 Apr 2022 00:32:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p10so30368175lfa.12;
        Tue, 26 Apr 2022 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F0g9qo3ybY8iEO2/2tlXYPagk9pjmzx4hk34peH7j8k=;
        b=Co2nwDWBQVsthBmDYH6dvU1VZThHhk5SWTKvxo00/nQBInmNp2Nv7XedF/gfE2OdWo
         JkR6bYq97ykNARMB5OemScMwI1v+ZnuA8880YF3wQlkwA0uGSXH9XAG1wj53FFwArT7H
         IjNL8HYXhkw0+QBqQMRU1bTb1au5sk9ycQ2IZinlxHAMm+XnmaQTIicDXdVOHbdYrQjT
         vI1aSxRX4xLx1dy9MxrHxCSmTvYADpSi2mD7azgo3KfGy/alFJyPC93vUF2saNgALPy8
         +L9BG00AOD3auO4h8qWFxrjmkC08Kk8QkSCC9PGpc8nOgV3uIN7mAj5egGT38gDSj6RK
         27Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F0g9qo3ybY8iEO2/2tlXYPagk9pjmzx4hk34peH7j8k=;
        b=V28mCWkNFcd4OsQlD/63IxSnc0NuW3fB4fjkhPid2Efwv0XNXiZdgwzXX1Mq25f5Nx
         ge3ZlC4YgrfNVxkP8SVs8uvqBGmjgPbD6PqhIlEgabM3UHC6EzJqWkLjZphaf0Is5cBi
         3XJv9Oy4xsuZG2g9NiYNmmxhdOqy8bO/04w3SNE1pacPcOEsigkohTUY+gmie3Z5GXSa
         +OKtynB5S9CVIRmkuf5VA5deM+PTBbPquFpeWRctoPB/poUDvmKRMTFMvaeb2kYVPPtY
         OasHyTkdaZMK1XcG/eH24tIVyTAFqpkWfFGuIq2+n4XKsJczmDiBedquNZ+Vxl0TMMCP
         fghg==
X-Gm-Message-State: AOAM531QEmIigAcvlugkSbrsztWtSrmnh9nMx+SX0l9QaeCJhMwZkUOq
        4zJfVSn5gKg0IklxvF4iKGq5WEruztY=
X-Google-Smtp-Source: ABdhPJwdk5fuJSUq/x1Yu+hY94qEr03UpTwjOfxptGJoFyvl4taVU1gXJkkrm70HzsVYWP76KDaoZw==
X-Received: by 2002:a05:6512:3341:b0:44a:eb29:c59c with SMTP id y1-20020a056512334100b0044aeb29c59cmr15523622lfd.596.1650958331332;
        Tue, 26 Apr 2022 00:32:11 -0700 (PDT)
Received: from localhost.localdomain (adla4.neoplus.adsl.tpnet.pl. [79.185.4.4])
        by smtp.gmail.com with ESMTPSA id d2-20020a056512320200b004721999f1cesm103509lfe.66.2022.04.26.00.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:32:10 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] clk: qcom: gcc-msm8976: Set floor ops for SDCC
Date:   Tue, 26 Apr 2022 09:30:46 +0200
Message-Id: <20220426073048.11509-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426073048.11509-1-a39.skl@gmail.com>
References: <20220426073048.11509-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like in case of other SoCs change SDCC1/SDCC2 ops
to floor to avoid overclocking controller.
This commit only sets SDCC1/SDCC2 which are used for EMMC/SDCARD.
Leave SDCC3 because on this platform it's mostly used for WIFI/BT chips,
like on Sony Loire familly devices.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/clk/qcom/gcc-msm8976.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8976.c b/drivers/clk/qcom/gcc-msm8976.c
index a8b15814933e..5781a7bcecc6 100644
--- a/drivers/clk/qcom/gcc-msm8976.c
+++ b/drivers/clk/qcom/gcc-msm8976.c
@@ -1486,7 +1486,7 @@ static const struct clk_init_data sdcc1_apps_clk_src_8976v1_1_init = {
 	.name = "sdcc1_apps_clk_src",
 	.parent_data = gcc_parent_data_v1_1,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_v1_1),
-	.ops = &clk_rcg2_ops,
+	.ops = &clk_rcg2_floor_ops,
 };
 
 static struct clk_rcg2 sdcc1_apps_clk_src = {
@@ -1499,7 +1499,7 @@ static struct clk_rcg2 sdcc1_apps_clk_src = {
 		.name = "sdcc1_apps_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -1547,7 +1547,7 @@ static struct clk_rcg2 sdcc2_apps_clk_src = {
 		.name = "sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_4_8,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_4_8),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
-- 
2.25.1

