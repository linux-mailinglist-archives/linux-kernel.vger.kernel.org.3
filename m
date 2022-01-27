Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A6149EDA2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242979AbiA0Vo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:44:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47308 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiA0Vo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:44:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C94E961B27
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA46C340E4;
        Thu, 27 Jan 2022 21:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643319867;
        bh=Nh2XASApFu2lsg6gBs46YYmvmtu1NJnkdfIELXZr024=;
        h=From:To:Cc:Subject:Date:From;
        b=gWMIY489v4nuJxbnV2lB/lCKDvP3L4HDIZNp6QOOPdD8XKBn28cX5hUXFF2ESSINQ
         hLgJIBANUAZucBE3fnoux/k9VW+fFAKWtM8icvOmRbdIg0Zf9P78DxmYD+GxwvilYM
         lu/wIe18RopCjfFFuJoJyl4gxNCPmbTUQuA1VC+/MGpW18LL5YPHM6whZz9doObZZR
         mmzJ4vzHLOq7DUfBNNtQv8ixriJDA36Ic2oHlaTBjMgG03//fs7Ik0iLYZHjJ3wzS3
         d8faHCHbGsa8OQXJg5brLhHT7j1JXxdNu2a1GwfCZsx6LGWZqnchHn6hBkrug345e7
         5o72M/O4LdIbw==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/7]  tracing: Misc bugfixes
Date:   Thu, 27 Jan 2022 15:44:14 -0600
Message-Id: <cover.1643319703.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

This is an assorted bunch of bugfixes addressing a bugzilla bug,
smatch warnings, and related things I found while fixing those.  In
particular, when looking at the bugzilla bug,
https://bugzilla.kernel.org/show_bug.cgi?id=215513, I noticed that the
err_log output looked truncated and looking further into it found that
it was, because the hist trigger command was very long, exceeding the
256 character limit.

Obviously that's too short, and the final 3 patches remove that
limitation.

Tom

The following changes since commit 4798f3784b1208138e06ab2de65666c19d51ab4d:

  tools/tracing: Update Makefile to build rtla (2022-01-27 11:47:17 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/misc-bugfixes-v1

Tom Zanussi (7):
  tracing: Fix smatch warning for null glob in
    event_hist_trigger_parse()
  tracing: Fix smatch warning for do while check in
    event_hist_trigger_parse()
  tracing: Propagate is_signed to expression
  tracing: Don't inc err_log entry count if entry allocation fails
  tracing: Remove size restriction on tracing_log_err cmd strings
  tracing: Remove size restriction on hist trigger cmd error logging
  tracing: Remove size restriction on synthetic event cmd error logging

 kernel/trace/trace.c              | 56 ++++++++++++++++++++++++-------
 kernel/trace/trace.h              |  2 +-
 kernel/trace/trace_events_hist.c  | 39 ++++++++++++++++-----
 kernel/trace/trace_events_synth.c | 17 ++++++++--
 4 files changed, 88 insertions(+), 26 deletions(-)

-- 
2.17.1

