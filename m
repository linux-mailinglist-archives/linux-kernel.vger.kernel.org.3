Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6614BD370
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbiBUCBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:01:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiBUCBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:01:36 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9531517D3;
        Sun, 20 Feb 2022 18:01:14 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id x3so28177102qvd.8;
        Sun, 20 Feb 2022 18:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6UJ01aO6yqMFyXgXVkysCIqiLsld/b/1p7hzthZA8U=;
        b=FV9H/c+eRAbiraRlbbFVbiUpp+PdGevLPwWpXp5zDNgnKnVqO4+fED7zaFyE9HDmpN
         sH9fo9LkiNQvf+JSp7FIt0dXcZrM8SpUS6013DfVUatIToW0uNqgotay7nH5s+QmgHtf
         ZKJQl2sitkYGDNKctwH+fS3sNIx+DMsWOmYxst2OBZQGO2S/lpY89MHoOlMDIocPv4vz
         43t8PxlZR8lDUGouHja3QhGoAHmWXsI2nQOJ5GA4wvEFsLmqsiKV1A/rSCmsmh/i8v3G
         NUYVz3L7reQ+1IppHRMjhh7Rer6gPXkQsSj7HuZ4zvmJkOkb8gPYF43v98Aket1bna5L
         CgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6UJ01aO6yqMFyXgXVkysCIqiLsld/b/1p7hzthZA8U=;
        b=24qBptNL3RcZ9Q4yjJtMY2xB4SGjqK3Ip6KbZChUpXxTR0jopuwOwPpOzDn85MPCeq
         te8VuP95+2wkYZmZyQH3/kGCFCG7V1aAZ3N4pBGNZPBEAXZfq0/1crUcqsKo95ZXzU9r
         HLeF7nJoDiiW3LBokaka3niHAkQV+27gF4jGmDbb2pf03ZSv99lu9NhJuoQ70Ip+cRcf
         ocwwPFdIpLvwe6jUCtupgf874Slhy7XNlyGuYtW3QPTRlovirzniiKsgtPH5H5dIUK/X
         oDcPGm9PWNcxRT+RrmVUvBvcO6j+HErkKvsfmxaSlTszRzyJiBrZDUCCS+ZwTnpOd4v0
         A8Eg==
X-Gm-Message-State: AOAM533ri6EMx6Y5GEE8GvBEyvaPHHiqVKnF+y9HtpAaLRBDmGB3AIeE
        MhMwNa7ApjO/bhgbC4xphTY=
X-Google-Smtp-Source: ABdhPJyti2fe/0D7jey1jMV+CH6mSxJq2zIFxoITidmlU76ohHSP58kKVGfznBiNbihuemWWiby6Ww==
X-Received: by 2002:a05:6214:e6f:b0:431:46cd:dd9a with SMTP id jz15-20020a0562140e6f00b0043146cddd9amr6013348qvb.125.1645408874012;
        Sun, 20 Feb 2022 18:01:14 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n19sm19160708qtk.66.2022.02.20.18.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:01:13 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, heiko@sntech.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] clk/rockchip: Use of_device_get_match_data()
Date:   Mon, 21 Feb 2022 02:01:03 +0000
Message-Id: <20220221020103.1925026-1-chi.minghao@zte.com.cn>
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
 drivers/clk/rockchip/clk-rk3568.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
index 69a9e8069a48..9ca1a26a2533 100644
--- a/drivers/clk/rockchip/clk-rk3568.c
+++ b/drivers/clk/rockchip/clk-rk3568.c
@@ -1697,14 +1697,12 @@ static const struct of_device_id clk_rk3568_match_table[] = {
 static int __init clk_rk3568_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	const struct clk_rk3568_inits *init_data;
 
-	match = of_match_device(clk_rk3568_match_table, &pdev->dev);
-	if (!match || !match->data)
+	init_data = (struct clk_rk3568_inits *)of_device_get_match_data(&pdev->dev);
+	if (!init_data)
 		return -EINVAL;
 
-	init_data = match->data;
 	if (init_data->inits)
 		init_data->inits(np);
 
-- 
2.25.1

