Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F7E507F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359062AbiDTCso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359025AbiDTCs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:48:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EC22E9FB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:45:42 -0700 (PDT)
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KjlQh68FmzhXdN;
        Wed, 20 Apr 2022 10:45:32 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 10:45:40 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 10:45:38 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v4 5/7] arm64: mte: Clean up user tag accessors
Date:   Wed, 20 Apr 2022 03:04:16 +0000
Message-ID: <20220420030418.3189040-6-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420030418.3189040-1-tongtiangen@huawei.com>
References: <20220420030418.3189040-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

Invoking user_ldst to explicitly add a post-increment of 0 is silly.
Just use a normal USER() annotation and save the redundant instruction.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/lib/mte.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index 8590af3c98c0..eeb9e45bcce8 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -93,7 +93,7 @@ SYM_FUNC_START(mte_copy_tags_from_user)
 	mov	x3, x1
 	cbz	x2, 2f
 1:
-	user_ldst 2f, ldtrb, w4, x1, 0
+USER(2f, ldtrb	w4, [x1])
 	lsl	x4, x4, #MTE_TAG_SHIFT
 	stg	x4, [x0], #MTE_GRANULE_SIZE
 	add	x1, x1, #1
@@ -120,7 +120,7 @@ SYM_FUNC_START(mte_copy_tags_to_user)
 1:
 	ldg	x4, [x1]
 	ubfx	x4, x4, #MTE_TAG_SHIFT, #MTE_TAG_SIZE
-	user_ldst 2f, sttrb, w4, x0, 0
+USER(2f, sttrb	w4, [x0])
 	add	x0, x0, #1
 	add	x1, x1, #MTE_GRANULE_SIZE
 	subs	x2, x2, #1
-- 
2.25.1

