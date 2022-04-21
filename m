Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3A509AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386866AbiDUIuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386859AbiDUIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:50:03 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D0813F17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:47:13 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id d9so3204034qvm.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y5nc8nEZWjuBQmTaRa0LMr0t/dGnjEISw3ovW17pvKY=;
        b=ewWIfGejas1qU53cAWyN3JLVuSRhRhpDF5m6uTIoiCncukxiMdRrDXRfTOM3PsV/Nr
         XNlYhiyt3AnswvJskg0hh/XqvYg2KeN5ZbuQXg9vzJVIw5R6mjTFyeAYz8KnbLRV/y3W
         ngs5Hl5k0Nir3Jyi04BGLLjIYSqId7jOY3+QyJE8swa/H6pmX5ru3n/Gpn9y9OsMIn+j
         g0MZrdgPvbYmilSKXQhe+5zwgT9gvL+ntD4JWpxmqcNuzS05Z9UxIRq9FhRK4Zq2kxL/
         h55+3hHldL0NY5ua9PGGY85jqKSVHBZPQKOEuvTBO0xqFZXigUCJmTwJ0p1F5U8GLONc
         eIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y5nc8nEZWjuBQmTaRa0LMr0t/dGnjEISw3ovW17pvKY=;
        b=vFTSdAi7CO98nqKQJVr80OUYGsLsTdEzYpbYh8tL5UuLpYr4+Uu1Itr03hVcUAd5Rg
         p3OiK25l54wJ95bULApG4dheduep3E2EoWqbvsN0GHibyvUvUzt0hCEnyjyH/UdldnSR
         VnKMefhYNdXmarJqytPiBUfMie4XczJkL3vCl2hxMPbqxOhDmsYzRCqcExKb/06flJyR
         14YldPe2rEPI1OXXUCG7h2DNzALMHI4Xw15f1YAe14gkyXDGKh4+YnuVx0yx8R5BM0jo
         qdR6myUHj+ydwPnuf4rKixAaDla1nEZXeaOaqKfbUqqkWqSbPtn3EXfdvXDl943YSvgT
         8YqQ==
X-Gm-Message-State: AOAM532rPvts3vO9ysCI7B6oLlswlV+SUiZ6zDm42E53bc+VjzmwwQkj
        E+I1o1GUz5GjQSQWQloAaD8=
X-Google-Smtp-Source: ABdhPJziNI68RSJ40w4UaVeVAWvv7CxloEJNZHggZC/k1TmmyWaENGynAluXJSiPcZDRQD8N7DNrJA==
X-Received: by 2002:a05:6214:21a7:b0:441:1434:eafd with SMTP id t7-20020a05621421a700b004411434eafdmr18267353qvc.77.1650530832232;
        Thu, 21 Apr 2022 01:47:12 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 135-20020a37078d000000b0069ea3c7513bsm2724793qkh.121.2022.04.21.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:47:11 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     khalasa@piap.pl
Cc:     linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] soc: ixp4xx: qmgr: Make use of the helper function devm_platform_ioremap_resource()
Date:   Thu, 21 Apr 2022 08:47:06 +0000
Message-Id: <20220421084706.2615657-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap_resource() separately.Make the
code simpler without functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/soc/ixp4xx/ixp4xx-qmgr.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 9154c7029b05..72b5a10e3104 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -377,13 +377,9 @@ static int ixp4xx_qmgr_probe(struct platform_device *pdev)
 	int i, err;
 	irq_handler_t handler1, handler2;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int irq1, irq2;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-	qmgr_regs = devm_ioremap_resource(dev, res);
+	qmgr_regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(qmgr_regs))
 		return PTR_ERR(qmgr_regs);
 
-- 
2.25.1


