Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574464F4CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580568AbiDEXef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbiDEMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:45:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4E52611E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:48:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1079C1F745;
        Tue,  5 Apr 2022 11:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649159324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FG5W+X6iauWFlicsUD/KFyqhn8yb4pSpN2a+NvHudUE=;
        b=U+sas9du3g1kGret/F44LxtQJ9gs5N95bX2kvPi+VTiTK5WxnIBohb43yoKrqojPmNWGy1
        fuSEsvxN3kVlKJssR0JWHyLEUdciVUpPSmWHH0P0v5nkYidRj50rvmG79EsdXgCXjJv+0F
        5muU73su1r/MZR1LNkD2GBsQqPSnDUA=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id 74F23A3BA6;
        Tue,  5 Apr 2022 11:48:43 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] printk/index: Printk index feature documentation
Date:   Tue,  5 Apr 2022 13:48:29 +0200
Message-Id: <20220405114829.31837-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
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

Document the printk index feature. The primary motivation is to
explain that it is not creating KABI from particular printk() calls.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
Changes against RFC[*]:

  + Updated text by feedback from Darrick.
  + Updated index.rst and MAINTAINERS.
  + Tested build of the html documentation.

Did not add Sergey's ack because there were some changes.

[*] https://lore.kernel.org/r/20220330145955.GB4384@pathway.suse.cz

 Documentation/core-api/index.rst        |   1 +
 Documentation/core-api/printk-index.rst | 136 ++++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 3 files changed, 138 insertions(+)
 create mode 100644 Documentation/core-api/printk-index.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 972d46a5ddf6..8a3fce1fe582 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -20,6 +20,7 @@ it.
    workqueue
    printk-basics
    printk-formats
+   printk-index
    symbol-namespaces
 
 Data structures and low-level utilities
diff --git a/Documentation/core-api/printk-index.rst b/Documentation/core-api/printk-index.rst
new file mode 100644
index 000000000000..0de380b4a67c
--- /dev/null
+++ b/Documentation/core-api/printk-index.rst
@@ -0,0 +1,136 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+Printk Index
+============
+
+There are many ways how to monitor the state of the system. One important
+source of information is the system log. It provides a lot of information,
+including more or less important warnings and error messages.
+
+There are monitoring tools that filter and take action based on messages
+logged.
+
+The kernel messages are evolving together with the code. As a result,
+particular kernel messages are not KABI and never will be!
+
+It is a huge challenge for maintaining the system log monitors. It requires
+knowing what messages were updated in a particular kernel version and why.
+Finding these changes in the sources would require non-trivial parsers.
+Also it would require matching the sources with the binary kernel which
+is not always trivial. Various changes might be backported. Various kernel
+versions might be used on different monitored systems.
+
+This is where the printk index feature might become useful. It provides
+a dump of printk formats used all over the source code used for the kernel
+and modules on the running system. It is accessible at runtime via debugfs.
+
+The printk index helps to find changes in the message formats. Also it helps
+to track the strings back to the kernel sources and the related commit.
+
+
+User Interface
+==============
+
+The index of printk formats are split in into separate files. The files are
+named according to the binaries where the printk formats are built-in. There
+is always "vmlinux" and optionally also modules, for example::
+
+   /sys/kernel/debug/printk/index/vmlinux
+   /sys/kernel/debug/printk/index/ext4
+   /sys/kernel/debug/printk/index/scsi_mod
+
+Note that only loaded modules are shown. Also printk formats from a module
+might appear in "vmlinux" when the module is built-in.
+
+The content is inspired by the dynamic debug interface and looks like::
+
+   $> head -1 /sys/kernel/debug/printk/index/vmlinux; shuf -n 5 vmlinux
+   # <level[,flags]> filename:line function "format"
+   <5> block/blk-settings.c:661 disk_stack_limits "%s: Warning: Device %s is misaligned\n"
+   <4> kernel/trace/trace.c:8296 trace_create_file "Could not create tracefs '%s' entry\n"
+   <6> arch/x86/kernel/hpet.c:144 _hpet_print_config "hpet: %s(%d):\n"
+   <6> init/do_mounts.c:605 prepare_namespace "Waiting for root device %s...\n"
+   <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"
+
+, where the meaning is::
+
+   - level: log level
+   - flags: optional flags: currently only 'c' for KERN_CONT
+   - filename:line: source filename and line number of the related
+	printk() call. Note that there are many wrappers, for example,
+	pr_warn(), pr_warn_once(), dev_warn().
+   - function: function name where the printk() call is used.
+   - format: format string
+
+The extra information makes it a bit harder to find differences
+between various kernels. Especially the line number might change
+very often. On the other hand, it helps a lot to confirm that
+it is the same string or find the commit that is responsible
+for eventual changes.
+
+
+printk() Is Not a Stable KABI
+=============================
+
+Several developers are afraid that exporting all these implementation
+details into the user space will transform particular printk() calls
+into KABI.
+
+But it is exactly the opposite. printk() calls must _not_ be KABI.
+And the printk index helps user space tools to deal with this.
+
+
+Subsystem specific printk wrappers
+==================================
+
+The printk index is generated using extra metadata that are stored in
+a dedicated .elf section ".printk_index". It is achieved using macro
+wrappers doing __printk_index_emit() together with the real printk()
+call. The same technique is used also for the metadata used by
+the dynamic debug feature.
+
+The metadata are stored for a particular message only when it is printed
+using these special wrappers. It is implemented for the commonly
+used printk() calls, including, for example, pr_warn(), or pr_once().
+
+Additional changes are necessary for various subsystem specific wrappers
+that call the original printk() via a common helper function. These needs
+their own wrappers adding __printk_index_emit().
+
+Only few subsystem specific wrappers have been updated so far,
+for example, dev_printk(). As a result, the printk formats from
+some subsystes can be missing in the printk index.
+
+
+Subsystem specific prefix
+=========================
+
+The macro pr_fmt() macro allows to define a prefix that is printed
+before the string generated by the related printk() calls.
+
+Subsystem specific wrappers usually add even more complicated
+prefixes.
+
+These prefixes can be stored into the printk index metadata
+by an optional parameter of __printk_index_emit(). The debugfs
+interface might then show the printk formats including these prefixes.
+For example, drivers/acpi/osl.c contains::
+
+  #define pr_fmt(fmt) "ACPI: OSL: " fmt
+
+  static int __init acpi_no_auto_serialize_setup(char *str)
+  {
+	acpi_gbl_auto_serialize_methods = FALSE;
+	pr_info("Auto-serialization disabled\n");
+
+	return 1;
+  }
+
+This results in the following printk index entry::
+
+  <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"
+
+It helps matching messages from the real log with printk index.
+Then the source file name, line number, and function name can
+be used to match the string with the source code.
diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..ad8625130ea9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15855,6 +15855,7 @@ F:	kernel/printk/
 PRINTK INDEXING
 R:	Chris Down <chris@chrisdown.name>
 S:	Maintained
+F:	Documentation/core-api/printk-index.rst
 F:	kernel/printk/index.c
 
 PROC FILESYSTEM
-- 
2.26.2

