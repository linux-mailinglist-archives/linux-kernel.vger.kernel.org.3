Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929A650C1F0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiDVV5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiDVV4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:56:36 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5F1401D3C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:39:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650659234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzEsczHFMypgWq69vA44Rvu+DQROb38PPU7Epb/mgEc=;
        b=RtMUaM7EyQrxGmg8IItP71QZKXZdb8tz/qRajo2wxfWyBj3Xly3AgB2JjoyOFxQlSpBpP/
        DBiKUD+OXTZEd/XK0/AyW8LApJAJbzEb9b7PnWtstSodGl5lmeXJxcgDNmI6NOk3B2WodO
        WBJjlEwduMubPNKe+lpp4zXsUQmWtas=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 6/7] docs: document shrinker debugfs
Date:   Fri, 22 Apr 2022 13:26:43 -0700
Message-Id: <20220422202644.799732-7-roman.gushchin@linux.dev>
In-Reply-To: <20220422202644.799732-1-roman.gushchin@linux.dev>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a document describing the shrinker debugfs interface.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 Documentation/admin-guide/mm/index.rst        |  1 +
 .../admin-guide/mm/shrinker_debugfs.rst       | 90 +++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/shrinker_debugfs.rst

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index c21b5823f126..1bd11118dfb1 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -36,6 +36,7 @@ the Linux memory management.
    numa_memory_policy
    numaperf
    pagemap
+   shrinker_debugfs
    soft-dirty
    swap_numa
    transhuge
diff --git a/Documentation/admin-guide/mm/shrinker_debugfs.rst b/Documentation/admin-guide/mm/shrinker_debugfs.rst
new file mode 100644
index 000000000000..c2f3da534b70
--- /dev/null
+++ b/Documentation/admin-guide/mm/shrinker_debugfs.rst
@@ -0,0 +1,90 @@
+==========================
+Shrinker Debugfs Interface
+==========================
+
+Shrinker debugfs interface provides a visibility into the kernel memory
+shrinkers subsystem and allows to get statistics and interact with
+individual shrinkers.
+
+For each shrinker registered in the system a directory in <debugfs>/shrinker/
+is created. The directory is named like "kfree_rcu-0". Each name is composed
+from the shrinker's name and an unique id.
+
+Each shrinker directory contains "count" and "scan" files, which allow
+to trigger count_objects() and scan_objects() callbacks. For memcg-aware
+and numa-aware shrinkers count_memcg, scan_memcg, count_node, scan_node,
+count_memcg_node and scan_memcg_node are additionally provided. They allow
+to get per-memcg and/or per-node object count and shrink only a specific
+memcg/node.
+
+Usage examples:
+
+ 1. List registered shrinkers::
+      $ cd /sys/kernel/debug/shrinker/
+      $ ls
+      dqcache-16          sb-cgroup2-30    sb-hugetlbfs-33  sb-proc-41       sb-selinuxfs-22  sb-tmpfs-40    sb-zsmalloc-19
+      kfree_rcu-0         sb-configfs-23   sb-iomem-12      sb-proc-44       sb-sockfs-8      sb-tmpfs-42    shadow-18
+      sb-aio-20           sb-dax-11        sb-mqueue-21     sb-proc-45       sb-sysfs-26      sb-tmpfs-43    thp_deferred_split-10
+      sb-anon_inodefs-15  sb-debugfs-7     sb-nsfs-4        sb-proc-47       sb-tmpfs-1       sb-tmpfs-46    thp_zero-9
+      sb-bdev-3           sb-devpts-28     sb-pipefs-14     sb-pstore-31     sb-tmpfs-27      sb-tmpfs-49    xfs_buf-37
+      sb-bpf-32           sb-devtmpfs-5    sb-proc-25       sb-rootfs-2      sb-tmpfs-29      sb-tracefs-13  xfs_inodegc-38
+      sb-btrfs-24         sb-hugetlbfs-17  sb-proc-39       sb-securityfs-6  sb-tmpfs-35      sb-xfs-36      zspool-34
+
+ 2. Get information about a specific shrinker::
+      $ cd sb-btrfs-24/
+      $ ls
+      count  count_memcg  count_memcg_node  count_node  scan  scan_memcg  scan_memcg_node  scan_node
+
+ 3. Count objects on the system/root cgroup level::
+      $ cat count
+      212
+
+ 4. Count objects on the system/root cgroup level per numa node (on a 2-node machine)::
+      $ cat count_node
+      209 3
+
+ 5. Count objects for each memcg (output format: cgroup inode, count)::
+      $ cat count_memcg
+      1 212
+      20 96
+      53 817
+      2297 2
+      218 13
+      581 30
+      911 124
+      ...
+
+ 6. Same but with a per-node output::
+      $ cat count_memcg_node
+      1 209 3
+      20 96 0
+      53 810 7
+      2297 2 0
+      218 13 0
+      581 30 0
+      911 124 0
+      ...
+
+ 7. Scan system/root shrinker::
+      $ cat count
+      212
+      $ echo 100 > scan
+      $ cat scan
+      97
+      $ cat count
+      115
+
+ 8. Scan individual memcg::
+      $ echo "1868 500" > scan_memcg
+      $ cat scan_memcg
+      193
+
+ 9. Scan individual node::
+      $ echo "1 200" > scan_node
+      $ cat scan_node
+      2
+
+ 10. Scan individual memcg and node::
+     $ echo "1868 0 500" > scan_memcg_node
+     $ cat scan_memcg_node
+     435
-- 
2.35.1

