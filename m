Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA65AE0FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbiIFHXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbiIFHX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:23:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694CB74B8C;
        Tue,  6 Sep 2022 00:23:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s14so866462plr.4;
        Tue, 06 Sep 2022 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Pl2h4vsOG6M23r0OQYHFMQdM5uk7PYJhc61vxoQT21c=;
        b=eGNHHLgF8zyFPeewUENbB1grkS03THyOUmOlJTrQn+rOcbwtQDKW5nO3JmXhFOBvyR
         KegkNcCOrh7q02gATNVGh4mxS/4T3R4iuOCJ/7KErb1XmZgnwutu6VMCzizcS9JOL94m
         KlCEfTSwsyjVEH2wY349FHw/CofAtJ9FDtkzIpvTQ/FBAnpLJCOWSeVOfZYuEoTGV7E0
         LQzZQZsVnLEAfJfrnh/Cd75NDcVSNcdSSaKw8RjMeD8CDw89+0ASmudxMZJK3eo1Xpf2
         bzWlayvaigu8aoLth3chhXm7cbfIlsPfN+/7mdAQc6V1/T39svb1baC1pZ2MTx8v9+Q/
         BL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Pl2h4vsOG6M23r0OQYHFMQdM5uk7PYJhc61vxoQT21c=;
        b=B/khAyVUy6PVspoz0UAsmcbYyKEEorVKZ/D4irvdNj6nccp+sz0fgqmKOHU/FOttEy
         7QrXJkomCpvF5tP5IdNTv5iAxSTda8tsCApXy+zny8S3Ox0Xf2WCHIMp039hsxpwoVxn
         nyeuv0SZW68IGUivQmyjtsQkQOfer0Ob5Uky3JPXUJFRKxOmQnGc2D8uB+BOzE+fQigu
         D37J80K7cdwJtAcPrxm58dsia8WC2VCp80ZcFKv4QBdDcBfQb5yjLoL9UnoaarCXyoZb
         SaUWG5tNXU8lw2SAMK1zYb7J2riXRfOuj5UX1kWfC3Tvzg6NPa+XN5iiMjhvSSXU7oeM
         V1eg==
X-Gm-Message-State: ACgBeo05BiGZ1TdIdsWgQnn3/4sAVvabszYJuRCI4uc4jAKG08vzbLC1
        G1tYKAW3UqGbncNOYiGgibY8M/fYQ7s=
X-Google-Smtp-Source: AA6agR6te5AVdii7ND3kEy0cpnjV6KwARvvupDHtVidonGpWY/dIx7N441f7I8vr3iire1XAzotuKw==
X-Received: by 2002:a17:90b:3a8e:b0:200:78b2:d8d9 with SMTP id om14-20020a17090b3a8e00b0020078b2d8d9mr7589737pjb.152.1662449006905;
        Tue, 06 Sep 2022 00:23:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r22-20020a63ce56000000b0041d95d805d6sm7778541pgi.57.2022.09.06.00.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 00:23:26 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] clk: mvebu: armada-37xx-tbg: Remove the unneeded result variable
Date:   Tue,  6 Sep 2022 07:23:22 +0000
Message-Id: <20220906072322.337253-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value of_clk_add_hw_provider() directly instead of storing it
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/clk/mvebu/armada-37xx-tbg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
index 585a02e0b330..fc403ad735ad 100644
--- a/drivers/clk/mvebu/armada-37xx-tbg.c
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -87,7 +87,7 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct clk *parent;
 	void __iomem *reg;
-	int i, ret;
+	int i;
 
 	hw_tbg_data = devm_kzalloc(&pdev->dev,
 				   struct_size(hw_tbg_data, hws, NUM_TBG),
@@ -123,9 +123,7 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
 			dev_err(dev, "Can't register TBG clock %s\n", name);
 	}
 
-	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, hw_tbg_data);
-
-	return ret;
+	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, hw_tbg_data);
 }
 
 static int armada_3700_tbg_clock_remove(struct platform_device *pdev)
-- 
2.25.1
