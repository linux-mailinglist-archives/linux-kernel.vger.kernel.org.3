Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B714FC128
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348138AbiDKPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbiDKPoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:44:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731073A72E;
        Mon, 11 Apr 2022 08:42:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h16so10193504wmd.0;
        Mon, 11 Apr 2022 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jI0EvweldafVkAuij5gIPkwDPKF6ejG+3VYtG6fV4jM=;
        b=Nha6ydSRr6MR/73lGSpupUHjXzCe3Fl3LB7kdB+sNlq3S4H8bmdszRSEfrx6CPJz7R
         WdQKiRB5H1DSFeMnD4jqhtU6It57/068wHn5Rga3MvcRhAUxEbVef/36FaNbcvFJW8nI
         YFm9j6lP0JvrwpLp7u7jDYzo2OViXG5j0UjDqwkOEguu3KKugdkWRdQN07zNw0nFd3Xj
         pPz5nshd0/ejP8rS8m8IDbSFNgCXjVnfv9BgpdpZZ2CMAkiWtP7AUzjZKcMyPlUWE44h
         TuOFgJ8jN9XR0RmhjW5z8v4M5HTXEu9ZFHOzUaVRBqDxZ5nV7xs+4e6/ZRE78okYv1Y3
         MXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jI0EvweldafVkAuij5gIPkwDPKF6ejG+3VYtG6fV4jM=;
        b=3IoJKN5aiOA8n06/A4zTwGIKnV8cT+R4cDruVMfDnl8zQooCSBFxWgdmLwMQfLK6rA
         s2rKO62Fojlj6T+64AAMmvFJ8frFS+JJ8ghCcj2Rk5gKkew3V58u4lkrWkWddsaK3qh0
         qh43zFUNbffAxGmDttILYpCnmpXx8mRUg6NlVHaeWU2mdpDGTnEQ3B2nM05E6rKr0bEp
         YYrlLOZ3TH0ZJFDtpMXngYOJjqUFuamnpfGCGjpG122DFlJWcNYKGGUQw/qZZZ6IOpFH
         U/gzISuC1L3cREigdNIfAcQ9nKSVwBMdKqpczvlL2mPYoJloww22nfE9PPo8P32LTUtq
         pZIA==
X-Gm-Message-State: AOAM530VuzEJerZvXZUpPwPHfWfFmkd4+ne2QHumu42VupWYjIP7Ij2J
        yvIgMuGyxIg51OQPZ5YmWwI=
X-Google-Smtp-Source: ABdhPJwgX5v91HwXKxnlwkfVA4+hq3nT8jeTDRqqV9FlZMjxQr5i9sNajG30P3xPlwy2nWnHD9BYvw==
X-Received: by 2002:a05:600c:3487:b0:38c:9a42:4d49 with SMTP id a7-20020a05600c348700b0038c9a424d49mr30267607wmq.29.1649691724026;
        Mon, 11 Apr 2022 08:42:04 -0700 (PDT)
Received: from localhost (92.40.202.92.threembb.co.uk. [92.40.202.92])
        by smtp.gmail.com with ESMTPSA id f15-20020a0560001a8f00b002078f74ccd2sm12314323wry.36.2022.04.11.08.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:42:03 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, krzk+dt@kernel.org,
        tsbogend@alpha.franken.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 2/2] clk: ingenic-tcu: Fix missing TCU clock for X1000 SoCs
Date:   Mon, 11 Apr 2022 16:42:41 +0100
Message-Id: <20220411154241.50834-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220411154241.50834-1-aidanmacdonald.0x0@gmail.com>
References: <20220411154241.50834-1-aidanmacdonald.0x0@gmail.com>
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
 drivers/clk/ingenic/tcu.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index 77acfbeb4830..ce8c768db997 100644
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
@@ -354,15 +356,27 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 	if (tcu->soc_info->has_tcu_clk) {
 		tcu->clk = of_clk_get_by_name(np, "tcu");
 		if (IS_ERR(tcu->clk)) {
-			ret = PTR_ERR(tcu->clk);
-			pr_crit("Cannot get TCU clock\n");
-			goto err_free_tcu;
-		}
-
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
+			if (tcu->soc_info->allow_missing_tcu_clk &&
+			    PTR_ERR(tcu->clk) == -EINVAL) {
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
 
@@ -432,10 +446,10 @@ static int __init ingenic_tcu_probe(struct device_node *np)
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

