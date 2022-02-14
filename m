Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0594B4EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351456AbiBNL2u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:28:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351468AbiBNL2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:28:35 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE6CB64C8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:07:01 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-rAk7EfuaM-GmxaBj1VVZFg-1; Mon, 14 Feb 2022 05:46:41 -0500
X-MC-Unique: rAk7EfuaM-GmxaBj1VVZFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7313C18B613D;
        Mon, 14 Feb 2022 10:46:39 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2B4C27BD1;
        Mon, 14 Feb 2022 10:46:34 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [RFC V2 06/21] tools/rv: Add dot2c
Date:   Mon, 14 Feb 2022 11:44:57 +0100
Message-Id: <647bdb3653b74f54b5656080b246a99d71d9b314.1644830251.git.bristot@kernel.org>
In-Reply-To: <cover.1644830251.git.bristot@kernel.org>
References: <cover.1644830251.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dot2c is a tool that transforms an automata in the graphiviz .dot file
into an C representation of the automata.

usage: dot2c [-h] dot_file

dot2c: converts a .dot file into a C structure

positional arguments:
  dot_file    The dot file to be converted

optional arguments:
  -h, --help  show this help message and exit

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
 tools/tracing/rv/dot2/Makefile    |  21 +++
 tools/tracing/rv/dot2/automata.py | 179 ++++++++++++++++++++++
 tools/tracing/rv/dot2/dot2c       |  30 ++++
 tools/tracing/rv/dot2/dot2c.py    | 240 ++++++++++++++++++++++++++++++
 4 files changed, 470 insertions(+)
 create mode 100644 tools/tracing/rv/dot2/Makefile
 create mode 100644 tools/tracing/rv/dot2/automata.py
 create mode 100644 tools/tracing/rv/dot2/dot2c
 create mode 100644 tools/tracing/rv/dot2/dot2c.py

diff --git a/tools/tracing/rv/dot2/Makefile b/tools/tracing/rv/dot2/Makefile
new file mode 100644
index 000000000000..9dd59ec8a733
--- /dev/null
+++ b/tools/tracing/rv/dot2/Makefile
@@ -0,0 +1,21 @@
+INSTALL=install
+
+prefix  ?= /usr
+bindir  ?= $(prefix)/bin
+mandir  ?= $(prefix)/share/man
+miscdir ?= $(prefix)/share/dot2
+srcdir  ?= $(prefix)/src
+
+PYLIB  ?= $(shell python3 -c 'import distutils.sysconfig;  print (distutils.sysconfig.get_python_lib())')
+
+.PHONY: all
+all:
+
+.PHONY: clean
+clean:
+
+.PHONY: install
+install:
+	$(INSTALL) automata.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/automata.py
+	$(INSTALL) dot2c.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2c.py
+	$(INSTALL) dot2c -D -m 755 $(DESTDIR)$(bindir)/
diff --git a/tools/tracing/rv/dot2/automata.py b/tools/tracing/rv/dot2/automata.py
new file mode 100644
index 000000000000..171ad4497983
--- /dev/null
+++ b/tools/tracing/rv/dot2/automata.py
@@ -0,0 +1,179 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# automata object: parse a dot file into a python object
+# For more information, see:
+#   https://bristot.me/efficient-formal-verification-for-the-linux-kernel/
+#
+# This program was written in the development of this paper:
+#  de Oliveira, D. B. and Cucinotta, T. and de Oliveira, R. S.
+#  "Efficient Formal Verification for the Linux Kernel." International
+#  Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
+#
+# Copyright 2018-2020 Red Hat, Inc.
+#
+# Author:
+#  Daniel Bristot de Oliveira <bristot@kernel.org>
+
+import ntpath
+
+class Automata:
+    """Automata class: Reads a dot file and part it as an automata.
+
+    Attributes:
+        dot_file: A dot file with an state_automaton definition.
+    """
+
+    def __init__(self, file_path):
+        self.__dot_path=file_path
+        self.name=self.__get_model_name()
+        self.__dot_lines = self.__open_dot()
+        self.states, self.initial_state, self.final_states = self.__get_state_variables()
+        self.events = self.__get_event_variables()
+        self.function = self.__create_matrix()
+
+    def __get_model_name(self):
+        basename=ntpath.basename(self.__dot_path)
+        if basename.endswith(".dot") == False:
+            print("not a dot file")
+            raise Exception("not a dot file: %s" % self.__dot_path)
+
+        model_name=basename[0:-4]
+        if model_name.__len__() == 0:
+            raise Exception("not a dot file: %s" % self.__dot_path)
+
+        return model_name
+
+    def __open_dot(self):
+        cursor = 0
+        dot_lines = []
+        try:
+            dot_file = open(self.__dot_path)
+        except:
+            raise Exception("Cannot open the file: %s" % self.__dot_path)
+
+        dot_lines = dot_file.read().splitlines()
+        dot_file.close()
+
+        # checking the first line:
+        line = dot_lines[cursor].split()
+
+        if (line[0] != "digraph") and (line[1] != "state_automaton"):
+            raise Exception("Not a valid .dot format: %s" % self.__dot_path)
+        else:
+            cursor = cursor + 1
+        return dot_lines
+
+    def __get_cursor_begin_states(self):
+        cursor = 0
+        while self.__dot_lines[cursor].split()[0] != "{node":
+            cursor += 1
+        return cursor
+
+    def __get_cursor_begin_events(self):
+        cursor = 0
+        while self.__dot_lines[cursor].split()[0] != "{node":
+           cursor += 1
+        while self.__dot_lines[cursor].split()[0] == "{node":
+            cursor += 1
+        # skip initial state transition
+        cursor += 1
+        return cursor
+
+    def __get_state_variables(self):
+        # wait for node declaration
+        states = []
+        final_states=[]
+
+        has_final_states = False
+        cursor = self.__get_cursor_begin_states()
+
+        # process nodes
+        while self.__dot_lines[cursor].split()[0] == "{node":
+            line = self.__dot_lines[cursor].split()
+            raw_state = line[-1]
+
+            #  "enabled_fired"}; -> enabled_fired
+            state = raw_state.replace('"', '').replace('};', '').replace(',','_')
+            if state[0:7] == "__init_":
+                initial_state = state[7:]
+            else:
+                states.append(state)
+                if self.__dot_lines[cursor].__contains__("doublecircle") == True:
+                    final_states.append(state)
+                    has_final_states = True
+
+                if self.__dot_lines[cursor].__contains__("ellipse") == True:
+                    final_states.append(state)
+                    has_final_states = True
+
+            cursor = cursor + 1
+
+        states = sorted(set(states))
+        states.remove(initial_state)
+
+        # Insert the initial state at the bein og the states
+        states.insert(0, initial_state)
+
+        if has_final_states == False:
+            final_states.append(initial_state)
+
+        return states, initial_state, final_states
+
+    def __get_event_variables(self):
+        # here we are at the begin of transitions, take a note, we will return later.
+        cursor = self.__get_cursor_begin_events()
+
+        events = []
+        while self.__dot_lines[cursor][1] == '"':
+            # transitions have the format:
+            # "all_fired" -> "both_fired" [ label = "disable_irq" ];
+            #  ------------ event is here ------------^^^^^
+            if self.__dot_lines[cursor].split()[1] == "->":
+                line = self.__dot_lines[cursor].split()
+                event = line[-2].replace('"','')
+
+                # when a transition has more than one lables, they are like this
+                # "local_irq_enable\nhw_local_irq_enable_n"
+                # so split them.
+
+                event = event.replace("\\n", " ")
+                for i in event.split():
+                    events.append(i)
+            cursor = cursor + 1
+
+        return sorted(set(events))
+
+    def __create_matrix(self):
+        # transform the array into a dictionary
+        events = self.events
+        states = self.states
+        events_dict = {}
+        states_dict = {}
+        nr_event = 0
+        for event in events:
+            events_dict[event] = nr_event
+            nr_event += 1
+
+        nr_state = 0
+        for state in states:
+            states_dict[state] = nr_state
+            nr_state = nr_state + 1
+
+        # declare the matrix....
+        matrix = [['-1' for x in range(nr_event)] for y in range(nr_state)]
+
+        # and we are back! Let's fill the matrix
+        cursor = self.__get_cursor_begin_events()
+
+        while self.__dot_lines[cursor][1] == '"':
+            if self.__dot_lines[cursor].split()[1] == "->":
+                line = self.__dot_lines[cursor].split()
+                origin_state = line[0].replace('"','').replace(',','_')
+                dest_state = line[2].replace('"','').replace(',','_')
+                possible_events = line[-2].replace('"','').replace("\\n", " ")
+                for event in possible_events.split():
+                    matrix[states_dict[origin_state]][events_dict[event]] = dest_state
+            cursor = cursor + 1
+
+        return matrix
diff --git a/tools/tracing/rv/dot2/dot2c b/tools/tracing/rv/dot2/dot2c
new file mode 100644
index 000000000000..0165f203dedc
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2c
@@ -0,0 +1,30 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# dot2m: transform dot files into C structures.
+# For more information, see:
+#   https://bristot.me/efficient-formal-verification-for-the-linux-kernel/
+#
+# This program was written in the development of this paper:
+#  de Oliveira, D. B. and Cucinotta, T. and de Oliveira, R. S.
+#  "Efficient Formal Verification for the Linux Kernel." International
+#  Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
+#
+# Copyright 2018-2020 Red Hat, Inc.
+#
+# Author:
+#  Daniel Bristot de Oliveira <bristot@kernel.org>
+
+if __name__ == '__main__':
+    from dot2 import dot2c
+    import argparse
+    import ntpath
+    import sys
+
+    parser = argparse.ArgumentParser(description='dot2c: converts a .dot file into a C structure')
+    parser.add_argument('dot_file',  help='The dot file to be converted')
+
+
+    args = parser.parse_args()
+    d=dot2c.Dot2c(args.dot_file)
+    d.print_model_classic()
diff --git a/tools/tracing/rv/dot2/dot2c.py b/tools/tracing/rv/dot2/dot2c.py
new file mode 100644
index 000000000000..0a68851437c8
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2c.py
@@ -0,0 +1,240 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# dot2c: transform dot files into C structures.
+# For more information, see:
+#   https://bristot.me/efficient-formal-verification-for-the-linux-kernel/
+#
+# This program was written in the development of this paper:
+#  de Oliveira, D. B. and Cucinotta, T. and de Oliveira, R. S.
+#  "Efficient Formal Verification for the Linux Kernel." International
+#  Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
+#
+# Copyright 2018-2020 Red Hat, Inc.
+#
+# Author:
+#  Daniel Bristot de Oliveira <bristot@kernel.org>
+
+from dot2.automata import Automata
+
+class Dot2c(Automata):
+    enum_states_def="states"
+    enum_events_def="events"
+    struct_automaton_def="automaton"
+    var_automaton_def="aut"
+
+    def __init__(self, file_path):
+        super().__init__(file_path)
+        self.line_length=80
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
+    def __get_enum_states_content(self):
+        buff=[]
+        buff.append("\t%s = 0," % self.initial_state)
+        for state in self.states:
+            if state != self.initial_state:
+                buff.append("\t%s," % state)
+        buff.append("\tstate_max")
+
+        return buff
+
+    def get_enum_states_string(self):
+        buff=self.__get_enum_states_content()
+        return self.__buff_to_string(buff)
+
+    def format_states_enum(self):
+        buff=[]
+        buff.append("enum %s {" % self.enum_states_def)
+        buff.append(self.get_enum_states_string())
+        buff.append("};\n")
+
+        return buff
+
+    def __get_enum_events_content(self):
+        buff=[]
+        first=True
+        for event in self.events:
+            if first:
+                buff.append("\t%s = 0," % event)
+                first=False
+            else:
+                buff.append("\t%s," % event)
+        buff.append("\tevent_max")
+
+        return buff
+
+    def get_enum_events_string(self):
+        buff=self.__get_enum_events_content()
+        return self.__buff_to_string(buff)
+
+    def format_events_enum(self):
+        buff=[]
+        buff.append("enum %s {" % self.enum_events_def)
+        buff.append(self.get_enum_events_string())
+        buff.append("};\n")
+
+        return buff
+
+    def get_minimun_type(self):
+        min_type="char"
+
+        if self.states.__len__() > 255:
+            min_type="short"
+
+        if self.states.__len__() > 65535:
+            min_type="int"
+
+        return min_type
+
+    def format_automaton_definition(self):
+        min_type = self.get_minimun_type()
+        buff=[]
+        buff.append("struct %s {" % self.struct_automaton_def)
+        buff.append("\tchar *state_names[state_max];")
+        buff.append("\tchar *event_names[event_max];")
+        buff.append("\t%s function[state_max][event_max];" % min_type)
+        buff.append("\t%s initial_state;" % min_type)
+        buff.append("\tchar final_states[state_max];")
+        buff.append("};\n")
+        return buff
+
+    def format_aut_init_header(self):
+        buff=[]
+        buff.append("struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
+        return buff
+
+    def __get_string_vector_per_line_content(self, buff):
+        first=True
+        string=""
+        for entry in buff:
+            if first:
+                string = string + "\t\t\"" + entry
+                first=False;
+            else:
+                string = string + "\",\n\t\t\"" + entry
+        string = string + "\""
+
+        return string
+
+    def get_aut_init_events_string(self):
+        return self.__get_string_vector_per_line_content(self.events)
+
+    def get_aut_init_states_string(self):
+        return self.__get_string_vector_per_line_content(self.states)
+
+    def format_aut_init_events_string(self):
+        buff=[]
+        buff.append("\t.event_names = {")
+        buff.append(self.get_aut_init_events_string())
+        buff.append("\t},")
+        return buff
+
+    def format_aut_init_states_string(self):
+        buff=[]
+        buff.append("\t.state_names = {")
+        buff.append(self.get_aut_init_states_string())
+        buff.append("\t},")
+
+        return buff
+
+    def __get_max_strlen_of_states(self):
+        return max(self.states, key=len).__len__()
+
+    def __get_state_string_length(self):
+        maxlen = self.__get_max_strlen_of_states()
+        return "%" + str(maxlen) + "s"
+
+    def get_aut_init_function(self):
+        nr_states=self.states.__len__()
+        nr_events=self.events.__len__()
+        buff=[]
+
+        strformat = self.__get_state_string_length()
+
+        for x in range(nr_states):
+            line="\t\t{ "
+            for y in range(nr_events):
+                if y != nr_events-1:
+                    line = line + strformat % self.function[x][y] + ", "
+                else:
+                    line = line + strformat % self.function[x][y] + " },"
+            buff.append(line)
+
+        return self.__buff_to_string(buff)
+
+    def format_aut_init_function(self):
+        buff=[]
+        buff.append("\t.function = {")
+        buff.append(self.get_aut_init_function())
+        buff.append("\t},")
+
+        return buff
+
+    def get_aut_init_initial_state(self):
+        return self.initial_state
+
+    def format_aut_init_initial_state(self):
+        buff=[]
+        initial_state=self.get_aut_init_initial_state()
+        buff.append("\t.initial_state = " + initial_state + ",")
+
+        return buff
+
+
+    def get_aut_init_final_states(self):
+        line=""
+        first=True
+        for state in self.states:
+            if first == False:
+                line = line + ', '
+            else:
+                first = False
+
+            if self.final_states.__contains__(state):
+                line = line + '1'
+            else:
+                line = line + '0'
+        return line
+
+    def format_aut_init_final_states(self):
+       buff=[]
+       buff.append("\t.final_states = { %s }," % self.get_aut_init_final_states())
+
+       return buff
+
+    def __get_automaton_initialization_footer_string(self):
+        footer="};"
+        return footer
+
+    def format_aut_init_footer(self):
+        buff=[]
+        buff.append(self.__get_automaton_initialization_footer_string())
+
+        return buff
+
+    def format_model(self):
+        buff=[]
+        buff += self.format_states_enum()
+        buff += self.format_events_enum()
+        buff += self.format_automaton_definition()
+        buff += self.format_aut_init_header()
+        buff += self.format_aut_init_states_string()
+        buff += self.format_aut_init_events_string()
+        buff += self.format_aut_init_function()
+        buff += self.format_aut_init_initial_state()
+        buff += self.format_aut_init_final_states()
+        buff += self.format_aut_init_footer()
+
+        return buff
+
+    def print_model_classic(self):
+        buff=self.format_model()
+        print(self.__buff_to_string(buff))
-- 
2.33.1

