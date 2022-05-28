Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC18536B0D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 08:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiE1GKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 02:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiE1GK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 02:10:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC3023162
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 23:10:27 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L9B630ddszRhW6;
        Sat, 28 May 2022 14:07:23 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 14:10:25 +0800
From:   Yuanzheng Song <songyuanzheng@huawei.com>
To:     <tobin@kernel.org>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        Yuanzheng Song <songyuanzheng@huawei.com>
Subject: [PATCH] tools/vm/slabinfo: use alphabetic order when two values are equal
Date:   Sat, 28 May 2022 06:31:17 +0000
Message-ID: <20220528063117.935158-1-songyuanzheng@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the number of partial slabs in each cache is the same (e.g., the
value are 0), the results of the `slabinfo -X -N5` and `slabinfo -P -N5`
are different.

/ # slabinfo -X -N5
...
Slabs sorted by number of partial slabs
---------------------------------------
Name                   Objects Objsize           Space Slabs/Part/Cpu  O/S O %Fr %Ef Flg
inode_cache              15180     392         6217728        758/0/1   20 1   0  95 a
kernfs_node_cache        22494      88         2002944        488/0/1   46 0   0  98
shmem_inode_cache          663     464          319488         38/0/1   17 1   0  96
biovec-max                  50    3072          163840          4/0/1   10 3   0  93 A
dentry                   19050     136         2600960        633/0/2   30 0   0  99 a

/ # slabinfo -P -N5
Name                   Objects Objsize           Space Slabs/Part/Cpu  O/S O %Fr %Ef Flg
bdev_cache                  32     984           32.7K          1/0/1   16 2   0  96 Aa
ext4_inode_cache            42     752           32.7K          1/0/1   21 2   0  96 a
dentry                   19050     136            2.6M        633/0/2   30 0   0  99 a
TCPv6                       17    1840           32.7K          0/0/1   17 3   0  95 A
RAWv6                       18     856           16.3K          0/0/1   18 2   0  94 A

This problem is caused by the sort_slabs(). So let's use alphabetic order
when two values are equal in the sort_slabs().

By the way, the content of the `slabinfo -h` is not aligned because the
`-P|--partial		Sort by number of partial slabs` uses tabs instead
of spaces. So let's use spaces instead of tabs to fix it.

Fixes: 1106b205a3fe ("tools/vm/slabinfo: add partial slab listing to -X")
Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
---
 tools/vm/slabinfo.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 9b68658b6bb8..3ae985dc24b6 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -125,7 +125,7 @@ static void usage(void)
 		"-n|--numa              Show NUMA information\n"
 		"-N|--lines=K           Show the first K slabs\n"
 		"-o|--ops               Show kmem_cache_ops\n"
-		"-P|--partial		Sort by number of partial slabs\n"
+		"-P|--partial           Sort by number of partial slabs\n"
 		"-r|--report            Detailed report on single slabs\n"
 		"-s|--shrink            Shrink slabs\n"
 		"-S|--Size              Sort by size\n"
@@ -1045,15 +1045,27 @@ static void sort_slabs(void)
 		for (s2 = s1 + 1; s2 < slabinfo + slabs; s2++) {
 			int result;
 
-			if (sort_size)
-				result = slab_size(s1) < slab_size(s2);
-			else if (sort_active)
-				result = slab_activity(s1) < slab_activity(s2);
-			else if (sort_loss)
-				result = slab_waste(s1) < slab_waste(s2);
-			else if (sort_partial)
-				result = s1->partial < s2->partial;
-			else
+			if (sort_size) {
+				if (slab_size(s1) == slab_size(s2))
+					result = strcasecmp(s1->name, s2->name);
+				else
+					result = slab_size(s1) < slab_size(s2);
+			} else if (sort_active) {
+				if (slab_activity(s1) == slab_activity(s2))
+					result = strcasecmp(s1->name, s2->name);
+				else
+					result = slab_activity(s1) < slab_activity(s2);
+			} else if (sort_loss) {
+				if (slab_waste(s1) == slab_waste(s2))
+					result = strcasecmp(s1->name, s2->name);
+				else
+					result = slab_waste(s1) < slab_waste(s2);
+			} else if (sort_partial) {
+				if (s1->partial == s2->partial)
+					result = strcasecmp(s1->name, s2->name);
+				else
+					result = s1->partial < s2->partial;
+			} else
 				result = strcasecmp(s1->name, s2->name);
 
 			if (show_inverted)
-- 
2.25.1

