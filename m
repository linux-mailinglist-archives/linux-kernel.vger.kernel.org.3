Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378D0573EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiGMVSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiGMVSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:18:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F217B1B7B6;
        Wed, 13 Jul 2022 14:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DBC461E8C;
        Wed, 13 Jul 2022 21:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A411AC341C8;
        Wed, 13 Jul 2022 21:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657747086;
        bh=aS4EDskgQfDDMMDFP9Ws+Tjgi2/V9W9w/FWX20Sp6gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtbewGX8/YXdhgfDbGZ9F8DdxtMEPwl4RCb4+TTyYOWtgmbm0NFkzdvdreT8wxXE1
         BItQ45q6xEx5Wm7soCuRK4R6HKgJ/HLOKmG7lCbF8YayAxilPMouo9WOXbb22DjvN1
         dQjMooylfQuMJyvjQNcYex4Zu79RQGmQJPtuy45JAAzOfW46ruXHqX+6pWfC0Pvwu/
         hdH2segWPja4uAiD62sTECm7Qn5LIPBYbE93gDQfFnKHZS8DcN392WNrc/hyFep1rb
         zmp+F7IkVKrNTz3WdblLn1zFSB+Jsa+0NxAX8PLtoa/q8cQeW4WEOOhJHSWQl4ebQw
         U82fRrMTdHlug==
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
Subject: [PATCH V5 03/16] rv/include: Add helper functions for deterministic automata
Date:   Wed, 13 Jul 2022 23:17:19 +0200
Message-Id: <0d8463406169956ad994ab7c8adc520a4f7eba66.1657745645.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657745645.git.bristot@kernel.org>
References: <cover.1657745645.git.bristot@kernel.org>
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

DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Romulo
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
index 000000000000..7125c91df607
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
+ * model_get_init_state_##name - return the automaton's initial state		\
+ */										\
+static inline type model_get_init_state_##name(void)				\
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

