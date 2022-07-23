Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C372E57EEA0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiGWKPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 06:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239188AbiGWKPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:15:16 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6F62981D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 03:05:27 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id FC03oI5J881u5FC03oFWNV; Sat, 23 Jul 2022 12:04:45 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 23 Jul 2022 12:04:45 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     akpm@linux-foundation.org, feng.tang@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [RFC PATCH] devres: avoid over memory allocation with managed memory allocation
Date:   Sat, 23 Jul 2022 12:04:33 +0200
Message-Id: <92ec2f78e8d38f68da95d9250cf3f86b2fbe78ad.1658570017.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On one side, when using devm_kmalloc(), a memory overhead is added in order
to keep track of the data needed to release the resources automagically.

On the other side, kmalloc() also rounds-up the required memory size in
order to ease memory reuse and avoid memory fragmentation.

Both behavior together can lead to some over memory allocation which can
be avoided.

For example:
  - if 4096 bytes of managed memory is required
  - "4096 + sizeof(struct devres_node)" bytes are required to the memory
allocator
  - 8192 bytes are allocated and nearly half of it is wasted

In such a case, it would be better to really allocate 4096 bytes of memory
and record an "action" to perform the kfree() when needed.

On my 64 bits system:
   sizeof(struct devres_node) = 40
   sizeof(struct action_devres) = 16

So, a devm_add_action() call will allocate 56, rounded up to 64 bytes.

kmalloc() uses hunks of 8k, 4k, 2k, 1k, 512, 256, 192, 128, 96, 64, 32, 16,
8 bytes.

So in order to save some memory, if the 256 bytes boundary is crossed
because of the overhead of devm_kmalloc(), 2 distinct memory allocations
make sense.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is only a RFC to get feed-back on the proposed approach.

It is compile tested only.
I don't have numbers to see how much memory could be saved.
I don't have numbers on the performance impact.

Should this makes sense to anyone, I would really appreciate getting some
numbers from others to confirm if it make sense or not.


The idea of this patch came to me because of a discussion initiated by
Feng Tang <feng.tang@intel.com>. He proposes to track wasted memory
allocation in order to give hints on where optimizations can be done.

My approach is to avoid part of these allocations when due to the usage of
a devm_ function.


The drawbacks I see are:
   - code is more complex
   - this concurs to memory fragmentation because there will be 2 memory
     allocations, instead of just 1
   - this is slower for every memory allocation because of the while loop
     and tests
   - the magic 256 constant is maybe not relevant on all systems
   - some places of the kernel already take advantage of this over memory
     allocation. So unpredictable impacts can occur somewhere! (see [1],
     which is part of the [2] thread)
   - this makes some assumption in devres.c on how memory allocation works,
     which is not a great idea :(

The advantages I see:
   - in some cases, it saves some memory :)
   - fragmentation is not necessarily an issue, devm_ allocated memory
     are rarely freed, right?

One case where such an approach makes sense to me is:
   drivers/mtd/nand/onenand/onenand_samsung.c
where (on my system) we would allocate 8k when 4k is required.


Thought?

CJ

[1]: https://lore.kernel.org/all/5ad51c9f-ce84-5d1b-309c-6e475cebca97@suse.cz/
[2]: https://lore.kernel.org/all/20220701135954.45045-1-feng.tang@intel.com/
---
 drivers/base/devres.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 864d0b3f566e..67f87af32914 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -794,6 +794,11 @@ static void devm_kmalloc_release(struct device *dev, void *res)
 	/* noop */
 }
 
+static void devm_kmalloc_release_with_action(void *res)
+{
+	kfree(res);
+}
+
 static int devm_kmalloc_match(struct device *dev, void *res, void *data)
 {
 	return res == data;
@@ -814,11 +819,40 @@ static int devm_kmalloc_match(struct device *dev, void *res, void *data)
  */
 void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
 {
+	size_t tipping_point;
 	struct devres *dr;
 
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;
 
+	/*
+	 * alloc_dr() adds a small memory overhead that may require some over
+	 * memory allocation. In such cases, it is more interesting to allocate
+	 * the exact amount of memory required and register an "action" to free
+	 * it. The overhead of devm_add_action_or_reset() is smaller.
+	 */
+	tipping_point = 256;
+	while (tipping_point < KMALLOC_MAX_CACHE_SIZE) {
+		void *ptr;
+		int err;
+
+		if (size <= tipping_point &&
+		    size + sizeof(struct devres) > tipping_point) {
+			ptr = kmalloc(size, gfp);
+			if (unlikely(!ptr))
+				return NULL;
+
+			err = devm_add_action_or_reset(dev,
+					devm_kmalloc_release_with_action, ptr);
+			if (unlikely(err))
+				return NULL;
+
+			return ptr;
+		}
+
+		tipping_point <<= 1;
+	}
+
 	/* use raw alloc_dr for kmalloc caller tracing */
 	dr = alloc_dr(devm_kmalloc_release, size, gfp, dev_to_node(dev));
 	if (unlikely(!dr))
-- 
2.34.1

