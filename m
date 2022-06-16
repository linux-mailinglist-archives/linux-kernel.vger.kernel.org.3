Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D825C54D9D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358922AbiFPFiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358727AbiFPFhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:37:43 -0400
X-Greylist: delayed 909 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 22:37:42 PDT
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3E913F6C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1655356942; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=CyY6ToycbNn+zWinEzZEs0D//LT/UQNM1yTp2rHMer0hwQN4tmWfTgqUFVSU4MPLcxr2BOKVwcGUZKUeSALbSOjoSWzAzd3CnTofuFRfuqvdLWTaVMyL3zypuzWUbe7/blkcbJXrre8wfvOkpkrpUel7mTxCsP6BbLy0KTbrbkM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1655356942; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=SPhGZ2firub1ZFNfQSqHRLLIpyGLrtsyXbIh15hT2/8=; 
        b=Ih+sj9oFQWGcYzm8swXT2KgK6YU4FGTN3NJjLn4f+r25gKboLVXBlm1sjL8l4biL+uAJ73m5sa9UKmnJHWfaYS8vZNFfmaLi6RwwjOaiNlsvcVDiwBKZg/c3NzQ08ZVCUi/o6G9LjmHKYGLVh7X7yYUPWMRjRtOM+gOiO1U5Jt0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 165535694023895.0045501776118; Wed, 15 Jun 2022 22:22:20 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:22:20 -0700
From:   Elijah Conners <business@elijahpepe.com>
To:     "acme" <acme@kernel.org>
Cc:     "peterz" <peterz@infradead.org>, "mingo" <mingo@redhat.com>,
        "linux-perf-users" <linux-perf-users@vger.kernel.org>,
        "jolsa" <jolsa@kernel.org>, "markrutland" <mark.rutland@arm.com>,
        "alexandershishkin" <alexander.shishkin@linux.intel.com>,
        "namhyung" <namhyung@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1816af65fb3.cadada251255317.8101049033080913987@elijahpepe.com>
In-Reply-To: 
Subject: [PATCH] scripts: use is None instead of == None
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In compaction-times.py, exported-sql-viewer.py, mem-phys-addr.py,
net_dropmonitor.py, kunit.py, and tdc.py, the None object is checked
against various variables using equality. This is 50% slower than using
an identity operator, since using equality invokes the __eq__ method.
Checking identity in this case is also much better form.

Signed-off-by: Elijah Conners <business@elijahpepe.com>
---
 tools/perf/scripts/python/compaction-times.py    | 2 +-
 tools/perf/scripts/python/exported-sql-viewer.py | 2 +-
 tools/perf/scripts/python/mem-phys-addr.py       | 2 +-
 tools/perf/scripts/python/net_dropmonitor.py     | 2 +-
 tools/testing/kunit/kunit.py                     | 2 +-
 tools/testing/selftests/tc-testing/tdc.py        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
index 2560a042dc6f..790cc58214a9 100644
--- a/tools/perf/scripts/python/compaction-times.py
+++ b/tools/perf/scripts/python/compaction-times.py
@@ -31,7 +31,7 @@ class comm_filter:
 
     def filter(self, pid, comm):
         m = self.re.search(comm)
-        return m == None or m.group() == ""
+        return m is None or m.group() == ""
 
 class pid_filter:
     def __init__(self, low, high):
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 13f2d8a81610..28b53739746f 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -452,7 +452,7 @@ class FindBar():
         index = self.textbox.currentIndex()
         data = self.textbox.itemData(index)
         # Store the pattern in the combo box to keep it with the text value
-        if data == None:
+        if data is None:
             self.textbox.setItemData(index, pattern)
         else:
             self.pattern.setChecked(data)
diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
index 1f332e72b9b0..5891a4df69aa 100644
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -95,6 +95,6 @@ def process_event(param_dict):
     phys_addr  = sample["phys_addr"]
 
     global event_name
-    if event_name == None:
+    if event_name is None:
         event_name = name
     load_mem_type_cnt[find_memory_type(phys_addr)] += 1
diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
index 101059971738..cd9488f11e03 100755
--- a/tools/perf/scripts/python/net_dropmonitor.py
+++ b/tools/perf/scripts/python/net_dropmonitor.py
@@ -55,7 +55,7 @@ def print_drop_table():
     print("%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT"))
     for i in drop_log.keys():
         (sym, off) = get_sym(i)
-        if sym == None:
+        if sym is None:
             sym = i
         print("%25s %25s %25s" % (sym, off, drop_log[i]))
 
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 9274c6355809..6195e091d22d 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -496,7 +496,7 @@ def main(argv, linux=None):
         if result.status != KunitStatus.SUCCESS:
             sys.exit(1)
     elif cli_args.subcommand == 'parse':
-        if cli_args.file == None:
+        if cli_args.file is None:
             sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
             kunit_output = sys.stdin
         else:
diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index ee22e3447ec7..f1840023283a 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -355,7 +355,7 @@ def test_runner(pm, args, filtered_tests):
         print('give test rig 2 seconds to stabilize')
     time.sleep(2)
     for tidx in testlist:
-        if "flower" in tidx["category"] and args.device == None:
+        if "flower" in tidx["category"] and args.device is None:
             errmsg = "Tests using the DEV2 variable must define the name of a "
             errmsg += "physical NIC with the -d option when running tdc.\n"
             errmsg += "Test has been skipped."
--
2.25.1
