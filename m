Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608B54C701F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiB1OzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiB1OzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:55:15 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861F424BA;
        Mon, 28 Feb 2022 06:54:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 12so11653752pgd.0;
        Mon, 28 Feb 2022 06:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZI3WKr44gQFwNamAPZLz71oRj2BK+8Z/76zrwIPf9TA=;
        b=LmbZpW6/LWzUaZkybCSn6M9Rmt712kYOR1ZkqSm6K9ju9oW7F2UeiDk/bB6SxojDI0
         mvrARsOhjsY355jwhSSwf8ytFo+t9BNDMm21klZsQSwG+gFqk3O36pTBsXWCkun+258R
         fxZ4cQ2+rLUWP1mL00jpA7K8IktC+CgLymJXG0vKZwfwStIrNrRuKxyq8T58Y0HTqL4r
         vSW5GNt/wSPKs4F87marwsI3B6w5KNRmUuS6OHQz5PAPZ7bh8o92rxj9KspA8fNKLHdI
         oRvIdZXdy7mdC0XEqj9Xw001mJEtfZKXVqEqj8fv4tk+EtnCU6b8xWIZE9lcbhGEQoys
         c0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZI3WKr44gQFwNamAPZLz71oRj2BK+8Z/76zrwIPf9TA=;
        b=a7CoGfyFMwIUff7zYQV1IBQ7J8TXkT7Ym8Nj37dauIk0HHQXg+HssaEXe/Javbun1F
         zFv2XHHVAOeiTvBwxOcC37zsTUeOz7t1sUnYbrAElD2kzqb4kOABUHQ580hSzs/ZxuQk
         cP8xr2z2lO6EvN3FpwHui/kCSdweJwKst5xqhhLIwKaTWY84gMv+Q/VgGN7PKJeVx7Op
         Zgbr/YLqUUalYLQMRZxcoWqNglKzMlO2dDLd8cGJL/KU3ma74QVdp43ioB7oYtn3KaqG
         3NfSasHqEHEkA2xlgDk9qAw/eylNN4MxC6WexBmoMztb91jEfVWGR1VfStdlCteHm9vc
         aJgg==
X-Gm-Message-State: AOAM533q//LA36cDeFuyVlzVmFUaqKSqsZtkFP1coYVpXh6ZilFJM9nr
        +7aQPGqf+UiSXipvEM7W8w==
X-Google-Smtp-Source: ABdhPJxwUfKZSF6qDcSU2tVaVicT9+sagkyPAR7XDw0i7zaqVWgmgU6fvwvC+Xsyygjc5f6oyA3yPA==
X-Received: by 2002:a63:2c4e:0:b0:373:6dfb:29e with SMTP id s75-20020a632c4e000000b003736dfb029emr17526601pgs.109.1646060076109;
        Mon, 28 Feb 2022 06:54:36 -0800 (PST)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id bt20-20020a17090af01400b001bd60582399sm2256272pjb.29.2022.02.28.06.54.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:54:35 -0800 (PST)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] scsi: wd719x: Return proper error code when dma_set_mask() fails
Date:   Mon, 28 Feb 2022 14:54:15 +0000
Message-Id: <1646060055-11361-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the process of driver probing, the probe function should return < 0
for failure, otherwise, the kernel will treat value >= 0 as success.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/scsi/wd719x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/wd719x.c b/drivers/scsi/wd719x.c
index 1a7947554581..2b24ef387d57 100644
--- a/drivers/scsi/wd719x.c
+++ b/drivers/scsi/wd719x.c
@@ -904,7 +904,8 @@ static int wd719x_pci_probe(struct pci_dev *pdev, const struct pci_device_id *d)
 	if (err)
 		goto fail;
 
-	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
+	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (err) {
 		dev_warn(&pdev->dev, "Unable to set 32-bit DMA mask\n");
 		goto disable_device;
 	}
-- 
2.25.1

