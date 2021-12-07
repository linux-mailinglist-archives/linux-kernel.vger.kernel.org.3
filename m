Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64A646B77E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhLGJjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:39:47 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44840 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229453AbhLGJjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:39:46 -0500
X-UUID: 64c74f11bcfc449e8d5e5c76bf4219a3-20211207
X-UUID: 64c74f11bcfc449e8d5e5c76bf4219a3-20211207
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1195996042; Tue, 07 Dec 2021 17:36:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 7 Dec 2021 17:36:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Dec 2021 17:36:12 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] gfp: further document GFP_DMA32
Date:   Tue, 7 Dec 2021 17:36:10 +0800
Message-ID: <20211207093610.6406-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc(..., GFP_DMA32) does not return DMA32 memory
because the DMA32 kmalloc cache array is not implemented.
(Reason: there is no such user in kernel).

Put a short comment about this so people can understand this by
reading the comment.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2018-December/031696.html

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 include/linux/gfp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b976c4177299..c7bfaa9f3903 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -302,7 +302,9 @@ struct vm_area_struct;
  * lowest zone as a type of emergency reserve.
  *
  * %GFP_DMA32 is similar to %GFP_DMA except that the caller requires a 32-bit
- * address.
+ * address. Note that kmalloc(..., GFP_DMA32) does not return DMA32 memory
+ * because the DMA32 kmalloc cache array is not implemented.
+ * (Reason: there is no such user in kernel).
  *
  * %GFP_HIGHUSER is for userspace allocations that may be mapped to userspace,
  * do not need to be directly accessible by the kernel but that cannot
-- 
2.18.0

