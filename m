Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C291F59059E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiHKRQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiHKRPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:15:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6871924945
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660237493; x=1691773493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6oRrpXV57AhHFylmsZ4bzcUSzGU82BEfHWqfj2j9qo=;
  b=RocOqBxIT+G+AxLtFqzbUOWCpHn7RjMlB8sdczM6XHDxqyS2X5Iq6hdq
   XS10XQ99p5ym1i6FAyzAhde+Oaec0RESpR/xKuQzofZIKxGBAMyNQOL+Y
   hffVxfXxJuRnjCCQjce8Q1OxgsEwTDuy7lvaTVOXhF0lULVmTSbbtM+Mn
   paTyybuZJqWkIuBRvjsJ5gh4FiUT5jDOc9j2nSiyL0vIEZ9A91cqswyYG
   7LWAoNlKD/mjdvbkL7bOLc4OpMTOlRvIHQkD9nDut4iU2b7zL2Oshc8TR
   8XEDkCbs7IrVgR1A/n76PVpfqIozoGDp3uh9SYtTpcVyCLhVAu/s6Os9C
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="290161827"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="290161827"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 10:04:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="602234632"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.35.150])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 10:04:33 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf tools: Tidy guest option documentation
Date:   Thu, 11 Aug 2022 20:04:11 +0300
Message-Id: <20220811170411.84154-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811170411.84154-1-adrian.hunter@intel.com>
References: <20220811170411.84154-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common guest options into include files. Use attribute substitution to
customize an example, using "[verse]" to define the block instead of a
"literal" block which does not permit substitution.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/guest-files.txt | 16 +++++++++++++
 tools/perf/Documentation/guestmount.txt  | 11 +++++++++
 tools/perf/Documentation/perf-inject.txt | 14 +++---------
 tools/perf/Documentation/perf-kvm.txt    | 25 ++++----------------
 tools/perf/Documentation/perf-script.txt | 29 +++---------------------
 5 files changed, 38 insertions(+), 57 deletions(-)
 create mode 100644 tools/perf/Documentation/guest-files.txt
 create mode 100644 tools/perf/Documentation/guestmount.txt

diff --git a/tools/perf/Documentation/guest-files.txt b/tools/perf/Documentation/guest-files.txt
new file mode 100644
index 000000000000..8cc0b092f996
--- /dev/null
+++ b/tools/perf/Documentation/guest-files.txt
@@ -0,0 +1,16 @@
+include::guestmount.txt[]
+
+--guestkallsyms=<path>::
+	Guest OS /proc/kallsyms file copy. perf reads it to get guest
+	kernel symbols. Users copy it out from guest OS.
+
+--guestmodules=<path>::
+	Guest OS /proc/modules file copy. perf reads it to get guest
+	kernel module information. Users copy it out from guest OS.
+
+--guestvmlinux=<path>::
+	Guest OS kernel vmlinux.
+
+--guest-code::
+	Indicate that guest code can be found in the hypervisor process,
+	which is a common case for KVM test programs.
diff --git a/tools/perf/Documentation/guestmount.txt b/tools/perf/Documentation/guestmount.txt
new file mode 100644
index 000000000000..6edf12363add
--- /dev/null
+++ b/tools/perf/Documentation/guestmount.txt
@@ -0,0 +1,11 @@
+--guestmount=<path>::
+	Guest OS root file system mount directory. Users mount guest OS
+	root directories under <path> by a specific filesystem access method,
+	typically, sshfs.
+	For example, start 2 guest OS, one's pid is 8888 and the other's is 9999:
+[verse]
+	$ mkdir \~/guestmount
+	$ cd \~/guestmount
+	$ sshfs -o allow_other,direct_io -p 5551 localhost:/ 8888/
+	$ sshfs -o allow_other,direct_io -p 5552 localhost:/ 9999/
+	$ perf {GMEXAMPLECMD} --guestmount=~/guestmount {GMEXAMPLESUBCMD}
diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index c741ca2107b1..ffc293fdf61d 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -102,17 +102,9 @@ include::itrace.txt[]
 	should be used, and also --buildid-all and --switch-events may be
 	useful.
 
---guestmount=<path>::
-	Guest OS root file system mount directory. Users mount guest OS
-	root directories under <path> by a specific filesystem access method,
-	typically, sshfs.
-	For example, start 2 guest OS, one's pid is 8888 and the other's is 9999:
-[verse]
-	$ mkdir \~/guestmount
-	$ cd \~/guestmount
-	$ sshfs -o allow_other,direct_io -p 5551 localhost:/ 8888/
-	$ sshfs -o allow_other,direct_io -p 5552 localhost:/ 9999/
-	$ perf inject --guestmount=~/guestmount
+:GMEXAMPLECMD: inject
+:GMEXAMPLESUBCMD:
+include::guestmount.txt[]
 
 SEE ALSO
 --------
diff --git a/tools/perf/Documentation/perf-kvm.txt b/tools/perf/Documentation/perf-kvm.txt
index 83c742adf86e..2ad3f5d9f72b 100644
--- a/tools/perf/Documentation/perf-kvm.txt
+++ b/tools/perf/Documentation/perf-kvm.txt
@@ -77,26 +77,11 @@ OPTIONS
         Collect host side performance profile.
 --guest::
         Collect guest side performance profile.
---guestmount=<path>::
-	Guest os root file system mount directory. Users mounts guest os
-        root directories under <path> by a specific filesystem access method,
-	typically, sshfs. For example, start 2 guest os. The one's pid is 8888
-	and the other's is 9999.
-        #mkdir ~/guestmount; cd ~/guestmount
-        #sshfs -o allow_other,direct_io -p 5551 localhost:/ 8888/
-        #sshfs -o allow_other,direct_io -p 5552 localhost:/ 9999/
-        #perf kvm --host --guest --guestmount=~/guestmount top
---guestkallsyms=<path>::
-        Guest os /proc/kallsyms file copy. 'perf' kvm' reads it to get guest
-	kernel symbols. Users copy it out from guest os.
---guestmodules=<path>::
-	Guest os /proc/modules file copy. 'perf' kvm' reads it to get guest
-	kernel module information. Users copy it out from guest os.
---guestvmlinux=<path>::
-	Guest os kernel vmlinux.
---guest-code::
-	Indicate that guest code can be found in the hypervisor process,
-	which is a common case for KVM test programs.
+
+:GMEXAMPLECMD: kvm --host --guest
+:GMEXAMPLESUBCMD: top
+include::guest-files.txt[]
+
 -v::
 --verbose::
 	Be more verbose (show counter open errors, etc).
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 48ee42a891b6..68e37de5fae4 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -487,29 +487,6 @@ include::itrace.txt[]
 	For itrace only show specified functions and their callees for
 	itrace. Multiple functions can be separated by comma.
 
---guestmount=<path>::
-	Guest OS root file system mount directory. Users mount guest OS
-	root directories under <path> by a specific filesystem access method,
-	typically, sshfs.
-	For example, start 2 guest OS, one's pid is 8888 and the other's is 9999:
-[verse]
-	$ mkdir \~/guestmount
-	$ cd \~/guestmount
-	$ sshfs -o allow_other,direct_io -p 5551 localhost:/ 8888/
-	$ sshfs -o allow_other,direct_io -p 5552 localhost:/ 9999/
-	$ perf script --guestmount=~/guestmount
-
---guestkallsyms=<path>::
-	Guest OS /proc/kallsyms file copy. perf reads it to get guest
-	kernel symbols. Users copy it out from guest OS.
-
---guestmodules=<path>::
-	Guest OS /proc/modules file copy. perf reads it to get guest
-	kernel module information. Users copy it out from guest OS.
-
---guestvmlinux=<path>::
-	Guest OS kernel vmlinux.
-
 --switch-on EVENT_NAME::
 	Only consider events after this event is found.
 
@@ -530,9 +507,9 @@ include::itrace.txt[]
 	The known limitations include exception handing such as
 	setjmp/longjmp will have calls/returns not match.
 
---guest-code::
-	Indicate that guest code can be found in the hypervisor process,
-	which is a common case for KVM test programs.
+:GMEXAMPLECMD: script
+:GMEXAMPLESUBCMD:
+include::guest-files.txt[]
 
 SEE ALSO
 --------
-- 
2.25.1

