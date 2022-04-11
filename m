Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C34FB93A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbiDKKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345196AbiDKKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:16:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B78715FD2;
        Mon, 11 Apr 2022 03:14:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so22273392wrg.3;
        Mon, 11 Apr 2022 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuNqfwwfmDk9L2CQQ3VU8TN8eMid01qpUgPNixDf+K8=;
        b=Iy3fSeXx0MN7XJCELrXJsvxmHJ0LhFizYONSxzzJbzQu0vWzYDIDJ3KYg8Wha+T7jD
         GHrs/9jDJfBqStMy27xn/39+pXYGiuuhDuUuDn1rOB7mr1qEQ3a+oohXspfyW1uVE1NR
         yRlMrqTKTrdkkFa0d8UcOa97rbRf4BGCTyKSu6LdCokWL/MtqOUNnZwfWf/AkUPeJfoJ
         mDGtUoar0/ibW4jYDPtTUm0UCobHFB3b/0raoAD/zrCFSuFOKfCCd7B0iP768q8+eZ/H
         HGX3fhBu1sXBJTuxnfT4LhMQvpCA6mTp65MAgxoE6rymeVqcrYhL30DUlg51NTp6538t
         trDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuNqfwwfmDk9L2CQQ3VU8TN8eMid01qpUgPNixDf+K8=;
        b=zVkU68GIyg0HZ9RpjweQTAk0aWyrwjdtqIIufqfxZTKpOI5R0gN4bvOISxJcyI9wDa
         buH9GXdKhtt5RkTB1jKrT+Ijg4oN1Qucu9KqUEv5orDVXuwuBGqTP3OJ3L6d0xT7+2T8
         n8ufQch2zX+fxN3qcZ8+p8TVZy6+DVJf1QiNe+vm6fN1USX2y5Zo+MQD5fF28as3Isgl
         6qUIwwh2u7LtdBIg3SoA8DaCLt/xXHV15cFNpw+P1PGByajfUdb/48Jr2sve2csuLgw4
         xH0O8/0vmmlwe7xjG5p9GYKwDNMYNx6F41pgoDYvEwqO2X4+jOD0znrMpqdwh9rpJ15e
         a7oA==
X-Gm-Message-State: AOAM530yoOlduwzpWbKOZEoxroPhtCnSVuLx+P2zDnDuTBLgnr9eDTUl
        uz4m57VF4iLXUAk/rTOIT+Q=
X-Google-Smtp-Source: ABdhPJxcxPlV2yHZJgEQYvsTeDWo0pgjofleztmJhQXrzkwsT4bJIbpttARF0YD14oq+ZdymHnsp5w==
X-Received: by 2002:a5d:48cc:0:b0:206:d17:10aa with SMTP id p12-20020a5d48cc000000b002060d1710aamr24464232wrs.460.1649672063197;
        Mon, 11 Apr 2022 03:14:23 -0700 (PDT)
Received: from localhost (92.40.202.18.threembb.co.uk. [92.40.202.18])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0038ceb0b21b4sm20526369wmq.24.2022.04.11.03.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:14:22 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, paulburton@kernel.org,
        tsbogend@alpha.franken.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [RESEND PATCH 3/3] mips: ingenic: Do not manually reference the CPU clock
Date:   Mon, 11 Apr 2022 11:14:41 +0100
Message-Id: <20220411101441.17020-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220411101441.17020-1-aidanmacdonald.0x0@gmail.com>
References: <20220411101441.17020-1-aidanmacdonald.0x0@gmail.com>
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
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
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
2.35.1

