Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7317E4DBFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiCQHEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCQHEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:04:35 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19ADB9188;
        Thu, 17 Mar 2022 00:03:19 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id o23so1990103pgk.13;
        Thu, 17 Mar 2022 00:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QS+owt/6LPBcNmYdhUS3l3R2H/RaKUY+gUk7F26xgNs=;
        b=kBQwVHBpotsaObj1xbqEqnh81nhcNKjIaOuEQoYDPs7LiAauaYnhrHGRGITfwrk5C1
         eSUnQUmzyn7qoCok6rnunYml7VegIZqFTt1x00pZ30eY8oNMZntsPkZS8twXQi6Sn7AV
         Uyvw7TD9g7zngHAfeWB0RPz5pWuHrd7JV8pvx3KKXg9TmGo42NU604TpW7wjgddeziuw
         /WDYpLYgDK4iLz8MjS+aWIbyNy4sdkSAkMC7FMICk0wVMlDndwIWgBwNZ9FZYIRGYYY9
         bMa/ss6TZMv78hLjns/7TqsqzsStS4bEAKTWdaay6zEoSN7F9RzIjXxtGQxQcdG8X2Gs
         wwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QS+owt/6LPBcNmYdhUS3l3R2H/RaKUY+gUk7F26xgNs=;
        b=ItjL74tA9yrugr17ePsdldM2S5OWkAH2t0/s3eXx7YFW2SyW3eAfLseUXWf+rEI146
         3zw/WcgrdsWAuqpDGHnvh2W9iRDJ8tbGOrP+Pr57G8FuXk883Ca381ovY+G+ZfhHqrep
         7qPANKOCpj2bf2f58pJ6CXDz0v27MvRoEqI/4YBFURjcdyCFanUx9/9hEVYnxg+7vQBS
         qwEnj358iNE1awTH0Pgf84MUIs2bL5eR+X9SLXVlyduDybDVauHuRBYtj+S+4OOTadvS
         P6pjQt5655dJ3yBJjoJSgstq5Rctz1WBq31O2d+fa8Y/UMEyjymLjNRjhP0yDz/we+5w
         zgbw==
X-Gm-Message-State: AOAM5320jKj70zJJa95a1G03TyCWe8nHwDq0M6hCbqAb+GpuiO7ozrSG
        CMrV8o7049vT7gYclzzWBTE=
X-Google-Smtp-Source: ABdhPJwreOjvCv0G0GhiIBYbra9rFXW9rtHBwQaRrccgWTViIiN1vpExl/kWBf0XgjpRnHsbClZv4A==
X-Received: by 2002:a62:5f06:0:b0:4fa:3a26:c845 with SMTP id t6-20020a625f06000000b004fa3a26c845mr2489862pfb.26.1647500598903;
        Thu, 17 Mar 2022 00:03:18 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id mw9-20020a17090b4d0900b001c690d47924sm323568pjb.53.2022.03.17.00.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 00:03:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: csiostor: Remove useless DMA-32 fallback configuration
Date:   Thu, 17 Mar 2022 07:03:14 +0000
Message-Id: <20220317070314.2138743-1-chi.minghao@zte.com.cn>
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
 drivers/scsi/csiostor/csio_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
index ccbded3353bd..d44cd6da8cb4 100644
--- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -204,8 +204,6 @@ csio_pci_init(struct pci_dev *pdev, int *bars)
 	pci_try_set_mwi(pdev);
 
 	rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (rv)
-		rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rv) {
 		rv = -ENODEV;
 		dev_err(&pdev->dev, "No suitable DMA available.\n");
-- 
2.25.1

