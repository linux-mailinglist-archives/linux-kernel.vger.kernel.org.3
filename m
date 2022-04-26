Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18EE510C89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356037AbiDZXVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbiDZXVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BEE2558A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32F9D619D9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1B0C385AC;
        Tue, 26 Apr 2022 23:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651015077;
        bh=YnkPrrQiKwuGGyvVaqlu6cxudhMT2Z6l0tsHJMGCSLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+wVaca+J8Z0we2yoKSO7pa/nVK4O+JWJv51NVJMdHtqy9uAfxA4KfbmUtKOPL/TF
         8geiAzHdQpKjKDEsMTQwOYX+HdIsyKqSEmt9W81+MevTJeqeA7dBEXYqKR9F8jJgII
         KVTXeHGp+axIKSK5XNuRH0P5nut+3hrm+mHp4K3u+5MtmEu2K/p3I7xe3eaTg9sxUY
         61U/3yRlcTv3qGYfXP692Diyzh4x2DJ9S4djv5AKhQKtOmtNYVq2euOpvsNJxCPO0W
         K16ZCOAIDjb+a/TPd+iM8qLTAnxhrvHNTnIs+36dldyRNJTa/kmTrQpT4bmb4NY3y5
         JVMy9EmDJfFxQ==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/3] mm/damon/vaddr: register a damon_operations for fixed virtual address ranges monitoring
Date:   Tue, 26 Apr 2022 23:17:48 +0000
Message-Id: <20220426231750.48822-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426231750.48822-1-sj@kernel.org>
References: <20220426231750.48822-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

The monitoring operations set for virtual address spaces automatically
updates the monitoring target regions to cover entire mappings of the
virtual address spaces as much as possible.  Some users could have more
information about their programs than kernel and therefore have interest
in not entire regions but only specific regions.  For such cases, the
automatic monitoring target regions updates are only unnecessary
overheads or distractions.

For such cases, DAMON's API users can simply set the '->init()' and
'->update()' of the DAMON context's '->ops' NULL, and set the target
monitoring regions when creating the context.  But, that would be a
dirty hack.  Worse yet, the hack is unavailable for DAMON user space
interface users.

To support the use case in a clean way that can easily exported to the
user space, this commit adds another monitoring operations set called
'fvaddr', which is same to 'vaddr' but does not automatically update the
monitoring regions.  Instead, it will only respect the virtual address
regions which have explicitly passed at the initial context creation.

Note that this commit leave sysfs interface not supporting the feature
yet.  The support will be made in a following commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  3 +++
 mm/damon/sysfs.c      |  4 ++++
 mm/damon/vaddr.c      | 15 +++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 73ff0e2d2a4d..09a5d0d02c00 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -261,10 +261,13 @@ struct damos {
  * enum damon_ops_id - Identifier for each monitoring operations implementation
  *
  * @DAMON_OPS_VADDR:	Monitoring operations for virtual address spaces
+ * @DAMON_OPS_FVADDR:	Monitoring operations for only fixed ranges of virtual
+ *			address spaces
  * @DAMON_OPS_PADDR:	Monitoring operations for the physical address space
  */
 enum damon_ops_id {
 	DAMON_OPS_VADDR,
+	DAMON_OPS_FVADDR,
 	DAMON_OPS_PADDR,
 	NR_DAMON_OPS,
 };
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6ad6364780b8..719a286d378f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1694,6 +1694,7 @@ static struct kobj_type damon_sysfs_attrs_ktype = {
 /* This should match with enum damon_ops_id */
 static const char * const damon_sysfs_ops_strs[] = {
 	"vaddr",
+	"unsupported",	/* fvaddr is not supported by sysfs yet */
 	"paddr",
 };
 
@@ -1843,6 +1844,9 @@ static ssize_t operations_store(struct kobject *kobj,
 
 	for (id = 0; id < NR_DAMON_OPS; id++) {
 		if (sysfs_streq(buf, damon_sysfs_ops_strs[id])) {
+			/* fvaddr is not supported by sysfs yet */
+			if (id == DAMON_OPS_FVADDR)
+				return -EINVAL;
 			context->ops_id = id;
 			return count;
 		}
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b2ec0aa1ff45..5ba82ab4943b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -753,8 +753,19 @@ static int __init damon_va_initcall(void)
 		.apply_scheme = damon_va_apply_scheme,
 		.get_scheme_score = damon_va_scheme_score,
 	};
-
-	return damon_register_ops(&ops);
+	/* ops for fixed virtual address ranges */
+	struct damon_operations ops_fvaddr = ops;
+	int err;
+
+	/* Don't set the monitoring target regions for the entire mapping */
+	ops_fvaddr.id = DAMON_OPS_FVADDR;
+	ops_fvaddr.init = NULL;
+	ops_fvaddr.update = NULL;
+
+	err = damon_register_ops(&ops);
+	if (err)
+		return err;
+	return damon_register_ops(&ops_fvaddr);
 };
 
 subsys_initcall(damon_va_initcall);
-- 
2.25.1

