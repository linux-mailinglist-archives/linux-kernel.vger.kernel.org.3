Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3C44DD225
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiCRA7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiCRA7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:59:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1347D19C594;
        Thu, 17 Mar 2022 17:58:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s11so8180904pfu.13;
        Thu, 17 Mar 2022 17:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OjGU9QY9zP7JqWUA2HLfdO0yP2EkBCjSzBVQExa48+M=;
        b=mBkrn2+VFQ5GqR4/ZqQ+d4mESCBPTgl0y+1hkn8prKgW206jTpxpkPyCM6a0BTi3h+
         aXlXOby3u47XhQHQ6dV33GzYj1cIifrBT81FiOl2s9B+8xu+q8zO2bsVrno6Q3WfER6W
         2rob2ls8JJ+kbocrJ+bO+bXP131GyoW2th0ujjd11P4mWmuU1KjLYtIavgFHn/ZVzvQr
         to8TPvfw4GYxlBaTPYojv8xo/TVaf846rY5QNcqt14zN9REBh8r7slN2Q0YYK5ZLqKgo
         FDWwuuSoKcMmcEosC0JEVNKG2C/pzqaClTOfZopn3KAPEF3gBdQzNCMZXJLuMlWU+HOa
         XiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OjGU9QY9zP7JqWUA2HLfdO0yP2EkBCjSzBVQExa48+M=;
        b=MPbkzAriAyLUXJBcEDoo86r/7h19EkhbTI1knyuabJgTP9Da8zlywtic0Sut3O8hh6
         f4G+zbLwQYnFsNlJPlOjSAcKfo02AWrR7v1BX3j6w5T/dfRxtpq5ejfOXlBUDjJ7HPG0
         G7bNcGlY4Yc+vqlfMMtBD4z+nqKIMx9rNVOjx82ghA0Z27OKldecsKYmT1zKOabPX8cl
         4eIvQlgZoO6Mc8BeNKDJnLMcsWV28m+cRgPDD81tPkvVy3b//jIkVDlwIXwQ76rkjIxT
         Q6QCj4Od65zBi43boHhl/lm4vtekwOm+0uMIei37QkD1WRwET7LIRAIJFakGqocWke0N
         M3RQ==
X-Gm-Message-State: AOAM533ib4VVbKEEr5dCqoWL202v3FtiCn4n9iu2ZJjpO4SKCU4f0PPi
        lbtMbrhJ9o4P9KvaIa1/Dgc=
X-Google-Smtp-Source: ABdhPJxFxlJRWclENUosyKaF5XSJ9FNLT76IEUwe4TLTXMUNJChv2tL+q+e5mZojvCACwwK5zA5r9Q==
X-Received: by 2002:a63:c156:0:b0:37c:9955:ab24 with SMTP id p22-20020a63c156000000b0037c9955ab24mr5946676pgi.90.1647565102551;
        Thu, 17 Mar 2022 17:58:22 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h7-20020a056a001a4700b004f70b86fd28sm7788636pfv.134.2022.03.17.17.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:58:22 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     james.smart@broadcom.com
Cc:     dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: lpfc: Remove useless DMA-32 fallback configuration
Date:   Fri, 18 Mar 2022 00:58:17 +0000
Message-Id: <20220318005817.2141903-1-chi.minghao@zte.com.cn>
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

As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lkml.org/lkml/2021/6/7/398

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/scsi/lpfc/lpfc_init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index f5c363f663f6..e793c4183499 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -9187,8 +9187,6 @@ lpfc_sli_pci_mem_setup(struct lpfc_hba *phba)
 
 	/* Set the device DMA mask size */
 	error = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (error)
-		error = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (error)
 		return error;
 	error = -ENODEV;
@@ -11714,8 +11712,6 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 
 	/* Set the device DMA mask size */
 	error = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (error)
-		error = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (error)
 		return error;
 
-- 
2.25.1

