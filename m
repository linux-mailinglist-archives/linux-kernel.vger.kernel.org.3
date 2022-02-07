Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86A44AC51E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379109AbiBGQOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbiBGQJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:09:28 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BB8C0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:09:28 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id ay7so3548398oib.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 08:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mAu8pWBtSchKstM5A3tZ7ZHtLl/tvNz8Fm6ONHkwe4s=;
        b=RepKa8SkJ2TUQ+K6b0KJbqwAyCDaePxYPDwzGUi5nkwciUGr7ZHZwqZSinG1w3s0kL
         sLiR9veBA3jd0qenLNT+DSxpEaG+a3C9xFLEiyEiVZFN6iw9sX9cQcB+Ci8/2ZvfLe/K
         ZpsYBGA9k1vB/B0xqULtFLKF05ylVJt9j6+PdearCLo4dpboS53DnpP4NAfjOHyaeAdg
         CsAuUYoWSbqSLQSewLJlxguOw26cO50JBNKZa4+jzPKxPtC8/W5/hDhTWwufqFEq4LjR
         IS76TyW8Dkw+glmy8zymXFRYwbAlkmo6nlpgDGYH9tCbJm3Mpi7EYoQ9kCXDWBTaiXgf
         I6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mAu8pWBtSchKstM5A3tZ7ZHtLl/tvNz8Fm6ONHkwe4s=;
        b=Qmu0ZS8s73t6AC599HlyTWREEhDecYDG6qHeZ2CWQUsHIWZtDIkk9FeZKc+0F9ZzlA
         AQVMMXTBCJminYP5z6lW3OOot7t7Oy6JKTv8dLo1nsbzktnqdJR+u/bn8kukBSwNE+HX
         v+KM0wKnsoLQ66GFibZYwTt5SHUGk4CFikd9LEH5yOp7E3xXe22JKR1RhvEmSIQPfhRc
         03MolIxKywB7heTY4GOi67qx5kgyJV14iPh5e8v+EtYq+pvXVLvIvV+CIYeRS2XBZaYx
         hZbkcumWhVH4HvQ/feglQlTTanM5qkssFgArvyFg0peEWzBOtNgtrjSuQ52dtZxA51cm
         xx7A==
X-Gm-Message-State: AOAM531YMdROiXn+i0f/60ViOrzSqHLhWSxbMyDzdCiA6x8t6pi2GPjW
        ekaRO6XPzBkJccX5fQ/7ysc=
X-Google-Smtp-Source: ABdhPJw70VbtPo9y5hLiH62QDpTkOmxvHJ7SHRLlMlw8o8xatBkWtLmjbLHOaoeqGjSilgv5GKiwlw==
X-Received: by 2002:a05:6808:1647:: with SMTP id az7mr7522062oib.335.1644250167222;
        Mon, 07 Feb 2022 08:09:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 31sm4089019otr.13.2022.02.07.08.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 08:09:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Mark Brown <broonie@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v2] ASoC: Revert "ASoC: mediatek: Check for error clk pointer"
Date:   Mon,  7 Feb 2022 08:09:23 -0800
Message-Id: <20220207160923.3911501-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9de2b9286a6d ("ASoC: mediatek: Check for error clk
pointer").

With this patch in the tree, Chromebooks running the affected hardware
no longer boot. Bisect points to this patch, and reverting it fixes
the problem.

An analysis of the code with this patch applied shows:

        ret = init_clks(pdev, clk);
        if (ret)
                return ERR_PTR(ret);
...
                for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
                        struct clk *c = clk[data->clk_id[j]];

                        if (IS_ERR(c)) {
                                dev_err(&pdev->dev, "%s: clk unavailable\n",
                                        data->name);
                                return ERR_CAST(c);
                        }

                        scpd->clk[j] = c;
                }

Not all clocks in the clk_names array have to be present. Only the clocks
in the data->clk_id array are actually needed. The code already checks if
the required clocks are available and bails out if not. The assumption that
all clocks have to be present is wrong, and commit 9de2b9286a6d ("ASoC:
mediatek: Check for error clk pointer") needs to be reverted.

Cc: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc: Mark Brown <broonie@kernel.org>
Cc: James Liao <jamesjj.liao@mediatek.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Reported-by: Frank Wunderlich <frank-w@public-files.de>
Reported-by: Daniel Golle <daniel@makrotopia.org>
Fixes: 9de2b9286a6d ("ASoC: mediatek: Check for error clk pointer")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Updated subject and description, trying to match expected subsystem
    style.
    Replaced two Cc: tags with Reported-by: to give proper credit.

 drivers/soc/mediatek/mtk-scpsys.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 670cc82d17dc..ca75b14931ec 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -411,17 +411,12 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	return ret;
 }
 
-static int init_clks(struct platform_device *pdev, struct clk **clk)
+static void init_clks(struct platform_device *pdev, struct clk **clk)
 {
 	int i;
 
-	for (i = CLK_NONE + 1; i < CLK_MAX; i++) {
+	for (i = CLK_NONE + 1; i < CLK_MAX; i++)
 		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
-		if (IS_ERR(clk[i]))
-			return PTR_ERR(clk[i]);
-	}
-
-	return 0;
 }
 
 static struct scp *init_scp(struct platform_device *pdev,
@@ -431,7 +426,7 @@ static struct scp *init_scp(struct platform_device *pdev,
 {
 	struct genpd_onecell_data *pd_data;
 	struct resource *res;
-	int i, j, ret;
+	int i, j;
 	struct scp *scp;
 	struct clk *clk[CLK_MAX];
 
@@ -486,9 +481,7 @@ static struct scp *init_scp(struct platform_device *pdev,
 
 	pd_data->num_domains = num;
 
-	ret = init_clks(pdev, clk);
-	if (ret)
-		return ERR_PTR(ret);
+	init_clks(pdev, clk);
 
 	for (i = 0; i < num; i++) {
 		struct scp_domain *scpd = &scp->domains[i];
-- 
2.35.1

