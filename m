Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699354B3C43
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 17:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiBMQV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 11:21:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiBMQVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 11:21:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0844E391
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 08:21:17 -0800 (PST)
X-UUID: a550d979978e4613b85bd0d28b026b98-20220214
X-UUID: a550d979978e4613b85bd0d28b026b98-20220214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <phil.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 744166561; Mon, 14 Feb 2022 00:21:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 14 Feb 2022 00:21:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 00:21:12 +0800
From:   Phil Chang <phil.chang@mediatek.com>
To:     <phil.chang@mediatek.com>
CC:     <jens.wiklander@linaro.org>, <matthias.bgg@gmail.com>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] tee: make tee_shm_register_kernel_buf vmalloc supported
Date:   Mon, 14 Feb 2022 00:21:10 +0800
Message-ID: <20220213162110.27210-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some low-memory devices, it's hard to aquire large-orders pages,
this patch allowed user using scatter pages to register shm.

Signed-off-by: Phil Chang <phil.chang@mediatek.com>
---
 drivers/tee/optee/call.c |  2 +-
 drivers/tee/tee_shm.c    | 40 ++++++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index bd49ec934060..2082e632adff 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -362,7 +362,7 @@ int optee_check_mem_type(unsigned long start, size_t num_pages)
 	 * Allow kernel address to register with OP-TEE as kernel
 	 * pages are configured as normal memory only.
 	 */
-	if (virt_addr_valid(start))
+	if (virt_addr_valid(start) || is_vmalloc_addr((void *)start))
 		return 0;
 
 	mmap_read_lock(mm);
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index f31e29e8f1ca..861403588485 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -23,22 +23,38 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
 static int shm_get_kernel_pages(unsigned long start, size_t page_count,
 				struct page **pages)
 {
-	struct kvec *kiov;
-	size_t n;
 	int rc;
 
-	kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
-	if (!kiov)
-		return -ENOMEM;
-
-	for (n = 0; n < page_count; n++) {
-		kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
-		kiov[n].iov_len = PAGE_SIZE;
+	if (is_vmalloc_addr((void *)start)) {
+		struct page *page;
+		int i;
+
+		for (i = 0; i < page_count; i++) {
+			page = vmalloc_to_page((void *)(start + PAGE_SIZE * i));
+			if (!page)
+				return -ENOMEM;
+
+			get_page(page);
+			pages[i] = page;
+		}
+		rc = page_count;
+	} else {
+		struct kvec *kiov;
+		size_t n;
+
+		kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
+		if (!kiov)
+			return -ENOMEM;
+
+		for (n = 0; n < page_count; n++) {
+			kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
+			kiov[n].iov_len = PAGE_SIZE;
+		}
+
+		rc = get_kernel_pages(kiov, page_count, 0, pages);
+		kfree(kiov);
 	}
 
-	rc = get_kernel_pages(kiov, page_count, 0, pages);
-	kfree(kiov);
-
 	return rc;
 }
 
-- 
2.25.1
