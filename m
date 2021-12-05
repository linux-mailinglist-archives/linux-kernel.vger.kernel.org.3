Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEE6468DDF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 00:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhLEXLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbhLEXK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:10:59 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3542C061714;
        Sun,  5 Dec 2021 15:07:31 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso9090333wms.3;
        Sun, 05 Dec 2021 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCs4/c+MZjNeQBr7owALQPbVfoikSkuepr0D43CkZt4=;
        b=etuc3JNHYSR2qBMjnECcQbwGd67gHRN3VVYeLjsq7ZYhehTG+8aw7oVS5D1GcLQDrG
         otwhCin6RMIapm4tLRYP/3a7VSx384sq9rI+TcPg9b8JpCHLcLkwxLK0/vlOEAknDceI
         sfkaeaS5DZmPeHdmNZof/Mcamu9ZioITqILs2lOoSObPpJU1/cd1sropa2N6CSlpa1G6
         moEinBVkA7wyfKCcltaRX+ISLt5Y9piQXX2ELVTW1kxF98pNDQ7GsdOEdKWZFQZJFYpH
         sg4IVc78cn7t98JlQ67ttGJ8PNABFLcNg1mma7j1yULMER8vP2y262/YJIuVTHmovo+8
         pHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCs4/c+MZjNeQBr7owALQPbVfoikSkuepr0D43CkZt4=;
        b=5Co0RmnDD87GImuiFJ7pInMnMDHQJ+L1/d3YHiFBQSBb0x2OLAUwXBn2UohMmhSBnw
         RVPJcFtc7bA2UX/LSWV3aKpW/VYr+CyvHCBDRaqIhOong+Sp/DACKCoMdeI1WxV7SdTF
         a08UljTF1a+pMltkokagYuIOyosF+Nbbev8BfO7vEGrCaw0mTf0KNDzV3zWXMaHyfNXT
         eUei/QjoRidZeUlefBdThr3vmZ2fcYBKrqN4q71UdtBNsyemoOP2mNJRYBk0ihx556Y6
         gOiJ3uIKi+PxeKgJ9PPOHblsPAoXEuGKSAWjbqPrNa7I1rS2MF7hA0RNir6g5QX1b9Uc
         MpbQ==
X-Gm-Message-State: AOAM531WObS1X4JRLabXqoPcG8Gd4otxMqhji/tv8xzRe3azh7SnhTNR
        MmvX12U2KrJKfW3CNieII+c=
X-Google-Smtp-Source: ABdhPJzFzTk4VJ2Kcyr0vUgFhVC5261Y6D40B5sxj5N0OrHad1y7My8v8MECFMVz/HoWa7xmbQ28Ww==
X-Received: by 2002:a05:600c:6025:: with SMTP id az37mr34685964wmb.194.1638745650500;
        Sun, 05 Dec 2021 15:07:30 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q123sm11389887wma.30.2021.12.05.15.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:07:30 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: onenand: remove redundant variable ooblen
Date:   Sun,  5 Dec 2021 23:07:29 +0000
Message-Id: <20211205230729.79337-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable ooblen is being initialized with a value that is never read.
The variable is never used after this, so it is redundant and can be
removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/nand/onenand/onenand_bbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/onenand/onenand_bbt.c b/drivers/mtd/nand/onenand/onenand_bbt.c
index def89f108007..b17315f8e1d4 100644
--- a/drivers/mtd/nand/onenand/onenand_bbt.c
+++ b/drivers/mtd/nand/onenand/onenand_bbt.c
@@ -60,7 +60,7 @@ static int create_bbt(struct mtd_info *mtd, uint8_t *buf, struct nand_bbt_descr
 	int i, j, numblocks, len, scanlen;
 	int startblock;
 	loff_t from;
-	size_t readlen, ooblen;
+	size_t readlen;
 	struct mtd_oob_ops ops;
 	int rgn;
 
@@ -69,7 +69,7 @@ static int create_bbt(struct mtd_info *mtd, uint8_t *buf, struct nand_bbt_descr
 	len = 2;
 
 	/* We need only read few bytes from the OOB area */
-	scanlen = ooblen = 0;
+	scanlen = 0;
 	readlen = bd->len;
 
 	/* chip == -1 case only */
-- 
2.33.1

