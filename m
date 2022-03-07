Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F264CF046
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiCGDgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiCGDgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:36:49 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500305E15B;
        Sun,  6 Mar 2022 19:35:56 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id d3so11131334qvb.5;
        Sun, 06 Mar 2022 19:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5XBkGbLpwKeBtWV3nxW7T3iRe3e2U7dNRaaKdhMqyg=;
        b=aCj15Rfu3s9zAggB/tbruIRc88f/jJ82tAjsZGPQys8b+IPg06+lO1UlsqNnW74Vhs
         g1Ix/vZVtZqqOtVxfBBcwDuzRIRCQ8nbr9N0P+8GduTzXi5uAYodSYccfFgAUVmEUzpn
         XN3NqsJe9iaH/uJjf4eCqZigG1X/+hYGNxGsWsXBk9wIUy0XHgJ+CJkKwt7kW+wekakG
         MBXaqGic42TIRee4pneOjeXYsV3kUwht9RXj2s0PQkfH00Wso7h6MRFRPZvPkWCwcWyQ
         jqZp1N6C0vtTN6itM6Fa9ZPMirfuHRn5IUhGNbIuLesxCTwbhBU+FJCuhbq3/hto2pZ6
         m9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5XBkGbLpwKeBtWV3nxW7T3iRe3e2U7dNRaaKdhMqyg=;
        b=GsxXbD56ERKTrNRjeL9AUT3UaE/xOktbt05IETsS6CdW1pz0qF1P3heUVINr/1XTXD
         KJh3dXF7NzTb34LJiTQrXBlcTNmmnrB10qxEHQA+cYvaB/4GE29uTqHzG3pgf6+iRFYV
         s8OnuE3oCB8sBBBbvwjH5dXw7XCjqm+CVFuZOLRLSjZnnoUB4MnnjDgZYdYoD97LtHQK
         0AckC8rcnfUpy1jMcEcTp2INMDp/7IVWo/qr2vTcD/G+PNaA3QntW4lsnPF+NFUpc5GC
         dzr/QnHp9tv3q27VR6/DI2wB/GDe5tTJkYaQdKU+/R4Nc71KcukCdzbuQLK2n6kQR1vd
         BxWw==
X-Gm-Message-State: AOAM5334pS9ZC/fr+UwTAU5JkC/hO36DrDK6hHWItf8b+DseZ4GO+0vQ
        psE8CUfUDItpeo4G/00FBxw=
X-Google-Smtp-Source: ABdhPJzu52klhBnRGqJo8805Vg4DIQqWlUEGypeXh4aucC3h7ef9+QM9aYDTXGGTP96FVPbl2pMHVQ==
X-Received: by 2002:a05:6214:104b:b0:435:17bf:da07 with SMTP id l11-20020a056214104b00b0043517bfda07mr6749274qvr.91.1646624155436;
        Sun, 06 Mar 2022 19:35:55 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i192-20020a379fc9000000b0067b314c0ff3sm616867qke.43.2022.03.06.19.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 19:35:54 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     s.nawrocki@samsung.com
Cc:     tomasz.figa@gmail.com, cw00.choi@samsung.com,
        alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>
Subject: [PATCH V2] clk/samsung: Use of_device_get_match_data()
Date:   Mon,  7 Mar 2022 03:35:46 +0000
Message-Id: <20220307033546.2075097-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

v1->v2:
  Add a judgment for returning variant to NULL

Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/clk/samsung/clk-exynos-clkout.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index e6d6cbf8c4e6..273f77d54dab 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -81,19 +81,17 @@ MODULE_DEVICE_TABLE(of, exynos_clkout_ids);
 static int exynos_clkout_match_parent_dev(struct device *dev, u32 *mux_mask)
 {
 	const struct exynos_clkout_variant *variant;
-	const struct of_device_id *match;
 
 	if (!dev->parent) {
 		dev_err(dev, "not instantiated from MFD\n");
 		return -EINVAL;
 	}
 
-	match = of_match_device(exynos_clkout_ids, dev->parent);
-	if (!match) {
+	variant = of_device_get_match_data(dev->parent);
+	if (!variant) {
 		dev_err(dev, "cannot match parent device\n");
 		return -EINVAL;
 	}
-	variant = match->data;
 
 	*mux_mask = variant->mux_mask;
 
-- 
2.25.1

