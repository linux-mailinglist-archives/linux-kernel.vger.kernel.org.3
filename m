Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557F2497404
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbiAWRze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiAWRzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:55:33 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C6CC06173B;
        Sun, 23 Jan 2022 09:55:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso31252280wma.1;
        Sun, 23 Jan 2022 09:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WI6QCwdRfRlhXBBrAhQd4qPsTNBfgzyozeX2unnb/ig=;
        b=QEMKp0ONwTggSKl83x6IUBKNe1+VppnM8jIGUKimz9j1OTB0HMLc/FtTjktA0L42E7
         KY9uiTwYJmDt8Ggie1T/CmB2Koig3teRuUhWFkg2i114WK7/MjWMxYCijI/pIIrV9USt
         mp8gTRk6YuPObAbH8FPpVAZQhqAshpNqCDvVBlSVZ4obY0K6gE9w5fjH/03Q4Dzljr1d
         qufZoYk2HrIDJdqr7zB+fyiISUh5jvZoLGx1jF7qM0DbIDvaYZN+u0QtJgbxk9otgqgY
         fyCendqMUmAZ0r99RED4KOmj0OHZAO79g8Uy8/HfwMqaAgFk3BQ7ps77rXpwWzLPh0tI
         QwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WI6QCwdRfRlhXBBrAhQd4qPsTNBfgzyozeX2unnb/ig=;
        b=oPFk1w0YKX3OfdxfRJGs7cpmckDOVUcYf4qfIoawU17wbD/5HKcn8m3hh69m1AL2vP
         QVNRTcX8Cnetu6jEAaJTXUVehGah7lv7L4EfZ2yTr5B1GynokTYUPM2qIFuEgx+oimye
         0U6VkUE7VzKMZiKM+Tiq/IioX8pJlyynxRg+7LU2AAecIM4B0tHFM4c5LVRaBg5LeqxL
         pMoEtNLXMyAetYWLxXvIWaDwUJWT+OgJALIHCiDw28avDFE4967Uf9uAyDt/pRGviEBf
         0KXM5pG+6a1QHnAu7MxFdGZzfStFDMHg3072el80Qq1lSzJLQ5zRSq5H7IGbtam+vSi/
         DdhQ==
X-Gm-Message-State: AOAM531q2kTkd9r0bJdusB4+zomcN9v6VwVoi9n8sg3OZAU3S8gkHAnQ
        TtiLf6H+M9oDkilWjGff+ko=
X-Google-Smtp-Source: ABdhPJwgO8agwK+ujGOVSevske6oCMA6yzA3GQP2IcQRndDxy1C+PmZW8H9ckD7VUVRN6h8gadzQgQ==
X-Received: by 2002:a05:600c:1ca5:: with SMTP id k37mr3862278wms.40.1642960531434;
        Sun, 23 Jan 2022 09:55:31 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p19sm11630136wmq.19.2022.01.23.09.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 09:55:30 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: 53c700: remove redundant assignment to pointer SCp
Date:   Sun, 23 Jan 2022 17:55:30 +0000
Message-Id: <20220123175530.110462-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer SCp is being re-assigned the same value that it was initialized
to a few lines earlier, the assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/53c700.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 3ad3ebaca8e9..ad4972c0fc53 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1507,7 +1507,6 @@ NCR_700_intr(int irq, void *dev_id)
 		struct scsi_cmnd *SCp = hostdata->cmd;
 
 		handled = 1;
-		SCp = hostdata->cmd;
 
 		if(istat & SCSI_INT_PENDING) {
 			udelay(10);
-- 
2.33.1

