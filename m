Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59635344D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 22:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345065AbiEYU1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344664AbiEYU0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:26:30 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E70222B3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:26:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653510387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2z4am8efPkBHe5K6q2zk3FpEuHSEHOPmz0WCK0OizBQ=;
        b=KxYU41M1OXMmX2HuaPpT7qSkyDYZYmKlwefzIQVV12iluYYz+L1bln0LfuxhLnu5cf6AaS
        bFjxReLGI0vBGAfEAqmaHvdLljifECRPj65nPjBj+ZH6nqTQk/RlTwFO+aoP5Wh3L6mBaJ
        YGvwgUL+51rhCCLNlERj7rCWFxyg41w=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v4 5/6] tools: add memcg_shrinker.py
Date:   Wed, 25 May 2022 13:25:59 -0700
Message-Id: <20220525202600.2910982-6-roman.gushchin@linux.dev>
In-Reply-To: <20220525202600.2910982-1-roman.gushchin@linux.dev>
References: <20220525202600.2910982-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple tool which prints a sorted list of shrinker lists
in the following format: (number of objects, shrinker name, cgroup).

Example:
  $ ./memcg_shrinker.py -n 10
  2090     sb-sysfs-26          /sys/fs/cgroup/system.slice
  1809     sb-sysfs-26          /sys/fs/cgroup/system.slice/systemd-udevd.service
  1044     sb-btrfs:vda2-24     /sys/fs/cgroup/system.slice/system-dbus\x2d:1.3\...
  861      sb-btrfs:vda2-24     /sys/fs/cgroup/system.slice/system-dbus\x2d:1.3\...
  804      sb-btrfs:vda2-24     /sys/fs/cgroup/system.slice
  643      sb-btrfs:vda2-24     /sys/fs/cgroup/system.slice/firewalld.service
  616      sb-cgroup2-30        /sys/fs/cgroup/init.scope
  275      sb-sysfs-26          /
  238      sb-proc-25           /sys/fs/cgroup/system.slice/systemd-journald.service
  225      sb-proc-25           /sys/fs/cgroup/system.slice/abrtd.service

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/cgroup/memcg_shrinker.py | 71 ++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100755 tools/cgroup/memcg_shrinker.py

diff --git a/tools/cgroup/memcg_shrinker.py b/tools/cgroup/memcg_shrinker.py
new file mode 100755
index 000000000000..706ab27666a4
--- /dev/null
+++ b/tools/cgroup/memcg_shrinker.py
@@ -0,0 +1,71 @@
+#!/usr/bin/env python3
+#
+# Copyright (C) 2022 Roman Gushchin <roman.gushchin@linux.dev>
+# Copyright (C) 2022 Meta
+
+import os
+import argparse
+import sys
+
+
+def scan_cgroups(cgroup_root):
+    cgroups = {}
+
+    for root, subdirs, _ in os.walk(cgroup_root):
+        for cgroup in subdirs:
+            path = os.path.join(root, cgroup)
+            ino = os.stat(path).st_ino
+            cgroups[ino] = path
+
+    # (memcg ino, path)
+    return cgroups
+
+
+def scan_shrinkers(shrinker_debugfs):
+    shrinkers = []
+
+    for root, subdirs, _ in os.walk(shrinker_debugfs):
+        for shrinker in subdirs:
+            count_path = os.path.join(root, shrinker, "count")
+            with open(count_path) as f:
+                for line in f.readlines():
+                    items = line.split(' ')
+                    ino = int(items[0])
+                    # (count, shrinker, memcg ino)
+                    shrinkers.append((int(items[1]), shrinker, ino))
+    return shrinkers
+
+
+def main():
+    parser = argparse.ArgumentParser(description='Display biggest shrinkers')
+    parser.add_argument('-n', '--lines', type=int, help='Number of lines to print')
+
+    args = parser.parse_args()
+
+    cgroups = scan_cgroups("/sys/fs/cgroup/")
+    shrinkers = scan_shrinkers("/sys/kernel/debug/shrinker/")
+    shrinkers = sorted(shrinkers, reverse = True, key = lambda x: x[0])
+
+    n = 0
+    for s in shrinkers:
+        count, name, ino = (s[0], s[1], s[2])
+        if count == 0:
+            break
+
+        if ino == 0 or ino == 1:
+            cg = "/"
+        else:
+            try:
+                cg = cgroups[ino]
+            except KeyError:
+                cg = "unknown (%d)" % ino
+
+        print("%-8s %-20s %s" % (count, name, cg))
+
+        n += 1
+        if args.lines and n >= args.lines:
+            break
+
+
+if __name__ == '__main__':
+    main()
-- 
2.35.3

