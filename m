Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6BA528211
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbiEPK1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238343AbiEPK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:27:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46DDF1D;
        Mon, 16 May 2022 03:27:29 -0700 (PDT)
Message-ID: <20220516102615.651153597@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652696848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=G8D+w9l5Lss27nCE3t4mlITpiDy4X9kzTzFB0OULnRM=;
        b=zjys7jPcbR63XH5SkdtFuVf5Ch/I9Z+TOamn2Ub+6z70KBO5nUOhFIwt/0eR3jEA3dltRB
        71HNhyKXxCymJaUfaqUtvDjVSN9hKkEnWIKZprL7lw9pLTN0iGtDbL3AA2rRIabliAV05u
        rain+VAi2uDA9oB1GA+Z0FRfwcKFjTG/2UzXuOm+pmXaY6rKpeudtymLLvRO0+2c1JTsVG
        AIgoliVwWZeR7X6tT4vh/dRcxI+8nxM5vDCGIClDdieTlc8Chdeh9lsauvVBk0SUyzA2XK
        K13OVBfZTIL7Q1DS0vhkBxLljczWDZVsgOpuKdtPKYqWRUd8Z6YqMcH7cl9vHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652696848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=G8D+w9l5Lss27nCE3t4mlITpiDy4X9kzTzFB0OULnRM=;
        b=hYN7QVgm84WdviV6EHqfWLd2za/odVH6senXYTQUIcol73T/3oyNCWyqNXsS3YXPrIzLrw
        vSxQcYM9bdrpDdCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch 4/9] scripts/spdxcheck: Add option to display files without SPDX
References: <20220516101901.475557433@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 May 2022 12:27:27 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes life easier when chasing the missing ones. Is activated with '-f'
on the command line.

# scripts/spdxcheck.py -f kernel/
Files without SPDX:
    ./kernel/cpu.c
    ./kernel/kmod.c
    ./kernel/relay.c
    ./kernel/bpf/offload.c
    ./kernel/bpf/preload/.gitignore
    ./kernel/bpf/preload/iterators/README
    ./kernel/bpf/ringbuf.c
    ./kernel/cgroup/cgroup.c
    ./kernel/cgroup/cpuset.c
    ./kernel/cgroup/legacy_freezer.c
    ./kernel/debug/debug_core.h
    ./kernel/debug/kdb/Makefile
    ./kernel/debug/kdb/kdb_bp.c
    ./kernel/debug/kdb/kdb_bt.c
    ./kernel/debug/kdb/kdb_cmds
    ./kernel/debug/kdb/kdb_debugger.c
    ./kernel/debug/kdb/kdb_io.c
    ./kernel/debug/kdb/kdb_keyboard.c
    ./kernel/debug/kdb/kdb_main.c
    ./kernel/debug/kdb/kdb_private.h
    ./kernel/debug/kdb/kdb_support.c
    ./kernel/locking/lockdep_states.h
    ./kernel/locking/mutex-debug.c
    ./kernel/locking/spinlock_debug.c
    ./kernel/sched/pelt.h

With the optional -D parameter the directory depth can be limited:

# scripts/spdxcheck.py -f -D 0 kernel/
Files without SPDX:
    ./kernel/cpu.c
    ./kernel/kmod.c
    ./kernel/relay.c

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/spdxcheck.py |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -32,10 +32,16 @@ import os
     def __init__(self):
         self.missing = 0
         self.total = 0
+        self.files = []
 
-    def update(self, miss):
+    def update(self, fname, basedir, miss):
         self.total += 1
         self.missing += miss
+        if miss:
+            fname = './' + fname
+            bdir = os.path.dirname(fname)
+            if bdir == basedir.rstrip('/'):
+                self.files.append(fname)
 
 # Read the spdx data from the LICENSES directory
 def read_spdxdata(repo):
@@ -245,7 +251,7 @@ import os
         base += '/'
 
         di = self.spdx_dirs.get(base, dirinfo())
-        di.update(fail)
+        di.update(fname, base, fail)
         self.spdx_dirs[base] = di
 
 def scan_git_tree(tree, basedir, dirdepth):
@@ -275,6 +281,8 @@ import os
                     help='Show [sub]directory statistics.')
     ap.add_argument('-D', '--depth', type=int, default=-1,
                     help='Directory depth for -d statistics. Default: unlimited')
+    ap.add_argument('-f', '--files', action='store_true',
+                    help='Show files without SPDX.')
     ap.add_argument('-m', '--maxlines', type=int, default=15,
                     help='Maximum number of lines to scan in a file. Default 15')
     ap.add_argument('-v', '--verbose', action='store_true', help='Verbose statistics output')
@@ -364,6 +372,15 @@ import os
                         pc = int(100 * valid / di.total)
                         sys.stderr.write('    %-80s: %5d of %5d  %3d%%\n' %(f, valid, di.total, pc))
 
+            if ndirs and ndirs != dirsok and args.files:
+                if args.verbose or args.dirs:
+                    sys.stderr.write('\n')
+                sys.stderr.write('Files without SPDX:\n')
+                for f in sorted(parser.spdx_dirs.keys()):
+                    di = parser.spdx_dirs[f]
+                    for f in sorted(di.files):
+                        sys.stderr.write('    %s\n' %f)
+
             sys.exit(0)
 
     except Exception as ex:

