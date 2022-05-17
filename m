Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5787F52A03E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345070AbiEQLSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345704AbiEQLRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:17:23 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E213F7B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:17:19 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id a191so16667193pge.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3He5zqQafCaqxIZZoOREzUNxsIzRMeOPPdePDkzSSxg=;
        b=qiKm1mbardgIojujIEXZig/+qJiCfV5w3aki/6jtJF49OSvbAvTeya8kkPRO3xQZXo
         SZfsaP2xwY3T+dbidEWwbVJjQTGHKqsR1Pn0ZsNBHdAiBYW107qT/z9cV6KyVaKCy/a2
         muO3OlKawuiRWJ7Iu2SuOk8wjw8fLi2M1XizS0MWZZT4J7HleJ4nlw3C6A3x5VX1TQeu
         RPPUKACz1ByBMGjQrMVgvKSHUpLc/POEtjr4WpHIt8Sk/AgS1AYACUGiDYs4Y5Al7pCk
         K8AMNJRjsnutWKKzmG3llFcMjxGwCLikuBDWFBcg6VEq92wHeLgi1ye77RVwC98uO8WJ
         Q8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3He5zqQafCaqxIZZoOREzUNxsIzRMeOPPdePDkzSSxg=;
        b=x08/6gd1yONvnEMP1kVGLEJyIE+fxMAo3J0L2fWjCwJxhC6DFY0acDGnlJMPrFWozR
         iDWSpooPvyBcXqU2VRtfOrtUCPhikwGke3SziDe9EMLCG1+xz5wUEzD2Fe/BpvLj4HGj
         I/iYkXPdGPmxJYhrbwjY80NIM2DfWQd/YkwGi+44fr4Cjo7yQrILmZT5nd/9jwmAdkRc
         7tGQRGBM8Sm4YZEA95NrDpv/UuGzKcQ7thR8W8GreEzty9N5PyobibxJ9rgAOpOKLVDe
         v6cp+lE0T4GftaUxRmqK+QPsXwt/oK9U4ISfiqn6UuBaCE3pc4+mS2hwg7qg5j2a6+bA
         siHQ==
X-Gm-Message-State: AOAM5307dRoYTM7vRwA3GD/H38yEO0NeLPLa3l4WjYoNOzh7xW8Asj+q
        +jh9IT9NodmlgkKG18GfGU4=
X-Google-Smtp-Source: ABdhPJxiX2+4JCzqJi4lQkLBZjwoKutGXIxRhWZ5Awu1vC+sL4AHnlsvrnw3OzuvWGorZf8YwuII4w==
X-Received: by 2002:aa7:9557:0:b0:50d:b868:4798 with SMTP id w23-20020aa79557000000b0050db8684798mr22212636pfq.84.1652786239205;
        Tue, 17 May 2022 04:17:19 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id n11-20020a170902f60b00b0015ec71f72d6sm8800503plg.253.2022.05.17.04.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 04:17:18 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] irqchip/apple-aic: Fix refcount leak in build_fiq_affinity
Date:   Tue, 17 May 2022 15:17:09 +0400
Message-Id: <20220517111710.37753-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_find_node_by_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: a5e8801202b3 ("irqchip/apple-aic: Parse FIQ affinities from device-tree")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/irqchip/irq-apple-aic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 12dd48727a15..478d0af16d9f 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -1035,6 +1035,7 @@ static void build_fiq_affinity(struct aic_irq_chip *ic, struct device_node *aff)
 			continue;
 
 		cpu = of_cpu_node_to_id(cpu_node);
+		of_node_put(cpu_node);
 		if (WARN_ON(cpu < 0))
 			continue;
 
-- 
2.25.1

