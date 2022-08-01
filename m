Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C1358629C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiHACcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiHACcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:32:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D234DFF3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DDBC8CE10E9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA309C433D6;
        Mon,  1 Aug 2022 02:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659321130;
        bh=QTHV+Za2cVq7ZPArF6flWqV/SOEUw18WnPgUPGZY4uU=;
        h=From:To:Cc:Subject:Date:From;
        b=ZoBK4/nqv6V+VDIkP2rtBHOkpY2AjyI23jDhJJzNUUWIGSGwVaFwppS77DjtjLf9s
         uqhF4u0yvENOKbW3wU1Cv5VGXH9i+0xweY6sdKfBt2KEXUGa7kGfZPFWW0wBq1xwif
         umjK3bmzPYGjzePR+GwDuU4A4cvi06WO0dlsVzYieWcQVBuN4odlWm2gMLgBt5BuQ3
         IRvIPtMPWYLWrLAntJRTpvX7FM/wkYxXUlMNJElJfxmLjf6sTH0oNkDG5Yph9biYlj
         BYeWTov+igX1kZRLOLF2fFsdq9/SZRN8veDZ54Cg9Kkvr6cj9yYxxMOdCoE3tRQxHM
         lDV4WV+BPASeg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/3] ftrace: Event probe updates
Date:   Mon,  1 Aug 2022 11:32:05 +0900
Message-Id: <165932112555.2850673.7704483936633223533.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
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

This series adds some features/tests to event probe, which includes
- Add event probe syntax error logs on <tracefs>/error_log file.
- Add 'if' filter to the event probe.
- Add a syntax error test case for event probe.

'if' filter is a new feature, which allows us to define new event based on
the condition. There are some events which include both start and end
events by one event type. e.g. CPU idle (power/cpu_idle) event is called
at the CPU idle start with "state=C-state ID" and at the end with "state=(u32)-1".
In that case, it is useful if we can define 2 new event probes on it for
the start and the end besed on the state value. Or, we can classify events
based on running CPU, etc.

Thanks,

---

Masami Hiramatsu (Google) (3):
      tracing/eprobe: Show syntax error logs in error_log file
      tracing/eprobe: Add eprobe filter support
      selftests/ftrace: Add eprobe syntax error testcase


 kernel/trace/trace_eprobe.c                        |  115 ++++++++++++++++++--
 kernel/trace/trace_probe.h                         |    6 +
 .../test.d/dynevent/eprobes_syntax_errors.tc       |   27 +++++
 3 files changed, 137 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
