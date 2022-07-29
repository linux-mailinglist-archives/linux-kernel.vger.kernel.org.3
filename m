Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D5F584E30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiG2Jjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiG2JjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6734F674;
        Fri, 29 Jul 2022 02:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA17561D43;
        Fri, 29 Jul 2022 09:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4CEC43141;
        Fri, 29 Jul 2022 09:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659087562;
        bh=oWw25mtkJXkfmoetD7cNHKyHoDEVZWd1NhnSPh98QnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V35CUiW/D6XVNnoOIq+dlMbi3L8jwnrxMBCj1IXuAAwGXqW+lcm4cEZFTRUSyrasr
         uSX6FveXUo5kzghM3MbxBdhWaB8QULn3DIOBuEytU5VumYtH+sbRaGVZE+7WVvNMSp
         6bvu/b4+sK1MZFwbyjUoWZLqa97DChSZ1rdeSiIQv6qqROPfpx21E5+MrVB03U9/fQ
         XZyUoPi+EpYWI1dlLmRD0DXEqFUnp3MaB51od80MJs+c1/YwpNstcUZ3AAAbkrFiUm
         sDZkcXmhMbegMnbGVHPfZwRHJi2DtZVn8h2z0SmJ3780ViATpuV8RtNOuwW0C7InRU
         AndFiN46Z9Kkg==
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
Subject: [PATCH V9 03/16] rv/include: Add helper functions for deterministic automata
Date:   Fri, 29 Jul 2022 11:38:42 +0200
Message-Id: <563234f2bfa84b540f60cf9e39c2d9f0eea95a55.1659052063.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659052063.git.bristot@kernel.org>
References: <cover.1659052063.git.bristot@kernel.org>
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

