Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556C1470C57
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbhLJVUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:20:09 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57200 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhLJVUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:20:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8D4FCCE2D3F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 21:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CB8C00446;
        Fri, 10 Dec 2021 21:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639170989;
        bh=DOtG6TPvUgWsavv5ESG/olkb5/LNjUM7lSIanjKa+sI=;
        h=From:To:Cc:Subject:Date:From;
        b=RRxvjK7kAjP7zhgCkrmxiyUPPw5wm9FyKt0/uhH9nWgfC3qbW9N07HaAU/ottDTug
         w6P3ggreCdlfK+BVAEM/J5h10xGz1PEWhk/+mHe1D2F8gUljfoPStq14t/qUM/JwTb
         eddUig8FmQTMdc4c4JtXyTzFbDW3adh7sZe/OZcnaA4njwajkO4lVlEKHTlzlh6du6
         BPZFGOnxqaK304tv0U2nGEokzO8X9itFHg4mVfHzemrQRvUpqqkeC7yWAzXVVWzJvV
         wntzHDJgwY6h7ZVcCZsfB6RFQwyPWVpEn6a8lDgQEtNutbZ834lHdMWGM3pyseMr/N
         ZUaJA8sHSGPpg==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] tracing: Add and use event_command parsing func helpers
Date:   Fri, 10 Dec 2021 15:16:21 -0600
Message-Id: <cover.1639170140.git.zanussi@kernel.org>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/cleanup-hist-func-v4

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
 kernel/trace/trace_events_trigger.c | 558 ++++++++++++++++++++--------
 4 files changed, 515 insertions(+), 226 deletions(-)

-- 
2.17.1

