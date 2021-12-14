Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693DB474B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbhLNS5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:57:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59674 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhLNS5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:57:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 927136168F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 18:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B941C34600;
        Tue, 14 Dec 2021 18:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639508259;
        bh=+5H7tmXm5JL0z/Eb5YMmyedVcM3AXcxgFfl4LimxwK8=;
        h=From:To:Cc:Subject:Date:From;
        b=aySmg66q3zSt64rqtVqQIyxpG+v2Zbf7TAac4F7a2H4QBTcdSXeDhhjqxu5xlOieQ
         44uWaN2hEnMk/s5+MP+Lt+lJAvpoZKsJBpxHLNSAyynrKhwz9Zg2KTJyBh6jfJvbVt
         sDiHdzHtYxr+0CGL/QSAZz4W2sCRD8wVwLuTSuVGzzVQhiI5BiAhIr3md8OFwT6N40
         VoQlLASXhkeGIy3GeymzirxE2wEJcVXQBcP9YI1T4EFIZH0HiuC1zd1oqOr33U36kl
         AqddkzuilQcokrrm4J8YToWdvr3cKEM3FW2TpQ6Lk1UKyqWFzd7VGvkK3vzAFwBv+5
         hsDhyBK2ZYscw==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] tracing: Add and use event_command parsing func helpers
Date:   Tue, 14 Dec 2021 12:57:28 -0600
Message-Id: <cover.1639507505.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With more event commands being implemented, it's been pointed out that
it would make sense to clean up the existing ones and make it easier
to implement new ones without copying a lot of boilerplate.  The main
culprit here is the event_command.func() callback - the rest of the
event_command infrastructure has default implementations that work for
most implementations.  The func() callback is a little different in
that every new command needs to customize parsing to some extent.

This patchset attempts to help clean that up and make it easier for
new users to deal with.

v5: Changed the parsing helper function example components param and
    filter to reflect only the param and filter components, and added
    param_and_filter which now appears in the functions.

    Removed the check for a NULL *param following the strsep
    separating the param from the filter in
    event_trigger_separate_filter() because it will never be true due
    to the previous check for NULL param_and_filter previously.

    Changed the param name from trigger to param and updated the
    function documentation in event_trigger_parse_num().

v4: Added two patches changing the names of event_command.func() and
    event_trigger_ops.func() to make them reflect their functions.

    Added back missing kfree(trigger_data) in event_trigger_callback().

    Changed char *param to const char *param in
    event_trigger_check_remove() and event_trigger_empty_param().

    Changed event_trigger_separate_filter() to use separate param and
    filter outparams, and changed the name of the param inparam to
    param_and_filter to better reflect its contents and avoid the
    clash with new param outparam.  Changed all parse()
    implementations to use this new scheme.

    Fixed some typos and added more extensive comments with examples
    explaining various things that were mentioned as causing confusion
    and just in general tried to clarify things with respect to the
    callbacks and parameters.

v3: broke up event_trigger_check() into smaller functions instead of
    parameterizing it, and added function documentation.

v2: removed unused event_trigger_remove(). No change in functionality.

The following changes since commit a6ed2aee54644cfa2d04ca86308767f5c3a087e8:

  tracing: Switch to kvfree_rcu() API (2021-12-06 17:53:50 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/cleanup-hist-func-v5

Tom Zanussi (4):
  tracing: Change event_command func() to parse()
  tracing: Change event_trigger_ops func() to trigger()
  tracing: Add helper functions to simplify event_command.parse()
    callback handling
  tracing: Have existing event_command.parse() implementations use
    helpers

 kernel/trace/trace.h                |  63 +++-
 kernel/trace/trace_eprobe.c         |  11 +-
 kernel/trace/trace_events_hist.c    | 109 +++---
 kernel/trace/trace_events_trigger.c | 564 ++++++++++++++++++++--------
 4 files changed, 519 insertions(+), 228 deletions(-)

-- 
2.17.1

