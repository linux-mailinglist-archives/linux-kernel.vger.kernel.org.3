Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D29594227
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349229AbiHOVor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349323AbiHOVk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:40:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 269905A885
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:29:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 505E5D6E;
        Mon, 15 Aug 2022 12:29:00 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B38853F67D;
        Mon, 15 Aug 2022 12:28:58 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yunfei Wang <yf.wang@mediatek.com>
Subject: [PATCH] dma-debug: Improve search for partial syncs
Date:   Mon, 15 Aug 2022 20:28:40 +0100
Message-Id: <35bf2add5ae803b0355d556f965090d4014e574e.1660590752.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When bucket_find_contains() tries to find the original entry for a
partial sync, it manages to constrain its search in a way that is both
too restrictive and not restrictive enough. A driver which only uses
single mappings rather than scatterlists might not set max_seg_size, but
could still technically perform a partial sync at an offset of more than
64KB into a sufficiently large mapping, so we could stop searching too
early before reaching a legitimate entry. Conversely, if no valid entry
is present and max_range is large enough, we can pointlessly search
buckets that we've already searched, or that represent an impossible
wrapping around the bottom of the address space. At worst, the
(legitimate) case of max_seg_size == UINT_MAX can make the loop
infinite.

Replace the fragile and frankly hard-to-follow "range" logic with a
simple counted loop for the number of possible hash buckets below the
given address.

Reported-by: Yunfei Wang <yf.wang@mediatek.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Having come back and looked at this for long enough to realise that
max_range itself was both wrong and not actually useful, I figured it
was easiest just to write the whole thing up as an alternative patch.

 kernel/dma/debug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 2caafd13f8aa..18c93c2276ca 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -350,11 +350,10 @@ static struct dma_debug_entry *bucket_find_contain(struct hash_bucket **bucket,
 						   unsigned long *flags)
 {
 
-	unsigned int max_range = dma_get_max_seg_size(ref->dev);
 	struct dma_debug_entry *entry, index = *ref;
-	unsigned int range = 0;
+	int limit = min(HASH_SIZE, (index.dev_addr >> HASH_FN_SHIFT) + 1);
 
-	while (range <= max_range) {
+	for (int i = 0; i < limit; i++) {
 		entry = __hash_bucket_find(*bucket, ref, containing_match);
 
 		if (entry)
@@ -364,7 +363,6 @@ static struct dma_debug_entry *bucket_find_contain(struct hash_bucket **bucket,
 		 * Nothing found, go back a hash bucket
 		 */
 		put_hash_bucket(*bucket, *flags);
-		range          += (1 << HASH_FN_SHIFT);
 		index.dev_addr -= (1 << HASH_FN_SHIFT);
 		*bucket = get_hash_bucket(&index, flags);
 	}
-- 
2.36.1.dirty

