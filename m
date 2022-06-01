Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4C53A07A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351112AbiFAJdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345378AbiFAJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:32:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F0EC8AE42
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:32:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C1F223A;
        Wed,  1 Jun 2022 02:32:58 -0700 (PDT)
Received: from net-x86-dell-8268.shanghai.arm.com (net-x86-dell-8268.shanghai.arm.com [10.169.210.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F2223F66F;
        Wed,  1 Jun 2022 02:32:56 -0700 (PDT)
From:   Tianyu Li <tianyu.li@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kernel@vger.kernel.org (open list)
Cc:     nd@arm.com, Tianyu Li <tianyu.li@arm.com>
Subject: [PATCH] mm/mempolicy: fix get_nodes out of bound access
Date:   Wed,  1 Jun 2022 17:32:11 +0800
Message-Id: <20220601093211.2970565-1-tianyu.li@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user specified more nodes than supported,
get_nodes will access nmask array out of bound.

Fixes: e130242dc351 ("mm: simplify compat numa syscalls")
Signed-off-by: Tianyu Li <tianyu.li@arm.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0b4ba3ee810e..9f27dc4b66ba 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1388,7 +1388,7 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 		unsigned long bits = min_t(unsigned long, maxnode, BITS_PER_LONG);
 		unsigned long t;
 
-		if (get_bitmap(&t, &nmask[maxnode / BITS_PER_LONG], bits))
+		if (get_bitmap(&t, &nmask[(maxnode - 1) / BITS_PER_LONG], bits))
 			return -EFAULT;
 
 		if (maxnode - bits >= MAX_NUMNODES) {
-- 
2.25.1

