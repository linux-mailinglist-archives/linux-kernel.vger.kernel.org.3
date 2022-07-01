Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E75632A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiGALfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiGALfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:35:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB23814AE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:35:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBDBB1FD68;
        Fri,  1 Jul 2022 11:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656675315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JgxaIL96JwElgIYm05F9VRx8UX346YdBzHhZ9TJjvCA=;
        b=MtkpddmCc7KHZa3NECv35qv0US8GzxyNLjOcQ39r1I6Hi1G34/WTvlVggpakyB5IferJbK
        ZgYv7CnzoA5oHb2HsezAdtoiksbUmy7UtlNUsFa4FhdRjmBFSDolPyhsa2jVf0irZ53VDa
        qoligt3FnEny86LSRJ64f8r3F+XiPW4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9017C13484;
        Fri,  1 Jul 2022 11:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2p1iIPPbvmLiGAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 01 Jul 2022 11:35:15 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] scripts/bloat-o-meter: switch argument parsing to using argparse
Date:   Fri,  1 Jul 2022 14:35:12 +0300
Message-Id: <20220701113513.1938008-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will facilitate further extension to the arguments the script
takes. As an added benefit it also produces saner usage output, where
mutual exclusivity of the c|d|t parameters is clearly visible:

./scripts/bloat-o-meter  -h
usage: bloat-o-meter [-h] [-c | -d | -t] file1 file2

Simple script used to compare the symbol sizes of 2 object files

positional arguments:
  file1       First file to compare
  file2       Second file to compare

optional arguments:
  -h, --help  show this help message and exit
  -c          categorize output based on symbol type
  -d          Show delta of Data Section
  -t          Show delta of text Section

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 scripts/bloat-o-meter | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
index 4dd6a804ce41..2a360118710e 100755
--- a/scripts/bloat-o-meter
+++ b/scripts/bloat-o-meter
@@ -7,18 +7,20 @@
 # This software may be used and distributed according to the terms
 # of the GNU General Public License, incorporated herein by reference.
 
-import sys, os, re
+import sys, os, re, argparse
 from signal import signal, SIGPIPE, SIG_DFL
 
 signal(SIGPIPE, SIG_DFL)
 
-if len(sys.argv) < 3:
-    sys.stderr.write("usage: %s [option] file1 file2\n" % sys.argv[0])
-    sys.stderr.write("The options are:\n")
-    sys.stderr.write("-c	categorize output based on symbol type\n")
-    sys.stderr.write("-d	Show delta of Data Section\n")
-    sys.stderr.write("-t	Show delta of text Section\n")
-    sys.exit(-1)
+parser = argparse.ArgumentParser(description="Simple script used to compare the symbol sizes of 2 object files")
+group = parser.add_mutually_exclusive_group()
+group.add_argument('-c', help='categorize output based on symbol type', action='store_true')
+group.add_argument('-d', help='Show delta of Data Section', action='store_true')
+group.add_argument('-t', help='Show delta of text Section', action='store_true')
+parser.add_argument('file1', help='First file to compare')
+parser.add_argument('file2', help='Second file to compare')
+
+args = parser.parse_args()
 
 re_NUMBER = re.compile(r'\.[0-9]+')
 
@@ -77,9 +79,9 @@ re_NUMBER = re.compile(r'\.[0-9]+')
     delta.reverse()
     return grow, shrink, add, remove, up, down, delta, old, new, otot, ntot
 
-def print_result(symboltype, symbolformat, argc):
+def print_result(symboltype, symbolformat):
     grow, shrink, add, remove, up, down, delta, old, new, otot, ntot = \
-    calc(sys.argv[argc - 1], sys.argv[argc], symbolformat)
+    calc(args.file1, args.file2, symbolformat)
 
     print("add/remove: %s/%s grow/shrink: %s/%s up/down: %s/%s (%s)" % \
           (add, remove, grow, shrink, up, -down, up-down))
@@ -93,13 +95,13 @@ re_NUMBER = re.compile(r'\.[0-9]+')
         percent = 0
     print("Total: Before=%d, After=%d, chg %+.2f%%" % (otot, ntot, percent))
 
-if sys.argv[1] == "-c":
-    print_result("Function", "tT", 3)
-    print_result("Data", "dDbB", 3)
-    print_result("RO Data", "rR", 3)
-elif sys.argv[1] == "-d":
-    print_result("Data", "dDbBrR", 3)
-elif sys.argv[1] == "-t":
-    print_result("Function", "tT", 3)
+if args.c:
+    print_result("Function", "tT")
+    print_result("Data", "dDbB")
+    print_result("RO Data", "rR")
+elif args.d:
+    print_result("Data", "dDbBrR")
+elif args.t:
+    print_result("Function", "tT")
 else:
-    print_result("Function", "tTdDbBrR", 2)
+    print_result("Function", "tTdDbBrR")
-- 
2.25.1

