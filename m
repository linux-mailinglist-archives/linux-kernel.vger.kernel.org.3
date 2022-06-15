Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D9B54C443
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbiFOJGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiFOJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:06:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026A83A739;
        Wed, 15 Jun 2022 02:06:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso1493358pjl.3;
        Wed, 15 Jun 2022 02:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CXhk1iX0j0cRqg2v0/nsYGsi9fNJeaTXvM2J8kFqgnw=;
        b=WO8UeaeHx+RhZcSEPzoaksikiXQ9T7WphV+R1vGRRs3nlkWoc5v4wulx/FNc8t3pP8
         XuTkj6FgHuPaVqR6MoGRmTHN4s/l+VvZoZlBT/Mz+48tkA3cQ4FmhGsaLTSlfakAu9Pt
         7nAI8YlZEFr6szqo8htQ9ckwMilAH4klEhKLCt414X1vDZgbSylJOEgHbvE75CCrpZuQ
         KnHhLNHyYf4tWFYIvtdU/IHuTz/DfACAAdBTUqZTHnG+36pEmTprmzjmoW6RCvab0keB
         R/Zndm5RoqphpRT9MLeykyYaW28D4AZIHqqxg6iv47N9UDo7qyBSBXMMO6hZi29RVqHy
         t9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CXhk1iX0j0cRqg2v0/nsYGsi9fNJeaTXvM2J8kFqgnw=;
        b=l+ExGAU0Q51pb51dP1mxqQyctfduPHEJ87h4jzwPwisEdASOvWAKlCO7NP/Bes50Xl
         vUOt8f7xgbgI0qnqKEIzI3TKY73WTWnTLedcLKrSxrphNuVgqjHXMnzGCze+eC/hZDfX
         axnXrUZ5OUnOVYoc6xczl/xvnXjtdywyM1c2oezNRFmzuFJJYHj8EzAPjLegyF19iEPq
         omSbXLbZJNfXUzzX8qtiNalitY1FAgeF1sFmSuaUZfr1lmPa/eN28jI6ColRq778Pvl3
         eewe9eXcQsxQhmaiHBiwfJcCaoTEGKlUtNvCoRjuwqzgnniu6BhPDAoFeIdcI8lS+2IJ
         B41g==
X-Gm-Message-State: AJIora9VVZtXFGgEWIRjHprpl7w4Nt78htWCoO1keueSzKAY6pU1rfMA
        7OX7LHueCz+YCSrTXf9DEdE=
X-Google-Smtp-Source: AGRyM1sU0k3W0fNgy4AXqClk96xssdjDtPCRN9ULmCaXODsIJrzLySWTaMsU/e4EIMNIu1dSxiNjVQ==
X-Received: by 2002:a17:902:f64c:b0:156:7ceb:b579 with SMTP id m12-20020a170902f64c00b001567cebb579mr8327611plg.73.1655284003404;
        Wed, 15 Jun 2022 02:06:43 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.111])
        by smtp.gmail.com with ESMTPSA id p10-20020a62b80a000000b0050dc76281aasm9227748pfe.132.2022.06.15.02.06.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jun 2022 02:06:42 -0700 (PDT)
From:   korantwork@gmail.com
To:     dave.hansen@linux.intel.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        trivial@kernel.org, Xinghui Li <korantli@tencent.com>
Subject: [PATCH] x86,iommu:cleanup misleading comment about SWIOTLB turned off by IOMMU
Date:   Wed, 15 Jun 2022 17:06:39 +0800
Message-Id: <20220615090639.34402-1-korantwork@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinghui Li <korantli@tencent.com>

According to commit 327d5b2fee91 ("iommu/vt-d: Allow 32bit devices to
uses DMA domain"), SWIOTLB could be enable even IOMMU exist.This comment
could mislead developer that there is an error enabling SWIOTLB when
they enable IOMMU.

Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 arch/x86/kernel/pci-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 30bbe4abb5d6..c0434abf7e09 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -193,7 +193,6 @@ static int __init pci_iommu_init(void)
 	x86_init.iommu.iommu_init();
 
 #ifdef CONFIG_SWIOTLB
-	/* An IOMMU turned us off. */
 	if (x86_swiotlb_enable) {
 		pr_info("PCI-DMA: Using software bounce buffering for IO (SWIOTLB)\n");
 		swiotlb_print_info();
-- 
2.25.1

