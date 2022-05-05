Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3B51C4B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355574AbiEEQLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381740AbiEEQLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:11:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E2C5C37E;
        Thu,  5 May 2022 09:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A152361DCE;
        Thu,  5 May 2022 16:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C37C385B1;
        Thu,  5 May 2022 16:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651766870;
        bh=RtaFjmrfGUYcp1hIg1se0MMZKZhQDCqvfo+iqNklTnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYpU1MLLTuXGaj15UebT17ipCV+h1DPLxzlttAs0TPKMe/+J+O/bi5iZR0P8eLxPu
         bRD3siTDR5Lso1q4+Mp8mjliUNxPrG7uWeLIEL1k1VMtZCgq0y/v2G8AZQJaO+sldp
         +sFTn+5I2QJsuhr5hIWHUFD5+xg7j/7fqMWLEmxyR4yK2qRsd6WVOfZTgyufkTlBk7
         5sLK8JVThtwdZUmMcDn5edAc6BnqbqDMzPRcjHaPSiPzzEoWvDetKpeRTU+L+FchDp
         SuffkU2BC7RNUOVaoDbHVqbNuAif9sEfsBB32E78JtaxKxSCxzKWKzSVqlpcNtA49K
         g5aFKfuFLzyAw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
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
        linux-doc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [RFC V3 07/20] tools/rv: Add dot2k
Date:   Thu,  5 May 2022 18:06:47 +0200
Message-Id: <a633f4fd45a2f1d26473a0ea7406ac7308b929bf.1651766361.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651766361.git.bristot@kernel.org>
References: <cover.1651766361.git.bristot@kernel.org>
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
 tools/tracing/rv/dot2/Makefile                |   5 +
 tools/tracing/rv/dot2/dot2k                   |  46 +++++
 tools/tracing/rv/dot2/dot2k.py                | 188 ++++++++++++++++++
 .../rv/dot2/dot2k_templates/main_global.c     |  97 +++++++++
 .../rv/dot2/dot2k_templates/main_global.h     |  64 ++++++
 .../rv/dot2/dot2k_templates/main_per_cpu.c    |  97 +++++++++
 .../rv/dot2/dot2k_templates/main_per_cpu.h    |  64 ++++++
 .../rv/dot2/dot2k_templates/main_per_task.c   |  97 +++++++++
 .../rv/dot2/dot2k_templates/main_per_task.h   |  70 +++++++
 9 files changed, 728 insertions(+)
 create mode 100644 tools/tracing/rv/dot2/dot2k
 create mode 100644 tools/tracing/rv/dot2/dot2k.py
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_global.c
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_global.h
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.c
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.h
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_task.c
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_task.h

diff --git a/tools/tracing/rv/dot2/Makefile b/tools/tracing/rv/dot2/Makefile
index 235d182f6b2c..021beb07a521 100644
--- a/tools/tracing/rv/dot2/Makefile
+++ b/tools/tracing/rv/dot2/Makefile
@@ -19,3 +19,8 @@ install:
 	$(INSTALL) automata.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/automata.py
 	$(INSTALL) dot2c.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2c.py
 	$(INSTALL) dot2c -D -m 755 $(DESTDIR)$(bindir)/
+	$(INSTALL) dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2k.py
+	$(INSTALL) dot2k -D -m 755 $(DESTDIR)$(bindir)/
+
+	mkdir -p ${miscdir}/
+	cp -rp dot2k_templates $(DESTDIR)$(miscdir)/
diff --git a/tools/tracing/rv/dot2/dot2k b/tools/tracing/rv/dot2/dot2k
new file mode 100644
index 000000000000..84c069164949
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k
@@ -0,0 +1,46 @@
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
+    print("Done, now edit the %s/%s.c to add the instrumentation" % (monitor.name, monitor.name))
+    print("Add a Makefile to compile it as a module, or follow the WWNR example in kernel source")
diff --git a/tools/tracing/rv/dot2/dot2k.py b/tools/tracing/rv/dot2/dot2k.py
new file mode 100644
index 000000000000..a5ab018c416c
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k.py
@@ -0,0 +1,188 @@
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
+        self.main_h = self.__open_file(self.monitor_templates_dir + "main_" + MonitorType + ".h")
+        self.main_c = self.__open_file(self.monitor_templates_dir + "main_" + MonitorType + ".c")
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
+                buff.append("\tda_handle_event_%s(p, %s);" % (self.name, event));
+            else:
+                buff.append("\tda_handle_event_%s(%s);" % (self.name, event));
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
+    def fill_main_h(self):
+        main_h = self.main_h
+        main_h = main_h.replace("MIN_TYPE", self.get_minimun_type())
+        main_h = main_h.replace("MODEL_NAME_BIG", self.name.upper())
+        main_h = main_h.replace("MODEL_NAME", self.name)
+
+        return main_h
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
+        main_h=self.fill_main_h()
+        main_c=self.fill_main_c()
+        model_h=self.fill_model_h()
+
+        self.__create_directory()
+
+        path="%s.h" % self.name
+        self.__create_file(path, main_h)
+
+        path="%s.c" % self.name
+        self.__create_file(path, main_c)
+
+        self.__create_file("model.h", model_h)
diff --git a/tools/tracing/rv/dot2/dot2k_templates/main_global.c b/tools/tracing/rv/dot2/dot2k_templates/main_global.c
new file mode 100644
index 000000000000..32fd866b81b1
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k_templates/main_global.c
@@ -0,0 +1,97 @@
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
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no need
+ * to touch this section.
+ */
+#include "model.h"
+
+/*
+ * Declare the deterministic automata monitor.
+ *
+ * The rv monitor reference is needed for the monitor declaration.
+ */
+struct rv_monitor rv_MODEL_NAME;
+DECLARE_DA_MON_GLOBAL(MODEL_NAME, MIN_TYPE);
+
+#define CREATE_TRACE_POINTS
+#include "MODEL_NAME.h"
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ *
+ */
+TRACEPOINT_HANDLERS_SKEL
+
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
diff --git a/tools/tracing/rv/dot2/dot2k_templates/main_global.h b/tools/tracing/rv/dot2/dot2k_templates/main_global.h
new file mode 100644
index 000000000000..d55cb8b83463
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k_templates/main_global.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rv
+
+#if !defined(_MODEL_NAME_BIG_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _MODEL_NAME_BIG_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(event_MODEL_NAME,
+
+	TP_PROTO(char state, char event, char next_state, bool safe),
+
+	TP_ARGS(state, event, next_state, safe),
+
+	TP_STRUCT__entry(
+		__field(	char,		state		)
+		__field(	char,		event		)
+		__field(	char,		next_state	)
+		__field(	bool,		safe		)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->event = event;
+		__entry->next_state = next_state;
+		__entry->safe = safe;
+	),
+
+	TP_printk("%s x %s -> %s %s",
+		model_get_state_name_MODEL_NAME(__entry->state),
+		model_get_event_name_MODEL_NAME(__entry->event),
+		model_get_state_name_MODEL_NAME(__entry->next_state),
+		__entry->safe ? "(safe)" : "")
+);
+
+TRACE_EVENT(error_MODEL_NAME,
+
+	TP_PROTO(char state, char event),
+
+	TP_ARGS(state, event),
+
+	TP_STRUCT__entry(
+		__field(	char,		state		)
+		__field(	char,		event		)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->event = event;
+	),
+
+	TP_printk("event %s not expected in the state %s",
+		model_get_event_name_MODEL_NAME(__entry->event),
+		model_get_state_name_MODEL_NAME(__entry->state))
+);
+
+#endif /* _MODEL_NAME_BIG_H */
+
+/* This part ust be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE MODEL_NAME
+#include <trace/define_trace.h>
diff --git a/tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.c b/tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.c
new file mode 100644
index 000000000000..6db83532af23
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.c
@@ -0,0 +1,97 @@
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
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no need
+ * to touch this section.
+ */
+#include "model.h"
+
+/*
+ * Declare the deterministic automata monitor.
+ *
+ * The rv monitor reference is needed for the monitor declaration.
+ */
+struct rv_monitor rv_MODEL_NAME;
+DECLARE_DA_MON_PER_CPU(MODEL_NAME, MIN_TYPE);
+
+#define CREATE_TRACE_POINTS
+#include "MODEL_NAME.h"
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ *
+ */
+TRACEPOINT_HANDLERS_SKEL
+
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
diff --git a/tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.h b/tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.h
new file mode 100644
index 000000000000..d55cb8b83463
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rv
+
+#if !defined(_MODEL_NAME_BIG_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _MODEL_NAME_BIG_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(event_MODEL_NAME,
+
+	TP_PROTO(char state, char event, char next_state, bool safe),
+
+	TP_ARGS(state, event, next_state, safe),
+
+	TP_STRUCT__entry(
+		__field(	char,		state		)
+		__field(	char,		event		)
+		__field(	char,		next_state	)
+		__field(	bool,		safe		)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->event = event;
+		__entry->next_state = next_state;
+		__entry->safe = safe;
+	),
+
+	TP_printk("%s x %s -> %s %s",
+		model_get_state_name_MODEL_NAME(__entry->state),
+		model_get_event_name_MODEL_NAME(__entry->event),
+		model_get_state_name_MODEL_NAME(__entry->next_state),
+		__entry->safe ? "(safe)" : "")
+);
+
+TRACE_EVENT(error_MODEL_NAME,
+
+	TP_PROTO(char state, char event),
+
+	TP_ARGS(state, event),
+
+	TP_STRUCT__entry(
+		__field(	char,		state		)
+		__field(	char,		event		)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->event = event;
+	),
+
+	TP_printk("event %s not expected in the state %s",
+		model_get_event_name_MODEL_NAME(__entry->event),
+		model_get_state_name_MODEL_NAME(__entry->state))
+);
+
+#endif /* _MODEL_NAME_BIG_H */
+
+/* This part ust be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE MODEL_NAME
+#include <trace/define_trace.h>
diff --git a/tools/tracing/rv/dot2/dot2k_templates/main_per_task.c b/tools/tracing/rv/dot2/dot2k_templates/main_per_task.c
new file mode 100644
index 000000000000..cd4b5c177487
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k_templates/main_per_task.c
@@ -0,0 +1,97 @@
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
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no need
+ * to touch this section.
+ */
+#include "model.h"
+
+/*
+ * Declare the deterministic automata monitor.
+ *
+ * The rv monitor reference is needed for the monitor declaration.
+ */
+struct rv_monitor rv_MODEL_NAME;
+DECLARE_DA_MON_PER_TASK(MODEL_NAME, MIN_TYPE);
+
+#define CREATE_TRACE_POINTS
+#include "MODEL_NAME.h"
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ *
+ */
+TRACEPOINT_HANDLERS_SKEL
+
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
diff --git a/tools/tracing/rv/dot2/dot2k_templates/main_per_task.h b/tools/tracing/rv/dot2/dot2k_templates/main_per_task.h
new file mode 100644
index 000000000000..55fb47265344
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k_templates/main_per_task.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rv
+
+#if !defined(_MODEL_NAME_BIG_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _MODEL_NAME_BIG_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(event_MODEL_NAME,
+
+	TP_PROTO(pid_t pid, MIN_TYPE state, MIN_TYPE event, MIN_TYPE next_state, bool safe),
+
+	TP_ARGS(pid, state, event, next_state, safe),
+
+	TP_STRUCT__entry(
+		__field(	pid_t,		pid		)
+		__field(	MIN_TYPE,		state		)
+		__field(	MIN_TYPE,		event		)
+		__field(	MIN_TYPE,		next_state	)
+		__field(	bool,		safe		)
+	),
+
+	TP_fast_assign(
+		__entry->pid = pid;
+		__entry->state = state;
+		__entry->event = event;
+		__entry->next_state = next_state;
+		__entry->safe = safe;
+	),
+
+	TP_printk("%d: %s x %s -> %s %s",
+		__entry->pid,
+		model_get_state_name_MODEL_NAME(__entry->state),
+		model_get_event_name_MODEL_NAME(__entry->event),
+		model_get_state_name_MODEL_NAME(__entry->next_state),
+		__entry->safe ? "(safe)" : "")
+);
+
+TRACE_EVENT(error_MODEL_NAME,
+
+	TP_PROTO(pid_t pid, MIN_TYPE state, MIN_TYPE event),
+
+	TP_ARGS(pid, state, event),
+
+	TP_STRUCT__entry(
+		__field(	pid_t,		pid		)
+		__field(	MIN_TYPE,		state		)
+		__field(	MIN_TYPE,		event		)
+	),
+
+	TP_fast_assign(
+		__entry->pid = pid;
+		__entry->state = state;
+		__entry->event = event;
+	),
+
+	TP_printk("%d event %s not expected in the state %s",
+		__entry->pid,
+		model_get_event_name_MODEL_NAME(__entry->event),
+		model_get_state_name_MODEL_NAME(__entry->state))
+);
+
+#endif /* _MODEL_NAME_BIG_H */
+
+/* This part ust be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE MODEL_NAME
+#include <trace/define_trace.h>
-- 
2.35.1

