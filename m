Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EAC513A38
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350321AbiD1Qru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350298AbiD1Qrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:47:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D34B2471;
        Thu, 28 Apr 2022 09:44:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so3350950wmn.1;
        Thu, 28 Apr 2022 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuNqfwwfmDk9L2CQQ3VU8TN8eMid01qpUgPNixDf+K8=;
        b=g3z4I7Fw5b659c5VtcJceBdug81emUa4YI1iovyAo23Luwq6y2GMYmVdoEV/5nesYM
         hXY178GXxuV6ablOJe91n81w60+Z0X2RYnsC8LTEIQaVzA65lVwQTuOFE5xVx0WCU63W
         /pMpAVpRAc2bGntkk9RkCP0se6LedH0wgFeWSxJG6wlyH8jLaegNCo95osveQo9YZQiv
         T4TwHdNoONiUlzYEwIOrpul2JAWU58zD085s7dmg5P8mmGn1wv+O/1O+gGmOlDUCp0Eq
         1MieGyt1kluVV8Ee6jtTXpPpU/pfpDTJsX4dkzQ8upfhmyFPw4brNEVZCEfI2RQg6SjG
         F5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuNqfwwfmDk9L2CQQ3VU8TN8eMid01qpUgPNixDf+K8=;
        b=rwefHhei2mPAnH5e2ISej8E/Huc0GvSjlcmry+uSgBuHJwMqPI6F3EvqLPcInltSOE
         /7yM0BpOS7gHQsZcDbMkI9Bca3x0hgf9n/n/Q+P8y7ZGLSjT4s276ta3YCqXbEl06c2k
         tbidG+U+MLRmmx2vcifeiflh8ivGXGYkfGOtsutqW1flFdETqTX/Pm6fOQOgwmO6/nx4
         UTpWRyyZ9QUS4vB8wHcOwnOGVqZU/9wlpJ0iOMjDziHhGoslLcDyXW1x4sIF2jIM3duY
         XF+ckaVi5aVEzrsDCCfauSC1KfoTVMON0GtqtnW9VU6r2fmSpv8ywWxKcyy+5+f/RJ94
         JUmw==
X-Gm-Message-State: AOAM533z34EWEtfsU3jxfA7FzNW3zaYKg+q/tPaLSVJ+lk2YqehGF4TV
        1xbvmeGREVxIclGVAOBAweg=
X-Google-Smtp-Source: ABdhPJw+7+C9AZ30tLDTZTu27v5j+y7iZiAb28HCV7CxuuLmfavVlYAq0TEgcX7hehr0Xt1+Pwj74w==
X-Received: by 2002:a05:600c:3b15:b0:393:eb14:bb5 with SMTP id m21-20020a05600c3b1500b00393eb140bb5mr21007048wms.129.1651164264321;
        Thu, 28 Apr 2022 09:44:24 -0700 (PDT)
Received: from localhost (92.40.203.206.threembb.co.uk. [92.40.203.206])
        by smtp.gmail.com with ESMTPSA id f189-20020a1c38c6000000b0038ff83b9792sm4453035wma.43.2022.04.28.09.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:44:23 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sboyd@kernel.org, mturquette@baylibre.com,
        tsbogend@alpha.franken.de
Cc:     paulburton@kernel.org, paul@crapouillou.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 3/3] mips: ingenic: Do not manually reference the CPU clock
Date:   Thu, 28 Apr 2022 17:44:54 +0100
Message-Id: <20220428164454.17908-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220428164454.17908-1-aidanmacdonald.0x0@gmail.com>
References: <20220428164454.17908-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

