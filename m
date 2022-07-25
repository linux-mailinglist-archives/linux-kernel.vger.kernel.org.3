Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41B8580527
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiGYUMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiGYUMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9970B21E37;
        Mon, 25 Jul 2022 13:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1584C61157;
        Mon, 25 Jul 2022 20:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE3EC341D6;
        Mon, 25 Jul 2022 20:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658779945;
        bh=aTFFUhV/ovGh1pL4592w1TWqGPvo+d89bBF6ifbVuJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+1BwRuraYIGL8codf3jqfFfV1CUrBEVsp+rZx5uPpR2N82ScrEGCyT2JF8jDENk9
         fg3bdR3T0O7lrgBPrA+nz47T9xvflwfg+JWUjDm/q8WL0y40NX/daRB+lM0jwiJzbx
         kQNQO91un+Il5LKqSbzfycGqWFRiVfSQj+TDohljqEBAWL90/C0rcPKsEljmZjIgQd
         ZuCGDh2LxCX0kqfpuBEjbO2DfN98L0nPiA24qt2piL+DYqf1X4Enfu1rgM9L7HBcsV
         TekBgz6HOhJ9b4PlwclCYdzL8cz14/Bf3MnYf6S6d0N/vKu5127sTr+ug6l0QLMYOy
         YSt2R58svqZUw==
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
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V7 07/16] tools/rv: Add dot2c
Date:   Mon, 25 Jul 2022 22:11:19 +0200
Message-Id: <79a272c75f8048fdd1ded5ee2efedc0f49f5dff4.1658778484.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1658778484.git.bristot@kernel.org>
References: <cover.1658778484.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Tao Zhou <tao.zhou@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/verification/dot2/Makefile    |  21 +++
 tools/verification/dot2/automata.py | 171 +++++++++++++++++++
 tools/verification/dot2/dot2c       |  23 +++
 tools/verification/dot2/dot2c.py    | 251 ++++++++++++++++++++++++++++
 4 files changed, 466 insertions(+)
 create mode 100644 tools/verification/dot2/Makefile
 create mode 100644 tools/verification/dot2/automata.py
 create mode 100644 tools/verification/dot2/dot2c
 create mode 100644 tools/verification/dot2/dot2c.py

diff --git a/tools/verification/dot2/Makefile b/tools/verification/dot2/Makefile
new file mode 100644
index 000000000000..235d182f6b2c
--- /dev/null
+++ b/tools/verification/dot2/Makefile
@@ -0,0 +1,21 @@
+INSTALL=install
+
+prefix  ?= /usr
+bindir  ?= $(prefix)/bin
+mandir  ?= $(prefix)/share/man
+miscdir ?= $(prefix)/share/dot2
+srcdir  ?= $(prefix)/src
+
+PYLIB  ?= $(shell python3 -c 'import sysconfig;  print (sysconfig.get_path("purelib"))')
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
diff --git a/tools/verification/dot2/automata.py b/tools/verification/dot2/automata.py
new file mode 100644
index 000000000000..f22e1dff19ce
--- /dev/null
+++ b/tools/verification/dot2/automata.py
@@ -0,0 +1,171 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
+#
+# Automata object: parse an automata in dot file digraph format into a python object
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
+    invalid_state_str = "INVALID_STATE"
+
+    def __init__(self, file_path):
+        self.__dot_path = file_path
+        self.name = self.__get_model_name()
+        self.__dot_lines = self.__open_dot()
+        self.states, self.initial_state, self.final_states = self.__get_state_variables()
+        self.events = self.__get_event_variables()
+        self.function = self.__create_matrix()
+
+    def __get_model_name(self):
+        basename = ntpath.basename(self.__dot_path)
+        if basename.endswith(".dot") == False:
+            print("not a dot file")
+            raise Exception("not a dot file: %s" % self.__dot_path)
+
+        model_name = basename[0:-4]
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
+            cursor += 1
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
+           cursor += 1
+        # skip initial state transition
+        cursor += 1
+        return cursor
+
+    def __get_state_variables(self):
+        # wait for node declaration
+        states = []
+        final_states = []
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
+            cursor += 1
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
+            cursor += 1
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
+            nr_state += 1
+
+        # declare the matrix....
+        matrix = [[ self.invalid_state_str for x in range(nr_event)] for y in range(nr_state)]
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
+            cursor += 1
+
+        return matrix
diff --git a/tools/verification/dot2/dot2c b/tools/verification/dot2/dot2c
new file mode 100644
index 000000000000..8a8cd84bdfcf
--- /dev/null
+++ b/tools/verification/dot2/dot2c
@@ -0,0 +1,23 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
+#
+# dot2c: parse an automata in dot file digraph format into a C
+#
+# This program was written in the development of this paper:
+#  de Oliveira, D. B. and Cucinotta, T. and de Oliveira, R. S.
+#  "Efficient Formal Verification for the Linux Kernel." International
+#  Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
+
+if __name__ == '__main__':
+    from dot2 import dot2c
+    import argparse
+    import sys
+
+    parser = argparse.ArgumentParser(description='dot2c: converts a .dot file into a C structure')
+    parser.add_argument('dot_file',  help='The dot file to be converted')
+
+    args = parser.parse_args()
+    d = dot2c.Dot2c(args.dot_file)
+    d.print_model_classic()
diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/dot2/dot2c.py
new file mode 100644
index 000000000000..bca902eec483
--- /dev/null
+++ b/tools/verification/dot2/dot2c.py
@@ -0,0 +1,251 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
+#
+# dot2c: parse an automata in dot file digraph format into a C
+#
+# This program was written in the development of this paper:
+#  de Oliveira, D. B. and Cucinotta, T. and de Oliveira, R. S.
+#  "Efficient Formal Verification for the Linux Kernel." International
+#  Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
+
+from dot2.automata import Automata
+
+class Dot2c(Automata):
+    enum_suffix = ""
+    enum_states_def = "states"
+    enum_events_def = "events"
+    struct_automaton_def = "automaton"
+    var_automaton_def = "aut"
+
+    def __init__(self, file_path):
+        super().__init__(file_path)
+        self.line_length = 100
+
+    def __buff_to_string(self, buff):
+        string = ""
+
+        for line in buff:
+            string = string + line + "\n"
+
+        # cut off the last \n
+        return string[:-1]
+
+    def __get_enum_states_content(self):
+        buff = []
+        buff.append("\t%s%s = 0," % (self.initial_state, self.enum_suffix))
+        for state in self.states:
+            if state != self.initial_state:
+                buff.append("\t%s%s," % (state, self.enum_suffix))
+        buff.append("\tstate_max%s" % (self.enum_suffix))
+
+        return buff
+
+    def get_enum_states_string(self):
+        buff = self.__get_enum_states_content()
+        return self.__buff_to_string(buff)
+
+    def format_states_enum(self):
+        buff = []
+        buff.append("enum %s {" % self.enum_states_def)
+        buff.append(self.get_enum_states_string())
+        buff.append("};\n")
+
+        return buff
+
+    def __get_enum_events_content(self):
+        buff = []
+        first = True
+        for event in self.events:
+            if first:
+                buff.append("\t%s%s = 0," % (event, self.enum_suffix))
+                first = False
+            else:
+                buff.append("\t%s%s," % (event, self.enum_suffix))
+
+        buff.append("\tevent_max%s" % self.enum_suffix)
+
+        return buff
+
+    def get_enum_events_string(self):
+        buff = self.__get_enum_events_content()
+        return self.__buff_to_string(buff)
+
+    def format_events_enum(self):
+        buff = []
+        buff.append("enum %s {" % self.enum_events_def)
+        buff.append(self.get_enum_events_string())
+        buff.append("};\n")
+
+        return buff
+
+    def get_minimun_type(self):
+        min_type = "unsigned char"
+
+        if self.states.__len__() > 255:
+            min_type = "unsigned short"
+
+        if self.states.__len__() > 65535:
+            min_type = "unsigned int"
+
+        if self.states.__len__() > 1000000:
+            raise Exception("Too many states: %d" % self.states.__len__())
+
+        return min_type
+
+    def format_automaton_definition(self):
+        min_type = self.get_minimun_type()
+        buff = []
+        buff.append("struct %s {" % self.struct_automaton_def)
+        buff.append("\tchar *state_names[state_max%s];" % (self.enum_suffix))
+        buff.append("\tchar *event_names[event_max%s];" % (self.enum_suffix))
+        buff.append("\t%s function[state_max%s][event_max%s];" % (min_type, self.enum_suffix, self.enum_suffix))
+        buff.append("\t%s initial_state;" % min_type)
+        buff.append("\tbool final_states[state_max%s];" % (self.enum_suffix))
+        buff.append("};\n")
+        return buff
+
+    def format_aut_init_header(self):
+        buff = []
+        buff.append("struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
+        return buff
+
+    def __get_string_vector_per_line_content(self, buff):
+        first = True
+        string = ""
+        for entry in buff:
+            if first:
+                string = string + "\t\t\"" + entry
+                first = False;
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
+        buff = []
+        buff.append("\t.event_names = {")
+        buff.append(self.get_aut_init_events_string())
+        buff.append("\t},")
+        return buff
+
+    def format_aut_init_states_string(self):
+        buff = []
+        buff.append("\t.state_names = {")
+        buff.append(self.get_aut_init_states_string())
+        buff.append("\t},")
+
+        return buff
+
+    def __get_max_strlen_of_states(self):
+        max_state_name = max(self.states, key = len).__len__()
+        return max(max_state_name, self.invalid_state_str.__len__())
+
+    def __get_state_string_length(self):
+        maxlen = self.__get_max_strlen_of_states() + self.enum_suffix.__len__()
+        return "%" + str(maxlen) + "s"
+
+    def get_aut_init_function(self):
+        nr_states = self.states.__len__()
+        nr_events = self.events.__len__()
+        buff = []
+
+        strformat = self.__get_state_string_length()
+
+        for x in range(nr_states):
+            line = "\t\t{ "
+            for y in range(nr_events):
+                next_state = self.function[x][y]
+                if next_state != self.invalid_state_str:
+                    next_state = self.function[x][y] + self.enum_suffix
+
+                if y != nr_events-1:
+                    line = line + strformat % next_state + ", "
+                else:
+                    line = line + strformat % next_state + " },"
+            buff.append(line)
+
+        return self.__buff_to_string(buff)
+
+    def format_aut_init_function(self):
+        buff = []
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
+        buff = []
+        initial_state = self.get_aut_init_initial_state()
+        buff.append("\t.initial_state = " + initial_state + self.enum_suffix + ",")
+
+        return buff
+
+    def get_aut_init_final_states(self):
+        line = ""
+        first = True
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
+       buff = []
+       buff.append("\t.final_states = { %s }," % self.get_aut_init_final_states())
+
+       return buff
+
+    def __get_automaton_initialization_footer_string(self):
+        footer = "};\n"
+        return footer
+
+    def format_aut_init_footer(self):
+        buff = []
+        buff.append(self.__get_automaton_initialization_footer_string())
+
+        return buff
+
+    def format_invalid_state(self):
+        buff = []
+        buff.append("#define %s state_max%s\n" % (self.invalid_state_str, self.enum_suffix))
+
+        return buff
+
+    def format_model(self):
+        buff = []
+        buff += self.format_states_enum()
+        buff += self.format_invalid_state()
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
+        buff = self.format_model()
+        print(self.__buff_to_string(buff))
-- 
2.35.1

