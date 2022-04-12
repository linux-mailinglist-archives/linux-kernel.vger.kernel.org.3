Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A924FDA87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbiDLJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389288AbiDLJXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:23:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B80653E27
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:32:01 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KczPB3CKHzBsHk
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:27:42 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 16:31:59 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 16:31:59 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <chenlifu@huawei.com>
Subject: [PATCH v2 -next] scripts: add compare-config utility
Date:   Tue, 12 Apr 2022 16:30:57 +0800
Message-ID: <20220412083057.4101246-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

This is an alternative utility to compare two .config files. Unlike
existing utilities "diffconfig" in the kernel tree, it prints detailed
results in table style, and support config name prefix so that it can be
used elsewhere. It is useful sometimes, for example, to analyze .config files
through tables, or to compare Buildroot .config.

With grep and awk, it can print similar results like "diffconfg" as well.

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
Changes in v2:
- Add config name prefix support

 scripts/compare-config | 201 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)
 create mode 100755 scripts/compare-config

diff --git a/scripts/compare-config b/scripts/compare-config
new file mode 100755
index 000000000000..419843a11eda
--- /dev/null
+++ b/scripts/compare-config
@@ -0,0 +1,201 @@
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
+    parser.add_argument("-p", "--prefix", dest = "prefix",
+                        action = "store", default = "CONFIG_",
+                        help = "config name prefix (default: CONFIG_)")
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
+def read_line(line, prefix):
+    line = line.strip()
+    if line.endswith(" is not set"):
+        beg = line.find(prefix)
+        if beg == -1: return None, None
+        name, val = line[beg:-10].rsplit(" ", 1)
+        return name.strip(), "n"
+    if line.startswith(prefix):
+        if line.find("=") == -1: return None, None
+        name, val = line.split("=", 1)
+        return name.strip(), val.strip()
+    return None, None
+
+def read_file(filename, prefix):
+    configs = {}
+    with open(filename, "r", encoding = "utf-8") as f:
+        for line in f:
+            name, val = read_line(line, prefix)
+            if not name is None: configs[name] = val
+    return configs
+
+def compare_config(args):
+    result = {"S": {}, "C": {}, "O": {}, "N": {}}
+    try:
+        old_configs = read_file(args.old_file, args.prefix)
+        new_configs = read_file(args.new_file, args.prefix)
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
+result = compare_config(args)
+print_result(result, args)
-- 
2.35.1

