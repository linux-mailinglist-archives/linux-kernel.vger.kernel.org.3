Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121F5539F18
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350562AbiFAIMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350622AbiFAIMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:12:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94D8C3F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:12:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b135so1256898pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDHLNk2lC1y820Hnctg510Z3pMFH42mdXU5O+qRYKas=;
        b=arrmauLcCxQndylaqkIA9fZ0VPxT810s39+vQWP3F3WnNMGOPYnIZ3hBSdBdD3B4Ej
         s4prptJWPl5/vqxaSc/fUl7y70PfQACoZzJj61xE4n30EZTA4BV4Bi6r8rZ/YZOu10m5
         IEZQNt7MGu79BotcQeQ/3OQzBG4QJ8dSxtfWeYoOJErGMKP2lkkn/N/yB8RJtvRUYDZ5
         G181GMNlHoon+ht/Fm5HLrPRYysHkMFSa+cVNFwoaiNsnh4ZXRZhEBAyIpvUf4L4w7YP
         A2EWDdpUHRMH0407FM/jMRqzvQ6HA4EzsmKSWiTwENCwBvriwJau1SMYxSfaign62Kae
         LL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDHLNk2lC1y820Hnctg510Z3pMFH42mdXU5O+qRYKas=;
        b=vpiqhlj27iysdm+OhWMEiRbDiPrcRgVB/bbbUnS98k78iLT3KMMNyfLK7A/V0p3BP4
         CjEX1i1Cng/++Mlr6mEeerE6r4v19YA+AeMkof93y4fCuZc3iKDxzVEyr++tbmF+FABC
         OdsiN/IiYaiKgefvMPWE9gw+3on8e4LDJaXwQJo1Ont+uLL1xcIDVXwMVaSi1xyKRm1w
         VA/VCCoMLsikgjYVgBzWfOaxLYW/zL+eoGZ6t1Iy5GtZGBoEJ8aifxPYzm9wlvY6cv/D
         8DQ28+O9p/RTz1Fq0favYe3pTDOEi48+u6pJvyz3roPWb2fZ/UgeCZakMKGyPIViZA83
         Tt+A==
X-Gm-Message-State: AOAM533WhRWK6XwiYQ5PMzJ6Y2d2SF94CrybTa3szbE4+ieoV9COXXrs
        0K9xp0xIYer/l3a8jV+KGBo=
X-Google-Smtp-Source: ABdhPJw4BidUZQTAmV3LJkHDKE7X1qt6fzaWbucahjUCngpbzdX11O/YdU3Uf72mxrMRfIb6Tt5WQA==
X-Received: by 2002:a63:69c5:0:b0:3fb:a606:819a with SMTP id e188-20020a6369c5000000b003fba606819amr22251860pgc.81.1654071126469;
        Wed, 01 Jun 2022 01:12:06 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y1-20020a17090ad0c100b001e2f3831102sm792288pjw.17.2022.06.01.01.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:12:05 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        John Crispin <john@phrozen.org>,
        Bert Vermeulen <bert@biot.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH 5/6] irqchip/gic-v3: Fix refcount leak in gic_populate_ppi_partitions
Date:   Wed,  1 Jun 2022 12:09:29 +0400
Message-Id: <20220601080930.31005-6-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601080930.31005-1-linmq006@gmail.com>
References: <20220601080930.31005-1-linmq006@gmail.com>
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

Fixes: e3825ba1af3a ("irqchip/gic-v3: Add support for partitioned PPIs")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/irqchip/irq-gic-v3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1d5b4755a27e..5c1cf907ee68 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1973,12 +1973,15 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 				continue;
 
 			cpu = of_cpu_node_to_id(cpu_node);
-			if (WARN_ON(cpu < 0))
+			if (WARN_ON(cpu < 0)) {
+				of_node_put(cpu_node);
 				continue;
+			}
 
 			pr_cont("%pOF[%d] ", cpu_node, cpu);
 
 			cpumask_set_cpu(cpu, &part->mask);
+			of_node_put(cpu_node);
 		}
 
 		pr_cont("}\n");
-- 
2.25.1

