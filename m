Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF85A4CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiH2M6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiH2M4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDEA1A83C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:38 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGVWt2QRCzkWl8;
        Mon, 29 Aug 2022 20:44:58 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 20:48:35 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 29 Aug
 2022 20:48:34 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next v4 3/6] Revert "frontswap: simplify frontswap_register_ops"
Date:   Mon, 29 Aug 2022 21:22:59 +0800
Message-ID: <20220829132302.3367054-4-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829132302.3367054-1-liushixin2@huawei.com>
References: <20220829132302.3367054-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f328c1d16e4c764992895ac9c9425cea861b2ca0.

Since we are supported to delay zswap initializaton, we need to invoke
ops->init for the swap device which is already online when register
backend.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/frontswap.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/mm/frontswap.c b/mm/frontswap.c
index 8d644f56a1d2..555e78f9529d 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -99,6 +99,25 @@ static inline void inc_frontswap_invalidates(void) { }
  */
 void frontswap_register_ops(struct frontswap_ops *ops)
 {
+	DECLARE_BITMAP(a, MAX_SWAPFILES);
+	DECLARE_BITMAP(b, MAX_SWAPFILES);
+	struct swap_info_struct *si;
+	unsigned int i;
+
+	bitmap_zero(a, MAX_SWAPFILES);
+	bitmap_zero(b, MAX_SWAPFILES);
+
+	spin_lock(&swap_lock);
+	plist_for_each_entry(si, &swap_active_head, list) {
+		if (!WARN_ON(!si->frontswap_map))
+			__set_bit(si->type, a);
+	}
+	spin_unlock(&swap_lock);
+
+	/* the new ops needs to know the currently active swap devices */
+	for_each_set_bit(i, a, MAX_SWAPFILES)
+		ops->init(i);
+
 	/*
 	 * Setting frontswap_ops must happen after the ops->init() calls
 	 * above; cmpxchg implies smp_mb() which will ensure the init is
@@ -109,6 +128,28 @@ void frontswap_register_ops(struct frontswap_ops *ops)
 	} while (cmpxchg(&frontswap_ops, ops->next, ops) != ops->next);
 
 	static_branch_inc(&frontswap_enabled_key);
+
+	spin_lock(&swap_lock);
+	plist_for_each_entry(si, &swap_active_head, list) {
+		if (si->frontswap_map)
+			__set_bit(si->type, b);
+	}
+	spin_unlock(&swap_lock);
+
+	/*
+	 * On the very unlikely chance that a swap device was added or
+	 * removed between setting the "a" list bits and the ops init
+	 * calls, we re-check and do init or invalidate for any changed
+	 * bits.
+	 */
+	if (unlikely(!bitmap_equal(a, b, MAX_SWAPFILES))) {
+		for (i = 0; i < MAX_SWAPFILES; i++) {
+			if (!test_bit(i, a) && test_bit(i, b))
+				ops->init(i);
+			else if (test_bit(i, a) && !test_bit(i, b))
+				ops->invalidate_area(i);
+		}
+	}
 }
 
 /*
-- 
2.25.1

