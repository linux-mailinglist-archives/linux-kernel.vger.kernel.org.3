Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB7352820C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbiEPK2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiEPK1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:27:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C34F11C2D;
        Mon, 16 May 2022 03:27:31 -0700 (PDT)
Message-ID: <20220516102615.709125683@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652696849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TbVp2Z3JVdRR2wBH415NWLfbZybxBrBGYeL5p28FLAc=;
        b=Udg+eUPUYk3CE6B6gEMRGeJgOB6rugVJ92qIU0WeuNb3sIqVBcr3qqRDqwC29kRi3ZxBRc
        NECt4KNoUbnCp8Otyke3u6/Y6ONyIS8CBwKDELwQGpv0Nrk1xwukoAVtyiatgwfPSThBoE
        Y6Fhib7GKxWNS345qQaurUaDGJrr3J5Rz6gT2CzDDGQNKHL6AWn96J7BZ3uQjgsobNjeht
        3GgZz/mYlvJC6DJxvfpzR/T/5MHBQAABPNNKSkEocWNY0kPa5Uv5rzzHYyXABz7y9K9TgU
        J/om7+1kNOK0bc2vuK0y87fhBSLTr24z7/FNQ7BxfIAV9sOKaeMdQQ1AhpeIcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652696849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TbVp2Z3JVdRR2wBH415NWLfbZybxBrBGYeL5p28FLAc=;
        b=KxQtQHEi/A9n9qNkb6aVTyQUevLP8tmnIUCxbaJPzEoCAl+bmlXBVIRRctAvU2J92iEpSR
        I1/WNuNDAwKWBaAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch 5/9] scripts/spdxcheck: Put excluded files and directories
 into a separate file
References: <20220516101901.475557433@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 May 2022 12:27:29 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files and directories which are excluded from scanning are currently
hard coded in the script. That's not maintainable and not accessible for
external tools.

Move the files and directories which should be excluded into a file.  The
default file is scripts/spdxexclude. This can be overridden with the
'-e $FILE' command line option.

The file format and syntax is similar to the .gitignore file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/spdxcheck.py |   70 ++++++++++++++++++++++++++++++++++++++++++++++-----
 scripts/spdxexclude  |    8 +++++
 2 files changed, 72 insertions(+), 6 deletions(-)

--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -6,6 +6,7 @@ from argparse import ArgumentParser
 from ply import lex, yacc
 import locale
 import traceback
+import fnmatch
 import sys
 import git
 import re
@@ -106,6 +107,7 @@ import os
         self.parser = yacc.yacc(module = self, write_tables = False, debug = False)
         self.lines_checked = 0
         self.checked = 0
+        self.excluded = 0
         self.spdx_valid = 0
         self.spdx_errors = 0
         self.spdx_dirs = {}
@@ -254,17 +256,47 @@ import os
         di.update(fname, base, fail)
         self.spdx_dirs[base] = di
 
+class pattern(object):
+    def __init__(self, line):
+        self.pattern = line
+        self.match = self.match_file
+        if line == '.*':
+            self.match = self.match_dot
+        elif line.endswith('/'):
+            self.pattern = line[:-1]
+            self.match = self.match_dir
+        elif line.startswith('/'):
+            self.pattern = line[1:]
+            self.match = self.match_fn
+
+    def match_dot(self, fpath):
+        return os.path.basename(fpath).startswith('.')
+
+    def match_file(self, fpath):
+        return os.path.basename(fpath) == self.pattern
+
+    def match_fn(self, fpath):
+        return fnmatch.fnmatchcase(fpath, self.pattern)
+
+    def match_dir(self, fpath):
+        if self.match_fn(os.path.dirname(fpath)):
+            return True
+        return fpath.startswith(self.pattern)
+
+def exclude_file(fpath):
+    for rule in exclude_rules:
+        if rule.match(fpath):
+            return True
+    return False
+
 def scan_git_tree(tree, basedir, dirdepth):
     parser.set_dirinfo(basedir, dirdepth)
     for el in tree.traverse():
-        # Exclude stuff which would make pointless noise
-        # FIXME: Put this somewhere more sensible
-        if el.path.startswith("LICENSES"):
-            continue
-        if el.path.find("license-rules.rst") >= 0:
-            continue
         if not os.path.isfile(el.path):
             continue
+        if exclude_file(el.path):
+            parser.excluded += 1
+            continue
         with open(el.path, 'rb') as fd:
             parser.parse_lines(fd, args.maxlines, el.path)
 
@@ -273,6 +305,20 @@ import os
         tree = tree[p]
     scan_git_tree(tree, path.strip('/'), dirdepth)
 
+def read_exclude_file(fname):
+    rules = []
+    if not fname:
+        return rules
+    with open(fname) as fd:
+        for line in fd:
+            line = line.strip()
+            if line.startswith('#'):
+                continue
+            if not len(line):
+                continue
+            rules.append(pattern(line))
+    return rules
+
 if __name__ == '__main__':
 
     ap = ArgumentParser(description='SPDX expression checker')
@@ -281,6 +327,8 @@ import os
                     help='Show [sub]directory statistics.')
     ap.add_argument('-D', '--depth', type=int, default=-1,
                     help='Directory depth for -d statistics. Default: unlimited')
+    ap.add_argument('-e', '--exclude',
+                    help='File containing file patterns to exclude. Default: scripts/spdxexclude')
     ap.add_argument('-f', '--files', action='store_true',
                     help='Show files without SPDX.')
     ap.add_argument('-m', '--maxlines', type=int, default=15,
@@ -317,6 +365,15 @@ import os
         sys.exit(1)
 
     try:
+        fname = args.exclude
+        if not fname:
+            fname = os.path.join(os.path.dirname(__file__), 'spdxexclude')
+        exclude_rules = read_exclude_file(fname)
+    except Exception as ex:
+        sys.stderr.write('FAIL: Reading exclude file %s: %s\n' %(fname, ex))
+        sys.exit(1)
+
+    try:
         if len(args.path) and args.path[0] == '-':
             stdin = os.fdopen(sys.stdin.fileno(), 'rb')
             parser.parse_lines(stdin, args.maxlines, '-')
@@ -349,6 +406,7 @@ import os
                 sys.stderr.write('License IDs        %12d\n' %len(spdx.licenses))
                 sys.stderr.write('Exception IDs      %12d\n' %len(spdx.exceptions))
                 sys.stderr.write('\n')
+                sys.stderr.write('Files excluded:    %12d\n' %parser.excluded)
                 sys.stderr.write('Files checked:     %12d\n' %parser.checked)
                 sys.stderr.write('Lines checked:     %12d\n' %parser.lines_checked)
                 if parser.checked:
--- /dev/null
+++ b/scripts/spdxexclude
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Patterns for excluding files and directories
+
+# Ignore the license directory and the licensing documentation which would
+# create lots of noise for no value
+LICENSES/
+license-rules.rst

