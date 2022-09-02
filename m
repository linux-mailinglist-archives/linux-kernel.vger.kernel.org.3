Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF51E5AB746
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbiIBRLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiIBRLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:11:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048C3E7243
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:11:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v16so3102605wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=DuTa3saognZzf1yEXBtMWHdD/K4d13DqN4oEB+KjK0E=;
        b=ihnBlXqBkFfnIS849/CkMDtR/8d9hjln5YIoMyz8vCmy1vYdUeVFYuyizmnHulg+3W
         0PUT/iwKWo58JsYTdAWffHQfSbO6Ny6a8paLY7Az4TCtJTFJSCTMsvCtE+GCvojikA6M
         OysTwEjSRUvhwZfEWwdqVHYRvwOPKbR6bEYEvpWIPMDCk3xa8BLdxL1VfMULp5gFts9B
         PUScEO+GSyc4hpQFcciwc7Kr1KQfHME5U2tuqoSO9A6AiwYvu0B0Rek7JyOxI5+oyxgn
         8N1vvDGLm11PGr9x8+YRsb4/Ejt9jlrO/GTjtx7D1+M+ExYswjQgu1RqOBl4tagm60dN
         v58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=DuTa3saognZzf1yEXBtMWHdD/K4d13DqN4oEB+KjK0E=;
        b=baJe4URX1iNzFWhhsLlwWRHsND+2XxbVIfAexMg31oYcng/a8Ne0doRmc2tlpBGFP/
         F0i1BE8t5DXwrGmx/WXqDm4ehZdwDJFOrYnqrP7XqTOGqYm6UMkQDViYwyGhvmHPcI2T
         LqEZ1nDNPwbl80A6W621LGPCtqPQMBS/MXCPUVEG3MWT0IwvL3KyNGF5aHY8cHdTuL50
         YIpBqVNp/x3QbzjHgZcKW9MvE5b+lMah8ApP6sMiCnP/49gMS3dwNh1X7y7Dtc1UQwOp
         esFyw3DI5PJQbr3O6KsbuWU61vj03bsFUCwvWQsnIDQyv55oPIx5BBV9yPYIobXXoPm2
         /tVg==
X-Gm-Message-State: ACgBeo2vv/d3JqEclKmcdVoDReVP/0xr1qvODIhqa8MM1xjeyD4HXtvL
        ngIWCLY8jkIhkrsj/hEMZI8iJA==
X-Google-Smtp-Source: AA6agR73+iSdTpIx7bgU9NEjn1+QjWWazigQwpl7fLbia/ZWg+GsIUOp3JFCgqLypKKVHx5IQ3i+2Q==
X-Received: by 2002:a05:6000:1ac9:b0:220:7f40:49e3 with SMTP id i9-20020a0560001ac900b002207f4049e3mr18048393wry.40.1662138667541;
        Fri, 02 Sep 2022 10:11:07 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id bt24-20020a056000081800b0022377df817fsm2066869wrb.58.2022.09.02.10.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 10:11:07 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zong.li@sifive.com
Cc:     Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes
Date:   Fri,  2 Sep 2022 18:11:05 +0100
Message-Id: <20220902171105.257436-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pr_fmt() macro to prefix all the output with "CCACHE:"
to avoid having to write it out each time, or make a large diff
when the next change comes along.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/soc/sifive/sifive_ccache.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 40d2ac7895a2..90d21a1a4aae 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -5,6 +5,9 @@
  * Copyright (C) 2018-2019 SiFive, Inc.
  *
  */
+
+#define pr_fmt(fmt) "CCACHE: " fmt
+
 #include <linux/debugfs.h>
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
@@ -80,13 +83,13 @@ static void ccache_config_read(void)
 
 	cfg = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
 
-	pr_info("CCACHE: %u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
+	pr_info("%u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
 		(cfg & 0xff), (cfg >> 8) & 0xff,
 		BIT_ULL((cfg >> 16) & 0xff),
 		BIT_ULL((cfg >> 24) & 0xff));
 
 	cfg = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
-	pr_info("CCACHE: Index of the largest way enabled: %d\n", cfg);
+	pr_info("Index of the largest way enabled: %d\n", cfg);
 }
 
 static const struct of_device_id sifive_ccache_ids[] = {
@@ -148,7 +151,7 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
 	if (irq == g_irq[DIR_CORR]) {
 		add_h = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_HIGH);
 		add_l = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_LOW);
-		pr_err("CCACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
+		pr_err("DirError @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DirError interrupt sig */
 		readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_CE,
@@ -157,7 +160,7 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
 	if (irq == g_irq[DATA_CORR]) {
 		add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_HIGH);
 		add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_LOW);
-		pr_err("CCACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
+		pr_err("DataError @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DataError interrupt sig */
 		readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_CE,
@@ -166,7 +169,7 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
 	if (irq == g_irq[DATA_UNCORR]) {
 		add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_HIGH);
 		add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_LOW);
-		pr_err("CCACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
+		pr_err("DataFail @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DataFail interrupt sig */
 		readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_UE,
@@ -200,7 +203,7 @@ static int __init sifive_ccache_init(void)
 		g_irq[i] = irq_of_parse_and_map(np, i);
 		rc = request_irq(g_irq[i], ccache_int_handler, 0, "ccache_ecc", NULL);
 		if (rc) {
-			pr_err("CCACHE: Could not request IRQ %d\n", g_irq[i]);
+			pr_err("Could not request IRQ %d\n", g_irq[i]);
 			return rc;
 		}
 	}
-- 
2.35.1

