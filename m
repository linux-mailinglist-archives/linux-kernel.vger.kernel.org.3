Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286A24DD59F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiCRH40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiCRH4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:56:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E501770B8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:55:04 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKbqK2NnmzfZ4G
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:53:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 15:55:02 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 15:55:02 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <patchwork@huawei.com>, <chenlifu@huawei.com>,
        <linux-kernel@vger.kernel.org>
CC:     <miaoxie@huawei.com>, <weiyongjun1@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <yuehaibing@huawei.com>, <rui.xiang@huawei.com>,
        <zhaohongjiang@huawei.com>, <johnny.chenyi@huawei.com>,
        <heying24@huawei.com>, <liaochang1@huawei.com>,
        <lizhengyu3@huawei.com>, <chenjiahao16@huawei.com>,
        <xuyihang@huawei.com>, <chris.zjh@huawei.com>,
        <linyujun809@huawei.com>
Subject: [PATCH -next] scripts: add compare-config utility
Date:   Fri, 18 Mar 2022 15:54:21 +0800
Message-ID: <20220318075421.606533-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an alternative utility to compare two Linux .config files.
Unlike existing utilities such as "diffconfig" in the Linux kernel tree,
it prints detailed results in table style. It is useful sometimes,
e.g. for those who need to analyze .config files through tables.

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 scripts/compare-config | 199 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)
 create mode 100755 scripts/compare-config

diff --git a/scripts/compare-config b/scripts/compare-config
new file mode 100755
index 000000000000..6da7c844b89c
--- /dev/null
+++ b/scripts/compare-config
@@ -0,0 +1,199 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# An utility to compare two .config files and print the results in table style.
+#
+
+import sys
+import argparse
+import traceback
+
+def args_parser():
+    comment = ("An utility to compare two .config files and "
+               "print the results in table style.")
+    parser = argparse.ArgumentParser(description = comment,
+                                     formatter_class =
+                                         argparse.RawTextHelpFormatter)
+    parser.add_argument(dest = "old_file", nargs = "?",
+                        metavar = "old-file",
+                        default = ".config.old",
+                        help = "specify old .config file "
+                               "(default: .config.old)")
+    parser.add_argument(dest = "new_file", nargs = "?",
+                        metavar = "new-file",
+                        default = ".config",
+                        help = "specify new .config file "
+                               "(default: .config)")
+    parser.add_argument("-S", dest = "S", action = "store_true",
+                        help = "print configs that exist in both files "
+                               "and are equal")
+    parser.add_argument("-C", dest = "C", action = "store_true",
+                        help = "print configs that exist in both files "
+                               "but are not equal")
+    parser.add_argument("-O", dest = "O", action = "store_true",
+                        help = "print configs that only exist in old-file")
+    parser.add_argument("-N", dest = "N", action = "store_true",
+                        help = "print configs that only exist in new-file")
+    parser.add_argument("-y", dest = "y", action = "store_true",
+                        help = "print configs that are y")
+    parser.add_argument("-n", dest = "n", action = "store_true",
+                        help = "print configs that are n (not set)")
+    parser.add_argument("-m", dest = "m", action = "store_true",
+                        help = "print configs that are m")
+    parser.add_argument("-v", dest = "v", action = "store_true",
+                        help = "print configs that are "
+                               "string/hex/int value")
+    parser.add_argument("--old", dest = "old", action = "store_true",
+                        help = "filter configs base on old-file")
+    parser.add_argument("--new", dest = "new", action = "store_true",
+                        help = "filter configs base on new-file")
+    return parser
+
+def usage():
+    args_parser().parse_args(["-h"])
+
+def parse_args():
+    args = args_parser().parse_args()
+    setattr(args, "doptions", diff_options(args))
+    setattr(args, "voptions", value_options(args))
+    old = args.old or not args.new
+    new = args.new or not args.old
+    args.old = old
+    args.new = new
+    return args
+
+def diff_options(args):
+    doptions = []
+    if args.S: doptions.append("S")
+    if args.C: doptions.append("C")
+    if args.O: doptions.append("O")
+    if args.N: doptions.append("N")
+    if len(doptions) == 0:
+        doptions = ["S", "C", "O", "N"]
+    return doptions
+
+def value_options(args):
+    voptions = set()
+    if args.y: voptions.add("y")
+    if args.n: voptions.add("n")
+    if args.m: voptions.add("m")
+    if args.v: voptions.add("v")
+    if len(voptions) == 0:
+        voptions = {"y", "n", "m", "v"}
+    return voptions
+
+def test_value(val, voptions):
+    if val is None: return False
+    if val in voptions: return True
+    return (not val in {"y", "n", "m"}) and ("v" in voptions)
+
+def format_exception():
+    es = ""
+    exc_type, exc_value, exc_traceback = sys.exc_info()
+    exc_str = traceback.format_exception(exc_type, exc_value, exc_traceback)
+    for s in exc_str:
+        es += s
+    return es
+
+def read_line(line):
+    prefix = "CONFIG_"
+    line = line.strip()
+    if line.startswith(prefix):
+        if line.find("=") == -1: return None, None
+        name, val = line.split("=", 1)
+        return name.strip(), val.strip()
+    if line.endswith(" is not set"):
+        beg = line.find(prefix)
+        if beg == -1: return None, None
+        name, val = line[beg:].split(" ", 1)
+        return name, "n"
+    return None, None
+
+def read_file(filename):
+    configs = {}
+    with open(filename, "r", encoding = "utf-8") as f:
+        for line in f:
+            name, val = read_line(line)
+            if not name is None: configs[name] = val
+    return configs
+
+def compare_files(old_file, new_file):
+    result = {"S": {}, "C": {}, "O": {}, "N": {}}
+    try:
+        old_configs = read_file(old_file)
+        new_configs = read_file(new_file)
+        while len(old_configs) > 0:
+            name, old_val = old_configs.popitem()
+            new_val = new_configs.pop(name, None)
+            if new_val is None:
+                result["O"][name] = (old_val, None)
+            elif old_val == new_val:
+                result["S"][name] = (old_val, new_val)
+            else:
+                result["C"][name] = (old_val, new_val)
+        while len(new_configs) > 0:
+            name, new_val = new_configs.popitem()
+            result["N"][name] = (None, new_val)
+    except:
+        print(format_exception())
+        usage()
+    return result
+
+def filter_output(result, args):
+    output = {"S": {}, "C": {}, "O": {}, "N": {}}
+    for opt in args.doptions:
+        for name, val in result[opt].items():
+            if (args.old and test_value(val[0], args.voptions) or
+                args.new and test_value(val[1], args.voptions)):
+                old_val = "-" if val[0] is None else val[0]
+                new_val = "-" if val[1] is None else val[1]
+                output[opt][name] = (old_val, new_val)
+    return output
+
+def print_table(output, args):
+    name_max_len = 8
+    old_max_len  = 8
+    new_max_len  = 8
+    name_list = sum([list(output[opt].keys()) for opt in args.doptions], [])
+    if len(name_list) > 0:
+        name_max_len = len(max(name_list, key = len))
+    val_list = sum([list(output[opt].values()) for opt in args.doptions], [])
+    if len(val_list) > 0:
+        old_max_len = len(max([val[0] for val in val_list], key = len))
+        new_max_len = len(max([val[1] for val in val_list], key = len))
+    diff_max_len = len(max([diff_types[opt] for opt in args.doptions], key = len))
+    header = ["NAME", "DIFF", "OLD", "NEW"]
+    # table row format
+    row = ("{{:{}}}\t{{:{}}}\t{{:{}}}\t{{:{}}}"
+           .format(min(max(name_max_len, len(header[0])), 40),
+                   min(max(diff_max_len, len(header[1])), 40),
+                   min(max(old_max_len,  len(header[2])), 40),
+                   min(max(new_max_len,  len(header[3])), 40)))
+    print(row.format(header[0], header[1], header[2], header[3]))
+    for opt in args.doptions:
+        for name, val in sorted(output[opt].items()):
+            print(row.format(name, diff_types[opt], val[0], val[1]))
+
+def print_summary(output, args):
+    diff_max_len = len(max([diff_types[opt] for opt in args.doptions], key = len))
+    # summary line format
+    line = "{{:{}}}: {{}}".format(max(diff_max_len, 8))
+    print("\nSummary:")
+    print(line.format("Old-file", args.old_file))
+    print(line.format("New-file", args.new_file))
+    total = 0
+    for opt in args.doptions:
+        count = len(output[opt])
+        print(line.format(diff_types[opt], count))
+        total += count
+    print(line.format("Total", total))
+
+def print_result(result, args):
+    output = filter_output(result, args)
+    print_table(output, args)
+    print_summary(output, args)
+
+diff_types = {"S": "Same", "C": "Changed", "O": "Old-only", "N": "New-only"}
+args = parse_args()
+result = compare_files(args.old_file, args.new_file)
+print_result(result, args)
-- 
2.35.1

