Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455ED539F14
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243130AbiFAILi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348233AbiFAILd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:11:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AFD64D01
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:11:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q18so1059378pln.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Px54YeB8y4JCFlFNgwFGWbi1FoMMkCqF3KundDZ3EiM=;
        b=M8QTLybUaNBk1aN+aW6WTC6oMiD4gHTGH1IngOQcZXfUt6/9wkK5VwiDq6/TgBjLAi
         VVsj1zx/ZRNW6HwMWapL1em5dRTDFO1BdGM4XJEzdGl465emrnSipiJlkXL99sIWN7qI
         9CSmCdLCdbtaS5kOdWFVaX+dXjXQFG3VInPenaz9FVnGInt6sogEJ3OUq9UKXKTUi8Tg
         y3iCO9U3saux5xWEPNNxjZUTr3CRhtjY9lza1ynF5mNDhIArJKqHuSDLhxPIyjv8C8Q+
         tVZdl1wi9BZZSp8Cv+flw3+ENseAF/nVTGBzMznepyaQD+/Awxu8IeXC1MK+Dka/qAib
         EvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Px54YeB8y4JCFlFNgwFGWbi1FoMMkCqF3KundDZ3EiM=;
        b=chhySVU9aN9lh2pg5/XUh1fOObXjftr6vrOvmOcwUI1o9/LBiDtiWSrAslFZFN1WAJ
         1pBWJ17lcsD7V3B+O+ST+mgpYsZpNroUkTOJ9WuRSfa21qpaPHwWdob0MoFE2KnuQS4M
         A7NkXvukIMY+P7VBedAZH+9lwVompiab0Jz4eJwAsR0JlRylFn2axzKrnMKFn4AIGUm0
         GPU3blc1/sec8hIVjXHRFB9JiLmhVoPm33c3Y9KOiJuoKGK1QR/rt2B76TGz2fN/Wi2Q
         mdjV33mF/u5gND3VLglcyBiM++qcXdQQTV0GIyu1h8jZOeNuAE52kl1tRETUaUp9C3Ym
         eYcw==
X-Gm-Message-State: AOAM530+g7m54Iphmkbx5uf6ZQg1hHQwxCpqjlJ/TS7/iGfh0zs9Xt/O
        /Lc6rKSDwzhlb56omOE9rVs=
X-Google-Smtp-Source: ABdhPJzG3vlU3jO48Ym1PPOrpdAe+gZj7tJD29o/oekC+E8060IQUrfmuoDVjXjxS3qI7mfLWO385Q==
X-Received: by 2002:a17:902:690b:b0:159:65c:9044 with SMTP id j11-20020a170902690b00b00159065c9044mr66244014plk.47.1654071090228;
        Wed, 01 Jun 2022 01:11:30 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y1-20020a17090ad0c100b001e2f3831102sm792288pjw.17.2022.06.01.01.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:11:29 -0700 (PDT)
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
Subject: [PATCH 1/6] irqchip/gic/realview: Fix refcount leak in realview_gic_of_init
Date:   Wed,  1 Jun 2022 12:09:25 +0400
Message-Id: <20220601080930.31005-2-linmq006@gmail.com>
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

of_find_matching_node_and_match() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 82b0a434b436 ("irqchip/gic/realview: Support more RealView DCC variants")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/irqchip/irq-gic-realview.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-gic-realview.c b/drivers/irqchip/irq-gic-realview.c
index b4c1924f0255..38fab02ffe9d 100644
--- a/drivers/irqchip/irq-gic-realview.c
+++ b/drivers/irqchip/irq-gic-realview.c
@@ -57,6 +57,7 @@ realview_gic_of_init(struct device_node *node, struct device_node *parent)
 
 	/* The PB11MPCore GIC needs to be configured in the syscon */
 	map = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (!IS_ERR(map)) {
 		/* new irq mode with no DCC */
 		regmap_write(map, REALVIEW_SYS_LOCK_OFFSET,
-- 
2.25.1

