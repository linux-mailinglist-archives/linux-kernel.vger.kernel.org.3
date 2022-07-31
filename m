Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9E45860A3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 21:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbiGaTF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 15:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbiGaTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 15:04:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2B510563;
        Sun, 31 Jul 2022 12:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 840F9B80DD4;
        Sun, 31 Jul 2022 19:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F5AC4314C;
        Sun, 31 Jul 2022 19:04:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oIEEr-007G5U-0d;
        Sun, 31 Jul 2022 15:04:33 -0400
Message-ID: <20220731190433.031964424@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 31 Jul 2022 15:03:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-doc@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 07/21] rv/include: Add helper functions for deterministic automata
References: <20220731190329.641602282@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Formally, a deterministic automaton, denoted by G, is defined as a
quintuple:

  G = { X, E, f, x_0, X_m }

where:
	- X is the set of states;
	- E is the finite set of events;
	- x_0 is the initial state;
	- X_m (subset of X) is the set of marked states.
	- f : X x E -> X $ is the transition function. It defines the
	  state transition in the occurrence of a event from E in
	  the state X. In the special case of deterministic automata,
	  the occurrence of the event in E in a state in X has a
	  deterministic next state from X.

An automaton can also be represented using a graphical format of
vertices (nodes) and edges. The open-source tool Graphviz can produce
this graphic format using the (textual) DOT language as the source code.

The dot2c tool presented in this paper:

De Oliveira, Daniel Bristot; Cucinotta, Tommaso; De Oliveira, Romulo
Silva. Efficient formal verification for the Linux kernel. In:
International Conference on Software Engineering and Formal Methods.
Springer, Cham, 2019. p. 315-332.

Translates a deterministic automaton in the DOT format into a C
source code representation that to be used for monitoring.

This header file implements helper functions to facilitate the usage
of the C output from dot2c/k for monitoring.

Link: https://lkml.kernel.org/r/563234f2bfa84b540f60cf9e39c2d9f0eea95a55.1659052063.git.bristot@kernel.org

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Corbet <corbet@lwn.net>
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
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/rv/automata.h | 75 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 include/rv/automata.h

diff --git a/include/rv/automata.h b/include/rv/automata.h
new file mode 100644
index 000000000000..eb9e636809a0
--- /dev/null
+++ b/include/rv/automata.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira  <bristot@kernel.org>
+ *
+ * Deterministic automata helper functions, to be used with the automata
+ * models in C generated by the dot2k tool.
+ */
+
+/*
+ * DECLARE_AUTOMATA_HELPERS - define a set of helper functions for automata
+ *
+ * Define a set of helper functions for automata. The 'name' argument is used
+ * as suffix for the functions and data. These functions will handle automaton
+ * with data type 'type'.
+ */
+#define DECLARE_AUTOMATA_HELPERS(name, type)					\
+										\
+/*										\
+ * model_get_state_name_##name - return the (string) name of the given state	\
+ */ 										\
+static char *model_get_state_name_##name(enum states_##name state)		\
+{										\
+	if ((state < 0) || (state >= state_max_##name))				\
+		return "INVALID";						\
+										\
+	return automaton_##name.state_names[state];				\
+}										\
+										\
+/*										\
+ * model_get_event_name_##name - return the (string) name of the given event	\
+ */										\
+static char *model_get_event_name_##name(enum events_##name event)		\
+{										\
+	if ((event < 0) || (event >= event_max_##name))				\
+		return "INVALID";						\
+										\
+	return automaton_##name.event_names[event];				\
+}										\
+										\
+/*										\
+ * model_get_initial_state_##name - return the automaton's initial state		\
+ */										\
+static inline type model_get_initial_state_##name(void)				\
+{										\
+	return automaton_##name.initial_state;					\
+}										\
+										\
+/*										\
+ * model_get_next_state_##name - process an automaton event occurrence		\
+ *										\
+ * Given the current state (curr_state) and the event (event), returns		\
+ * the next state, or INVALID_STATE in case of error.				\
+ */										\
+static inline type model_get_next_state_##name(enum states_##name curr_state,	\
+					       enum events_##name event)	\
+{										\
+	if ((curr_state < 0) || (curr_state >= state_max_##name))		\
+		return INVALID_STATE;						\
+										\
+	if ((event < 0) || (event >= event_max_##name))				\
+		return INVALID_STATE;						\
+										\
+	return automaton_##name.function[curr_state][event];			\
+}										\
+										\
+/*										\
+ * model_is_final_state_##name - check if the given state is a final state	\
+ */										\
+static inline bool model_is_final_state_##name(enum states_##name state)	\
+{										\
+	if ((state < 0) || (state >= state_max_##name))				\
+		return 0;							\
+										\
+	return automaton_##name.final_states[state];				\
+}
-- 
2.35.1
