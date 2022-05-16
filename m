Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7458528207
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbiEPK1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiEPK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:27:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470B662F4;
        Mon, 16 May 2022 03:27:26 -0700 (PDT)
Message-ID: <20220516102615.536726051@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652696845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=j3Ex0Ow/KN+YBi2B26Hp2A14bYxb03Mt8DMY0lW7zmE=;
        b=2v6Qgw5cdY4aCQ9zxJM123Zw024PSKt6bxe/UQfT8wbl5CP1MD5s+3XtGCxo3iraFTy/hs
        Q9AuMEVr99Rh84X38DmWBpa27tSG50tEGFWGmAvuAjwrrpykF2+1+5MewB/qM3nUoYHx+d
        U0b4j0RreKPIA14A2Z/YqOJ9FLWBIk52sKtmZ6mVb1CKWDQ9k56HGT6YDcsHZXIWgyeqaW
        HL8PzUPHl6vgVpTyZ3BPdbnnHJQwRhryIOIqDQ2aKJyh1AHq7og2AKkQxw9+S2R5fXlLoc
        hEUf4oP+7brb+xoHWmIexJm4mkywO1st5SAPHPRNyiNw+I1gxGqFKxo33An3NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652696845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=j3Ex0Ow/KN+YBi2B26Hp2A14bYxb03Mt8DMY0lW7zmE=;
        b=3gJsHHYHwC3MsqT8GtwzAdywjIVZiM4FVu3oS29E5wfH88MEfiYgFDkqWlooFNqABp6nfy
        LoV//abVioj+RICg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch 2/9] scripts/spdxcheck: Add directory statistics
References: <20220516101901.475557433@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 May 2022 12:27:24 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better insights.

Directories accounted:     4646
Directories complete:      2565  55%

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/spdxcheck.py |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -28,6 +28,15 @@ import os
         self.licenses = [ ]
         self.exceptions = { }
 
+class dirinfo(object):
+    def __init__(self):
+        self.missing = 0
+        self.total = 0
+
+    def update(self, miss):
+        self.total += 1
+        self.missing += miss
+
 # Read the spdx data from the LICENSES directory
 def read_spdxdata(repo):
 
@@ -93,6 +102,7 @@ import os
         self.checked = 0
         self.spdx_valid = 0
         self.spdx_errors = 0
+        self.spdx_dirs = {}
         self.curline = 0
         self.deepest = 0
 
@@ -167,6 +177,7 @@ import os
     def parse_lines(self, fd, maxlines, fname):
         self.checked += 1
         self.curline = 0
+        fail = 1
         try:
             for line in fd:
                 line = line.decode(locale.getpreferredencoding(False), errors='ignore')
@@ -192,6 +203,7 @@ import os
                 # Should we check for more SPDX ids in the same file and
                 # complain if there are any?
                 #
+                fail = 0
                 break
 
         except ParserException as pe:
@@ -203,6 +215,11 @@ import os
                 sys.stdout.write('%s: %d:0 %s\n' %(fname, self.curline, pe.txt))
             self.spdx_errors += 1
 
+        base = os.path.dirname(fname)
+        di = self.spdx_dirs.get(base, dirinfo())
+        di.update(fail)
+        self.spdx_dirs[base] = di
+
 def scan_git_tree(tree):
     for el in tree.traverse():
         # Exclude stuff which would make pointless noise
@@ -289,6 +306,16 @@ import os
                     pc = int(100 * parser.spdx_valid / parser.checked)
                     sys.stderr.write('Files with SPDX:   %12d %3d%%\n' %(parser.spdx_valid, pc))
                 sys.stderr.write('Files with errors: %12d\n' %parser.spdx_errors)
+                ndirs = len(parser.spdx_dirs)
+                dirsok = 0
+                if ndirs:
+                    sys.stderr.write('\n')
+                    sys.stderr.write('Directories accounted: %8d\n' %ndirs)
+                    for di in parser.spdx_dirs.values():
+                        if not di.missing:
+                            dirsok += 1
+                    pc = int(100 * dirsok / ndirs)
+                    sys.stderr.write('Directories complete:  %8d %3d%%\n' %(dirsok, pc))
 
             sys.exit(0)
 

