Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5FB4CCB39
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiCDBR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbiCDBR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:17:57 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA217B0EA;
        Thu,  3 Mar 2022 17:17:10 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id gm1so5531008qvb.7;
        Thu, 03 Mar 2022 17:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nef46n+0WiAiPTBLsF8EixaVYmTgFHXQPrMltQQQvcc=;
        b=pkXHG1K2UDN7+lz4dIByc+OJNuFrtjXMd/IOu9/RyQ4JPrwLat06ySKgkjThxRjWq2
         ryurXjG3x+vH97U5O0P8F6zkMq9iDuAo9VjTkWd8uzUIhO7+KrtNw++uzZw/qPftA3nH
         93oN9HbXjlYa3aiWW9zJEL9wPoMltff31cpxBinNJU4XqFI4w6bsfK2+iCO+NniuHrdJ
         fD8hLSOw0K3fYy8ccokUX7J0XWYiASsjDQm6Q2hh5UCKqhsefXkKr6g+6CO3/R0mofj3
         l2/H2Cs75lvJqFE+dXdquSzxrbIW1Qn7K9okj+tfvBO/uVY8QdjJLVvs3KyJqzjSS8iO
         rg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nef46n+0WiAiPTBLsF8EixaVYmTgFHXQPrMltQQQvcc=;
        b=dkBbpAdBPglGirUVsGz5OQE96gBmfmOmxvFcgzpDecU1S/I0jjDtoPAqJ8n9uCqmGg
         Z5B85UFrCsPdrxoRfMjd6oEYkeTcxVwTg+/YGmMFEXqkKkILkWlTeY1x0OpQV0LREf8W
         usrGGSBSuFHYqboefAge5tGEsWvwiFkT3Mc+uPUS+ZQbpBdztOIZkC/s8T75/kkbUnh1
         w7GPm8aIEGEzQlu56j4qrmj53RmeGkkWGaRo9cMYRTYkl+0+GfC909TCkdOAV0suke00
         0jJ0IitFNq4jGSj+xwPgw2/r7cwBzuXSXlYQIzjjPv7Q3NxmkfkzrUMWGTBa5YAHIDj8
         nVig==
X-Gm-Message-State: AOAM533WUBChmVHV9/Jnp/zcjkPe/AByibKe839/W3mdoNNLPumlztvF
        nCWu0SspqQFWALJSQQv2+bhRq6qTGTU=
X-Google-Smtp-Source: ABdhPJyCiWhvNoSkjckC0Z87Kpf+RSjHvDOrCA++0nJbz586ipJnqDuk2Iyijkn7FlbFS+hA54yKUg==
X-Received: by 2002:a0c:9029:0:b0:431:37ad:c8d2 with SMTP id o38-20020a0c9029000000b0043137adc8d2mr26009012qvo.71.1646356629977;
        Thu, 03 Mar 2022 17:17:09 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x23-20020a05620a14b700b00648eb7f4ce5sm1725895qkj.35.2022.03.03.17.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 17:17:09 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, heiko@sntech.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] clk/rockchip: Use of_device_get_match_data()
Date:   Fri,  4 Mar 2022 01:17:03 +0000
Message-Id: <20220304011703.2061466-1-chi.minghao@zte.com.cn>
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
 drivers/clk/rockchip/clk-rk3399.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 306910a3a0d3..b1b67bfb63b8 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1634,14 +1634,8 @@ static const struct of_device_id clk_rk3399_match_table[] = {
 static int __init clk_rk3399_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	const struct clk_rk3399_inits *init_data;
-
-	match = of_match_device(clk_rk3399_match_table, &pdev->dev);
-	if (!match || !match->data)
-		return -EINVAL;
-
-	init_data = match->data;
+	init_data = of_device_get_match_data(&pdev->dev);
 	if (init_data->inits)
 		init_data->inits(np);
 
-- 
2.25.1

