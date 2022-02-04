Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DB54AA2E9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346909AbiBDWMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346367AbiBDWMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:12:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090BBC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 14:12:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2984B83939
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 22:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289A0C004E1;
        Fri,  4 Feb 2022 22:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644012733;
        bh=PBWzZJnL+htlQc5BKH8fEYaxKnXTesqM7XBBdTBM2/I=;
        h=From:To:Cc:Subject:Date:From;
        b=iSSTiFVRmnVOGROnGRiXtFjeSai0yuGN9GeGO7KdDAGM19U4AMz/Tnxgoj05SUwqr
         L2ZAGFy7uARKfaO3zBRWyhxCVdT4gGIFMmhhpKQ+ZVoEQhU/AStq9VyCZvsDCtSHhD
         fY17M7u53ECmyP/mTf0owfQTBLqpLpfPCqH8W98jHkSdz4Y3bH2f+p5UueYke6ZBxk
         yoBCLhrPljVKatGR7HVzpfARG3MIQzTHWwBMFDUFQnoIuH7iMeHvPCtyUvyrC5X3ZT
         +/1zdmtevKJfOkNtAZjLq7hMrATnhRtoQeIoY2kPdHVgGMh8c8fUGS90JGLWFJk2YP
         XvOs1XG2vFW7A==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/4] tracing: Add and use event_command parsing func helpers
Date:   Fri,  4 Feb 2022 16:12:03 -0600
Message-Id: <cover.1644010575.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_50,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

v8: Patches 1-4 of v7 were merged and so don't appear here.

    Added new patch 'tracing: Remove logic for registering multiple
    event triggers at a time' because the code doesn't ever register
    multiple triggers and it just complicates the code.  Doing this
    also removes the unreg() call along with just about everything
    else from event_trigger_register() so is no longer a policy
    violation.  Also added a new function event_trigger_unregister()
    to match event_trigger_register() and clean up the code even more.

    Moved 'tracing: Remove redundant trigger_ops params' so it doesn't
    depend on the following patches.

    Added 'tracing: Separate hist state updates from hist
    registration' to remove the confusing logic concerning
    pause/cont/clear and which caused problems in v7.

v7: Missed a fixup in patch 6/6 to a data->ops->print() in the debug
    code since I forgot to build with CONFIG_HIST_TRIGGERS_DEBUG.

    Patches 1-5 remain the same.

v6: Fixed warning for an uninitialized trigger_ops local in
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


The following changes since commit f125ef075cd648a7794aa0cc61a188b1c40c8f94:

  tracing: Remove size restriction on synthetic event cmd error logging (2022-01-27 19:15:51 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/cleanup-hist-func-v8

Tom Zanussi (4):
  tracing: Remove logic for registering multiple event triggers at a
    time
  tracing: Remove redundant trigger_ops params
  tracing: Have existing event_command.parse() implementations use
    helpers
  tracing: Separate hist state updates from hist registration

 kernel/trace/trace.h                |  26 ++-
 kernel/trace/trace_eprobe.c         |  10 +-
 kernel/trace/trace_events_hist.c    | 166 ++++++++--------
 kernel/trace/trace_events_trigger.c | 292 +++++++++-------------------
 4 files changed, 193 insertions(+), 301 deletions(-)

-- 
2.17.1

