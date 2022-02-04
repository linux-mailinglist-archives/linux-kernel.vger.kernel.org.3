Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B5B4A96DB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiBDJdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:33:07 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57650 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232946AbiBDJdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:33:06 -0500
X-UUID: a50011e4aa3a4a8397125ce9a9d20236-20220204
X-UUID: a50011e4aa3a4a8397125ce9a9d20236-20220204
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <phil.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1009347765; Fri, 04 Feb 2022 17:33:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Feb 2022 17:33:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Feb 2022 17:33:02 +0800
From:   Phil Chang <phil.chang@mediatek.com>
To:     <jens.wiklander@linaro.org>
CC:     <sumit.garg@linaro.org>, <matthias.bgg@gmail.com>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <phil.chang@mediatek.com>
Subject: [PATCH] optee: make tee_shm_register vmalloc supported
Date:   Fri, 4 Feb 2022 17:32:54 +0800
Message-ID: <20220204093254.2467-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allowed the tee shm use vmalloc area buffer.

Signed-off-by: Phil Chang <phil.chang@mediatek.com>
---

Hi,

 In some low-memory devices, it's hard to aquire large-orders pages,
 this pathes is allowed user use scatter pages to register shm.

 Thanks.

 drivers/tee/optee/call.c |  2 +-
 drivers/tee/tee_shm.c    | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index b25cc1fac945..937bcc7df8e4 100644
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
index 499fccba3d74..31d0c10485ff 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -195,6 +195,20 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 	if (flags & TEE_SHM_USER_MAPPED) {
 		rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
 					 shm->pages);
+	} else if (is_vmalloc_addr((void *)start)) {
+		struct page *page;
+		int i;
+
+		for (i = 0; i < num_pages; i++) {
+			page = vmalloc_to_page((void *)(start + PAGE_SIZE * i));
+			if (!page) {
+				ret = ERR_PTR(-ENOMEM);
+				goto err;
+			}
+			get_page(page);
+			shm->pages[i] = page;
+		}
+		rc = num_pages;
 	} else {
 		struct kvec *kiov;
 		int i;
--
2.25.1
