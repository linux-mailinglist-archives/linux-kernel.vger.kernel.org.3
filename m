Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4371489B01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiAJOE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiAJOEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:04:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8870C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 06:04:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C4D2CCE1323
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80C3C36AE3;
        Mon, 10 Jan 2022 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641823460;
        bh=cAuJcBFuiHfs6d3simMY3JqxwAiiyjSRfj7MT/Po3Qo=;
        h=From:To:Cc:Subject:Date:From;
        b=TwwZMjLu79z95fSSbtuQg2SrQekN+W7dBfM7H6ZQxiY/2bdfnPiq8YFtTJJP40wYr
         GbAZlTDrDBNKqqHMbQUxUUdkIA2gRHvjfmZeWyz8tcXm1RyYZ8rQgCcPsOaBnvdk6A
         4POeIPNVIjzVzlWFWyrAR89d/w/YNgdEntrXL+7bHUKZDYgOnNbth3L/dE0mOM+Tvj
         cWcILDAbkC0XtPvyx8ir+Ro2iX25dUdIUOdrjkceuVi34lzP0QfTGpmWr6Th5QKkW3
         DcCD2wOujJPCSLtqeJWj3H9CghCcAVTVyt88ScYS3pIiUSyGV5YSilZ/9Dw12MERUL
         kvur5HdumHnYw==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/6] tracing: Add and use event_command parsing func helpers
Date:   Mon, 10 Jan 2022 08:04:10 -0600
Message-Id: <cover.1641823001.git.zanussi@kernel.org>
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

v7:
    Missed a fixup in patch 6/6 to a data->ops->print() in the debug
    code since I forgot to build with CONFIG_HIST_TRIGGERS_DEBUG.

    Patches 1-5 remain the same.

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

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/cleanup-hist-func-v7

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
 kernel/trace/trace_events_hist.c    | 147 +++----
 kernel/trace/trace_events_trigger.c | 626 +++++++++++++++++++---------
 4 files changed, 566 insertions(+), 318 deletions(-)

-- 
2.17.1

