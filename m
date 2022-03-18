Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6152C4DD22E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiCRBBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiCRBBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:01:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A9B2571BC;
        Thu, 17 Mar 2022 18:00:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w8so5826120pll.10;
        Thu, 17 Mar 2022 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/J9CokFaMWfDdDSCmsPm7z7x/bhc1KUNd91iLyx4us=;
        b=h7nPdjpO1hEjwiQzFnGxhI/CSN/AX6VC2zBItKnJbVQIxfWIw/8xhOwz+kybAPq2M8
         rO0ri8t+zNDHG4g5+Ek6uHlWy5JT7xdTh9fDUZrlK5Y+JYZLsdv3WevQTP7eNN3PnQKh
         uUhyV0ON3/2DjpcCovD+ot07LfBmVsul2zqIBYBlyhAFzR98vTM8xP+nI9TPJkusbkMu
         GHuK5FaNRxhhxrhKbva4qkDVeGs5/YDUVDx9diWCr4Z0RHXTULExEsh+CGUO3FbnWY2M
         Ii8e5fimlLCYR4L5SuaJyniuTj1cUMZzGTfVnvq5eyVK741kZROgxkxto9CUVJ/scbUG
         YiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/J9CokFaMWfDdDSCmsPm7z7x/bhc1KUNd91iLyx4us=;
        b=10qhhUOXwvxl8Ft74TuYHgMvWAjeRLeOQ2hx0nCOFWEog2LrTTMFJSr2B+82QQJ+7C
         CKD9x0akpn5KNr6BWcohw41rZ8rmqlrDkVwKg6/1IdniZgNO3YRcrEMSh4cCkKsWHa40
         YboAPwE2G68tktZ5tfUmoJ+9iTXaQuhuTNstVozaMfXJq2q5cTADrartjyrVr91UcfWA
         B2gCwE2NoD5EvLR8Gqt0yuqthHOFIsC0iaurcw9BYe8MDEJuz89J9NuMBBSnxXtjg0o4
         Q3DCrllTeSgOA0swdrh+l3IdiD7bHMzMgs2xu3Qb7WpDsaz3K7sHivhWjlDZyDqX6NGo
         1/Sg==
X-Gm-Message-State: AOAM533Vlp5SVMXEe1UILJyzSMd5/+fpPjcubxYOItrvtPRb66uDIcYL
        eAThYY4BiQiJY4BDbDsyBNA=
X-Google-Smtp-Source: ABdhPJzTs2LArTNlI52yXaaAH03JCqT60+Ya2opm1KFlq9+sRudQkliigmD0YQH4yEx3U09IH8jQ0Q==
X-Received: by 2002:a17:90b:1647:b0:1c3:b18c:793f with SMTP id il7-20020a17090b164700b001c3b18c793fmr18978533pjb.134.1647565223519;
        Thu, 17 Mar 2022 18:00:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y21-20020a056a00191500b004f78813b2d6sm8399768pfi.178.2022.03.17.18.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:00:23 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     brking@us.ibm.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: ipr: Remove useless DMA-32 fallback configuration
Date:   Fri, 18 Mar 2022 01:00:18 +0000
Message-Id: <20220318010018.2142089-1-chi.minghao@zte.com.cn>
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

As stated in [1], dma_set_mask() with a 64-bit mask never fails if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/scsi/ipr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 104bee9b3a9d..dd8b32b00c9b 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -10261,11 +10261,8 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
 
 	if (ioa_cfg->sis64) {
 		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-		if (rc < 0) {
+		if (rc < 0)
 			dev_dbg(&pdev->dev, "Failed to set 64 bit DMA mask\n");
-			rc = dma_set_mask_and_coherent(&pdev->dev,
-						       DMA_BIT_MASK(32));
-		}
 	} else
 		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 
-- 
2.25.1

