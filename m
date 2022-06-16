Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D7854DD3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359788AbiFPIq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359782AbiFPIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA0C5DBDD;
        Thu, 16 Jun 2022 01:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A77661D78;
        Thu, 16 Jun 2022 08:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFEAC341C0;
        Thu, 16 Jun 2022 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369147;
        bh=B88M7ZEwl68n7THj+esBYgDD9SubditJErT6VVWUfQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkX9227Bir4FoX04g6kzBhmp5jdkGgrgX6rjFTe8ZTYMldzqtQ68Eul3/syEMTteq
         WEoy4bSXDAgGWNN/GZTb2IfzC3oByQnFKrSwNsaexdAxpdI328UgdPhl2QQASYkbb5
         4Zm/9QE0oKJh83wEZa2aq5SNAy/hrSO91Jf3tHasOs8BLK+34fNbRKoEVGLnlxYrvE
         ETpNxXow+6JLZjD67Cz9Wj7BKEixmaazQLej7lxQ32boNS7wgNFn/SifmuqOVRbNP2
         OIIAOFpEzybFWY438p3fkzZ9I3eqpx2NP+HaAOBC3MbJlGqO7RAox/QWI1b1rDDM7e
         Fsv9bFGNP1siw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V4 07/20] tools/rv: Add dot2k
Date:   Thu, 16 Jun 2022 10:44:49 +0200
Message-Id: <ab7c58f8aa48f14db6f3352760808828ce3de96f.1655368610.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

transform .dot file into kernel rv monitor

usage: dot2k [-h] -d DOT_FILE -t MONITOR_TYPE [-n MODEL_NAME] [-D DESCRIPTION]

optional arguments:
  -h, --help            show this help message and exit
  -d DOT_FILE, --dot DOT_FILE
  -t MONITOR_TYPE, --monitor_type MONITOR_TYPE
  -n MODEL_NAME, --model_name MODEL_NAME
  -D DESCRIPTION, --description DESCRIPTION

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/verification/dot2/Makefile              |   5 +
 tools/verification/dot2/dot2k                 |  50 +++++
 tools/verification/dot2/dot2k.py              | 177 ++++++++++++++++++
 .../dot2/dot2k_templates/main_global.c        |  94 ++++++++++
 .../dot2/dot2k_templates/main_per_cpu.c       |  94 ++++++++++
 .../dot2/dot2k_templates/main_per_task.c      |  94 ++++++++++
 6 files changed, 514 insertions(+)
 create mode 100644 tools/verification/dot2/dot2k
 create mode 100644 tools/verification/dot2/dot2k.py
 create mode 100644 tools/verification/dot2/dot2k_templates/main_global.c
 create mode 100644 tools/verification/dot2/dot2k_templates/main_per_cpu.c
 create mode 100644 tools/verification/dot2/dot2k_templates/main_per_task.c

diff --git a/tools/verification/dot2/Makefile b/tools/verification/dot2/Makefile
index 235d182f6b2c..021beb07a521 100644
--- a/tools/verification/dot2/Makefile
+++ b/tools/verification/dot2/Makefile
@@ -19,3 +19,8 @@ install:
 	$(INSTALL) automata.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/automata.py
 	$(INSTALL) dot2c.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2c.py
 	$(INSTALL) dot2c -D -m 755 $(DESTDIR)$(bindir)/
+	$(INSTALL) dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2k.py
+	$(INSTALL) dot2k -D -m 755 $(DESTDIR)$(bindir)/
+
+	mkdir -p ${miscdir}/
+	cp -rp dot2k_templates $(DESTDIR)$(miscdir)/
diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
new file mode 100644
index 000000000000..6a35297e812e
--- /dev/null
+++ b/tools/verification/dot2/dot2k
@@ -0,0 +1,50 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# dot2k: transform dot files into a monitor for the Linux kernel.
+#
+# For more information, see:
+#   https://bristot.me/efficient-formal-verification-for-the-linux-kernel/
+#
+# Copyright 2018-2020 Red Hat, Inc.
+#
+# Author:
+#  Daniel Bristot de Oliveira <bristot@kernel.org>
+
+if __name__ == '__main__':
+    from dot2.dot2k import dot2k
+    import argparse
+    import ntpath
+    import os
+    import platform
+    import sys
+    import sys
+    import argparse
+
+    parser = argparse.ArgumentParser(description='transform .dot file into kernel rv monitor')
+    parser.add_argument('-d', "--dot", dest="dot_file", required=True)
+    parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=True)
+    parser.add_argument('-n', "--model_name", dest="model_name", required=False)
+    parser.add_argument("-D", "--description", dest="description", required=False)
+    params = parser.parse_args()
+
+    print("Opening and parsing the dot file %s" % params.dot_file)
+    try:
+        monitor=dot2k(params.dot_file, params.monitor_type)
+    except Exception as e:
+        print('Error: '+ str(e))
+        print("Sorry : :-(")
+        sys.exit(1)
+
+    # easier than using argparse action.
+    if params.model_name != None:
+        print(params.model_name)
+
+    print("Writing the monitor into the directory %s" % monitor.name)
+    monitor.print_files()
+    print("Almost done, checklist")
+    print("  - Edit the %s/%s.c to add the instrumentation" % (monitor.name, monitor.name))
+    print("  - Edit include/trace/events/rv.h to add the tracepoint entry")
+    print("  - Move it to the kernel's monitor directory")
+    print("  - Edit kernel/trace/rv/Makefile")
+    print("  - Edit kernel/trace/rv/Kconfig")
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
new file mode 100644
index 000000000000..230ad530b50c
--- /dev/null
+++ b/tools/verification/dot2/dot2k.py
@@ -0,0 +1,177 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# dot2k: transform dot files into a monitor for the Linux kernel.
+#
+# For more information, see:
+#   https://bristot.me/efficient-formal-verification-for-the-linux-kernel/
+#
+# Copyright 2018-2020 Red Hat, Inc.
+#
+# Author:
+#  Daniel Bristot de Oliveira <bristot@kernel.org>
+
+from dot2.dot2c import Dot2c
+import platform
+import os
+
+class dot2k(Dot2c):
+    monitor_types={ "global" : 1, "per_cpu" : 2, "per_task" : 3 }
+    monitor_templates_dir="dot2k/rv_templates/"
+    monitor_type="per_cpu"
+
+    def __init__(self, file_path, MonitorType):
+        super().__init__(file_path)
+
+        self.monitor_type=self.monitor_types.get(MonitorType)
+        if self.monitor_type == None:
+            raise Exception("Unknown monitor type: %s" % MonitorType)
+
+        self.monitor_type=MonitorType
+        self.__fill_rv_templates_dir()
+        self.main_c = self.__open_file(self.monitor_templates_dir + "main_" + MonitorType + ".c")
+        self.enum_suffix = "_%s" % self.name
+
+    def __fill_rv_templates_dir(self):
+
+        if os.path.exists(self.monitor_templates_dir) == True:
+            return
+
+        if platform.system() != "Linux":
+            raise Exception("I can only run on Linux.")
+
+        kernel_path="/lib/modules/%s/build/tools/rv/%s" % (platform.release(), self.monitor_templates_dir)
+
+        if os.path.exists(kernel_path) == True:
+            self.monitor_templates_dir=kernel_path
+            return
+
+        if os.path.exists("/usr/share/dot2/dot2k_templates/") == True:
+            self.monitor_templates_dir="/usr/share/dot2/dot2k_templates/"
+            return
+
+        raise Exception("Could not find the template directory, do you have the kernel source installed?")
+
+
+    def __open_file(self, path):
+        try:
+            fd = open(path)
+        except OSError:
+            raise Exception("Cannot open the file: %s" % path)
+
+        content = fd.read()
+
+        return content
+
+    def __buff_to_string(self, buff):
+        string=""
+
+        for line in buff:
+            string=string + line + "\n"
+
+        # cut off the last \n
+        return string[:-1]
+
+    def fill_monitor_h(self):
+        monitor_h = self.monitor_h
+
+        min_type=self.get_minimun_type()
+
+        monitor_h = monitor_h.replace("MIN_TYPE", min_type)
+
+        return monitor_h
+
+    def fill_tracepoint_handlers_skel(self):
+        buff=[]
+        for event in self.events:
+            buff.append("static void handle_%s(void *data, /* XXX: fill header */)" % event)
+            buff.append("{")
+            if self.monitor_type == "per_task":
+                buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;");
+                buff.append("\tda_handle_event_%s(p, %s%s);" % (self.name, event, self.enum_suffix));
+            else:
+                buff.append("\tda_handle_event_%s(%s%s);" % (self.name, event, self.enum_suffix));
+            buff.append("}")
+            buff.append("")
+        return self.__buff_to_string(buff)
+
+    def fill_tracepoint_attach_probe(self):
+        buff=[]
+        for event in self.events:
+            buff.append("\trv_attach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_%s);" % (self.name, event))
+        return self.__buff_to_string(buff)
+
+    def fill_tracepoint_detach_helper(self):
+        buff=[]
+        for event in self.events:
+            buff.append("\trv_detach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_%s);" % (self.name, event))
+        return self.__buff_to_string(buff)
+
+    def fill_main_c(self):
+        main_c = self.main_c
+        min_type=self.get_minimun_type()
+        nr_events=self.events.__len__()
+        tracepoint_handlers=self.fill_tracepoint_handlers_skel()
+        tracepoint_attach=self.fill_tracepoint_attach_probe()
+        tracepoint_detach=self.fill_tracepoint_detach_helper()
+
+        main_c = main_c.replace("MIN_TYPE", min_type)
+        main_c = main_c.replace("MODEL_NAME", self.name)
+        main_c = main_c.replace("NR_EVENTS", str(nr_events))
+        main_c = main_c.replace("TRACEPOINT_HANDLERS_SKEL", tracepoint_handlers)
+        main_c = main_c.replace("TRACEPOINT_ATTACH", tracepoint_attach)
+        main_c = main_c.replace("TRACEPOINT_DETACH", tracepoint_detach)
+
+        return main_c
+
+    def fill_model_h(self):
+        #
+        # Adjust the definition names
+        #
+        self.enum_states_def="states_%s" % self.name
+        self.enum_events_def="events_%s" % self.name
+        self.struct_automaton_def="automaton_%s" % self.name
+        self.var_automaton_def="automaton_%s" % self.name
+
+        buff=self.format_model()
+
+        return self.__buff_to_string(buff)
+
+    def __create_directory(self):
+        try:
+            os.mkdir(self.name)
+        except FileExistsError:
+            return
+        except:
+            print("Fail creating the output dir: %s" % self.name)
+
+    def __create_file(self, file_name, content):
+        path="%s/%s" % (self.name, file_name)
+        try:
+            file = open(path, 'w')
+        except FileExistsError:
+            return
+        except:
+            print("Fail creating file: %s" % path)
+
+        file.write(content)
+
+        file.close()
+
+    def __get_main_name(self):
+        path="%s/%s" % (self.name, "main.c")
+        if os.path.exists(path) == False:
+           return "main.c"
+        return "__main.c"
+
+    def print_files(self):
+        main_c=self.fill_main_c()
+        model_h=self.fill_model_h()
+
+        self.__create_directory()
+
+        path="%s.c" % self.name
+        self.__create_file(path, main_c)
+
+        path="%s.h" % self.name
+        self.__create_file(path, model_h)
diff --git a/tools/verification/dot2/dot2k_templates/main_global.c b/tools/verification/dot2/dot2k_templates/main_global.c
new file mode 100644
index 000000000000..913dc68d782d
--- /dev/null
+++ b/tools/verification/dot2/dot2k_templates/main_global.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+#include <rv/da_monitor.h>
+
+#define MODULE_NAME "MODEL_NAME"
+
+/*
+ * XXX: include required tracepoint headers, e.g.,
+ * #include <trace/events/sched.h>
+ */
+#include <trace/events/rv.h>
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no need
+ * to touch this section.
+ */
+#include "MODEL_NAME.h"
+
+/*
+ * Declare the deterministic automata monitor.
+ *
+ * The rv monitor reference is needed for the monitor declaration.
+ */
+struct rv_monitor rv_MODEL_NAME;
+DECLARE_DA_MON_GLOBAL(MODEL_NAME, MIN_TYPE);
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ *
+ */
+TRACEPOINT_HANDLERS_SKEL
+static int start_MODEL_NAME(void)
+{
+	int retval;
+
+	retval = da_monitor_init_MODEL_NAME();
+	if (retval)
+		return retval;
+
+TRACEPOINT_ATTACH
+
+	return 0;
+}
+
+static void stop_MODEL_NAME(void)
+{
+	rv_MODEL_NAME.enabled = 0;
+
+TRACEPOINT_DETACH
+
+	da_monitor_destroy_MODEL_NAME();
+}
+
+/*
+ * This is the monitor register section.
+ */
+struct rv_monitor rv_MODEL_NAME = {
+	.name = "MODEL_NAME",
+	.description = "auto-generated MODEL_NAME",
+	.start = start_MODEL_NAME,
+	.stop = stop_MODEL_NAME,
+	.reset = da_monitor_reset_all_MODEL_NAME,
+	.enabled = 0,
+};
+
+int register_MODEL_NAME(void)
+{
+	rv_register_monitor(&rv_MODEL_NAME);
+	return 0;
+}
+
+void unregister_MODEL_NAME(void)
+{
+	if (rv_MODEL_NAME.enabled)
+		stop_MODEL_NAME();
+
+	rv_unregister_monitor(&rv_MODEL_NAME);
+}
+
+module_init(register_MODEL_NAME);
+module_exit(unregister_MODEL_NAME);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("dot2k: auto-generated");
+MODULE_DESCRIPTION("MODEL_NAME");
diff --git a/tools/verification/dot2/dot2k_templates/main_per_cpu.c b/tools/verification/dot2/dot2k_templates/main_per_cpu.c
new file mode 100644
index 000000000000..95eac96d8951
--- /dev/null
+++ b/tools/verification/dot2/dot2k_templates/main_per_cpu.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+#include <rv/da_monitor.h>
+
+#define MODULE_NAME "MODEL_NAME"
+
+/*
+ * XXX: include required tracepoint headers, e.g.,
+ * #include <linux/trace/events/sched.h>
+ */
+#include <trace/events/rv.h>
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no need
+ * to touch this section.
+ */
+#include "MODEL_NAME.h"
+
+/*
+ * Declare the deterministic automata monitor.
+ *
+ * The rv monitor reference is needed for the monitor declaration.
+ */
+struct rv_monitor rv_MODEL_NAME;
+DECLARE_DA_MON_PER_CPU(MODEL_NAME, MIN_TYPE);
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ *
+ */
+TRACEPOINT_HANDLERS_SKEL
+static int start_MODEL_NAME(void)
+{
+	int retval;
+
+	retval = da_monitor_init_MODEL_NAME();
+	if (retval)
+		return retval;
+
+TRACEPOINT_ATTACH
+
+	return 0;
+}
+
+static void stop_MODEL_NAME(void)
+{
+	rv_MODEL_NAME.enabled = 0;
+
+TRACEPOINT_DETACH
+
+	da_monitor_destroy_MODEL_NAME();
+}
+
+/*
+ * This is the monitor register section.
+ */
+struct rv_monitor rv_MODEL_NAME = {
+	.name = "MODEL_NAME",
+	.description = "auto-generated MODEL_NAME",
+	.start = start_MODEL_NAME,
+	.stop = stop_MODEL_NAME,
+	.reset = da_monitor_reset_all_MODEL_NAME,
+	.enabled = 0,
+};
+
+int register_MODEL_NAME(void)
+{
+	rv_register_monitor(&rv_MODEL_NAME);
+	return 0;
+}
+
+void unregister_MODEL_NAME(void)
+{
+	if (rv_MODEL_NAME.enabled)
+		stop_MODEL_NAME();
+
+	rv_unregister_monitor(&rv_MODEL_NAME);
+}
+
+module_init(register_MODEL_NAME);
+module_exit(unregister_MODEL_NAME);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("dot2k: auto-generated");
+MODULE_DESCRIPTION("MODEL_NAME");
diff --git a/tools/verification/dot2/dot2k_templates/main_per_task.c b/tools/verification/dot2/dot2k_templates/main_per_task.c
new file mode 100644
index 000000000000..8bafb8c8a0a4
--- /dev/null
+++ b/tools/verification/dot2/dot2k_templates/main_per_task.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+#include <rv/da_monitor.h>
+
+#define MODULE_NAME "MODEL_NAME"
+
+/*
+ * XXX: include required tracepoint headers, e.g.,
+ * #include <linux/trace/events/sched.h>
+ */
+#include <trace/events/rv.h>
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no need
+ * to touch this section.
+ */
+#include "MODEL_NAME.h"
+
+/*
+ * Declare the deterministic automata monitor.
+ *
+ * The rv monitor reference is needed for the monitor declaration.
+ */
+struct rv_monitor rv_MODEL_NAME;
+DECLARE_DA_MON_PER_TASK(MODEL_NAME, MIN_TYPE);
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ *
+ */
+TRACEPOINT_HANDLERS_SKEL
+static int start_MODEL_NAME(void)
+{
+	int retval;
+
+	retval = da_monitor_init_MODEL_NAME();
+	if (retval)
+		return retval;
+
+TRACEPOINT_ATTACH
+
+	return 0;
+}
+
+static void stop_MODEL_NAME(void)
+{
+	rv_MODEL_NAME.enabled = 0;
+
+TRACEPOINT_DETACH
+
+	da_monitor_destroy_MODEL_NAME();
+}
+
+/*
+ * This is the monitor register section.
+ */
+struct rv_monitor rv_MODEL_NAME = {
+	.name = "MODEL_NAME",
+	.description = "auto-generated MODEL_NAME",
+	.start = start_MODEL_NAME,
+	.stop = stop_MODEL_NAME,
+	.reset = da_monitor_reset_all_MODEL_NAME,
+	.enabled = 0,
+};
+
+int register_MODEL_NAME(void)
+{
+	rv_register_monitor(&rv_MODEL_NAME);
+	return 0;
+}
+
+void unregister_MODEL_NAME(void)
+{
+	if (rv_MODEL_NAME.enabled)
+		stop_MODEL_NAME();
+
+	rv_unregister_monitor(&rv_MODEL_NAME);
+}
+
+module_init(register_MODEL_NAME);
+module_exit(unregister_MODEL_NAME);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("dot2k: auto-generated");
+MODULE_DESCRIPTION("MODEL_NAME");
-- 
2.35.1

