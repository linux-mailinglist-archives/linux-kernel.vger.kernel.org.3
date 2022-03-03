Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B254CBA1B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiCCJXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiCCJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:23:17 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D9BDB;
        Thu,  3 Mar 2022 01:22:31 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id b23so4056500qtt.6;
        Thu, 03 Mar 2022 01:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/zSPK6JEvJijyCiO9MABrtOwuhrRt9yY2leCnS6HUS0=;
        b=XgIZuW+mhwEVgZNB9ZO+iX9LiKtwmin8cXBt3P5Hewpj+JwXcqYDkDl8SYwIT47Ve1
         6UC0aedtNtUysYMmAFMXeJE9EYxVEanwBVpZ113sU+G/ZyGvfil3dM8ic9KjfjVfvB3L
         eQd1OzdGtgxWqxSz9ObNMeqhp8P9RguYj0Itc9gx4/PFCB9dVXofrryo8HLjBOn0XcHl
         oleEwQ7uAr6HnW70wt883JxIk1+Kv0wn++bDg7Cz1sKCukcJ2Hn+/b34mKO0ajQVtyb5
         7iM0jhRroUGomEBqruhafh+7uiWGChVzm4VMZij8H76cWiHfY9++kkREXPvJbEl24jF5
         w9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/zSPK6JEvJijyCiO9MABrtOwuhrRt9yY2leCnS6HUS0=;
        b=yE4BqWRVTW+9y4Tlc67YCo8PdWbb9mJDJBFO5RDGeMxXNDJdqgIVZThaqW8mxrdrj4
         ekLKJBd8Oy7NVvxGJWqF84NV1LNidmgmHK5OJ+lan2Bjkal077C++4J4BZRmfxSURGev
         whIcfUzBSEqv/1WpD2yqMEbyVwdXCvxKeZgNdxtWO45jExZWuwGToW6Bni1dvq7norNv
         HmvLy+2UyvNYaMnpIF586u+4GbszKbY2b1CVspsvueQi4JGI+g2wIRIrehJf19nM41+P
         iNR7w1+qTy9tzeopJqWbYK7FZCtRXgeJoKmbyHsphAHp+O/OzAysrAskyao08E6vF6pu
         FvPA==
X-Gm-Message-State: AOAM5300/6LB1flmhoz2NCUBQH5pnhL4augPU8fzPz26IfsRr9Pd0mJA
        0YCCbj4d4sxUIT4+YI7rMBxlaijW6ao=
X-Google-Smtp-Source: ABdhPJwG5VUeWIl21NeNrWs2YKDhLgzYhhIJRERbt2tiJT5u7bdGVyUMP9LlqEQmttn4Xwpe/ngUJQ==
X-Received: by 2002:ac8:5946:0:b0:2df:c52:86e3 with SMTP id 6-20020ac85946000000b002df0c5286e3mr21929324qtz.575.1646299350796;
        Thu, 03 Mar 2022 01:22:30 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s7-20020a05622a018700b002dfed15c9edsm1191015qtw.74.2022.03.03.01.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 01:22:30 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     s.nawrocki@samsung.com
Cc:     tomasz.figa@gmail.com, cw00.choi@samsung.com,
        alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] clk/samsung: Use of_device_get_match_data()
Date:   Thu,  3 Mar 2022 09:22:23 +0000
Message-Id: <20220303092223.2060108-1-chi.minghao@zte.com.cn>
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

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/clk/samsung/clk-exynos-clkout.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index e6d6cbf8c4e6..feed1a347c09 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -81,19 +81,13 @@ MODULE_DEVICE_TABLE(of, exynos_clkout_ids);
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
-		dev_err(dev, "cannot match parent device\n");
-		return -EINVAL;
-	}
-	variant = match->data;
+	variant = of_device_get_match_data(dev->parent);
 
 	*mux_mask = variant->mux_mask;
 
-- 
2.25.1

