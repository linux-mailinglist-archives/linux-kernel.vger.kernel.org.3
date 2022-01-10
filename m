Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6586C488D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 01:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiAJAEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 19:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbiAJAET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 19:04:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F22FC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 16:04:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AAC260FD9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAF0C36AE3;
        Mon, 10 Jan 2022 00:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641773056;
        bh=58LDqfXkxF6/L/AdUWOUj9Y/5z6CxQ2olP2VZ704bRE=;
        h=From:To:Cc:Subject:Date:From;
        b=K7sbpY01nmlymY9+aw5kZ6L9Ef+cQLw9BwDT0Uyus5rJekgYRkeof7FxeIL2q2dGe
         PkNk9V3ooH/84wxerY+dCXl8hn+Lpv+5v+y3sfc2PxhNjH0Tvkiu2cSsldz4/9QmRA
         KoHzAP7cdydkXzej38yEay92dhyS+yFVFo1RQov0J+BcGoB8b1fp3xjdvZc9YT4nuJ
         Irx+NhYYv2t7O0fYwBV6UuuQHUFpdQUXOH6PuI6f0P7iuWNN1V0F7w+7aZ9sB7y/Bg
         GZwWESgXPG35yOoFzD+t3x51Z6VySL3ujcjnYUmbZXM/tMNripzmBGNOzowP0/5LZ2
         eDfBmD131p17w==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/6] tracing: Add and use event_command parsing func helpers
Date:   Sun,  9 Jan 2022 18:04:04 -0600
Message-Id: <cover.1641772259.git.zanussi@kernel.org>
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

v6:

    Fixed warning for an uninitialized trigger_ops local in
    event_trigger_parse() pointed out by Steve and the kernel test
    robot. This was done by removing the need for the local by
    removing the redundant trigger_ops params in [PATCH v6 3/6]
    tracing: Remove ops param from event_command reg()/unreg()
    callbacks.

    Also added a follow-on patch to remove all the other instances of
    redundant trigger_ops in [PATCH v6 6/6] tracing: Remove redundant
    trigger_ops params

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

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/cleanup-hist-func-v6

Tom Zanussi (6):
  tracing: Change event_command func() to parse()
  tracing: Change event_trigger_ops func() to trigger()
  tracing: Remove ops param from event_command reg()/unreg() callbacks
  tracing: Add helper functions to simplify event_command.parse()
    callback handling
  tracing: Have existing event_command.parse() implementations use
    helpers
  tracing: Remove redundant trigger_ops params

 kernel/trace/trace.h                |  81 ++--
 kernel/trace/trace_eprobe.c         |  30 +-
 kernel/trace/trace_events_hist.c    | 145 +++----
 kernel/trace/trace_events_trigger.c | 626 +++++++++++++++++++---------
 4 files changed, 565 insertions(+), 317 deletions(-)

-- 
2.17.1

