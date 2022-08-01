Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EC85862A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbiHACcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbiHACcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A45D13CCF
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4F0F61210
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9932C433D7;
        Mon,  1 Aug 2022 02:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659321159;
        bh=ngzqObwtwIp2kbdKF1z/NesmrXUK7HAjk3wY6TqLDeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PolyEiYkekg3yuJn8tKEgRqOGxr2ij/b3czk8uAfmTSN0nhuEunx1nubZ980vdITt
         qtYwIFV4kMMmND+AC09ZuHnnEky/SdSceqOAf/e3xG1BpCSNbX14psSletYS/ruqqn
         Bt+CW8Gw+dFtw6D5JtNL551YEVabHXLOrfwYSugmW7xZ59BNaWQUwm87M/rGfMK5Ug
         Q4ynh9Dql5QCuu1I9VT+Ukpb8Rqi/ZVR7D/AicZ28fPGe3MAWiy8P6FKugQTtDzEfn
         E6dWDd9Jn4fn4t80pvSZP77soojTYYartt3q8gGAlcyExwBsUn8D6igKCaXURETSt5
         7b7jWAhmrPMsA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/3] selftests/ftrace: Add eprobe syntax error testcase
Date:   Mon,  1 Aug 2022 11:32:34 +0900
Message-Id: <165932115471.2850673.8014722990775242727.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <165932112555.2850673.7704483936633223533.stgit@devnote2>
References: <165932112555.2850673.7704483936633223533.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a syntax error test case for eprobe as same as kprobes.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../test.d/dynevent/eprobes_syntax_errors.tc       |   27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
new file mode 100644
index 000000000000..fc1daac7f066
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Event probe event parser error log check
+# requires: dynamic_events events/syscalls/sys_enter_openat "<attached-group>.<attached-event> [<args>]":README error_log
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'event_probe' "$1" 'dynamic_events'
+}
+
+check_error 'e ^a.'			# NO_EVENT_INFO
+check_error 'e ^.b'			# NO_EVENT_INFO
+check_error 'e ^a.b'			# BAD_ATTACH_EVENT
+check_error 'e syscalls/sys_enter_openat ^foo'	# BAD_ATTACH_ARG
+check_error 'e:^/bar syscalls/sys_enter_openat'	# NO_GROUP_NAME
+check_error 'e:^12345678901234567890123456789012345678901234567890123456789012345/bar syscalls/sys_enter_openat'	# GROUP_TOO_LONG
+
+check_error 'e:^foo.1/bar syscalls/sys_enter_openat'	# BAD_GROUP_NAME
+check_error 'e:^ syscalls/sys_enter_openat'		# NO_EVENT_NAME
+check_error 'e:foo/^12345678901234567890123456789012345678901234567890123456789012345 syscalls/sys_enter_openat'	# EVENT_TOO_LONG
+check_error 'e:foo/^bar.1 syscalls/sys_enter_openat'	# BAD_EVENT_NAME
+
+check_error 'e:foo/bar syscalls/sys_enter_openat arg=^dfd'	# BAD_FETCH_ARG
+check_error 'e:foo/bar syscalls/sys_enter_openat ^arg=$foo'	# BAD_ATTACH_ARG
+
+check_error 'e:foo/bar syscalls/sys_enter_openat if ^'	# NO_EP_FILTER
+
+exit 0

