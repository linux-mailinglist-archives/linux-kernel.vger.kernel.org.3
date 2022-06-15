Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231E054C2CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiFOHmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352263AbiFOHlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:41:53 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F3649CB7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:41:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g186so10675200pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJ9dbVQWS3muelD2che4m2RkFNGOIFlrl7yE1kJ0cFU=;
        b=FAT0EaCFsCTaNLOLBSejLQwRxm65I4tTblkI3UpdUWn8LkJheU8IAbeAn0cEdRFv5G
         HMHwwyWCK03/LG0EK4eQM3EwWRXexrnrJF5oR7Z2FH5XXlhgw5NhRQNAJXCYkVLEVZWG
         RKZ5n22b7d/tGYnTfUX7jKYrzcFznWrjpvjErE0BWVJor+v66JF4FLBXcF+Ic2BYXVYd
         YplyLSfrWGnNk9fC4ud0d7jrAsUG9pE41yw1PG8/yM7kwb/ofjT6ZSPer/WG4/xsmqoT
         hnsdfNQYKw9xopwkfLzim0SOOIsYyzn93dC14/ro8RYkNk7X7+EWP0aIVu97BB24EexL
         AKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJ9dbVQWS3muelD2che4m2RkFNGOIFlrl7yE1kJ0cFU=;
        b=gkZt33jnMo74zg5Xb/QEAmKyD0tBKUzq/3niVzFYDWINEML7NzgYQ3Fk/gmmVjBbcW
         D0XMioE3pGlr6W0PEJQlJy2Rx+R1E/oK/7VjdB+s/bXa6xbuhL7JywIIAOv+cTEnRJG+
         PSdTQWDiK808BE9jY9agI/vqhDv6ZZeV117+PfsBWLRfOWWHlZH0QTN4IhQ06jaUAgZG
         UkMe9xbr7VeA4cu/DSs7zwy9DGr14o3hiCTItjOWdH8KbzeRuZcnRFmmbwRHxHcgL+Yf
         pow2faAYSHC8QhoSTWIPeAvXIBuyTsAa2/LsVOB3cqk08ZDzdDTcZH00C2YhvgeXBDR6
         njXw==
X-Gm-Message-State: AOAM532PnmVFO/Ua06nb+lmp8aysGLtDeFY5LfWCTBArHe9xvblTJZxq
        G8VOA2vN4g6/Y1h53wxTUxhPrm3eXvI=
X-Google-Smtp-Source: ABdhPJwbTKseu/QIW7iTQ2w4314NirUemHlEitpOoFNS2Q1fWMlcyegVNTQB/TiFSFQAYqiWfzFOBQ==
X-Received: by 2002:a65:67da:0:b0:3fc:6ca7:d58c with SMTP id b26-20020a6567da000000b003fc6ca7d58cmr7913724pgs.562.1655278911579;
        Wed, 15 Jun 2022 00:41:51 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ik24-20020a170902ab1800b001664d88aab3sm8553342plb.240.2022.06.15.00.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 00:41:51 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     linux@armlinux.org.uk
Cc:     logang@deltatee.com, martin.oliveira@eideticom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ARM: dma-mapping: Use kvzalloc in __iommu_alloc_buffer
Date:   Wed, 15 Jun 2022 07:41:46 +0000
Message-Id: <20220615074146.912213-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kvzalloc() in __iommu_alloc_buffer() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 arch/arm/mm/dma-mapping.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 82ffac621854..940819eda182 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1208,10 +1208,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	int i = 0;
 	int order_idx = 0;
 
-	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, GFP_KERNEL);
-	else
-		pages = vzalloc(array_size);
+	pages = kvzalloc(array_size, GFP_KERNEL);
 	if (!pages)
 		return NULL;
 
-- 
2.25.1


