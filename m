Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C08F539904
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346312AbiEaVvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348142AbiEaVvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:51:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729868D69D;
        Tue, 31 May 2022 14:51:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b135so111398pfb.12;
        Tue, 31 May 2022 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B9FwC67kdV1Qhd0VfAGvYEKiy1HjaP02OHwCopLdlrk=;
        b=UXkot/AAjsbfd2YxXonkpfjWoJWPHa9e2I3jq/G3iGrnZnG4gcDZrF9eCcyJrwi+Ad
         P8P60say7nteVz4Lu0KbuwtEHmo/B1bGiu2/yNBW+hwKK1Mrf0sth2PeBJDlfPO4hcEk
         kwWqmV2l+RPk30kJc1tI1HefHk1Mb3QPCw4ZkaEqZQ0pBbp6kDtkgDEAt+bcMv9did6b
         uVAYVi3DY1mzl4BNAJHqqvx2ZSRGRyBwQ31eiX3yxaNWrJkcZxYfhwILXw4gl+7zF8PF
         8Ml5qqbrxWltikDVQHCPf/+dNc6Zvb9PFJvKLQK4sI7alUJ7boSKgJHxzl2SdzIhRH5V
         HswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B9FwC67kdV1Qhd0VfAGvYEKiy1HjaP02OHwCopLdlrk=;
        b=VFW5XDgka3dnHtq1uZ7AHPCga4RXE82N/iOC4DngfJreMV5udvLcq0w5sL+VnNeR9L
         2maV2belpllKrJcpzOMCewTiuPVisVWNMTwfbap5rRWUyZYvx/r8hFc8Xetuj+/WTj25
         tADFJ3OSQhnClH5XN9XgVsmbeL6Q0GUdKLLlrbo24bn1ZQvk6Nkzs5Unkv9ZVgoRK2+l
         yUO3Ra63ZBdS10mor2lFWx7In+/zhARfcx/0WCbKXORYvshckUG1MKEQTsWQ+rmij5kW
         HStNYunmCijm2m+N6t+xMOpincopVLdasMEHHTvkyoSUJj55S1RpU42krCkTzGJRctVc
         qRWA==
X-Gm-Message-State: AOAM5338MBW68waRvlE9ytoXYl5vI+kx/6v2F3BLS6dJtZOATANCiQiS
        UnObFACVzV26JddXl5odSBwbNOLGdJs=
X-Google-Smtp-Source: ABdhPJyuMvsm/NRmorMJqRxBRNiHArx79tqFW/gO7U6IBR7sfrrK6kJgo4/ofqYcX4K4Iuzd3he0Lg==
X-Received: by 2002:a62:d45e:0:b0:51b:4d60:cda4 with SMTP id u30-20020a62d45e000000b0051b4d60cda4mr11758399pfl.17.1654033869377;
        Tue, 31 May 2022 14:51:09 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b001640a74624dsm36981plk.24.2022.05.31.14.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 14:51:08 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org (open list:DMA MAPPING HELPERS)
Subject: [PATCH] dma-debug: Make things less spammy under memory pressure
Date:   Tue, 31 May 2022 14:51:06 -0700
Message-Id: <20220531215106.192271-1-robdclark@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

Ratelimit the error msg to avoid flooding the console.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index f8ff598596b8..683966f0247b 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -564,7 +564,7 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 
 	rc = active_cacheline_insert(entry);
 	if (rc == -ENOMEM) {
-		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
+		pr_err_ratelimited("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
 	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		err_printk(entry->dev, entry,
-- 
2.36.1

