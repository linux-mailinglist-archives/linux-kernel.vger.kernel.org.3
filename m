Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5675344D2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 22:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiEYU0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 16:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245732AbiEYU03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:26:29 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7997B1CB14
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:26:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653510385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxW0mgchqVtBty8PpNYGf7pFW+VUKsCTUd+U5SS9e/M=;
        b=SYl+7tm86vDXCmiYPMiIwfaQII6cqg3o/xu9YA7Nv9JML0xZGTTT+L9QhX0EySqVDGw7E1
        mvxPGtvI+rhfDGyVVC3hOJ/SYMrqHD+KgQQkKf/JKX0euJsm1kAoS+BsFCyTrdqEgJI1jg
        Ncc52XX0lCKXxQxxKrBq8WCSQI+4pVY=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v4 4/6] mm: docs: document shrinker debugfs
Date:   Wed, 25 May 2022 13:25:58 -0700
Message-Id: <20220525202600.2910982-5-roman.gushchin@linux.dev>
In-Reply-To: <20220525202600.2910982-1-roman.gushchin@linux.dev>
References: <20220525202600.2910982-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a document describing the shrinker debugfs interface.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 Documentation/admin-guide/mm/index.rst        |   1 +
 .../admin-guide/mm/shrinker_debugfs.rst       | 100 ++++++++++++++++++
 2 files changed, 101 insertions(+)
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
index 000000000000..2033d696aa59
--- /dev/null
+++ b/Documentation/admin-guide/mm/shrinker_debugfs.rst
@@ -0,0 +1,100 @@
+.. _shrinker_debugfs:
+
+==========================
+Shrinker Debugfs Interface
+==========================
+
+Shrinker debugfs interface provides a visibility into the kernel memory
+shrinkers subsystem and allows to get information about individual shrinkers.
+
+For each shrinker registered in the system a directory in **<debugfs>/shrinker/**
+is created. The directory's name is composed from the shrinker's name and an
+unique id: e.g. *kfree_rcu-0* or *sb-xfs:vda1-36*.
+
+Each shrinker directory contains the **count** file, which allows to trigger
+the *count_objects()* callback for each memcg and numa node (if applicable).
+
+Usage:
+------
+
+1. *List registered shrinkers*
+
+  ::
+
+    $ cd /sys/kernel/debug/shrinker/
+    $ ls
+    dqcache-16          sb-hugetlbfs-17  sb-rootfs-2      sb-tmpfs-49
+    kfree_rcu-0         sb-hugetlbfs-33  sb-securityfs-6  sb-tracefs-13
+    sb-aio-20           sb-iomem-12      sb-selinuxfs-22  sb-xfs:vda1-36
+    sb-anon_inodefs-15  sb-mqueue-21     sb-sockfs-8      sb-zsmalloc-19
+    sb-bdev-3           sb-nsfs-4        sb-sysfs-26      shadow-18
+    sb-bpf-32           sb-pipefs-14     sb-tmpfs-1       thp_deferred_split-10
+    sb-btrfs:vda2-24    sb-proc-25       sb-tmpfs-27      thp_zero-9
+    sb-cgroup2-30       sb-proc-39       sb-tmpfs-29      xfs_buf-vda1-37
+    sb-configfs-23      sb-proc-41       sb-tmpfs-35      xfs_inodegc-vda1-38
+    sb-dax-11           sb-proc-45       sb-tmpfs-40      zspool-zram0-34
+    sb-debugfs-7        sb-proc-46       sb-tmpfs-42
+    sb-devpts-28        sb-proc-47       sb-tmpfs-43
+    sb-devtmpfs-5       sb-pstore-31     sb-tmpfs-44
+
+2. *Get information about a specific shrinker*
+
+  ::
+
+    $ cd sb-btrfs\:vda2-24/
+    $ ls
+    count
+
+3. *Count objects*
+
+  Each line in the output has the following format::
+
+    <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1> ...
+    <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1> ...
+    ...
+
+  If there are no objects on all numa nodes, a line is omitted. If there
+  are no objects at all, the output might be empty.
+  ::
+
+    $ cat count
+    1 224 2
+    21 98 0
+    55 818 10
+    2367 2 0
+    2401 30 0
+    225 13 0
+    599 35 0
+    939 124 0
+    1041 3 0
+    1075 1 0
+    1109 1 0
+    1279 60 0
+    1313 7 0
+    1347 39 0
+    1381 3 0
+    1449 14 0
+    1483 63 0
+    1517 53 0
+    1551 6 0
+    1585 1 0
+    1619 6 0
+    1653 40 0
+    1687 11 0
+    1721 8 0
+    1755 4 0
+    1789 52 0
+    1823 888 0
+    1857 1 0
+    1925 2 0
+    1959 32 0
+    2027 22 0
+    2061 9 0
+    2469 799 0
+    2537 861 0
+    2639 1 0
+    2707 70 0
+    2775 4 0
+    2877 84 0
+    293 1 0
+    735 8 0
-- 
2.35.3

