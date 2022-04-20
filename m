Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB5507F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359161AbiDTDKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359138AbiDTDK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:10:28 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A6A6571
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:07:36 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id y129so376037qkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpmyg8XLS13nF/sVE65s2xiBisYTpjV5/f0AVee7Iss=;
        b=TAL2aCc91h+Ay7idog+nOlQuP8J6jP28XTdU1Y6wUy6VMnZoqEl54ET/e3GXf0xNi/
         15Ha0PlwVZtDaWDVIyaEGFBnNyueQU/dhknbMFUvtPau6P9z03NTa6yDXfMkyk5V0OiK
         drcgS8fUset703wRlXMEpyRGj6d4xp8hhQlpWH2yciub/lYl+ogS1nnw38IHkk7+KcMH
         ZczgNtLLy2JAhxX7sA6Em58ijKp626XjEJ9dD5S3C/8w/IrYbZ8rzkf6h65BpLx0IL/B
         RUdEeNxproDeP4HEdaAxvRf9wmdrv6N/MKQcrENdlZS7UmKC7+VliEbfXTU58oi54ACa
         JdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpmyg8XLS13nF/sVE65s2xiBisYTpjV5/f0AVee7Iss=;
        b=fPfM8FFKeL+H+FDkPH3qgv0+puTQ3g9nXJraiAKXLGjjkFqDXDzq9I0jILJXkuoY1e
         wgU2O0cCCnC3AwrxlWkUUl9JBY+097a4Ubv5q1ykDkQMSLGcfKrebRM/fkasSM7gE4BY
         f5hXpv6Gl+OnLCJD4lkxauJKwMv5cZi5gnXYQMroB6IzQzEKyjD+1R/zR/kzAuLCd7vZ
         91PJeq2RhiunaZgApSaVicz7WrgpMwdqfc1igFIJRBBOUlt9eA9Fq/IIx//vhcY9eEtq
         49q261Rdv252Jj0HK/BkP0NPwbDcpM7grE+Y0fc5OjT5KngqYl+xokcRZRxL+EsDUOnH
         ++og==
X-Gm-Message-State: AOAM531zQovsbsFZ+agzsI/ZL7OGItuRg0UsGX8mf4q0xjhcxk8lO+/z
        +GJ8qLrJ7/y8CBWNZQZ6R74=
X-Google-Smtp-Source: ABdhPJy4wHrCRkO6ny5AYzUzvmrLJxHazJY5R+UASEjdsR+b+H3QhIPr7QTeV+IrTguLc4w4HJjKcg==
X-Received: by 2002:a05:620a:30a:b0:69c:10ef:c87f with SMTP id s10-20020a05620a030a00b0069c10efc87fmr11279776qkm.634.1650424055254;
        Tue, 19 Apr 2022 20:07:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l130-20020a37a288000000b0069e8290f28asm914740qke.97.2022.04.19.20.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 20:07:34 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] iommu/omap: using pm_runtime_resume_and_get to simplify the code
Date:   Wed, 20 Apr 2022 03:07:29 +0000
Message-Id: <20220420030729.2576005-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/iommu/omap-iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 4aab631ef517..7cfa80ccd9a8 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -193,9 +193,7 @@ static int iommu_enable(struct omap_iommu *obj)
 {
 	int ret;
 
-	ret = pm_runtime_get_sync(obj->dev);
-	if (ret < 0)
-		pm_runtime_put_noidle(obj->dev);
+	ret = pm_runtime_resume_and_get(obj->dev);
 
 	return ret < 0 ? ret : 0;
 }
-- 
2.25.1


