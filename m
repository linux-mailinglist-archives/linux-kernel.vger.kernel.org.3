Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0F4FE158
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbiDLM4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355264AbiDLMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:53:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6991AD;
        Tue, 12 Apr 2022 05:27:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e8so11081103wra.7;
        Tue, 12 Apr 2022 05:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hqV3V+/OemrvfMyi+qYwBTg1CTLubJfYbcXo78XjwGQ=;
        b=RfRS2TxKI932USUqjn74NpDvmCwPkIAhDuxzpYxizk3HbVfZoY9Dc9fCrWaYFV/Hrf
         znKQNQX6T29mXY/xIK+0+dUnvo7HqpNGNnCLnl0rXwF4J7J10bho7+6k8loFaoWvxa4N
         6hrr3/dl3Op4M3+AoCb4dG4Qiwc16fuWxU41JQkiY9gyzjI3aPUfXlG6hyyPtAPxSBH5
         Kq+ZgMoX3s+zxoYv1wB2yIHm1SeRqMqGlkcu6l4bX0If1TxlTBITP26vAdYE0i1siXYN
         a8hKjeATjrgintK3u6NbnaxgoLopS2Q0BuftEUsLtWqDExYpRCcWXRf10aakUCTxdU3p
         oJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqV3V+/OemrvfMyi+qYwBTg1CTLubJfYbcXo78XjwGQ=;
        b=7LjLecFZIhLLwGUixkJ3TUzKj8TfAA7w4hLxTH+AjK7KtbJmab9LmNLOXiRptl7jnw
         8CYnl74CedNo3ogu0yvU6OHxUwXKbsGoJUViqk9b77R3u9FaAEgwKwata2wOxL7JXmWb
         3P+gN7No1JtiMbpnkHarOlvgNtEQeNdqhA6jm5fzykg9y49xx3lBC26W5DEmRKXjCTE8
         u2TOW0rknCC9h4QD24+JmiRh2+BjmPLg4Cj7uEU1lya3a6XwCJ+yfEeS+o29VPZ/U0rI
         vcXvJSQu47JlOOu5XhhFDEPr4Y8Wu24J/20jsFq6y/OAHYaI2d7/GTXNOW1M2EavGAL+
         fmbA==
X-Gm-Message-State: AOAM5313GBaw6oHWXiuPO6tr4PAw+MbqOncY/0vDHto/RoKVWn6Y6dWo
        yH9EQNtXyEJX7fde1eX3dFM=
X-Google-Smtp-Source: ABdhPJzyoIJEB/ACYgq/iZXBHyBSnbtnKirJW34N89Tg1eJ8h6upogcWoGImf8lZ3QoSzkrA6b1hKA==
X-Received: by 2002:a5d:6e84:0:b0:206:147b:1f59 with SMTP id k4-20020a5d6e84000000b00206147b1f59mr28646783wrz.86.1649766441581;
        Tue, 12 Apr 2022 05:27:21 -0700 (PDT)
Received: from localhost (92.40.203.131.threembb.co.uk. [92.40.203.131])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c4f8800b0038eb596ab10sm2296064wmq.2.2022.04.12.05.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 05:27:21 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, krzk+dt@kernel.org,
        tsbogend@alpha.franken.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH v5 2/2] clk: ingenic-tcu: Fix missing TCU clock for X1000 SoCs
Date:   Tue, 12 Apr 2022 13:27:50 +0100
Message-Id: <20220412122750.279058-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220412122750.279058-1-aidanmacdonald.0x0@gmail.com>
References: <20220412122750.279058-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCU clock gate on X1000 wasn't requested by the driver and could
be gated automatically later on in boot, which prevents timers from
running and breaks PWM.

Add a workaround to support old device trees that don't specify the
"tcu" clock gate. In this case the kernel will print a warning and
attempt to continue without the clock, which is wrong, but it could
work if "clk_ignore_unused" is in the kernel arguments.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/clk/ingenic/tcu.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index 77acfbeb4830..201bf6e6b6e0 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -31,6 +31,7 @@ struct ingenic_soc_info {
 	unsigned int num_channels;
 	bool has_ost;
 	bool has_tcu_clk;
+	bool allow_missing_tcu_clk;
 };
 
 struct ingenic_tcu_clk_info {
@@ -320,7 +321,8 @@ static const struct ingenic_soc_info jz4770_soc_info = {
 static const struct ingenic_soc_info x1000_soc_info = {
 	.num_channels = 8,
 	.has_ost = false, /* X1000 has OST, but it not belong TCU */
-	.has_tcu_clk = false,
+	.has_tcu_clk = true,
+	.allow_missing_tcu_clk = true,
 };
 
 static const struct of_device_id __maybe_unused ingenic_tcu_of_match[] __initconst = {
@@ -355,14 +357,27 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 		tcu->clk = of_clk_get_by_name(np, "tcu");
 		if (IS_ERR(tcu->clk)) {
 			ret = PTR_ERR(tcu->clk);
-			pr_crit("Cannot get TCU clock\n");
-			goto err_free_tcu;
-		}
 
-		ret = clk_prepare_enable(tcu->clk);
-		if (ret) {
-			pr_crit("Unable to enable TCU clock\n");
-			goto err_put_clk;
+			/*
+			 * Old device trees for some SoCs did not include the
+			 * TCU clock because this driver (incorrectly) didn't
+			 * use it. In this case we complain loudly and attempt
+			 * to continue without the clock, which might work if
+			 * booting with workarounds like "clk_ignore_unused".
+			 */
+			if (tcu->soc_info->allow_missing_tcu_clk && ret == -EINVAL) {
+				pr_warn("TCU clock missing from device tree, please update your device tree\n");
+				tcu->clk = NULL;
+			} else {
+				pr_crit("Cannot get TCU clock from device tree\n");
+				goto err_free_tcu;
+			}
+		} else {
+			ret = clk_prepare_enable(tcu->clk);
+			if (ret) {
+				pr_crit("Unable to enable TCU clock\n");
+				goto err_put_clk;
+			}
 		}
 	}
 
@@ -432,10 +447,10 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 			clk_hw_unregister(tcu->clocks->hws[i]);
 	kfree(tcu->clocks);
 err_clk_disable:
-	if (tcu->soc_info->has_tcu_clk)
+	if (tcu->clk)
 		clk_disable_unprepare(tcu->clk);
 err_put_clk:
-	if (tcu->soc_info->has_tcu_clk)
+	if (tcu->clk)
 		clk_put(tcu->clk);
 err_free_tcu:
 	kfree(tcu);
-- 
2.35.1

