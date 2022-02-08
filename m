Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113F24ACDDB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbiBHBMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344296AbiBHBAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:00:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4129EC0612A4;
        Mon,  7 Feb 2022 17:00:44 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cn6so11266280edb.5;
        Mon, 07 Feb 2022 17:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vp7Ll7vGM/TdoTnXfC7intfGiHu5bP7tDpFt1yu3RWk=;
        b=No6dX3xfeYTITXPtzWFL2TKM3n3Cok1FtZbdXTlhERM5eSD0sQ727EHb69OQenl1bR
         sFndLrN9pisrOUKQGLG0HD8ROR/EO9mO9cT539EGjd3CRN80BhFL4vhCmdMVSTc69Z75
         7IlcRfzB9TroU+y7kITFO8zHYbB2UxFxw2RQ58HAtu+fZhXey5gDFug7iYlaIFzXeKlk
         rQCB/t0pBEW9cwe/9f/9QwBBmun7A664e2OGnvj1eIk6Jt5NyfoDxkJ8K85S/a7CNx3W
         s25t+c/lNvv7uI/SRKmYmyqpqcs8xrV9LxlYXeyELUHGZN8s9qExrszZZUL/k8ApX2aI
         t5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vp7Ll7vGM/TdoTnXfC7intfGiHu5bP7tDpFt1yu3RWk=;
        b=X84sVtCvJJfCw8msCa3L5oTIzVoAQ+Nxg8hI4HiVSLVv1itbZ+IyUEIvhBIao4FLh3
         53IBekgBrR3lDMtZA54rnn8F6dXz6wzzQlZZjPLb3oT2D5+Xg1XTD4wETQvvmpO6Wpy/
         328ihOJVyltI9vBC9V3LabsbYyJL3VXfWpNC1kHux3YCoODmr/II9Nq7sNzYHbsjvHYd
         1uFCKuJ5iX0Ou7XRRKrQ0AOzWUjBwIwTsE6+ZHchHoBi9WgjwynviD7c9gX+4tvb8jq0
         oVgm6q2v2Yxw/CpttSUr7lCSR5aX4N+BWnjcszcV5fsxqvThGZEoHgnnwHc1Fh+4l9Ty
         vvhQ==
X-Gm-Message-State: AOAM533On0wU9HUPkZJHjS30UKRClNIqvDmtBMoVHHEL+RJTZYHBvsUn
        xT1+aRhrnuJuB5mPbjpoVk4=
X-Google-Smtp-Source: ABdhPJyyRzdme+bKBqifH4sYk7rFX96OzSFzE0zKqXRDsMmUhlshdf+PjUMLAEkDcJsNuoyqh0GdJg==
X-Received: by 2002:aa7:c155:: with SMTP id r21mr2044416edp.327.1644282042912;
        Mon, 07 Feb 2022 17:00:42 -0800 (PST)
Received: from localhost (92.40.202.227.threembb.co.uk. [92.40.202.227])
        by smtp.gmail.com with ESMTPSA id p19sm4197644ejc.42.2022.02.07.17.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 17:00:42 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mips: ingenic: Do not manually reference the CPU clock
Date:   Tue,  8 Feb 2022 01:00:48 +0000
Message-Id: <20220208010048.211691-4-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208010048.211691-1-aidanmacdonald.0x0@gmail.com>
References: <20220208010048.211691-1-aidanmacdonald.0x0@gmail.com>
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

It isn't necessary to manually walk the device tree and enable
the CPU clock anymore. The CPU and other necessary clocks are
now flagged as critical in the clock driver, which accomplishes
the same thing in a more declarative fashion.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 arch/mips/generic/board-ingenic.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/mips/generic/board-ingenic.c b/arch/mips/generic/board-ingenic.c
index 3f44f14bdb33..c422bbc890ed 100644
--- a/arch/mips/generic/board-ingenic.c
+++ b/arch/mips/generic/board-ingenic.c
@@ -131,36 +131,10 @@ static const struct platform_suspend_ops ingenic_pm_ops __maybe_unused = {
 
 static int __init ingenic_pm_init(void)
 {
-	struct device_node *cpu_node;
-	struct clk *cpu0_clk;
-	int ret;
-
 	if (boot_cpu_type() == CPU_XBURST) {
 		if (IS_ENABLED(CONFIG_PM_SLEEP))
 			suspend_set_ops(&ingenic_pm_ops);
 		_machine_halt = ingenic_halt;
-
-		/*
-		 * Unconditionally enable the clock for the first CPU.
-		 * This makes sure that the PLL that feeds the CPU won't be
-		 * stopped while the kernel is running.
-		 */
-		cpu_node = of_get_cpu_node(0, NULL);
-		if (!cpu_node) {
-			pr_err("Unable to get CPU node\n");
-		} else {
-			cpu0_clk = of_clk_get(cpu_node, 0);
-			if (IS_ERR(cpu0_clk)) {
-				pr_err("Unable to get CPU0 clock\n");
-				return PTR_ERR(cpu0_clk);
-			}
-
-			ret = clk_prepare_enable(cpu0_clk);
-			if (ret) {
-				pr_err("Unable to enable CPU0 clock\n");
-				return ret;
-			}
-		}
 	}
 
 	return 0;
-- 
2.34.1

