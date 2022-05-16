Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA994528209
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiEPK1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbiEPK13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:27:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088BBDEB7;
        Mon, 16 May 2022 03:27:28 -0700 (PDT)
Message-ID: <20220516102615.594443792@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652696846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iNfD7ykfCeiXZWxnwVI0kcPJ8rKUxOXEi0kWV1J+zM4=;
        b=rGpVlRju1ftE25hIYJfZ06jJR/T7hJmD1X2IfmShkBJ+HMto0QddQYuQDJNSIs3GS0OOQy
        SPQU/yZD/nRx9K5+6ardlffHmyhJTwcDnD2gm6H0wrmcQbnr3Y48scEbg90jEgyUb5f+Jp
        //oyoSkHQ7XKH/d2JLRLTmdnEg49ZKcR3GxFaGv1btQSCaSCHB+E2EijspcubfYZmWVivb
        wXtf0V/rpmF4Kf9Zj5xEAB6r32XZC+g0W/Vhnp/Zi7BWICmFbm6zQ3H+CI6CBdb7w8mZrs
        Ufg36QcmMWvK0aUtq7fN7t40yxnoABHck0LzZW38Qvlf4SuzXW26QVKFjNh2EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652696846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iNfD7ykfCeiXZWxnwVI0kcPJ8rKUxOXEi0kWV1J+zM4=;
        b=6ipFWcrz9+p0BHUwRmxLeKZlatXWiy9yKqNsG8geCT8feXiae1orzAPlzhtYx4LqDTE0fZ
        T6Ef69bi5jh6Y0BA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch 3/9] scripts/spdxcheck: Add [sub]directory statistics
References: <20220516101901.475557433@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 May 2022 12:27:26 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functionality to display [sub]directory statistics. This is enabled by
adding '-d' to the command line. The optional -D parameter allows to limit
the directory depth. If supplied the subdirectories are accumulated

# scripts/spdxcheck.py -d kernel/
Incomplete directories: SPDX in Files
    ./kernel                         :   111 of   114   97%
    ./kernel/bpf                     :    43 of    45   95%
    ./kernel/bpf/preload             :     4 of     5   80%
    ./kernel/bpf/preload/iterators   :     4 of     5   80%
    ./kernel/cgroup                  :    10 of    13   76%
    ./kernel/configs                 :     0 of     9    0%
    ./kernel/debug                   :     3 of     4   75%
    ./kernel/debug/kdb               :     1 of    11    9%
    ./kernel/locking                 :    29 of    32   90%
    ./kernel/sched                   :    38 of    39   97%

The result can be accumulated by restricting the depth via the new command
line option '-d $DEPTH':

# scripts/spdxcheck.py -d -D1
Incomplete directories: SPDX in Files
    ./                               :     6 of    13   46%
    ./Documentation                  :  4096 of  8451   48%
    ./arch                           : 13476 of 16402   82%
    ./block                          :   100 of   101   99%
    ./certs                          :    11 of    14   78%
    ./crypto                         :   145 of   176   82%
    ./drivers                        : 24682 of 30745   80%
    ./fs                             :  1876 of  2110   88%
    ./include                        :  5175 of  5757   89%
    ./ipc                            :    12 of    13   92%
    ./kernel                         :   493 of   527   93%
    ./lib                            :   393 of   524   75%
    ./mm                             :   151 of   159   94%
    ./net                            :  1713 of  1900   90%
    ./samples                        :   211 of   273   77%
    ./scripts                        :   341 of   435   78%
    ./security                       :   241 of   250   96%
    ./sound                          :  2438 of  2503   97%
    ./tools                          :  3810 of  5462   69%
    ./usr                            :     9 of    10   90%

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/spdxcheck.py |   67 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 10 deletions(-)

--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -103,9 +103,21 @@ import os
         self.spdx_valid = 0
         self.spdx_errors = 0
         self.spdx_dirs = {}
+        self.dirdepth = -1
+        self.basedir = '.'
         self.curline = 0
         self.deepest = 0
 
+    def set_dirinfo(self, basedir, dirdepth):
+        if dirdepth >= 0:
+            self.basedir = basedir
+            bdir = basedir.lstrip('./').rstrip('/')
+            if bdir != '':
+                parts = bdir.split('/')
+            else:
+                parts = []
+            self.dirdepth = dirdepth + len(parts)
+
     # Validate License and Exception IDs
     def validate(self, tok):
         id = tok.value.upper()
@@ -215,12 +227,29 @@ import os
                 sys.stdout.write('%s: %d:0 %s\n' %(fname, self.curline, pe.txt))
             self.spdx_errors += 1
 
+        if fname == '-':
+            return
+
         base = os.path.dirname(fname)
+        if self.dirdepth > 0:
+            parts = base.split('/')
+            i = 0
+            base = '.'
+            while i < self.dirdepth and i < len(parts) and len(parts[i]):
+                base += '/' + parts[i]
+                i += 1
+        elif self.dirdepth == 0:
+            base = self.basedir
+        else:
+            base = './' + base.rstrip('/')
+        base += '/'
+
         di = self.spdx_dirs.get(base, dirinfo())
         di.update(fail)
         self.spdx_dirs[base] = di
 
-def scan_git_tree(tree):
+def scan_git_tree(tree, basedir, dirdepth):
+    parser.set_dirinfo(basedir, dirdepth)
     for el in tree.traverse():
         # Exclude stuff which would make pointless noise
         # FIXME: Put this somewhere more sensible
@@ -233,15 +262,19 @@ import os
         with open(el.path, 'rb') as fd:
             parser.parse_lines(fd, args.maxlines, el.path)
 
-def scan_git_subtree(tree, path):
+def scan_git_subtree(tree, path, dirdepth):
     for p in path.strip('/').split('/'):
         tree = tree[p]
-    scan_git_tree(tree)
+    scan_git_tree(tree, path.strip('/'), dirdepth)
 
 if __name__ == '__main__':
 
     ap = ArgumentParser(description='SPDX expression checker')
     ap.add_argument('path', nargs='*', help='Check path or file. If not given full git tree scan. For stdin use "-"')
+    ap.add_argument('-d', '--dirs', action='store_true',
+                    help='Show [sub]directory statistics.')
+    ap.add_argument('-D', '--depth', type=int, default=-1,
+                    help='Directory depth for -d statistics. Default: unlimited')
     ap.add_argument('-m', '--maxlines', type=int, default=15,
                     help='Maximum number of lines to scan in a file. Default 15')
     ap.add_argument('-v', '--verbose', action='store_true', help='Verbose statistics output')
@@ -285,13 +318,21 @@ import os
                     if os.path.isfile(p):
                         parser.parse_lines(open(p, 'rb'), args.maxlines, p)
                     elif os.path.isdir(p):
-                        scan_git_subtree(repo.head.reference.commit.tree, p)
+                        scan_git_subtree(repo.head.reference.commit.tree, p,
+                                         args.depth)
                     else:
                         sys.stderr.write('path %s does not exist\n' %p)
                         sys.exit(1)
             else:
                 # Full git tree scan
-                scan_git_tree(repo.head.commit.tree)
+                scan_git_tree(repo.head.commit.tree, '.', args.depth)
+
+            ndirs = len(parser.spdx_dirs)
+            dirsok = 0
+            if ndirs:
+                for di in parser.spdx_dirs.values():
+                    if not di.missing:
+                        dirsok += 1
 
             if args.verbose:
                 sys.stderr.write('\n')
@@ -306,17 +347,23 @@ import os
                     pc = int(100 * parser.spdx_valid / parser.checked)
                     sys.stderr.write('Files with SPDX:   %12d %3d%%\n' %(parser.spdx_valid, pc))
                 sys.stderr.write('Files with errors: %12d\n' %parser.spdx_errors)
-                ndirs = len(parser.spdx_dirs)
-                dirsok = 0
                 if ndirs:
                     sys.stderr.write('\n')
                     sys.stderr.write('Directories accounted: %8d\n' %ndirs)
-                    for di in parser.spdx_dirs.values():
-                        if not di.missing:
-                            dirsok += 1
                     pc = int(100 * dirsok / ndirs)
                     sys.stderr.write('Directories complete:  %8d %3d%%\n' %(dirsok, pc))
 
+            if ndirs and ndirs != dirsok and args.dirs:
+                if args.verbose:
+                    sys.stderr.write('\n')
+                sys.stderr.write('Incomplete directories: SPDX in Files\n')
+                for f in sorted(parser.spdx_dirs.keys()):
+                    di = parser.spdx_dirs[f]
+                    if di.missing:
+                        valid = di.total - di.missing
+                        pc = int(100 * valid / di.total)
+                        sys.stderr.write('    %-80s: %5d of %5d  %3d%%\n' %(f, valid, di.total, pc))
+
             sys.exit(0)
 
     except Exception as ex:

