Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1FB4FC4C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbiDKTMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiDKTME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:12:04 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693FE1EECB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649704190; x=1681240190;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=MHOm1tS6UY0+dHUTJrUMw8Q+8aCJ7sp8oEsef1gcb+c=;
  b=Woo11qLtQ4gk1p33DRKnd/BeFG7N7Y9hWZqTQ9Pw3r7JJz+Av+qTRM4Q
   c0mcHmhq1+kZ/wP+nH0bxz8uct8Ko121p9nPVcfEcAeHx/0Wv4eDU4sY+
   4D7kgjN0Xccg+QrM04Nj9vAk3k0Q++L/XWbVkky/ZYgWA2E4/ejtiPmCE
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 12:09:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 12:09:49 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 12:09:49 -0700
Received: from faiyazm-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 12:09:46 -0700
From:   Faiyaz Mohammed <quic_faiyazm@quicinc.com>
To:     <quic_vjitta@quicinc.com>, <karahmed@amazon.de>,
        <qperret@google.com>, <robh@kernel.org>, <rppt@kernel.org>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Faiyaz Mohammed <quic_faiyazm@quicinc.com>
Subject: [PATCH] mm: memblock: avoid to create memmap for memblock nomap regions
Date:   Tue, 12 Apr 2022 00:39:32 +0530
Message-ID: <1649704172-13181-1-git-send-email-quic_faiyazm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
memory region")' is keeping the no-map regions in memblock.memory with
MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
but during the initialization sparse_init mark all memblock.memory as
present using for_each_mem_pfn_range, which is creating the memmap for
no-map memblock regions. To avoid it skiping the memblock.memory regions
set with MEMBLOCK_NOMAP set and with this change we will be able to save
~11MB memory for ~612MB carve out.

With change:
[    0.000000] memblock_alloc_exact_nid_raw: 115343360 bytes align=0x200000 nid=0 from=0x0000000080000000 max_addr=0x0000000000000000 sparse_buffer_init+0x60/0x8c
[    0.000000] memblock_reserve: [0x0000000932c00000-0x00000009399fffff] memblock_alloc_range_nid+0xbc/0x1a0
[    0.000000] On node 0 totalpages: 1627824
[    0.000000] DMA32 zone: 5383 pages used for memmap
[    0.000000] Normal zone: 20052 pages used for memmap

Without change:
[    0.000000] memblock_alloc_exact_nid_raw: 117440512 bytes align=0x200000 nid=0 from=0x0000000080000000 max_addr=0x0000000000000000 sparse_buffer_init+0x60/0x8c
[    0.000000] memblock_reserve: [0x0000000932a00000-0x00000009399fffff] memblock_alloc_range_nid+0xbc/0x1a0
[    0.000000] On node 0 totalpages: 1788416
[    0.000000] DMA32 zone: 8192 pages used for memmap
[    0.000000] Normal zone: 20052 pages used for memmap.

Signed-off-by: Faiyaz Mohammed <quic_faiyazm@quicinc.com>
---
 mm/memblock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 2270e3c..a4fde9d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1175,8 +1175,13 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 		r = &type->regions[*idx];
 		r_nid = memblock_get_region_node(r);
 
+		/* If memblock region is nomap then skip the region. */
+		if (memblock_is_nomap(r))
+			continue;
+
 		if (PFN_UP(r->base) >= PFN_DOWN(r->base + r->size))
 			continue;
+
 		if (nid == MAX_NUMNODES || nid == r_nid)
 			break;
 	}
-- 
2.7.4

