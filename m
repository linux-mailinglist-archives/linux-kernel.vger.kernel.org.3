Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9466E5AF99B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIGCBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIGCBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:01:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D003686FE6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:01:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so16759404pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 19:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wMmXTxb9LbCsYqga95mJwmvC4k81ZDpljIpjJFQZtFw=;
        b=hn6hqpEUxGoGhX68VXgTXpMCVKDJ5Pa6HLR3DTCS+p/PxteYYkJWtclUSQ+cFe8KTe
         jBdDF3N2kAMZp3qwCb8e0woljUxUquQSNV9Pq/AzMSLTHKXe69BXp+9OD1A2pWrD6sOL
         nWr92uWfuhzsfhJ4nN8KxkkF0zXIxxVezZkiWpzt+4LW8RKcR23HXmFvLGaKJMZXGWHJ
         JiEULAe6syHdCofXjyEvOs1ZVjq/pQrbYhRwPpX7bncI/u5VH5VkY4Jz5Mqj7AZEuA9D
         T4nap+kOtJo67m5mcrZwLQ7nMqT6vBLDeoe15kfsBhzkKTXO79GjcqeeX8jDIKyO1Mug
         jl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wMmXTxb9LbCsYqga95mJwmvC4k81ZDpljIpjJFQZtFw=;
        b=MsHUrLwh8yp1GBlYHUr9z+/fibvWny5ZWM6qNOsiTLllh3b/dmfUH5yKCNnM5h5JFg
         edrv52mvlpMz/csEYaDdBMQVULXUg+n4Xa+2UWRjXMV4SrwYEwDAeRW9rVNKG/5g07E5
         TBay20PDlLVzbYjysOWRmFx3fkHM8lPFyI53p+ftF/CLKS3VViq6K9Sj4usYJgBJlzaP
         hnIx410aG/OYlsCfxpEzSCby3AcF7Bmq64OpjndiiMWIDYZd8sYP6YT7cQ08oz1XZFOh
         qOGxvNATPJmUoq8LCXyk8Uy//hch8sdJzPIZrcJVMte3cVDcGfxxjmj5RKfF3klmekOa
         OTsw==
X-Gm-Message-State: ACgBeo1mjjsHX8asr4fMoIL/nI7qRn3iYyJe3pBPj25KLXW8wNVc1TyM
        US5jok6D98qAFCJFgyxyFPXeHQ==
X-Google-Smtp-Source: AA6agR6xr1M9nClZ35+wWuEvB7RQBR2FuZReE6jv3+pgOUfltbLPBGu7oaxudF/b7HTVtH7DOaL/Aw==
X-Received: by 2002:a17:902:ce8e:b0:16d:cebc:e92e with SMTP id f14-20020a170902ce8e00b0016dcebce92emr1241966plg.85.1662516069638;
        Tue, 06 Sep 2022 19:01:09 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id s59-20020a17090a2f4100b002005c3d4d4fsm5182369pjd.19.2022.09.06.19.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 19:01:09 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>
Subject: [PATCH v3 1/2] misc: pci_endpoint_test: Aggregate params checking for xfer
Date:   Wed,  7 Sep 2022 11:00:59 +0900
Message-Id: <20220907020100.122588-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each transfer test functions have same parameter checking code. This patch
unites those to an introduced function.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes in v3:
* Remove duplicated logging and change to use dev_dbg().

Changes in v2:
* New patch
---
---
 drivers/misc/pci_endpoint_test.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8f786a225dcf..39d477bb0989 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -332,6 +332,17 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static int pci_endpoint_test_validate_xfer_params(struct device *dev,
+		struct pci_endpoint_test_xfer_param *param, size_t alignment)
+{
+	if (param->size > SIZE_MAX - alignment) {
+		dev_dbg(dev, "Maximum transfer data size exceeded\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 				   unsigned long arg)
 {
@@ -363,9 +374,11 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 		return false;
 	}
 
+	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
+	if (err)
+		return false;
+
 	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
@@ -497,9 +510,11 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 		return false;
 	}
 
+	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
+	if (err)
+		return false;
+
 	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
@@ -595,9 +610,11 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 		return false;
 	}
 
+	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
+	if (err)
+		return false;
+
 	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
-- 
2.17.1

