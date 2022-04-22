Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672E750C167
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiDVVzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiDVVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:55:39 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70761E5F7A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650659237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIcEPpdyLCFHehrF6EjwfH/S8rR+FWD7FuLOrsoav4I=;
        b=LYCD2BdGVPfWh3NvaVHOatAgiYmQELzvA6f2uljVJALCl2Y667IjSVrZTJyc3jlXv2JbvP
        cWB6Ep+t9wpg1Z0UPJC0GseF1KAS7gyUNhXQzk0cduiOIY/y2Bl9n2FFqLQK/0hur4ikoy
        0GoBMKQXmj0q7nvZQYfJIFudeUnygSM=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 7/7] tools: add memcg_shrinker.py
Date:   Fri, 22 Apr 2022 13:26:44 -0700
Message-Id: <20220422202644.799732-8-roman.gushchin@linux.dev>
In-Reply-To: <20220422202644.799732-1-roman.gushchin@linux.dev>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple tool which prints a sorted list of shrinker lists
in the following format: (number of objects, shrinker name, cgroup).

Example:
  $ ./memcg_shrinker.py | head -n 10
    2092     sb-sysfs-26          /sys/fs/cgroup/system.slice
    1809     sb-sysfs-26          /sys/fs/cgroup/system.slice/systemd-udevd.service
    1350     sb-btrfs-24          /sys/fs/cgroup/system.slice
    1016     sb-btrfs-24          /sys/fs/cgroup/system.slice/system-dbus\x2d:1.3\x2dorg.fedoraproject.Setroubleshootd.slice
    861      sb-btrfs-24          /sys/fs/cgroup/system.slice/system-dbus\x2d:1.3\x2dorg.fedoraproject.SetroubleshootPrivileged.slice
    672      sb-btrfs-24          /sys/fs/cgroup/system.slice/firewalld.service
    655      sb-cgroup2-30        /sys/fs/cgroup/init.scope
    275      sb-sysfs-26          /
    232      sb-btrfs-24          /
    221      sb-proc-25           /sys/fs/cgroup/system.slice/systemd-journald.service

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/cgroup/memcg_shrinker.py | 70 ++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100755 tools/cgroup/memcg_shrinker.py

diff --git a/tools/cgroup/memcg_shrinker.py b/tools/cgroup/memcg_shrinker.py
new file mode 100755
index 000000000000..9c32bf0247b2
--- /dev/null
+++ b/tools/cgroup/memcg_shrinker.py
@@ -0,0 +1,70 @@
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
+            count_memcg_path = os.path.join(root, shrinker, "count_memcg")
+            try:
+                with open(count_memcg_path) as f:
+                    for line in f.readlines():
+                        items = line.split(' ')
+                        ino = int(items[0])
+                        shrinkers.append((int(items[1]), shrinker, ino))
+            except FileNotFoundError:
+                count_path = os.path.join(root, shrinker, "count")
+                with open(count_path) as f:
+                    shrinkers.append((int(f.readline()), shrinker, 0))
+
+    # (count, shrinker, memcg ino)
+    return shrinkers
+
+
+def main():
+    cgroups = scan_cgroups("/sys/fs/cgroup/")
+    shrinkers = scan_shrinkers("/sys/kernel/debug/shrinker/")
+    shrinkers = sorted(shrinkers, reverse = True, key = lambda x: x[0])
+
+    for s in shrinkers:
+        count = s[0]
+        name = s[1]
+        ino = s[2]
+
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
+
+if __name__ == '__main__':
+    main()
-- 
2.35.1

